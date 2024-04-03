Return-Path: <linux-kernel+bounces-128953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86C896234
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FA828D44F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2B1BC26;
	Wed,  3 Apr 2024 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIkuELiv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B531B946;
	Wed,  3 Apr 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108604; cv=none; b=ufP8YPyghntgRY733KHswZ+UI/uHXEmQhGO5U141u3XEE1M2xG2ROLFy3f9UWbjnqqe7kS93hS1KbFA/zTWa8vY42lBvXvMuzH06tCR66wzRdZxtPYSLkPYi4ZgldiKyoSJcsJkv3kYVJ87Aa4K1TquiRXMg2Ws9/ceBS3DHSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108604; c=relaxed/simple;
	bh=p3/vC/O60cW1sJhdzpZy97xlMwM5ZR+kBSjXW1h82SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q61TZjz+/T66d/N5hSOurYQKTIQgvYcpFj2+dyCZpDjYCRuRQ7sO66GjHo85HmyR3T5O3kbQyPuvamxnKgyLLhP4u2aoHez0QeibLsMugM0AfbKo+oVb9tKahBEpG77HlsR40dVp8F8eSQuVzR4LaODlYtOKsbVkMde9G0yD918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIkuELiv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712108603; x=1743644603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3/vC/O60cW1sJhdzpZy97xlMwM5ZR+kBSjXW1h82SA=;
  b=dIkuELivB2rOLvXIsAPmRN4lZRHY3mW+W3CkUTODf4INYDTh0Rnc4hAv
   BQA76lHlkNu5lIDJqGkNG22eeIesEQ5PM/Om3xCXj3Buh1FVvOw0zOZ0g
   dDfXCj1iRqo03JAU/E2Rb7uwN1MCcfe5i+bW6zLWnNBAdIHyiVsgYWtdh
   atcFFVYlNSI8i+ayYPv89OZc37P/WvJ3NGdkPa5+f5AdvTKc68SEVWuGy
   NSd+07IA4OM9E+lVnKMmthlS4q83A2Ry5nOSocC7kNajD1m5gtAgZp/Xs
   9aD3tmTBeGAs2t3Bjw5vuW4GUgshnZ/DCN6RPzn6MaPyRP/j6Nr7B+zD6
   g==;
X-CSE-ConnectionGUID: WudfhBrsQayYf1vdWyvLtA==
X-CSE-MsgGUID: 4eWWiqt5SamwosdhGOmz/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18681604"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18681604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:43:22 -0700
X-CSE-ConnectionGUID: qRADzWEaS/e9qI/jWWDl5Q==
X-CSE-MsgGUID: YMNiNCojRiCWuS+4okXJsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22901528"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2024 18:43:19 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrpem-0001k5-2a;
	Wed, 03 Apr 2024 01:43:16 +0000
Date: Wed, 3 Apr 2024 09:43:08 +0800
From: kernel test robot <lkp@intel.com>
To: Dawei Li <dawei.li@shingroup.cn>, will@kernel.org, mark.rutland@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Dawei Li <dawei.li@shingroup.cn>
Subject: Re: [PATCH 4/9] perf/arm_dsu: Avoid explicit cpumask var allocation
 from stack
Message-ID: <202404030906.L4BhRzHw-lkp@intel.com>
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
config: arm64-randconfig-001-20240403 (https://download.01.org/0day-ci/archive/20240403/202404030906.L4BhRzHw-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030906.L4BhRzHw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030906.L4BhRzHw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/perf/arm_dsu_pmu.c:243:24: error: incompatible pointer types passing 'cpumask_var_t *' (aka 'struct cpumask **') to parameter of type 'const struct cpumask *'; remove & [-Werror,-Wincompatible-pointer-types]
           ret = cpumask_any_but(&online_supported, cpu);
                                 ^~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:379:52: note: passing argument to parameter 'mask' here
   unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
                                                      ^
   1 error generated.


vim +243 drivers/perf/arm_dsu_pmu.c

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

