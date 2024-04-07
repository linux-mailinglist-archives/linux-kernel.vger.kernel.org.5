Return-Path: <linux-kernel+bounces-134619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A756189B3BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA01F211B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DD3D0C2;
	Sun,  7 Apr 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX2c2muy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870533E46D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712516969; cv=none; b=T+5uYcBYEWEU3QHAfczohOa9QIntv+uzYSEka9y5cSd/XoHyc3oT6E1uP2WRRXk2D2yhDoA9oCUa17wNQ4ZUw3lBms5xrNsejQ7rm+c+fXsrFC+IHJg7SkgmPHulC+dftLeqnXS5l4ldrlEo47gwT4acb6jgFrk2L2Ch4JpAUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712516969; c=relaxed/simple;
	bh=m92H+RqfQ9mb3vbd1IC/3x+9MfBepslHSeyETYln7fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbyI83Axark7nVJosGX9fQ6kussp+5ileKj5XhJqpmDtYRVbZMyiITIVIAwGZNEmdIoLcZiEaRafOhzLqiLzNcoheHo8OoE9llL836P+6WsKfbvi4fL248KPakCh4vvSupZi6UVeGWLebl/j6avjJihecaP0qFjnidl7/fjHAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX2c2muy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712516967; x=1744052967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m92H+RqfQ9mb3vbd1IC/3x+9MfBepslHSeyETYln7fk=;
  b=lX2c2muyADub6meOqwOvoxOV5a9x16m0wyUhJYXve1P8uBW8dmq40PvW
   oDm0SzPl7Do+CRdZ3KTOU+/Xrb4dEqzBjha0cb7c2oO0xjBHQ5iKvKXpx
   giqjJOigoxANy/s+R3IXipF8XC5mh7dv2IfPMI4jtS/gGE3+wgb1xL2PU
   ObCdKbor0GGOb0Z2OIpviKiF+kkAoYIQXSWAiR1VKTiDupvKzr/sdC5Y5
   YKzjU6l5HgX77zj9zmULzR2xutI89rv+ptifOhiq+v9fM4cuB1c3eD0b6
   CBMMXrp04LmNO0Ce7k70H+IK2HgYdydIslbmMkKcvWFPBuRhsgTotEkqE
   A==;
X-CSE-ConnectionGUID: eo4ANJR4R7+OGz1yO7vsnA==
X-CSE-MsgGUID: 3g0a83I1SMCd70KY8HyTWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7696569"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7696569"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:09:26 -0700
X-CSE-ConnectionGUID: t+GayMmgS4qRNwRIJpmK7w==
X-CSE-MsgGUID: QnGy3/ugQraVpknPRD9rtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19539680"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Apr 2024 12:09:24 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtXtJ-0004YU-0m;
	Sun, 07 Apr 2024 19:09:21 +0000
Date: Mon, 8 Apr 2024 03:09:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/5] sched: Split out kernel/sched/syscalls.c from
 kernel/sched/core.c
Message-ID: <202404080226.2qQ925j2-lkp@intel.com>
References: <20240407084319.1462211-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407084319.1462211-2-mingo@kernel.org>

Hi Ingo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linux/master linus/master peterz-queue/sched/core v6.9-rc2 next-20240405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/sched-Split-out-kernel-sched-syscalls-c-from-kernel-sched-core-c/20240407-164646
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240407084319.1462211-2-mingo%40kernel.org
patch subject: [PATCH 1/5] sched: Split out kernel/sched/syscalls.c from kernel/sched/core.c
config: i386-randconfig-061-20240408 (https://download.01.org/0day-ci/archive/20240408/202404080226.2qQ925j2-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240408/202404080226.2qQ925j2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404080226.2qQ925j2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/syscalls.c:197:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:197:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:197:22: sparse:    struct task_struct *
   kernel/sched/syscalls.c: note: in included file:
   kernel/sched/sched.h:2172:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2172:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2172:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2172:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2172:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2172:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2344:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2344:9: sparse:    struct task_struct *
   kernel/sched/syscalls.c:1228:5: sparse: sparse: context imbalance in 'dl_task_check_affinity' - wrong count at exit
   kernel/sched/syscalls.c:1331:9: sparse: sparse: context imbalance in 'sched_setaffinity' - different lock contexts for basic block
   kernel/sched/syscalls.c:1393:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit

vim +197 kernel/sched/syscalls.c

   186	
   187	/**
   188	 * idle_cpu - is a given CPU idle currently?
   189	 * @cpu: the processor in question.
   190	 *
   191	 * Return: 1 if the CPU is currently idle. 0 otherwise.
   192	 */
   193	int idle_cpu(int cpu)
   194	{
   195		struct rq *rq = cpu_rq(cpu);
   196	
 > 197		if (rq->curr != rq->idle)
   198			return 0;
   199	
   200		if (rq->nr_running)
   201			return 0;
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

