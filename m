Return-Path: <linux-kernel+bounces-24716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1E82C138
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4910B1F26427
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14F66D1BC;
	Fri, 12 Jan 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnrPWFXs"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B86D1B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705067911; x=1736603911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DZ3thWCMXzVKYHpidQUx936D1LbhAlLXp+GRrOgJgnQ=;
  b=bnrPWFXskGbNR1JMwSpvnP1ygX6uHbSqW0OeMcmXFcWzdzNEdXV3nqz6
   I31+1SKbFF5bHKU1SJJqnmp0CsKNvkA/UTzX4zrbKzNXjFjjWe8WK+dQI
   NEUq670XNwkuguu47lqmRVQwggLJ6kPAoXoUPuFMXRBITu+wIhjVWwXp+
   QvENpWILv2icM94IRnwI6FKqyoXstgPhnGdaKlCukSPVL3n6QghSXFf+n
   AWj1tb3l+uUAIGLTmY/btuO5yNdG5BkYRy+/Td8MG76TH5ilO7wLXeRZm
   W6x4SFwastE+a9/AoKHmDx5BniCDnuaSv+rjRN9HdtYXDmhzRbF5kyU3A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="430352717"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="430352717"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 05:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="873369008"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="873369008"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2024 05:58:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOI3H-0009Xo-0o;
	Fri, 12 Jan 2024 13:58:27 +0000
Date: Fri, 12 Jan 2024 21:58:02 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/context_tracking.c:126:39: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202401122136.5Kgy2ZR3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70d201a40823acba23899342d62bc2644051ad2e
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   6 months ago
config: csky-buildonly-randconfig-r006-20230413 (https://download.01.org/0day-ci/archive/20240112/202401122136.5Kgy2ZR3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240112/202401122136.5Kgy2ZR3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401122136.5Kgy2ZR3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/context_tracking.c:126:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:126:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:126:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:165:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:165:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:165:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:206:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:206:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:206:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:261:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:261:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:261:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +126 kernel/context_tracking.c

172114552701b8 Frederic Weisbecker 2022-06-08  115  
172114552701b8 Frederic Weisbecker 2022-06-08  116  /*
172114552701b8 Frederic Weisbecker 2022-06-08  117   * Enter an RCU extended quiescent state, which can be either the
172114552701b8 Frederic Weisbecker 2022-06-08  118   * idle loop or adaptive-tickless usermode execution.
172114552701b8 Frederic Weisbecker 2022-06-08  119   *
172114552701b8 Frederic Weisbecker 2022-06-08  120   * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
172114552701b8 Frederic Weisbecker 2022-06-08  121   * the possibility of usermode upcalls having messed up our count
172114552701b8 Frederic Weisbecker 2022-06-08  122   * of interrupt nesting level during the prior busy period.
172114552701b8 Frederic Weisbecker 2022-06-08  123   */
171476775d32a4 Frederic Weisbecker 2022-06-08  124  static void noinstr ct_kernel_exit(bool user, int offset)
172114552701b8 Frederic Weisbecker 2022-06-08  125  {
172114552701b8 Frederic Weisbecker 2022-06-08 @126  	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
172114552701b8 Frederic Weisbecker 2022-06-08  127  
172114552701b8 Frederic Weisbecker 2022-06-08  128  	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
172114552701b8 Frederic Weisbecker 2022-06-08  129  	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
172114552701b8 Frederic Weisbecker 2022-06-08  130  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
172114552701b8 Frederic Weisbecker 2022-06-08  131  		     ct_dynticks_nesting() == 0);
172114552701b8 Frederic Weisbecker 2022-06-08  132  	if (ct_dynticks_nesting() != 1) {
172114552701b8 Frederic Weisbecker 2022-06-08  133  		// RCU will still be watching, so just do accounting and leave.
172114552701b8 Frederic Weisbecker 2022-06-08  134  		ct->dynticks_nesting--;
172114552701b8 Frederic Weisbecker 2022-06-08  135  		return;
172114552701b8 Frederic Weisbecker 2022-06-08  136  	}
172114552701b8 Frederic Weisbecker 2022-06-08  137  
172114552701b8 Frederic Weisbecker 2022-06-08  138  	instrumentation_begin();
172114552701b8 Frederic Weisbecker 2022-06-08  139  	lockdep_assert_irqs_disabled();
172114552701b8 Frederic Weisbecker 2022-06-08  140  	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
172114552701b8 Frederic Weisbecker 2022-06-08  141  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
172114552701b8 Frederic Weisbecker 2022-06-08  142  	rcu_preempt_deferred_qs(current);
172114552701b8 Frederic Weisbecker 2022-06-08  143  
171476775d32a4 Frederic Weisbecker 2022-06-08  144  	// instrumentation for the noinstr ct_kernel_exit_state()
171476775d32a4 Frederic Weisbecker 2022-06-08  145  	instrument_atomic_write(&ct->state, sizeof(ct->state));
172114552701b8 Frederic Weisbecker 2022-06-08  146  
172114552701b8 Frederic Weisbecker 2022-06-08  147  	instrumentation_end();
172114552701b8 Frederic Weisbecker 2022-06-08  148  	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
172114552701b8 Frederic Weisbecker 2022-06-08  149  	// RCU is watching here ...
171476775d32a4 Frederic Weisbecker 2022-06-08  150  	ct_kernel_exit_state(offset);
172114552701b8 Frederic Weisbecker 2022-06-08  151  	// ... but is no longer watching here.
172114552701b8 Frederic Weisbecker 2022-06-08  152  	rcu_dynticks_task_enter();
172114552701b8 Frederic Weisbecker 2022-06-08  153  }
172114552701b8 Frederic Weisbecker 2022-06-08  154  

:::::: The code at line 126 was first introduced by commit
:::::: 172114552701b85d5c3b1a089a73ee85d0d7786b rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

