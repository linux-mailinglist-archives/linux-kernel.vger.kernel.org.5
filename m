Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA07996AC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbjIIHI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIIHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD111BF9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694243330; x=1725779330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xv5T9WSZWFjttBhAsH3tfPxJ2gOPx23bW1Cl+jZpRX0=;
  b=DJ29IaFVHETidL+epREMvo8W4D/qYH5jG167LyClYNnJf5temHkqKz1x
   ddDk957Dm9DRE/XmNOkwRkUM/9whhC23769GdGrleMewJ5QRPkmTGfCsr
   +CbP30hZeGQSBGshQQic5lBVVJ/H0ELSX6ZsC3OBS5JZfvTVE6lKEJrtR
   raB4YYrTwaePMgw9QZsJhSoLhgyauirT67s2d/1jI2X25uatxBJeKMGx1
   FzRv0Jdh1KEdEu2wb3VcoUK4OoNDqf+2dSNx2R+Y/gGJ7k+qJzYMYsfUT
   WHI8WGQZ5tGfW5t0mHb0hKl4GxVAlsltu5sYnTincsa3Q3Jv5LNBlYEL+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="375173697"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="375173697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 00:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="1073563936"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="1073563936"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2023 00:08:48 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qes5G-00032j-10;
        Sat, 09 Sep 2023 07:08:46 +0000
Date:   Sat, 9 Sep 2023 15:07:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Stefan Kristiansson <stefank@nvidia.com>
Subject: drivers/soc/tegra/pmc.c:467: warning: Function parameter or member
 'syscore' not described in 'tegra_pmc'
Message-ID: <202309091552.Brm1Esmk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petlozu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 1ddb8f6d44ff482c9953a06f800453bc372cfead soc/tegra: pmc: Fix dual edge triggered wakes
date:   10 months ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091552.Brm1Esmk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091552.Brm1Esmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091552.Brm1Esmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/tegra/pmc.c:467: warning: Function parameter or member 'syscore' not described in 'tegra_pmc'


vim +467 drivers/soc/tegra/pmc.c

