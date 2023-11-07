Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E077E4B20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjKGVti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjKGVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:49:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E3010E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699393775; x=1730929775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b+q5jfs/hj2QgcyRXxN6WEKGacc8928DRRx5Awu7oFw=;
  b=I70elGWOBI8Tg7EFzpdDth0vzNfauRM2PqBTbLWBKDHUKHInIepvA+Kr
   GSZdVx07yiDVWPmz6nPpaPWxcS8BqyTh+ppmuXlnjiBrnW6BXHzExJwsG
   AdmDF6+mqCzwldkYy7P/8WCLWV5Z7IuluSDOx4STqDmhFsv4zPDQTKJFj
   MHcG4qOQEekgQzZS5BTB9pocTtqS8793DKxZDAENLxFr2PSjxAoqiv3gc
   NIH1ckeyuGmkEVjXDbR+7OJZfG3L0M5XlxrTDP5tHnMIYB2z/nUrLJKRW
   HVnp7ZiOsaY4p7FQYzFMBFd73h+hT1dDlx86L9MA+KbALUUWZk+ZUMh80
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393553003"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="393553003"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 13:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="936297189"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="936297189"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2023 13:49:33 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Twx-0007Pl-0M;
        Tue, 07 Nov 2023 21:49:31 +0000
Date:   Wed, 8 Nov 2023 05:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202311080409.LlOfTR3m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: 7a025e91abd23effe869a05d037b26770ffa0309 mm/vmstat: Use preempt_[dis|en]able_nested()
date:   1 year, 2 months ago
config: loongarch-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080409.LlOfTR3m-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080409.LlOfTR3m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080409.LlOfTR3m-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got unsigned int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got int [noderef] __percpu *
>> mm/vmstat.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:358:9: sparse:     expected void *ptr
   mm/vmstat.c:358:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:394:9: sparse:     expected void *ptr
   mm/vmstat.c:394:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:440:9: sparse:     expected void *ptr
   mm/vmstat.c:440:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:463:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:463:9: sparse:     expected void *ptr
   mm/vmstat.c:463:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got unsigned int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:496:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/vmstat.c:496:9: sparse:     expected void *ptr
   mm/vmstat.c:496:9: sparse:     got int [noderef] __percpu *
   mm/vmstat.c:519:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/vmstat.c:519:9: sparse:     expected void *ptr

vim +358 mm/vmstat.c

   337	
   338	/*
   339	 * For use when we know that interrupts are disabled,
   340	 * or when we know that preemption is disabled and that
   341	 * particular counter cannot be updated from interrupt context.
   342	 */
   343	void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
   344				   long delta)
   345	{
   346		struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
   347		s8 __percpu *p = pcp->vm_stat_diff + item;
   348		long x;
   349		long t;
   350	
   351		/*
   352		 * Accurate vmstat updates require a RMW. On !PREEMPT_RT kernels,
   353		 * atomicity is provided by IRQs being disabled -- either explicitly
   354		 * or via local_lock_irq. On PREEMPT_RT, local_lock_irq only disables
   355		 * CPU migrations and preemption potentially corrupts a counter so
   356		 * disable preemption.
   357		 */
 > 358		preempt_disable_nested();
   359	
   360		x = delta + __this_cpu_read(*p);
   361	
   362		t = __this_cpu_read(pcp->stat_threshold);
   363	
   364		if (unlikely(abs(x) > t)) {
   365			zone_page_state_add(x, zone, item);
   366			x = 0;
   367		}
   368		__this_cpu_write(*p, x);
   369	
   370		preempt_enable_nested();
   371	}
   372	EXPORT_SYMBOL(__mod_zone_page_state);
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
