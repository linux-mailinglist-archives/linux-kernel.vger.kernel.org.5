Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5881479F7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjINCK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjINCKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BD3591;
        Wed, 13 Sep 2023 19:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694657387; x=1726193387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSQkTceluSnPVGEvmSOHQLuZ2d6CUEkWNEeZbE/Eqr4=;
  b=AxS6IYqV38WGEXorBlR8BTWMd/wdUZwto3STzE+iDPXw/gy8POXUDHkv
   nb+U66l5qv8DG660JekGOfzCVFSyiz4UFs1txqcS+ElO5/JylC++HUYO0
   QteYsoaPa8heM5OMP/m0Rr8sYmOW6fXo0oNOXCLs6fPqHyCKJO4HrWUBV
   NAH0aeCZMOSauQVAzJXVFTeWHkEgzfWwSGqsGqGsXFH/fJG+X7ykJYmju
   +YJB8OFkS+9LUCaFJkT6SxWinUkWhYe04GQnOogCnEjYocTcdEVGOxzZh
   P0i2+1Xe2XVov3nvySP5ZMEjXK8ss4v8FX+t080PdC8nBjXr0dSBYFu5f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442862982"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="442862982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 19:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859516489"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="859516489"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2023 19:09:39 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgbnV-0000yz-0B;
        Thu, 14 Sep 2023 02:09:37 +0000
Date:   Thu, 14 Sep 2023 10:09:23 +0800
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
Message-ID: <202309140915.2J9OzWIZ-lkp@intel.com>
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
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140915.2J9OzWIZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140915.2J9OzWIZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/processor_thermal.c:141:6: warning: no previous declaration for 'acpi_thermal_cpufreq_config_nvidia' [-Wmissing-declarations]
    void acpi_thermal_cpufreq_config_nvidia(void)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
