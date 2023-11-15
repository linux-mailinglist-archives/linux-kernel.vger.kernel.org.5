Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C17ED0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjKOT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343898AbjKOT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:58:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85EC2;
        Wed, 15 Nov 2023 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700078303; x=1731614303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyzrHGjQw2aoiAimp6drxsmKrMLf4ZbFv0gRpykk8KI=;
  b=cDj83SD98t9WpOG+B3tHhqwmEYHxGv+NzSmENAHyvOxv58dJCSSjmjjs
   cG74UIWzetY600pAEcb2+e4vdMxGH6NTUACaRAM64X8+nZz+gNIT/RPaK
   ks6MD2yvez4/Z3jooEctsAT7ahywTsAK7iLOkXjUW9NJuPB63Zk8dB1xh
   r+5VrMqi51ZWo2XNnz8o4ySj3mk0SUgr1AhAHN8EC9raljl3zHa/KBERK
   mDStSfEEwX1w5pIewS6AoYUkjZO7gpcq0i0Y4bAQvNmWOtNYc2/PEqKyD
   oC0GqCxY03HZXou2C6Fl1JjmGxuiJg1hOCaarEcXQbTwpqmweiL7QG2BJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370294325"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="370294325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096542631"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="1096542631"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2023 11:58:19 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3M1h-0000m3-03;
        Wed, 15 Nov 2023 19:58:17 +0000
Date:   Thu, 16 Nov 2023 03:58:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v11 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202311160332.4oEPIsQA-lkp@intel.com>
References: <20231115133414.1221480-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115133414.1221480-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20231115-213811
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231115133414.1221480-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v11 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231116/202311160332.4oEPIsQA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160332.4oEPIsQA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160332.4oEPIsQA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_dump_state':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1586:44: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
    1586 |         netdev_err(dev, "Tx phyAddr = 0x%llx\n", ring->phy_addr);
         |                                         ~~~^     ~~~~~~~~~~~~~~
         |                                            |         |
         |                                            |         dma_addr_t {aka unsigned int}
         |                                            long long unsigned int
         |                                         %x
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1592:44: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
    1592 |         netdev_err(dev, "Rx phyAddr = 0x%llx\n", ring->phy_addr);
         |                                         ~~~^     ~~~~~~~~~~~~~~
         |                                            |         |
         |                                            |         dma_addr_t {aka unsigned int}
         |                                            long long unsigned int
         |                                         %x


vim +1586 drivers/net/ethernet/realtek/rtase/rtase_main.c

