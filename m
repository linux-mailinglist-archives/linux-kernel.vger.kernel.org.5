Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89297F0456
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjKSEfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSEft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:35:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CE131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 20:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700368545; x=1731904545;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ipdxxzs29xgw279rg24xNW2TDlWc6hpsRnwtZez5B4o=;
  b=CMPgQ7qltSNmnL7RIT0bIkbsWYS872SdGOxZCXow8MiFHLV25+g+Vfuq
   ujhjFnWVgarI9YVhzNpD1s3sstiJlTWPPe0Hbb3HJD4WiauQVJXBPgd9K
   v8g/Koke808Mia1ADoR3+uHhEjcwAJq9Zs4uGNYuiMqt0Ib6TH73u618U
   iTwL5kaXMvQa7R0hU+lNWkeYo0mIbWG44OXRjLe+nbkgsN0eMAarOp00A
   BKf/NYn4nJLdcuYdhII8RxHE+S2ZNOEcobvD9netdeGgqxgi1sTjDsDsa
   yS1b8mge4rLde21vhO52alu6Y8Euen6KX0Ki83ZEkkDst96UmUfe+olwc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="391253783"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="391253783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 20:35:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="883525009"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="883525009"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2023 20:35:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4ZX4-0004eD-0C;
        Sun, 19 Nov 2023 04:35:42 +0000
Date:   Sun, 19 Nov 2023 12:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/time/hrtimer.c:1483:14: warning: variable
 'expires_in_hardirq' set but not used
Message-ID: <202311191229.55QXHVc6-lkp@intel.com>
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

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: 73d20564e0dcae003e0d79977f044d5e57496304 hrtimer: Don't dereference the hrtimer pointer after the callback
date:   3 years, 8 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231119/202311191229.55QXHVc6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191229.55QXHVc6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191229.55QXHVc6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
   kernel/time/hrtimer.c: In function '__run_hrtimer':
>> kernel/time/hrtimer.c:1483:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1483 |         bool expires_in_hardirq;
         |              ^~~~~~~~~~~~~~~~~~


vim +/expires_in_hardirq +1483 kernel/time/hrtimer.c

  1458	
  1459	/*
  1460	 * The write_seqcount_barrier()s in __run_hrtimer() split the thing into 3
  1461	 * distinct sections:
  1462	 *
  1463	 *  - queued:	the timer is queued
  1464	 *  - callback:	the timer is being ran
  1465	 *  - post:	the timer is inactive or (re)queued
  1466	 *
  1467	 * On the read side we ensure we observe timer->state and cpu_base->running
  1468	 * from the same section, if anything changed while we looked at it, we retry.
  1469	 * This includes timer->base changing because sequence numbers alone are
  1470	 * insufficient for that.
  1471	 *
  1472	 * The sequence numbers are required because otherwise we could still observe
  1473	 * a false negative if the read side got smeared over multiple consequtive
  1474	 * __run_hrtimer() invocations.
  1475	 */
  1476	
  1477	static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
  1478				  struct hrtimer_clock_base *base,
  1479				  struct hrtimer *timer, ktime_t *now,
  1480				  unsigned long flags) __must_hold(&cpu_base->lock)
  1481	{
  1482		enum hrtimer_restart (*fn)(struct hrtimer *);
> 1483		bool expires_in_hardirq;
  1484		int restart;
  1485	
  1486		lockdep_assert_held(&cpu_base->lock);
  1487	
  1488		debug_deactivate(timer);
  1489		base->running = timer;
  1490	
  1491		/*
  1492		 * Separate the ->running assignment from the ->state assignment.
  1493		 *
  1494		 * As with a regular write barrier, this ensures the read side in
  1495		 * hrtimer_active() cannot observe base->running == NULL &&
  1496		 * timer->state == INACTIVE.
  1497		 */
  1498		raw_write_seqcount_barrier(&base->seq);
  1499	
  1500		__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
  1501		fn = timer->function;
  1502	
  1503		/*
  1504		 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
  1505		 * timer is restarted with a period then it becomes an absolute
  1506		 * timer. If its not restarted it does not matter.
  1507		 */
  1508		if (IS_ENABLED(CONFIG_TIME_LOW_RES))
  1509			timer->is_rel = false;
  1510	
  1511		/*
  1512		 * The timer is marked as running in the CPU base, so it is
  1513		 * protected against migration to a different CPU even if the lock
  1514		 * is dropped.
  1515		 */
  1516		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
  1517		trace_hrtimer_expire_entry(timer, now);
  1518		expires_in_hardirq = lockdep_hrtimer_enter(timer);
  1519	
  1520		restart = fn(timer);
  1521	
  1522		lockdep_hrtimer_exit(expires_in_hardirq);
  1523		trace_hrtimer_expire_exit(timer);
  1524		raw_spin_lock_irq(&cpu_base->lock);
  1525	
  1526		/*
  1527		 * Note: We clear the running state after enqueue_hrtimer and
  1528		 * we do not reprogram the event hardware. Happens either in
  1529		 * hrtimer_start_range_ns() or in hrtimer_interrupt()
  1530		 *
  1531		 * Note: Because we dropped the cpu_base->lock above,
  1532		 * hrtimer_start_range_ns() can have popped in and enqueued the timer
  1533		 * for us already.
  1534		 */
  1535		if (restart != HRTIMER_NORESTART &&
  1536		    !(timer->state & HRTIMER_STATE_ENQUEUED))
  1537			enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
  1538	
  1539		/*
  1540		 * Separate the ->running assignment from the ->state assignment.
  1541		 *
  1542		 * As with a regular write barrier, this ensures the read side in
  1543		 * hrtimer_active() cannot observe base->running.timer == NULL &&
  1544		 * timer->state == INACTIVE.
  1545		 */
  1546		raw_write_seqcount_barrier(&base->seq);
  1547	
  1548		WARN_ON_ONCE(base->running != timer);
  1549		base->running = NULL;
  1550	}
  1551	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
