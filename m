Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1687D1274
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbjJTPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377620AbjJTPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:19:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF791
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697815156; x=1729351156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UxTf/46sBy4sdiELY9ZpGd/y59k5LsJYvf7S3OTAvvY=;
  b=PEGj6eblqL9aX6p//3mkzxnxAlfNgQgoKNg7ZfCNAi0vhixstBJUwNSs
   8YdRi3YqGCqg1atAg19lcBMpUWAk3TMhuwepL2+aOI8xz89TkxFJDrFQM
   4XeNBWiRmvyIQF+X8SfXCSom9fcBnlkHoi58IC6aVdUAoA6uEgLJgjL12
   6Pu5+cZXWJ+6WWdV31B7qg8Pd6YcnA2OjEW3fPKQA3JULiOdN/PvGUeJk
   4z38lnxN8Gku76h+BrVhDm2bn2RC3YxTGpC8ygzLchLz471Awp8IibviP
   w+kqosxedO5RHIaiN6gamRsYNCTbcr5HKKXDqRDgyHy96nNIhGZeS3zyv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366743865"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366743865"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1004636891"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1004636891"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2023 08:19:14 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtrHM-0003f0-2H;
        Fri, 20 Oct 2023 15:19:12 +0000
Date:   Fri, 20 Oct 2023 23:18:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/context_tracking.c:126:39: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202310202343.ARtbp2kg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce55c22ec8b223a90ff3e084d842f73cfba35588
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   3 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231020/202310202343.ARtbp2kg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310202343.ARtbp2kg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310202343.ARtbp2kg-lkp@intel.com/

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
--
>> arch/x86/kernel/cpu/bugs.c:64:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:64:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:64:9: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:74:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:74:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:74:13: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:77:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:77:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:77:9: sparse:     got unsigned long long *
   arch/x86/kernel/cpu/bugs.c:89:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/cpu/bugs.c:89:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/cpu/bugs.c:89:16: sparse:     got unsigned long long *

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
