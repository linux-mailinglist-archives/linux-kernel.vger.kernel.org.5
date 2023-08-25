Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78C788004
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjHYGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbjHYGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:38:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF051FCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692945478; x=1724481478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pV8ekNNMAxTA4+vHF2loLxjGa17Kbulq6RW+d0X+oMo=;
  b=oI/mVB4Q7BZPuSTYnWKdt7lkr/MIMUMNSIsE9eryyP4kD4dCrqSmGEp7
   xHKtj642FqcoLzT2Wb4Wx92sahsU6YEqwxQmYc4GW0Zw7W2d4D7t55h89
   btTSDtuvjNSO6TfSmS9GSfD5NRu84tvB6nlsUSOBIGY3YD/IBV5s9figI
   LFWk0Lz1M0ahIg4/vp27B45hwCy4/6OI/VAN3zsrjSWOEDaNG7Z16gQC7
   an7SAXYCPvKxF2SNOHWF4fOo68fzgPK52t3h6fF0GjuJz7Vh3N3+PHgy3
   Yc9Id4bbFU3eBTPC9XujLwLsYYE6x44fMb0RyePhuXRb8vAc6mWwfA/oe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364841519"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364841519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881071899"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 23:38:00 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZQSA-0003Hg-2x;
        Fri, 25 Aug 2023 06:37:54 +0000
Date:   Fri, 25 Aug 2023 14:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a 61/69]
 kernel/locking/qspinlock.c:660:19: error: redefinition of 'tail_to_cpu'
Message-ID: <202308251435.gwLevKf4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: bdd8d60bd4047aa4a7dc207789dc4ad0dfd5f07e [61/69] EXP qspinlock: Dump lock state, add call from locktorture
config: i386-buildonly-randconfig-001-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251435.gwLevKf4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251435.gwLevKf4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251435.gwLevKf4-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/qspinlock.c:709:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
                   __func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, sizeof(qval.tail));
                                                                                                                      ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:478:35: note: expanded from macro 'pr_alert'
           printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   In file included from kernel/locking/qspinlock.c:741:
   kernel/locking/qspinlock_paravirt.h:298:7: warning: variable 'wait_early' set but not used [-Wunused-but-set-variable]
           bool wait_early;
                ^
   kernel/locking/qspinlock_paravirt.h:407:6: warning: variable 'waitcnt' set but not used [-Wunused-but-set-variable]
           int waitcnt = 0;
               ^
   kernel/locking/qspinlock_paravirt.h:493:1: warning: no previous prototype for function '__pv_queued_spin_unlock_slowpath' [-Wmissing-prototypes]
   __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
   ^
   kernel/locking/qspinlock_paravirt.h:492:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __visible __lockfunc void
                        ^
                        static 
   In file included from kernel/locking/qspinlock.c:742:
>> kernel/locking/qspinlock.c:660:19: error: redefinition of 'tail_to_cpu'
   static __pure int tail_to_cpu(u32 tail)
                     ^
   kernel/locking/qspinlock.c:660:19: note: previous definition is here
   static __pure int tail_to_cpu(u32 tail)
                     ^
   In file included from kernel/locking/qspinlock.c:742:
>> kernel/locking/qspinlock.c:665:19: error: redefinition of 'tail_to_idx'
   static __pure int tail_to_idx(u32 tail)
                     ^
   kernel/locking/qspinlock.c:665:19: note: previous definition is here
   static __pure int tail_to_idx(u32 tail)
                     ^
   In file included from kernel/locking/qspinlock.c:742:
>> kernel/locking/qspinlock.c:670:29: error: redefinition of 'next_to_prev'
   static struct mcs_spinlock *next_to_prev(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   kernel/locking/qspinlock.c:670:29: note: previous definition is here
   static struct mcs_spinlock *next_to_prev(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   In file included from kernel/locking/qspinlock.c:742:
>> kernel/locking/qspinlock.c:691:6: error: redefinition of 'spinlock_dump'
   void spinlock_dump(spinlock_t *sp, bool full)
        ^
   kernel/locking/qspinlock.c:691:6: note: previous definition is here
   void spinlock_dump(spinlock_t *sp, bool full)
        ^
   In file included from kernel/locking/qspinlock.c:742:
   kernel/locking/qspinlock.c:709:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
                   __func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, sizeof(qval.tail));
                                                                                                                      ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:478:35: note: expanded from macro 'pr_alert'
           printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   5 warnings and 4 errors generated.


vim +/tail_to_cpu +660 kernel/locking/qspinlock.c

   658	
   659	/* Dump out queued spinlock state. */
 > 660	static __pure int tail_to_cpu(u32 tail)
   661	{
   662		return (tail >> (_Q_TAIL_CPU_OFFSET - _Q_TAIL_OFFSET)) - 1;
   663	}
   664	
 > 665	static __pure int tail_to_idx(u32 tail)
   666	{
   667		return (tail & _Q_TAIL_IDX_MASK) >> (_Q_TAIL_IDX_OFFSET - _Q_TAIL_OFFSET);
   668	}
   669	
 > 670	static struct mcs_spinlock *next_to_prev(struct mcs_spinlock *msp, int *cpup, int *idxp)
   671	{
   672		int cpu;
   673		int idx;
   674	
   675		for_each_possible_cpu(cpu) {
   676			struct qnode *qnp = per_cpu_ptr(&qnodes[0], cpu);
   677	
   678			for (idx = 0; idx < MAX_NODES; idx++) {
   679				if (qnp[idx].mcs.next == msp) {
   680					*cpup = cpu;
   681					*idxp = idx;
   682					return &qnp[idx].mcs;
   683				}
   684			}
   685		}
   686		*cpup = -1;
   687		*idxp = -1;
   688		return NULL;
   689	}
   690	
 > 691	void spinlock_dump(spinlock_t *sp, bool full)
   692	{
   693		int cpu;
   694		int i = 0;
   695		int idx;
   696		struct mcs_spinlock *msp;
   697		struct qspinlock qval = sp->rlock.raw_lock;
   698	
   699		cpu = tail_to_cpu(qval.tail);
   700		idx = tail_to_idx(qval.tail);
   701		pr_alert("%s: %ps %#x (%c%c%c%c %#x: %d[%d]\n",
   702			 __func__, sp, (unsigned int)atomic_read(&qval.val),
   703			 ".L"[!!qval.locked],
   704			 ".P"[!!qval.pending],
   705			 ".Q"[cpu >= 0 && idx >= 0],
   706			 ".F"[!!full],
   707			 (unsigned int)qval.tail, cpu, idx);
   708		pr_alert("%s: _Q_TAIL_CPU_OFFSET=%d _Q_TAIL_IDX_MASK=%d _Q_TAIL_IDX_OFFSET=%d _Q_LOCKED_VAL=%d _Q_TAIL_OFFSET=%d sizeof(->tail)=%lu\n",
   709			__func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, sizeof(qval.tail));
   710		if (!full)
   711			return;
   712		while (i++ < nr_cpu_ids && (msp = next_to_prev(msp, &cpu, &idx))) {
   713			pr_alert("%s: Q%d CPU %d[%d] %c%d\n", __func__, i, cpu, idx,
   714				 ".L"[!!msp->locked], msp->count);
   715		}
   716		if (i >= nr_cpu_ids && cpu >= 0 && idx >= 0)
   717			pr_alert("%s: Queue output truncated.\n", __func__);
   718		else
   719			pr_alert("%s: End of queue.\n", __func__);
   720	}
   721	EXPORT_SYMBOL(spinlock_dump);
   722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
