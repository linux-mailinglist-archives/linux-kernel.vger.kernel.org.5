Return-Path: <linux-kernel+bounces-63838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A385354A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEEA1F217FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB35F56B;
	Tue, 13 Feb 2024 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SeXgpPJS"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77C5F476
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839597; cv=none; b=WQuuUC6sw3/SvmaNPrxvz4rc24seoSBXNiTL5fGYoI4K1m7brzQinfR6vMMcpWoEyEOXuBWVTA5wWr6g9qvcHWDdM324RYG8HQsexxXgkL6u7LYDllct388w8zcMswa13pRghEoUAH3padRw0Ff/lRrzWp8OgtTMh3wpX//M89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839597; c=relaxed/simple;
	bh=bxnK+PIwuuQWPaJLyrZQzzOgAP+DAixzsuRNg/XrAps=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWVqVWQPh8VFjjP41ME8smIBNnd33TP+75niQGQeOSvPAfIETYdyFQl5d9enuJWGBmSoyu6k1EVzX2gdjh0spJR57W7ISVPzCLawekoEQo3oDp3XZp+nkufp7va2wAixZ65HDb/Ucm8pua43qdH17L5bpaEB1ynpbpJuU4qgK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SeXgpPJS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD2A53F186
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707839592;
	bh=q5WAT9xlsrwi7nU49VclyEz1XabNb44H4w1xGoGEwPc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=SeXgpPJSTS6ALCD6UgkKT5pXqwKZ3e37YNF3YMHCYS76qRmLU/A0M/F2eH/XSxDiX
	 nYq7HqlXPTRPC+O2zbRfdkl57FhLwr3kVppeQkMEpB3/saA5mAchLjHlIhI+0BZbmw
	 p8c/zuHHnckdQXZGtJzQ7OLBLrZMf526vX5jOWFGSHXa2PVCFuacJERqVWylqKga0D
	 1DRzM0LDDIPpqyiSjGBXgCikddNAoL+PYiOTbQLV6ny/Dgp4xYi0y40vFP57uRy3IH
	 As4aFZGteKNxfSL08E2QqR343ICTiF3i1Hztjlobo83Ype91sGScS2FolqHYklIfH9
	 CiFQ3hTdl/9UA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42bff6e8630so45471591cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839591; x=1708444391;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5WAT9xlsrwi7nU49VclyEz1XabNb44H4w1xGoGEwPc=;
        b=mtp9VLeynQvzkwnYWPemyf8ONe9YXwP8TZI3WjfEfbOoVzMPdlyNM3TnAYD+6TRhGg
         ecBpaag0MaYsQ/6rPmuP7OWKI++4ETpaJj53kmbHQUyNtdtyZJ0foEaChDJhBJoU5IdO
         xhdPigEXNSnmokfoT3RbWNfjanLT1yOWt9vB0o83hlUlKnByipOc2fChMZ4q/LFeuE+G
         v8Zkbe4VPW6ReTCslve0D5tQU/tMQuMp7j3CnyjsgtUpSsKTJ2OSbGw7K2R4D82XPhtl
         81g51WBLAxycoJzpKpAjT2RNiaRrZ9BQGyhznUGC8lESgOoCalhTRqwhLn5R3f3xB/3U
         y64g==
X-Forwarded-Encrypted: i=1; AJvYcCWBuRhhoBW4kiQRZzUStC8/5/z5tPKP5oOsTwdybEYnSY9irjzkelLUE6OI6SOMFhIxCS5GxolF1ONweGyqEWUnxiozLWsQtkz7cUrc
X-Gm-Message-State: AOJu0Yz1Uf07RdtkKM3N6FdFe/m9rrmuI1JMT0/54CZc8vivaMN4dzSO
	DIqBZxc/dMHNv1aufCP/i6cJOAAZZPwvnEYi/VMPFenJpzAk/7Zqic3HmoGySo8AXAJlqZjtkJJ
	13VZ9jTtxrGjEUBHQWKZm6KHNRX9TJCAwtZjTvn+tVlIGqqGbLwhHyjUhO0oqeCzTLrbWel+TJi
	vIJ7q6rV0Uy0GQf1Z0KKlUMWTX4hR+Bta8PWg7YjNiNewfj4ZcqyBCxeMZfAD/
