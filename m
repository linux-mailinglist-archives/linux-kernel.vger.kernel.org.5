Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3F806839
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376986AbjLFH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLFH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:28:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB15122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701847702; x=1733383702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y2BLxMeFCg26MvmvkQY1Eoek5zZc7iBvIKIQlKS+GRQ=;
  b=WklE2TvqicchcTdFHV5OjOWvMZVMaNCtxDLebgdMYvZX3LhJ47/b2dTQ
   xlCD1zu4TXVoj8yhCFAmdvTq8rSdf+67IZcxagl2VJNicYGPhjgazKw0Z
   KrcSYfcSgdtHraM2Bj9BLAfs2+35qL64r1HZrN8e/QbgFmgV9dF1Vc66B
   UYpqH/Fy0Fup50coGJT9h9xZ6jVrDnEkEpUoqG/upP/lPwiN1s+U00pYt
   uDQsv2rYiByFKKV0v9PS2zLuPswX6cSnzhE3y5hVrDQib29R8YHm78RKX
   8S+fyC9/xE12Pup9Vc+TCUIvVVXD9qWbqgAWZqRghb4JsOumPih3bQVEI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391189446"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391189446"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 23:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="720987882"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="720987882"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2023 23:28:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAmKO-000ASw-13;
        Wed, 06 Dec 2023 07:28:16 +0000
Date:   Wed, 6 Dec 2023 15:27:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/phy/marvell/phy-mmp3-hsic.c:61:31: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202312061540.CHjD764h-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 0347c69214f4b600f40c0dc58945dc2798e2b3d9 phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
date:   3 years, 1 month ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231206/202312061540.CHjD764h-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061540.CHjD764h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061540.CHjD764h-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/phy/marvell/phy-mmp3-hsic.c:61:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/phy/marvell/phy-mmp3-hsic.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:299:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:299:22: sparse:     got restricted __le32 [usertype]

vim +/__iomem +61 drivers/phy/marvell/phy-mmp3-hsic.c

    39	
    40	static int mmp3_hsic_phy_probe(struct platform_device *pdev)
    41	{
    42		struct device *dev = &pdev->dev;
    43		struct phy_provider *provider;
    44		struct resource *resource;
    45		void __iomem *base;
    46		struct phy *phy;
    47	
    48		resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    49		base = devm_ioremap_resource(dev, resource);
    50		if (IS_ERR(base)) {
    51			dev_err(dev, "failed to remap PHY regs\n");
    52			return PTR_ERR(base);
    53		}
    54	
    55		phy = devm_phy_create(dev, NULL, &mmp3_hsic_phy_ops);
    56		if (IS_ERR(phy)) {
    57			dev_err(dev, "failed to create PHY\n");
    58			return PTR_ERR(phy);
    59		}
    60	
  > 61		phy_set_drvdata(phy, (void *)base);
    62		provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
    63		if (IS_ERR(provider)) {
    64			dev_err(dev, "failed to register PHY provider\n");
    65			return PTR_ERR(provider);
    66		}
    67	
    68		return 0;
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
