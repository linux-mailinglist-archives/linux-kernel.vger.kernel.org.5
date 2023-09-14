Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505779F877
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjINCvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:51:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334B10C3;
        Wed, 13 Sep 2023 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694659906; x=1726195906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEoEyEQ+kZdfM2KYaRFi9MudhQl7uMO52kPJ58tdVVw=;
  b=fLBGxn/C9iYFnVjMjhsNzb1dtoCluZWd9TYXlv6Lw7WPOgHUDXekfVcc
   iWksWbYaiI1CWEKHPdr0KFF8aheMt9GdmEcqJrXaKSaW1gEwJkZ4197CN
   Swe33eLYUzardJ+ZcbA2+bDPv2et6j2bcNrICOoEpoOoTkUplQEP1GLYZ
   Tjjoxmm6W43EfheF10NHswA5BqeaPHQDTbLs9i0lupW02UsagzcBbZQ5J
   noRXyJSCS1le65EAn7BcqCepfiS8V1qK6iFfwGyj//e1sb1/eBbDAyisY
   3P0ezHZxh7FqoCLh3HjkTmL62iupgJ0GtY+u2M/v0HtIeTE0Imv1GfOnv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359099481"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="359099481"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 19:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991223843"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="991223843"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2023 19:51:41 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgcSB-00013o-2S;
        Thu, 14 Sep 2023 02:51:39 +0000
Date:   Thu, 14 Sep 2023 10:51:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        rui.zhang@intel.com, lenb@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, sumitg@nvidia.com,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <202309141006.XkUm1rIu-lkp@intel.com>
References: <20230913164659.9345-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913164659.9345-3-sumitg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20230914-004929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230913164659.9345-3-sumitg%40nvidia.com
patch subject: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230914/202309141006.XkUm1rIu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141006.XkUm1rIu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141006.XkUm1rIu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/processor_thermal.c:141:6: warning: no previous prototype for 'acpi_thermal_cpufreq_config_nvidia' [-Wmissing-prototypes]
     141 | void acpi_thermal_cpufreq_config_nvidia(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_thermal_cpufreq_config_nvidia +141 drivers/acpi/processor_thermal.c

   140	
 > 141	void acpi_thermal_cpufreq_config_nvidia(void)
   142	{
   143	#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
   144		s32 soc_id = arm_smccc_get_soc_id_version();
   145	
   146		/* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
   147		if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
   148			return;
   149	
   150		/* Reduce the CPUFREQ Thermal reduction percentage to 5% */
   151		cpufreq_thermal_pctg = 5;
   152	
   153		/*
   154		 * Derive the MAX_STEP from minimum throttle percentage so that the reduction
   155		 * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
   156		 * the CPU performance doesn't become 0.
   157		 */
   158		cpufreq_thermal_max_step = ((100 / cpufreq_thermal_pctg) - 1);
   159	#endif
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
