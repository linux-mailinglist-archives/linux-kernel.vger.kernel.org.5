Return-Path: <linux-kernel+bounces-2453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431B815D59
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD93283B48
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9417F6;
	Sun, 17 Dec 2023 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emPrM9o5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F21374
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702785802; x=1734321802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VgD3cFIfzkqag+oR7EOUisxD/GwYwmANEYmZVSJ8vIY=;
  b=emPrM9o59CYhh7jtBiEVNcoY4u8PvrO0b+AG+e6qyWt0Lx5PidUdFXGS
   b4G58s0Xxww88uKCDkVMUagDSe/Sn6YZ+sJqkLR7QKgotRkZRjgceM8Va
   0mlvXPSk9PO2IS9K5bzYYIZqAe6oc/+PVuSrIsigEs30ehfo0RJHMHJZq
   XN2L55df7mbioD7yM0SslZkjVBUSGwba8YNwPEoCBfPxHQfT1hSQTMbWR
   +2kYajdVedUj96UZXww5Q1h0lCWHERtdq/REN8cJjcVCFUAXgir8RLMIN
   6V2k8qddB/TrRApoMXBiso5EqjNaf4lXeYKh3lCHLsSNIMJgbK22/a1QK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2488754"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="2488754"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 20:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="809413343"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="809413343"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2023 20:03:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEiN2-0002cA-0P;
	Sun, 17 Dec 2023 04:03:16 +0000
Date: Sun, 17 Dec 2023 12:02:28 +0800
From: kernel test robot <lkp@intel.com>
To: Junwen Wu <wudaemon@163.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, bsegall@google.com, vschneid@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, mgorman@suse.de, bristot@redhat.com,
	linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: Re: [PATCH v1] sched/debug: Update print_task formatin
  /sys/kernel/debug/sched/debug
