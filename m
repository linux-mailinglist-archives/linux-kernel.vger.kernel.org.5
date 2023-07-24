Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9675FF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGXS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGXS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:57:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63565188
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690225076; x=1721761076;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ajcmbEwmfewAP1G5zMvUTyfIiLEzqMlTeYZOfN4uE5I=;
  b=iqkvaueJu0zvbVHPkIN5Saq9SBAns7HtIz7nVWxULuaoGAaPjEZtmLgn
   CM5Hgn2azQFCdmnd5Skf+ZLd2TH7dIF3J1Rl1gGGqBRd0/FhV/uxUTjSU
   8/SfNqvgrXc+T3XUB6PAmNSUNfT1fyW+LW1Vqpvo5JZ6gcdvnch9FYS22
   NUbSSG0TRYOFLEKIZbqrSiCGqoxePXuDpQLGDJHkanXmtZPA2bq1qTmBi
   h+j9Mn+MhFEyUkf+oxYqEzdD9mcYQeouU0w+6q5Dn0cr5xy1f0nes6crr
   xt/qZRBa9VDVJl6SisPbk984/BoWXm9MnymK75sxKwyg1zYLVXv/alyTH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370196825"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370196825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 11:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="725811164"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="725811164"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2023 11:57:52 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO0kJ-0009y0-08;
        Mon, 24 Jul 2023 18:57:34 +0000
Date:   Tue, 25 Jul 2023 02:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/char/random.c:1329:1: warning: the frame size of 1360 bytes
 is larger than 1024 bytes
Message-ID: <202307250244.WRnC5csB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
commit: 1c21fe00eda76e4081535c739cf9f4bbb5dcb0ce random: spread out jitter callback to different CPUs
date:   8 months ago
config: x86_64-intel-next-customedconfig-dcg_x86_64_defconfig (https://download.01.org/0day-ci/archive/20230725/202307250244.WRnC5csB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307250244.WRnC5csB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307250244.WRnC5csB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/char/random.c: In function 'try_to_generate_entropy':
>> drivers/char/random.c:1329:1: warning: the frame size of 1360 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1329 | }
         | ^


vim +1329 drivers/char/random.c

50ee7529ec4500 Linus Torvalds     2019-09-28  1258  
50ee7529ec4500 Linus Torvalds     2019-09-28  1259  /*
0e42d14be23f4c Jason A. Donenfeld 2022-11-29  1260   * If we have an actual cycle counter, see if we can generate enough entropy
0e42d14be23f4c Jason A. Donenfeld 2022-11-29  1261   * with timing noise.
50ee7529ec4500 Linus Torvalds     2019-09-28  1262   */
560181c27b5825 Jason A. Donenfeld 2022-05-13  1263  static void __cold try_to_generate_entropy(void)
50ee7529ec4500 Linus Torvalds     2019-09-28  1264  {
122733471384be Jason A. Donenfeld 2022-10-01  1265  	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 15 };
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1266  	struct entropy_timer_state stack;
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1267  	unsigned int i, num_different = 0;
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1268  	unsigned long last = random_get_entropy();
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1269  	int cpu = -1;
50ee7529ec4500 Linus Torvalds     2019-09-28  1270  
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1271  	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
4b758eda851eb9 Jason A. Donenfeld 2022-04-12  1272  		stack.entropy = random_get_entropy();
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1273  		if (stack.entropy != last)
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1274  			++num_different;
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1275  		last = stack.entropy;
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1276  	}
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1277  	stack.samples_per_bit = DIV_ROUND_UP(NUM_TRIAL_SAMPLES, num_different + 1);
78c768e619fbd5 Jason A. Donenfeld 2022-04-22  1278  	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
50ee7529ec4500 Linus Torvalds     2019-09-28  1279  		return;
50ee7529ec4500 Linus Torvalds     2019-09-28  1280  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1281  	atomic_set(&stack.samples, 0);
50ee7529ec4500 Linus Torvalds     2019-09-28  1282  	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
3e504d2026eb6c Jason A. Donenfeld 2022-03-08  1283  	while (!crng_ready() && !signal_pending(current)) {
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1284  		/*
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1285  		 * Check !timer_pending() and then ensure that any previous callback has finished
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1286  		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1287  		 */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1288  		if (!timer_pending(&stack.timer) && try_to_del_timer_sync(&stack.timer) >= 0) {
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1289  			struct cpumask timer_cpus;
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1290  			unsigned int num_cpus;
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1291  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1292  			/*
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1293  			 * Preemption must be disabled here, both to read the current CPU number
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1294  			 * and to avoid scheduling a timer on a dead CPU.
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1295  			 */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1296  			preempt_disable();
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1297  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1298  			/* Only schedule callbacks on timer CPUs that are online. */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1299  			cpumask_and(&timer_cpus, housekeeping_cpumask(HK_TYPE_TIMER), cpu_online_mask);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1300  			num_cpus = cpumask_weight(&timer_cpus);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1301  			/* In very bizarre case of misconfiguration, fallback to all online. */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1302  			if (unlikely(num_cpus == 0)) {
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1303  				timer_cpus = *cpu_online_mask;
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1304  				num_cpus = cpumask_weight(&timer_cpus);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1305  			}
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1306  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1307  			/* Basic CPU round-robin, which avoids the current CPU. */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1308  			do {
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1309  				cpu = cpumask_next(cpu, &timer_cpus);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1310  				if (cpu == nr_cpumask_bits)
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1311  					cpu = cpumask_first(&timer_cpus);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1312  			} while (cpu == smp_processor_id() && num_cpus > 1);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1313  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1314  			/* Expiring the timer at `jiffies` means it's the next tick. */
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1315  			stack.timer.expires = jiffies;
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1316  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1317  			add_timer_on(&stack.timer, cpu);
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1318  
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1319  			preempt_enable();
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1320  		}
4b758eda851eb9 Jason A. Donenfeld 2022-04-12  1321  		mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
50ee7529ec4500 Linus Torvalds     2019-09-28  1322  		schedule();
4b758eda851eb9 Jason A. Donenfeld 2022-04-12  1323  		stack.entropy = random_get_entropy();
50ee7529ec4500 Linus Torvalds     2019-09-28  1324  	}
1c21fe00eda76e Jason A. Donenfeld 2022-10-01  1325  	mix_pool_bytes(&stack.entropy, sizeof(stack.entropy));
50ee7529ec4500 Linus Torvalds     2019-09-28  1326  
50ee7529ec4500 Linus Torvalds     2019-09-28  1327  	del_timer_sync(&stack.timer);
50ee7529ec4500 Linus Torvalds     2019-09-28  1328  	destroy_timer_on_stack(&stack.timer);
50ee7529ec4500 Linus Torvalds     2019-09-28 @1329  }
50ee7529ec4500 Linus Torvalds     2019-09-28  1330  

:::::: The code at line 1329 was first introduced by commit
:::::: 50ee7529ec4500c88f8664560770a7a1b65db72b random: try to actively add entropy rather than passively wait for it

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
