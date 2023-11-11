Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19597E8BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKKQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKKQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:45:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70382590
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699721097; x=1731257097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Qtiw6Ia22SvdhBRcdYGB19DGbCclQQV/GOzH4ZUZYU=;
  b=I1KVHxIpF3HB9VNCab8zS3vWTtd5gIEEo/obnb6pC5netkE1N5vxWK9s
   gtUC1F0qZDT2BxVeyY1RgaTiehXM1LqngtWw4guYLfGdrfrqs8nfNxfUJ
   dxEmAqGS/HYCA5N+7efqHZfJYwf/EEX1nkBrNDPl13cvD6kOZpeigwv3P
   gdAnC/afq+Soe6UGkB0Ktaq5dh9K/1CG2GTjZ3+4/dA/VhA7L05DM8NmS
   OY9l2gEdBKpwkD6bkg4IOkuAD1DJGP8jkxW3/VoBie1vE8+42eLsjP7I3
   LvPtknAtFT/LpqRmpyTlEC2KGaGv5ojGIya251EIMY3yS+fjK9nCuLLAc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476511627"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="476511627"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 08:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="767547743"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="767547743"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2023 08:44:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1r6L-000AcI-3B;
        Sat, 11 Nov 2023 16:44:53 +0000
Date:   Sun, 12 Nov 2023 00:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stafford Horne <shorne@gmail.com>
Subject: kernel/time/tick-broadcast.c:873: warning: Function parameter or
 member 'bc' not described in 'tick_broadcast_setup_oneshot'
Message-ID: <202311120044.hYNk7hms-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 8e6d08e0a15e7d4d4b608b56597350d4cdd77710 openrisc: initial SMP support
date:   6 years ago
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20231112/202311120044.hYNk7hms-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120044.hYNk7hms-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120044.hYNk7hms-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from kernel/time/tick-broadcast.c:14:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             \
         |                                       ^~~
   kernel/time/tick-broadcast.c: In function 'tick_broadcast_control':
   kernel/time/tick-broadcast.c:381:39: warning: this statement may fall through [-Wimplicit-fallthrough=]
     381 |                 tick_broadcast_forced = 1;
         |                 ~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/time/tick-broadcast.c:382:9: note: here
     382 |         case TICK_BROADCAST_ON:
         |         ^~~~
>> kernel/time/tick-broadcast.c:873: warning: Function parameter or member 'bc' not described in 'tick_broadcast_setup_oneshot'


vim +873 kernel/time/tick-broadcast.c

7300711e8c6824 Thomas Gleixner 2008-09-06  868  
79bf2bb335b85d Thomas Gleixner 2007-02-16  869  /**
8dce39c231af55 Li Zefan        2007-11-05  870   * tick_broadcast_setup_oneshot - setup the broadcast device
79bf2bb335b85d Thomas Gleixner 2007-02-16  871   */
94114c367553f3 Stephen Boyd    2017-06-07  872  static void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
79bf2bb335b85d Thomas Gleixner 2007-02-16 @873  {
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  874  	int cpu = smp_processor_id();
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  875  
c1a9eeb938b543 Thomas Gleixner 2016-12-15  876  	if (!bc)
c1a9eeb938b543 Thomas Gleixner 2016-12-15  877  		return;
c1a9eeb938b543 Thomas Gleixner 2016-12-15  878  
9c17bcda991000 Thomas Gleixner 2008-09-03  879  	/* Set it up only once ! */
9c17bcda991000 Thomas Gleixner 2008-09-03  880  	if (bc->event_handler != tick_handle_oneshot_broadcast) {
472c4a9437d3c6 Viresh Kumar    2015-05-21  881  		int was_periodic = clockevent_state_periodic(bc);
7300711e8c6824 Thomas Gleixner 2008-09-06  882  
79bf2bb335b85d Thomas Gleixner 2007-02-16  883  		bc->event_handler = tick_handle_oneshot_broadcast;
7300711e8c6824 Thomas Gleixner 2008-09-06  884  
7300711e8c6824 Thomas Gleixner 2008-09-06  885  		/*
7300711e8c6824 Thomas Gleixner 2008-09-06  886  		 * We must be careful here. There might be other CPUs
7300711e8c6824 Thomas Gleixner 2008-09-06  887  		 * waiting for periodic broadcast. We need to set the
7300711e8c6824 Thomas Gleixner 2008-09-06  888  		 * oneshot_mask bits for those and program the
7300711e8c6824 Thomas Gleixner 2008-09-06  889  		 * broadcast device to fire.
7300711e8c6824 Thomas Gleixner 2008-09-06  890  		 */
b352bc1cbc2913 Thomas Gleixner 2013-03-05  891  		cpumask_copy(tmpmask, tick_broadcast_mask);
b352bc1cbc2913 Thomas Gleixner 2013-03-05  892  		cpumask_clear_cpu(cpu, tmpmask);
b352bc1cbc2913 Thomas Gleixner 2013-03-05  893  		cpumask_or(tick_broadcast_oneshot_mask,
b352bc1cbc2913 Thomas Gleixner 2013-03-05  894  			   tick_broadcast_oneshot_mask, tmpmask);
7300711e8c6824 Thomas Gleixner 2008-09-06  895  
b352bc1cbc2913 Thomas Gleixner 2013-03-05  896  		if (was_periodic && !cpumask_empty(tmpmask)) {
d7eb231c71420b Thomas Gleixner 2015-06-02  897  			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
b352bc1cbc2913 Thomas Gleixner 2013-03-05  898  			tick_broadcast_init_next_event(tmpmask,
6b954823c24f04 Rusty Russell   2009-01-01  899  						       tick_next_period);
298dbd1c5cd66f Thomas Gleixner 2015-05-05  900  			tick_broadcast_set_event(bc, cpu, tick_next_period);
7300711e8c6824 Thomas Gleixner 2008-09-06  901  		} else
2456e855354415 Thomas Gleixner 2016-12-25  902  			bc->next_event = KTIME_MAX;
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  903  	} else {
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  904  		/*
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  905  		 * The first cpu which switches to oneshot mode sets
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  906  		 * the bit for all other cpus which are in the general
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  907  		 * (periodic) broadcast mask. So the bit is set and
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  908  		 * would prevent the first broadcast enter after this
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  909  		 * to program the bc device.
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  910  		 */
07f4beb0b5bbfa Thomas Gleixner 2011-05-16  911  		tick_broadcast_clear_oneshot(cpu);
79bf2bb335b85d Thomas Gleixner 2007-02-16  912  	}
9c17bcda991000 Thomas Gleixner 2008-09-03  913  }
79bf2bb335b85d Thomas Gleixner 2007-02-16  914  

:::::: The code at line 873 was first introduced by commit
:::::: 79bf2bb335b85db25d27421c798595a2fa2a0e82 [PATCH] tick-management: dyntick / highres functionality

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
