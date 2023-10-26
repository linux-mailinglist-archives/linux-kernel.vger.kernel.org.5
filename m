Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD727D888B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJZSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJZSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:47:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13C10A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:47:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507f1c29f25so1762257e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698346069; x=1698950869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Yge/pzHIm5n8Zsrn6PWyJmFn5ZiDLLVD+FzMWOF/k=;
        b=jcajiP1HBRKqn+9dleQv7r8SWX7QL1A4SplzBcLW8IjfUjJXSCGcDesY1BAj3rXlYC
         4li0cKoZFPx1FWiY/jHGGHXaPgYbOBpyPh9ZELr4aZ6pDMAGK5QYh6vJhtH0YF3obm0d
         bL9ApzBV9sxGNwHgwsV4tr485MD4bDrxunzMJAYMrTcBH085w+91b71Mb/aJ59T6M58b
         08OXv52YesxY/aH3mQFeRLSankI6HiVAD0ttNjaJ/DhMiP0DnBxOFmT+bULkBjiJOG3X
         lTTwl2LSulblqZ0wX3GRs4m6DYlCBgSbL8pXK1gljM/8zZSaR8/3LHCSRJXwg+i75uE6
         u4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346069; x=1698950869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4Yge/pzHIm5n8Zsrn6PWyJmFn5ZiDLLVD+FzMWOF/k=;
        b=dm+iUw39BvcjThK3JV7BGGjXzXy8kxxukWfCs+nmPgDpgWgijhbvBRErafjltx3WcW
         96eeGep0+2ZB5q8r2UDWgkDNyZMLHQ3b3quei/siBj7TBmesIDuKOCu/L/M5JmL49cvN
         k8q1k9UpifNakY0e1HP1sksyJc0X4wZ4vrWSBwyNNDY/DWvg/OOQycuFDF0Cc9KZ2Oxk
         vNF27+oa8GainyBntckPD9JRbN3h8ay9CdsA71llCGPaUR6V4Emoa+FIioxO1mKgau3F
         HSm8OuZDR1kodcs/PA4Ln12UTebIkNNGtHsmiLvZjB2dfYiHYE3FQy2IXjMccpKyk7is
         wOkg==
X-Gm-Message-State: AOJu0YxjoqhJ9AzYU1muD8oL0/K+EgqpxWceuq8AiOOc61vA9Xp7s+O1
        gb6sv80iNPwrIany19y6zUW8tTg9olfzNh5KJY04/+qv1kP5uU5I
X-Google-Smtp-Source: AGHT+IEdqjuQ3p2NMyOBki7F27FeOvvaatahymBlcbjBlZLTnGar1diTEj4esiCLEKkiK0AZZtXIT1mMg/g8QtquJ+Y=
X-Received: by 2002:a05:6512:3e0f:b0:507:b8c5:6542 with SMTP id
 i15-20020a0565123e0f00b00507b8c56542mr218686lfv.65.1698346068566; Thu, 26 Oct
 2023 11:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-8-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-8-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:47:37 +0200
Message-ID: <CAFULd4ZSzJGzckYLGuh-uVXqpk4E7bxnen0_y5HqFiPkr_36PA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] x86/percpu/64: Use relative percpu offsets
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
> The percpu section is currently linked at virtual address 0, because
> older compilers hardcoded the stack protector canary value at a fixed
> offset from the start of the GS segment.  Now that the canary is a
> normal percpu variable, the percpu section can be linked normally.
> This means that x86-64 will calculate percpu offsets like most other
> architectures, as the delta between the initial percpu address and the
> dynamically allocated memory.

The comments above MSR_GS_BASE setup should be reviewed or removed. I
don't think they need to be set up to access stack canary, they are
just clearing MSR now.

>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

