Return-Path: <linux-kernel+bounces-2482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC406815DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BA8B20D09
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB32817FF;
	Sun, 17 Dec 2023 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2anfCpZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F917E6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702793494; x=1734329494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IoybD3HXakUoweSjvSKyVf/XwtoBXXNbQM06gzuHkhQ=;
  b=b2anfCpZZhedD2ntlhaoq+1xR497kLZv0aVDY9aOvR2m7G6PRX969aRH
   rMI5TYeJaEKOYkL3yWSNxqwt53V5uA1/p/w8Hbs3d7pIDNkgNb2cJVost
   J7dLwsy33QEx/nnmtsqRHpkorsv+g56CFpClzkdwr8k5yJy6DOpTmaJQp
   bqf02bSPm7opIcLFHH0nD75FUhTl1gzOHJIUjLGwzj+sqsVqWJTJbsEFL
   sMV1+hpsjDF0+9UzivQICpc5RtK8FkQfSHnW1WUEs3/FdPh/WDs6BsY0o
   I5NLGpvxtQDcQkOCWJszdUNEoZjVZNDxQdAZl0wzeRjBhF3IAKxq8E8Eq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="380395012"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="380395012"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 22:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="23335484"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Dec 2023 22:11:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEkN5-0002iy-3A;
	Sun, 17 Dec 2023 06:11:27 +0000
Date: Sun, 17 Dec 2023 14:10:31 +0800
From: kernel test robot <lkp@intel.com>
To: Junwen Wu <wudaemon@163.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, bsegall@google.com, vschneid@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, mgorman@suse.de, bristot@redhat.com,
	linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: Re: [PATCH v1] sched/debug: Update print_task formatin
  /sys/kernel/debug/sched/debug
