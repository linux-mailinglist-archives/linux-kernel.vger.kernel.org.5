Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA88025BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjLCQwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjLCQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:52:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC6F3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701622343; x=1733158343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sZ0hPBTBtzVbBUK88Od1Hdne9INnzv7sJtbuNU28180=;
  b=hV1Jc1Xi0C8x8YLN6zWjj/zCQESXEIq8iVzdgD7ap+MUQLE+PK9kYCfq
   XWLbMhT1nFj/h7BolJTeMIxdWX/Ul7qt3MIPyS6ElbZ4YFTYG7FNLHgi+
   yN5gtzypTdacVrwGJQLqv4VV4mqVcLt+sUYbAEZ5xzdeANF9U6uXsUaxx
   tvRVj9uKw9hhDAN7CACcjnIhBmjezIK/usGNv2C3W76HpCDGgjT8f5iKj
   FG+rpoSMEXi8jEt02a6W77FQVwZ8yKqiSCaOOR5yoWYwJ3oGSCyHhY2YD
   hH6/E2gwH2WSvPqq+JcTdSJoZysZkvzFDp66ZoqS5L8vdcCtJ0Ed/9tCJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="687178"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="687178"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 08:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720083249"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="720083249"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2023 08:52:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9phU-0006tW-1n;
        Sun, 03 Dec 2023 16:52:14 +0000
Date:   Mon, 4 Dec 2023 00:51:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/rcu/rcutorture.c:293:23: warning: variable 'completed' set
 but not used
Message-ID: <202312040041.wStDvPeB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: d0af39e89ec59fe7c92c4bcbc2d652ea4c0ee644 torture: Trace long read-side delays
date:   7 years ago
config: x86_64-randconfig-x001-20230722 (https://download.01.org/0day-ci/archive/20231204/202312040041.wStDvPeB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312040041.wStDvPeB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040041.wStDvPeB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from kernel/rcu/rcutorture.c:28:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:452:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     452 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   kernel/rcu/rcutorture.c: In function 'rcu_read_delay':
   kernel/rcu/rcutorture.c:296:28: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
     296 |         unsigned long long ts;
         |                            ^~
>> kernel/rcu/rcutorture.c:293:23: warning: variable 'completed' set but not used [-Wunused-but-set-variable]
     293 |         unsigned long completed;
         |                       ^~~~~~~~~
>> kernel/rcu/rcutorture.c:292:23: warning: variable 'started' set but not used [-Wunused-but-set-variable]
     292 |         unsigned long started;
         |                       ^~~~~~~
   kernel/rcu/rcutorture.c: In function 'rcu_torture_timer':
   kernel/rcu/rcutorture.c:1104:28: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
    1104 |         unsigned long long ts;
         |                            ^~
   kernel/rcu/rcutorture.c: In function 'rcu_torture_reader':
   kernel/rcu/rcutorture.c:1169:28: warning: variable 'ts' set but not used [-Wunused-but-set-variable]
    1169 |         unsigned long long ts;
         |                            ^~
   kernel/rcu/rcutorture.c: At top level:
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'rcu_torture_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   kernel/rcu/rcutorture.c:1912:1: note: in expansion of macro 'module_init'
    1912 | module_init(rcu_torture_init);
         | ^~~~~~~~~~~
   kernel/rcu/rcutorture.c:1715:1: note: 'init_module' target declared here
    1715 | rcu_torture_init(void)
         | ^~~~~~~~~~~~~~~~


vim +/completed +293 kernel/rcu/rcutorture.c

   289	
   290	static void rcu_read_delay(struct torture_random_state *rrsp)
   291	{
 > 292		unsigned long started;
 > 293		unsigned long completed;
   294		const unsigned long shortdelay_us = 200;
   295		const unsigned long longdelay_ms = 50;
   296		unsigned long long ts;
   297	
   298		/* We want a short delay sometimes to make a reader delay the grace
   299		 * period, and we want a long delay occasionally to trigger
   300		 * force_quiescent_state. */
   301	
   302		if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
   303			started = cur_ops->completed();
   304			ts = rcu_trace_clock_local();
   305			mdelay(longdelay_ms);
   306			completed = cur_ops->completed();
   307			do_trace_rcu_torture_read(cur_ops->name, NULL, ts,
   308						  started, completed);
   309		}
   310		if (!(torture_random(rrsp) % (nrealreaders * 2 * shortdelay_us)))
   311			udelay(shortdelay_us);
   312	#ifdef CONFIG_PREEMPT
   313		if (!preempt_count() &&
   314		    !(torture_random(rrsp) % (nrealreaders * 20000)))
   315			preempt_schedule();  /* No QS if preempt_disable() in effect */
   316	#endif
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
