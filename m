Return-Path: <linux-kernel+bounces-11156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7781E23D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053841F21DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD28537FE;
	Mon, 25 Dec 2023 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8297Ulg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD0537F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703534894; x=1735070894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/LP5ybDOdUTuNnalFfi44IKdHSxwVGsj+3hEhbPVUoQ=;
  b=k8297UlgFP5Ce9kdaBczZ98UEnIWCa4nWrXB5oC9DVtmZmFqFuPEmxFs
   j2lJAZknafApj85D32fD6u6MnP8amhmXCKxcUY0dB7lOYllrMcI1Ev0Eb
   lykurxarW1aIslzKrgBymMhl9KYhHagL4PN90qbQbfZctz6filNpP85Ho
   BOAyWN6U8KE5PSCrBhxRd3SKpmzSQogHqdtiXklxR9/IAMKRUZwWnWj1B
   aXLDhHyxAqLEJbAUdPxuPO0zhs/HlR6rCYdP1aOMgmaT8bJ5jXqoTfe4C
   wGgk9lke34o8r+kL2L8fPZkSsXC0D1Gm+OB2pIzZOnHmazS4AycPgLeT6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9828423"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="9828423"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 12:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109209634"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="1109209634"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Dec 2023 12:08:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHrEc-000DeL-0i;
	Mon, 25 Dec 2023 20:07:53 +0000
Date: Tue, 26 Dec 2023 04:05:38 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: kernel/locking/qspinlock_paravirt.h:298:14: warning: variable
 'wait_early' set but not used
