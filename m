Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003777F233
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348969AbjHQI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbjHQI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748113E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692260957; x=1723796957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AVoxAPrPGXPAYHR5pzQIokSDae3tHBNnewTLx/I2BYI=;
  b=S+9DwLhkB1AL/HqI2rBINugKTBJP9/Y4fEtHzdEXUbIoFu0cYQAPYXu0
   CblMuFPbAWzREo2CHRgdE+h9GeGDNYYjc5YrME9G5ukKoxq0xa7XBa2Ls
   2nCxEYtjHmyT18Dxu9jgVKVl8gptl6wmKmJLcCJxnI7JqYk/DHK7gXTuB
   j8/hG3PG/I/lS9EZizX76d7dcwTH97WqEDbyhS5T76JKgFojQTNjsIBMD
   iYZz/SyhWI4FEar1aljkw0g6uhx/5OwBFYXFLOFeobltWOfp6TCk7CSbn
   HiK8DSHz4GXLQRbKVxO58RgCkFEjikkA1GAu3Bz9hR8W36LnBy9gfCn4u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436653430"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="436653430"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="858150609"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="858150609"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 01:29:15 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWYNR-0000wz-20;
        Thu, 17 Aug 2023 08:29:10 +0000
Date:   Thu, 17 Aug 2023 16:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: kernel/time/tick-broadcast.c:1026: warning: Function parameter or
 member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'
Message-ID: <202308171624.uh1qEoWo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: f9d36cf445ffff0b913ba187a3eff78028f9b1fb tick/broadcast: Make broadcast device replacement work correctly
date:   3 months ago
config: i386-randconfig-i013-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171624.uh1qEoWo-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171624.uh1qEoWo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171624.uh1qEoWo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/time/tick-broadcast.c:1026: warning: Function parameter or member 'bc' not described in 'tick_broadcast_setup_oneshot'
>> kernel/time/tick-broadcast.c:1026: warning: Function parameter or member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'


vim +1026 kernel/time/tick-broadcast.c

