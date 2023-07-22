Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25D75DBAD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGVKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVKRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:17:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCB268E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690021038; x=1721557038;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x+fbm8DBl8bfdhUMiGW2xTC/27ysxOuLaPGwbz9B1xA=;
  b=Mj0QB6+kXZMh4CtatSR+GnKrTz6LEnd4oLDPaeKyKwBNuVqQK0Vi3oxY
   WLGd+sJOgze4vVUS5uMCLkdNoNia0heAxjgnl/8FlWwXeBZYGQXB/MUZi
   kpXjGVD8VCdqg9PIZPLPSUkM3+j4jESb5Sxjgc/tv56o8SotBf5dfKUud
   ZxN3f0ghK+Nlyqx47xd/SjbtDoURoggB04ghSKIRHIkYHWVJQC3yqb6Vd
   3s/Qb7XzQ4K0gAtW+VVuteEGjEIMsCJf1LWjdcrmXQx8zdlnPnLa2rNGB
   oSPKKNh+RBolbk4yiJTnvRZMNoLAS98imgZMZKae3u9F2msAOV+aVr3FU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="367211085"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="367211085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 03:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675312738"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="675312738"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Jul 2023 03:17:15 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN9fm-0008FH-0l;
        Sat, 22 Jul 2023 10:17:14 +0000
Date:   Sat, 22 Jul 2023 18:17:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: kernel/bpf/verifier.c:3959:12: warning: stack frame size (1152)
 exceeds limit (1024) in '__mark_chain_precision'
