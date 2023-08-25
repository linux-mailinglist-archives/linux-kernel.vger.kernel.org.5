Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB0787D53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjHYBtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHYBsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:48:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BAA8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692928117; x=1724464117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eh5YqIQK65gZuUtvygXGY1OIBSrgJDWKSVzm0lov+Wc=;
  b=HauRyEtFK5YtcrQML9lLajSMNrJnmcCpc9kv1ribLWNkqsIZ0n73dns1
   oDc78J3xqysG6xeMVy6rjRcRzYqYG8IkOUGXOZa7XHsZsyt97X7PyE+Vk
   yOurMs+okklZuhKH4AEbz9OqTqW6/Ujegi4H5EJvdyoZBoI4Dy64Y4KpC
   2CxSWktX1Ij+lZJQng+Mlf/spZsZPKl21mLTQBb8XRWHWQmfb1U4pGsKF
   m6JvgAF+YNmMlLkNtUsRBFxGgmyz8nDFirw8p4nPrfXD1l2uX+0Ob9ebk
   x11PubMPHGYhZSCRVDn/dEm41BSm061gvJa5yn4uLm5G/JG8EhQcfB8RZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372004724"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372004724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 18:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="911119748"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="911119748"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2023 18:48:35 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZLwA-00037O-1H;
        Fri, 25 Aug 2023 01:48:34 +0000
Date:   Fri, 25 Aug 2023 09:48:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.22a 61/69]
 kernel/locking/qspinlock.c:709:102: warning: format specifies type 'unsigned
 long' but the argument has type 'unsigned int'
Message-ID: <202308250917.NOqF6Mad-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: bdd8d60bd4047aa4a7dc207789dc4ad0dfd5f07e [61/69] EXP qspinlock: Dump lock state, add call from locktorture
config: mips-randconfig-r023-20230825 (https://download.01.org/0day-ci/archive/20230825/202308250917.NOqF6Mad-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250917.NOqF6Mad-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250917.NOqF6Mad-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/qspinlock.c:709:102: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     709 |         pr_alert("%s: _Q_TAIL_CPU_OFFSET=%d _Q_TAIL_IDX_MASK=%d _Q_TAIL_IDX_OFFSET=%d _Q_LOCKED_VAL=%d _Q_TAIL_OFFSET=%d sizeof(->tail)=%lu\n",
         |                                                                                                                                         ~~~
         |                                                                                                                                         %u
     710 |                 __func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, sizeof(qval.tail));
         |                                                                                                                    ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:478:35: note: expanded from macro 'pr_alert'
     478 |         printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
     455 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
>> kernel/locking/qspinlock.c:691:6: warning: no previous prototype for function 'spinlock_dump' [-Wmissing-prototypes]
     691 | void spinlock_dump(spinlock_t *sp, bool full)
         |      ^
   kernel/locking/qspinlock.c:691:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     691 | void spinlock_dump(spinlock_t *sp, bool full)
         | ^
         | static 
   2 warnings generated.


vim +709 kernel/locking/qspinlock.c

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
 > 709			__func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, sizeof(qval.tail));
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
