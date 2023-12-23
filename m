Return-Path: <linux-kernel+bounces-10584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DA81D683
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19471C21684
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928D15EB7;
	Sat, 23 Dec 2023 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw4j/JV5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2ED15E96
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703364575; x=1734900575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ou99dolNfw3cha0dctmW6y/QjzYF9KleF9X+eoYPzZM=;
  b=Aw4j/JV5z5FGBfkdb9az5OX5gaVZ+LzRyr7kR1+yrMk+XKy62nTeGXYP
   hA7aMIpU3brB+0ivpKuSelySof6M75iuN6js6CvE/8xIWkwu16bbgvhi8
   UPqtabMYg94zMrBRQoXvAvI/xd5yykBzdxLCXpYvgqoxjP9ewvB7zIEb7
   6ka8aGDbbUQ4iMkCSrbkKA1vaWds9fDrNbTZSlELcfNOvqf5rwWHCbIiH
   dJqEI4dR/yrdYb0yV912+M0oyfrddvYL+2/dj4fIsGAhxQV4csD0KgAHf
   oYL1sYdQG6npiCLvHJz4q3oKnd2QDTF/r987SMFvxzVY/YXsWk26di2M+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="482388866"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="482388866"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 12:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="19082682"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Dec 2023 12:49:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH8w5-000BRN-2h;
	Sat, 23 Dec 2023 20:49:29 +0000
