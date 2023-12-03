Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5E802144
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjLCGb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCGbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:31:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57510F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585109; x=1733121109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DBWET4GQiuRfCBb1fB7SdWA1naylfEFV034G8pPqYl0=;
  b=ZlyvipBpiqKfPbxChLSi5w9KfqGKFpVN26M1xuehSZIghE8ivT3JtUJl
   cJNqIT1cnw+1AnMG1mx2ujoxLzyfeqOnv2NjN1kchqiB06sO8nzpe+PDi
   TkuaqUVpXnwm0VePvzLIZu5YqWYrjlXHxqq37XXa39SPvy43h+TDm8hUP
   W/lK+hDHy+HahxEdxc7FsCa0xQYxbBoenfOp58I6LipjPBb3jIRvP7G7I
   Qv1w88cTaIZeo4q7UYbd5EGqWt+DmnVr799gqOPow9IP+WJUEkmKDifva
   nE2YyAhw5vtdvp+gBLUyaM/e4B1ILcqIN3w+l6oySYHdrI2A7slKtzIMJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6942685"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6942685"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="893652731"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="893652731"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2023 22:31:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g11-0006KQ-2C;
        Sun, 03 Dec 2023 06:31:43 +0000
Date:   Sun, 3 Dec 2023 14:31:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@rainbow-software.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/net/ethernet/dlink/dl2k.c:483:17: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202312030058.hfZPTXd7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: c3f45d322cbd379c46466cc2ecab7e2d719b22ed dl2k: Add support for IP1000A-based cards
date:   8 years ago
config: s390-randconfig-r121-20231106 (https://download.01.org/0day-ci/archive/20231203/202312030058.hfZPTXd7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312030058.hfZPTXd7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312030058.hfZPTXd7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/dlink/dl2k.c:483:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   drivers/net/ethernet/dlink/dl2k.c:483:17: sparse:     expected unsigned short [usertype] value
   drivers/net/ethernet/dlink/dl2k.c:483:17: sparse:     got restricted __le16 [usertype]
   drivers/net/ethernet/dlink/dl2k.c:366:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/dlink/dl2k.c: note: in included file (through arch/s390/include/asm/io.h, include/linux/io.h, include/linux/pci.h, ...):
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:121:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:121:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:121:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:121:16: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:155:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:155:22: sparse:     expected unsigned short [usertype] val
   include/asm-generic/io.h:155:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:163:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:129:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:163:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:163:22: sparse:     expected unsigned int [usertype] val

vim +483 drivers/net/ethernet/dlink/dl2k.c

   448	
   449	static int
   450	rio_open (struct net_device *dev)
   451	{
   452		struct netdev_private *np = netdev_priv(dev);
   453		void __iomem *ioaddr = np->ioaddr;
   454		const int irq = np->pdev->irq;
   455		int i;
   456		u16 macctrl;
   457	
   458		i = request_irq(irq, rio_interrupt, IRQF_SHARED, dev->name, dev);
   459		if (i)
   460			return i;
   461	
   462		/* Reset all logic functions */
   463		dw16(ASICCtrl + 2,
   464		     GlobalReset | DMAReset | FIFOReset | NetworkReset | HostReset);
   465		mdelay(10);
   466	
   467		rio_set_led_mode(dev);
   468	
   469		/* DebugCtrl bit 4, 5, 9 must set */
   470		dw32(DebugCtrl, dr32(DebugCtrl) | 0x0230);
   471	
   472		/* Jumbo frame */
   473		if (np->jumbo != 0)
   474			dw16(MaxFrameSize, MAX_JUMBO+14);
   475	
   476		alloc_list (dev);
   477	
   478		/* Set station address */
   479		/* 16 or 32-bit access is required by TC9020 datasheet but 8-bit works
   480		 * too. However, it doesn't work on IP1000A so we use 16-bit access.
   481		 */
   482		for (i = 0; i < 3; i++)
 > 483			dw16(StationAddr0 + 2 * i,
   484			     cpu_to_le16(((u16 *)dev->dev_addr)[i]));
   485	
   486		set_multicast (dev);
   487		if (np->coalesce) {
   488			dw32(RxDMAIntCtrl, np->rx_coalesce | np->rx_timeout << 16);
   489		}
   490		/* Set RIO to poll every N*320nsec. */
   491		dw8(RxDMAPollPeriod, 0x20);
   492		dw8(TxDMAPollPeriod, 0xff);
   493		dw8(RxDMABurstThresh, 0x30);
   494		dw8(RxDMAUrgentThresh, 0x30);
   495		dw32(RmonStatMask, 0x0007ffff);
   496		/* clear statistics */
   497		clear_stats (dev);
   498	
   499		/* VLAN supported */
   500		if (np->vlan) {
   501			/* priority field in RxDMAIntCtrl  */
   502			dw32(RxDMAIntCtrl, dr32(RxDMAIntCtrl) | 0x7 << 10);
   503			/* VLANId */
   504			dw16(VLANId, np->vlan);
   505			/* Length/Type should be 0x8100 */
   506			dw32(VLANTag, 0x8100 << 16 | np->vlan);
   507			/* Enable AutoVLANuntagging, but disable AutoVLANtagging.
   508			   VLAN information tagged by TFC' VID, CFI fields. */
   509			dw32(MACCtrl, dr32(MACCtrl) | AutoVLANuntagging);
   510		}
   511	
   512		setup_timer(&np->timer, rio_timer, (unsigned long)dev);
   513		np->timer.expires = jiffies + 1*HZ;
   514		add_timer (&np->timer);
   515	
   516		/* Start Tx/Rx */
   517		dw32(MACCtrl, dr32(MACCtrl) | StatsEnable | RxEnable | TxEnable);
   518	
   519		macctrl = 0;
   520		macctrl |= (np->vlan) ? AutoVLANuntagging : 0;
   521		macctrl |= (np->full_duplex) ? DuplexSelect : 0;
   522		macctrl |= (np->tx_flow) ? TxFlowControlEnable : 0;
   523		macctrl |= (np->rx_flow) ? RxFlowControlEnable : 0;
   524		dw16(MACCtrl, macctrl);
   525	
   526		netif_start_queue (dev);
   527	
   528		dl2k_enable_int(np);
   529		return 0;
   530	}
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
