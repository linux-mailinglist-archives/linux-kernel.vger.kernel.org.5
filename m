Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421227E6136
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjKHXwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:52:38 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13442684
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:52:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc3388621cso10366015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699487555; x=1700092355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvjSg1y4bT22KnIGIJJ0Cbw4BydLG7eim8o3gquiKz8=;
        b=E3ZIbgrglDeTEHKZuS2uInioEtLqwbYl3J7tjTX1R7RSLU+NEySitwg5cbcjMF85cK
         TTcCr8Sm8Fc+Zwd9PyK/PzDYmi5q8Yan1ZoSsRew266j/uEN1wSh5j4OV6Yiq97UMhiU
         AD3zYcW2yUeqeRv63jDUOvJxBvtdM4OlvAgG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487555; x=1700092355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvjSg1y4bT22KnIGIJJ0Cbw4BydLG7eim8o3gquiKz8=;
        b=gop2Np34Zx80/eU+jK7stW9o01/h57ki/vyWLySJHYP4jPHN8Ju+mNK6tpmenLKW4V
         iBMp6bfeqhwR1L3i1fzqEq2kwSxdV96k0iQyZOmYtr6xDmKal+F3X6mKiWhfP1h/TNbY
         Y+GTTHax6OIzKPrNiw5/zjCMaR0o8e92r55tjlfsT/N/nNlLvsW67kDjIZxa88epD5VB
         KDMl4YpJ0nyGtayzOmsVgZMR1FBrxbjDC2vZQtLrOAHkeFNNQRXEsVVZu64EoqxoW7Vi
         C+JPwsyqQMWPdax7VG1+oPOFvas/ZfnsjTDh/VsI2miTBmy5TqhE4MG7+D/vcL/Pl7vB
         MBQw==
X-Gm-Message-State: AOJu0YzMfYy3TnqQQbHHnq5cZzY5vfJZUhm+k7qiek+nL4nH4CcFlNcV
        E0Pbgo8yxzD3CXX+pLi834dA4w==
X-Google-Smtp-Source: AGHT+IE56iyH+j6M2vVGHUa3z3ealRKT2+uoIcQR+3BIJD6IhmJ2vPyWIcKCRvZ0dai7YaSYbWg6zg==
X-Received: by 2002:a17:903:4304:b0:1cc:3004:750c with SMTP id jz4-20020a170903430400b001cc3004750cmr7931071plb.20.1699487555307;
        Wed, 08 Nov 2023 15:52:35 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001cc311ef152sm2267003pli.286.2023.11.08.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:52:34 -0800 (PST)
Date:   Wed, 8 Nov 2023 15:52:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        jszhang@kernel.org, conor.dooley@microchip.com,
        andy.chiu@sifive.com, samitolvanen@google.com,
        coelacanthushex@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv: Support RANDOMIZE_KSTACK_OFFSET
Message-ID: <202311081552.062D21EB@keescook>
References: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:44:23PM +0800, Song Shuai wrote:
> Inspired from arm64's implement -- commit 70918779aec9
> ("arm64: entry: Enable random_kstack_offset support")
> 
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_trap_ecall_u() at the function level.
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>

I can't speak to the correctness of the entropy level, but the usage of
the helpers looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Testing with randomize_kstack_offset=y cmdline, lkdtm/stack-entropy.sh
> showed appropriate stack offset instead of zero.
> ---
>  arch/riscv/Kconfig        |  1 +
>  arch/riscv/kernel/traps.c | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..0e843de33f0c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -100,6 +100,7 @@ config RISCV
>  	select HAVE_ARCH_KGDB_QXFER_PKT
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 19807c4d3805..3f869b2d47c3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -296,9 +297,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  	}
>  }
>  
> -asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> +asmlinkage __visible __trap_section  __no_stack_protector
> +void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> +
>  		long syscall = regs->a7;
>  
>  		regs->epc += 4;
> @@ -308,10 +311,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> +		add_random_kstack_offset();
> +
>  		if (syscall >= 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else if (syscall != -1)
>  			regs->a0 = -ENOSYS;
> +		/*
> +		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> +		 * so the maximum stack offset is 1k bytes (10 bits).
> +		 *
> +		 * The actual entropy will be further reduced by the compiler when
> +		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
> +		 * for RV32I or RV64I.
> +		 *
> +		 * The resulting 6 bits of entropy is seen in SP[9:4].
> +		 */
> +		choose_random_kstack_offset(get_random_u16());
>  
>  		syscall_exit_to_user_mode(regs);
>  	} else {
> -- 
> 2.20.1
> 

-- 
Kees Cook
