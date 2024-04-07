Return-Path: <linux-kernel+bounces-134612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0D89B39C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C5C1C2126F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C93CF4F;
	Sun,  7 Apr 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdGbhHHx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84121DA24
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515769; cv=none; b=TmpjrybazWRq3TyBk/w4Km5W0flaW5nbJ8P01jEDeIybH+HGTGAeEMagdU1drgnb7eWeDmiFPEQDX6A+P2U+ARIf1PtE8euUbKIXDkMq0sjH715I8W36+DN03uLudiK+SsNgH/RN/XFE48w2zGBJN/10ciccovTrIUxqsZQ2d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515769; c=relaxed/simple;
	bh=abTUwIjIEn8CoVDaZCCvWCNQErF+fn/yHr/4f1a/juc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKJjweamt903wa1oeBrPvWRptfBq2EcKKFLAnvaBFBwdze8qa4e0ZMByEzuGTXHMH2l3U+MEASADsZsOyoVwBTnHI8/RusqtWlmUXPlunVehiAW+fsiooT+GOWBaahf9knCBUbdgTVmKHNFTFTqhYbl9qVIh2MBuPkxCg7DyOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdGbhHHx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712515766; x=1744051766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=abTUwIjIEn8CoVDaZCCvWCNQErF+fn/yHr/4f1a/juc=;
  b=WdGbhHHxt4UHLymezESybmr/hy2Zk/CFCoVNsBAmVbS0DqaxMGe0iPli
   n0uapmbsx3O3bnwcXuVEkHftkzXiLdWDeH0RLQRWP+FA72CO5pfnmU9kG
   Mz+SrJ84YdSgxwW9b9cJvAlwZv01FY1sOEn0GvuUQaLrq8EVWZrpmonl3
   UNBtbVFqdn8ds+dElXbPmbwCvn42DQMawYLcLbHXh8eaKQcUZ03+xTC7F
   ZEt1rCWmC76PE5gbrrsGUoB3Q6J+yUCyidL3FtWle10MMaKkvpph9Fa98
   pfcykF4/jdGYdSnTqJTOU71MokJmAITmjYcRekJXS8o2OVShUkHo4+sPF
   A==;
X-CSE-ConnectionGUID: NgQ3VxLSTY2MiWHRbuDQZQ==
X-CSE-MsgGUID: VIjEuJfFRrqgs7uhxiX+LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18405742"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="18405742"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 11:49:26 -0700
X-CSE-ConnectionGUID: 6VUvkVxMRAipYrmElyyBcQ==
X-CSE-MsgGUID: 1VHHS+vqRb2TvgP3N9Uq8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="24409221"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2024 11:49:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtXZw-0004YA-37;
	Sun, 07 Apr 2024 18:49:20 +0000
Date: Mon, 8 Apr 2024 02:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/5] sched: Split out kernel/sched/numa_balancing.c from
 kernel/sched/fair.c
Message-ID: <202404080242.0PsxhOlk-lkp@intel.com>
References: <20240407084319.1462211-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407084319.1462211-4-mingo@kernel.org>

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
patch link:    https://lore.kernel.org/r/20240407084319.1462211-4-mingo%40kernel.org
patch subject: [PATCH 3/5] sched: Split out kernel/sched/numa_balancing.c from kernel/sched/fair.c
config: x86_64-randconfig-121-20240408 (https://download.01.org/0day-ci/archive/20240408/202404080242.0PsxhOlk-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240408/202404080242.0PsxhOlk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404080242.0PsxhOlk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/numa_balancing.c:1654:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/numa_balancing.c:1654:13: sparse:     expected struct task_struct *tsk
   kernel/sched/numa_balancing.c:1654:13: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/numa_balancing.c: note: in included file (through include/linux/mmzone.h, include/linux/memory-tiers.h):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   kernel/sched/numa_balancing.c:1600:9: sparse: sparse: context imbalance in 'task_numa_placement' - different lock contexts for basic block

vim +1654 kernel/sched/numa_balancing.c

  1619	
  1620	static void task_numa_group(struct task_struct *p, int cpupid, int flags,
  1621				int *priv)
  1622	{
  1623		struct numa_group *grp, *my_grp;
  1624		struct task_struct *tsk;
  1625		bool join = false;
  1626		int cpu = cpupid_to_cpu(cpupid);
  1627		int i;
  1628	
  1629		if (unlikely(!deref_curr_numa_group(p))) {
  1630			unsigned int size = sizeof(struct numa_group) +
  1631					    NR_NUMA_HINT_FAULT_STATS *
  1632					    nr_node_ids * sizeof(unsigned long);
  1633	
  1634			grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
  1635			if (!grp)
  1636				return;
  1637	
  1638			refcount_set(&grp->refcount, 1);
  1639			grp->active_nodes = 1;
  1640			grp->max_faults_cpu = 0;
  1641			spin_lock_init(&grp->lock);
  1642			grp->gid = p->pid;
  1643	
  1644			for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
  1645				grp->faults[i] = p->numa_faults[i];
  1646	
  1647			grp->total_faults = p->total_numa_faults;
  1648	
  1649			grp->nr_tasks++;
  1650			rcu_assign_pointer(p->numa_group, grp);
  1651		}
  1652	
  1653		rcu_read_lock();
> 1654		tsk = READ_ONCE(cpu_rq(cpu)->curr);
  1655	
  1656		if (!cpupid_match_pid(tsk, cpupid))
  1657			goto no_join;
  1658	
  1659		grp = rcu_dereference(tsk->numa_group);
  1660		if (!grp)
  1661			goto no_join;
  1662	
  1663		my_grp = deref_curr_numa_group(p);
  1664		if (grp == my_grp)
  1665			goto no_join;
  1666	
  1667		/*
  1668		 * Only join the other group if its bigger; if we're the bigger group,
  1669		 * the other task will join us.
  1670		 */
  1671		if (my_grp->nr_tasks > grp->nr_tasks)
  1672			goto no_join;
  1673	
  1674		/*
  1675		 * Tie-break on the grp address.
  1676		 */
  1677		if (my_grp->nr_tasks == grp->nr_tasks && my_grp > grp)
  1678			goto no_join;
  1679	
  1680		/* Always join threads in the same process. */
  1681		if (tsk->mm == current->mm)
  1682			join = true;
  1683	
  1684		/* Simple filter to avoid false positives due to PID collisions */
  1685		if (flags & TNF_SHARED)
  1686			join = true;
  1687	
  1688		/* Update priv based on whether false sharing was detected */
  1689		*priv = !join;
  1690	
  1691		if (join && !get_numa_group(grp))
  1692			goto no_join;
  1693	
  1694		rcu_read_unlock();
  1695	
  1696		if (!join)
  1697			return;
  1698	
  1699		WARN_ON_ONCE(irqs_disabled());
  1700		double_lock_irq(&my_grp->lock, &grp->lock);
  1701	
  1702		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++) {
  1703			my_grp->faults[i] -= p->numa_faults[i];
  1704			grp->faults[i] += p->numa_faults[i];
  1705		}
  1706		my_grp->total_faults -= p->total_numa_faults;
  1707		grp->total_faults += p->total_numa_faults;
  1708	
  1709		my_grp->nr_tasks--;
  1710		grp->nr_tasks++;
  1711	
  1712		spin_unlock(&my_grp->lock);
  1713		spin_unlock_irq(&grp->lock);
  1714	
  1715		rcu_assign_pointer(p->numa_group, grp);
  1716	
  1717		put_numa_group(my_grp);
  1718		return;
  1719	
  1720	no_join:
  1721		rcu_read_unlock();
  1722		return;
  1723	}
  1724	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

