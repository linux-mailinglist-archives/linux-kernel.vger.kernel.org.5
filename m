Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32047D888C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjJZStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:49:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A731A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:49:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so1893659a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698346141; x=1698950941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N6Og79ebnOUyWTGEW3Q50Z1o013flCNliiH7msTKzQ=;
        b=k7QfMQTrR+uV5UaM7kiLr7KUu8EI0TR/umNKBfD9NsmQnqpFE8M+h5sa2261f9lhi5
         HXiPrjhNu4loNWYnxO4sV+XWtPJmwWXtKCStqFIeECzbwfe4DvUrg0MKneqiw6B414MB
         iDoQoLyrjlULpqzhlq8Tt9/VDB1f12WlF6BMa7hmUv+L7/7NwJ6jiid9rVptJ8awJq7G
         gZ0fbccpKwxX1Xowxok4wUICUp+2ac2qnCghMjxJFmBOB/uzME3cdg9VbSpiCfDGEdQX
         uUCccG2uRoY2oOwaudWPMlnAcXTOo133TKxkRSfZw15KWe+2Ip73ls0hHrESypO6p6Au
         BmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346141; x=1698950941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N6Og79ebnOUyWTGEW3Q50Z1o013flCNliiH7msTKzQ=;
        b=B6uq9NAQAawo6fQqpzitssPc9maSvB3/t0siXpZYZdSczopTABYY1AWYE0aKKvoz8Y
         OD7LlMO/WSGQeZB1kNlVzVqkLlErlaDJm4gkwqtx8RSVZfvLztTg4HMDj3kd77Mx29Br
         RBxwnpTJxGdfjgGOXRe0hTDXKHQuBVUEAaSmwVOdNMdBFTeytRcqiS+fASgQGMY9vcNb
         PSE38cPLzmqcAV9pZsys3GG9Nb7zW/DZ34Tcf5RMlszLKNDV3gYifvnNhu+LRuSDs0Cn
         bbupYR5niFRui+lrdfJL7kDwruxKAkUnPXjpFkI0r96DDbL8KySb8ntylBCjV4w0rnpr
         rL9w==
X-Gm-Message-State: AOJu0Yy1BxrMcjfcNPnM7Wcjey15CWzlqD1vk5w2rjPU+JcURyzQZYB1
        kPyLwCwU0XhW03X1E79Omh0kZm5C8UOL9KjoNzw=
X-Google-Smtp-Source: AGHT+IEoS2m2ZQvFhi0YtoS9Qs0lJlwh7RzkKY7+JML+C/+nRZ65v1hOehslsdE4NS/P1XVfXfcqkiDAq4Tkntsj6+A=
X-Received: by 2002:aa7:c441:0:b0:52f:b00a:99be with SMTP id
 n1-20020aa7c441000000b0052fb00a99bemr522645edr.33.1698346140214; Thu, 26 Oct
 2023 11:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-10-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-10-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:48:49 +0200
Message-ID: <CAFULd4YMdEZ7_BT5kvpyL3HwN_bRKTUxgM2_8AC-ua69v6GAew@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] x86/percpu/64: Remove INIT_PER_CPU macros
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
> The load and link addresses of percpu variables are now the same, so
> these macros are no longer necessary.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/percpu.h | 22 ----------------------
>  arch/x86/kernel/irq_64.c      |  1 -
>  arch/x86/kernel/vmlinux.lds.S |  7 -------
>  arch/x86/tools/relocs.c       |  1 -
>  4 files changed, 31 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index b86b27d15e52..7a176381ee01 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -20,12 +20,6 @@
>
>  #define PER_CPU_VAR(var)       __percpu(var)__percpu_rel
>
> -#ifdef CONFIG_X86_64_SMP
> -#define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
> -#else
> -#define INIT_PER_CPU_VAR(var)  var
> -#endif
> -
>  #else /* ...!ASSEMBLY */
>
>  #include <linux/kernel.h>
> @@ -96,22 +90,6 @@
>  #define __percpu_arg(x)                __percpu_prefix "%" #x
>  #define __force_percpu_arg(x)  __force_percpu_prefix "%" #x
>
> -/*
> - * Initialized pointers to per-cpu variables needed for the boot
> - * processor need to use these macros to get the proper address
> - * offset from __per_cpu_load on SMP.
> - *
> - * There also must be an entry in vmlinux_64.lds.S
> - */
> -#define DECLARE_INIT_PER_CPU(var) \
> -       extern typeof(var) init_per_cpu_var(var)
> -
> -#ifdef CONFIG_X86_64_SMP
> -#define init_per_cpu_var(var)  init_per_cpu__##var
> -#else
> -#define init_per_cpu_var(var)  var
> -#endif
> -
>  /* For arch-specific code, we can use direct single-insn ops (they
>   * don't give an lvalue though). */
>
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index fe0c859873d1..30424f9876bc 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -26,7 +26,6 @@
>  #include <asm/apic.h>
>
>  DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) _=
_visible;
> -DECLARE_INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_VMAP_STACK
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index efa4885060b5..9aea7b6b02c7 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -482,13 +482,6 @@ SECTIONS
>            "kernel image bigger than KERNEL_IMAGE_SIZE");
>
>  #ifdef CONFIG_X86_64
> -/*
> - * Per-cpu symbols which need to be offset from __per_cpu_load
> - * for the boot processor.
> - */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
> -INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_CPU_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 7feb63179b62..931d90aa814c 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -83,7 +83,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES]=
 =3D {
>         "__initramfs_start|"
>         "(jiffies|jiffies_64)|"
>  #if ELF_BITS =3D=3D 64
> -       "init_per_cpu__.*|"
>         "__end_rodata_hpage_align|"
>  #endif
>         "__vvar_page|"
> --
> 2.41.0
>
