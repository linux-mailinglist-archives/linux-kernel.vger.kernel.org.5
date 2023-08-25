Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1910E7882BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbjHYI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbjHYI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:56:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6671BCD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692953791; x=1724489791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JCH43ctKr+8nrbOK2BXGW5bYASdd1r/s0AzuHw4giac=;
  b=H4RYQuX4kXwtvpE92FrlC/J+izi52FVOSIFV7V2w8j5cIRwXdhq5PLE7
   viudZ4drO1kiI+SBqrJYH5wwIPg4UuttSdeddjPE+XxhWmecFnSxBtm43
   NSd320tc3Di7QFLjEujusFbHeJA48Zdwr/gA3cuAVMgPQLtapqFymGRMi
   SGIFTSFJU1+Mf8AXs7WDp0Bc2rbWTKy+wVzuRUzFGuG++xUKlKkHMAbqc
   FHhnTRABvX1144WwrPpaqegw9pFeIslKXh5HDPBnR65vziM4ah0Hl3gnC
   33IV+lurtNSOF23PYB93YgB37CkNn/VkqEsb2kQAA7VcBvP5jhfE4TT/5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405669222"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405669222"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737408490"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737408490"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2023 01:56:29 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZScG-0003Mu-24;
        Fri, 25 Aug 2023 08:56:28 +0000
Date:   Fri, 25 Aug 2023 16:55:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a 67/69]
 kernel/locking/qspinlock.c:691:29: error: redefinition of 'next_to_cpu_idx'
Message-ID: <202308251616.7HOmYRfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: 62532cfc5f2be5376f0eac431783c226c35e104f [67/69] EXP qspinlock: Dump full qnode structure
config: i386-buildonly-randconfig-001-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251616.7HOmYRfg-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251616.7HOmYRfg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251616.7HOmYRfg-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/qspinlock.c:730:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
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
   In file included from kernel/locking/qspinlock.c:779:
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
   In file included from kernel/locking/qspinlock.c:780:
   kernel/locking/qspinlock.c:660:19: error: redefinition of 'tail_to_cpu'
   static __pure int tail_to_cpu(u32 tail)
                     ^
   kernel/locking/qspinlock.c:660:19: note: previous definition is here
   static __pure int tail_to_cpu(u32 tail)
                     ^
   In file included from kernel/locking/qspinlock.c:780:
   kernel/locking/qspinlock.c:665:19: error: redefinition of 'tail_to_idx'
   static __pure int tail_to_idx(u32 tail)
                     ^
   kernel/locking/qspinlock.c:665:19: note: previous definition is here
   static __pure int tail_to_idx(u32 tail)
                     ^
   In file included from kernel/locking/qspinlock.c:780:
   kernel/locking/qspinlock.c:670:29: error: redefinition of 'next_to_prev'
   static struct mcs_spinlock *next_to_prev(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   kernel/locking/qspinlock.c:670:29: note: previous definition is here
   static struct mcs_spinlock *next_to_prev(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   In file included from kernel/locking/qspinlock.c:780:
>> kernel/locking/qspinlock.c:691:29: error: redefinition of 'next_to_cpu_idx'
   static struct mcs_spinlock *next_to_cpu_idx(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   kernel/locking/qspinlock.c:691:29: note: previous definition is here
   static struct mcs_spinlock *next_to_cpu_idx(struct mcs_spinlock *msp, int *cpup, int *idxp)
                               ^
   In file included from kernel/locking/qspinlock.c:780:
   kernel/locking/qspinlock.c:712:6: error: redefinition of 'spinlock_dump'
   void spinlock_dump(spinlock_t *sp, bool full)
        ^
   kernel/locking/qspinlock.c:712:6: note: previous definition is here
   void spinlock_dump(spinlock_t *sp, bool full)
        ^
   In file included from kernel/locking/qspinlock.c:780:
   kernel/locking/qspinlock.c:730:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
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
   5 warnings and 5 errors generated.


vim +/next_to_cpu_idx +691 kernel/locking/qspinlock.c

   690	
 > 691	static struct mcs_spinlock *next_to_cpu_idx(struct mcs_spinlock *msp, int *cpup, int *idxp)
   692	{
   693		int cpu;
   694		int idx;
   695	
   696		for_each_possible_cpu(cpu) {
   697			struct qnode *qnp = per_cpu_ptr(&qnodes[0], cpu);
   698	
   699			for (idx = 0; idx < MAX_NODES; idx++) {
   700				if (&qnp[idx].mcs == msp) {
   701					*cpup = cpu;
   702					*idxp = idx;
   703					return &qnp[idx].mcs;
   704				}
   705			}
   706		}
   707		*cpup = -1;
   708		*idxp = -1;
   709		return NULL;
   710	}
   711	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
