Return-Path: <linux-kernel+bounces-125518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F88927B0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF331F24FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6C13E6B6;
	Fri, 29 Mar 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MumSkYzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF613E6A7;
	Fri, 29 Mar 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753691; cv=none; b=oxOdEwa+gnrpgYLLObtn2z21LNMTQBuys0Ny65PyY4yc2Toq7skdSlXmZbkChM05ZlooMFZeTME9Nk6w4VLmwlekr4wCfcxn4f+m61CiZKQpaKiFL87qKUzE9ecxo3ZDmuk1WIYwMSftsogybn4iGhji4Lzep0YhgPa4fPShkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753691; c=relaxed/simple;
	bh=ec2F1zO1pAITVaGxx6NZ6eWrWbWDN/2TSFFAHJU4qx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxk1hD7IrEFvjZBRco+0Qcj371tiachoK24OOlfO+HmNASWjCnzrBP97ZYTIno/bZKhX/IvDQDbA6nN/AtNhFG5oiXNEwqJfTWohMFNY6LukDIMjXhxM5BuLdka3nOXxlXY4uSTYTug+rAhKXZHwDTxkoF20gtrcSQ8zxhZXigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MumSkYzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A4C433C7;
	Fri, 29 Mar 2024 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711753691;
	bh=ec2F1zO1pAITVaGxx6NZ6eWrWbWDN/2TSFFAHJU4qx8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MumSkYzIEUc4uqNypRrvdB+KwOeTyHmCJvkXY/a5xogU7N+K4Up/4hzWtKyZA8UgJ
	 rS4aTYzf+gLu4426YqfYE7YExEOZ3xkxYyUCT1BOW/4RNiXJwwDqRWMwgTwZTQrQo4
	 qzCxw6CVdRm06Nm1/pWR2qRC1C6tu+zf5idv5sHJXGbngV2wPkMcUe2HBGpN2CduCb
	 loqXWmtA60F8abfnBzW6vwFkCd8d5kGjfORVKADznCPGLAB/3qLJj4iWFG1X77LqJu
	 WB9+3k1MjObb3cr3a7RW2yZG3V6++WLUvQpFc1TlEgCvOQxk+jbyEQvK0IT9kKxYo7
	 6uzdeQwIpenSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5D40CE120B; Fri, 29 Mar 2024 16:08:10 -0700 (PDT)
Date: Fri, 29 Mar 2024 16:08:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.03.27b 61/69] lib/cmpxchg-emu.c:24:11:
 warning: no previous prototype for 'cmpxchg_emu_u8'
Message-ID: <e4b7ecac-719e-40f5-80b5-7a1c63e72b33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202403300508.Xz7XNp71-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403300508.Xz7XNp71-lkp@intel.com>

On Sat, Mar 30, 2024 at 05:26:12AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
> head:   786fab3085d764055a78edb54023420920344333
> commit: b48ffed4c636b96d2be7a93806870772ce34961f [61/69] csky: Emulate one-byte and two-byte cmpxchg
> config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300508.Xz7XNp71-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403300508.Xz7XNp71-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> lib/cmpxchg-emu.c:24:11: warning: no previous prototype for 'cmpxchg_emu_u8' [-Wmissing-prototypes]
>       24 | uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
>          |           ^~~~~~~~~~~~~~
> >> lib/cmpxchg-emu.c:51:11: warning: no previous prototype for 'cmpxchg_emu_u16' [-Wmissing-prototypes]
>       51 | uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
>          |           ^~~~~~~~~~~~~~~

Again, good catch, and thank you for the testing!  Does the patch at the
end of this email fix things for you?

							Thanx, Paul

> vim +/cmpxchg_emu_u8 +24 lib/cmpxchg-emu.c
> 
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  22  
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  23  /* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17 @24  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  25  {
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  26  	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  27  	int i = ((uintptr_t)p) & 0x3;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  28  	union u8_32 old32;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  29  	union u8_32 new32;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  30  	u32 ret;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  31  
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  32  	old32.w = READ_ONCE(*p32);
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  33  	do {
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  34  		if (old32.b[i] != old)
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  35  			return old32.b[i];
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  36  		new32.w = old32.w;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  37  		new32.b[i] = new;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  38  		instrument_atomic_read_write(p, 1);
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  39  		ret = data_race(cmpxchg(p32, old32.w, new32.w));
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  40  	} while (ret != old32.w);
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  41  	return old;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  42  }
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  43  EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  44  
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  45  union u16_32 {
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  46  	u16 h[2];
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  47  	u32 w;
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  48  };
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  49  
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17  50  /* Emulate two-byte cmpxchg() in terms of 4-byte cmpxchg. */
> 0bbce967f3ecfc Paul E. McKenney 2024-03-17 @51  uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new)
> 
> :::::: The code at line 24 was first introduced by commit
> :::::: 0bbce967f3ecfc6da1e7e8756b0d398e791b8dee lib: Add one-byte and two-byte cmpxchg() emulation functions
> 
> :::::: TO: Paul E. McKenney <paulmck@kernel.org>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

commit a326496eb88936b291adea830c2e59e74ca1d373
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Mar 29 16:06:45 2024 -0700

    squash! lib: Add one-byte and two-byte cmpxchg() emulation functions
    
    [ paulmck: Apply kernel test robot feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
index abdd451767220..a88c4f3c88430 100644
--- a/lib/cmpxchg-emu.c
+++ b/lib/cmpxchg-emu.c
@@ -14,6 +14,7 @@
 #include <linux/panic.h>
 #include <linux/bug.h>
 #include <asm-generic/rwonce.h>
+#include <linux/cmpxchg-emu.h>
 
 union u8_32 {
 	u8 b[4];

