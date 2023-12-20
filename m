Return-Path: <linux-kernel+bounces-6296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64DE8196E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1F288B14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD32168CE;
	Wed, 20 Dec 2023 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1jkXndE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EE168A5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703040296; x=1734576296;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xReOnTnr074Rjsh7vnPU98rE77eGcbvTTOM09LsMMsI=;
  b=C1jkXndEJwaPrvfQmXRrCL182QcbT/EbmEuxJtXp97IMIUDcGWjcd7qx
   a0XJ4sp943bGqUWeFnSeSgrIesAs7bBf1BVwhVm2UH1ctoTnZAhLlr8CO
   5CczCt7NT0kaUtnJYK8N1YitBV7LNFl9C6vtydL6L0/J/ubGhCxAlzk5G
   oDFbY3eT0sJVQvuzml2CuDiDXMb9xW5R6sUXBzWcMJVJf7cFnm4gIZTF9
   ku/5xoiqoEeLdh4bEs3pgvAsVKit/0rWKkmk08YN9lNBfjCNhshwvBArU
   mwiiJGrph7dOuVVZXOtnfxl1jC3K5nFQUEMMKGlSyemF0UnfKEMWcLitb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="395476521"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="395476521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107577820"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1107577820"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2023 18:44:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFmZd-0006ET-0o;
	Wed, 20 Dec 2023 02:44:41 +0000
Date: Wed, 20 Dec 2023 10:43:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: kernel/trace/fgraph.c:253: warning: Function parameter or member
 'task' not described in 'ftrace_graph_ret_addr'
Message-ID: <202312201054.4wPWNTRR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: 76b42b63ed0d004961097d3a3cd979129d4afd26 function_graph: Move ftrace_graph_ret_addr() to fgraph.c
date:   5 years ago
config: x86_64-buildonly-randconfig-005-20230918 (https://download.01.org/0day-ci/archive/20231220/202312201054.4wPWNTRR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312201054.4wPWNTRR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312201054.4wPWNTRR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/fgraph.c:209:15: warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
     209 | unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:303:6: warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
     303 | void ftrace_graph_sleep_time_control(bool enable)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:308:5: warning: no previous prototype for 'ftrace_graph_entry_stub' [-Wmissing-prototypes]
     308 | int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/fgraph.c:315:25: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' to 'void (*)(struct ftrace_graph_ret *)' [-Wcast-function-type]
     315 |                         (trace_func_graph_ret_t)ftrace_stub;
         |                         ^
   kernel/trace/fgraph.c: In function 'unregister_ftrace_graph':
   kernel/trace/fgraph.c:595:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct pt_regs *)' to 'void (*)(struct ftrace_graph_ret *)' [-Wcast-function-type]
     595 |         ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
         |                               ^
>> kernel/trace/fgraph.c:253: warning: Function parameter or member 'task' not described in 'ftrace_graph_ret_addr'
>> kernel/trace/fgraph.c:253: warning: Function parameter or member 'idx' not described in 'ftrace_graph_ret_addr'
>> kernel/trace/fgraph.c:253: warning: Function parameter or member 'ret' not described in 'ftrace_graph_ret_addr'
>> kernel/trace/fgraph.c:253: warning: Function parameter or member 'retp' not described in 'ftrace_graph_ret_addr'


vim +253 kernel/trace/fgraph.c

   234	
   235	/**
   236	 * ftrace_graph_ret_addr - convert a potentially modified stack return address
   237	 *			   to its original value
   238	 *
   239	 * This function can be called by stack unwinding code to convert a found stack
   240	 * return address ('ret') to its original value, in case the function graph
   241	 * tracer has modified it to be 'return_to_handler'.  If the address hasn't
   242	 * been modified, the unchanged value of 'ret' is returned.
   243	 *
   244	 * 'idx' is a state variable which should be initialized by the caller to zero
   245	 * before the first call.
   246	 *
   247	 * 'retp' is a pointer to the return address on the stack.  It's ignored if
   248	 * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
   249	 */
   250	#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
   251	unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
   252					    unsigned long ret, unsigned long *retp)
 > 253	{
   254		int index = task->curr_ret_stack;
   255		int i;
   256	
   257		if (ret != (unsigned long)return_to_handler)
   258			return ret;
   259	
   260		if (index < 0)
   261			return ret;
   262	
   263		for (i = 0; i <= index; i++)
   264			if (task->ret_stack[i].retp == retp)
   265				return task->ret_stack[i].ret;
   266	
   267		return ret;
   268	}
   269	#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
   270	unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
   271					    unsigned long ret, unsigned long *retp)
   272	{
   273		int task_idx;
   274	
   275		if (ret != (unsigned long)return_to_handler)
   276			return ret;
   277	
   278		task_idx = task->curr_ret_stack;
   279	
   280		if (!task->ret_stack || task_idx < *idx)
   281			return ret;
   282	
   283		task_idx -= *idx;
   284		(*idx)++;
   285	
   286		return task->ret_stack[task_idx].ret;
   287	}
   288	#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
   289	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

