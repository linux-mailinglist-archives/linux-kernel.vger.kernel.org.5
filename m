Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9567E1A94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKFG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjKFG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:59:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38BA4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699253987; x=1730789987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z2a+ZQYduABVO1PtsBIirBhxo9V59QgrSOz1BS2hYls=;
  b=Eom9jx6kP8A3yyuljL50eVzM/GbEmCFtQkFQDi1086EkFSlZwjGT3Der
   DwmMFTd4NJpVqczPhdsDDbd2Kk7Cnpb+zYkeOnaVm+qqiJphc2xmsCiE4
   qqrhl2S2S6edjLVpmuAIfECOd7hP7ddcooexzZhYSFTPwh8FJ3F4YcoM3
   gj6GaMvsaPQ6yOPC5iHUXTohWHJDUr1ZPWF5y5WY4sv6TC0EO2hHWQNEb
   Qvaox54brPhjWoLXJlD/wHwQQFr574LYl6/QmCO9UJSjEJYGN3BmW57jf
   qjvWSuhiIoYmZjT4Pldjfn2So4tEpYgYa7WOIiGK96LZPW8xEQSiH/NRT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386393948"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="386393948"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:59:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755765104"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="755765104"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2023 22:59:44 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qztaI-0006D2-1j;
        Mon, 06 Nov 2023 06:59:42 +0000
Date:   Mon, 6 Nov 2023 14:59:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Chan <mchan@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/broadcom/bnxt/bnxt.c:4092:38: warning: '%s'
 directive output may be truncated writing 4 bytes into a region of size
 between 2 and 17
Message-ID: <202311061443.bktIDwRt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 379a80a1d048dcacfc2011d5d32e16d5c804b9f4 bnxt_en: Fix compile errors when CONFIG_BNXT_SRIOV is not set.
date:   8 years ago
config: x86_64-buildonly-randconfig-006-20230911 (https://download.01.org/0day-ci/archive/20231106/202311061443.bktIDwRt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061443.bktIDwRt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061443.bktIDwRt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/net/ethernet/broadcom/bnxt/bnxt.c:10:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   In file included from include/net/inet_sock.h:27,
                    from include/net/ip.h:30,
                    from drivers/net/ethernet/broadcom/bnxt/bnxt.c:35:
   include/net/sock.h: In function 'skb_add_data_nocache':
   include/net/sock.h:1820:55: warning: pointer targets in passing argument 4 of 'skb_do_copy_data_nocache' differ in signedness [-Wpointer-sign]
    1820 |         err = skb_do_copy_data_nocache(sk, skb, from, skb_put(skb, copy),
         |                                                       ^~~~~~~~~~~~~~~~~~
         |                                                       |
         |                                                       unsigned char *
   include/net/sock.h:1798:73: note: expected 'char *' but argument is of type 'unsigned char *'
    1798 |                                            struct iov_iter *from, char *to,
         |                                                                   ~~~~~~^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_tx_enable':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4291:30: warning: variable 'txq' set but not used [-Wunused-but-set-variable]
    4291 |         struct netdev_queue *txq;
         |                              ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_change_mac_addr':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5203:38: warning: pointer targets in passing argument 1 of 'is_valid_ether_addr' differ in signedness [-Wpointer-sign]
    5203 |         if (!is_valid_ether_addr(addr->sa_data))
         |                                  ~~~~^~~~~~~~~
         |                                      |
         |                                      char *
   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt.c:22:
   include/linux/etherdevice.h:186:50: note: expected 'const u8 *' {aka 'const unsigned char *'} but argument is of type 'char *'
     186 | static inline bool is_valid_ether_addr(const u8 *addr)
         |                                        ~~~~~~~~~~^~~~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:206: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:206: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function '__bnxt_open_nic':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:4092:38: warning: '%s' directive output may be truncated writing 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
    4092 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                      ^~                 ~~~~~~
   In function 'bnxt_setup_msix',
       inlined from 'bnxt_setup_int_mode' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4143:8,
       inlined from '__bnxt_open_nic' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4536:8:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4092:34: note: directive argument in the range [0, 2147483646]
    4092 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                  ^~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4091:25: note: 'snprintf' output between 8 and 32 bytes into a destination of size 18
    4091 |                         snprintf(bp->irq_tbl[i].name, len,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4092 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function '__bnxt_open_nic':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4132:22: warning: '%s' directive output may be truncated writing 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
    4132 |                  "%s-%s-%d", bp->dev->name, "TxRx", 0);
         |                      ^~                     ~~~~~~
   In function 'bnxt_setup_inta',
       inlined from 'bnxt_setup_int_mode' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4147:8,
       inlined from '__bnxt_open_nic' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4536:8:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4131:9: note: 'snprintf' output between 8 and 23 bytes into a destination of size 18
    4131 |         snprintf(bp->irq_tbl[0].name, len,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4132 |                  "%s-%s-%d", bp->dev->name, "TxRx", 0);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:252: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_one':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3745:69: warning: '.' directive output may be truncated writing 1 byte into a region of size between 0 and 8 [-Wformat-truncation=]
    3745 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |                                                                     ^
   In function 'bnxt_hwrm_ver_get',
       inlined from 'bnxt_init_one' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:5649:2:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3745:51: note: directive argument in the range [0, 255]
    3745 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3745:51: note: directive argument in the range [0, 255]
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3745:9: note: 'snprintf' output between 18 and 30 bytes into a destination of size 21
    3745 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3746 |                  resp->hwrm_fw_maj, resp->hwrm_fw_min, resp->hwrm_fw_bld,
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3747 |                  resp->hwrm_intf_maj, resp->hwrm_intf_min, resp->hwrm_intf_upd);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_one':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5541:54: warning: '.' directive output may be truncated writing 1 byte into a region of size between 0 and 4 [-Wformat-truncation=]
    5541 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |                                                      ^
   In function 'bnxt_probe_phy',
       inlined from 'bnxt_init_one' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:5694:7:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5541:44: note: directive argument in the range [0, 255]
    5541 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |                                            ^~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5541:9: note: 'snprintf' output between 10 and 16 bytes into a destination of size 11
    5541 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    5542 |                  link_info->phy_ver[0],
         |                  ~~~~~~~~~~~~~~~~~~~~~~
    5543 |                  link_info->phy_ver[1],
         |                  ~~~~~~~~~~~~~~~~~~~~~~
    5544 |                  link_info->phy_ver[2]);
         |                  ~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bitops.h:96: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'


