Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B67DE863
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKAWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjKAWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:54:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF412F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698879268; x=1730415268;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tZVTpUY1N1MedF2l86nD3DHTHWTVwd0+nVjfFkbyVyU=;
  b=koWnXswI0wi2iNTCn72RcbYRMcVkOrIf/xHGJSIp3J9sWVtzid3IB5+V
   lr7tLc5Ig64NaLQlZUKRXe7CV4xSTrofdNnbGnsgUU2Mug4LTnxv2r9Vq
   oEdUkyRc3Ao+SHuBcYE+wNloC6pYchtHTLyJH1a2pr31Kv3BJ8eqAS4AF
   F4ASGxxH7YevKjWAwjjMT37JulwQT5pWDBmei6iwlO9BT3e7gWztA+Dkx
   QTbm7QK+yG3P+NnF2BFFj3gx/gdlizYA2Pir+XTSY8lakQLmR3cB7DMD2
   tMupy6JVPeF6Hi1Hf6RnqeAFxkJLsA8yhudEKnQbTVsRK+eReanyB2oAM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1511461"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1511461"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 15:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="764710567"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="764710567"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2023 15:54:26 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyK6R-00010C-0W;
        Wed, 01 Nov 2023 22:54:23 +0000
Date:   Thu, 2 Nov 2023 06:53:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.11.01a 18/37]
 kernel/locking/qspinlock.c:691:6: warning: no previous declaration for
 'spinlock_dump'
Message-ID: <202311020612.oQucVrSC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.01a
head:   a5d1576b5e4924bc6884b992be2345013a663c82
commit: 851f9c70733ed644c8a03d8f93f9876942181bee [18/37] EXP qspinlock: Add spinlock_dump() to dump lock state
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231102/202311020612.oQucVrSC-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311020612.oQucVrSC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311020612.oQucVrSC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/qspinlock.c:691:6: warning: no previous declaration for 'spinlock_dump' [-Wmissing-declarations]
    void spinlock_dump(spinlock_t *sp, bool full)
         ^~~~~~~~~~~~~


vim +/spinlock_dump +691 kernel/locking/qspinlock.c

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
   709			__func__, _Q_TAIL_CPU_OFFSET, _Q_TAIL_IDX_MASK, _Q_TAIL_IDX_OFFSET, _Q_LOCKED_VAL, _Q_TAIL_OFFSET, (unsigned long)sizeof(qval.tail));
   710		if (!full || cpu < 0 || idx < 0)
   711			return;
   712		msp = per_cpu_ptr(&qnodes[idx].mcs, cpu);
   713		while (i++ < nr_cpu_ids && (msp = next_to_prev(msp, &cpu, &idx))) {
   714			pr_alert("%s: Q%d CPU %d[%d] %c%d\n", __func__, i, cpu, idx,
   715				 ".L"[!!msp->locked], msp->count);
   716		}
   717		if (i >= nr_cpu_ids && cpu >= 0 && idx >= 0)
   718			pr_alert("%s: Queue output truncated.\n", __func__);
   719		else
   720			pr_alert("%s: End of queue.\n", __func__);
   721	}
   722	EXPORT_SYMBOL(spinlock_dump);
   723	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
