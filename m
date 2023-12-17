Return-Path: <linux-kernel+bounces-2441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE9815D3D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153E0283E5E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581DED8;
	Sun, 17 Dec 2023 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/wfUkfO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90497380
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702780639; x=1734316639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2v/4M/a702R/5bup6IDgFWIoP7jMnQ1x0k+Jh5zbPI=;
  b=U/wfUkfOvoS+RXT4ii4s3F1HpYX4b4R2N943+erT5gc3f1V3o6mbtRHD
   Fwn4jZ5DyHyARN4vC9853A82NnuMzMTS2RUNfUmLNbg1SBOp0TGtGGDnX
   wBFtyLUZOGhbDZWDMB9Djpm2vpC9iaQTHzMem8HyAvem9K4VrbrADZdIM
   9O7tHZUm33LNSvxPOy6M0ap2GSLNWT0rkKSFYd4z2NGK+jByprGAY07nX
   ZOLUbgbN3LXuHcCTwlhW9DgDJgnCt9PWyNe9gy/DdPTUpObffHk6V2nla
   2+xL8TmwAkY3d2yEV92jfaGqyYzKlJxp+VroelwY1cp3f3jXCpAXWw5Gj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="395133345"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="395133345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 18:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751364226"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="751364226"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 18:37:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEh1k-0002Wa-1H;
	Sun, 17 Dec 2023 02:37:12 +0000
Date: Sun, 17 Dec 2023 10:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Junwen Wu <wudaemon@163.com>, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	bsegall@google.com, vschneid@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, mgorman@suse.de, bristot@redhat.com,
	linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: Re: [PATCH v1] sched/debug: Update print_task formatin
  /sys/kernel/debug/sched/debug
Message-ID: <202312171007.tDZmSAZV-lkp@intel.com>
References: <20231216154412.613443-1-wudaemon@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216154412.613443-1-wudaemon@163.com>

Hi Junwen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junwen-Wu/sched-debug-Update-print_task-formatin-sys-kernel-debug-sched-debug/20231216-234714
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231216154412.613443-1-wudaemon%40163.com
patch subject: [PATCH v1] sched/debug: Update print_task formatin  /sys/kernel/debug/sched/debug
config: arm-hisi_defconfig (https://download.01.org/0day-ci/archive/20231217/202312171007.tDZmSAZV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171007.tDZmSAZV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171007.tDZmSAZV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c: In function 'print_rq':
>> kernel/sched/debug.c:1129:2: error: unterminated argument list invoking macro "SEQ_printf"
    1129 | }
         |  ^