Message-ID: <202312260422.f4pK3f9m-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: ad53fa10fa9e816067bbae7109845940f5e6df50 locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs
date:   4 years, 9 months ago
config: x86_64-buildonly-randconfig-006-20230826 (https://download.01.org/0day-ci/archive/20231226/202312260422.f4pK3f9m-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260422.f4pK3f9m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/locking/qspinlock.c:589:
   kernel/locking/qspinlock_paravirt.h: In function 'pv_wait_node':
>> kernel/locking/qspinlock_paravirt.h:298:14: warning: variable 'wait_early' set but not used [-Wunused-but-set-variable]
     298 |         bool wait_early;
         |              ^~~~~~~~~~
   kernel/locking/qspinlock_paravirt.h: At top level:
   kernel/locking/qspinlock_paravirt.h:493:1: warning: no previous prototype for '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
     493 | __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/wait_early +298 kernel/locking/qspinlock_paravirt.h

a23db284fe0d18 Waiman Long    2015-04-24  287  
a23db284fe0d18 Waiman Long    2015-04-24  288  /*
a23db284fe0d18 Waiman Long    2015-04-24  289   * Wait for node->locked to become true, halt the vcpu after a short spin.
75d2270280686b Waiman Long    2015-07-11  290   * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
75d2270280686b Waiman Long    2015-07-11  291   * behalf.
a23db284fe0d18 Waiman Long    2015-04-24  292   */
cd0272fab78507 Waiman Long    2015-11-09  293  static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
a23db284fe0d18 Waiman Long    2015-04-24  294  {
a23db284fe0d18 Waiman Long    2015-04-24  295  	struct pv_node *pn = (struct pv_node *)node;
cd0272fab78507 Waiman Long    2015-11-09  296  	struct pv_node *pp = (struct pv_node *)prev;
a23db284fe0d18 Waiman Long    2015-04-24  297  	int loop;
cd0272fab78507 Waiman Long    2015-11-09 @298  	bool wait_early;
a23db284fe0d18 Waiman Long    2015-04-24  299  
08be8f63c40c03 Waiman Long    2016-05-31  300  	for (;;) {
cd0272fab78507 Waiman Long    2015-11-09  301  		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
a23db284fe0d18 Waiman Long    2015-04-24  302  			if (READ_ONCE(node->locked))
a23db284fe0d18 Waiman Long    2015-04-24  303  				return;
cd0272fab78507 Waiman Long    2015-11-09  304  			if (pv_wait_early(pp, loop)) {
cd0272fab78507 Waiman Long    2015-11-09  305  				wait_early = true;
cd0272fab78507 Waiman Long    2015-11-09  306  				break;
cd0272fab78507 Waiman Long    2015-11-09  307  			}
a23db284fe0d18 Waiman Long    2015-04-24  308  			cpu_relax();
a23db284fe0d18 Waiman Long    2015-04-24  309  		}
a23db284fe0d18 Waiman Long    2015-04-24  310  
a23db284fe0d18 Waiman Long    2015-04-24  311  		/*
a23db284fe0d18 Waiman Long    2015-04-24  312  		 * Order pn->state vs pn->locked thusly:
a23db284fe0d18 Waiman Long    2015-04-24  313  		 *
a23db284fe0d18 Waiman Long    2015-04-24  314  		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
a23db284fe0d18 Waiman Long    2015-04-24  315  		 *     MB			      MB
75d2270280686b Waiman Long    2015-07-11  316  		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
a23db284fe0d18 Waiman Long    2015-04-24  317  		 *
75d2270280686b Waiman Long    2015-07-11  318  		 * Matches the cmpxchg() from pv_kick_node().
a23db284fe0d18 Waiman Long    2015-04-24  319  		 */
b92b8b35a2e38b Peter Zijlstra 2015-05-12  320  		smp_store_mb(pn->state, vcpu_halted);
a23db284fe0d18 Waiman Long    2015-04-24  321  
45e898b735620f Waiman Long    2015-11-09  322  		if (!READ_ONCE(node->locked)) {
ad53fa10fa9e81 Waiman Long    2019-04-04  323  			lockevent_inc(pv_wait_node);
ad53fa10fa9e81 Waiman Long    2019-04-04  324  			lockevent_cond_inc(pv_wait_early, wait_early);
a23db284fe0d18 Waiman Long    2015-04-24  325  			pv_wait(&pn->state, vcpu_halted);
45e898b735620f Waiman Long    2015-11-09  326  		}
a23db284fe0d18 Waiman Long    2015-04-24  327  
a23db284fe0d18 Waiman Long    2015-04-24  328  		/*
45e898b735620f Waiman Long    2015-11-09  329  		 * If pv_kick_node() changed us to vcpu_hashed, retain that
1c4941fd53afb4 Waiman Long    2015-11-10  330  		 * value so that pv_wait_head_or_lock() knows to not also try
1c4941fd53afb4 Waiman Long    2015-11-10  331  		 * to hash this lock.
a23db284fe0d18 Waiman Long    2015-04-24  332  		 */
75d2270280686b Waiman Long    2015-07-11  333  		cmpxchg(&pn->state, vcpu_halted, vcpu_running);
a23db284fe0d18 Waiman Long    2015-04-24  334  
a23db284fe0d18 Waiman Long    2015-04-24  335  		/*
a23db284fe0d18 Waiman Long    2015-04-24  336  		 * If the locked flag is still not set after wakeup, it is a
a23db284fe0d18 Waiman Long    2015-04-24  337  		 * spurious wakeup and the vCPU should wait again. However,
a23db284fe0d18 Waiman Long    2015-04-24  338  		 * there is a pretty high overhead for CPU halting and kicking.
a23db284fe0d18 Waiman Long    2015-04-24  339  		 * So it is better to spin for a while in the hope that the
a23db284fe0d18 Waiman Long    2015-04-24  340  		 * MCS lock will be released soon.
a23db284fe0d18 Waiman Long    2015-04-24  341  		 */
ad53fa10fa9e81 Waiman Long    2019-04-04  342  		lockevent_cond_inc(pv_spurious_wakeup,
ad53fa10fa9e81 Waiman Long    2019-04-04  343  				  !READ_ONCE(node->locked));
a23db284fe0d18 Waiman Long    2015-04-24  344  	}
75d2270280686b Waiman Long    2015-07-11  345  
a23db284fe0d18 Waiman Long    2015-04-24  346  	/*
a23db284fe0d18 Waiman Long    2015-04-24  347  	 * By now our node->locked should be 1 and our caller will not actually
a23db284fe0d18 Waiman Long    2015-04-24  348  	 * spin-wait for it. We do however rely on our caller to do a
a23db284fe0d18 Waiman Long    2015-04-24  349  	 * load-acquire for us.
a23db284fe0d18 Waiman Long    2015-04-24  350  	 */
a23db284fe0d18 Waiman Long    2015-04-24  351  }
a23db284fe0d18 Waiman Long    2015-04-24  352  

:::::: The code at line 298 was first introduced by commit
:::::: cd0272fab785077c121aa91ec2401090965bbc37 locking/pvqspinlock: Queue node adaptive spinning

:::::: TO: Waiman Long <Waiman.Long@hpe.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

