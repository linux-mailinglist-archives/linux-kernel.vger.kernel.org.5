Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD497EC43D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbjKON72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjKON71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:59:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E18C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700056763; x=1731592763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UvATQHOFjYiPH5iJj6fWGlYk7sbJf++h6Q5mjov2V5A=;
  b=j5He7nv1zKRS/phF+FH5PNwjqvTV0Dm29ozexGQdTGKbZ/01P0EwVWgK
   1sViNYasD6hUd0ODkd0+jxaABeYTM0pMkFutKiIIYivNdLZWgirkLOJDY
   099tNW4iYaOqqsChOl3cpRrq0ZUgy0oYVh+CiCwL5qhrT1M33FEjkxqdV
   I6keyFfE2yqOpY/VDOm6n+HG4vcMn3Wn+GIExmUIbH9V1k0EQwFs0OSdT
   leGkEdbWE8bmrwFFr4fKVGiL/aWhpE1XhlQvrABwpazGkeyKhh5/Pc4kN
   QM1scyScSkoJu3uhhe4dKuVqSWuQ6S8QNsg04FXZ+KMVYGlxE+crTA2BH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="375918809"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375918809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714894663"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="714894663"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2023 05:59:21 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3GQI-0000NZ-2O;
        Wed, 15 Nov 2023 13:59:18 +0000
Date:   Wed, 15 Nov 2023 21:58:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Subject: kernel/trace/ftrace.c:146:23: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202311152142.g6UyNx1R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: dbe3ba3018ec1fc53ea0d0adf0f687f5d438039d LoongArch/ftrace: Add basic support
date:   11 months ago
config: loongarch-randconfig-r111-20231115 (https://download.01.org/0day-ci/archive/20231115/202311152142.g6UyNx1R-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311152142.g6UyNx1R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311152142.g6UyNx1R-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/ftrace.c:120:59: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:120:59: sparse:     expected struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:120:59: sparse:     got struct ftrace_ops *
>> kernel/trace/ftrace.c:146:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:146:23: sparse:     expected void *ptr
   kernel/trace/ftrace.c:146:23: sparse:     got int [noderef] __percpu *
>> kernel/trace/ftrace.c:146:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:146:23: sparse:     expected void *ptr
   kernel/trace/ftrace.c:146:23: sparse:     got int [noderef] __percpu *
>> kernel/trace/ftrace.c:146:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:146:23: sparse:     expected void *ptr
   kernel/trace/ftrace.c:146:23: sparse:     got int [noderef] __percpu *
>> kernel/trace/ftrace.c:146:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:146:23: sparse:     expected void *ptr
   kernel/trace/ftrace.c:146:23: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:199:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:199:49: sparse:     expected struct ftrace_ops *ops
   kernel/trace/ftrace.c:199:49: sparse:     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list
   kernel/trace/ftrace.c:282:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops [noderef] __rcu * @@     got struct ftrace_ops * @@
   kernel/trace/ftrace.c:282:23: sparse:     expected struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:282:23: sparse:     got struct ftrace_ops *
   kernel/trace/ftrace.c:286:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu **list @@
   kernel/trace/ftrace.c:286:16: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:286:16: sparse:     got struct ftrace_ops [noderef] __rcu **list
   kernel/trace/ftrace.c:286:50: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops **p @@     got struct ftrace_ops [noderef] __rcu ** @@
   kernel/trace/ftrace.c:286:50: sparse:     expected struct ftrace_ops **p
   kernel/trace/ftrace.c:286:50: sparse:     got struct ftrace_ops [noderef] __rcu **
   kernel/trace/ftrace.c:293:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops * @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:293:12: sparse:     expected struct ftrace_ops *
   kernel/trace/ftrace.c:293:12: sparse:     got struct ftrace_ops [noderef] __rcu *next
   kernel/trace/ftrace.c:7630:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7630:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7630:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7630:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7630:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7630:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7630:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7630:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7630:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7630:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7630:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7630:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7633:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7633:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7633:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7633:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7633:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7633:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7633:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7633:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7633:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7633:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7633:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7633:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7898:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7898:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7898:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7898:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7898:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7898:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7898:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7898:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7898:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7898:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7898:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7898:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7901:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7901:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7901:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7901:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7901:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7901:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7901:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7901:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7901:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:7901:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/ftrace.c:7901:17: sparse:     expected void *ptr
   kernel/trace/ftrace.c:7901:17: sparse:     got int [noderef] __percpu *
   kernel/trace/ftrace.c:197:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:197:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:197:20: sparse: sparse: dereference of noderef expression
--
   kernel/trace/trace_functions_graph.c: note: in included file:
>> kernel/trace/trace.h:988:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.h:988:16: sparse:     expected void *ptr
   kernel/trace/trace.h:988:16: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.h:988:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.h:988:16: sparse:     expected void *ptr
   kernel/trace/trace.h:988:16: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.h:988:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.h:988:16: sparse:     expected void *ptr
   kernel/trace/trace.h:988:16: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.h:988:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.h:988:16: sparse:     expected void *ptr
   kernel/trace/trace.h:988:16: sparse:     got int [noderef] __percpu *

vim +146 kernel/trace/ftrace.c

f04f24fb7e48d4 Masami Hiramatsu         2013-05-09  138  
2f5f6ad9390c1e Steven Rostedt           2011-08-08  139  static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
d19ad0775dcd64 Steven Rostedt (VMware   2020-10-28  140) 			    struct ftrace_ops *op, struct ftrace_regs *fregs)
df4fc31558dd2a Steven Rostedt           2008-11-26  141  {
345ddcc882d889 Steven Rostedt (Red Hat  2016-04-22  142) 	struct trace_array *tr = op->private;
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  143) 	int pid;
345ddcc882d889 Steven Rostedt (Red Hat  2016-04-22  144) 
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  145) 	if (tr) {
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19 @146) 		pid = this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  147) 		if (pid == FTRACE_PID_IGNORE)
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  148) 			return;
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  149) 		if (pid != FTRACE_PID_TRACE &&
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  150) 		    pid != current->pid)
df4fc31558dd2a Steven Rostedt           2008-11-26  151  			return;
717e3f5ebc823e Steven Rostedt (VMware   2020-03-19  152) 	}
df4fc31558dd2a Steven Rostedt           2008-11-26  153  
d19ad0775dcd64 Steven Rostedt (VMware   2020-10-28  154) 	op->saved_func(ip, parent_ip, op, fregs);
df4fc31558dd2a Steven Rostedt           2008-11-26  155  }
df4fc31558dd2a Steven Rostedt           2008-11-26  156  

:::::: The code at line 146 was first introduced by commit
:::::: 717e3f5ebc823e5ecfdd15155b0fd81af9fc58d6 ftrace: Make function trace pid filtering a bit more exact

:::::: TO: Steven Rostedt (VMware) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