>> kernel/sched/debug.c:613:9: error: unknown type name 'SEQ_printf'
     613 |         SEQ_printf(m, " S            task   PID         tree-key          deadline"
         |         ^~~~~~~~~~
   In file included from kernel/sched/build_utility.c:79:
>> kernel/sched/loadavg.c:58:15: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'calc_load_tasks'
      58 | atomic_long_t calc_load_tasks;
         |               ^~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_utility.c:12:
>> kernel/sched/loadavg.c:61:15: error: extern declaration of 'avenrun' follows declaration with no linkage
      61 | EXPORT_SYMBOL(avenrun); /* should be removed */
         |               ^~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/loadavg.c:61:1: note: in expansion of macro 'EXPORT_SYMBOL'
      61 | EXPORT_SYMBOL(avenrun); /* should be removed */
         | ^~~~~~~~~~~~~
   kernel/sched/loadavg.c:60:15: note: previous declaration of 'avenrun' with type 'long unsigned int[3]'
      60 | unsigned long avenrun[3];
         |               ^~~~~~~
>> kernel/sched/loadavg.c:109:1: error: invalid storage class for function 'fixed_power_int'
     109 | fixed_power_int(unsigned long x, unsigned int frac_bits, unsigned int n)
         | ^~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:208:19: error: invalid storage class for function 'calc_load_write_idx'
     208 | static inline int calc_load_write_idx(void)
         |                   ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:228:19: error: invalid storage class for function 'calc_load_read_idx'
     228 | static inline int calc_load_read_idx(void)
         |                   ^~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:233:13: error: invalid storage class for function 'calc_load_nohz_fold'
     233 | static void calc_load_nohz_fold(struct rq *rq)
         |             ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:283:13: error: invalid storage class for function 'calc_load_nohz_read'
     283 | static long calc_load_nohz_read(void)
         |             ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:303:13: error: invalid storage class for function 'calc_global_nohz'
     303 | static void calc_global_nohz(void)
         |             ^~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:80:
>> kernel/sched/completion.c:16:13: error: invalid storage class for function 'complete_with_flags'
      16 | static void complete_with_flags(struct completion *x, int wake_flags)
         |             ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:49:15: error: non-static declaration of 'complete' follows static declaration
      49 | EXPORT_SYMBOL(complete);
         |               ^~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:49:1: note: in expansion of macro 'EXPORT_SYMBOL'
      49 | EXPORT_SYMBOL(complete);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:45:6: note: previous definition of 'complete' with type 'void(struct completion *)'
      45 | void complete(struct completion *x)
         |      ^~~~~~~~
>> kernel/sched/completion.c:78:15: error: non-static declaration of 'complete_all' follows static declaration
      78 | EXPORT_SYMBOL(complete_all);
         |               ^~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:78:1: note: in expansion of macro 'EXPORT_SYMBOL'
      78 | EXPORT_SYMBOL(complete_all);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:67:6: note: previous definition of 'complete_all' with type 'void(struct completion *)'
      67 | void complete_all(struct completion *x)
         |      ^~~~~~~~~~~~
>> kernel/sched/completion.c:81:1: error: invalid storage class for function 'do_wait_for_common'
      81 | do_wait_for_common(struct completion *x,
         | ^~~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:108:1: error: invalid storage class for function '__wait_for_common'
     108 | __wait_for_common(struct completion *x,
         | ^~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:125:1: error: invalid storage class for function 'wait_for_common'
     125 | wait_for_common(struct completion *x, long timeout, int state)
         | ^~~~~~~~~~~~~~~
>> kernel/sched/completion.c:131:1: error: invalid storage class for function 'wait_for_common_io'
     131 | wait_for_common_io(struct completion *x, long timeout, int state)
         | ^~~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:150:15: error: non-static declaration of 'wait_for_completion' follows static declaration
     150 | EXPORT_SYMBOL(wait_for_completion);
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:150:1: note: in expansion of macro 'EXPORT_SYMBOL'
     150 | EXPORT_SYMBOL(wait_for_completion);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:146:14: note: previous definition of 'wait_for_completion' with type 'void(struct completion *)'
     146 | void __sched wait_for_completion(struct completion *x)
         |              ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:169:15: error: non-static declaration of 'wait_for_completion_timeout' follows static declaration
     169 | EXPORT_SYMBOL(wait_for_completion_timeout);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:169:1: note: in expansion of macro 'EXPORT_SYMBOL'
     169 | EXPORT_SYMBOL(wait_for_completion_timeout);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:165:1: note: previous definition of 'wait_for_completion_timeout' with type 'long unsigned int(struct completion *, long unsigned int)'
     165 | wait_for_completion_timeout(struct completion *x, unsigned long timeout)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/completion.c:183:15: error: non-static declaration of 'wait_for_completion_io' follows static declaration
     183 | EXPORT_SYMBOL(wait_for_completion_io);
         |               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:183:1: note: in expansion of macro 'EXPORT_SYMBOL'
     183 | EXPORT_SYMBOL(wait_for_completion_io);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:179:14: note: previous definition of 'wait_for_completion_io' with type 'void(struct completion *)'
     179 | void __sched wait_for_completion_io(struct completion *x)
         |              ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:203:15: error: non-static declaration of 'wait_for_completion_io_timeout' follows static declaration
     203 | EXPORT_SYMBOL(wait_for_completion_io_timeout);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:203:1: note: in expansion of macro 'EXPORT_SYMBOL'
     203 | EXPORT_SYMBOL(wait_for_completion_io_timeout);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:199:1: note: previous definition of 'wait_for_completion_io_timeout' with type 'long unsigned int(struct completion *, long unsigned int)'
     199 | wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:222:15: error: non-static declaration of 'wait_for_completion_interruptible' follows static declaration
     222 | EXPORT_SYMBOL(wait_for_completion_interruptible);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:222:1: note: in expansion of macro 'EXPORT_SYMBOL'
     222 | EXPORT_SYMBOL(wait_for_completion_interruptible);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:214:13: note: previous definition of 'wait_for_completion_interruptible' with type 'int(struct completion *)'
     214 | int __sched wait_for_completion_interruptible(struct completion *x)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:241:15: error: non-static declaration of 'wait_for_completion_interruptible_timeout' follows static declaration
     241 | EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:241:1: note: in expansion of macro 'EXPORT_SYMBOL'
     241 | EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:236:1: note: previous definition of 'wait_for_completion_interruptible_timeout' with type 'long int(struct completion *, long unsigned int)'
     236 | wait_for_completion_interruptible_timeout(struct completion *x,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:260:15: error: non-static declaration of 'wait_for_completion_killable' follows static declaration
     260 | EXPORT_SYMBOL(wait_for_completion_killable);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:260:1: note: in expansion of macro 'EXPORT_SYMBOL'
     260 | EXPORT_SYMBOL(wait_for_completion_killable);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:252:13: note: previous definition of 'wait_for_completion_killable' with type 'int(struct completion *)'
     252 | int __sched wait_for_completion_killable(struct completion *x)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:270:15: error: non-static declaration of 'wait_for_completion_state' follows static declaration
     270 | EXPORT_SYMBOL(wait_for_completion_state);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:270:1: note: in expansion of macro 'EXPORT_SYMBOL'
     270 | EXPORT_SYMBOL(wait_for_completion_state);
         | ^~~~~~~~~~~~~
   kernel/sched/completion.c:262:13: note: previous definition of 'wait_for_completion_state' with type 'int(struct completion *, unsigned int)'
     262 | int __sched wait_for_completion_state(struct completion *x, unsigned int state)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:290:15: error: non-static declaration of 'wait_for_completion_killable_timeout' follows static declaration
     290 | EXPORT_SYMBOL(wait_for_completion_killable_timeout);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   kernel/sched/completion.c:290:1: note: in expansion of macro 'EXPORT_SYMBOL'
     290 | EXPORT_SYMBOL(wait_for_completion_killable_timeout);


vim +/SEQ_printf +1129 kernel/sched/debug.c

c006fac556e401 Paul Turner 2021-04-16  1120  
c006fac556e401 Paul Turner 2021-04-16  1121  void resched_latency_warn(int cpu, u64 latency)
c006fac556e401 Paul Turner 2021-04-16  1122  {
c006fac556e401 Paul Turner 2021-04-16  1123  	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
c006fac556e401 Paul Turner 2021-04-16  1124  
c006fac556e401 Paul Turner 2021-04-16  1125  	WARN(__ratelimit(&latency_check_ratelimit),
c006fac556e401 Paul Turner 2021-04-16  1126  	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
c006fac556e401 Paul Turner 2021-04-16  1127  	     "without schedule\n",
c006fac556e401 Paul Turner 2021-04-16  1128  	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
c006fac556e401 Paul Turner 2021-04-16 @1129  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