X-Received: by 2002:a05:622a:10b:b0:42d:b08a:989a with SMTP id u11-20020a05622a010b00b0042db08a989amr1485779qtw.12.1707839591460;
        Tue, 13 Feb 2024 07:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeTEwmPdBmetgPyADcrTQz1p1Sm+PlqQJKgFlYISYShQDJYai6tEyxiizFvBKTYZWmTi1/3o6xjC8oXx9AJW0=
X-Received: by 2002:a05:622a:10b:b0:42d:b08a:989a with SMTP id
 u11-20020a05622a010b00b0042db08a989amr1485761qtw.12.1707839591207; Tue, 13
 Feb 2024 07:53:11 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Feb 2024 07:53:10 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240213143105.2418044-1-ericchancf@google.com>
References: <20240213142632.2415127-1-ericchancf@google.com> <20240213143105.2418044-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Feb 2024 07:53:10 -0800
Message-ID: <CAJM55Z9MOoZ3A=h4uFaO2hD461U3BMDyWxXLBt0tUdOuJJ5t+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv/barrier: Resolve checkpath.pl error
To: Eric Chan <ericchancf@google.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Eric Chan wrote:
> The original form would cause checkpath.pl to issue a error.
> The error message is as follows:
> ERROR: space required after that ',' (ctx:VxV)
> +#define __atomic_acquire_fence()       RISCV_FENCE(r,rw)
>                                                      ^
> correct the form of RISCV_FENCE and RISCV_FENCE_ASM even if they
> already exist.

A lot of the changes in this patch fixes lines that was added in the previous
patches. I'd prefer to add new code correctly and then only fix the remaining
instances in this patch.

/Emil

