Return-Path: <linux-kernel+bounces-130151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE78974B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8FB1F2346D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CF14A626;
	Wed,  3 Apr 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odtPt0rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945132F32;
	Wed,  3 Apr 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160044; cv=none; b=VG88PEwviVhWXTWKbHHVbWO2I4ZN2sWgzag1O+egHJua9TCYJ0q82EaxUBk3+2DyuMkr7wuwkKVZcwiLxGou6jh4rZotS4Rj9QMtyazqvFKFG3YwK8NJXJOiE7Ib6CtJ/8xjARUQ45xuRTpKiHdGV82u5RdE3Vosoe2p7kg3Slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160044; c=relaxed/simple;
	bh=iQZt7MavJLJScAA6KVQHLeABjEOs5wyIsuokPbTDdlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orYaWtPGCQ9SoNsjL/3z1dv6XvakJ/yx44LpcBMl0dqcIurl2vhrrCvvqRJIKZ6oYqSJJfgPmB9L69gOeYKSvmWCjeXTy+/NIJN+bzKhJvD5+p6azbo8vQqMXikh5fqZeiL0j4as3psInd3VAp5sDpjyjlm1jK/Rc9oBxt6/6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odtPt0rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243FFC43390;
	Wed,  3 Apr 2024 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712160044;
	bh=iQZt7MavJLJScAA6KVQHLeABjEOs5wyIsuokPbTDdlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odtPt0rlOdcogLEbHmSEl/uTpFpWH0x2CWmtSB326Rm8bur1WZX/W7MaZu9zAJp3O
	 qrz72dXmwfWnKt92WaZkgfyWt8LfMeqS0RVEKm6zJT+AsoMZWPmp7f7POn6ze2qHD0
	 et+pWEKY0Z3MmSuhTMnEglPXERykqbxiMY/iRQXvTfO9eB6PJTQFqPGk9HRBvmcZiX
	 uDAPlGFrWAs9ip1zOXZukqEp9uRrGjkWfJ3aZdt5WZwMyvkNmWhVp/qQhhDVmP5tKx
	 7MuNdfgzsYsITQ3Ly82aF33qZWoQ32Qe5ch0vaUDfAFU0khHeAaSHkNh6E96vsYeE6
	 ZPAKv54VgIFQA==
Date: Wed, 3 Apr 2024 09:00:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	clang-built-linux <llvm@lists.linux.dev>,
	Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: kernel/sched/core.c:961:15: error: incompatible pointer to
 integer conversion passing 'typeof
Message-ID: <20240403160041.GA1252923@dev-arch.thelio-3990X>
References: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
 <CAKfTPtC9YgbZgGNK82MhhzzsD3P6j64+w6oieJMDKQNOmrC4FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC9YgbZgGNK82MhhzzsD3P6j64+w6oieJMDKQNOmrC4FQ@mail.gmail.com>

Hi all,

+ Paul McKenney

On Wed, Apr 03, 2024 at 03:26:05PM +0200, Vincent Guittot wrote:
> Hi Naresh,
> 
> Adding riscv people
> 
> On Wed, 3 Apr 2024 at 09:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The riscv clang-17 defconfig build failed due to following warnings / errors
> > on the Linux next-20240402.
> 
> Could you confirm that there is no problem with other arch and/or
> other toolchain ?

