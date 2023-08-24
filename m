Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105917869CD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjHXIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbjHXINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:13:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD861BCA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:12:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500772c7889so1732323e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692864730; x=1693469530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtVGHBP9P4Y0/4aCrjzc4LTdRWVLOhNvr5Izw4+meus=;
        b=dZ6YmH7CjijVQfN8DUwJxq3sSNJMl9fKS5JusKVl1G2LsaF6mtsNp3moXTsnrFVaCp
         euuoHhX6ONNWDr0/1VLomDnhMbvcAV3js1Yn64RCFOnD4ka9ixfQHZ0K8WceCm9Tm22l
         OD05FRhpO3epEqXNGRhiTwMMIiFTiSPqHcoU1qXJxtrvOyGiSztrMU8Zc4VGC5TRYS5h
         zCU1IL6qNyuWdsyqUorykTxD20PJL3yaP5MOE7dV22kkAYfaPqt7KPA8hSJrFfc7R+gl
         SfoJwT81NjdXQr5MBWDh9BZjP5UWJg6+a6/pbSApAVZFGKBxZw6/PiTX5Vjq+zpFXHAL
         /yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864730; x=1693469530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtVGHBP9P4Y0/4aCrjzc4LTdRWVLOhNvr5Izw4+meus=;
        b=Bgm1chu4O9uCbmhCHKFqllavxzkO9a27p+1ldxMozEc2fKEvo/QqZzfumNkGsMxMgD
         jX3RzGhnAiAicLQzAB2yDJa1PX+w4EGB5FzwPIbvtInVIIVFt/k7uc3aNmRCFWV1P+lq
         A51oLprBtE+xzfFR/KRs7RUt6nrq6Yo0Rl8uzynf03o35irg4B4vEhqsJTex+e6YNOca
         GzFqdITjjbsX0cD2Twkyu8hrwdPYJSJmHZH4Gd0SYbOivDHkAVrkkbx3pMxbgtTP79rb
         xPV0qFLc/sFkiXopHcsqOxaDfwAn0O/MpPlNZwgIhoYNOwakTv4yexI2226vvFo7IWxE
         ptEA==
X-Gm-Message-State: AOJu0Yz+ITCLTu8KUumgQZKJUoQpVPVK9Nr1d/rpouxCdM41Pj7g5hgP
        a4bgH3jJmnPWmWJ9AcoZV/5QkA==
X-Google-Smtp-Source: AGHT+IFN3hm3+YpJmRPKQh2EefYd8Tq9QDpzMIJzXNlZVipOpMuMUz91qN0BxQYT8twM2HtDhC25EA==
X-Received: by 2002:a19:7516:0:b0:4fe:5838:3dbf with SMTP id y22-20020a197516000000b004fe58383dbfmr9712509lfe.1.1692864729534;
        Thu, 24 Aug 2023 01:12:09 -0700 (PDT)
Received: from ?IPV6:2a01:cb15:81c2:f100:1b1d:60bf:66d8:40d6? ([2a01:cb15:81c2:f100:1b1d:60bf:66d8:40d6])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003feee8d8011sm1832770wmi.41.2023.08.24.01.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:12:08 -0700 (PDT)
Message-ID: <d3696b2a-3d21-4ab6-8cef-20b8ee21742f@rivosinc.com>
Date:   Thu, 24 Aug 2023 10:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] riscv: Deduplicate IRQ stack switching
Content-Language: en-US
To:     Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230815203442.1608773-8-samitolvanen@google.com>
 <20230815203442.1608773-10-samitolvanen@google.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230815203442.1608773-10-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2023 22:34, Sami Tolvanen wrote:
> With CONFIG_IRQ_STACKS, we switch to a separate per-CPU IRQ stack
> before calling handle_riscv_irq or __do_softirq. We currently
> have duplicate inline assembly snippets for stack switching in
> both code paths. Now that we can access per-CPU variables in
> assembly, implement call_on_irq_stack in assembly, and use that
> instead of redudant inline assembly.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/riscv/include/asm/asm.h       |  5 +++++
>  arch/riscv/include/asm/irq_stack.h |  3 +++
>  arch/riscv/kernel/entry.S          | 32 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/irq.c            | 32 ++++++++----------------------
>  arch/riscv/kernel/traps.c          | 29 ++++-----------------------
>  5 files changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index bfb4c26f113c..8e446be2d57c 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -104,6 +104,11 @@
>  .endm
>  #endif /* CONFIG_SMP */
>  
> +.macro load_per_cpu dst ptr tmp
> +	asm_per_cpu \dst \ptr \tmp
> +	REG_L \dst, 0(\dst)
> +.endm
> +
>  	/* save all GPs except x1 ~ x5 */
>  	.macro save_from_x6_to_x31
>  	REG_S x6,  PT_T1(sp)
> diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/irq_stack.h
> index e4042d297580..6441ded3b0cf 100644
> --- a/arch/riscv/include/asm/irq_stack.h
> +++ b/arch/riscv/include/asm/irq_stack.h
> @@ -12,6 +12,9 @@
>  
>  DECLARE_PER_CPU(ulong *, irq_stack_ptr);
>  
> +asmlinkage void call_on_irq_stack(struct pt_regs *regs,
> +				  void (*func)(struct pt_regs *));
> +
>  #ifdef CONFIG_VMAP_STACK
>  /*
>   * To ensure that VMAP'd stack overflow detection works correctly, all VMAP'd
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 3d11aa3af105..39875f5e08a6 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -218,6 +218,38 @@ SYM_CODE_START(ret_from_fork)
>  	tail syscall_exit_to_user_mode
>  SYM_CODE_END(ret_from_fork)
>  
> +#ifdef CONFIG_IRQ_STACKS
> +/*
> + * void call_on_irq_stack(struct pt_regs *regs,
> + * 		          void (*func)(struct pt_regs *));
> + *
> + * Calls func(regs) using the per-CPU IRQ stack.
> + */
> +SYM_FUNC_START(call_on_irq_stack)
> +	/* Create a frame record to save ra and s0 (fp) */
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	ra, (sp)
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	s0, (sp)
> +	addi	s0, sp, 2*RISCV_SZPTR

