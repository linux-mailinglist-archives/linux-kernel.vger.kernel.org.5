Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFA79A518
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjIKHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjIKHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:54:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D764F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694418886; x=1725954886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=40Vd/3MXLpUlXvowAcmvE9gBEIbt5RlbmY5yDYRdPlI=;
  b=I4/QN9qO3RzxAZqWXRhFFC9NaxXU4ucBpFCwa/YBdmUuhtP82w59xo3t
   M9u1v5pcC4nX3KsqGNrdMr1d28fD8Vk3+e7X6A3RCPHSce4KeKD9exGE1
   DCzgxkr+BjwaUBu8Yrl5i2tDi7aYJR3DKDcv3Qx8rh+SjC27vgPjNqxDK
   67l34RxfSVIuAszxYyQbSLnbYnrzEgHOFoxdkRYTqk9gHCyY+/Ju81H4v
   HsyCkIxBI5q13B2fI1b2K0oc3DdOG3Drnvb54UqhLOoVur/SoWnTONakq
   ZtzTJzhGBIffAgNd+2hY1tr0OXNLsuO03enUVTr73UYdQPIc+LjrS8rRA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368260575"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368260575"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="989995341"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="989995341"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 00:54:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfbkn-0005xQ-2j;
        Mon, 11 Sep 2023 07:54:41 +0000
Date:   Mon, 11 Sep 2023 15:54:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/time/hrtimer.c:1483:14: warning: variable
 'expires_in_hardirq' set but not used
Message-ID: <202309111514.seVql7NU-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 73d20564e0dcae003e0d79977f044d5e57496304 hrtimer: Don't dereference the hrtimer pointer after the callback
date:   3 years, 5 months ago
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20230911/202309111514.seVql7NU-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111514.seVql7NU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111514.seVql7NU-lkp@intel.com/

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
