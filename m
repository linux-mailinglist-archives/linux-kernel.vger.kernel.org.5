Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC95C7F8D14
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKYSXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjKYSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:23:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA22D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700936632; x=1732472632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ix/ZA2M2AcV+mEFiVP+jQf9Ly9wDAtJX8kkc6F1m/4E=;
  b=kG9FFwG/4ob1MQKFWbMx9+iUZEDRIil7YCrQMWDQbz8vOCf6lD23TzPj
   qYxrm3q+tg0syMYnXCN/ckN1BELPQYu3LC9S7CEkhG69HZCOEC/+LLWAc
   9kZRBq114N9OY72aNOiWHh30/BbA2MeCS7xiHCmsKAlw9CTjQdOuTiqzI
   RXvbqBF44LPvA8rvMlgzvP6eA2GZ3CJDK02jsApxSMIYRwAaR46HOD3Jg
   TXljouN7BmRH3++YRQAACpDlA+P++OlzUTko+AKkZZS+RevYrmZQLWzmJ
   A5Ttj8v79L643oxEeUJRvrdLI7JMAE4Xxm/O8Jd0XrSD27vfLIzhEIuWI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="389682698"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="389682698"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 10:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="885559548"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="885559548"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Nov 2023 10:23:50 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6xJk-0004Ik-2W;
        Sat, 25 Nov 2023 18:23:48 +0000
Date:   Sun, 26 Nov 2023 02:22:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found
 for parameter 'xlate_clkctrl'
Message-ID: <202311260151.b1ciS4X3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
commit: 70f05be3213393f20f01e4d59625df7ee49fe32f ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available
date:   6 years ago
config: arm-randconfig-001-20231123 (https://download.01.org/0day-ci/archive/20231126/202311260151.b1ciS4X3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311260151.b1ciS4X3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311260151.b1ciS4X3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'wait_target_ready'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'assert_hardreset'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'deassert_hardreset'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'is_hardreset_asserted'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'init_clkdm'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'update_context_lost'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'get_context_lost'
   arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'disable_direct_prcm'
>> arch/arm/mach-omap2/omap_hwmod.c:228: warning: No description found for parameter 'xlate_clkctrl'
   arch/arm/mach-omap2/omap_hwmod.c:583: warning: No description found for parameter 'v'
   arch/arm/mach-omap2/omap_hwmod.c:616: warning: No description found for parameter 'v'
   arch/arm/mach-omap2/omap_hwmod.c:670: warning: No description found for parameter 'init_oh'
   arch/arm/mach-omap2/omap_hwmod.c:699: warning: No description found for parameter 'init_oh'
   arch/arm/mach-omap2/omap_hwmod.c:1128: warning: No description found for parameter 'os'
   arch/arm/mach-omap2/omap_hwmod.c:1128: warning: Excess function parameter 'oh' description in '_count_ocp_if_addr_spaces'
   arch/arm/mach-omap2/omap_hwmod.c:2446: warning: No description found for parameter 'data'
   arch/arm/mach-omap2/omap_hwmod.c:2446: warning: Excess function parameter 'n' description in '_init'
   arch/arm/mach-omap2/omap_hwmod.c:2644: warning: No description found for parameter 'data'
   arch/arm/mach-omap2/omap_hwmod.c:2644: warning: Excess function parameter 'n' description in '_setup'


vim +/xlate_clkctrl +228 arch/arm/mach-omap2/omap_hwmod.c

70f05be3213393 Tero Kristo    2017-05-31  202  
9ebfd285371835 Kevin Hilman   2012-06-18  203  /**
9ebfd285371835 Kevin Hilman   2012-06-18  204   * struct omap_hwmod_soc_ops - fn ptrs for some SoC-specific operations
9ebfd285371835 Kevin Hilman   2012-06-18  205   * @enable_module: function to enable a module (via MODULEMODE)
9ebfd285371835 Kevin Hilman   2012-06-18  206   * @disable_module: function to disable a module (via MODULEMODE)
9ebfd285371835 Kevin Hilman   2012-06-18  207   *
9ebfd285371835 Kevin Hilman   2012-06-18  208   * XXX Eventually this functionality will be hidden inside the PRM/CM
9ebfd285371835 Kevin Hilman   2012-06-18  209   * device drivers.  Until then, this should avoid huge blocks of cpu_is_*()
9ebfd285371835 Kevin Hilman   2012-06-18  210   * conditionals in this code.
9ebfd285371835 Kevin Hilman   2012-06-18  211   */
9ebfd285371835 Kevin Hilman   2012-06-18  212  struct omap_hwmod_soc_ops {
9ebfd285371835 Kevin Hilman   2012-06-18  213  	void (*enable_module)(struct omap_hwmod *oh);
9ebfd285371835 Kevin Hilman   2012-06-18  214  	int (*disable_module)(struct omap_hwmod *oh);
8f6aa8ee114fb5 Kevin Hilman   2012-06-18  215  	int (*wait_target_ready)(struct omap_hwmod *oh);
b8249cf2d2b16d Kevin Hilman   2012-06-18  216  	int (*assert_hardreset)(struct omap_hwmod *oh,
b8249cf2d2b16d Kevin Hilman   2012-06-18  217  				struct omap_hwmod_rst_info *ohri);
b8249cf2d2b16d Kevin Hilman   2012-06-18  218  	int (*deassert_hardreset)(struct omap_hwmod *oh,
b8249cf2d2b16d Kevin Hilman   2012-06-18  219  				  struct omap_hwmod_rst_info *ohri);
b8249cf2d2b16d Kevin Hilman   2012-06-18  220  	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
b8249cf2d2b16d Kevin Hilman   2012-06-18  221  				     struct omap_hwmod_rst_info *ohri);
0a179eaa436e58 Kevin Hilman   2012-06-18  222  	int (*init_clkdm)(struct omap_hwmod *oh);
e6d3a8b0bdcd8f Rajendra Nayak 2012-11-21  223  	void (*update_context_lost)(struct omap_hwmod *oh);
e6d3a8b0bdcd8f Rajendra Nayak 2012-11-21  224  	int (*get_context_lost)(struct omap_hwmod *oh);
9fabc1a26e37f8 Tero Kristo    2016-07-04  225  	int (*disable_direct_prcm)(struct omap_hwmod *oh);
70f05be3213393 Tero Kristo    2017-05-31  226  	u32 (*xlate_clkctrl)(struct omap_hwmod *oh,
70f05be3213393 Tero Kristo    2017-05-31  227  			     struct clkctrl_provider *provider);
9ebfd285371835 Kevin Hilman   2012-06-18 @228  };
9ebfd285371835 Kevin Hilman   2012-06-18  229  

:::::: The code at line 228 was first introduced by commit
:::::: 9ebfd285371835b1c0243d15aaacd72d5def76f8 ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable module

:::::: TO: Kevin Hilman <khilman@ti.com>
:::::: CC: Paul Walmsley <paul@pwsan.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
