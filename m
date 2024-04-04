Return-Path: <linux-kernel+bounces-131582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110E8989BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67611F2D925
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D87129E88;
	Thu,  4 Apr 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Y7VI8v9X"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352C129E6E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240145; cv=none; b=ALPBhGQcBLtZyn60yNG+cjLFqwVhWLdElEN3wbkl6g/xhwzGBRQPFGmpDi7IAtH86KBJen041TanZ+NvpmXRDo5tF58XjyaH/B2HM4NXURc4te8f/IMbWhyZ7LX0mKjrW4CqtExSuyzQ75/Qh3sbM0PePvayYc6mn3wIxv4SzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240145; c=relaxed/simple;
	bh=1WHK8xxK5txNWUkfWIrOkumfp4VOWMOySmuMpdklqew=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Jk/ksseCHpGBcOWNrOA4MmJq/YBDw1H7YEQUc3QfGuhGJ8nqQBV4SKvvh2aWxuqyGeQJp9iJRqtXdabbwUVPoYNyV6KhMJxvXz89KctxWhN6L8Qkpl8ESjcKaL8I0wa/RyQ6Y/isc4WiJc50gp5DaJzANA0UHs8IVHV/8n5qSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Y7VI8v9X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e28be94d32so7702715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712240142; x=1712844942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dQTK01Mc93Hqq7XN7ozDnupNum3f6cBI1vXeUhrQTs=;
        b=Y7VI8v9Xv6Zx76kx79+pfaphMGbcKrmRdgmUhMSEW6Dd76fuUGyt2TerP7+TzF2sVi
         U1Xz7pfIIoUecsz2638u6zDG6NUekEK7gcq70kTYEr9hu9oaezxPqms5YCiIX+C8PsVx
         jTzzrtJ42P7kqiAEE2M68Yc6YCV6UDDvi1xqAJ2qRvlYh3pXrpSqu7Fc7XOTqjJCSstl
         ZiqtyEsCN+1kkjULg6JFKH9bEb8CFrhpNqyRVTSH9IVsaQlx83d7pUxjCIhcG3HUY4HY
         fOaRHIVId163+HomqN6N66AirQzfD+ILjRPxc/7EFPZyNFvTyc/0tWFAl4+ckHB2V9U6
         XR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240142; x=1712844942;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dQTK01Mc93Hqq7XN7ozDnupNum3f6cBI1vXeUhrQTs=;
        b=r/KmI8kHjMZIb5Vow71li9TNtwJtcOI+YPqrZIufbuPErgRqpCclYVPfE4oZhAmSsv
         05WaazrlLtmFmZODrJFyMlqOV+Y9hvOTP9fMaD9iBHJErttLVjYyRHETrciGn343pm/w
         95ZodXKkUn8uNHVXexSm02mfcowPH6acbHk9ND4XDoE4M5Bryt6tzZr87kMMYJhnha1A
         C8V8wDpL0zrfxL4V9JAYjeyp2zHHUHFZ6njZZiI5YP4ZBZqCAZh9cPHJmaKmk1Di8MNR
         zGotayqHoF5GRtVftKF3zllnfO3/16DTOGu4VnkAyP98ogvbmEB8KduJ00z0qCFLEVBX
         F+xg==
X-Gm-Message-State: AOJu0YyAmsddD39do2oYlxlVxqeBjq1XRAjuCDjoxfIWn8oTrWDsJJlO
	153nQdOL9kK21djNTur7f2qym+3auzFZl9z7SKIc3YoAgd3ci2EmS19MVO1lzq/2LeW8EUedafz
	E
X-Google-Smtp-Source: AGHT+IFe8EfuHyfR6/MI5fUajRdSh/iNX7dmkKRiYA/xzF9WgxpkGHT5zehtXJ97sF4LICcgy/mGgg==
X-Received: by 2002:a17:902:e542:b0:1dd:5f85:118c with SMTP id n2-20020a170902e54200b001dd5f85118cmr2773574plf.62.1712240141481;
        Thu, 04 Apr 2024 07:15:41 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b001e252f2bdd2sm9133829plk.289.2024.04.04.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:15:40 -0700 (PDT)
Date: Thu, 04 Apr 2024 07:15:40 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2024 07:15:36 PDT (-0700)
Subject:     Re: [PATCH RFC cmpxchg 8/8] riscv: Emulate one-byte and two-byte cmpxchg
In-Reply-To: <20240401213950.3910531-8-paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
  andi.shyti@linux.intel.com, andrzej.hajda@intel.com, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: paulmck@kernel.org
Message-ID: <mhng-d6a8a972-5054-4c48-a903-5a53a31da9ad@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 01 Apr 2024 14:39:50 PDT (-0700), paulmck@kernel.org wrote:
> Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> and two-byte cmpxchg() on riscv.
>
> [ paulmck: Apply kernel test robot feedback. ]

I'm not entirely following the thread, but sounds like there's going to 
be generic kernel users of this now?  Before we'd said "no" to the 
byte/half atomic emulation routines beacuse they weren't used, but if 
it's a generic thing then I'm find adding them.

There's a patch set over here 
<https://lore.kernel.org/all/20240103163203.72768-2-leobras@redhat.com/> 
that implements these more directly using LR/SC.  I was sort of on the 
fence about just taking it even with no direct users right now, as the 
byte/half atomic extension is working its way through the spec process 
so we'll have them for real soon.  I stopped right there for the last 
merge window, though, as I figured it was too late to be messing with 
the atomics...

So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if you guys want to take some sort of tree-wide change to make the 
byte/half stuff be required everywhere.  We'll eventually end up with 
arch routines for the extension, so at that point we might as well also 
have the more direct LR/SC flavors.

If you want I can go review/merge that RISC-V patch set and then it'll 
have time to bake for a shared tag you can pick up for all this stuff?  
No rush on my end, just LMK.

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: <linux-riscv@lists.infradead.org>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/cmpxchg.h | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56b..4eaf40d0a52ec 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -44,6 +44,7 @@ config RISCV
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAS_VDSO_DATA
>  	select ARCH_KEEP_MEMBLOCK if ACPI
> +	select ARCH_NEED_CMPXCHG_1_2_EMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>  	select ARCH_STACKWALK
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 2fee65cc84432..a5b377481785c 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -9,6 +9,7 @@
>  #include <linux/bug.h>
>
>  #include <asm/fence.h>
> +#include <linux/cmpxchg-emu.h>
>
>  #define __xchg_relaxed(ptr, new, size)					\
>  ({									\
> @@ -170,6 +171,12 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
> +	case 2:								\
> +		break;							\
> +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\
> @@ -214,6 +221,12 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
> +	case 2:								\
> +		break;							\
> +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\
> @@ -260,6 +273,12 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
> +	case 2:								\
> +		break;							\
> +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			RISCV_RELEASE_BARRIER				\
> @@ -306,6 +325,12 @@
>  	__typeof__(*(ptr)) __ret;					\
>  	register unsigned int __rc;					\
>  	switch (size) {							\
> +	case 1:								\
> +		__ret = cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> +		break;							\
> +	case 2:								\
> +		break;							\
> +		__ret = cmpxchg_emu_u16((volatile u16 *)__ptr, __old, __new); \
>  	case 4:								\
>  		__asm__ __volatile__ (					\
>  			"0:	lr.w %0, %2\n"				\

