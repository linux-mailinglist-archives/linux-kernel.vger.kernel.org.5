Return-Path: <linux-kernel+bounces-112424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C988799F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E0C1C20AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AA51C3B;
	Sat, 23 Mar 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QulReOaT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276B4D9ED
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213911; cv=none; b=jxPT9/eGiu0znVEj0XfmYgBy6LCH6AfUBiKgB9DFvFXCLSNeXq+RxqXRd8rodyB/WccFwroNba9dj+t8wcTJd+lhUTE7QY5jkXJ+A5J9s5sR5tZkAzePfSLH5mksPdcTLJDLDvy7lltGDlQrqhNjdnwqZ2Kv4GPYiWzy+afujFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213911; c=relaxed/simple;
	bh=/skpTwlSeediqLvVGlZLBuXtd9C2k5y2S7aPLhz1Gx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0tQ+XdSeBcBH975pC83jovm4imoh7lkVMKsY+3D5Wk7l9gHN/vE+vSaj2tbGbb3WHcV+EQTVeeyH7TU/NB78WxVY1Ik5g+/SogyGfx9uvYzbWfH+v4sCAieJ0eBqdnDHJOTYI7vb+3m08FEdX44j/OFgBApsUFc+bBcHPivP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QulReOaT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so38962641fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711213907; x=1711818707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX6dO4A+tQV6XaFIVXVovhcMt1Xa2zKgtMQMxoAQVZM=;
        b=QulReOaT670ueJpOBSlzTK4tUiA7Ee6/MQ2UN4iQe1QCZ4u8z4u8qjs7eY8do27MUJ
         LvLM4VsbdlIpmD+EnzpMu/b6VMNtVzEarA+wH6szgGEBhdJMgmKV4EGEsP5cbgZ6f05L
         P/vEa+O0pCWCUav4EaRj4PaoeppoDRnAa5k38zbnU6jE4dIaZj/qysyDZ+8tjr57zhAd
         Wmjs+wTPCN+eXC6qL9cHofqPB68TpZL3qTY6Qx2hjuro0yCIcsG8S9tmb3gYCT6JrdS5
         uWi0ajI/KjwJa31n0+/+imz/ak6giFyIYjyp/dKsA32ikkwPHpdfVt0pkzD8gLa5d4+q
         3ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711213907; x=1711818707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX6dO4A+tQV6XaFIVXVovhcMt1Xa2zKgtMQMxoAQVZM=;
        b=p9lUq5y8TkC7Z3Lge7FcXCxapjnLwqYfgTcHHwuaCSDty9OZntP6UEwBKGzsrnwT/n
         qag81QP+qNluR3iemSxmfX9s4QrVjOcouATU4fokoS62HYmNojj8rgaO6PyhNJgKaj7h
         SCWa4U76aysoH13FcOZ+MY2Jbku1LNaf9uqQB/FlGdyDKQvL7Nuw7m+V9BgEp1surOec
         xnFElU2PpGw/HRzTtVFozpHv6M/MG68sr1nrN6pGsBcPhX3Leh0DV7VnEK/3jOJGSQIG
         a2QC+8sFcf3tvq1zUzrF6aPVSVtsCaskheSeEUE8MBhynsmuMv81AvqtG+kFi7uYRpwV
         U3uw==
X-Gm-Message-State: AOJu0Yy0F6oDw1MyGyvkVdQX/m1W+iID6VWEH9d5xg8KV43io8XBuhK5
	uRxpUkSZCJdAMeO/DFW6MoIjwk2ZCHtoKQLQUxzwLuD8BI1CiwAiZoa/QivumUbe/kOIEe8fsLu
	OC5RahLfcCjrPmbEz5kJXcsEdVxaargnM5R8RcQ==
X-Google-Smtp-Source: AGHT+IHJxtNRVMnPw7JUpXd2G+Cv3q6gAvrZGRciCcUMHX2eFe36jIGTK91BNbpvSHwCsqA3USzQa7GUPow3Pgp+X4Q=
X-Received: by 2002:a05:651c:1042:b0:2d6:c1b1:f1c5 with SMTP id
 x2-20020a05651c104200b002d6c1b1f1c5mr1465937ljm.45.1711213907325; Sat, 23 Mar
 2024 10:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-9-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-9-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:11:45 +0100