f73f64d5687192 Thomas Gleixner 2020-11-17  1020  
79bf2bb335b85d Thomas Gleixner 2007-02-16  1021  /**
8dce39c231af55 Li Zefan        2007-11-05  1022   * tick_broadcast_setup_oneshot - setup the broadcast device
79bf2bb335b85d Thomas Gleixner 2007-02-16  1023   */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1024  static void tick_broadcast_setup_oneshot(struct clock_event_device *bc,
f9d36cf445ffff Thomas Gleixner 2023-05-06  1025  					 bool from_periodic)
79bf2bb335b85d Thomas Gleixner 2007-02-16 @1026  {
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  1027  	int cpu = smp_processor_id();
f9d36cf445ffff Thomas Gleixner 2023-05-06  1028  	ktime_t nexttick = 0;
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  1029  
c1a9eeb938b543 Thomas Gleixner 2016-12-15  1030  	if (!bc)
c1a9eeb938b543 Thomas Gleixner 2016-12-15  1031  		return;
c1a9eeb938b543 Thomas Gleixner 2016-12-15  1032  
f9d36cf445ffff Thomas Gleixner 2023-05-06  1033  	/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1034  	 * When the broadcast device was switched to oneshot by the first
f9d36cf445ffff Thomas Gleixner 2023-05-06  1035  	 * CPU handling the NOHZ change, the other CPUs will reach this
f9d36cf445ffff Thomas Gleixner 2023-05-06  1036  	 * code via hrtimer_run_queues() -> tick_check_oneshot_change()
f9d36cf445ffff Thomas Gleixner 2023-05-06  1037  	 * too. Set up the broadcast device only once!
f9d36cf445ffff Thomas Gleixner 2023-05-06  1038  	 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1039  	if (bc->event_handler == tick_handle_oneshot_broadcast) {
f9d36cf445ffff Thomas Gleixner 2023-05-06  1040  		/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1041  		 * The CPU which switched from periodic to oneshot mode
f9d36cf445ffff Thomas Gleixner 2023-05-06  1042  		 * set the broadcast oneshot bit for all other CPUs which
f9d36cf445ffff Thomas Gleixner 2023-05-06  1043  		 * are in the general (periodic) broadcast mask to ensure
f9d36cf445ffff Thomas Gleixner 2023-05-06  1044  		 * that CPUs which wait for the periodic broadcast are
f9d36cf445ffff Thomas Gleixner 2023-05-06  1045  		 * woken up.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1046  		 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1047  		 * Clear the bit for the local CPU as the set bit would
f9d36cf445ffff Thomas Gleixner 2023-05-06  1048  		 * prevent the first tick_broadcast_enter() after this CPU
f9d36cf445ffff Thomas Gleixner 2023-05-06  1049  		 * switched to oneshot state to program the broadcast
f9d36cf445ffff Thomas Gleixner 2023-05-06  1050  		 * device.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1051  		 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1052  		 * This code can also be reached via tick_broadcast_control(),
f9d36cf445ffff Thomas Gleixner 2023-05-06  1053  		 * but this cannot avoid the tick_broadcast_clear_oneshot()
f9d36cf445ffff Thomas Gleixner 2023-05-06  1054  		 * as that would break the periodic to oneshot transition of
f9d36cf445ffff Thomas Gleixner 2023-05-06  1055  		 * secondary CPUs. But that's harmless as the below only
f9d36cf445ffff Thomas Gleixner 2023-05-06  1056  		 * clears already cleared bits.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1057  		 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1058  		tick_broadcast_clear_oneshot(cpu);
f9d36cf445ffff Thomas Gleixner 2023-05-06  1059  		return;
f9d36cf445ffff Thomas Gleixner 2023-05-06  1060  	}
f9d36cf445ffff Thomas Gleixner 2023-05-06  1061  
7300711e8c6824 Thomas Gleixner 2008-09-06  1062  
79bf2bb335b85d Thomas Gleixner 2007-02-16  1063  	bc->event_handler = tick_handle_oneshot_broadcast;
f9d36cf445ffff Thomas Gleixner 2023-05-06  1064  	bc->next_event = KTIME_MAX;
7300711e8c6824 Thomas Gleixner 2008-09-06  1065  
7300711e8c6824 Thomas Gleixner 2008-09-06  1066  	/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1067  	 * When the tick mode is switched from periodic to oneshot it must
f9d36cf445ffff Thomas Gleixner 2023-05-06  1068  	 * be ensured that CPUs which are waiting for periodic broadcast
f9d36cf445ffff Thomas Gleixner 2023-05-06  1069  	 * get their wake-up at the next tick.  This is achieved by ORing
f9d36cf445ffff Thomas Gleixner 2023-05-06  1070  	 * tick_broadcast_mask into tick_broadcast_oneshot_mask.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1071  	 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1072  	 * For other callers, e.g. broadcast device replacement,
f9d36cf445ffff Thomas Gleixner 2023-05-06  1073  	 * tick_broadcast_oneshot_mask must not be touched as this would
f9d36cf445ffff Thomas Gleixner 2023-05-06  1074  	 * set bits for CPUs which are already NOHZ, but not idle. Their
f9d36cf445ffff Thomas Gleixner 2023-05-06  1075  	 * next tick_broadcast_enter() would observe the bit set and fail
f9d36cf445ffff Thomas Gleixner 2023-05-06  1076  	 * to update the expiry time and the broadcast event device.
7300711e8c6824 Thomas Gleixner 2008-09-06  1077  	 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1078  	if (from_periodic) {
b352bc1cbc2913 Thomas Gleixner 2013-03-05  1079  		cpumask_copy(tmpmask, tick_broadcast_mask);
f9d36cf445ffff Thomas Gleixner 2023-05-06  1080  		/* Remove the local CPU as it is obviously not idle */
b352bc1cbc2913 Thomas Gleixner 2013-03-05  1081  		cpumask_clear_cpu(cpu, tmpmask);
f9d36cf445ffff Thomas Gleixner 2023-05-06  1082  		cpumask_or(tick_broadcast_oneshot_mask, tick_broadcast_oneshot_mask, tmpmask);
7300711e8c6824 Thomas Gleixner 2008-09-06  1083  
f9d36cf445ffff Thomas Gleixner 2023-05-06  1084  		/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1085  		 * Ensure that the oneshot broadcast handler will wake the
f9d36cf445ffff Thomas Gleixner 2023-05-06  1086  		 * CPUs which are still waiting for periodic broadcast.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1087  		 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1088  		nexttick = tick_get_next_period();
f9d36cf445ffff Thomas Gleixner 2023-05-06  1089  		tick_broadcast_init_next_event(tmpmask, nexttick);
f73f64d5687192 Thomas Gleixner 2020-11-17  1090  
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  1091  		/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1092  		 * If the underlying broadcast clock event device is
f9d36cf445ffff Thomas Gleixner 2023-05-06  1093  		 * already in oneshot state, then there is nothing to do.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1094  		 * The device was already armed for the next tick
f9d36cf445ffff Thomas Gleixner 2023-05-06  1095  		 * in tick_handle_broadcast_periodic()
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  1096  		 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1097  		if (clockevent_state_oneshot(bc))
f9d36cf445ffff Thomas Gleixner 2023-05-06  1098  			return;
79bf2bb335b85d Thomas Gleixner 2007-02-16  1099  	}
f9d36cf445ffff Thomas Gleixner 2023-05-06  1100  
f9d36cf445ffff Thomas Gleixner 2023-05-06  1101  	/*
f9d36cf445ffff Thomas Gleixner 2023-05-06  1102  	 * When switching from periodic to oneshot mode arm the broadcast
f9d36cf445ffff Thomas Gleixner 2023-05-06  1103  	 * device for the next tick.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1104  	 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1105  	 * If the broadcast device has been replaced in oneshot mode and
f9d36cf445ffff Thomas Gleixner 2023-05-06  1106  	 * the oneshot broadcast mask is not empty, then arm it to expire
f9d36cf445ffff Thomas Gleixner 2023-05-06  1107  	 * immediately in order to reevaluate the next expiring timer.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1108  	 * @nexttick is 0 and therefore in the past which will cause the
f9d36cf445ffff Thomas Gleixner 2023-05-06  1109  	 * clockevent code to force an event.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1110  	 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1111  	 * For both cases the programming can be avoided when the oneshot
f9d36cf445ffff Thomas Gleixner 2023-05-06  1112  	 * broadcast mask is empty.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1113  	 *
f9d36cf445ffff Thomas Gleixner 2023-05-06  1114  	 * tick_broadcast_set_event() implicitly switches the broadcast
f9d36cf445ffff Thomas Gleixner 2023-05-06  1115  	 * device to oneshot state.
f9d36cf445ffff Thomas Gleixner 2023-05-06  1116  	 */
f9d36cf445ffff Thomas Gleixner 2023-05-06  1117  	if (!cpumask_empty(tick_broadcast_oneshot_mask))
f9d36cf445ffff Thomas Gleixner 2023-05-06  1118  		tick_broadcast_set_event(bc, cpu, nexttick);
9c17bcda991000 Thomas Gleixner 2008-09-03  1119  }
79bf2bb335b85d Thomas Gleixner 2007-02-16  1120  

:::::: The code at line 1026 was first introduced by commit
:::::: 79bf2bb335b85db25d27421c798595a2fa2a0e82 [PATCH] tick-management: dyntick / highres functionality

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