With fixed comments:

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/kernel/head_64.S      |  6 ------
>  arch/x86/kernel/setup_percpu.c | 12 ++----------
>  arch/x86/kernel/vmlinux.lds.S  | 24 +-----------------------
>  arch/x86/platform/pvh/head.S   |  6 ------
>  arch/x86/tools/relocs.c        | 10 +++-------
>  arch/x86/xen/xen-head.S        |  6 ------
>  init/Kconfig                   |  2 +-
>  7 files changed, 7 insertions(+), 59 deletions(-)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index f2453eb38417..b35f74e58dd7 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -72,14 +72,8 @@ SYM_CODE_START_NOALIGN(startup_64)
>
>         /* Setup GSBASE to allow stack canary access for C code */
>         movl    $MSR_GS_BASE, %ecx
> -#ifdef CONFIG_SMP
> -       leaq    __per_cpu_load(%rip), %rdx
> -       movl    %edx, %eax
> -       shrq    $32,  %rdx
> -#else
>         xorl    %eax, %eax
>         xorl    %edx, %edx
> -#endif
>         wrmsr
>
>         call    startup_64_setup_env
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percp=
u.c
> index 2c97bf7b56ae..8707dd07b9ce 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -23,18 +23,10 @@
>  #include <asm/cpumask.h>
>  #include <asm/cpu.h>
>
> -#ifdef CONFIG_X86_64
> -#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
> -#else
> -#define BOOT_PERCPU_OFFSET 0
> -#endif
> -
> -DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) =3D BOOT_PERCPU_=
OFFSET;
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
>  EXPORT_PER_CPU_SYMBOL(this_cpu_off);
>
> -unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init =3D {
> -       [0 ... NR_CPUS-1] =3D BOOT_PERCPU_OFFSET,
> -};
> +unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
>  EXPORT_SYMBOL(__per_cpu_offset);
>
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index e6126cd21615..efa4885060b5 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -103,12 +103,6 @@ const_pcpu_hot =3D pcpu_hot;
>  PHDRS {
>         text PT_LOAD FLAGS(5);          /* R_E */
>         data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> -       percpu PT_LOAD FLAGS(6);        /* RW_ */
> -#endif
> -       init PT_LOAD FLAGS(7);          /* RWE */
> -#endif
>         note PT_NOTE FLAGS(0);          /* ___ */
>  }
>
> @@ -224,21 +218,7 @@ SECTIONS
>                 __init_begin =3D .; /* paired with __init_end */
>         }
>
> -#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> -       /*
> -        * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes =
the
> -        * output PHDR, so the next output section - .init.text - should
> -        * start another segment - init.
> -        */
> -       PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
> -       ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
> -              "per-CPU data too large - increase CONFIG_PHYSICAL_START")
> -#endif
> -
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -       :init
> -#endif
>
>         /*
>          * Section for code used exclusively before alternatives are run.=
 All
> @@ -368,9 +348,7 @@ SECTIONS
>                 EXIT_DATA
>         }
>
> -#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
>         PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> -#endif
>
>         . =3D ALIGN(PAGE_SIZE);
>
> @@ -508,7 +486,7 @@ SECTIONS
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
>   */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
> +#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(irq_stack_backing_store);
>
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index d215b16bf89f..4bd925b23436 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -96,14 +96,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>  1:
>         /* Set base address in stack canary descriptor. */
>         mov $MSR_GS_BASE,%ecx
> -#ifdef CONFIG_SMP
> -       lea __per_cpu_load(%rip), %rdx
> -       mov %edx, %eax
> -       shr $32, %rdx
> -#else
>         xor %eax, %eax
>         xor %edx, %edx
> -#endif
>         wrmsr
>
>         call xen_prepare_pvh
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 3ccd9d4fcf9c..01efbfdd3eb3 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -815,12 +815,7 @@ static void percpu_init(void)
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
>  {
> -       int shndx =3D sym_index(sym);
> -
> -       return (shndx =3D=3D per_cpu_shndx) &&
> -               strcmp(symname, "__init_begin") &&
> -               strcmp(symname, "__per_cpu_load") &&
> -               strncmp(symname, "init_per_cpu_", 13);
> +       return 0;
>  }
>
>
> @@ -1043,7 +1038,8 @@ static int cmp_relocs(const void *va, const void *v=
b)
>
>  static void sort_relocs(struct relocs *r)
>  {
> -       qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
> +       if (r->count)
> +               qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relo=
cs);
>  }
>
>  static int write32(uint32_t v, FILE *f)
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index 9ce0d9d268bb..c1d9c92b417a 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -57,14 +57,8 @@ SYM_CODE_START(startup_xen)
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -#ifdef CONFIG_SMP
> -       leaq    __per_cpu_load(%rip), %rdx
> -       movl    %edx, %eax
> -       shrq    $32, %rdx
> -#else
>         xorl    %eax, %eax
>         xorl    %edx, %edx
> -#endif
>         wrmsr
>
>         mov     %rsi, %rdi
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2..1af31b23e376 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1718,7 +1718,7 @@ config KALLSYMS_ALL
>  config KALLSYMS_ABSOLUTE_PERCPU
>         bool
>         depends on KALLSYMS
> -       default X86_64 && SMP
> +       default n
>
>  config KALLSYMS_BASE_RELATIVE
>         bool
> --
> 2.41.0
>
