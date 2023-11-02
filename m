Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E37DF90D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjKBRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKBRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D0182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947119; x=1730483119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lsv6LCCERrXEZ6+vMlRwcKrtfS+obUEef2nO4ynJUOA=;
  b=AJEePLZ/BbZSqO6oGrVroXlLw4fhUVBwrOjANS12Ew0sqSkJmhf8pc2P
   McN1rFIdVumz+quInzO1NUiNXE6UOj4EqXINwGxuagzLQ7AA3L7aFSIT9
   JeOaP6dQXcsfUTegiQCLxYNTqUw2eDAit5xrsQ9Voj8wTUR6bkXKWiLK/
   D7C+b/v+Lp7oT0FVsAfkCyYx7cfOCItqvwINn7SNIdwHDNLyj+yyZPtV+
   8WFTfPcO/cCqz66WreJUEeWz6CBwKA3jydOlQ4vXJp2R9GxnHy0eNPU5n
   u6T3UmMLAPHgg0g5IUrFdjblHLcF7oRJeVKFWmmrkn7upSQZh9kqFEs+/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475019328"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475019328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092792340"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092792340"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2023 10:45:16 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qybko-0001jL-1F;
        Thu, 02 Nov 2023 17:45:14 +0000
Date:   Fri, 3 Nov 2023 01:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chester Lin <clin@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>
Subject: drivers/pinctrl/nxp/pinctrl-s32cc.c:830:62: warning: '%u' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 5
Message-ID: <202311030159.iyUGjNGF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chester,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: fd84aaa8173d3ff86f8df2009921336a1ea53a8a pinctrl: add NXP S32 SoC family support
date:   8 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231103/202311030159.iyUGjNGF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030159.iyUGjNGF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030159.iyUGjNGF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/nxp/pinctrl-s32cc.c: In function 's32_pinctrl_probe_dt':
>> drivers/pinctrl/nxp/pinctrl-s32cc.c:830:62: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 5 [-Wformat-truncation=]
     830 |                          sizeof(ipctl->regions[i].name), "map%u", i);
         |                                                              ^~
   drivers/pinctrl/nxp/pinctrl-s32cc.c:830:58: note: directive argument in the range [0, 4294967294]
     830 |                          sizeof(ipctl->regions[i].name), "map%u", i);
         |                                                          ^~~~~~~
   drivers/pinctrl/nxp/pinctrl-s32cc.c:829:17: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
     829 |                 snprintf(ipctl->regions[i].name,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     830 |                          sizeof(ipctl->regions[i].name), "map%u", i);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +830 drivers/pinctrl/nxp/pinctrl-s32cc.c

   796	
   797	static int s32_pinctrl_probe_dt(struct platform_device *pdev,
   798					struct s32_pinctrl *ipctl)
   799	{
   800		struct s32_pinctrl_soc_info *info = ipctl->info;
   801		struct device_node *np = pdev->dev.of_node;
   802		struct device_node *child;
   803		struct resource *res;
   804		struct regmap *map;
   805		void __iomem *base;
   806		int mem_regions = info->mem_regions;
   807		u32 nfuncs = 0;
   808		u32 i = 0;
   809	
   810		if (!np)
   811			return -ENODEV;
   812	
   813		if (mem_regions == 0) {
   814			dev_err(&pdev->dev, "mem_regions is 0\n");
   815			return -EINVAL;
   816		}
   817	
   818		ipctl->regions = devm_kzalloc(&pdev->dev,
   819					      mem_regions * sizeof(*(ipctl->regions)),
   820					      GFP_KERNEL);
   821		if (!ipctl->regions)
   822			return -ENOMEM;
   823	
   824		for (i = 0; i < mem_regions; ++i) {
   825			base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
   826			if (IS_ERR(base))
   827				return PTR_ERR(base);
   828	
   829			snprintf(ipctl->regions[i].name,
 > 830				 sizeof(ipctl->regions[i].name), "map%u", i);
   831	
   832			s32_regmap_config.name = ipctl->regions[i].name;
   833			s32_regmap_config.max_register = resource_size(res) -
   834							 s32_regmap_config.reg_stride;
   835	
   836			map = devm_regmap_init_mmio(&pdev->dev, base,
   837							&s32_regmap_config);
   838			if (IS_ERR(map)) {
   839				dev_err(&pdev->dev, "Failed to init regmap[%u]\n", i);
   840				return PTR_ERR(map);
   841			}
   842	
   843			ipctl->regions[i].map = map;
   844			ipctl->regions[i].pin_range = &info->mem_pin_ranges[i];
   845		}
   846	
   847		nfuncs = of_get_child_count(np);
   848		if (nfuncs <= 0) {
   849			dev_err(&pdev->dev, "no functions defined\n");
   850			return -EINVAL;
   851		}
   852	
   853		info->nfunctions = nfuncs;
   854		info->functions = devm_kzalloc(&pdev->dev,
   855					       nfuncs * sizeof(struct s32_pmx_func),
   856					       GFP_KERNEL);
   857		if (!info->functions)
   858			return -ENOMEM;
   859	
   860		info->ngroups = 0;
   861		for_each_child_of_node(np, child)
   862			info->ngroups += of_get_child_count(child);
   863		info->groups = devm_kzalloc(&pdev->dev,
   864					    info->ngroups * sizeof(struct s32_pin_group),
   865					    GFP_KERNEL);
   866		if (!info->groups)
   867			return -ENOMEM;
   868	
   869		i = 0;
   870		for_each_child_of_node(np, child)
   871			s32_pinctrl_parse_functions(child, info, i++);
   872	
   873		return 0;
   874	}
   875	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
