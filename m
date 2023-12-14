Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E68126CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443145AbjLNFJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjLNFJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:09:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCD106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702530593; x=1734066593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cd6UtyNaPeH1MxMteWuVqa0aiuAfrVKfEkFpAum6ZoU=;
  b=Q1CxOdqq9TdTjyCJCsnaKPFLNVe3v93ih1BxxOEJWjarjWNJHfqPVpge
   GUl9/kSo5D82KqK8xV/s0syG6J1xN5JLMAtYRZX+cH1OLasHLtHjCJ9AE
   /HJmYmgO4YfNJaCNNrOWBSKPlPs8y6sMB5awb3dzE4/F8T68mv3XVn3Rt
   VBajMhqJh3OvsMP8ilfyD1FOCkSq6liFf+dE6fCeknaXo+Y0kTCO84tn3
   K6RlBqXNC7Uy0Dy+j8iZ0dN0Usg0iUEv+7uVK0FV6bZLdAra8CSKia32b
   BRmKfSM0g707UPGCffWG7NgUSveyElOKR43Fp/C3hUmmhq0aZFzGNlrHQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375224427"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375224427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 21:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="897611115"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="897611115"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2023 21:09:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDdym-000LZz-2w;
        Thu, 14 Dec 2023 05:09:48 +0000
Date:   Thu, 14 Dec 2023 13:09:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312141322.DDhM2rzj-lkp@intel.com>
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

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 6ef92063bf94cd8a6fa9fea3a82596955eb25424 net: korina: Make driver COMPILE_TESTable
date:   2 years, 8 months ago
config: sh-randconfig-r133-20231118 (https://download.01.org/0day-ci/archive/20231214/202312141322.DDhM2rzj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141322.DDhM2rzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141322.DDhM2rzj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/korina.c:408:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *tx_dma_regs @@
   drivers/net/ethernet/korina.c:408:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:408:33: sparse:     got struct dma_reg [noderef] __iomem *tx_dma_regs
   drivers/net/ethernet/korina.c:415:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *rx_dma_regs @@
   drivers/net/ethernet/korina.c:415:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:415:33: sparse:     got struct dma_reg [noderef] __iomem *rx_dma_regs
>> drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:391:13: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:392:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:392:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:394:26: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:397:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:400:9: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:401:9: sparse:     got unsigned int *
>> drivers/net/ethernet/korina.c:391:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:391:13: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:392:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:392:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:26: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:394:26: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:397:17: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:400:9: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/ethernet/korina.c:401:9: sparse:     got unsigned int *

vim +391 drivers/net/ethernet/korina.c

0fc96939a97ffd drivers/net/ethernet/korina.c Thomas Bogendoerfer 2021-04-19  387  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  388  static inline void korina_abort_dma(struct net_device *dev,
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  389  					struct dma_reg *ch)
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  390  {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19 @391  	if (readl(&ch->dmac) & DMA_CHAN_RUN_BIT) {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  392  		writel(0x10, &ch->dmac);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  393  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  394  		while (!(readl(&ch->dmas) & DMA_STAT_HALT))
860e9538a9482b drivers/net/ethernet/korina.c Florian Westphal    2016-05-03  395  			netif_trans_update(dev);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  396  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  397  		writel(0, &ch->dmas);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  398  	}
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  399  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  400  	writel(0, &ch->dmadptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  401  	writel(0, &ch->dmandptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  402  }
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  403  

:::::: The code at line 391 was first introduced by commit
:::::: ef11291bcd5f963c72e7ba5952be3e3c97463d2c Add support the Korina (IDT RC32434) Ethernet MAC

:::::: TO: Florian Fainelli <florian.fainelli@telecomint.eu>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
