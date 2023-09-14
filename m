Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66179F997
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjINEkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjINEkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:40:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A971985;
        Wed, 13 Sep 2023 21:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694666401; x=1726202401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TKi52rvlfIoGcPmcOL9hgF/Ozj/+C1T6xU6PAFOkPHA=;
  b=TiiKIr2/s/8H2y11/8cl1ZMeVGCHlYK/NydpkXN+uyCSBDtPxvWuasqv
   2DXNxfH6ekDTB+qkvX4E8aniWDJjP8J9xdk+FmMndR0aqCRuZKAGSxVbJ
   7kDwsEiRf+D0riW3surGx+jU5rAAHXf8jBUqhTpxy1yTRVIZnimi3Wi3f
   ed4ydZoSDOI83ElzDgD+v8azoZFcbvUT1WSVQKU6bdT0oFfj+IWSFlzaA
   TFZt4MABr1W3ElBJoSDEuMwaRjars5WFGe/AA5wUAltVbYlojEQIse1sV
   o6V0mkKljRlimfluh0VqrIWhyMrlibdYHvCXKuMb1ULU2pHfvSjufiAuh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369123211"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="369123211"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 21:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="868097149"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="868097149"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2023 21:39:57 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qge8w-0001AD-35;
        Thu, 14 Sep 2023 04:39:54 +0000
Date:   Thu, 14 Sep 2023 12:39:31 +0800
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
Message-ID: <202309141242.CUDGcSdC-lkp@intel.com>
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
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20230914/202309141242.CUDGcSdC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141242.CUDGcSdC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141242.CUDGcSdC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/processor_thermal.c:141:6: sparse: sparse: symbol 'acpi_thermal_cpufreq_config_nvidia' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
