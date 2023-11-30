Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF27FF177
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbjK3OPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbjK3OPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:15:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047E85
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701353706; x=1732889706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3M69+PV2jP46rJp2Fj4poL9L83eFnrFqZEbm5yY8uTA=;
  b=KO9GBM5ZOoT0/Flb8dQgA2xvWBFJiBjplV15cu7/efhahCFqLbm41PQy
   frJYuTeQsFa1ZGwMIKpZMuo+OI38JHaH1l6SXme/ShAbSF0/RURXS9J/J
   FYOY0EqB/8kR7g1bvyko9rbiXhIYx+sZagb05fwxozQJd8c395IfKo3/T
   U9iI1JcJZ1vGxWnmrzMhr7YEjUt9cMGqTmHVFml6U4/w6eFCcIlEH9TDd
   Rq+P6wJLUF7ym/zX5p0YVswCTbGxJ8956fRHqhbXb0v3biKE/c7qLOm9b
   QcqmiJFateUWpOz4Q6jSoeVo7g1Bom8JCD65uCxwgeJJ8C0H7XXh0U2op
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="208248"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="208248"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803708140"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803708140"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 06:14:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8hoe-00026I-25;
        Thu, 30 Nov 2023 14:14:56 +0000
Date:   Thu, 30 Nov 2023 22:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [tip:x86/percpu 21/22] arch/x86/include/asm/current.h:46:24: sparse:
 sparse: dereference of noderef expression
Message-ID: <202311302257.tSFtZnly-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
head:   0548eb067ed664b93043e033295ca71e3e706245
commit: ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e [21/22] x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation
config: i386-randconfig-062-20231025 (https://download.01.org/0day-ci/archive/20231130/202311302257.tSFtZnly-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302257.tSFtZnly-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/fpu/init.c: note: in included file (through arch/x86/include/asm/preempt.h, include/linux/preempt.h, include/linux/bottom_half.h, ...):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
--
   arch/x86/kernel/fpu/regset.c: note: in included file (through include/linux/sched.h, include/linux/sched/task_stack.h):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
--
   arch/x86/kernel/fpu/signal.c: note: in included file (through arch/x86/include/asm/nospec-branch.h, arch/x86/include/asm/paravirt_types.h, arch/x86/include/asm/ptrace.h, ...):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
--
   arch/x86/kernel/fpu/core.c: note: in included file (through arch/x86/include/asm/preempt.h, include/linux/preempt.h, include/linux/bottom_half.h, ...):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
   arch/x86/kernel/fpu/core.c:547:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/core.c:547:39: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/core.c:547:39: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/core.c:551:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/core.c:551:41: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/core.c:551:41: sparse:     got struct spinlock [noderef] __rcu *
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
--
   arch/x86/kernel/fpu/xstate.c: note: in included file (through arch/x86/include/asm/nospec-branch.h, arch/x86/include/asm/paravirt_types.h, arch/x86/include/asm/ptrace.h, ...):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
   arch/x86/kernel/fpu/xstate.c: note: in included file (through arch/x86/include/asm/fpu/regset.h):
   include/linux/regset.h:28:28: sparse: sparse: self-comparison always evaluates to false
   arch/x86/kernel/fpu/xstate.c: note: in included file (through arch/x86/include/asm/nospec-branch.h, arch/x86/include/asm/paravirt_types.h, arch/x86/include/asm/ptrace.h, ...):
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression
>> arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of noderef expression

vim +46 arch/x86/include/asm/current.h

    38	
    39	/* const-qualified alias to pcpu_hot, aliased by linker. */
    40	DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
    41				const_pcpu_hot);
    42	
    43	static __always_inline struct task_struct *get_current(void)
    44	{
    45		if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
  > 46			return const_pcpu_hot.current_task;
    47	
    48		return this_cpu_read_stable(pcpu_hot.current_task);
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