5f84bb1a4099e26 Sandipan Patra       2018-10-24  383  
7232398abc6a718 Thierry Reding       2014-07-11  384  /**
7232398abc6a718 Thierry Reding       2014-07-11  385   * struct tegra_pmc - NVIDIA Tegra PMC
35b67291b4a85d3 Jon Hunter           2015-12-04  386   * @dev: pointer to PMC device structure
7232398abc6a718 Thierry Reding       2014-07-11  387   * @base: pointer to I/O remapped register region
bbe5af60041cae1 Thierry Reding       2019-01-25  388   * @wake: pointer to I/O remapped region for WAKE registers
bbe5af60041cae1 Thierry Reding       2019-01-25  389   * @aotag: pointer to I/O remapped region for AOTAG registers
bbe5af60041cae1 Thierry Reding       2019-01-25  390   * @scratch: pointer to I/O remapped region for scratch registers
7232398abc6a718 Thierry Reding       2014-07-11  391   * @clk: pointer to pclk clock
35b67291b4a85d3 Jon Hunter           2015-12-04  392   * @soc: pointer to SoC data structure
e247deae1a55089 Mikko Perttunen      2019-01-25  393   * @tz_only: flag specifying if the PMC can only be accessed via TrustZone
3195ac6d9cbeef2 Jon Hunter           2015-12-04  394   * @debugfs: pointer to debugfs entry
7232398abc6a718 Thierry Reding       2014-07-11  395   * @rate: currently configured rate of pclk
7232398abc6a718 Thierry Reding       2014-07-11  396   * @suspend_mode: lowest suspend mode available
7232398abc6a718 Thierry Reding       2014-07-11  397   * @cpu_good_time: CPU power good time (in microseconds)
7232398abc6a718 Thierry Reding       2014-07-11  398   * @cpu_off_time: CPU power off time (in microsecends)
7232398abc6a718 Thierry Reding       2014-07-11  399   * @core_osc_time: core power good OSC time (in microseconds)
7232398abc6a718 Thierry Reding       2014-07-11  400   * @core_pmu_time: core power good PMU time (in microseconds)
7232398abc6a718 Thierry Reding       2014-07-11  401   * @core_off_time: core power off time (in microseconds)
7232398abc6a718 Thierry Reding       2014-07-11  402   * @corereq_high: core power request is active-high
7232398abc6a718 Thierry Reding       2014-07-11  403   * @sysclkreq_high: system clock request is active-high
7232398abc6a718 Thierry Reding       2014-07-11  404   * @combined_req: combined power request for CPU & core
7232398abc6a718 Thierry Reding       2014-07-11  405   * @cpu_pwr_good_en: CPU power good signal is enabled
7232398abc6a718 Thierry Reding       2014-07-11  406   * @lp0_vec_phys: physical base address of the LP0 warm boot code
7232398abc6a718 Thierry Reding       2014-07-11  407   * @lp0_vec_size: size of the LP0 warm boot code
a38045121bf4211 Jon Hunter           2016-03-30  408   * @powergates_available: Bitmap of available power gates
7232398abc6a718 Thierry Reding       2014-07-11  409   * @powergates_lock: mutex for power gate register access
bbe5af60041cae1 Thierry Reding       2019-01-25  410   * @pctl_dev: pin controller exposed by the PMC
bbe5af60041cae1 Thierry Reding       2019-01-25  411   * @domain: IRQ domain provided by the PMC
bbe5af60041cae1 Thierry Reding       2019-01-25  412   * @irq: chip implementation for the IRQ domain
e57a243f5d896f0 Dmitry Osipenko      2019-09-26  413   * @clk_nb: pclk clock changes handler
d3a20dcbca4880a Thierry Reding       2022-05-06  414   * @core_domain_state_synced: flag marking the core domain's state as synced
d3a20dcbca4880a Thierry Reding       2022-05-06  415   * @core_domain_registered: flag marking the core domain as registered
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  416   * @wake_type_level_map: Bitmap indicating level type for non-dual edge wakes
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  417   * @wake_type_dual_edge_map: Bitmap indicating if a wake is dual-edge or not
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  418   * @wake_sw_status_map: Bitmap to hold raw status of wakes without mask
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  419   * @wake_cntrl_level_map: Bitmap to hold wake levels to be programmed in
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  420   *     cntrl register associated with each wake during system suspend.
7232398abc6a718 Thierry Reding       2014-07-11  421   */
7232398abc6a718 Thierry Reding       2014-07-11  422  struct tegra_pmc {
3568df3d31d62b4 Mikko Perttunen      2015-01-06  423  	struct device *dev;
7232398abc6a718 Thierry Reding       2014-07-11  424  	void __iomem *base;
c641ec6eab8587a Thierry Reding       2017-08-30  425  	void __iomem *wake;
c641ec6eab8587a Thierry Reding       2017-08-30  426  	void __iomem *aotag;
5be2255676bf2bc Thierry Reding       2017-08-30  427  	void __iomem *scratch;
7232398abc6a718 Thierry Reding       2014-07-11  428  	struct clk *clk;
3195ac6d9cbeef2 Jon Hunter           2015-12-04  429  	struct dentry *debugfs;
7232398abc6a718 Thierry Reding       2014-07-11  430  
7232398abc6a718 Thierry Reding       2014-07-11  431  	const struct tegra_pmc_soc *soc;
e247deae1a55089 Mikko Perttunen      2019-01-25  432  	bool tz_only;
7232398abc6a718 Thierry Reding       2014-07-11  433  
7232398abc6a718 Thierry Reding       2014-07-11  434  	unsigned long rate;
7232398abc6a718 Thierry Reding       2014-07-11  435  
7232398abc6a718 Thierry Reding       2014-07-11  436  	enum tegra_suspend_mode suspend_mode;
7232398abc6a718 Thierry Reding       2014-07-11  437  	u32 cpu_good_time;
7232398abc6a718 Thierry Reding       2014-07-11  438  	u32 cpu_off_time;
7232398abc6a718 Thierry Reding       2014-07-11  439  	u32 core_osc_time;
7232398abc6a718 Thierry Reding       2014-07-11  440  	u32 core_pmu_time;
7232398abc6a718 Thierry Reding       2014-07-11  441  	u32 core_off_time;
7232398abc6a718 Thierry Reding       2014-07-11  442  	bool corereq_high;
7232398abc6a718 Thierry Reding       2014-07-11  443  	bool sysclkreq_high;
7232398abc6a718 Thierry Reding       2014-07-11  444  	bool combined_req;
7232398abc6a718 Thierry Reding       2014-07-11  445  	bool cpu_pwr_good_en;
7232398abc6a718 Thierry Reding       2014-07-11  446  	u32 lp0_vec_phys;
7232398abc6a718 Thierry Reding       2014-07-11  447  	u32 lp0_vec_size;
a38045121bf4211 Jon Hunter           2016-03-30  448  	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
7232398abc6a718 Thierry Reding       2014-07-11  449  
7232398abc6a718 Thierry Reding       2014-07-11  450  	struct mutex powergates_lock;
4a37f11c8f57ffd Aapo Vienamo         2018-08-10  451  
4a37f11c8f57ffd Aapo Vienamo         2018-08-10  452  	struct pinctrl_dev *pctl_dev;
19906e6b1667217 Thierry Reding       2018-09-17  453  
19906e6b1667217 Thierry Reding       2018-09-17  454  	struct irq_domain *domain;
19906e6b1667217 Thierry Reding       2018-09-17  455  	struct irq_chip irq;
e57a243f5d896f0 Dmitry Osipenko      2019-09-26  456  
e57a243f5d896f0 Dmitry Osipenko      2019-09-26  457  	struct notifier_block clk_nb;
41bafa698ddd075 Dmitry Osipenko      2021-06-01  458  
41bafa698ddd075 Dmitry Osipenko      2021-06-01  459  	bool core_domain_state_synced;
41bafa698ddd075 Dmitry Osipenko      2021-06-01  460  	bool core_domain_registered;
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  461  
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  462  	unsigned long *wake_type_level_map;
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  463  	unsigned long *wake_type_dual_edge_map;
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  464  	unsigned long *wake_sw_status_map;
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  465  	unsigned long *wake_cntrl_level_map;
1ddb8f6d44ff482 Petlozu Pravareshwar 2022-09-30  466  	struct syscore_ops syscore;
7232398abc6a718 Thierry Reding       2014-07-11 @467  };
7232398abc6a718 Thierry Reding       2014-07-11  468  

:::::: The code at line 467 was first introduced by commit
:::::: 7232398abc6a7186e315425638c367d50c674718 ARM: tegra: Convert PMC to a driver

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