Message-ID: <202307221821.As1rdRHs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: 904e6ddf4133c52fdb9654c2cd2ad90f320d48b9 bpf: Use scalar ids in mark_chain_precision()
date:   6 weeks ago
config: riscv-randconfig-r022-20230722 (https://download.01.org/0day-ci/archive/20230722/202307221821.As1rdRHs-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307221821.As1rdRHs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307221821.As1rdRHs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
   #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
   #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
   #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from kernel/bpf/verifier.c:7:
   In file included from include/linux/bpf-cgroup.h:5:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> kernel/bpf/verifier.c:3959:12: warning: stack frame size (1152) exceeds limit (1024) in '__mark_chain_precision' [-Wframe-larger-than]
   static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
              ^
   kernel/bpf/verifier.c:17989:12: warning: stack frame size (1328) exceeds limit (1024) in 'do_misc_fixups' [-Wframe-larger-than]
   static int do_misc_fixups(struct bpf_verifier_env *env)
              ^
   kernel/bpf/verifier.c:16126:12: warning: stack frame size (1776) exceeds limit (1024) in 'do_check' [-Wframe-larger-than]
   static int do_check(struct bpf_verifier_env *env)
              ^
   kernel/bpf/verifier.c:10638:12: warning: stack frame size (2080) exceeds limit (1024) in 'check_kfunc_args' [-Wframe-larger-than]
   static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
              ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   17 warnings and 20 errors generated.


vim +/__mark_chain_precision +3959 kernel/bpf/verifier.c

904e6ddf4133c5 Eduard Zingerman   2023-06-13  3871  
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3872  /*
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3873   * __mark_chain_precision() backtracks BPF program instruction sequence and
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3874   * chain of verifier states making sure that register *regno* (if regno >= 0)
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3875   * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3876   * SCALARS, as well as any other registers and slots that contribute to
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3877   * a tracked state of given registers/stack slots, depending on specific BPF
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3878   * assembly instructions (see backtrack_insns() for exact instruction handling
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3879   * logic). This backtracking relies on recorded jmp_history and is able to
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3880   * traverse entire chain of parent states. This process ends only when all the
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3881   * necessary registers/slots and their transitive dependencies are marked as
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3882   * precise.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3883   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3884   * One important and subtle aspect is that precise marks *do not matter* in
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3885   * the currently verified state (current state). It is important to understand
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3886   * why this is the case.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3887   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3888   * First, note that current state is the state that is not yet "checkpointed",
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3889   * i.e., it is not yet put into env->explored_states, and it has no children
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3890   * states as well. It's ephemeral, and can end up either a) being discarded if
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3891   * compatible explored state is found at some point or BPF_EXIT instruction is
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3892   * reached or b) checkpointed and put into env->explored_states, branching out
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3893   * into one or more children states.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3894   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3895   * In the former case, precise markings in current state are completely
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3896   * ignored by state comparison code (see regsafe() for details). Only
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3897   * checkpointed ("old") state precise markings are important, and if old
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3898   * state's register/slot is precise, regsafe() assumes current state's
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3899   * register/slot as precise and checks value ranges exactly and precisely. If
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3900   * states turn out to be compatible, current state's necessary precise
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3901   * markings and any required parent states' precise markings are enforced
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3902   * after the fact with propagate_precision() logic, after the fact. But it's
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3903   * important to realize that in this case, even after marking current state
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3904   * registers/slots as precise, we immediately discard current state. So what
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3905   * actually matters is any of the precise markings propagated into current
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3906   * state's parent states, which are always checkpointed (due to b) case above).
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3907   * As such, for scenario a) it doesn't matter if current state has precise
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3908   * markings set or not.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3909   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3910   * Now, for the scenario b), checkpointing and forking into child(ren)
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3911   * state(s). Note that before current state gets to checkpointing step, any
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3912   * processed instruction always assumes precise SCALAR register/slot
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3913   * knowledge: if precise value or range is useful to prune jump branch, BPF
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3914   * verifier takes this opportunity enthusiastically. Similarly, when
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3915   * register's value is used to calculate offset or memory address, exact
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3916   * knowledge of SCALAR range is assumed, checked, and enforced. So, similar to
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3917   * what we mentioned above about state comparison ignoring precise markings
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3918   * during state comparison, BPF verifier ignores and also assumes precise
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3919   * markings *at will* during instruction verification process. But as verifier
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3920   * assumes precision, it also propagates any precision dependencies across
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3921   * parent states, which are not yet finalized, so can be further restricted
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3922   * based on new knowledge gained from restrictions enforced by their children
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3923   * states. This is so that once those parent states are finalized, i.e., when
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3924   * they have no more active children state, state comparison logic in
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3925   * is_state_visited() would enforce strict and precise SCALAR ranges, if
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3926   * required for correctness.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3927   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3928   * To build a bit more intuition, note also that once a state is checkpointed,
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3929   * the path we took to get to that state is not important. This is crucial
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3930   * property for state pruning. When state is checkpointed and finalized at
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3931   * some instruction index, it can be correctly and safely used to "short
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3932   * circuit" any *compatible* state that reaches exactly the same instruction
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3933   * index. I.e., if we jumped to that instruction from a completely different
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3934   * code path than original finalized state was derived from, it doesn't
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3935   * matter, current state can be discarded because from that instruction
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3936   * forward having a compatible state will ensure we will safely reach the
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3937   * exit. States describe preconditions for further exploration, but completely
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3938   * forget the history of how we got here.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3939   *
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3940   * This also means that even if we needed precise SCALAR range to get to
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3941   * finalized state, but from that point forward *that same* SCALAR register is
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3942   * never used in a precise context (i.e., it's precise value is not needed for
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3943   * correctness), it's correct and safe to mark such register as "imprecise"
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3944   * (i.e., precise marking set to false). This is what we rely on when we do
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3945   * not set precise marking in current state. If no child state requires
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3946   * precision for any given SCALAR register, it's safe to dictate that it can
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3947   * be imprecise. If any child state does require this register to be precise,
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3948   * we'll mark it precise later retroactively during precise markings
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3949   * propagation from child state to parent states.
7a830b53c17bba Andrii Nakryiko    2022-11-04  3950   *
7a830b53c17bba Andrii Nakryiko    2022-11-04  3951   * Skipping precise marking setting in current state is a mild version of
7a830b53c17bba Andrii Nakryiko    2022-11-04  3952   * relying on the above observation. But we can utilize this property even
7a830b53c17bba Andrii Nakryiko    2022-11-04  3953   * more aggressively by proactively forgetting any precise marking in the
7a830b53c17bba Andrii Nakryiko    2022-11-04  3954   * current state (which we inherited from the parent state), right before we
7a830b53c17bba Andrii Nakryiko    2022-11-04  3955   * checkpoint it and branch off into new child state. This is done by
7a830b53c17bba Andrii Nakryiko    2022-11-04  3956   * mark_all_scalars_imprecise() to hopefully get more permissive and generic
7a830b53c17bba Andrii Nakryiko    2022-11-04  3957   * finalized states which help in short circuiting more future states.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3958   */
f655badf2a8fc0 Andrii Nakryiko    2023-05-04 @3959  static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3960  {
407958a0e980b9 Andrii Nakryiko    2023-05-04  3961  	struct backtrack_state *bt = &env->bt;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3962  	struct bpf_verifier_state *st = env->cur_state;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3963  	int first_idx = st->first_insn_idx;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3964  	int last_idx = env->insn_idx;
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  3965  	int subseq_idx = -1;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3966  	struct bpf_func_state *func;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3967  	struct bpf_reg_state *reg;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3968  	bool skip_first = true;
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  3969  	int i, fr, err;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3970  
2c78ee898d8f10 Alexei Starovoitov 2020-05-13  3971  	if (!env->bpf_capable)
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3972  		return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3973  
407958a0e980b9 Andrii Nakryiko    2023-05-04  3974  	/* set frame number from which we are starting to backtrack */
f655badf2a8fc0 Andrii Nakryiko    2023-05-04  3975  	bt_init(bt, env->cur_state->curframe);
407958a0e980b9 Andrii Nakryiko    2023-05-04  3976  
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3977  	/* Do sanity checks against current state of register and/or stack
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3978  	 * slot, but don't set precise flag in current state, as precision
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3979  	 * tracking in the current state is unnecessary.
f63181b6ae79fd Andrii Nakryiko    2022-11-04  3980  	 */
f655badf2a8fc0 Andrii Nakryiko    2023-05-04  3981  	func = st->frame[bt->frame];
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  3982  	if (regno >= 0) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3983  		reg = &func->regs[regno];
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3984  		if (reg->type != SCALAR_VALUE) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3985  			WARN_ONCE(1, "backtracing misuse");
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3986  			return -EFAULT;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3987  		}
407958a0e980b9 Andrii Nakryiko    2023-05-04  3988  		bt_set_reg(bt, regno);
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  3989  	}
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  3990  
407958a0e980b9 Andrii Nakryiko    2023-05-04  3991  	if (bt_empty(bt))
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  3992  		return 0;
be2ef8161572ec Andrii Nakryiko    2022-11-04  3993  
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3994  	for (;;) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3995  		DECLARE_BITMAP(mask, 64);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3996  		u32 history = st->jmp_history_cnt;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  3997  
d9439c21a9e476 Andrii Nakryiko    2023-05-04  3998  		if (env->log.level & BPF_LOG_LEVEL2) {
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  3999  			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  4000  				bt->frame, last_idx, first_idx, subseq_idx);
d9439c21a9e476 Andrii Nakryiko    2023-05-04  4001  		}
be2ef8161572ec Andrii Nakryiko    2022-11-04  4002  
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4003  		/* If some register with scalar ID is marked as precise,
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4004  		 * make sure that all registers sharing this ID are also precise.
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4005  		 * This is needed to estimate effect of find_equal_scalars().
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4006  		 * Do this at the last instruction of each state,
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4007  		 * bpf_reg_state::id fields are valid for these instructions.
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4008  		 *
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4009  		 * Allows to track precision in situation like below:
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4010  		 *
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4011  		 *     r2 = unknown value
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4012  		 *     ...
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4013  		 *   --- state #0 ---
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4014  		 *     ...
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4015  		 *     r1 = r2                 // r1 and r2 now share the same ID
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4016  		 *     ...
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4017  		 *   --- state #1 {r1.id = A, r2.id = A} ---
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4018  		 *     ...
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4019  		 *     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4020  		 *     ...
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4021  		 *   --- state #2 {r1.id = A, r2.id = A} ---
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4022  		 *     r3 = r10
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4023  		 *     r3 += r1                // need to mark both r1 and r2
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4024  		 */
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4025  		if (mark_precise_scalar_ids(env, st))
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4026  			return -EFAULT;
904e6ddf4133c5 Eduard Zingerman   2023-06-13  4027  
be2ef8161572ec Andrii Nakryiko    2022-11-04  4028  		if (last_idx < 0) {
be2ef8161572ec Andrii Nakryiko    2022-11-04  4029  			/* we are at the entry into subprog, which
be2ef8161572ec Andrii Nakryiko    2022-11-04  4030  			 * is expected for global funcs, but only if
be2ef8161572ec Andrii Nakryiko    2022-11-04  4031  			 * requested precise registers are R1-R5
be2ef8161572ec Andrii Nakryiko    2022-11-04  4032  			 * (which are global func's input arguments)
be2ef8161572ec Andrii Nakryiko    2022-11-04  4033  			 */
be2ef8161572ec Andrii Nakryiko    2022-11-04  4034  			if (st->curframe == 0 &&
be2ef8161572ec Andrii Nakryiko    2022-11-04  4035  			    st->frame[0]->subprogno > 0 &&
be2ef8161572ec Andrii Nakryiko    2022-11-04  4036  			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
407958a0e980b9 Andrii Nakryiko    2023-05-04  4037  			    bt_stack_mask(bt) == 0 &&
407958a0e980b9 Andrii Nakryiko    2023-05-04  4038  			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) == 0) {
407958a0e980b9 Andrii Nakryiko    2023-05-04  4039  				bitmap_from_u64(mask, bt_reg_mask(bt));
be2ef8161572ec Andrii Nakryiko    2022-11-04  4040  				for_each_set_bit(i, mask, 32) {
be2ef8161572ec Andrii Nakryiko    2022-11-04  4041  					reg = &st->frame[0]->regs[i];
be2ef8161572ec Andrii Nakryiko    2022-11-04  4042  					if (reg->type != SCALAR_VALUE) {
407958a0e980b9 Andrii Nakryiko    2023-05-04  4043  						bt_clear_reg(bt, i);
be2ef8161572ec Andrii Nakryiko    2022-11-04  4044  						continue;
be2ef8161572ec Andrii Nakryiko    2022-11-04  4045  					}
be2ef8161572ec Andrii Nakryiko    2022-11-04  4046  					reg->precise = true;
be2ef8161572ec Andrii Nakryiko    2022-11-04  4047  				}
be2ef8161572ec Andrii Nakryiko    2022-11-04  4048  				return 0;
be2ef8161572ec Andrii Nakryiko    2022-11-04  4049  			}
be2ef8161572ec Andrii Nakryiko    2022-11-04  4050  
407958a0e980b9 Andrii Nakryiko    2023-05-04  4051  			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
407958a0e980b9 Andrii Nakryiko    2023-05-04  4052  				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
be2ef8161572ec Andrii Nakryiko    2022-11-04  4053  			WARN_ONCE(1, "verifier backtracking bug");
be2ef8161572ec Andrii Nakryiko    2022-11-04  4054  			return -EFAULT;
be2ef8161572ec Andrii Nakryiko    2022-11-04  4055  		}
be2ef8161572ec Andrii Nakryiko    2022-11-04  4056  
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  4057  		for (i = last_idx;;) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4058  			if (skip_first) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4059  				err = 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4060  				skip_first = false;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4061  			} else {
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  4062  				err = backtrack_insn(env, i, subseq_idx, bt);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4063  			}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4064  			if (err == -ENOTSUPP) {
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4065  				mark_all_scalars_precise(env, env->cur_state);
407958a0e980b9 Andrii Nakryiko    2023-05-04  4066  				bt_reset(bt);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4067  				return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4068  			} else if (err) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4069  				return err;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4070  			}
407958a0e980b9 Andrii Nakryiko    2023-05-04  4071  			if (bt_empty(bt))
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4072  				/* Found assignment(s) into tracked register in this state.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4073  				 * Since this state is already marked, just return.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4074  				 * Nothing to be tracked further in the parent state.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4075  				 */
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4076  				return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4077  			if (i == first_idx)
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4078  				break;
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  4079  			subseq_idx = i;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4080  			i = get_prev_insn_idx(st, i, &history);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4081  			if (i >= env->prog->len) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4082  				/* This can happen if backtracking reached insn 0
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4083  				 * and there are still reg_mask or stack_mask
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4084  				 * to backtrack.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4085  				 * It means the backtracking missed the spot where
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4086  				 * particular register was initialized with a constant.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4087  				 */
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4088  				verbose(env, "BUG backtracking idx %d\n", i);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4089  				WARN_ONCE(1, "verifier backtracking bug");
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4090  				return -EFAULT;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4091  			}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4092  		}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4093  		st = st->parent;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4094  		if (!st)
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4095  			break;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4096  
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4097  		for (fr = bt->frame; fr >= 0; fr--) {
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4098  			func = st->frame[fr];
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4099  			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4100  			for_each_set_bit(i, mask, 32) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4101  				reg = &func->regs[i];
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  4102  				if (reg->type != SCALAR_VALUE) {
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4103  					bt_clear_frame_reg(bt, fr, i);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4104  					continue;
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  4105  				}
407958a0e980b9 Andrii Nakryiko    2023-05-04  4106  				if (reg->precise)
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4107  					bt_clear_frame_reg(bt, fr, i);
407958a0e980b9 Andrii Nakryiko    2023-05-04  4108  				else
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4109  					reg->precise = true;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4110  			}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4111  
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4112  			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4113  			for_each_set_bit(i, mask, 64) {
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4114  				if (i >= func->allocated_stack / BPF_REG_SIZE) {
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4115  					/* the sequence of instructions:
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4116  					 * 2: (bf) r3 = r10
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4117  					 * 3: (7b) *(u64 *)(r3 -8) = r0
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4118  					 * 4: (79) r4 = *(u64 *)(r10 -8)
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4119  					 * doesn't contain jmps. It's backtracked
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4120  					 * as a single block.
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4121  					 * During backtracking insn 3 is not recognized as
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4122  					 * stack access, so at the end of backtracking
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4123  					 * stack slot fp-8 is still marked in stack_mask.
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4124  					 * However the parent state may not have accessed
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4125  					 * fp-8 and it's "unallocated" stack space.
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4126  					 * In such case fallback to conservative.
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4127  					 */
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4128  					mark_all_scalars_precise(env, env->cur_state);
407958a0e980b9 Andrii Nakryiko    2023-05-04  4129  					bt_reset(bt);
2339cd6cd0b540 Alexei Starovoitov 2019-09-03  4130  					return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4131  				}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4132  
407958a0e980b9 Andrii Nakryiko    2023-05-04  4133  				if (!is_spilled_scalar_reg(&func->stack[i])) {
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4134  					bt_clear_frame_slot(bt, fr, i);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4135  					continue;
a3ce685dd01a78 Alexei Starovoitov 2019-06-28  4136  				}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4137  				reg = &func->stack[i].spilled_ptr;
407958a0e980b9 Andrii Nakryiko    2023-05-04  4138  				if (reg->precise)
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4139  					bt_clear_frame_slot(bt, fr, i);
407958a0e980b9 Andrii Nakryiko    2023-05-04  4140  				else
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4141  					reg->precise = true;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4142  			}
496f3324048b6c Christy Lee        2021-12-16  4143  			if (env->log.level & BPF_LOG_LEVEL2) {
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4144  				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4145  					     bt_frame_reg_mask(bt, fr));
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4146  				verbose(env, "mark_precise: frame%d: parent state regs=%s ",
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4147  					fr, env->tmp_str_buf);
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4148  				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4149  					       bt_frame_stack_mask(bt, fr));
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4150  				verbose(env, "stack=%s: ", env->tmp_str_buf);
2e5766483c8c5c Christy Lee        2021-12-16  4151  				print_verifier_state(env, func, true);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4152  			}
1ef22b6865a73a Andrii Nakryiko    2023-05-04  4153  		}
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4154  
407958a0e980b9 Andrii Nakryiko    2023-05-04  4155  		if (bt_empty(bt))
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4156  			return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4157  
d84b1a6708eec0 Andrii Nakryiko    2023-05-15  4158  		subseq_idx = first_idx;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4159  		last_idx = st->last_insn_idx;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4160  		first_idx = st->first_insn_idx;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4161  	}
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4162  
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4163  	/* if we still have requested precise regs or slots, we missed
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4164  	 * something (e.g., stack access through non-r10 register), so
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4165  	 * fallback to marking all precise
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4166  	 */
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4167  	if (!bt_empty(bt)) {
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4168  		mark_all_scalars_precise(env, env->cur_state);
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4169  		bt_reset(bt);
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4170  	}
c50c0b57a51582 Andrii Nakryiko    2023-05-04  4171  
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4172  	return 0;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4173  }
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  4174  

:::::: The code at line 3959 was first introduced by commit
:::::: f655badf2a8fc028433d9583bf86a6b473721f09 bpf: fix propagate_precision() logic for inner frames

:::::: TO: Andrii Nakryiko <andrii@kernel.org>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
