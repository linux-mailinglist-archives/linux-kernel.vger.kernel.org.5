Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F47D5025
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjJXMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjJXMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:44:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5730A10D7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:44:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so4478527a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698151439; x=1698756239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v40ZgpVwcfwGlgWgoxwjmT6GE7Jepo2t8HoZt4sZzfM=;
        b=J7lWoVWM/84qmDP79wcNIzdBPBav/XV1ybltvDH/OLwVAvp+CmMXwGMVoDDMxj+KNB
         FccberTYxSTKW2OaZGT5QouWks5Nty6T443bqp3CoZ4Ujo+9bQoPq6LQ9NTfpsr3+USe
         MRHcCAz+FDx0aJXq20xnFH3fpOwAo93RCFaEh//rfwFEAcVpjoX4KjYhzqnd42wZYGzu
         2tdJ0sIZ7+E00WFro6bf6Wa5NjaYH2SwqAPm9hE4ZbWNcsi17jNLyJahvx+l/4j4Qbnx
         5xFNQqFfKa2rs1XdEXBni9T8+LcwVqvObgtqHPJ5KYdzu6YmTa5GnQOp65r6swWGVzHs
         u1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151439; x=1698756239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v40ZgpVwcfwGlgWgoxwjmT6GE7Jepo2t8HoZt4sZzfM=;
        b=J9R5NcNhSmX8mo2BllzSsxO9uaXot7Boglh+9NRp1tNinCIlIy1hrUx3qbQeLovOd+
         T93g1wUb3v9J3S0KvQRLNjxRCWX53Si+40CuF+kZ63hLBEfwbftvANTAtyrLUfQwLnIc
         2U1HdO743IaUQXY5SBCS6IkjPhJd+kmL02ZEyvW0GiGBLfDeInRabjCnK55u3vQKoAVM
         75LFfPCN66v6a9a9zIIJp7R1u98RdhIdQ+5q0PTWpxHLwzijBJJt8MJsbv3h00aTfZFb
         ngp3jmBZrpNOAuUpEB4LcvhWfMQmXkOXS+Ea+mdBWGz2ScxYw7xqDyoe9qQy9YOHqVbp
         U9MA==
X-Gm-Message-State: AOJu0Yz+FG2mmc8rb7R+1OCynukSMnPdGNVXKLhGZD9zp6QFMd5M6Eou
        mKb8JrZdrut80wAG2vDkZyMwlHBqu18uLIvJWO0=
X-Google-Smtp-Source: AGHT+IEow+2ONTJDIdZuO3PScd4iL+2P7Sl+nPKzpDv18/ufucXiJgQ2RgueO1TslUKvco2WNwad/V7CPf6InEagZS4=
X-Received: by 2002:a50:d719:0:b0:53e:1815:ed0f with SMTP id
 t25-20020a50d719000000b0053e1815ed0fmr8556508edi.31.1698151438541; Tue, 24
 Oct 2023 05:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231023211730.40566-1-brgerst@gmail.com> <20231023211730.40566-6-brgerst@gmail.com>
In-Reply-To: <20231023211730.40566-6-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 24 Oct 2023 14:43:47 +0200
Message-ID: <CAFULd4bKF8U1fj6458ygUAH3t789pVs0rkjDxo4vrrK1Y4Bj+g@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/percpu/64: Use relative percpu offsets
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

On Mon, Oct 23, 2023 at 11:17=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> The percpu section is currently linked at virtual address 0, because
> older compilers hardcoded the stack protector canary value at a fixed
> offset from the start of the GS segment.  Now that the canary is a
> normal percpu variable, the percpu section can be linked normally.
> This means that x86-64 will calculate percpu offsets like most other
> architectures, as the delta between the initial percpu address and the
> dynamically allocated memory.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/kernel/head_64.S      |  6 ------
>  arch/x86/kernel/setup_percpu.c | 12 ++----------
>  arch/x86/kernel/vmlinux.lds.S  | 24 +-----------------------
>  arch/x86/tools/relocs.c        | 10 +++-------
>  arch/x86/xen/xen-head.S        |  6 ------
>  init/Kconfig                   |  2 +-
>  6 files changed, 7 insertions(+), 53 deletions(-)
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
> index c87dc8de2084..8d8eb4d9ff9d 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -102,12 +102,6 @@ jiffies =3D jiffies_64;
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
> @@ -223,21 +217,7 @@ SECTIONS
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
> @@ -367,9 +347,7 @@ SECTIONS
>                 EXIT_DATA
>         }
>
> -#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
>         PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> -#endif
>
>         . =3D ALIGN(PAGE_SIZE);
>
> @@ -507,7 +485,7 @@ SECTIONS
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
>   */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
> +#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(irq_stack_backing_store);
>
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

Again, please note there is another access to $MSR_GS_BASE in
/arch/x86/platform/pvh/head.S that should be reviewed.

Uros.

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