Message-ID: <202312171141.Q5MmfuLK-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on peterz-queue/sched/core linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junwen-Wu/sched-debug-Update-print_task-formatin-sys-kernel-debug-sched-debug/20231216-234714
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231216154412.613443-1-wudaemon%40163.com
patch subject: [PATCH v1] sched/debug: Update print_task formatin  /sys/kernel/debug/sched/debug
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20231217/202312171141.Q5MmfuLK-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171141.Q5MmfuLK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171141.Q5MmfuLK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/sched/isolation.c:241:22: note: (near initialization for '__setup_housekeeping_isolcpus_setup.setup_func')
     241 | __setup("isolcpus=", housekeeping_isolcpus_setup);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:340:46: note: in definition of macro '__setup_param'
     340 |                 = { __setup_str_##unique_id, fn, early }
         |                                              ^~
   kernel/sched/isolation.c:241:1: note: in expansion of macro '__setup'
     241 | __setup("isolcpus=", housekeeping_isolcpus_setup);
         | ^~~~~~~
   kernel/sched/build_utility.c:105: error: expected declaration or statement at end of input
     105 | #endif
         | 
   kernel/sched/stop_task.c:106:20: warning: unused variable 'stop_sched_class' [-Wunused-variable]
     106 | DEFINE_SCHED_CLASS(stop) = {
         |                    ^~~~
   kernel/sched/sched.h:2335:26: note: in definition of macro 'DEFINE_SCHED_CLASS'
    2335 | const struct sched_class name##_sched_class \
         |                          ^~~~
   kernel/sched/debug.c:609:33: warning: unused variable 'p' [-Wunused-variable]
     609 |         struct task_struct *g, *p;
         |                                 ^
   kernel/sched/debug.c:609:29: warning: unused variable 'g' [-Wunused-variable]
     609 |         struct task_struct *g, *p;
         |                             ^
   kernel/sched/isolation.c: At top level:
   kernel/sched/isolation.c:82:13: warning: 'housekeeping_init' defined but not used [-Wunused-function]
      82 | void __init housekeeping_init(void)
         |             ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:249:25: warning: '__se_sys_membarrier' defined but not used [-Wunused-function]
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:614:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     614 | SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
         | ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:233:6: warning: 'membarrier_update_current_mm' defined but not used [-Wunused-function]
     233 | void membarrier_update_current_mm(struct mm_struct *next_mm)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:217:6: warning: 'membarrier_exec_mmap' defined but not used [-Wunused-function]
     217 | void membarrier_exec_mmap(struct mm_struct *mm)
         |      ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:2789:6: warning: 'partition_sched_domains' defined but not used [-Wunused-function]
    2789 | void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:2599:12: warning: 'sched_init_domains' defined but not used [-Wunused-function]
    2599 | int __init sched_init_domains(const struct cpumask *cpu_map)
         |            ^~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:2276:13: warning: '__sdt_free' defined but not used [-Wunused-function]
    2276 | static void __sdt_free(const struct cpumask *cpu_map)
         |             ^~~~~~~~~~
   kernel/sched/topology.c:2207:12: warning: '__sdt_alloc' defined but not used [-Wunused-function]
    2207 | static int __sdt_alloc(const struct cpumask *cpu_map)
         |            ^~~~~~~~~~~
   kernel/sched/topology.c:1710:13: warning: 'set_sched_topology' defined but not used [-Wunused-function]
    1710 | void __init set_sched_topology(struct sched_domain_topology_level *tl)
         |             ^~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:585:13: warning: 'init_defrootdomain' defined but not used [-Wunused-function]
     585 | void __init init_defrootdomain(void)
         |             ^~~~~~~~~~~~~~~~~~
   kernel/sched/topology.c:531:6: warning: 'sched_put_rd' defined but not used [-Wunused-function]
     531 | void sched_put_rd(struct root_domain *rd)
         |      ^~~~~~~~~~~~
   kernel/sched/topology.c:526:6: warning: 'sched_get_rd' defined but not used [-Wunused-function]
     526 | void sched_get_rd(struct root_domain *rd)
         |      ^~~~~~~~~~~~
   kernel/sched/cpupri.c:210:6: warning: 'cpupri_set' defined but not used [-Wunused-function]
     210 | void cpupri_set(struct cpupri *cp, int cpu, int newpri)
         |      ^~~~~~~~~~
   kernel/sched/cpupri.c:144:5: warning: 'cpupri_find_fitness' defined but not used [-Wunused-function]
     144 | int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
         |     ^~~~~~~~~~~~~~~~~~~
   kernel/sched/wait.c:209:6: warning: '__wake_up_pollfree' defined but not used [-Wunused-function]
     209 | void __wake_up_pollfree(struct wait_queue_head *wq_head)
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/wait.c:131:6: warning: '__wake_up_on_current_cpu' defined but not used [-Wunused-function]
     131 | void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/wait_bit.c:245:13: warning: 'wait_bit_init' defined but not used [-Wunused-function]
     245 | void __init wait_bit_init(void)
         |             ^~~~~~~~~~~~~
   kernel/sched/swait.c:125:6: warning: '__finish_swait' defined but not used [-Wunused-function]
     125 | void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
         |      ^~~~~~~~~~~~~~
   kernel/sched/swait.c:41:6: warning: 'swake_up_all_locked' defined but not used [-Wunused-function]
      41 | void swake_up_all_locked(struct swait_queue_head *q)
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/completion.c:28:6: warning: 'complete_on_current_cpu' defined but not used [-Wunused-function]
      28 | void complete_on_current_cpu(struct completion *x)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/loadavg.c:385:6: warning: 'calc_global_load_tick' defined but not used [-Wunused-function]
     385 | void calc_global_load_tick(struct rq *this_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/loadavg.c:349:6: warning: 'calc_global_load' defined but not used [-Wunused-function]
     349 | void calc_global_load(void)
         |      ^~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:156:1: warning: 'calc_load_n' defined but not used [-Wunused-function]
     156 | calc_load_n(unsigned long load, unsigned long exp,
         | ^~~~~~~~~~~
   kernel/sched/debug.c:607:13: warning: 'print_rq' defined but not used [-Wunused-function]
     607 | static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
         |             ^~~~~~~~
   kernel/sched/loadavg.c:71:6: warning: 'get_avenrun' defined but not used [-Wunused-function]
      71 | void get_avenrun(unsigned long *loads, unsigned long offset, int shift)
         |      ^~~~~~~~~~~
   kernel/sched/debug.c:575:1: warning: 'print_task' defined but not used [-Wunused-function]
     575 | print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
         | ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/calc_load_n +156 kernel/sched/loadavg.c

5c54f5b9edb1aa Johannes Weiner 2018-10-26  131  
5c54f5b9edb1aa Johannes Weiner 2018-10-26  132  /*
5c54f5b9edb1aa Johannes Weiner 2018-10-26  133   * a1 = a0 * e + a * (1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  134   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  135   * a2 = a1 * e + a * (1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  136   *    = (a0 * e + a * (1 - e)) * e + a * (1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  137   *    = a0 * e^2 + a * (1 - e) * (1 + e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  138   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  139   * a3 = a2 * e + a * (1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  140   *    = (a0 * e^2 + a * (1 - e) * (1 + e)) * e + a * (1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  141   *    = a0 * e^3 + a * (1 - e) * (1 + e + e^2)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  142   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  143   *  ...
5c54f5b9edb1aa Johannes Weiner 2018-10-26  144   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  145   * an = a0 * e^n + a * (1 - e) * (1 + e + ... + e^n-1) [1]
5c54f5b9edb1aa Johannes Weiner 2018-10-26  146   *    = a0 * e^n + a * (1 - e) * (1 - e^n)/(1 - e)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  147   *    = a0 * e^n + a * (1 - e^n)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  148   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  149   * [1] application of the geometric series:
5c54f5b9edb1aa Johannes Weiner 2018-10-26  150   *
5c54f5b9edb1aa Johannes Weiner 2018-10-26  151   *              n         1 - x^(n+1)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  152   *     S_n := \Sum x^i = -------------
5c54f5b9edb1aa Johannes Weiner 2018-10-26  153   *             i=0          1 - x
5c54f5b9edb1aa Johannes Weiner 2018-10-26  154   */
5c54f5b9edb1aa Johannes Weiner 2018-10-26  155  unsigned long
5c54f5b9edb1aa Johannes Weiner 2018-10-26 @156  calc_load_n(unsigned long load, unsigned long exp,
5c54f5b9edb1aa Johannes Weiner 2018-10-26  157  	    unsigned long active, unsigned int n)
5c54f5b9edb1aa Johannes Weiner 2018-10-26  158  {
5c54f5b9edb1aa Johannes Weiner 2018-10-26  159  	return calc_load(load, fixed_power_int(exp, FSHIFT, n), active);
5c54f5b9edb1aa Johannes Weiner 2018-10-26  160  }
5c54f5b9edb1aa Johannes Weiner 2018-10-26  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

