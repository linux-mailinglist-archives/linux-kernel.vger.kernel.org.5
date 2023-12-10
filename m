Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B080BA41
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjLJLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:05:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374ED9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702206365; x=1733742365;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZhUadHq0Pr+9Oje4fAA0wsi+79NCrLqBCMTxS5vtX/A=;
  b=jEwcCvornqEtGu5Z5Wmnu1d4iAlkiEjA5TnKoAXQXuu2AhEOwBjjtfLP
   sjvJNyO91klAAuaiR812TxquR3c9ef4i3k+cpV56kLLycRvQvcqV3YPUn
   8QySpGszqubl0OKbSm2FBOLXqlKgfqoVKRTMxb0ZPe2T4p1nugpGlbnaX
   Xa5xmdVqlOVmsNi+jaZjmWa7842III0NxLZDDvccVwhPRi5ksXUGkL7bb
   JAuzURN4DZoY+wEyhub7WPOx8WrAFGZMXfO5Jd60rjAkDLIh+TBpWoKL9
   XYak2NBUIjeKYKpdxA8HJ0oKCLItf1iFg8QhXLtU6qCRfveRn2WkLwvCO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1391574"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="1391574"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 03:06:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="945923452"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="945923452"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2023 03:06:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCHdI-000Gkc-2K;
        Sun, 10 Dec 2023 11:06:00 +0000
Date:   Sun, 10 Dec 2023 19:05:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:sched/core 10/15] kernel/sched/fair.c:8231:(.text+0x2b62):
 relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <202312101912.zKLp44oc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   418146e39891ef1fb2284dee4cabbfe616cd21cf
