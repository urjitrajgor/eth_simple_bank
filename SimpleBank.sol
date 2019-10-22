pragma solidity ^0.5.8;

contract SimpleBank{
    
    address public owner;
    uint8 private clientCount;
    mapping(address => uint256) balance;
    
    constructor() public payable {
        owner = msg.sender;
        clientCount = 0;
        require(msg.value == 30 ether, "30 ether initial funcding required");
    }
    
    function enroll() noOwner public returns(uint) {
        if(clientCount < 3){
            clientCount++;
            balance[msg.sender] = 10 ether;
        }
        return balance[msg.sender];
    }
    
    modifier noOwner(){
        require(msg.sender != owner, "Owner can not enroll");
        _;
    }
    
    function getClients() public view returns(uint){
        return clientCount;
    }
    
    function deposite() public payable returns(uint){
        balance[msg.sender]+= msg.value;
        return balance[msg.sender];
    }
    
    function withdraw(uint _withdrawAmount) public payable returns (uint){
        if(_withdrawAmount <= balance[msg.sender]){
            balance[msg.sender]-= _withdrawAmount;
            msg.sender.transfer(_withdrawAmount);
        }
        return balance[msg.sender];
    }
    
    function balances() public view returns (uint){
        return balance[msg.sender];
    } 
    
    function depositeBalance() public view returns(uint){
        return address(this).balance;
    }
    
    
}