ee13d5d822aea2 Justin Lai 2023-11-15  1572  
ee13d5d822aea2 Justin Lai 2023-11-15  1573  static void rtase_dump_state(const struct net_device *dev)
ee13d5d822aea2 Justin Lai 2023-11-15  1574  {
ee13d5d822aea2 Justin Lai 2023-11-15  1575  	const struct rtase_private *tp = netdev_priv(dev);
ee13d5d822aea2 Justin Lai 2023-11-15  1576  	const struct rtase_counters *counters;
ee13d5d822aea2 Justin Lai 2023-11-15  1577  	int max_reg_size = RTASE_PCI_REGS_SIZE;
ee13d5d822aea2 Justin Lai 2023-11-15  1578  	const struct rtase_ring *ring;
ee13d5d822aea2 Justin Lai 2023-11-15  1579  	u32 dword_rd;
ee13d5d822aea2 Justin Lai 2023-11-15  1580  	int n = 0;
ee13d5d822aea2 Justin Lai 2023-11-15  1581  
ee13d5d822aea2 Justin Lai 2023-11-15  1582  	ring = &tp->tx_ring[0];
ee13d5d822aea2 Justin Lai 2023-11-15  1583  	netdev_err(dev, "Tx descriptor info:\n");
ee13d5d822aea2 Justin Lai 2023-11-15  1584  	netdev_err(dev, "Tx curIdx = 0x%x\n", ring->cur_idx);
ee13d5d822aea2 Justin Lai 2023-11-15  1585  	netdev_err(dev, "Tx dirtyIdx = 0x%x\n", ring->dirty_idx);
ee13d5d822aea2 Justin Lai 2023-11-15 @1586  	netdev_err(dev, "Tx phyAddr = 0x%llx\n", ring->phy_addr);
ee13d5d822aea2 Justin Lai 2023-11-15  1587  
ee13d5d822aea2 Justin Lai 2023-11-15  1588  	ring = &tp->rx_ring[0];
ee13d5d822aea2 Justin Lai 2023-11-15  1589  	netdev_err(dev, "Rx descriptor info:\n");
ee13d5d822aea2 Justin Lai 2023-11-15  1590  	netdev_err(dev, "Rx curIdx = 0x%x\n", ring->cur_idx);
ee13d5d822aea2 Justin Lai 2023-11-15  1591  	netdev_err(dev, "Rx dirtyIdx = 0x%x\n", ring->dirty_idx);
ee13d5d822aea2 Justin Lai 2023-11-15  1592  	netdev_err(dev, "Rx phyAddr = 0x%llx\n", ring->phy_addr);
ee13d5d822aea2 Justin Lai 2023-11-15  1593  
ee13d5d822aea2 Justin Lai 2023-11-15  1594  	netdev_err(dev, "Device Registers:\n");
ee13d5d822aea2 Justin Lai 2023-11-15  1595  	netdev_err(dev, "Chip Command = 0x%02x\n", rtase_r8(tp, RTASE_CHIP_CMD));
ee13d5d822aea2 Justin Lai 2023-11-15  1596  	netdev_err(dev, "IMR = %08x\n", rtase_r32(tp, RTASE_IMR0));
ee13d5d822aea2 Justin Lai 2023-11-15  1597  	netdev_err(dev, "ISR = %08x\n", rtase_r32(tp, RTASE_ISR0));
ee13d5d822aea2 Justin Lai 2023-11-15  1598  	netdev_err(dev, "Boot Ctrl Reg(0xE004) = %04x\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1599  		   rtase_r16(tp, RTASE_BOOT_CTL));
ee13d5d822aea2 Justin Lai 2023-11-15  1600  	netdev_err(dev, "EPHY ISR(0xE014) = %04x\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1601  		   rtase_r16(tp, RTASE_EPHY_ISR));
ee13d5d822aea2 Justin Lai 2023-11-15  1602  	netdev_err(dev, "EPHY IMR(0xE016) = %04x\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1603  		   rtase_r16(tp, RTASE_EPHY_IMR));
ee13d5d822aea2 Justin Lai 2023-11-15  1604  	netdev_err(dev, "CLKSW SET REG(0xE018) = %04x\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1605  		   rtase_r16(tp, RTASE_CLKSW_SET));
ee13d5d822aea2 Justin Lai 2023-11-15  1606  
ee13d5d822aea2 Justin Lai 2023-11-15  1607  	netdev_err(dev, "Dump PCI Registers:\n");
ee13d5d822aea2 Justin Lai 2023-11-15  1608  
ee13d5d822aea2 Justin Lai 2023-11-15  1609  	while (n < max_reg_size) {
ee13d5d822aea2 Justin Lai 2023-11-15  1610  		if ((n % RTASE_DWORD_MOD) == 0)
ee13d5d822aea2 Justin Lai 2023-11-15  1611  			netdev_err(tp->dev, "0x%03x:\n", n);
ee13d5d822aea2 Justin Lai 2023-11-15  1612  
ee13d5d822aea2 Justin Lai 2023-11-15  1613  		pci_read_config_dword(tp->pdev, n, &dword_rd);
ee13d5d822aea2 Justin Lai 2023-11-15  1614  		netdev_err(tp->dev, "%08x\n", dword_rd);
ee13d5d822aea2 Justin Lai 2023-11-15  1615  		n += 4;
ee13d5d822aea2 Justin Lai 2023-11-15  1616  	}
ee13d5d822aea2 Justin Lai 2023-11-15  1617  
ee13d5d822aea2 Justin Lai 2023-11-15  1618  	netdev_err(dev, "Dump tally counter:\n");
ee13d5d822aea2 Justin Lai 2023-11-15  1619  	counters = tp->tally_vaddr;
ee13d5d822aea2 Justin Lai 2023-11-15  1620  	rtase_dump_tally_counter(tp);
ee13d5d822aea2 Justin Lai 2023-11-15  1621  
ee13d5d822aea2 Justin Lai 2023-11-15  1622  	netdev_err(dev, "tx_packets %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1623  		   le64_to_cpu(counters->tx_packets));
ee13d5d822aea2 Justin Lai 2023-11-15  1624  	netdev_err(dev, "rx_packets %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1625  		   le64_to_cpu(counters->rx_packets));
ee13d5d822aea2 Justin Lai 2023-11-15  1626  	netdev_err(dev, "tx_errors %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1627  		   le64_to_cpu(counters->tx_errors));
ee13d5d822aea2 Justin Lai 2023-11-15  1628  	netdev_err(dev, "rx_missed %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1629  		   le64_to_cpu(counters->rx_missed));
ee13d5d822aea2 Justin Lai 2023-11-15  1630  	netdev_err(dev, "align_errors %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1631  		   le64_to_cpu(counters->align_errors));
ee13d5d822aea2 Justin Lai 2023-11-15  1632  	netdev_err(dev, "tx_one_collision %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1633  		   le64_to_cpu(counters->tx_one_collision));
ee13d5d822aea2 Justin Lai 2023-11-15  1634  	netdev_err(dev, "tx_multi_collision %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1635  		   le64_to_cpu(counters->tx_multi_collision));
ee13d5d822aea2 Justin Lai 2023-11-15  1636  	netdev_err(dev, "rx_unicast %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1637  		   le64_to_cpu(counters->rx_unicast));
ee13d5d822aea2 Justin Lai 2023-11-15  1638  	netdev_err(dev, "rx_broadcast %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1639  		   le64_to_cpu(counters->rx_broadcast));
ee13d5d822aea2 Justin Lai 2023-11-15  1640  	netdev_err(dev, "rx_multicast %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1641  		   le64_to_cpu(counters->rx_multicast));
ee13d5d822aea2 Justin Lai 2023-11-15  1642  	netdev_err(dev, "tx_aborted %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1643  		   le64_to_cpu(counters->tx_aborted));
ee13d5d822aea2 Justin Lai 2023-11-15  1644  	netdev_err(dev, "tx_underun %lld\n",
ee13d5d822aea2 Justin Lai 2023-11-15  1645  		   le64_to_cpu(counters->tx_underun));
ee13d5d822aea2 Justin Lai 2023-11-15  1646  }
ee13d5d822aea2 Justin Lai 2023-11-15  1647  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