Message-ID: <202312171356.HVYTuiSz-lkp@intel.com>
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
config: i386-randconfig-014-20231217 (https://download.01.org/0day-ci/archive/20231217/202312171356.HVYTuiSz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171356.HVYTuiSz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171356.HVYTuiSz-lkp@intel.com/

All warnings (new ones prefixed by >>):

     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:614:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     614 | SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
         | ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c: In function 'print_rq':
   arch/x86/include/asm/syscall_wrapper.h:240:28: error: invalid storage class for function '__do_sys_membarrier'
     240 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
         |                            ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:614:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     614 | SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
         | ^~~~~~~~~~~~~~~
   kernel/sched/build_utility.c:101: error: expected declaration or statement at end of input
     101 | #endif
         | 
   In file included from kernel/sched/build_utility.c:52:
   kernel/sched/stop_task.c:106:20: warning: unused variable 'stop_sched_class' [-Wunused-variable]
     106 | DEFINE_SCHED_CLASS(stop) = {
         |                    ^~~~
   kernel/sched/sched.h:2335:26: note: in definition of macro 'DEFINE_SCHED_CLASS'
    2335 | const struct sched_class name##_sched_class \
         |                          ^~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:609:33: warning: unused variable 'p' [-Wunused-variable]
     609 |         struct task_struct *g, *p;
         |                                 ^
   kernel/sched/debug.c:609:29: warning: unused variable 'g' [-Wunused-variable]
     609 |         struct task_struct *g, *p;
         |                             ^
   In file included from include/linux/syscalls.h:100,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:61,
                    from kernel/sched/build_utility.c:52:
   At top level:
   arch/x86/include/asm/syscall_wrapper.h:233:21: warning: '__se_sys_membarrier' defined but not used [-Wunused-function]
     233 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))      \
         |                     ^~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:614:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     614 | SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:77:14: warning: '__ia32_sys_membarrier' defined but not used [-Wunused-function]
      77 |         long __##abi##_##name(const struct pt_regs *regs)               \
         |              ^~
   arch/x86/include/asm/syscall_wrapper.h:117:9: note: in expansion of macro '__SYS_STUBx'
     117 |         __SYS_STUBx(ia32, sys##name,                                    \
         |         ^~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:232:9: note: in expansion of macro '__IA32_SYS_STUBx'
     232 |         __IA32_SYS_STUBx(x, name, __VA_ARGS__)                          \
         |         ^~~~~~~~~~~~~~~~
   include/linux/syscalls.h:230:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:614:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     614 | SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
         | ^~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:100:
   kernel/sched/membarrier.c:233:6: warning: 'membarrier_update_current_mm' defined but not used [-Wunused-function]
     233 | void membarrier_update_current_mm(struct mm_struct *next_mm)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/membarrier.c:217:6: warning: 'membarrier_exec_mmap' defined but not used [-Wunused-function]
     217 | void membarrier_exec_mmap(struct mm_struct *mm)
         |      ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:96:
   kernel/sched/psi.c:1190:6: warning: 'psi_cgroup_restart' defined but not used [-Wunused-function]
    1190 | void psi_cgroup_restart(struct psi_group *group)
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/psi.c:1135:6: warning: 'cgroup_move_task' defined but not used [-Wunused-function]
    1135 | void cgroup_move_task(struct task_struct *task, struct css_set *to)
         |      ^~~~~~~~~~~~~~~~
   kernel/sched/psi.c:1111:6: warning: 'psi_cgroup_free' defined but not used [-Wunused-function]
    1111 | void psi_cgroup_free(struct cgroup *cgroup)
         |      ^~~~~~~~~~~~~~~
   kernel/sched/psi.c:1092:5: warning: 'psi_cgroup_alloc' defined but not used [-Wunused-function]
    1092 | int psi_cgroup_alloc(struct cgroup *cgroup)
         |     ^~~~~~~~~~~~~~~~
   kernel/sched/psi.c:916:6: warning: 'psi_task_switch' defined but not used [-Wunused-function]
     916 | void psi_task_switch(struct task_struct *prev, struct task_struct *next,
         |      ^~~~~~~~~~~~~~~
   kernel/sched/psi.c:730:13: warning: 'poll_timer_fn' defined but not used [-Wunused-function]
     730 | static void poll_timer_fn(struct timer_list *t)
         |             ^~~~~~~~~~~~~
   kernel/sched/psi.c:206:13: warning: 'psi_init' defined but not used [-Wunused-function]
     206 | void __init psi_init(void)
         |             ^~~~~~~~
   In file included from kernel/sched/build_utility.c:92:
>> kernel/sched/core_sched.c:289:6: warning: '__sched_core_tick' defined but not used [-Wunused-function]
     289 | void __sched_core_tick(struct rq *rq)
         |      ^~~~~~~~~~~~~~~~~
>> kernel/sched/core_sched.c:129:5: warning: 'sched_core_share_pid' defined but not used [-Wunused-function]
     129 | int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core_sched.c:116:6: warning: 'sched_core_free' defined but not used [-Wunused-function]
     116 | void sched_core_free(struct task_struct *p)
         |      ^~~~~~~~~~~~~~~
>> kernel/sched/core_sched.c:110:6: warning: 'sched_core_fork' defined but not used [-Wunused-function]
     110 | void sched_core_fork(struct task_struct *p)
         |      ^~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:88:
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
   In file included from kernel/sched/build_utility.c:86:
   kernel/sched/cpupri.c:210:6: warning: 'cpupri_set' defined but not used [-Wunused-function]
     210 | void cpupri_set(struct cpupri *cp, int cpu, int newpri)
         |      ^~~~~~~~~~
   kernel/sched/cpupri.c:144:5: warning: 'cpupri_find_fitness' defined but not used [-Wunused-function]
     144 | int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:83:
   kernel/sched/wait.c:209:6: warning: '__wake_up_pollfree' defined but not used [-Wunused-function]
     209 | void __wake_up_pollfree(struct wait_queue_head *wq_head)
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/wait.c:131:6: warning: '__wake_up_on_current_cpu' defined but not used [-Wunused-function]
     131 | void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:82:
   kernel/sched/wait_bit.c:245:13: warning: 'wait_bit_init' defined but not used [-Wunused-function]
     245 | void __init wait_bit_init(void)
         |             ^~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:81:
   kernel/sched/swait.c:125:6: warning: '__finish_swait' defined but not used [-Wunused-function]
     125 | void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
         |      ^~~~~~~~~~~~~~
   kernel/sched/swait.c:41:6: warning: 'swake_up_all_locked' defined but not used [-Wunused-function]
      41 | void swake_up_all_locked(struct swait_queue_head *q)
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:80:
   kernel/sched/completion.c:28:6: warning: 'complete_on_current_cpu' defined but not used [-Wunused-function]
      28 | void complete_on_current_cpu(struct completion *x)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:79:
   kernel/sched/loadavg.c:385:6: warning: 'calc_global_load_tick' defined but not used [-Wunused-function]
     385 | void calc_global_load_tick(struct rq *this_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/loadavg.c:349:6: warning: 'calc_global_load' defined but not used [-Wunused-function]
     349 | void calc_global_load(void)
         |      ^~~~~~~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:607:13: warning: 'print_rq' defined but not used [-Wunused-function]
     607 | static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
         |             ^~~~~~~~
   In file included from kernel/sched/build_utility.c:79:
   kernel/sched/loadavg.c:71:6: warning: 'get_avenrun' defined but not used [-Wunused-function]
      71 | void get_avenrun(unsigned long *loads, unsigned long offset, int shift)
         |      ^~~~~~~~~~~
   In file included from kernel/sched/build_utility.c:72:
   kernel/sched/debug.c:575:1: warning: 'print_task' defined but not used [-Wunused-function]
     575 | print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
         | ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__sched_core_tick +289 kernel/sched/core_sched.c

6e33cad0af4933 Peter Zijlstra       2021-03-26  109  
85dd3f61203c5c Peter Zijlstra       2021-03-29 @110  void sched_core_fork(struct task_struct *p)
85dd3f61203c5c Peter Zijlstra       2021-03-29  111  {
85dd3f61203c5c Peter Zijlstra       2021-03-29  112  	RB_CLEAR_NODE(&p->core_node);
85dd3f61203c5c Peter Zijlstra       2021-03-29  113  	p->core_cookie = sched_core_clone_cookie(current);
85dd3f61203c5c Peter Zijlstra       2021-03-29  114  }
85dd3f61203c5c Peter Zijlstra       2021-03-29  115  
6e33cad0af4933 Peter Zijlstra       2021-03-26 @116  void sched_core_free(struct task_struct *p)
6e33cad0af4933 Peter Zijlstra       2021-03-26  117  {
6e33cad0af4933 Peter Zijlstra       2021-03-26  118  	sched_core_put_cookie(p->core_cookie);
6e33cad0af4933 Peter Zijlstra       2021-03-26  119  }
7ac592aa35a684 Chris Hyser          2021-03-24  120  
7ac592aa35a684 Chris Hyser          2021-03-24  121  static void __sched_core_set(struct task_struct *p, unsigned long cookie)
7ac592aa35a684 Chris Hyser          2021-03-24  122  {
7ac592aa35a684 Chris Hyser          2021-03-24  123  	cookie = sched_core_get_cookie(cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  124  	cookie = sched_core_update_cookie(p, cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  125  	sched_core_put_cookie(cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  126  }
7ac592aa35a684 Chris Hyser          2021-03-24  127  
7ac592aa35a684 Chris Hyser          2021-03-24  128  /* Called from prctl interface: PR_SCHED_CORE */
7ac592aa35a684 Chris Hyser          2021-03-24 @129  int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
7ac592aa35a684 Chris Hyser          2021-03-24  130  			 unsigned long uaddr)
7ac592aa35a684 Chris Hyser          2021-03-24  131  {
7ac592aa35a684 Chris Hyser          2021-03-24  132  	unsigned long cookie = 0, id = 0;
7ac592aa35a684 Chris Hyser          2021-03-24  133  	struct task_struct *task, *p;
7ac592aa35a684 Chris Hyser          2021-03-24  134  	struct pid *grp;
7ac592aa35a684 Chris Hyser          2021-03-24  135  	int err = 0;
7ac592aa35a684 Chris Hyser          2021-03-24  136  
7ac592aa35a684 Chris Hyser          2021-03-24  137  	if (!static_branch_likely(&sched_smt_present))
7ac592aa35a684 Chris Hyser          2021-03-24  138  		return -ENODEV;
7ac592aa35a684 Chris Hyser          2021-03-24  139  
61bc346ce64a38 Eugene Syromiatnikov 2021-08-25  140  	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD != PIDTYPE_PID);
61bc346ce64a38 Eugene Syromiatnikov 2021-08-25  141  	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD_GROUP != PIDTYPE_TGID);
61bc346ce64a38 Eugene Syromiatnikov 2021-08-25  142  	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_PROCESS_GROUP != PIDTYPE_PGID);
61bc346ce64a38 Eugene Syromiatnikov 2021-08-25  143  
7ac592aa35a684 Chris Hyser          2021-03-24  144  	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
7ac592aa35a684 Chris Hyser          2021-03-24  145  	    (cmd != PR_SCHED_CORE_GET && uaddr))
7ac592aa35a684 Chris Hyser          2021-03-24  146  		return -EINVAL;
7ac592aa35a684 Chris Hyser          2021-03-24  147  
7ac592aa35a684 Chris Hyser          2021-03-24  148  	rcu_read_lock();
7ac592aa35a684 Chris Hyser          2021-03-24  149  	if (pid == 0) {
7ac592aa35a684 Chris Hyser          2021-03-24  150  		task = current;
7ac592aa35a684 Chris Hyser          2021-03-24  151  	} else {
7ac592aa35a684 Chris Hyser          2021-03-24  152  		task = find_task_by_vpid(pid);
7ac592aa35a684 Chris Hyser          2021-03-24  153  		if (!task) {
7ac592aa35a684 Chris Hyser          2021-03-24  154  			rcu_read_unlock();
7ac592aa35a684 Chris Hyser          2021-03-24  155  			return -ESRCH;
7ac592aa35a684 Chris Hyser          2021-03-24  156  		}
7ac592aa35a684 Chris Hyser          2021-03-24  157  	}
7ac592aa35a684 Chris Hyser          2021-03-24  158  	get_task_struct(task);
7ac592aa35a684 Chris Hyser          2021-03-24  159  	rcu_read_unlock();
7ac592aa35a684 Chris Hyser          2021-03-24  160  
7ac592aa35a684 Chris Hyser          2021-03-24  161  	/*
7ac592aa35a684 Chris Hyser          2021-03-24  162  	 * Check if this process has the right to modify the specified
7ac592aa35a684 Chris Hyser          2021-03-24  163  	 * process. Use the regular "ptrace_may_access()" checks.
7ac592aa35a684 Chris Hyser          2021-03-24  164  	 */
7ac592aa35a684 Chris Hyser          2021-03-24  165  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
7ac592aa35a684 Chris Hyser          2021-03-24  166  		err = -EPERM;
7ac592aa35a684 Chris Hyser          2021-03-24  167  		goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  168  	}
7ac592aa35a684 Chris Hyser          2021-03-24  169  
7ac592aa35a684 Chris Hyser          2021-03-24  170  	switch (cmd) {
7ac592aa35a684 Chris Hyser          2021-03-24  171  	case PR_SCHED_CORE_GET:
7ac592aa35a684 Chris Hyser          2021-03-24  172  		if (type != PIDTYPE_PID || uaddr & 7) {
7ac592aa35a684 Chris Hyser          2021-03-24  173  			err = -EINVAL;
7ac592aa35a684 Chris Hyser          2021-03-24  174  			goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  175  		}
7ac592aa35a684 Chris Hyser          2021-03-24  176  		cookie = sched_core_clone_cookie(task);
7ac592aa35a684 Chris Hyser          2021-03-24  177  		if (cookie) {
7ac592aa35a684 Chris Hyser          2021-03-24  178  			/* XXX improve ? */
7ac592aa35a684 Chris Hyser          2021-03-24  179  			ptr_to_hashval((void *)cookie, &id);
7ac592aa35a684 Chris Hyser          2021-03-24  180  		}
7ac592aa35a684 Chris Hyser          2021-03-24  181  		err = put_user(id, (u64 __user *)uaddr);
7ac592aa35a684 Chris Hyser          2021-03-24  182  		goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  183  
7ac592aa35a684 Chris Hyser          2021-03-24  184  	case PR_SCHED_CORE_CREATE:
7ac592aa35a684 Chris Hyser          2021-03-24  185  		cookie = sched_core_alloc_cookie();
7ac592aa35a684 Chris Hyser          2021-03-24  186  		if (!cookie) {
7ac592aa35a684 Chris Hyser          2021-03-24  187  			err = -ENOMEM;
7ac592aa35a684 Chris Hyser          2021-03-24  188  			goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  189  		}
7ac592aa35a684 Chris Hyser          2021-03-24  190  		break;
7ac592aa35a684 Chris Hyser          2021-03-24  191  
7ac592aa35a684 Chris Hyser          2021-03-24  192  	case PR_SCHED_CORE_SHARE_TO:
7ac592aa35a684 Chris Hyser          2021-03-24  193  		cookie = sched_core_clone_cookie(current);
7ac592aa35a684 Chris Hyser          2021-03-24  194  		break;
7ac592aa35a684 Chris Hyser          2021-03-24  195  
7ac592aa35a684 Chris Hyser          2021-03-24  196  	case PR_SCHED_CORE_SHARE_FROM:
7ac592aa35a684 Chris Hyser          2021-03-24  197  		if (type != PIDTYPE_PID) {
7ac592aa35a684 Chris Hyser          2021-03-24  198  			err = -EINVAL;
7ac592aa35a684 Chris Hyser          2021-03-24  199  			goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  200  		}
7ac592aa35a684 Chris Hyser          2021-03-24  201  		cookie = sched_core_clone_cookie(task);
7ac592aa35a684 Chris Hyser          2021-03-24  202  		__sched_core_set(current, cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  203  		goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  204  
7ac592aa35a684 Chris Hyser          2021-03-24  205  	default:
7ac592aa35a684 Chris Hyser          2021-03-24  206  		err = -EINVAL;
7ac592aa35a684 Chris Hyser          2021-03-24  207  		goto out;
8648f92a66a323 Xin Gao              2022-07-19  208  	}
7ac592aa35a684 Chris Hyser          2021-03-24  209  
7ac592aa35a684 Chris Hyser          2021-03-24  210  	if (type == PIDTYPE_PID) {
7ac592aa35a684 Chris Hyser          2021-03-24  211  		__sched_core_set(task, cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  212  		goto out;
7ac592aa35a684 Chris Hyser          2021-03-24  213  	}
7ac592aa35a684 Chris Hyser          2021-03-24  214  
7ac592aa35a684 Chris Hyser          2021-03-24  215  	read_lock(&tasklist_lock);
7ac592aa35a684 Chris Hyser          2021-03-24  216  	grp = task_pid_type(task, type);
7ac592aa35a684 Chris Hyser          2021-03-24  217  
7ac592aa35a684 Chris Hyser          2021-03-24  218  	do_each_pid_thread(grp, type, p) {
7ac592aa35a684 Chris Hyser          2021-03-24  219  		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS)) {
7ac592aa35a684 Chris Hyser          2021-03-24  220  			err = -EPERM;
7ac592aa35a684 Chris Hyser          2021-03-24  221  			goto out_tasklist;
7ac592aa35a684 Chris Hyser          2021-03-24  222  		}
7ac592aa35a684 Chris Hyser          2021-03-24  223  	} while_each_pid_thread(grp, type, p);
7ac592aa35a684 Chris Hyser          2021-03-24  224  
7ac592aa35a684 Chris Hyser          2021-03-24  225  	do_each_pid_thread(grp, type, p) {
7ac592aa35a684 Chris Hyser          2021-03-24  226  		__sched_core_set(p, cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  227  	} while_each_pid_thread(grp, type, p);
7ac592aa35a684 Chris Hyser          2021-03-24  228  out_tasklist:
7ac592aa35a684 Chris Hyser          2021-03-24  229  	read_unlock(&tasklist_lock);
7ac592aa35a684 Chris Hyser          2021-03-24  230  
7ac592aa35a684 Chris Hyser          2021-03-24  231  out:
7ac592aa35a684 Chris Hyser          2021-03-24  232  	sched_core_put_cookie(cookie);
7ac592aa35a684 Chris Hyser          2021-03-24  233  	put_task_struct(task);
7ac592aa35a684 Chris Hyser          2021-03-24  234  	return err;
7ac592aa35a684 Chris Hyser          2021-03-24  235  }
7ac592aa35a684 Chris Hyser          2021-03-24  236  
4feee7d12603de Josh Don             2021-10-18  237  #ifdef CONFIG_SCHEDSTATS
4feee7d12603de Josh Don             2021-10-18  238  
4feee7d12603de Josh Don             2021-10-18  239  /* REQUIRES: rq->core's clock recently updated. */
4feee7d12603de Josh Don             2021-10-18  240  void __sched_core_account_forceidle(struct rq *rq)
4feee7d12603de Josh Don             2021-10-18  241  {
4feee7d12603de Josh Don             2021-10-18  242  	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
4feee7d12603de Josh Don             2021-10-18  243  	u64 delta, now = rq_clock(rq->core);
4feee7d12603de Josh Don             2021-10-18  244  	struct rq *rq_i;
4feee7d12603de Josh Don             2021-10-18  245  	struct task_struct *p;
4feee7d12603de Josh Don             2021-10-18  246  	int i;
4feee7d12603de Josh Don             2021-10-18  247  
4feee7d12603de Josh Don             2021-10-18  248  	lockdep_assert_rq_held(rq);
4feee7d12603de Josh Don             2021-10-18  249  
4feee7d12603de Josh Don             2021-10-18  250  	WARN_ON_ONCE(!rq->core->core_forceidle_count);
4feee7d12603de Josh Don             2021-10-18  251  
4feee7d12603de Josh Don             2021-10-18  252  	if (rq->core->core_forceidle_start == 0)
4feee7d12603de Josh Don             2021-10-18  253  		return;
4feee7d12603de Josh Don             2021-10-18  254  
4feee7d12603de Josh Don             2021-10-18  255  	delta = now - rq->core->core_forceidle_start;
4feee7d12603de Josh Don             2021-10-18  256  	if (unlikely((s64)delta <= 0))
4feee7d12603de Josh Don             2021-10-18  257  		return;
4feee7d12603de Josh Don             2021-10-18  258  
4feee7d12603de Josh Don             2021-10-18  259  	rq->core->core_forceidle_start = now;
4feee7d12603de Josh Don             2021-10-18  260  
4feee7d12603de Josh Don             2021-10-18  261  	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
4feee7d12603de Josh Don             2021-10-18  262  		/* can't be forced idle without a running task */
4feee7d12603de Josh Don             2021-10-18  263  	} else if (rq->core->core_forceidle_count > 1 ||
4feee7d12603de Josh Don             2021-10-18  264  		   rq->core->core_forceidle_occupation > 1) {
4feee7d12603de Josh Don             2021-10-18  265  		/*
4feee7d12603de Josh Don             2021-10-18  266  		 * For larger SMT configurations, we need to scale the charged
4feee7d12603de Josh Don             2021-10-18  267  		 * forced idle amount since there can be more than one forced
4feee7d12603de Josh Don             2021-10-18  268  		 * idle sibling and more than one running cookied task.
4feee7d12603de Josh Don             2021-10-18  269  		 */
4feee7d12603de Josh Don             2021-10-18  270  		delta *= rq->core->core_forceidle_count;
4feee7d12603de Josh Don             2021-10-18  271  		delta = div_u64(delta, rq->core->core_forceidle_occupation);
4feee7d12603de Josh Don             2021-10-18  272  	}
4feee7d12603de Josh Don             2021-10-18  273  
4feee7d12603de Josh Don             2021-10-18  274  	for_each_cpu(i, smt_mask) {
4feee7d12603de Josh Don             2021-10-18  275  		rq_i = cpu_rq(i);
4feee7d12603de Josh Don             2021-10-18  276  		p = rq_i->core_pick ?: rq_i->curr;
4feee7d12603de Josh Don             2021-10-18  277  
b171501f258063 Cruz Zhao            2022-01-11  278  		if (p == rq_i->idle)
4feee7d12603de Josh Don             2021-10-18  279  			continue;
4feee7d12603de Josh Don             2021-10-18  280  
1fcf54deb767d4 Josh Don             2022-06-29  281  		/*
1fcf54deb767d4 Josh Don             2022-06-29  282  		 * Note: this will account forceidle to the current cpu, even
1fcf54deb767d4 Josh Don             2022-06-29  283  		 * if it comes from our SMT sibling.
1fcf54deb767d4 Josh Don             2022-06-29  284  		 */
1fcf54deb767d4 Josh Don             2022-06-29  285  		__account_forceidle_time(p, delta);
4feee7d12603de Josh Don             2021-10-18  286  	}
4feee7d12603de Josh Don             2021-10-18  287  }
4feee7d12603de Josh Don             2021-10-18  288  
4feee7d12603de Josh Don             2021-10-18 @289  void __sched_core_tick(struct rq *rq)
4feee7d12603de Josh Don             2021-10-18  290  {
4feee7d12603de Josh Don             2021-10-18  291  	if (!rq->core->core_forceidle_count)
4feee7d12603de Josh Don             2021-10-18  292  		return;
4feee7d12603de Josh Don             2021-10-18  293  
4feee7d12603de Josh Don             2021-10-18  294  	if (rq != rq->core)
4feee7d12603de Josh Don             2021-10-18  295  		update_rq_clock(rq->core);
4feee7d12603de Josh Don             2021-10-18  296  
4feee7d12603de Josh Don             2021-10-18  297  	__sched_core_account_forceidle(rq);
4feee7d12603de Josh Don             2021-10-18  298  }
4feee7d12603de Josh Don             2021-10-18  299  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