commit: c708a4dc5ab547edc3d6537233ca9e79ea30ce47 [10/15] sched: Unify more update_curr*()
config: csky-randconfig-s042-20220830 (https://download.01.org/0day-ci/archive/20231210/202312101912.zKLp44oc-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101912.zKLp44oc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101912.zKLp44oc-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.o: in function `attach_entity_load_avg':
>> include/trace/events/sched.h:743:(.text+0x2aec): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   include/trace/events/sched.h:743:(.text+0x2b0c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.o: in function `check_preempt_wakeup_fair':
>> kernel/sched/fair.c:8231:(.text+0x2b62): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:8287:(.text+0x2b88): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:8261:(.text+0x2be8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:8276:(.text+0x2c2e): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:8281:(.text+0x2c34): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.o: in function `select_idle_sibling':
   kernel/sched/fair.c:4730:(.text+0x2c94): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:7470:(.text+0x2d3a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:7472:(.text+0x2d40): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   kernel/sched/fair.c:6652:(.text+0x2d48): additional relocation overflows omitted from the output


vim +8231 kernel/sched/fair.c

02479099c28689 kernel/sched_fair.c Peter Zijlstra      2008-11-04  8206  
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8207  /*
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8208   * Preempt the current task with a newly woken task if needed:
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8209   */
82845683ca6a15 kernel/sched/fair.c Ingo Molnar         2023-09-19  8210  static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8211  {
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8212  	struct task_struct *curr = rq->curr;
8651a86c342ab7 kernel/sched_fair.c Srivatsa Vaddagiri  2007-10-15  8213  	struct sched_entity *se = &curr->se, *pse = &p->se;
4793241be408b3 kernel/sched_fair.c Peter Zijlstra      2008-11-04  8214  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
2f36825b176f67 kernel/sched_fair.c Venkatesh Pallipadi 2011-04-14  8215  	int next_buddy_marked = 0;
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8216  	int cse_is_idle, pse_is_idle;
4793241be408b3 kernel/sched_fair.c Peter Zijlstra      2008-11-04  8217  
4ae7d5cefd4aa3 kernel/sched_fair.c Ingo Molnar         2008-03-19  8218  	if (unlikely(se == pse))
4ae7d5cefd4aa3 kernel/sched_fair.c Ingo Molnar         2008-03-19  8219  		return;
4ae7d5cefd4aa3 kernel/sched_fair.c Ingo Molnar         2008-03-19  8220  
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8221  	/*
163122b7fcfa28 kernel/sched/fair.c Kirill Tkhai        2014-08-20  8222  	 * This is possible from callers such as attach_tasks(), in which we
e23edc86b09df6 kernel/sched/fair.c Ingo Molnar         2023-09-19  8223  	 * unconditionally wakeup_preempt() after an enqueue (which may have
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8224  	 * lead to a throttle).  This both saves work and prevents false
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8225  	 * next-buddy nomination below.
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8226  	 */
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8227  	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8228  		return;
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8229  
5e963f2bd4654a kernel/sched/fair.c Peter Zijlstra      2023-05-31  8230  	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
02479099c28689 kernel/sched_fair.c Peter Zijlstra      2008-11-04 @8231  		set_next_buddy(pse);
2f36825b176f67 kernel/sched_fair.c Venkatesh Pallipadi 2011-04-14  8232  		next_buddy_marked = 1;
2f36825b176f67 kernel/sched_fair.c Venkatesh Pallipadi 2011-04-14  8233  	}
57fdc26d4a734a kernel/sched_fair.c Peter Zijlstra      2008-09-23  8234  
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8235  	/*
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8236  	 * We can come here with TIF_NEED_RESCHED already set from new task
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8237  	 * wake up path.
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8238  	 *
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8239  	 * Note: this also catches the edge-case of curr being in a throttled
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8240  	 * group (e.g. via set_curr_task), since update_curr() (in the
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8241  	 * enqueue of curr) will have resulted in resched being set.  This
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8242  	 * prevents us from potentially nominating it as a false LAST_BUDDY
5238cdd3873e67 kernel/sched_fair.c Paul Turner         2011-07-21  8243  	 * below.
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8244  	 */
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8245  	if (test_tsk_need_resched(curr))
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8246  		return;
aec0a5142cb52a kernel/sched_fair.c Bharata B Rao       2008-08-28  8247  
a2f5c9ab79f78e kernel/sched_fair.c Darren Hart         2011-02-22  8248  	/* Idle tasks are by definition preempted by non-idle tasks. */
1da1843f9f0334 kernel/sched/fair.c Viresh Kumar        2018-11-05  8249  	if (unlikely(task_has_idle_policy(curr)) &&
1da1843f9f0334 kernel/sched/fair.c Viresh Kumar        2018-11-05  8250  	    likely(!task_has_idle_policy(p)))
a2f5c9ab79f78e kernel/sched_fair.c Darren Hart         2011-02-22  8251  		goto preempt;
a2f5c9ab79f78e kernel/sched_fair.c Darren Hart         2011-02-22  8252  
91c234b4e3419c kernel/sched_fair.c Ingo Molnar         2007-10-15  8253  	/*
a2f5c9ab79f78e kernel/sched_fair.c Darren Hart         2011-02-22  8254  	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
a2f5c9ab79f78e kernel/sched_fair.c Darren Hart         2011-02-22  8255  	 * is driven by the tick):
91c234b4e3419c kernel/sched_fair.c Ingo Molnar         2007-10-15  8256  	 */
8ed92e51f99c21 kernel/sched/fair.c Ingo Molnar         2012-10-14  8257  	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
91c234b4e3419c kernel/sched_fair.c Ingo Molnar         2007-10-15  8258  		return;
8651a86c342ab7 kernel/sched_fair.c Srivatsa Vaddagiri  2007-10-15  8259  
464b75273f64be kernel/sched_fair.c Peter Zijlstra      2008-10-24  8260  	find_matching_se(&se, &pse);
09348d75a6ce60 kernel/sched/fair.c Ingo Molnar         2022-08-11  8261  	WARN_ON_ONCE(!pse);
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8262  
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8263  	cse_is_idle = se_is_idle(se);
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8264  	pse_is_idle = se_is_idle(pse);
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8265  
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8266  	/*
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8267  	 * Preempt an idle group in favor of a non-idle group (and don't preempt
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8268  	 * in the inverse case).
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8269  	 */
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8270  	if (cse_is_idle && !pse_is_idle)
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8271  		goto preempt;
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8272  	if (cse_is_idle != pse_is_idle)
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8273  		return;
304000390f88d0 kernel/sched/fair.c Josh Don            2021-07-29  8274  
147f3efaa24182 kernel/sched/fair.c Peter Zijlstra      2023-05-31  8275  	cfs_rq = cfs_rq_of(se);
147f3efaa24182 kernel/sched/fair.c Peter Zijlstra      2023-05-31  8276  	update_curr(cfs_rq);
147f3efaa24182 kernel/sched/fair.c Peter Zijlstra      2023-05-31  8277  
2f36825b176f67 kernel/sched_fair.c Venkatesh Pallipadi 2011-04-14  8278  	/*
147f3efaa24182 kernel/sched/fair.c Peter Zijlstra      2023-05-31  8279  	 * XXX pick_eevdf(cfs_rq) != se ?
2f36825b176f67 kernel/sched_fair.c Venkatesh Pallipadi 2011-04-14  8280  	 */
147f3efaa24182 kernel/sched/fair.c Peter Zijlstra      2023-05-31  8281  	if (pick_eevdf(cfs_rq) == pse)
3a7e73a2e26fff kernel/sched_fair.c Peter Zijlstra      2009-11-28  8282  		goto preempt;
464b75273f64be kernel/sched_fair.c Peter Zijlstra      2008-10-24  8283  
3a7e73a2e26fff kernel/sched_fair.c Peter Zijlstra      2009-11-28  8284  	return;
a65ac745e47e91 kernel/sched_fair.c Jupyung Lee         2009-11-17  8285  
3a7e73a2e26fff kernel/sched_fair.c Peter Zijlstra      2009-11-28  8286  preempt:
8875125efe8402 kernel/sched/fair.c Kirill Tkhai        2014-06-29  8287  	resched_curr(rq);
f685ceacab07d3 kernel/sched_fair.c Mike Galbraith      2009-10-23  8288  }
bf0f6f24a1ece8 kernel/sched_fair.c Ingo Molnar         2007-07-09  8289  

:::::: The code at line 8231 was first introduced by commit
:::::: 02479099c286894644f8e96c6bbb535ab64662fd sched: fix buddies for group scheduling

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
