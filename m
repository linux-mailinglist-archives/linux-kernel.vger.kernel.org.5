Return-Path: <linux-kernel+bounces-18789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029FD82630F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32C71C2123D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2E125B1;
	Sun,  7 Jan 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1TTiN8q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E05125AB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704606304; x=1736142304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cypbT8fxXl5raFtj+qyGPU2t4rs3XLXM4ybpGmnc+w0=;
  b=j1TTiN8q2TDu4+qvu1eo45/EWfMcchVqdbEb4VFDeVpbhFrYLYjV9ttQ
   63ZJIeN6xOOSiwJdjJ1x9NHxS8ubop+sjnxPI0JzCS7T4yJCFjC8aQXp1
   36qYPDW+66bPg+ykp5PmePgSxpeHELTVI2gInkJItF0LlukaEJcBNXpz9
   CETAwwzEiz+97fNN1J1/cfE/tQY8p0u+2imQ7fChM0/SflJpufJIFi85r
   K9+95mNOoELhAuBC9bY2OJXidIMstH2CZkg7bDotJR4Z9GKGUIIpjlsQr
   SHnf6DBPOxhRNhKj2CJZ7+WSyqgvFjGRjgkpauzORuSgil6cl6VlaarVP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="401481558"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="401481558"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 21:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="815308986"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="815308986"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2024 21:45:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMLxz-0003RU-2x;
	Sun, 07 Jan 2024 05:44:59 +0000
Date: Sun, 7 Jan 2024 13:44:59 +0800
From: kernel test robot <lkp@intel.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/core.c:711:31: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202401071320.DgkEuvyo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 52b1364ba0b105122d6de0e719b36db705011ac1 sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure
date:   1 year, 4 months ago
config: x86_64-randconfig-122-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071320.DgkEuvyo-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071320.DgkEuvyo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071320.DgkEuvyo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/sched/core.c:711:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:711:31: sparse:     expected struct task_struct *task
   kernel/sched/core.c:711:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:781:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:781:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:781:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1028:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1028:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1028:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2192:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2192:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2192:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2192:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2192:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2192:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3592:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3592:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3592:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3789:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3789:28: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3789:28: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9156:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9156:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9156:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5441:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5441:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5441:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6387:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6387:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6387:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6913:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6913:17: sparse:    struct task_struct *
   kernel/sched/core.c:6913:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7129:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7129:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7129:22: sparse:    struct task_struct *
   kernel/sched/core.c:11188:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11188:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11188:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1323:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/sched.h:1323:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:562:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/sched.h:1582:9: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/sched.h:1582:9: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:781:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2183:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2184:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2185:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/core.c:2158:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2158:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2158:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *

vim +711 kernel/sched/core.c

   675	
   676	/*
   677	 * RQ-clock updating methods:
   678	 */
   679	
   680	static void update_rq_clock_task(struct rq *rq, s64 delta)
   681	{
   682	/*
   683	 * In theory, the compile should just see 0 here, and optimize out the call
   684	 * to sched_rt_avg_update. But I don't trust it...
   685	 */
   686		s64 __maybe_unused steal = 0, irq_delta = 0;
   687	
   688	#ifdef CONFIG_IRQ_TIME_ACCOUNTING
   689		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
   690	
   691		/*
   692		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
   693		 * this case when a previous update_rq_clock() happened inside a
   694		 * {soft,}irq region.
   695		 *
   696		 * When this happens, we stop ->clock_task and only update the
   697		 * prev_irq_time stamp to account for the part that fit, so that a next
   698		 * update will consume the rest. This ensures ->clock_task is
   699		 * monotonic.
   700		 *
   701		 * It does however cause some slight miss-attribution of {soft,}irq
   702		 * time, a more accurate solution would be to update the irq_time using
   703		 * the current rq->clock timestamp, except that would require using
   704		 * atomic ops.
   705		 */
   706		if (irq_delta > delta)
   707			irq_delta = delta;
   708	
   709		rq->prev_irq_time += irq_delta;
   710		delta -= irq_delta;
 > 711		psi_account_irqtime(rq->curr, irq_delta);
   712	#endif
   713	#ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
   714		if (static_key_false((&paravirt_steal_rq_enabled))) {
   715			steal = paravirt_steal_clock(cpu_of(rq));
   716			steal -= rq->prev_steal_time_rq;
   717	
   718			if (unlikely(steal > delta))
   719				steal = delta;
   720	
   721			rq->prev_steal_time_rq += steal;
   722			delta -= steal;
   723		}
   724	#endif
   725	
   726		rq->clock_task += delta;
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

