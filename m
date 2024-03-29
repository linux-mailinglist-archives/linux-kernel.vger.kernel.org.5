Return-Path: <linux-kernel+bounces-125416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D528925A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B772875FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E715139CE7;
	Fri, 29 Mar 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFyOPmkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B329D03;
	Fri, 29 Mar 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745713; cv=none; b=RJV5uogqWXLaR0baE3Kdp9u7Al+GnFQMjkLHEf05uTwzeNe+dzEvt6UaBEFxPONb1pdICmwhSm/9vt73EsgI1stPHjH8OGXWzsBs6TDURrsGEogqNhBXJtg5yrNktCsWEy/qH3pBJJ/T+DE6jbifk9L113BSOuSEshzaF1lpCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745713; c=relaxed/simple;
	bh=DMQucBcjCgpuomzn8VOqq6DIbR4Bhpkhb9Iw38JttEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV/up6myIR5LVN86GJ7cWAWD8r2UwzJors3YLr1yJwV1YDcHaavlrijpU3gp1Ozgz1buYelRwl9qLtmRLpKCRKZ0x8KbIr2ZHiIllCMBxUOmcBOXd325ivM1L83mJVyuGLzFc351v/Q5h5tIgKMX2kxy19ll9In4H1F+TieRTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFyOPmkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5CDC43390;
	Fri, 29 Mar 2024 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711745712;
	bh=DMQucBcjCgpuomzn8VOqq6DIbR4Bhpkhb9Iw38JttEc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bFyOPmkvrnhYh6H3oY9xqCtwqPgHzZ/jBgbrV28n0Aw5JE9VfucizCAHrBRNBRSsa
	 VS+lTyaFJm4Ti/0ad87OnhXPcqBZ5TYnUuOgXDSPOXNURwY4jZIIOSZoRqvYP5/mp/
	 G46nLej5dv1Iv70rHprxsQRDxurKDAg3w4Nsy05UK6ufEDr2iakoVIiDGHW2AyLDsw
	 lxM+9MI2SiI+Kxq4QWRo02eX79JgLBdxhYSR7UWgKYBG+L/eYakzAh1vcU8xc0VCAq
	 fkiaHLqkYE+U+pDlI+B+/ik4+vNZgAL0390X4P+Q6qppVM+H6RyscMnBkFQyLZ3Mqn
	 0nWaTzmZXjrZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04B56CE1ACC; Fri, 29 Mar 2024 11:52:17 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:52:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.03.27b 66/69]
 include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to
 undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <45452057-6655-4bab-a27d-38f2dff018e8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202403292322.bwguovKc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403292322.bwguovKc-lkp@intel.com>

On Fri, Mar 29, 2024 at 11:08:05PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> head:   786fab3085d764055a78edb54023420920344333
> commit: 032d9f7e1213171131a3f45c5c532ea5d11b4b9a [66/69] riscv: Emulate one-byte and two-byte cmpxchg
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292322.bwguovKc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403292322.bwguovKc-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
> >> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2026 |         return raw_cmpxchg(&v->counter, old, new);
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>       55 | #define raw_cmpxchg arch_cmpxchg
>          |                     ^
>    arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
>      367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:328:11: note: expanded from macro '__cmpxchg'
>      328 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>          |                         ^

Again, good catch!  And again, does the diff at the end of this email
fix things for you?

							Thanx, Paul

>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
> >> include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>       55 | #define raw_cmpxchg arch_cmpxchg
>          |                     ^
>    arch/riscv/include/asm/cmpxchg.h:367:23: note: expanded from macro 'arch_cmpxchg'
>      367 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:332:11: note: expanded from macro '__cmpxchg'
>      332 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>          |                         ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
>    include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2055 |         return raw_cmpxchg_acquire(&v->counter, old, new);
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
>       65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
>          |                             ^
>    arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
>      263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:224:11: note: expanded from macro '__cmpxchg_acquire'
>      224 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>          |                         ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
>    include/linux/atomic/atomic-arch-fallback.h:2055:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    include/linux/atomic/atomic-arch-fallback.h:65:29: note: expanded from macro 'raw_cmpxchg_acquire'
>       65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
>          |                             ^
>    arch/riscv/include/asm/cmpxchg.h:263:23: note: expanded from macro 'arch_cmpxchg_acquire'
>      263 |         (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:228:11: note: expanded from macro '__cmpxchg_acquire'
>      228 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>          |                         ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
>    include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2083 |         return raw_cmpxchg_release(&v->counter, old, new);
>          |                ^
>    include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
>       77 | #define raw_cmpxchg_release arch_cmpxchg_release
>          |                             ^
>    arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
>      315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:276:11: note: expanded from macro '__cmpxchg_release'
>      276 |                 __ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
>          |                         ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
>    include/linux/atomic/atomic-arch-fallback.h:2083:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    include/linux/atomic/atomic-arch-fallback.h:77:29: note: expanded from macro 'raw_cmpxchg_release'
>       77 | #define raw_cmpxchg_release arch_cmpxchg_release
>          |                             ^
>    arch/riscv/include/asm/cmpxchg.h:315:23: note: expanded from macro 'arch_cmpxchg_release'
>      315 |         (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
>          |                              ^
>    arch/riscv/include/asm/cmpxchg.h:280:11: note: expanded from macro '__cmpxchg_release'
>      280 |                 __ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>          |                         ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:7:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:63:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:14:
>    In file included from include/linux/atomic.h:80:
>    include/linux/atomic/atomic-arch-fallback.h:2108:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2108 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
> 
> 
> vim +/cmpxchg_emu_u8 +2026 include/linux/atomic/atomic-arch-fallback.h
> 
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2000  
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2001  /**
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2002   * raw_atomic_cmpxchg() - atomic compare and exchange with full ordering
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2003   * @v: pointer to atomic_t
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2004   * @old: int value to compare with
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2005   * @new: int value to assign
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2006   *
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2007   * If (@v == @old), atomically updates @v to @new with full ordering.
> 6dfee110c6cc7a include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2024-02-09  2008   * Otherwise, @v is not modified and relaxed ordering is provided.
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2009   *
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2010   * Safe to use in noinstr code; prefer atomic_cmpxchg() elsewhere.
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2011   *
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2012   * Return: The original value of @v.
> ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2013   */
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2014  static __always_inline int
> 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2015  raw_atomic_cmpxchg(atomic_t *v, int old, int new)
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2016  {
> 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2017  #if defined(arch_atomic_cmpxchg)
> 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2018  	return arch_atomic_cmpxchg(v, old, new);
> 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2019  #elif defined(arch_atomic_cmpxchg_relaxed)
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2020  	int ret;
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2021  	__atomic_pre_full_fence();
> 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2022  	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2023  	__atomic_post_full_fence();
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  2024  	return ret;
> 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2025  #else
> 9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05 @2026  	return raw_cmpxchg(&v->counter, old, new);
> d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2027  #endif
> 1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2028  }
> d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  2029  
> 
> :::::: The code at line 2026 was first introduced by commit
> :::::: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
> 
> :::::: TO: Mark Rutland <mark.rutland@arm.com>
> :::::: CC: Peter Zijlstra <peterz@infradead.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

commit da6c6c7a30e5a5015a2995b2119053ca3d12b7a2
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Mar 29 11:50:32 2024 -0700

    squash! riscv: Emulate one-byte and two-byte cmpxchg
    
    [ paulmck: Apply kernel test robot feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index b4cbea69ad2c8..a5b377481785c 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <linux/cmpxchg-emu.h>
 
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\


