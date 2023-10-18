Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2667CDBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjJRMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjJRMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:32:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F34BA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697632370; x=1729168370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p1I1hBsZX/DQygdcRiZq5uN7j+ERHCkcuI4n04NmK9c=;
  b=K0nCYnP5NSRPBkL21uQhH/VzDJmtUogm1wrUMF7ONevvInf05scGinF1
   nAy18Rw4AsFAOwtBQNGrhHqxei/cU0e954Ju6bYDTfqGUVXvvl4zn03am
   L1DF3/uuk75dXEmWkGzoEYZbENbNNPXT/5wSY3GAcDfOtpZE5c9Rma6gl
   JUwKvcJu9tBerPEJi4iBhPy1Ih1VfYMUJznhEFxQgdL6kbQzCcNPOSSPK
   fHU2pKN84teIqaNVs/VBJRXDn88SVFo+WV3Hc3EjvZuqY4yu92sSNrDsH
   PMCjBhWlDbJursRuFJYGtTUefFdscO9Zd+jXVCN8qFiJUHS9YHeuvA6CR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376374348"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="376374348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="750079116"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="750079116"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2023 05:32:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt5jB-0000M0-1C;
        Wed, 18 Oct 2023 12:32:45 +0000
Date:   Wed, 18 Oct 2023 20:32:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/memory/tegra/tegra186.c:74:49: warning: '%u' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 6
Message-ID: <202310182004.0XOYolzI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: a7cffa11fa9232eabf0c4f441dc53002978ab526 memory: tegra: Add memory controller channels support
date:   1 year, 5 months ago
config: arm64-randconfig-r036-20230512 (https://download.01.org/0day-ci/archive/20231018/202310182004.0XOYolzI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182004.0XOYolzI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182004.0XOYolzI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/memory/tegra/tegra186.c: In function 'tegra186_mc_probe':
>> drivers/memory/tegra/tegra186.c:74:49: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
      74 |                 snprintf(name, sizeof(name), "ch%u", i);
         |                                                 ^~
   drivers/memory/tegra/tegra186.c:74:46: note: directive argument in the range [0, 4294967294]
      74 |                 snprintf(name, sizeof(name), "ch%u", i);
         |                                              ^~~~~~
   drivers/memory/tegra/tegra186.c:74:17: note: 'snprintf' output between 4 and 13 bytes into a destination of size 8
      74 |                 snprintf(name, sizeof(name), "ch%u", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +74 drivers/memory/tegra/tegra186.c

    48	
    49	static int tegra186_mc_probe(struct tegra_mc *mc)
    50	{
    51		struct platform_device *pdev = to_platform_device(mc->dev);
    52		unsigned int i;
    53		char name[8];
    54		int err;
    55	
    56		mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
    57		if (IS_ERR(mc->bcast_ch_regs)) {
    58			if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
    59				dev_warn(&pdev->dev,
    60					 "Broadcast channel is missing, please update your device-tree\n");
    61				mc->bcast_ch_regs = NULL;
    62				goto populate;
    63			}
    64	
    65			return PTR_ERR(mc->bcast_ch_regs);
    66		}
    67	
    68		mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels, sizeof(*mc->ch_regs),
    69					   GFP_KERNEL);
    70		if (!mc->ch_regs)
    71			return -ENOMEM;
    72	
    73		for (i = 0; i < mc->soc->num_channels; i++) {
  > 74			snprintf(name, sizeof(name), "ch%u", i);
    75	
    76			mc->ch_regs[i] = devm_platform_ioremap_resource_byname(pdev, name);
    77			if (IS_ERR(mc->ch_regs[i]))
    78				return PTR_ERR(mc->ch_regs[i]);
    79		}
    80	
    81	populate:
    82		err = of_platform_populate(mc->dev->of_node, NULL, NULL, mc->dev);
    83		if (err < 0)
    84			return err;
    85	
    86		tegra186_mc_program_sid(mc);
    87	
    88		return 0;
    89	}
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