>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---
>  arch/riscv/include/asm/atomic.h  |  4 ++--
>  arch/riscv/include/asm/barrier.h | 18 +++++++++---------
>  arch/riscv/include/asm/fence.h   |  6 +++---
>  arch/riscv/include/asm/io.h      |  8 ++++----
>  arch/riscv/include/asm/mmio.h    |  4 ++--
>  arch/riscv/include/asm/mmiowb.h  |  2 +-
>  6 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 1b2ae3259f1d..19050d13b6c1 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -18,8 +18,8 @@
>
>  #include <asm/cmpxchg.h>
>
> -#define __atomic_acquire_fence()	RISCV_FENCE(r,rw)
> -#define __atomic_release_fence()	RISCV_FENCE(rw,r)
> +#define __atomic_acquire_fence()	RISCV_FENCE(r, rw)
> +#define __atomic_release_fence()	RISCV_FENCE(rw, r)
>
>  static __always_inline int arch_atomic_read(const atomic_t *v)
>  {
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index 4f4743d7440d..880b56d8480d 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -19,19 +19,19 @@
>
>
>  /* These barriers need to enforce ordering on both devices or memory. */
> -#define __mb()		RISCV_FENCE(iorw,iorw)
> -#define __rmb()		RISCV_FENCE(ir,ir)
> -#define __wmb()		RISCV_FENCE(ow,ow)
> +#define __mb()		RISCV_FENCE(iorw, iorw)
> +#define __rmb()		RISCV_FENCE(ir, ir)
> +#define __wmb()		RISCV_FENCE(ow, ow)
>
>  /* These barriers do not need to enforce ordering on devices, just memory. */
> -#define __smp_mb()	RISCV_FENCE(rw,rw)
> -#define __smp_rmb()	RISCV_FENCE(r,r)
> -#define __smp_wmb()	RISCV_FENCE(w,w)
> +#define __smp_mb()	RISCV_FENCE(rw, rw)
> +#define __smp_rmb()	RISCV_FENCE(r, r)
> +#define __smp_wmb()	RISCV_FENCE(w, w)
>
>  #define __smp_store_release(p, v)					\
>  do {									\
>  	compiletime_assert_atomic_type(*p);				\
> -	RISCV_FENCE(rw,w);						\
> +	RISCV_FENCE(rw, w);						\
>  	WRITE_ONCE(*p, v);						\
>  } while (0)
>
> @@ -39,7 +39,7 @@ do {									\
>  ({									\
>  	typeof(*p) ___p1 = READ_ONCE(*p);				\
>  	compiletime_assert_atomic_type(*p);				\
> -	RISCV_FENCE(r,rw);						\
> +	RISCV_FENCE(r, rw);						\
>  	___p1;								\
>  })
>
> @@ -68,7 +68,7 @@ do {									\
>   * instances the scheduler pairs this with an mb(), so nothing is necessary on
>   * the new hart.
>   */
> -#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
> +#define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)
>
>  #include <asm-generic/barrier.h>
>
> diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
> index ca094d72ec20..5b46f96a3ec8 100644
> --- a/arch/riscv/include/asm/fence.h
> +++ b/arch/riscv/include/asm/fence.h
> @@ -6,9 +6,9 @@
>  	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
>
>  #ifdef CONFIG_SMP
> -#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r,rw)
> -#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw,r)
> -#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw,rw)
> +#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r, rw)
> +#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, r)
> +#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw, rw)
>  #else
>  #define RISCV_ACQUIRE_BARRIER
>  #define RISCV_RELEASE_BARRIER
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index afb5ead7552e..1c5c641075d2 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -47,10 +47,10 @@
>   * sufficient to ensure this works sanely on controllers that support I/O
>   * writes.
>   */
> -#define __io_pbr()	RISCV_FENCE(io,i)
> -#define __io_par(v)	RISCV_FENCE(i,ior)
> -#define __io_pbw()	RISCV_FENCE(iow,o)
> -#define __io_paw()	RISCV_FENCE(o,io)
> +#define __io_pbr()	RISCV_FENCE(io, i)
> +#define __io_par(v)	RISCV_FENCE(i, ior)
> +#define __io_pbw()	RISCV_FENCE(iow, o)
> +#define __io_paw()	RISCV_FENCE(o, io)
>
>  /*
>   * Accesses from a single hart to a single I/O address must be ordered.  This
> diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
> index a708968d4a0f..06cadfd7a237 100644
> --- a/arch/riscv/include/asm/mmio.h
> +++ b/arch/riscv/include/asm/mmio.h
> @@ -132,8 +132,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>   * doesn't define any ordering between the memory space and the I/O space.
>   */
>  #define __io_br()	do {} while (0)
> -#define __io_ar(v)	RISCV_FENCE(i,ir)
> -#define __io_bw()	RISCV_FENCE(w,o)
> +#define __io_ar(v)	RISCV_FENCE(i, ir)
> +#define __io_bw()	RISCV_FENCE(w, o)
>  #define __io_aw()	mmiowb_set_pending()
>
>  #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
> diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
> index 3bcae97d4803..52ce4a399d9b 100644
> --- a/arch/riscv/include/asm/mmiowb.h
> +++ b/arch/riscv/include/asm/mmiowb.h
> @@ -7,7 +7,7 @@
>   * "o,w" is sufficient to ensure that all writes to the device have completed
>   * before the write to the spinlock is allowed to commit.
>   */
> -#define mmiowb()	RISCV_FENCE(o,w)
> +#define mmiowb()	RISCV_FENCE(o, w)
>
>  #include <linux/smp.h>
>  #include <asm-generic/mmiowb.h>
> --
> 2.43.0.687.g38aa6559b0-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

