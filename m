Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D587D883E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjJZS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:28:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF07B192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:28:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2066792a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698344892; x=1698949692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ6bZAXWn2psM4cxF+sbyroKbw59hu5E6zNsriOTEGo=;
        b=BYmuQlJcZxA3Z3XF56WWISzLbW87+Zm2HKx2j6XTu0q2rfuvwHlOuSGfxEBEnCUoJq
         K02y6rGBWxympI1N3ehlAjhlcBYqN+puJ4cibmt89XsInIV6j8QwLWQRcqn7glY4Z1nC
         Z4ihKmgbwgFuiT6UfFz/qBr9aGL+nDAltIqRuhEa7KOHzvWPnUUH2plpKSEo6iU09QaZ
         84fU2F12ZJwMfqydHnUt8sgeHvn10T3+KeCqEnN5iWegxgrI50711EMnn5WJcmTZ0H9s
         9w8cZIU5n5laEWGM1iaZxAIc11YWdWfRvSm5GH2DSVAFd0kazDnXy7JHAkIUKbPWyOhF
         PQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344892; x=1698949692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ6bZAXWn2psM4cxF+sbyroKbw59hu5E6zNsriOTEGo=;
        b=vTNWQpYblpD92RIGPhw2DXWZngdsRJA3dxrWAQaM6uLttmfazrYS1EQgK3qGDAS58p
         sFrZFdkaFb7n8Rir+Ywb0spbbW/rDiWqRBU7vM1Vtxw6gmL8XLS/gjn0Q9yr+u8vkhAy
         phnYYtWojMibDfTOZsbs9iCIz79QQfMp1YHe4x6vlGJRuYsQ84CDzFKesclMa9LmgsgP
         buXHOPz765G8J1CZfwWwZ62CBAhdm2F68uakWWfItPI3CRyCUWDA7Cs7Ttg9TUwa/uM3
         2NZqyOUOTrSI81CsVInFGlLuh2tqofsjErrnamYlouYLMxu1+jCNcyRXccjs8AKQwjJ1
         1hWA==
X-Gm-Message-State: AOJu0YxYi9jofgdNC/Zs8lu0rvIyA3spMERKeVdJ8HsTrn/H3Ed8c+Ec
        aNtQPo8XQ8cShIqlcWJbQhHaEh3D9f3WK+RqP6/0DNjJbN16+Ede
X-Google-Smtp-Source: AGHT+IGzhJ7cQdpWhKCC7B4d91JiA0+427hHhjSHDrj6O30kwf8hpJE3/t4m7aqKTD6Qe84QUoi5Dofx4tYxF9tBYWA=
X-Received: by 2002:a50:f68d:0:b0:53d:b7e7:301b with SMTP id
 d13-20020a50f68d000000b0053db7e7301bmr410638edn.24.1698344891696; Thu, 26 Oct
 2023 11:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-7-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-7-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:28:00 +0200
Message-ID: <CAFULd4aToAROKLNrj9uSD1ZonOFf+gH5y7J3M4Fvc4OWtYLUDg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] x86/percpu/64: Remove fixed_percpu_data
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Now that the stack protector canary value is a normal percpu variable,
> fixed_percpu_data is unused and can be removed.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/processor.h | 13 +++++--------
>  arch/x86/kernel/cpu/common.c     |  4 ----
>  arch/x86/kernel/head_64.S        | 11 ++++++-----
>  arch/x86/kernel/vmlinux.lds.S    |  6 ------
>  arch/x86/platform/pvh/head.S     |  7 ++++++-
>  arch/x86/tools/relocs.c          |  1 -
>  arch/x86/xen/xen-head.S          | 11 ++++++++---
>  7 files changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 2b6531d90273..d5a4044dba8f 100644
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
> index fb8f0371ffc3..32ae76cf4508 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2052,10 +2052,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
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
> index 0d94d2a091fe..f2453eb38417 100644
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
> @@ -345,14 +350,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.
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
> index 1239be7cc8d8..e6126cd21615 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -510,14 +510,8 @@ SECTIONS
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
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index be8d973c0528..d215b16bf89f 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -96,9 +96,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>  1:
>         /* Set base address in stack canary descriptor. */
>         mov $MSR_GS_BASE,%ecx
> -       lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> +#ifdef CONFIG_SMP
> +       lea __per_cpu_load(%rip), %rdx
>         mov %edx, %eax
>         shr $32, %rdx
> +#else
> +       xor %eax, %eax
> +       xor %edx, %edx
> +#endif
>         wrmsr
>
>         call xen_prepare_pvh
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
> index 30f27e757354..9ce0d9d268bb 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -53,13 +53,18 @@ SYM_CODE_START(startup_xen)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.
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
> --
> 2.41.0
>
