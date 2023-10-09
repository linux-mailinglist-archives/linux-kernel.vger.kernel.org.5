Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86947BEA41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378280AbjJITE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377155AbjJITEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:04:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA329D;
        Mon,  9 Oct 2023 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878263; x=1728414263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VcIVbkjldo4NhjDRdGLwRnd1Gsbr7VebFElrMtcM+SQ=;
  b=Gf1yZ1oIFI+E4jiAmiwjwYZ4Y078joufuFe89ldm0ih2knoyqByxmUhf
   drw/wJU0O+CjgPypddS+kVBPCzIHr1vLhtvR2+Pc5Z8L6K70knmviMUER
   UsxaQg89WX3ZP7taG3l7e+nZKBVctzyxCFKeR0MbnzAQzWvz/Kdl+/9jz
   8mMIrNnhEVRjcLEfL5d/KeTWjc2jKsEBU6iP5F08CKFsc2JNgfipK91w9
   8CLBUSU8fgl/ikKhx1Sk2DjkcUJMddAffpeDSkZF7RMHTAooKK0CMkfcu
   o2XyTqWvva3rp7utNw4brRg+9lqEsuLuzFJjq9ycfBVcX3fShJQal0HrQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364515885"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="364515885"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="746783124"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="746783124"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2023 12:03:27 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpvXK-0000Y0-0j;
        Mon, 09 Oct 2023 19:03:26 +0000
Date:   Tue, 10 Oct 2023 03:02:48 +0800
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
Message-ID: <202310100219.lpVzbckv-lkp@intel.com>
References: <20231009171839.12267-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009171839.12267-3-sumitg@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on next-20231009]
[cannot apply to linus/master v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-thermal-Add-Thermal-fast-Sampling-Period-_TFP-support/20231010-012229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231009171839.12267-3-sumitg%40nvidia.com
patch subject: [Patch v4 2/2] ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231010/202310100219.lpVzbckv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100219.lpVzbckv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100219.lpVzbckv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/setup.o: in function `acpi_thermal_cpufreq_pctg':
>> setup.c:(.text+0x3): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/x86_init.o: in function `acpi_thermal_cpufreq_pctg':
   x86_init.c:(.text+0x44): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/i8259.o: in function `acpi_thermal_cpufreq_pctg':
   i8259.c:(.text+0x2dd): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/irqinit.o: in function `acpi_thermal_cpufreq_pctg':
   irqinit.c:(.text+0x0): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/bootflag.o: in function `acpi_thermal_cpufreq_pctg':
   bootflag.c:(.text+0x0): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/e820.o: in function `acpi_thermal_cpufreq_pctg':
   e820.c:(.text+0x144): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/pci-dma.o: in function `acpi_thermal_cpufreq_pctg':
   pci-dma.c:(.text+0x0): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: arch/x86/kernel/process.o: in function `acpi_thermal_cpufreq_pctg':
   process.c:(.text+0xe5): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/sysctl.o: in function `acpi_thermal_cpufreq_pctg':
   sysctl.c:(.text+0x48): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: kernel/dma/mapping.o: in function `acpi_thermal_cpufreq_pctg':
   mapping.c:(.text+0x5ba): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: drivers/base/core.o: in function `acpi_thermal_cpufreq_pctg':
   core.c:(.text+0x13e9): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: drivers/base/platform.o: in function `acpi_thermal_cpufreq_pctg':
   platform.c:(.text+0x8b8): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: drivers/base/cpu.o: in function `acpi_thermal_cpufreq_pctg':
   cpu.c:(.text+0x128): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: drivers/base/property.o: in function `acpi_thermal_cpufreq_pctg':
   property.c:(.text+0xa87): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here
   ld: drivers/base/cacheinfo.o: in function `acpi_thermal_cpufreq_pctg':
   cacheinfo.c:(.text+0x231): multiple definition of `acpi_thermal_cpufreq_pctg'; init/main.o:main.c:(.text+0x32): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