vim +4092 drivers/net/ethernet/broadcom/bnxt/bnxt.c

c0c050c58d8409 Michael Chan 2015-10-22  4036  
c0c050c58d8409 Michael Chan 2015-10-22  4037  static int bnxt_setup_msix(struct bnxt *bp)
c0c050c58d8409 Michael Chan 2015-10-22  4038  {
c0c050c58d8409 Michael Chan 2015-10-22  4039  	struct msix_entry *msix_ent;
c0c050c58d8409 Michael Chan 2015-10-22  4040  	struct net_device *dev = bp->dev;
c0c050c58d8409 Michael Chan 2015-10-22  4041  	int i, total_vecs, rc = 0;
c0c050c58d8409 Michael Chan 2015-10-22  4042  	const int len = sizeof(bp->irq_tbl[0].name);
c0c050c58d8409 Michael Chan 2015-10-22  4043  
c0c050c58d8409 Michael Chan 2015-10-22  4044  	bp->flags &= ~BNXT_FLAG_USING_MSIX;
c0c050c58d8409 Michael Chan 2015-10-22  4045  	total_vecs = bp->cp_nr_rings;
c0c050c58d8409 Michael Chan 2015-10-22  4046  
c0c050c58d8409 Michael Chan 2015-10-22  4047  	msix_ent = kcalloc(total_vecs, sizeof(struct msix_entry), GFP_KERNEL);
c0c050c58d8409 Michael Chan 2015-10-22  4048  	if (!msix_ent)
c0c050c58d8409 Michael Chan 2015-10-22  4049  		return -ENOMEM;
c0c050c58d8409 Michael Chan 2015-10-22  4050  
c0c050c58d8409 Michael Chan 2015-10-22  4051  	for (i = 0; i < total_vecs; i++) {
c0c050c58d8409 Michael Chan 2015-10-22  4052  		msix_ent[i].entry = i;
c0c050c58d8409 Michael Chan 2015-10-22  4053  		msix_ent[i].vector = 0;
c0c050c58d8409 Michael Chan 2015-10-22  4054  	}
c0c050c58d8409 Michael Chan 2015-10-22  4055  
c0c050c58d8409 Michael Chan 2015-10-22  4056  	total_vecs = pci_enable_msix_range(bp->pdev, msix_ent, 1, total_vecs);
c0c050c58d8409 Michael Chan 2015-10-22  4057  	if (total_vecs < 0) {
c0c050c58d8409 Michael Chan 2015-10-22  4058  		rc = -ENODEV;
c0c050c58d8409 Michael Chan 2015-10-22  4059  		goto msix_setup_exit;
c0c050c58d8409 Michael Chan 2015-10-22  4060  	}
c0c050c58d8409 Michael Chan 2015-10-22  4061  
c0c050c58d8409 Michael Chan 2015-10-22  4062  	bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
c0c050c58d8409 Michael Chan 2015-10-22  4063  	if (bp->irq_tbl) {
c0c050c58d8409 Michael Chan 2015-10-22  4064  		int tcs;
c0c050c58d8409 Michael Chan 2015-10-22  4065  
c0c050c58d8409 Michael Chan 2015-10-22  4066  		/* Trim rings based upon num of vectors allocated */
c0c050c58d8409 Michael Chan 2015-10-22  4067  		bp->rx_nr_rings = min_t(int, total_vecs, bp->rx_nr_rings);
c0c050c58d8409 Michael Chan 2015-10-22  4068  		bp->tx_nr_rings = min_t(int, total_vecs, bp->tx_nr_rings);
c0c050c58d8409 Michael Chan 2015-10-22  4069  		bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
c0c050c58d8409 Michael Chan 2015-10-22  4070  		tcs = netdev_get_num_tc(dev);
c0c050c58d8409 Michael Chan 2015-10-22  4071  		if (tcs > 1) {
c0c050c58d8409 Michael Chan 2015-10-22  4072  			bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
c0c050c58d8409 Michael Chan 2015-10-22  4073  			if (bp->tx_nr_rings_per_tc == 0) {
c0c050c58d8409 Michael Chan 2015-10-22  4074  				netdev_reset_tc(dev);
c0c050c58d8409 Michael Chan 2015-10-22  4075  				bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
c0c050c58d8409 Michael Chan 2015-10-22  4076  			} else {
c0c050c58d8409 Michael Chan 2015-10-22  4077  				int i, off, count;
c0c050c58d8409 Michael Chan 2015-10-22  4078  
c0c050c58d8409 Michael Chan 2015-10-22  4079  				bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
c0c050c58d8409 Michael Chan 2015-10-22  4080  				for (i = 0; i < tcs; i++) {
c0c050c58d8409 Michael Chan 2015-10-22  4081  					count = bp->tx_nr_rings_per_tc;
c0c050c58d8409 Michael Chan 2015-10-22  4082  					off = i * count;
c0c050c58d8409 Michael Chan 2015-10-22  4083  					netdev_set_tc_queue(dev, i, count, off);
c0c050c58d8409 Michael Chan 2015-10-22  4084  				}
c0c050c58d8409 Michael Chan 2015-10-22  4085  			}
c0c050c58d8409 Michael Chan 2015-10-22  4086  		}
c0c050c58d8409 Michael Chan 2015-10-22  4087  		bp->cp_nr_rings = max_t(int, bp->rx_nr_rings, bp->tx_nr_rings);
c0c050c58d8409 Michael Chan 2015-10-22  4088  
c0c050c58d8409 Michael Chan 2015-10-22  4089  		for (i = 0; i < bp->cp_nr_rings; i++) {
c0c050c58d8409 Michael Chan 2015-10-22  4090  			bp->irq_tbl[i].vector = msix_ent[i].vector;
c0c050c58d8409 Michael Chan 2015-10-22  4091  			snprintf(bp->irq_tbl[i].name, len,
c0c050c58d8409 Michael Chan 2015-10-22 @4092  				 "%s-%s-%d", dev->name, "TxRx", i);
c0c050c58d8409 Michael Chan 2015-10-22  4093  			bp->irq_tbl[i].handler = bnxt_msix;
c0c050c58d8409 Michael Chan 2015-10-22  4094  		}
c0c050c58d8409 Michael Chan 2015-10-22  4095  		rc = bnxt_set_real_num_queues(bp);
c0c050c58d8409 Michael Chan 2015-10-22  4096  		if (rc)
c0c050c58d8409 Michael Chan 2015-10-22  4097  			goto msix_setup_exit;
c0c050c58d8409 Michael Chan 2015-10-22  4098  	} else {
c0c050c58d8409 Michael Chan 2015-10-22  4099  		rc = -ENOMEM;
c0c050c58d8409 Michael Chan 2015-10-22  4100  		goto msix_setup_exit;
c0c050c58d8409 Michael Chan 2015-10-22  4101  	}
c0c050c58d8409 Michael Chan 2015-10-22  4102  	bp->flags |= BNXT_FLAG_USING_MSIX;
c0c050c58d8409 Michael Chan 2015-10-22  4103  	kfree(msix_ent);
c0c050c58d8409 Michael Chan 2015-10-22  4104  	return 0;
c0c050c58d8409 Michael Chan 2015-10-22  4105  
c0c050c58d8409 Michael Chan 2015-10-22  4106  msix_setup_exit:
c0c050c58d8409 Michael Chan 2015-10-22  4107  	netdev_err(bp->dev, "bnxt_setup_msix err: %x\n", rc);
c0c050c58d8409 Michael Chan 2015-10-22  4108  	pci_disable_msix(bp->pdev);
c0c050c58d8409 Michael Chan 2015-10-22  4109  	kfree(msix_ent);
c0c050c58d8409 Michael Chan 2015-10-22  4110  	return rc;
c0c050c58d8409 Michael Chan 2015-10-22  4111  }
c0c050c58d8409 Michael Chan 2015-10-22  4112  

:::::: The code at line 4092 was first introduced by commit
:::::: c0c050c58d840994ba842ad1c338a98e7c12b764 bnxt_en: New Broadcom ethernet driver.

:::::: TO: Michael Chan <mchan@broadcom.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
