// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ETHBBSEPriceFeedOracle is Ownable {
  // Max number of blocks before a price update is required
  uint8 public constant MAX_PRICE_AGE = 3;

  // ETH/BBSE rate
  uint private rate;

  // Block number of the last rate update.
  uint public lastUpdateBlock;

  // An event that indicates that the price of the priceFeed should be updated
  // Must be listened by the oracle server
  event GetNewRate (string priceFeed);
  
  /**
  * @dev Initializes lastUpdateBlock to current block number and rate to 0.
  * Emits GetNewRate to trigger the oracle server to update the rate.
  * The priceFeed parameter of GetNewRate should be ETH/BBSE
  */
  constructor () { 
    // TODO: Complete the constructor
    lastUpdateBlock = block.number;
    rate = 0;
    emit GetNewRate("ETH/BBSE");
  }

  /**
  * @dev Updates the rate and sets the lastUpdateBlock to current block number.
  * Can only be called by the owner of the oracle contract.
  * Can't be called internally.
  * @param _rate new rate of the price feed.
  */
  // TODO: Implement the updateRate function (use the respective function modifier from Ownable)

  function updateRate(uint _rate) onlyOwner public{
    rate = _rate;
    lastUpdateBlock = block.number;
  }

 /**
  * @dev Returns the current rate.
  * If rate was updated more than MAX_PRICE_AGE blocks ago,
  * emits GetNewRate event to trigger the oracle server.
  */
  // TODO: Implement the getRate function
  function getRate() public returns (uint) {
    if (block.number - lastUpdateBlock > MAX_PRICE_AGE){
      emit GetNewRate("ETH/BBSE");
    }
    return rate;
  }
}