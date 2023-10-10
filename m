Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F07BF7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJJJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjJJJn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952F94;
        Tue, 10 Oct 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696931034; x=1728467034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABVJ/HsrIXFckFMfaqVuY7HMZK5cmb/9vsBsVL3RHYs=;
  b=W96m1l9n++shi4kt77FVrzChWWCbJlRDax8I1u+xHCEm/m+zzfDn21cu
   P2AE7/tgLK4AGfoV0xX0Lqnzn0iDCMzz+NuUXltV+YuPLGic2yntU8lna
   h0Vd54Xil3X8cZWRxFXsdOVEwdf9dMBf9GDKqCyfWzKTK5bhOy+XOLlDZ
   Rj+GnhzW6I+0+WYK+iBPHTStE09V1URbTgV0ROpr1nncV9wLf3mf/X2sR
   ysGu5gQsBW6giEqy0dY5YmoMVF/OGfgziGNlO2HCUceN32FJpcO4BAkD5
   c4B/uqH7jxUxbsdUNrj/AUZxBijrZVOuPMdc8Jl0hoYACqvBWd7youvbm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="388220620"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="388220620"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="730020342"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="730020342"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2023 02:43:32 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq9H0-0000Es-1F;
        Tue, 10 Oct 2023 09:43:30 +0000
Date:   Tue, 10 Oct 2023 17:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, treding@nvidia.com,
        jonathanh@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com
Subject: Re: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <202310101725.z21V2yNG-lkp@intel.com>
References: <20231009171839.12267-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009171839.12267-3-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on next-20231010]
[cannot apply to linus/master v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20231010-012229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231009171839.12267-3-sumitg%40nvidia.com
patch subject: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231010/202310101725.z21V2yNG-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101725.z21V2yNG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101725.z21V2yNG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/sysctl.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: kernel/power/main.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/core.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/platform.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/cpu.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/property.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/cacheinfo.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/base/power/common.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here
   ld: drivers/input/mouse/synaptics.o: in function `acpi_thermal_cpufreq_pctg':
>> include/linux/acpi.h:1546: multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:include/linux/acpi.h:1546: first defined here


vim +1546 include/linux/acpi.h

  1541	
  1542	#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
  1543	int acpi_thermal_cpufreq_pctg(void);
  1544	#else
  1545	inline int acpi_thermal_cpufreq_pctg(void)
> 1546	{
  1547		return 0;
  1548	}
  1549	#endif
  1550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
