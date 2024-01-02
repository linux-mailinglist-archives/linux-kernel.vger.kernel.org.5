Return-Path: <linux-kernel+bounces-14261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0480821A43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BC41F22713
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14948DDA7;
	Tue,  2 Jan 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IbMn7H6j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3DD2FA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so3518269a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704192310; x=1704797110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9aUIH6joDAn7FCueUrn26yQ88JnL3adYdiN3aOGRS0=;
        b=IbMn7H6jTCBXxmxVdTOhsMoi0Pg2MpYoAxeAPweJCVwui8bB/mtSy3yCYJgVMBezf0
         KMUnLpuNgWU36DoV+pEesFx/ygrSZY6S5b8D9TC/VKASvrRXNqV3gQRia40JdkXpm+sM
         pw+J7LbLLCO1KOZi2KvXM0818H7fHEQWeHMJ3n4bmSRolSMi/gwzpNj1AeRHEAY409hp
         wEr3AcnAxNq+iyefJSxcuGuPn+6okWzbQqifjgJsTd+ch1YV4JJepn9fd4tfU2knllZw
         +cXwgzA6NQYd7NUSSNUllzOylnztGNZ6kR/ot+yQl/JbHXZ3947NB4iuBBFxZ2M4ibdf
         pW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192310; x=1704797110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9aUIH6joDAn7FCueUrn26yQ88JnL3adYdiN3aOGRS0=;
        b=LGOyVjH7ziKLieRKv8lSmbTe+Ku0jkXQtim5XLu6yT0lzJW4Ic6RJs8uy0xvXAuWdg
         vBfVwjg5VsyDNdqi+nsnAbGZm9KJXXd19gVbT3UYViU1My8TmMmeh5Ar8LlwCxzm9vp5
         4iJT3O6FrfWTiQhvo5Whn7gCdRAcrHNXBd6txGzug8ePBZFAmLrumw46V/Q2bIVuiDpn
         v2y+L+k1eaDyAXOSeIOor2S7LwYpcRKXB9oz1ZtHsQNX1dLbPfo6gOjQuK7M0C0hzyyQ
         cB6WLdPG3iWNgV5DIiVlt7jW7mycD8RGcKnvCR3rByS4/R5fyGFzlO26xrP6rZpUQcJQ
         aRsA==
X-Gm-Message-State: AOJu0YydbjNxBUICmxf+6QrAAfE8TMWzANxk361pD0ujfmRYr92JEpXR
	i+kV4ZQVKzXw/rhsbWCuwaEhULhcGQ8sGA==
X-Google-Smtp-Source: AGHT+IHY9T5LH9nupqPCh6LPcY8T090GtaEOvzBuU/t6qszMQfPHzhWt7PIWk2kTHJi3C8h7IolBGg==
X-Received: by 2002:a50:871a:0:b0:553:738a:655f with SMTP id i26-20020a50871a000000b00553738a655fmr11239178edb.9.1704192310006;
        Tue, 02 Jan 2024 02:45:10 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id eg14-20020a056402288e00b00556aa0b342csm110085edb.55.2024.01.02.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:45:09 -0800 (PST)
Date: Tue, 2 Jan 2024 11:45:08 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 2/3] riscv: Add ARCH_HAS_PRETCHW support with Zibop
Message-ID: <20240102-7e62facbd8322db4dee4b0dd@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-3-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231082955.16516-3-guoren@kernel.org>


s/Zibop/Zicbop/ <<<$SUBJECT

On Sun, Dec 31, 2023 at 03:29:52AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Enable Linux prefetchw primitive with Zibop cpufeature, which preloads

Also s/Zibop/Zicbop/ here

> cache line into L1 cache for the next write operation.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/processor.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f19f861cda54..8d3a2ab37678 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,9 @@
>  #include <vdso/processor.h>
>  
>  #include <asm/ptrace.h>
> +#include <asm/insn-def.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/hwcap.h>
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> @@ -106,6 +109,19 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
>  #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
>  
> +#ifdef CONFIG_RISCV_ISA_ZICBOP
> +#define ARCH_HAS_PREFETCHW
> +
> +#define PREFETCHW_ASM(x)						\
> +	ALTERNATIVE(__nops(1), CBO_PREFETCH_W(x, 0), 0,			\
> +		    RISCV_ISA_EXT_ZICBOP, CONFIG_RISCV_ISA_ZICBOP)
> +
> +
> +static inline void prefetchw(const void *x)
> +{
> +	__asm__ __volatile__(PREFETCHW_ASM(%0) : : "r" (x) : "memory");
> +}

Shouldn't we create an interface which exposes the offset input of
the instruction, allowing a sequence of calls to be unrolled? But
I guess that could be put off until there's a need for it.

> +#endif /* CONFIG_RISCV_ISA_ZICBOP */
>  
>  /* Do necessary setup to start up a newly executed thread. */
>  extern void start_thread(struct pt_regs *regs,
> -- 
> 2.40.1
> 

Thanks,
drew

