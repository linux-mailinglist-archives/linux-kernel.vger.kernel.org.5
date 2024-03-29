Return-Path: <linux-kernel+bounces-125415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E58925A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB51F22F28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285B137774;
	Fri, 29 Mar 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSFW2LEc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F33BB2A;
	Fri, 29 Mar 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745713; cv=none; b=ueyVO/zKHylSjrHyEkfJT6lzO1eUfbO9B67TAmx8s61iserNNN3CSVn4tgMbvqB6zrI3iEslvuYlG5dwQR9fRGHSqw/I2V4cYJnlQkR0TZcKB4TR1Xj/gA/uCMOjqG1jVv+Qf+6alSYgcBB2Ofy/TAyI8EkoHUyy892gntqdqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745713; c=relaxed/simple;
	bh=HKGXLL/mwNCR0ODx3vz+BYkjPcnHX2BMF5VH4Qq1tTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW7ZEqUfyMFJKbbwbE4/d9xSgV22o6dgYAV/Z2cHctaucjFdZ0LbjyiK+/W3YFFW2DJvxlvSzdjTMDMN/fONe0ya5Siiew8HDSPvE5zQ9pkJP8Cr01j1nTTHo1GXqFGpivIWg0nfnA6QNiHwWFrOQtfedWZQLAvwrda3Mreu8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSFW2LEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB9C433F1;
	Fri, 29 Mar 2024 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711745712;
	bh=HKGXLL/mwNCR0ODx3vz+BYkjPcnHX2BMF5VH4Qq1tTM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QSFW2LEc5bfOs10Uto6lO+gYK2r3QFqfbELW8CSNpGb26fmyQkQtf9eIpIY2Liqas
	 IVBmqF1QDTBYTKHPznPSoJV78SY1s3Uvr2PkdZYchg3Hs4roV3xUiFZ8d4b1Qkbq2M
	 UEFQx0b3Jz43UOLn1BuWg2zqyeA6tQdhSHkGxHcMs+URfdLSOJSSHbfdcvP+5d+2Fw
	 xGbt4m7nIzjLNyGAt1cclf4FqxyQCSSV7DIFa9gqdWKR5CVnXvjwxy+TCcHP/dnJTH
	 KzRIcAkXFQTnj4oSWTdSCg4qEJBo4Z/lqkoVYSEcoqDNLdYsLbrr/tLi0JqAqruVIh
	 An+deYpGU2dyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5A5CCE16F0; Fri, 29 Mar 2024 11:48:37 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:48:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.03.27b 64/69]
 arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of
 function 'cmpxchg_emu_u8'
Message-ID: <0303151f-c12e-4350-804a-11e3b734df91@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202403292321.T55etywH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403292321.T55etywH-lkp@intel.com>

On Fri, Mar 29, 2024 at 11:08:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> head:   786fab3085d764055a78edb54023420920344333
> commit: b3b1a154281fc97efc4c1d5818a83c29c228dbd5 [64/69] xtensa: Emulate one-byte and two-byte cmpxchg
> config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/xtensa/include/asm/atomic.h:19,
>                     from include/linux/atomic.h:7,
>                     from include/asm-generic/bitops/atomic.h:5,
>                     from arch/xtensa/include/asm/bitops.h:192,
>                     from include/linux/bitops.h:68,
>                     from include/linux/log2.h:12,
>                     from kernel/bounds.c:13:
>    arch/xtensa/include/asm/cmpxchg.h: In function '__cmpxchg':
> >> arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
>       77 |         case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
>          |                         ^~~~~~~~~~~~~~

Good catch!  Does the diff at the end fix this?

							Thanx, Paul

> >> arch/xtensa/include/asm/cmpxchg.h:78:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
>       78 |         case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
>          |                         ^~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>    make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1197: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:240: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:240: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +/cmpxchg_emu_u8 +77 arch/xtensa/include/asm/cmpxchg.h
> 
>     72	
>     73	static __inline__ unsigned long
>     74	__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
>     75	{
>     76		switch (size) {
>   > 77		case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
>   > 78		case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
>     79		case 4:  return __cmpxchg_u32(ptr, old, new);
>     80		default: __cmpxchg_called_with_bad_pointer();
>     81			 return old;
>     82		}
>     83	}
>     84	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

commit 663161aaa5c3286dcfc9ba2cd9e12170f9354ea7
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Mar 29 11:47:13 2024 -0700

    squash! xtensa: Emulate one-byte and two-byte cmpxchg
    
    [ paulmck: Apply kernel test robot feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index bcce915a98e21..a0f9a2070209b 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -15,6 +15,7 @@
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
+#include <linux/cmpxchg-emu.h>
 
 /*
  * cmpxchg

