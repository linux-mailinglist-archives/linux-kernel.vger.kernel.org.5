Return-Path: <linux-kernel+bounces-7455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77DF81A81D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A47C286399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E74495C0;
	Wed, 20 Dec 2023 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idjsPEfZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356448CEA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703108210; x=1734644210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZgEdBUa+lo5Ong0hhJOtvtlqo2qCl/78eBKyNOrvSms=;
  b=idjsPEfZRs2OOio1RJ+PxGrSzq6KPaf8uG4dl+LdZ4gPlJCH3FIKc+0r
   rMZsFUEpoOlnrNXO+ie2red70ksoTxLWqAIZ73Y5BdntCJIsUoBTE1H6O
   aZ0Yv+vgxZPRufOd4jU2oPW4UT8SUmq2muphgu3nzukY73trdYEnBL1ZC
   v7E4+RgJSrVsoGMmOPzwCF/XmAa/3ahEKiDnFA2Qswe1Z84dFiiJxPQaA
   MXRP7cupfUYTzCzoxMhzDGWoL3t8lvF8rAXV5qBmd35HRMTTjfo87DqL3
   Cf6HWaNcaR4MgDe2W7wWgR3DgdJy5n+VweV/jHRL00U5G/iJY6+p4ZneQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="393044432"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="393044432"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 13:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920095630"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="920095630"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2023 13:36:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG4FB-0007W9-04;
	Wed, 20 Dec 2023 21:36:45 +0000
Date: Thu, 21 Dec 2023 05:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] entry: move exit to usermode functions to header
 file
Message-ID: <202312210535.lQDyVDDW-lkp@intel.com>
References: <20231218074520.1998026-2-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218074520.1998026-2-svens@linux.ibm.com>

Hi Sven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/core/entry]
[also build test WARNING on linus/master v6.7-rc6 next-20231220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/entry-move-exit-to-usermode-functions-to-header-file/20231218-154733
base:   tip/core/entry
patch link:    https://lore.kernel.org/r/20231218074520.1998026-2-svens%40linux.ibm.com
patch subject: [PATCH v2 1/3] entry: move exit to usermode functions to header file
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20231221/202312210535.lQDyVDDW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210535.lQDyVDDW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210535.lQDyVDDW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/entry/common.c:134: warning: Function parameter or struct member 'regs' not described in 'exit_to_user_mode_loop'
>> kernel/entry/common.c:134: warning: Function parameter or struct member 'ti_work' not described in 'exit_to_user_mode_loop'


vim +134 kernel/entry/common.c

a9f3a74a29af09 Thomas Gleixner     2020-07-22  128  
af18f155cb4bda Sven Schnelle       2023-12-18  129  /**
af18f155cb4bda Sven Schnelle       2023-12-18  130   * exit_to_user_mode_loop - do any pending work before leaving to user space
af18f155cb4bda Sven Schnelle       2023-12-18  131   */
af18f155cb4bda Sven Schnelle       2023-12-18  132  __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
a9f3a74a29af09 Thomas Gleixner     2020-07-22  133  						     unsigned long ti_work)
a9f3a74a29af09 Thomas Gleixner     2020-07-22 @134  {
a9f3a74a29af09 Thomas Gleixner     2020-07-22  135  	/*
a9f3a74a29af09 Thomas Gleixner     2020-07-22  136  	 * Before returning to user space ensure that all pending work
a9f3a74a29af09 Thomas Gleixner     2020-07-22  137  	 * items have been completed.
a9f3a74a29af09 Thomas Gleixner     2020-07-22  138  	 */
a9f3a74a29af09 Thomas Gleixner     2020-07-22  139  	while (ti_work & EXIT_TO_USER_MODE_WORK) {
a9f3a74a29af09 Thomas Gleixner     2020-07-22  140  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  141  		local_irq_enable_exit_to_user(ti_work);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  142  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  143  		if (ti_work & _TIF_NEED_RESCHED)
a9f3a74a29af09 Thomas Gleixner     2020-07-22  144  			schedule();
a9f3a74a29af09 Thomas Gleixner     2020-07-22  145  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  146  		if (ti_work & _TIF_UPROBE)
a9f3a74a29af09 Thomas Gleixner     2020-07-22  147  			uprobe_notify_resume(regs);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  148  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  149  		if (ti_work & _TIF_PATCH_PENDING)
a9f3a74a29af09 Thomas Gleixner     2020-07-22  150  			klp_update_patch_state(current);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  151  
12db8b690010cc Jens Axboe          2020-10-26  152  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
8ba62d37949e24 Eric W. Biederman   2022-02-09  153  			arch_do_signal_or_restart(regs);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  154  
a68de80f61f6af Sean Christopherson 2021-09-01  155  		if (ti_work & _TIF_NOTIFY_RESUME)
03248addadf1a5 Eric W. Biederman   2022-02-09  156  			resume_user_mode_work(regs);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  157  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  158  		/* Architecture specific TIF work */
a9f3a74a29af09 Thomas Gleixner     2020-07-22  159  		arch_exit_to_user_mode_work(regs, ti_work);
a9f3a74a29af09 Thomas Gleixner     2020-07-22  160  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  161  		/*
a9f3a74a29af09 Thomas Gleixner     2020-07-22  162  		 * Disable interrupts and reevaluate the work flags as they
a9f3a74a29af09 Thomas Gleixner     2020-07-22  163  		 * might have changed while interrupts and preemption was
a9f3a74a29af09 Thomas Gleixner     2020-07-22  164  		 * enabled above.
a9f3a74a29af09 Thomas Gleixner     2020-07-22  165  		 */
a9f3a74a29af09 Thomas Gleixner     2020-07-22  166  		local_irq_disable_exit_to_user();
47b8ff194c1fd7 Frederic Weisbecker 2021-02-01  167  
47b8ff194c1fd7 Frederic Weisbecker 2021-02-01  168  		/* Check if any of the above work has queued a deferred wakeup */
f268c3737ecaef Frederic Weisbecker 2021-05-27  169  		tick_nohz_user_enter_prepare();
47b8ff194c1fd7 Frederic Weisbecker 2021-02-01  170  
6ce895128b3bff Mark Rutland        2021-11-29  171  		ti_work = read_thread_flags();
a9f3a74a29af09 Thomas Gleixner     2020-07-22  172  	}
a9f3a74a29af09 Thomas Gleixner     2020-07-22  173  
a9f3a74a29af09 Thomas Gleixner     2020-07-22  174  	/* Return the latest work state for arch_exit_to_user_mode() */
a9f3a74a29af09 Thomas Gleixner     2020-07-22  175  	return ti_work;
a9f3a74a29af09 Thomas Gleixner     2020-07-22  176  }
a9f3a74a29af09 Thomas Gleixner     2020-07-22  177  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