Hi Sami,

Some defines for stack frame offsets could be added in asm-offsets for
the offsets:

	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe),
STACK_ALIGN));
	OFFSET(STACKFRAME_FP, stackframe, fp);
	OFFSET(STACKFRAME_RA, stackframe, ra);

And you can probably increment the stack at once (saving two addi in
prologue/epilogue) for both RA and FP and reuse the asm-offsets defines:

	addi	sp, sp, -STACKFRAME_SIZE_ON_STACK
	REG_S	ra, STACKFRAME_RA(sp)
	REG_S	s0, STACKFRAME_FP(sp)
	addi	s0, sp, STACKFRAME_SIZE_ON_STACK

Clément

> +
> +	/* Switch to the per-CPU IRQ stack and call the handler */
> +	load_per_cpu t0, irq_stack_ptr, t1
> +	li	t1, IRQ_STACK_SIZE
> +	add	sp, t0, t1
> +	jalr	a1
> +
> +	/* Switch back to the thread stack and restore ra and s0 */
> +	addi	sp, s0, -2*RISCV_SZPTR
> +	REG_L	s0, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +	REG_L	ra, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +
> +	ret
> +SYM_FUNC_END(call_on_irq_stack)
> +#endif /* CONFIG_IRQ_STACKS */
> +
>  /*
>   * Integer register context switch
>   * The callee-saved registers must be saved and restored.
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index d0577cc6a081..95dafdcbd135 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -61,32 +61,16 @@ static void init_irq_stacks(void)
>  #endif /* CONFIG_VMAP_STACK */
>  
>  #ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> +static void ___do_softirq(struct pt_regs *regs)
> +{
> +	__do_softirq();
> +}
> +
>  void do_softirq_own_stack(void)
>  {
> -#ifdef CONFIG_IRQ_STACKS
> -	if (on_thread_stack()) {
> -		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
> -					+ IRQ_STACK_SIZE/sizeof(ulong);
> -		__asm__ __volatile(
> -		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> -		REG_S"  ra, (sp)		\n"
> -		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> -		REG_S"  s0, (sp)		\n"
> -		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
> -		"move	sp, %[sp]		\n"
> -		"call	__do_softirq		\n"
> -		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
> -		REG_L"  s0, (sp)		\n"
> -		"addi	sp, sp, "RISCV_SZPTR   "\n"
> -		REG_L"  ra, (sp)		\n"
> -		"addi	sp, sp, "RISCV_SZPTR   "\n"
> -		:
> -		: [sp] "r" (sp)
> -		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> -		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> -		  "memory");
> -	} else
> -#endif
> +	if (on_thread_stack())
> +		call_on_irq_stack(NULL, ___do_softirq);
> +	else
>  		__do_softirq();
>  }
>  #endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index deb2144d9143..83319b6816da 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -350,31 +350,10 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  asmlinkage void noinstr do_irq(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
> -#ifdef CONFIG_IRQ_STACKS
> -	if (on_thread_stack()) {
> -		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
> -					+ IRQ_STACK_SIZE/sizeof(ulong);
> -		__asm__ __volatile(
> -		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> -		REG_S"  ra, (sp)		\n"
> -		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> -		REG_S"  s0, (sp)		\n"
> -		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
> -		"move	sp, %[sp]		\n"
> -		"move	a0, %[regs]		\n"
> -		"call	handle_riscv_irq	\n"
> -		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
> -		REG_L"  s0, (sp)		\n"
> -		"addi	sp, sp, "RISCV_SZPTR   "\n"
> -		REG_L"  ra, (sp)		\n"
> -		"addi	sp, sp, "RISCV_SZPTR   "\n"
> -		:
> -		: [sp] "r" (sp), [regs] "r" (regs)
> -		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> -		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> -		  "memory");
> -	} else
> -#endif
> +
> +	if (IS_ENABLED(CONFIG_IRQ_STACKS) && on_thread_stack())
> +		call_on_irq_stack(regs, handle_riscv_irq);
> +	else
>  		handle_riscv_irq(regs);
>  
>  	irqentry_exit(regs, state);
