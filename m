Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFB75A025
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGSUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD51FC0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689799740; x=1721335740;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gyE5oUAZQf8eFO3OxexjtCVX4TO6hdfu4WVnH0NtknA=;
  b=AUuR9+a4kUo4Qtlf4Hxyl5+rIN+bb+XT3QXRmAgyMNuCDkwsKXEDK5qd
   f3JNAc3DogiE8H/ZdtZOphCNmHAq3VhnYm/MBfE7N2aY0weJCFryWAMMd
   bkgo1OUoqejzse5P24iJqYKLTkW+aTpC+bZMDf/p5uJ0wUW4SGVrnvnaA
   gyLnl6I1aR1AwDvoeceOnPezAvs12ONC3JnSEp+BhvjT0RpbjwUKV/GdU
   INJZfO2cHmb9hoyt5xmJuUmqdQE4OafceuVsNirRIpbf5aZNR+pv/zWkD
   lg4Vv4geuwf7Bhnj1+A84l1agDAboVpZU+p9SULF4oT1UnKqSKTDPN2E6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346871397"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346871397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970763093"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="970763093"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jul 2023 13:48:58 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qME6U-0005T5-0j;
        Wed, 19 Jul 2023 20:48:58 +0000
Date:   Thu, 20 Jul 2023 04:48:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to
 restricted __be32
Message-ID: <202307200429.ZJZG9V9A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: 7bb49d774f481fdd7bd053e034e4d206770fda04 arm64: bcmbca: Make BCM4908 drivers depend on ARCH_BCMBCA
date:   11 months ago
config: arm64-randconfig-r092-20230720 (https://download.01.org/0day-ci/archive/20230720/202307200429.ZJZG9V9A-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307200429.ZJZG9V9A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307200429.ZJZG9V9A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:65: sparse: sparse: cast to restricted __be32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:103:45: sparse: sparse: cast to restricted __le32
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:115:36: sparse: sparse: restricted __le32 degrades to integer
>> drivers/soc/bcm/bcm63xx/bcm-pmb.c:115:55: sparse: sparse: restricted __be32 degrades to integer

vim +103 drivers/soc/bcm/bcm63xx/bcm-pmb.c

8bcac4011ebe0db Rafał Miłecki 2020-12-14   90  
8bcac4011ebe0db Rafał Miłecki 2020-12-14   91  static int bcm_pmb_bpcm_read(struct bcm_pmb *pmb, int bus, u8 device,
8bcac4011ebe0db Rafał Miłecki 2020-12-14   92  			     int offset, u32 *val)
8bcac4011ebe0db Rafał Miłecki 2020-12-14   93  {
8bcac4011ebe0db Rafał Miłecki 2020-12-14   94  	void __iomem *base = pmb->base + bus * 0x20;
8bcac4011ebe0db Rafał Miłecki 2020-12-14   95  	unsigned long flags;
8bcac4011ebe0db Rafał Miłecki 2020-12-14   96  	int err;
8bcac4011ebe0db Rafał Miłecki 2020-12-14   97  
8bcac4011ebe0db Rafał Miłecki 2020-12-14   98  	spin_lock_irqsave(&pmb->lock, flags);
8bcac4011ebe0db Rafał Miłecki 2020-12-14   99  	err = bpcm_rd(base, device, offset, val);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  100  	spin_unlock_irqrestore(&pmb->lock, flags);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  101  
8bcac4011ebe0db Rafał Miłecki 2020-12-14  102  	if (!err)
8bcac4011ebe0db Rafał Miłecki 2020-12-14 @103  		*val = pmb->little_endian ? le32_to_cpu(*val) : be32_to_cpu(*val);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  104  
8bcac4011ebe0db Rafał Miłecki 2020-12-14  105  	return err;
8bcac4011ebe0db Rafał Miłecki 2020-12-14  106  }
8bcac4011ebe0db Rafał Miłecki 2020-12-14  107  
8bcac4011ebe0db Rafał Miłecki 2020-12-14  108  static int bcm_pmb_bpcm_write(struct bcm_pmb *pmb, int bus, u8 device,
8bcac4011ebe0db Rafał Miłecki 2020-12-14  109  			      int offset, u32 val)
8bcac4011ebe0db Rafał Miłecki 2020-12-14  110  {
8bcac4011ebe0db Rafał Miłecki 2020-12-14  111  	void __iomem *base = pmb->base + bus * 0x20;
8bcac4011ebe0db Rafał Miłecki 2020-12-14  112  	unsigned long flags;
8bcac4011ebe0db Rafał Miłecki 2020-12-14  113  	int err;
8bcac4011ebe0db Rafał Miłecki 2020-12-14  114  
8bcac4011ebe0db Rafał Miłecki 2020-12-14 @115  	val = pmb->little_endian ? cpu_to_le32(val) : cpu_to_be32(val);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  116  
8bcac4011ebe0db Rafał Miłecki 2020-12-14  117  	spin_lock_irqsave(&pmb->lock, flags);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  118  	err = bpcm_wr(base, device, offset, val);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  119  	spin_unlock_irqrestore(&pmb->lock, flags);
8bcac4011ebe0db Rafał Miłecki 2020-12-14  120  
8bcac4011ebe0db Rafał Miłecki 2020-12-14  121  	return err;
8bcac4011ebe0db Rafał Miłecki 2020-12-14  122  }
8bcac4011ebe0db Rafał Miłecki 2020-12-14  123  

:::::: The code at line 103 was first introduced by commit
:::::: 8bcac4011ebe0dbdd46fd55b036ee855c95702d3 soc: bcm: add PM driver for Broadcom's PMB

:::::: TO: Rafał Miłecki <rafal@milecki.pl>
:::::: CC: Florian Fainelli <f.fainelli@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