Date: Sun, 24 Dec 2023 04:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: kernel/trace/ftrace.c:118:59: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202312240458.GlrZCjdn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
commit: 3306fc4aff464f9c08c8899695a218f4b1125d4a ftrace: Create new ftrace_internal.h header
date:   5 years ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231224/202312240458.GlrZCjdn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240458.GlrZCjdn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240458.GlrZCjdn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/ftrace.c:118:59: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:118:59: sparse:     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:118:59: sparse:     got struct ftrace_ops *
>> kernel/trace/ftrace.c:212:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:212:49: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:212:49: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:295:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu * @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:295:23: sparse:     expected struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:295:23: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:299:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu **list @@
   kernel/trace/ftrace.c:299:16: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:299:16: sparse:     got struct ftrace_ops [noderef] __rcu **list
   kernel/trace/ftrace.c:299:50: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu ** @@
   kernel/trace/ftrace.c:299:50: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:299:50: sparse:     got struct ftrace_ops [noderef] __rcu **
   kernel/trace/ftrace.c:306:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops * @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:306:12: sparse:     expected struct ftrace_ops *
   kernel/trace/ftrace.c:306:12: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:592:5: sparse: sparse: symbol 'ftrace_profile_pages_init' was not declared. Should it be static?
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:210:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c: note: in included file:
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   kernel/trace/ftrace.c: In function 'ftrace_ops_get_list_func':
   kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:184:24: note: in expansion of macro 'ftrace_ops_list_func'
     184 |                 return ftrace_ops_list_func;
         |                        ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'update_ftrace_function':
   kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:217:24: note: in expansion of macro 'ftrace_ops_list_func'
     217 |                 func = ftrace_ops_list_func;
         |                        ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:230:21: note: in expansion of macro 'ftrace_ops_list_func'
     230 |         if (func == ftrace_ops_list_func) {
         |                     ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:250:33: note: in expansion of macro 'ftrace_ops_list_func'
     250 |         ftrace_trace_function = ftrace_ops_list_func;
         |                                 ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:592:5: warning: no previous prototype for 'ftrace_profile_pages_init' [-Wmissing-prototypes]
     592 | int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:6726:5: warning: no previous prototype for 'ftrace_graph_entry_stub' [-Wmissing-prototypes]
    6726 | int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:6733:25: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' to 'void (*)(struct ftrace_graph_ret *)' [-Wcast-function-type]
    6733 |                         (trace_func_graph_ret_t)ftrace_stub;
         |                         ^
   kernel/trace/ftrace.c: In function 'unregister_ftrace_graph':
   kernel/trace/ftrace.c:6963:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' to 'void (*)(struct ftrace_graph_ret *)' [-Wcast-function-type]
    6963 |         ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
         |                               ^
   kernel/trace/ftrace.c:2144: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_update_record, set a record that now is tracing or not
   kernel/trace/ftrace.c:2157: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_test_record, check if the record has been enabled or not
   kernel/trace/ftrace.c:2420: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_rec_iter_start, start up iterating over traced functions
   kernel/trace/ftrace.c:2451: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_rec_iter_next, get the next record to process.
   kernel/trace/ftrace.c:2476: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_rec_iter_record, get the record at the iterator location
   kernel/trace/ftrace.c:2575: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * ftrace_run_stop_machine, go back to the stop machine method
   kernel/trace/ftrace.c:2587: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * arch_ftrace_update_code, modify the code to trace or not trace
   kernel/trace/ftrace.c:4729: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:4729: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:4729: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:4729: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:4743: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:4771: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:4771: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:4771: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:4771: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:4790: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:4790: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:4790: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:4790: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:4805: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:4805: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:4805: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:4821: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:4821: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:4821: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:6609: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Test if ftrace is dead or not.

vim +118 kernel/trace/ftrace.c

   117	
 > 118	struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
   119	ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
   120	struct ftrace_ops global_ops;
   121	
   122	#if ARCH_SUPPORTS_FTRACE_OPS
   123	static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
   124					 struct ftrace_ops *op, struct pt_regs *regs);
   125	#else
   126	/* See comment below, where ftrace_ops_list_func is defined */
   127	static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
   128	#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
   129	#endif
   130	
   131	static inline void ftrace_ops_init(struct ftrace_ops *ops)
   132	{
   133	#ifdef CONFIG_DYNAMIC_FTRACE
   134		if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED)) {
   135			mutex_init(&ops->local_hash.regex_lock);
   136			ops->func_hash = &ops->local_hash;
   137			ops->flags |= FTRACE_OPS_FL_INITIALIZED;
   138		}
   139	#endif
   140	}
   141	
   142	static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
   143				    struct ftrace_ops *op, struct pt_regs *regs)
   144	{
   145		struct trace_array *tr = op->private;
   146	
   147		if (tr && this_cpu_read(tr->trace_buffer.data->ftrace_ignore_pid))
   148			return;
   149	
   150		op->saved_func(ip, parent_ip, op, regs);
   151	}
   152	
   153	static void ftrace_sync(struct work_struct *work)
   154	{
   155		/*
   156		 * This function is just a stub to implement a hard force
   157		 * of synchronize_sched(). This requires synchronizing
   158		 * tasks even in userspace and idle.
   159		 *
   160		 * Yes, function tracing is rude.
   161		 */
   162	}
   163	
   164	static void ftrace_sync_ipi(void *data)
   165	{
   166		/* Probably not needed, but do it anyway */
   167		smp_rmb();
   168	}
   169	
   170	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
   171	/* Both enabled by default (can be cleared by function_graph tracer flags */
   172	static bool fgraph_sleep_time = true;
   173	static bool fgraph_graph_time = true;
   174	#endif
   175	
   176	static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
   177	{
   178		/*
   179		 * If this is a dynamic, RCU, or per CPU ops, or we force list func,
   180		 * then it needs to call the list anyway.
   181		 */
   182		if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
   183		    FTRACE_FORCE_LIST_FUNC)
   184			return ftrace_ops_list_func;
   185	
   186		return ftrace_ops_get_func(ops);
   187	}
   188	
   189	static void update_ftrace_function(void)
   190	{
   191		ftrace_func_t func;
   192	
   193		/*
   194		 * Prepare the ftrace_ops that the arch callback will use.
   195		 * If there's only one ftrace_ops registered, the ftrace_ops_list
   196		 * will point to the ops we want.
   197		 */
   198		set_function_trace_op = rcu_dereference_protected(ftrace_ops_list,
   199							lockdep_is_held(&ftrace_lock));
   200	
   201		/* If there's no ftrace_ops registered, just call the stub function */
   202		if (set_function_trace_op == &ftrace_list_end) {
   203			func = ftrace_stub;
   204	
   205		/*
   206		 * If we are at the end of the list and this ops is
   207		 * recursion safe and not dynamic and the arch supports passing ops,
   208		 * then have the mcount trampoline call the function directly.
   209		 */
   210		} else if (rcu_dereference_protected(ftrace_ops_list->next,
   211				lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
 > 212			func = ftrace_ops_get_list_func(ftrace_ops_list);
   213	
   214		} else {
   215			/* Just use the default ftrace_ops */
   216			set_function_trace_op = &ftrace_list_end;
   217			func = ftrace_ops_list_func;
   218		}
   219	
   220		update_function_graph_func();
   221	
   222		/* If there's no change, then do nothing more here */
   223		if (ftrace_trace_function == func)
   224			return;
   225	
   226		/*
   227		 * If we are using the list function, it doesn't care
   228		 * about the function_trace_ops.
   229		 */
   230		if (func == ftrace_ops_list_func) {
   231			ftrace_trace_function = func;
   232			/*
   233			 * Don't even bother setting function_trace_ops,
   234			 * it would be racy to do so anyway.
   235			 */
   236			return;
   237		}
   238	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

