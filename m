Return-Path: <linux-kernel+bounces-134639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4089B3FD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42BF28184E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41744C71;
	Sun,  7 Apr 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpslVSHC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104434437C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521354; cv=none; b=TI5Idj8mI8BlTSoe0WK7fIa8pWCgi9f1SKYFjeI3Ln4YBf3U8FjUG5lXBX5vz9bMURdXUwSi6H/ZWXoPvBQ8zSIKAsJf7Vev0vZAqInHbZFqMD1voSW3ybJwKnffsTj68FXUDT2Z8t5inTy/dizWucbYLsMCqfosRncMwesX+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521354; c=relaxed/simple;
	bh=A39JcqeuMcbaMXEjgSo1Q8OoByBxpCxVXXnv3GoVRzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzrABoHiuGp5zguoGlmsfOk0f7vnkrOAv4sq23y8bJJXP4FKvZM8FgAFJNYgz+ygJsbklcoEBeltfeXAr2ZvEjNKSgUjvmM27r4NYGjHLhsJBSzFggNyJY/JH0EC/WTnDdYe1xlYoznIAtg4N1rI76IC0TIT7FxckR3RmKLw3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpslVSHC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712521352; x=1744057352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A39JcqeuMcbaMXEjgSo1Q8OoByBxpCxVXXnv3GoVRzA=;
  b=PpslVSHCbr49B79dfJL7tCgXoHrqpkXjYrUB4f+RdNIl4goUJPBgPdbj
   +6ooy89d6PRPPmYjLij1x8V2nPFFKTIjbm2XOzbG1QmJjpuC2+w4sZSlk
   EDK09NaVkh0rUbGOY/QXyqKQN0kRPRRo1obLCpJETQ8VC/HCKprm6AQN9
   1V5WFXg472rgIy5pQMb8/lmu0QRKe1Va2lwkVcyvuSY2AVAsNwtxwBtvl
   RAEEr5tZd9DMesfastJ4FNPlbJnQxQD8pCAiLmIpwyvHRDHE6a9D82m+o
   Ncst44hCBmQy9Fjrz1cWhfjOMfx+g+LgemQduKuEQn/Kfl+bZZOolpm5T
   Q==;
X-CSE-ConnectionGUID: WkO5BkaDSQqz6V5YOpOAzw==
X-CSE-MsgGUID: nBnDEFBhR3WigrJQmVroGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19160674"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19160674"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 13:22:28 -0700
X-CSE-ConnectionGUID: lqs7wn7TQE2//drwd+sQhw==
X-CSE-MsgGUID: VtbaV3g8S7KRE28JKZ4kLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="50891408"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2024 13:22:26 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtZ20-0004ac-0E;
	Sun, 07 Apr 2024 20:22:24 +0000
Date: Mon, 8 Apr 2024 04:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from
 kernel/sched/fair.c
Message-ID: <202404080450.8XHvarcZ-lkp@intel.com>
References: <20240407084319.1462211-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407084319.1462211-3-mingo@kernel.org>

Hi Ingo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on next-20240405]
[cannot apply to linux/master linus/master peterz-queue/sched/core v6.9-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/sched-Split-out-kernel-sched-syscalls-c-from-kernel-sched-core-c/20240407-164646
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240407084319.1462211-3-mingo%40kernel.org
patch subject: [PATCH 2/5] sched: Split out kernel/sched/fair_balance.c from kernel/sched/fair.c
config: i386-randconfig-061-20240408 (https://download.01.org/0day-ci/archive/20240408/202404080450.8XHvarcZ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240408/202404080450.8XHvarcZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404080450.8XHvarcZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/fair_balance.c:2171:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair_balance.c:2171:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair_balance.c:2171:40: sparse:     got struct sched_domain [noderef] __rcu *child
>> kernel/sched/fair_balance.c:2793:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair_balance.c:2793:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair_balance.c:2793:22: sparse:    struct task_struct *
>> kernel/sched/fair_balance.c:4218:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair_balance.c:4218:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair_balance.c:4218:9: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/fair_balance.c:3866:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair_balance.c:3866:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair_balance.c:3866:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair_balance.c:4327:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair_balance.c:4327:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair_balance.c:4327:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair_balance.c:4972:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair_balance.c:4972:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair_balance.c:4972:9: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/fair_balance.c:1921:24: sparse: sparse: dereference of noderef expression
   kernel/sched/fair_balance.c:4050:64: sparse: sparse: dereference of noderef expression
   kernel/sched/fair_balance.c:4050:64: sparse: sparse: dereference of noderef expression

vim +2171 kernel/sched/fair_balance.c

  2168	
  2169	void update_group_capacity(struct sched_domain *sd, int cpu)
  2170	{
> 2171		struct sched_domain *child = sd->child;
  2172		struct sched_group *group, *sdg = sd->groups;
  2173		unsigned long capacity, min_capacity, max_capacity;
  2174		unsigned long interval;
  2175	
  2176		interval = msecs_to_jiffies(sd->balance_interval);
  2177		interval = clamp(interval, 1UL, max_load_balance_interval);
  2178		sdg->sgc->next_update = jiffies + interval;
  2179	
  2180		if (!child) {
  2181			update_cpu_capacity(sd, cpu);
  2182			return;
  2183		}
  2184	
  2185		capacity = 0;
  2186		min_capacity = ULONG_MAX;
  2187		max_capacity = 0;
  2188	
  2189		if (child->flags & SD_OVERLAP) {
  2190			/*
  2191			 * SD_OVERLAP domains cannot assume that child groups
  2192			 * span the current group.
  2193			 */
  2194	
  2195			for_each_cpu(cpu, sched_group_span(sdg)) {
  2196				unsigned long cpu_cap = capacity_of(cpu);
  2197	
  2198				capacity += cpu_cap;
  2199				min_capacity = min(cpu_cap, min_capacity);
  2200				max_capacity = max(cpu_cap, max_capacity);
  2201			}
  2202		} else  {
  2203			/*
  2204			 * !SD_OVERLAP domains can assume that child groups
  2205			 * span the current group.
  2206			 */
  2207	
  2208			group = child->groups;
  2209			do {
  2210				struct sched_group_capacity *sgc = group->sgc;
  2211	
  2212				capacity += sgc->capacity;
  2213				min_capacity = min(sgc->min_capacity, min_capacity);
  2214				max_capacity = max(sgc->max_capacity, max_capacity);
  2215				group = group->next;
  2216			} while (group != child->groups);
  2217		}
  2218	
  2219		sdg->sgc->capacity = capacity;
  2220		sdg->sgc->min_capacity = min_capacity;
  2221		sdg->sgc->max_capacity = max_capacity;
  2222	}
  2223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