This is not a clang specific issue, it happens with GCC too:

  $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux- mrproper defconfig kernel/sched/core.o
  kernel/sched/core.c: In function '__wake_q_add':
  arch/riscv/include/asm/cmpxchg.h:175:62: warning: passing argument 2 of 'cmpxchg_emu_u8' makes integer from pointer without a cast [-Wint-conversion]
    175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
        |                                                              ^~~~~
        |                                                              |
        |                                                              struct wake_q_node *
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  In file included from arch/riscv/include/asm/cmpxchg.h:12,
                   from arch/riscv/include/asm/atomic.h:19,
                   from include/linux/atomic.h:7,
                   from include/linux/cpumask.h:14,
                   from include/linux/smp.h:13,
                   from include/linux/lockdep.h:14,
                   from include/linux/spinlock.h:63,
                   from include/linux/wait.h:9,
                   from include/linux/wait_bit.h:8,
                   from include/linux/fs.h:6:
  include/linux/cmpxchg-emu.h:13:52: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
     13 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
        |                                          ~~~~~~~~~~^~~
  arch/riscv/include/asm/cmpxchg.h:175:69: warning: passing argument 3 of 'cmpxchg_emu_u8' makes integer from pointer without a cast [-Wint-conversion]
    175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
        |                                                                     ^~~~~
        |                                                                     |
        |                                                                     struct wake_q_node *
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  include/linux/cmpxchg-emu.h:13:67: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
     13 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
        |                                                         ~~~~~~~~~~^~~
  arch/riscv/include/asm/cmpxchg.h:175:23: warning: assignment to 'struct wake_q_node *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
    175 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
        |                       ^
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:179:64: warning: passing argument 2 of 'cmpxchg_emu_u16' makes integer from pointer without a cast [-Wint-conversion]
    179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                                                                ^~~~~
        |                                                                |
        |                                                                struct wake_q_node *
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  include/linux/cmpxchg-emu.h:14:54: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
     14 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
        |                                            ~~~~~~~~~~^~~
  arch/riscv/include/asm/cmpxchg.h:179:71: warning: passing argument 3 of 'cmpxchg_emu_u16' makes integer from pointer without a cast [-Wint-conversion]
    179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                                                                       ^~~~~
        |                                                                       |
        |                                                                       struct wake_q_node *
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  include/linux/cmpxchg-emu.h:14:69: note: expected 'uintptr_t' {aka 'long unsigned int'} but argument is of type 'struct wake_q_node *'
     14 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);
        |                                                           ~~~~~~~~~~^~~
  arch/riscv/include/asm/cmpxchg.h:179:23: warning: assignment to 'struct wake_q_node *' from 'uintptr_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
    179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                       ^
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:179:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:180:9: note: here
    180 |         case 4:                                                         \
        |         ^~~~
  include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
     77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
        |                                             ^
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4810:9: note: in expansion of macro 'raw_cmpxchg_relaxed'
   4810 |         raw_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c:961:22: note: in expansion of macro 'cmpxchg_relaxed'
    961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
        |                      ^~~~~~~~~~~~~~~
  kernel/sched/sched.h: In function 'mm_cid_put_lazy':
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/sched.h:3292:14: note: in expansion of macro 'try_cmpxchg'
   3292 |             !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/sched.h:3292:14: note: in expansion of macro 'try_cmpxchg'
   3292 |             !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
        |              ^~~~~~~~~~~
  kernel/sched/sched.h: In function 'mm_cid_get':
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/sched.h:3429:21: note: in expansion of macro 'try_cmpxchg'
   3429 |                 if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
        |                     ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/sched.h:3429:21: note: in expansion of macro 'try_cmpxchg'
   3429 |                 if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
        |                     ^~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic_cmpxchg_relaxed':
  arch/riscv/include/asm/cmpxchg.h:179:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    179 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:2108:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
   2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
        |                ^~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:180:9: note: here
    180 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:212:30: note: in expansion of macro '__cmpxchg_relaxed'
    212 |         (__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),                   \
        |                              ^~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^~~~~~~~~~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:2108:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
   2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
        |                ^~~~~~~~~~~~~~~~~~~
  kernel/sched/core.c: In function '__sched_mm_cid_migrate_from_try_steal_cid':
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11724:14: note: in expansion of macro 'try_cmpxchg'
  11724 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11724:14: note: in expansion of macro 'try_cmpxchg'
  11724 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11760:14: note: in expansion of macro 'try_cmpxchg'
  11760 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11760:14: note: in expansion of macro 'try_cmpxchg'
  11760 |         if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
        |              ^~~~~~~~~~~
  kernel/sched/core.c: In function 'task_mm_cid_work':
  arch/riscv/include/asm/cmpxchg.h:333:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
   4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~
  kernel/sched/core.c:11945:23: note: in expansion of macro 'cmpxchg'
  11945 |                 res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
        |                       ^~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
   4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~
  kernel/sched/core.c:11945:23: note: in expansion of macro 'cmpxchg'
  11945 |                 res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
        |                       ^~~~~~~
  arch/riscv/include/asm/cmpxchg.h:333:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11953:14: note: in expansion of macro 'try_cmpxchg'
  11953 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11953:14: note: in expansion of macro 'try_cmpxchg'
  11953 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
        |              ^~~~~~~~~~~
  kernel/sched/core.c: In function 'sched_mm_cid_remote_clear':
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11841:14: note: in expansion of macro 'try_cmpxchg'
  11841 |         if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11841:14: note: in expansion of macro 'try_cmpxchg'
  11841 |         if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
        |              ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11874:21: note: in expansion of macro 'try_cmpxchg'
  11874 |                 if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
        |                     ^~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
    192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
        |                ^~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
   4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
        |         ^~~~~~~~~~~~~~~
  kernel/sched/core.c:11874:21: note: in expansion of macro 'try_cmpxchg'
  11874 |                 if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
        |                     ^~~~~~~~~~~
  kernel/sched/sched.h: In function 'mm_cid_pcpu_unset':
  arch/riscv/include/asm/cmpxchg.h:333:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    333 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
        |                 ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
   4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~
  kernel/sched/sched.h:3310:23: note: in expansion of macro 'cmpxchg'
   3310 |                 res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
        |                       ^~~~~~~
  arch/riscv/include/asm/cmpxchg.h:334:9: note: here
    334 |         case 4:                                                         \
        |         ^~~~
  arch/riscv/include/asm/cmpxchg.h:368:30: note: in expansion of macro '__cmpxchg'
    368 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
        |                              ^~~~~~~~~
  include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
     55 | #define raw_cmpxchg arch_cmpxchg
        |                     ^~~~~~~~~~~~
  include/linux/atomic/atomic-instrumented.h:4788:9: note: in expansion of macro 'raw_cmpxchg'
   4788 |         raw_cmpxchg(__ai_ptr, __VA_ARGS__); \
        |         ^~~~~~~~~~~
  kernel/sched/sched.h:3310:23: note: in expansion of macro 'cmpxchg'
   3310 |                 res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
        |                       ^~~~~~~

> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > riscv:
> >   build:
> >     * clang-17-lkftconfig - Failed
> >     * rv32-clang-17-defconfig - Failed
> >     * clang-17-tinyconfig - Failed
> >     * rv32-clang-17-tinyconfig - Failed
> >     * clang-17-defconfig - Failed
> >     * clang-17-allnoconfig - Failed
> >     * rv32-clang-17-allnoconfig - Failed
> >
> > Build log:
> > -------
> > kernel/sched/core.c:961:15: error: incompatible pointer to integer
> > conversion passing 'typeof (*((__ai_ptr)))' (aka 'struct wake_q_node
> > *') to parameter of type 'uintptr_t' (aka 'unsigned long')
> > [-Wint-conversion]
> >   961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
> >       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> There is no recent change on this code. Could it be a change in
> cmpxchg_relaxed ?

Yes, it is caused by commit df35ee400e06 ("riscv: Emulate one-byte and
two-byte cmpxchg") in -next. There is another thread on this problem
with a suggested diff that resolves it for me (there are other issues
with that change as well such as break not being in the correct
location):

https://lore.kernel.org/Zgz98szFLLjTIZSO@yujie-X299/

Cheers,
Nathan