Message-ID: <CAFULd4a5y8uai3joMtYsZA+MQSkD4zOWBfawWYQqf8a2v8G-1Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/16] x86/stackprotector/64: Convert to normal percpu variable
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Older versions of GCC fixed the location of the stack protector canary
> at %gs:40.  This constraint forced the percpu section to be linked at
> virtual address 0 so that the canary could be the first data object in
> the percpu section.  Supporting the zero-based percpu section requires
> additional code to handle relocations for RIP-relative references to
> percpu data, extra complexity to kallsyms, and workarounds for linker
> bugs due to the use of absolute symbols.
>
> Use compiler options to redefine the stack protector location if
> supported, otherwise use objtool.  This will remove the contraint that
> the percpu section must be zero-based.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

HAVE_STACKPROTECTOR change is not needed without STACKPROTECTOR_OBJTOOL sup=
port.

With the above remark:

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                      | 11 ++++----
>  arch/x86/Makefile                     | 21 ++++++++++------
>  arch/x86/entry/entry_64.S             |  2 +-
>  arch/x86/include/asm/processor.h      | 16 ++----------
>  arch/x86/include/asm/stackprotector.h | 36 ++++-----------------------
>  arch/x86/kernel/asm-offsets_64.c      |  6 -----
>  arch/x86/kernel/cpu/common.c          |  5 +---
>  arch/x86/kernel/head_64.S             |  3 +--
>  arch/x86/xen/xen-head.S               |  3 +--
>  9 files changed, 30 insertions(+), 73 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 121cfb9ffc0e..3dbefdb8a5d6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -271,7 +271,7 @@ config X86
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_SETUP_PER_CPU_AREA
>         select HAVE_SOFTIRQ_ON_OWN_STACK
> -       select HAVE_STACKPROTECTOR              if CC_HAS_SANE_STACKPROTE=
CTOR
> +       select HAVE_STACKPROTECTOR              if X86_64 || CC_HAS_SANE_=
STACKPROTECTOR
>         select HAVE_STACK_VALIDATION            if HAVE_OBJTOOL
>         select HAVE_STATIC_CALL
>         select HAVE_STATIC_CALL_INLINE          if HAVE_OBJTOOL
> @@ -411,15 +411,14 @@ config PGTABLE_LEVELS
>
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
> -       default y if 64BIT
> +       default $(cc-option,-mstack-protector-guard-reg=3Dgs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard) if 64BIT
>         default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
> -       help
> -         We have to make sure stack protector is unconditionally disable=
d if
> -         the compiler does not allow control of the segment and symbol.
>
>  config STACKPROTECTOR_OBJTOOL
>         bool
> -       default n
> +       depends on X86_64 && STACKPROTECTOR
> +       default !CC_HAS_SANE_STACKPROTECTOR
> +       prompt "Debug objtool stack protector conversion" if CC_HAS_SANE_=
STACKPROTECTOR && DEBUG_KERNEL
>
>  menu "Processor type and features"
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 662d9d4033e6..2a3ba1abb802 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -116,13 +116,7 @@ ifeq ($(CONFIG_X86_32),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS +=3D -ffreestanding
>
> -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> -        ifeq ($(CONFIG_SMP),y)
> -                       KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D=
fs -mstack-protector-guard-symbol=3D__stack_chk_guard
> -        else
> -                       KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglob=
al
> -        endif
> -    endif
> +        percpu_seg :=3D fs
>  else
>          BITS :=3D 64
>          UTS_MACHINE :=3D x86_64
> @@ -172,6 +166,19 @@ else
>          KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
> +
> +        percpu_seg :=3D gs
> +endif
> +
> +ifeq ($(CONFIG_STACKPROTECTOR),y)
> +    ifneq ($(CONFIG_STACKPROTECTOR_OBJTOOL),y)
> +        ifeq ($(CONFIG_SMP),y)
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D$(percpu=
_seg)
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3D__sta=
ck_chk_guard
> +        else
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglobal
> +        endif
> +    endif
>  endif
>
>  #
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 8af2a26b24f6..9478ff768dd0 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -191,7 +191,7 @@ SYM_FUNC_START(__switch_to_asm)
>
>  #ifdef CONFIG_STACKPROTECTOR
>         movq    TASK_stack_canary(%rsi), %rbx
> -       movq    %rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
> +       movq    %rbx, PER_CPU_VAR(__stack_chk_guard)
>  #endif
>
>         /*
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 89ed5237e79f..946bebce396f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -387,16 +387,8 @@ struct irq_stack {
>
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
> -       /*
> -        * GCC hardcodes the stack canary as %gs:40.  Since the
> -        * irq_stack is the object at %gs:0, we reserve the bottom
> -        * 48 bytes of the irq stack for the canary.
> -        *
> -        * Once we are willing to require -mstack-protector-guard-symbol=
=3D
> -        * support for x86_64 stackprotector, we can get rid of this.
> -        */
>         char            gs_base[40];
> -       unsigned long   stack_canary;
> +       unsigned long   reserved;
>  };
>
>  DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> @@ -411,11 +403,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
>
>  /* Save actual FS/GS selectors and bases to current->thread */
>  void current_save_fsgs(void);
> -#else  /* X86_64 */
> -#ifdef CONFIG_STACKPROTECTOR
> -DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> -#endif
> -#endif /* !X86_64 */
> +#endif /* X86_64 */
>
>  struct perf_event;
>
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm=
/stackprotector.h
> index 00473a650f51..d43fb589fcf6 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -2,26 +2,10 @@
>  /*
>   * GCC stack protector support.
>   *
> - * Stack protector works by putting predefined pattern at the start of
> + * Stack protector works by putting a predefined pattern at the start of
>   * the stack frame and verifying that it hasn't been overwritten when
> - * returning from the function.  The pattern is called stack canary
> - * and unfortunately gcc historically required it to be at a fixed offse=
t
> - * from the percpu segment base.  On x86_64, the offset is 40 bytes.
> - *
> - * The same segment is shared by percpu area and stack canary.  On
> - * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
> - * base of percpu area.  The first occupant of the percpu area is always
> - * fixed_percpu_data which contains stack_canary at the appropriate
> - * offset.  On x86_32, the stack canary is just a regular percpu
> - * variable.
> - *
> - * Putting percpu data in %fs on 32-bit is a minor optimization compared=
 to
> - * using %gs.  Since 32-bit userspace normally has %fs =3D=3D 0, we are =
likely
> - * to load 0 into %fs on exit to usermode, whereas with percpu data in
> - * %gs, we are likely to load a non-null %gs on return to user mode.
> - *
> - * Once we are willing to require GCC 8.1 or better for 64-bit stackprot=
ector
> - * support, we can remove some of this complexity.
> + * returning from the function.  The pattern is called the stack canary
> + * and is a unique value for each task.
>   */
>
>  #ifndef _ASM_STACKPROTECTOR_H
> @@ -36,6 +20,8 @@
>
>  #include <linux/sched.h>
>
> +DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> +
>  /*
>   * Initialize the stackprotector canary value.
>   *
> @@ -51,25 +37,13 @@ static __always_inline void boot_init_stack_canary(vo=
id)
>  {
>         unsigned long canary =3D get_random_canary();
>
> -#ifdef CONFIG_X86_64
> -       BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) !=
=3D 40);
> -#endif
> -
>         current->stack_canary =3D canary;
> -#ifdef CONFIG_X86_64
> -       this_cpu_write(fixed_percpu_data.stack_canary, canary);
> -#else
>         this_cpu_write(__stack_chk_guard, canary);
> -#endif
>  }
>
>  static inline void cpu_init_stack_canary(int cpu, struct task_struct *id=
le)
>  {
> -#ifdef CONFIG_X86_64
> -       per_cpu(fixed_percpu_data.stack_canary, cpu) =3D idle->stack_cana=
ry;
> -#else
>         per_cpu(__stack_chk_guard, cpu) =3D idle->stack_canary;
> -#endif
>  }
>
>  #else  /* STACKPROTECTOR */
> diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offse=
ts_64.c
> index bb65371ea9df..590b6cd0eac0 100644
> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -54,11 +54,5 @@ int main(void)
>         BLANK();
>  #undef ENTRY
>
> -       BLANK();
> -
> -#ifdef CONFIG_STACKPROTECTOR
> -       OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
> -       BLANK();
> -#endif
>         return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 9a34651d24e7..f49e8f5b858d 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2063,16 +2063,13 @@ void syscall_init(void)
>         if (!cpu_feature_enabled(X86_FEATURE_FRED))
>                 idt_syscall_init();
>  }
> -
> -#else  /* CONFIG_X86_64 */
> +#endif /* CONFIG_X86_64 */
>
>  #ifdef CONFIG_STACKPROTECTOR
>  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
>  EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
>
> -#endif /* CONFIG_X86_64 */
> -
>  /*
>   * Clear all 6 debug registers:
>   */
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index b11526869a40..cfbf0486d424 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -361,8 +361,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data. If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index 758bcd47b72d..ae4672ea00bb 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -53,8 +53,7 @@ SYM_CODE_START(startup_xen)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.  If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> --
> 2.44.0
>

