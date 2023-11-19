Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A37F041C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjKSCkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKSCkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:40:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47071192
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700361637; x=1731897637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E22jqHnrQpCF/m5XO1ilVlfgmA0XrfUFSzeODohWJK4=;
  b=SwzAJ0h2vIoaTFiDrYtJB6dWCs6AnfQPBcNYEa/j5527+2hPf8Ac8Bd3
   tDBEPIdo8KGxwp0zub9SjQRMW6DMnLKgQcQlmYU/NdCi16+jTQxD1QJOY
   SRK/HMqbGEi2iKg7unqVhuX4xoZP8QPye+3+QV1OFCcv7i3pmmcs/Bop6
   tYdqaGOxAmOqNzdivqLuub8yAL/YPIRHaEVg35aK6+M50NDSM2xxTeTiU
   +/c3DO5bnob0+kyDUh7lyMHvMS9ourP7tckCg5eS+B4YxWMyCv8z1McNo
   n38RrOsnEn477IohXpfE6kbDjelhnYTa/UUVIsOOzUeE6nk4FS4OHMXm4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="394316029"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="394316029"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 18:40:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="800819223"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="800819223"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2023 18:40:35 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Xjc-0004Yt-2B;
        Sun, 19 Nov 2023 02:40:32 +0000
Date:   Sun, 19 Nov 2023 10:40:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast
 truncates bits from constant value (ffffffff becomes ff)
Message-ID: <202311191039.4P3HiiKh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: 0e34600ac9317dbe5f0a7bfaa3d7187d757572ed sched: Misc cleanups
date:   10 weeks ago
config: arm64-randconfig-r122-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191039.4P3HiiKh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231119/202311191039.4P3HiiKh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191039.4P3HiiKh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:6298:46: sparse:    struct task_struct *
   kernel/sched/core.c:6298:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:6358:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:6358:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:6358:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:6569:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6569:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6569:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7095:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7095:17: sparse:    struct task_struct *
   kernel/sched/core.c:7095:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7310:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7310:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7310:22: sparse:    struct task_struct *
   kernel/sched/core.c:7357:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7357:48: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7357:48: sparse:    struct task_struct *
   kernel/sched/core.c:11435:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11435:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11435:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:338:9: sparse: sparse: context imbalance in 'sched_core_lock' - different lock contexts for basic block
   kernel/sched/core.c:348:17: sparse: sparse: context imbalance in 'sched_core_unlock' - unexpected unlock
   kernel/sched/core.c:551:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:576:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1235:30: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:638:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:679:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1086:5: sparse: sparse: context imbalance in 'get_nohz_timer_target' - wrong count at exit
   kernel/sched/core.c:1481:13: sparse: sparse: context imbalance in 'uclamp_update_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:1775:13: sparse: sparse: context imbalance in 'uclamp_update_root_tg' - wrong count at exit
   kernel/sched/core.c:1813:9: sparse: sparse: context imbalance in 'uclamp_sync_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:2217:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2218:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2219:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2272:15: sparse: sparse: context imbalance in 'wait_task_inactive' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:2192:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2192:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2192:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:8241:5: sparse: sparse: context imbalance in 'dl_task_check_affinity' - wrong count at exit
   kernel/sched/core.c:8345:44: sparse: sparse: context imbalance in 'sched_setaffinity' - different lock contexts for basic block
   kernel/sched/core.c:8407:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/core.c:8570:28: sparse: sparse: context imbalance in '__cond_resched_lock' - unexpected unlock
   kernel/sched/core.c:8588:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_read' - unexpected unlock
   kernel/sched/core.c:8606:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_write' - unexpected unlock
   kernel/sched/core.c: note: in included file (through include/linux/mmu_context.h, include/linux/cpuset.h):
   arch/arm64/include/asm/mmu_context.h:252:22: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:11600:5: sparse: sparse: context imbalance in '__sched_mm_cid_migrate_from_fetch_cid' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/linux/jump_label.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)

vim +171 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  167  
305d454aaa292b Will Deacon     2015-10-08  168  __CMPXCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  169  __CMPXCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08  170  __CMPXCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08 @171  __CMPXCHG_GEN(_mb)
10b663aef1c247 Catalin Marinas 2012-03-05  172  

:::::: The code at line 171 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
