Return-Path: <linux-kernel+bounces-157835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA498B1701
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC928313C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877516F0DD;
	Wed, 24 Apr 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+2ubWx2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE515747E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000958; cv=none; b=oZiLrHoavYCket/+dn5c3se0FSvv4dQh/ChKk80fBGDqBLrG2y/A5RufP1x+SGCTDdNtPyMgn2uU8KhI1+b8lWAmib2wqbx5AqJ90PQ6px4j903NszCuoSh1yJ/JnYLGhlMpWK3/w7srdQqGlldejZyj4s/79IJ/o1fFbsRkH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000958; c=relaxed/simple;
	bh=Q5D0GlcovYCEkGzpI5doau3iBuWfQWrp9GB4JaXHZz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hpbgkrWshMJkDubqQ6e4Nh9vXG3rfIZhsBiOZ9T7GumpVo86YGgdFAZzEg8ABhA2PRwmLRgjNQ08ml7RgxxkoMyFulVzCF5SBzd5mwtd5LHiujkpqH6hIN0V70EgqLW9D9jZDbMYF2W4ZZg6axvm38RJeaPRAnFV1bjs3ZskHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+2ubWx2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714000957; x=1745536957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5D0GlcovYCEkGzpI5doau3iBuWfQWrp9GB4JaXHZz0=;
  b=h+2ubWx25K6v5WhXL9XaDFX5XErGNfMEuDzupKRjot329WjZgEvYp4GS
   ZEDmKsu67VQDMKH6h+OmdgaDm/Wo/eC0Uv8mK1joxaTcEZ+prZfAwri9R
   5ILn0ToJnNqB5EEQBs+yncGMH34IfVpN1Ko2585nr5kIAIGXWUTlpUWrb
   468xuyRw3z+vzt12ekAFpt+deijSzKEQzHXqsLf5tWGb2vDjyqSwesgk2
   HAiqsFKQdliMvGAmBSwEU8x/RI9wEQnfonzskEgUXWUxiEg4p8gcGCQn9
   QyU76a5sZexJBQfzNDgt57JsiMJwBE6iFBMvMUmFEb/l2vBGmFQAR9DAm
   g==;
X-CSE-ConnectionGUID: yCR1QY2OR1ajHABPER/1Jg==
X-CSE-MsgGUID: whzfIZsVQFWGsaDgwPAFQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27176825"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="27176825"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 16:22:36 -0700
X-CSE-ConnectionGUID: 3rNtiLX+Sxu7T6bFFxkoZw==
X-CSE-MsgGUID: qd+OC7dYSpeeHCT5CYgkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="56047914"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2024 16:22:34 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzlwd-0001lM-2O;
	Wed, 24 Apr 2024 23:22:31 +0000
Date: Thu, 25 Apr 2024 07:22:20 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [tip:sched/core 26/27] drivers/base/arch_topology.c:204:17: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202404250740.VhQQoD7N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vincent,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   97450eb909658573dcacc1063b06d3d08642c0c1
commit: d4dbc991714eefcbd8d54a3204bd77a0a52bd32d [26/27] sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
config: arm64-randconfig-r132-20240425 (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240425/202404250740.VhQQoD7N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *
>> drivers/base/arch_topology.c:204:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   drivers/base/arch_topology.c:204:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/base/arch_topology.c:204:17: sparse:     got unsigned long *

vim +204 drivers/base/arch_topology.c

   164	
   165	/**
   166	 * topology_update_hw_pressure() - Update HW pressure for CPUs
   167	 * @cpus        : The related CPUs for which capacity has been reduced
   168	 * @capped_freq : The maximum allowed frequency that CPUs can run at
   169	 *
   170	 * Update the value of HW pressure for all @cpus in the mask. The
   171	 * cpumask should include all (online+offline) affected CPUs, to avoid
   172	 * operating on stale data when hot-plug is used for some CPUs. The
   173	 * @capped_freq reflects the currently allowed max CPUs frequency due to
   174	 * HW capping. It might be also a boost frequency value, which is bigger
   175	 * than the internal 'capacity_freq_ref' max frequency. In such case the
   176	 * pressure value should simply be removed, since this is an indication that
   177	 * there is no HW throttling. The @capped_freq must be provided in kHz.
   178	 */
   179	void topology_update_hw_pressure(const struct cpumask *cpus,
   180					      unsigned long capped_freq)
   181	{
   182		unsigned long max_capacity, capacity, hw_pressure;
   183		u32 max_freq;
   184		int cpu;
   185	
   186		cpu = cpumask_first(cpus);
   187		max_capacity = arch_scale_cpu_capacity(cpu);
   188		max_freq = arch_scale_freq_ref(cpu);
   189	
   190		/*
   191		 * Handle properly the boost frequencies, which should simply clean
   192		 * the HW pressure value.
   193		 */
   194		if (max_freq <= capped_freq)
   195			capacity = max_capacity;
   196		else
   197			capacity = mult_frac(max_capacity, capped_freq, max_freq);
   198	
   199		hw_pressure = max_capacity - capacity;
   200	
   201		trace_hw_pressure_update(cpu, hw_pressure);
   202	
   203		for_each_cpu(cpu, cpus)
 > 204			WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
   205	}
   206	EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

