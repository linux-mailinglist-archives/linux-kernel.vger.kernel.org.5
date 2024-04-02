Return-Path: <linux-kernel+bounces-128846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DCE89606F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121C22832D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95C15A484;
	Tue,  2 Apr 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEJJa9vz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DA1E531;
	Tue,  2 Apr 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102329; cv=none; b=ZeX5e2AflCteWwqAg4JgIuDAeIXzBHXj9oR/ZSuGRpeMPTVW7GblO6+iYq5mDpqSlE84SkU+biN8RGqp81mgbltoSoZ3+W9vgpkQblMeHkiIpMGCrFxEOtigWm5EbGh7y6SFIgmTcP1NA/HJioidKA73X0I+YxFz7MncWiHB9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102329; c=relaxed/simple;
	bh=AiuyQ6KpY5OwIl/kOANr37LCmsygVJ4gTNLbVO+SnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8Mz8SgTa0E2UkJ0eDOJedvCeO3bqSbLSx+D0tNd5azrNYnjkbm9Ft3qw7hIyjJ3QM8lFYbBuByRIeqg3QA89rtYlU8Ww+3IAR7sshEcj4L0aAPdpE3lSj0E84tbTvzkZ3MRyeuje2D7cmgrZ7h/1WurN7/QjJD0Uo2dWx1iLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEJJa9vz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712102328; x=1743638328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AiuyQ6KpY5OwIl/kOANr37LCmsygVJ4gTNLbVO+SnCQ=;
  b=PEJJa9vzTwI9OfBN9sBgPm5CO2qLoFDVxA205xXP5nV2OHWFQ302z9rt
   T/e3YgKZrKMLTdv5RMho50d8BmYZ+tL63pedt0i9wzxTw6APi6rOmlO7R
   ylYG0+o6E3GUaNqK+Ym2Z/KdCSxar8kS+QFO+uxlHhK+K+IPqC/e6H2bs
   5DLBtNWCHcs1JipEF34W1+7uG2YCGPJuBvBsoY1ZGoM7Um78tK6ZL8Zf1
   9K21RcWn/cmYkBcBiP72A6YHYjY9OkP0Cb08YT/kyQnwv7Hnnn+8FeJyp
   ZXm+tuDznX+TMUCjtWtuf95P9nYu5/+pLsDbVYXtjnWH/OPaham9C+2Dt
   A==;
X-CSE-ConnectionGUID: CcYpB11VRkygaPfiacoOvg==
X-CSE-MsgGUID: 9DhA4FAlSjWyYTRImD9ucA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24800363"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24800363"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 16:58:46 -0700
X-CSE-ConnectionGUID: /0rSqutbSYGezZVceapNnQ==
X-CSE-MsgGUID: lJpG4qfoR8CBvsXJYGdm2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18058838"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Apr 2024 16:58:43 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rro1Y-0001dt-1Y;
	Tue, 02 Apr 2024 23:58:40 +0000
Date: Wed, 3 Apr 2024 07:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dawei Li <dawei.li@shingroup.cn>, will@kernel.org, mark.rutland@arm.com
Cc: oe-kbuild-all@lists.linux.dev, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: Re: [PATCH 4/9] perf/arm_dsu: Avoid explicit cpumask var allocation
 from stack
Message-ID: <202404030702.vL5Ep98R-lkp@intel.com>
References: <20240402105610.1695644-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105610.1695644-5-dawei.li@shingroup.cn>

Hi Dawei,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.9-rc2 next-20240402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dawei-Li/perf-alibaba_uncore_drw-Avoid-explicit-cpumask-var-allocation-from-stack/20240402-192244
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240402105610.1695644-5-dawei.li%40shingroup.cn
patch subject: [PATCH 4/9] perf/arm_dsu: Avoid explicit cpumask var allocation from stack
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240403/202404030702.vL5Ep98R-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030702.vL5Ep98R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030702.vL5Ep98R-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/perf/arm_dsu_pmu.c: In function 'dsu_pmu_get_online_cpu_any_but':
>> drivers/perf/arm_dsu_pmu.c:243:31: error: passing argument 1 of 'cpumask_any_but' from incompatible pointer type [-Werror=incompatible-pointer-types]
     243 |         ret = cpumask_any_but(&online_supported, cpu);
         |                               ^~~~~~~~~~~~~~~~~
         |                               |
         |                               struct cpumask (*)[1]
   In file included from arch/arm64/include/asm/cpufeature.h:26,
                    from arch/arm64/include/asm/ptrace.h:11,
                    from arch/arm64/include/asm/irqflags.h:10,
                    from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/perf/arm_dsu_pmu.c:14:
   include/linux/cpumask.h:379:52: note: expected 'const struct cpumask *' but argument is of type 'struct cpumask (*)[1]'
     379 | unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
         |                              ~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/cpumask_any_but +243 drivers/perf/arm_dsu_pmu.c

   232	
   233	static unsigned int dsu_pmu_get_online_cpu_any_but(struct dsu_pmu *dsu_pmu, int cpu)
   234	{
   235		cpumask_var_t online_supported;
   236		unsigned int ret;
   237	
   238		if (!alloc_cpumask_var(&online_supported, GFP_KERNEL))
   239			return -ENOMEM;
   240	
   241		cpumask_and(online_supported,
   242			    &dsu_pmu->associated_cpus, cpu_online_mask);
 > 243		ret = cpumask_any_but(&online_supported, cpu);
   244	
   245		free_cpumask_var(online_supported);
   246	
   247		return ret;
   248	}
   249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

