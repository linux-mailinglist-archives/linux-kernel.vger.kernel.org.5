Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF77FEE45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjK3Lwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Lww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:52:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDF93
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701345179; x=1732881179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=erHcKxKvKNGdLbjJN5W+zkSgSAEKrnaZ+KztAnWkLB4=;
  b=cM37oxZNY4hH3GfzlzoI/RnqdQ3OimiCdkumLHk3YNt/HbRC9M1kDuKm
   xtzL6qhnvbVa/fPA4vFAYLaXhTTF5vbr/cnT0zrMDDVrrZ3xXAdmMkWnM
   5BUmXjyZWUgGw7CqNwghK2BFFseQWxqMGBKkAZiU+Zs3rROXzbO1TP/Bd
   ZSTgrHY6DkC0oesCGQQwEZ7ynupes5EIvVekQLEm6AGObbc1RCFzSfYwN
   04G53e8IOYAekTRB6oBGjDamHb6FWYhoSkDGJjdlh41CM/2Ql8/gI7tfy
   P+I+hVpVIenkYQJEtK4HAabqVl6G1mrCwioTw80vyD3Xmahta3Bw4V2Mk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="372691973"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="372691973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1100918756"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1100918756"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2023 03:52:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8fbB-0001o2-2q;
        Thu, 30 Nov 2023 11:52:54 +0000
Date:   Thu, 30 Nov 2023 19:51:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: kernel/trace/fgraph.c:253: warning: Function parameter or member
 'retp' not described in 'ftrace_graph_ret_addr'
Message-ID: <202311301937.UkV28E7f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 76b42b63ed0d004961097d3a3cd979129d4afd26 function_graph: Move ftrace_graph_ret_addr() to fgraph.c
date:   5 years ago
config: i386-buildonly-randconfig-006-20231101 (https://download.01.org/0day-ci/archive/20231130/202311301937.UkV28E7f-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301937.UkV28E7f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301937.UkV28E7f-lkp@intel.com/

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
   kernel/trace/fgraph.c:253: warning: Function parameter or member 'task' not described in 'ftrace_graph_ret_addr'
   kernel/trace/fgraph.c:253: warning: Function parameter or member 'idx' not described in 'ftrace_graph_ret_addr'
   kernel/trace/fgraph.c:253: warning: Function parameter or member 'ret' not described in 'ftrace_graph_ret_addr'
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
