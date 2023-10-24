Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20987D4FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjJXMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJXMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:33:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9062EA2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:33:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso6799754a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150801; x=1698755601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHQr1DjZxvInvZ0D3s16y341VBd8U9kidRKMaeuvJ30=;
        b=A/Sx1kzAXa9X1HqsuC6GNtNsXNSq5CqtUPBBo58u2HD055W5nqoYDOJakAafxRN87k
         RUr70kGfO85YdZgFcNjWf53dBjtXsmzmzZ6mY/HNx06mq2Tn35KtACXBCjhMtWezt7lr
         YQn5TFYmHQSy53ln00lkqfsh/N4jp5ZfQxVmbkDa4B9lIpJCtF2oGWqLng1PMLd3Xp1c
         hND3n3uHcOZSfH1qZFgj3P0OD4bTKIj4iVUPybGfT6odVpH333MrPJsnbBhXEchxbK9x
         OXwHOq+usMSet7jJ7Etc2DydeQfkPdNPYT4BFwy88JRCc1Bqx1qQty6RhROjR362MkV7
         BplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150801; x=1698755601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHQr1DjZxvInvZ0D3s16y341VBd8U9kidRKMaeuvJ30=;
        b=hcuCBdG9QUhzVAyouu8cWIQ3DMgFY88PuBdyIZR1A7ZaL6PsF7msaNhilpL+H/vTxa
         Ae/L+4eAJrwmEx1Z9NuCzXg0oVIJG3P+R/wOQ891U3sO+rNS5kVKxWHRlY6QZZ0hJmWO
         nJv5pcQCCmPP/pjpjoHse7JQhbfTagP0g1zeJM8YRzxU4eBPxdwSsVuI+LbG5/8jiKMm
         tukzFrEcX0f7ke5H27aVL5RPDKUcx7hRxq0wKY9O/n0DGxZVlSL4RP4aeuKAgA0roMO4
         xpdG98gAIBgVZxVD9U2cGD06B0J5H0q3XnfeGCP3M0gBkarZB3cJut8BrQx1Gxl5BJ5t
         DiSg==
X-Gm-Message-State: AOJu0YyzomEQ38sBcZ2lLOVJSSoR3JGiMq/50p9YrX6ELpeu5kVb/59f
        BCRLc7zY8b5cYcKcYC6E2lL0+uZ2yVeSpO7gSX4=
X-Google-Smtp-Source: AGHT+IFdMzWc9XG2rCoL1yFb7AcaSrKZqrSfTF+vWzrYMVaQYj5hjYBM9v/ZF++5d3TPEVR7ePHBrVaxfNoyAkeNwXM=
X-Received: by 2002:a05:6402:3484:b0:53f:25c4:357f with SMTP id
 v4-20020a056402348400b0053f25c4357fmr8597341edc.34.1698150800722; Tue, 24 Oct
 2023 05:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231023211730.40566-1-brgerst@gmail.com> <20231023211730.40566-5-brgerst@gmail.com>
In-Reply-To: <20231023211730.40566-5-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 24 Oct 2023 14:33:08 +0200
Message-ID: <CAFULd4bFhke4iOHfX93jkC8UxMGuKYhk2Ow6gT835FmaorqOqg@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86/percpu/64: Remove fixed_percpu_data
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:17=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> Now that the stack protector canary value is a normal percpu variable,
> fixed_percpu_data is unused and can be removed.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/include/asm/processor.h | 13 +++++--------
>  arch/x86/kernel/cpu/common.c     |  4 ----
>  arch/x86/kernel/head_64.S        | 12 ++++++------
>  arch/x86/kernel/vmlinux.lds.S    |  6 ------
>  arch/x86/tools/relocs.c          |  1 -
>  arch/x86/xen/xen-head.S          | 12 ++++++++----
>  6 files changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 04371f60e3c6..48c31b8e3e72 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -393,16 +393,13 @@ struct irq_stack {
>  } __aligned(IRQ_STACK_SIZE);
>
>  #ifdef CONFIG_X86_64
> -struct fixed_percpu_data {
> -       char            gs_base[40];
> -};
> -
> -DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> -DECLARE_INIT_PER_CPU(fixed_percpu_data);
> -
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
> -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> +#ifdef CONFIG_SMP
> +       return per_cpu_offset(cpu);
> +#else
> +       return 0;
> +#endif
>  }
>
>  extern asmlinkage void entry_SYSCALL32_ignore(void);
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index f9c8bd27b642..a44fd3ad460e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2051,10 +2051,6 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) =
=3D {
>  EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>
>  #ifdef CONFIG_X86_64
> -DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
> -                    fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
> -EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
> -
>  static void wrmsrl_cstar(unsigned long val)
>  {
>         /*
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 3dcabbc49149..f2453eb38417 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -72,9 +72,14 @@ SYM_CODE_START_NOALIGN(startup_64)
>
>         /* Setup GSBASE to allow stack canary access for C code */
>         movl    $MSR_GS_BASE, %ecx
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> +#ifdef CONFIG_SMP
> +       leaq    __per_cpu_load(%rip), %rdx
>         movl    %edx, %eax
>         shrq    $32,  %rdx
> +#else
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx
> +#endif
>         wrmsr
>
>         call    startup_64_setup_env
> @@ -345,15 +350,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data. If the
> -        * stack protector canary is enabled, it is located at %gs:40.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -#ifndef CONFIG_SMP
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -#endif
>         movl    %edx, %eax
>         shrq    $32, %rdx
>         wrmsr
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 54a5596adaa6..c87dc8de2084 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -509,14 +509,8 @@ SECTIONS
>   */
>  #define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
>  INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>
> -#ifdef CONFIG_SMP
> -. =3D ASSERT((fixed_percpu_data =3D=3D 0),
> -           "fixed_percpu_data is not at start of per-cpu area");
> -#endif
> -
>  #ifdef CONFIG_CPU_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
>  #endif
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index d30949e25ebd..3ccd9d4fcf9c 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -811,7 +811,6 @@ static void percpu_init(void)
>   *     __per_cpu_load
>   *
>   * The "gold" linker incorrectly associates:
> - *     init_per_cpu__fixed_percpu_data
>   *     init_per_cpu__gdt_page
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index a0ea285878db..9ce0d9d268bb 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -53,14 +53,18 @@ SYM_CODE_START(startup_xen)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.  If the
> -        * stack protector canary is enabled, it is located at %gs:40.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -       movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> -       cdq
> +#ifdef CONFIG_SMP
> +       leaq    __per_cpu_load(%rip), %rdx
> +       movl    %edx, %eax
> +       shrq    $32, %rdx
> +#else
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx
> +#endif
>         wrmsr
>
>         mov     %rsi, %rdi

Please note there is another access to $MSR_GS_BASE in
/arch/x86/platform/pvh/head.S around line 98. Should this be fixed,
too?

Uros.
