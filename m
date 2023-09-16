Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE27A2F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjIPJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjIPJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:42:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA21985
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:42:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA1AC433C8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694857355;
        bh=1ELIN6mBqueM7Je8njcwZIy4xjOl1KGE6A2qdOaTLac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZuX+o8tGRGYDt2WdDlfEEM+yQhNO5UpjUuqCyQDXFLc51RdAFyiuHdgcgZIfR44S
         ATsfoX1aEqesSIj83v2+90miIWLd0O7R2mwz6aZqlFlImgruSOZWL+bxvWQ8U8wy6g
         HBW491A1eBNTBESzCM/eYOdU/cMXTr01XtW7WqAvasMtVuwx0J4scEZysrTK4idiRt
         OdK/Epfw8tBt6Nge8JgR0i4flniRPQed25PnUgiHdAvuzlVxEhu1cXvcG4fbSjrCk1
         HHwQyPEm8U70cpmZLlQfH55H6tfc6syU8tNlX4VsFicy1UP5YZXr1yKOJ5bUhBtHKz
         RZL0YxZqR6EOQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso1778985a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:42:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwNqbeBv3Q+M+D2xWPYpXJMJY9jjwCUrDrcnNdyPsyyT1vIvIXY
        yFNfNGGmp9seFy617njGrmTRAjSBOuLtyJFrQ04=
X-Google-Smtp-Source: AGHT+IEJ0BT0Y+SCwXU7AMYo59e8aWWUGdFLSSPsaofb1PUtzOjueM8kLv45N6tvFeLYB4LRHzr5y0sQSDzVrLnw2gE=
X-Received: by 2002:a05:6402:d41:b0:530:9e58:db6b with SMTP id
 ec1-20020a0564020d4100b005309e58db6bmr3121011edb.7.1694857353626; Sat, 16 Sep
 2023 02:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230916092330.971630-1-maobibo@loongson.cn>
In-Reply-To: <20230916092330.971630-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 16 Sep 2023 17:42:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H50_aY8Sw0uPSs1VuNOtbaHF2-a5mZE2jnSC7QPUaWf=Q@mail.gmail.com>
Message-ID: <CAAhV-H50_aY8Sw0uPSs1VuNOtbaHF2-a5mZE2jnSC7QPUaWf=Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix some build warnings with -W1 option
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

On Sat, Sep 16, 2023 at 5:23=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> There are some building warnings when building LoongArch kernel
> with -W1 option as following, this patch fixes these building
> warnings.
Don't touch asm-offsets.c now, because it is being refactored by the commun=
ity.

Huacai
>
> arch/loongarch/kernel/asm-offsets.c:18:6: warning: no previous
> prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
>    18 | void output_ptreg_defines(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> arch/loongarch/kernel/traps.c:496:25: warning: no previous prototype
> for 'do_fpe' [-Wmissing-prototypes]
>   496 | asmlinkage void noinstr do_fpe(struct pt_regs *regs
>       |                         ^~~~~~
> arch/loongarch/kernel/syscall.c:21:40: warning: initialized field
> overwritten [-Woverride-init]
>    21 | #define __SYSCALL(nr, call)     [nr] =3D (call),
>       |                                        ^
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/exception.h | 26 ++++++++++++++++++++++++++
>  arch/loongarch/kernel/Makefile         |  1 +
>  arch/loongarch/kernel/asm-offsets.c    | 24 ++++++++++++------------
>  arch/loongarch/kernel/smp.c            |  3 +++
>  arch/loongarch/kernel/traps.c          | 10 ++++++----
>  arch/loongarch/mm/fault.c              |  1 +
>  arch/loongarch/mm/tlb.c                |  2 +-
>  7 files changed, 50 insertions(+), 17 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/exception.h
>
> diff --git a/arch/loongarch/include/asm/exception.h b/arch/loongarch/incl=
ude/asm/exception.h
> new file mode 100644
> index 000000000000..ffa068aa6ac9
> --- /dev/null
> +++ b/arch/loongarch/include/asm/exception.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_EXCEPTION_H
> +#define __ASM_EXCEPTION_H
> +
> +#include <asm/ptrace.h>
> +
> +asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)=
;
> +asmlinkage void noinstr do_ade(struct pt_regs *regs);
> +asmlinkage void noinstr do_ale(struct pt_regs *regs);
> +asmlinkage void noinstr do_bce(struct pt_regs *regs);
> +asmlinkage void noinstr do_bp(struct pt_regs *regs);
> +asmlinkage void noinstr do_watch(struct pt_regs *regs);
> +asmlinkage void noinstr do_ri(struct pt_regs *regs);
> +asmlinkage void noinstr do_fpu(struct pt_regs *regs);
> +asmlinkage void noinstr do_lsx(struct pt_regs *regs);
> +asmlinkage void noinstr do_lasx(struct pt_regs *regs);
> +asmlinkage void noinstr do_lbt(struct pt_regs *regs);
> +asmlinkage void noinstr do_reserved(struct pt_regs *regs);
> +asmlinkage void cache_parity_error(void);
> +asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs);
> +asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp);
> +asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
> +                               unsigned long write, unsigned long addres=
s);
> +
> +#endif /* __ASM_EXCEPTION_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index c56ea0b75448..1e94764005e1 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_HAS_LBT)     +=3D lbt.o
>
>  obj-$(CONFIG_ARCH_STRICT_ALIGN)        +=3D unaligned.o
>
> +CFLAGS_syscall.o       +=3D $(call cc-option,-Wno-override-init,)
>  ifdef CONFIG_FUNCTION_TRACER
>    ifndef CONFIG_DYNAMIC_FTRACE
>      obj-y +=3D mcount.o ftrace.o
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 8da0726777ed..202873bcfeb0 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -14,7 +14,7 @@
>  #include <asm/processor.h>
>  #include <asm/ftrace.h>
>
> -void output_ptreg_defines(void)
> +static void __used output_ptreg_defines(void)
>  {
>         COMMENT("LoongArch pt_regs offsets.");
>         OFFSET(PT_R0, pt_regs, regs[0]);
> @@ -61,7 +61,7 @@ void output_ptreg_defines(void)
>         BLANK();
>  }
>
> -void output_task_defines(void)
> +static void __used output_task_defines(void)
>  {
>         COMMENT("LoongArch task_struct offsets.");
>         OFFSET(TASK_STATE, task_struct, __state);
> @@ -76,7 +76,7 @@ void output_task_defines(void)
>         BLANK();
>  }
>
> -void output_thread_info_defines(void)
> +static void __used output_thread_info_defines(void)
>  {
>         COMMENT("LoongArch thread_info offsets.");
>         OFFSET(TI_TASK, thread_info, task);
> @@ -92,7 +92,7 @@ void output_thread_info_defines(void)
>         BLANK();
>  }
>
> -void output_thread_defines(void)
> +static void __used output_thread_defines(void)
>  {
>         COMMENT("LoongArch specific thread_struct offsets.");
>         OFFSET(THREAD_REG01, task_struct, thread.reg01);
> @@ -128,7 +128,7 @@ void output_thread_defines(void)
>         BLANK();
>  }
>
> -void output_thread_fpu_defines(void)
> +static void __used output_thread_fpu_defines(void)
>  {
>         OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
>         OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
> @@ -169,7 +169,7 @@ void output_thread_fpu_defines(void)
>         BLANK();
>  }
>
> -void output_thread_lbt_defines(void)
> +static void __used output_thread_lbt_defines(void)
>  {
>         OFFSET(THREAD_SCR0,  loongarch_lbt, scr0);
>         OFFSET(THREAD_SCR1,  loongarch_lbt, scr1);
> @@ -179,7 +179,7 @@ void output_thread_lbt_defines(void)
>         BLANK();
>  }
>
> -void output_mm_defines(void)
> +static void __used output_mm_defines(void)
>  {
>         COMMENT("Size of struct page");
>         DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
> @@ -211,7 +211,7 @@ void output_mm_defines(void)
>         BLANK();
>  }
>
> -void output_sc_defines(void)
> +static void __used output_sc_defines(void)
>  {
>         COMMENT("Linux sigcontext offsets.");
>         OFFSET(SC_REGS, sigcontext, sc_regs);
> @@ -219,7 +219,7 @@ void output_sc_defines(void)
>         BLANK();
>  }
>
> -void output_signal_defines(void)
> +static void __used output_signal_defines(void)
>  {
>         COMMENT("Linux signal numbers.");
>         DEFINE(_SIGHUP, SIGHUP);
> @@ -257,7 +257,7 @@ void output_signal_defines(void)
>  }
>
>  #ifdef CONFIG_SMP
> -void output_smpboot_defines(void)
> +static void __used output_smpboot_defines(void)
>  {
>         COMMENT("Linux smp cpu boot offsets.");
>         OFFSET(CPU_BOOT_STACK, secondary_data, stack);
> @@ -267,7 +267,7 @@ void output_smpboot_defines(void)
>  #endif
>
>  #ifdef CONFIG_HIBERNATION
> -void output_pbe_defines(void)
> +static void __used output_pbe_defines(void)
>  {
>         COMMENT("Linux struct pbe offsets.");
>         OFFSET(PBE_ADDRESS, pbe, address);
> @@ -279,7 +279,7 @@ void output_pbe_defines(void)
>  #endif
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -void output_fgraph_ret_regs_defines(void)
> +static void __used output_fgraph_ret_regs_defines(void)
>  {
>         COMMENT("LoongArch fgraph_ret_regs offsets.");
>         OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 6667b0a90f81..ef35c871244f 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -13,6 +13,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/profile.h>
>  #include <linux/seq_file.h>
>  #include <linux/smp.h>
>  #include <linux/threads.h>
> @@ -556,10 +557,12 @@ void smp_send_stop(void)
>         smp_call_function(stop_this_cpu, NULL, 0);
>  }
>
> +#ifdef CONFIG_PROFILING
>  int setup_profiling_timer(unsigned int multiplier)
>  {
>         return 0;
>  }
> +#endif
>
>  static void flush_tlb_all_ipi(void *info)
>  {
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index 65214774ef7c..e6429047b6d9 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -35,6 +35,7 @@
>  #include <asm/branch.h>
>  #include <asm/break.h>
>  #include <asm/cpu.h>
> +#include <asm/exception.h>
>  #include <asm/fpu.h>
>  #include <asm/lbt.h>
>  #include <asm/inst.h>
> @@ -371,7 +372,7 @@ void show_regs(struct pt_regs *regs)
>         dump_stack();
>  }
>
> -void show_registers(struct pt_regs *regs)
> +static void show_registers(struct pt_regs *regs)
>  {
>         __show_regs(regs);
>         print_modules();
> @@ -439,7 +440,7 @@ static inline void setup_vint_size(unsigned int size)
>   * happen together with Overflow or Underflow, and `ptrace' can set
>   * any bits.
>   */
> -void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
> +static void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
>                      struct task_struct *tsk)
>  {
>         int si_code =3D FPE_FLTUNK;
> @@ -458,7 +459,8 @@ void force_fcsr_sig(unsigned long fcsr, void __user *=
fault_addr,
>         force_sig_fault(SIGFPE, si_code, fault_addr);
>  }
>
> -int process_fpemu_return(int sig, void __user *fault_addr, unsigned long=
 fcsr)
> +static int process_fpemu_return(int sig, void __user *fault_addr,
> +                               unsigned long fcsr)
>  {
>         int si_code;
>
> @@ -824,7 +826,7 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs=
)
>  asmlinkage void noinstr do_ri(struct pt_regs *regs)
>  {
>         int status =3D SIGILL;
> -       unsigned int opcode =3D 0;
> +       unsigned int __maybe_unused opcode;
>         unsigned int __user *era =3D (unsigned int __user *)exception_era=
(regs);
>         irqentry_state_t state =3D irqentry_enter(regs);
>
> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> index e6376e3dce86..02f2a9765524 100644
> --- a/arch/loongarch/mm/fault.c
> +++ b/arch/loongarch/mm/fault.c
> @@ -26,6 +26,7 @@
>  #include <linux/kfence.h>
>
>  #include <asm/branch.h>
> +#include <asm/exception.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptrace.h>
>
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index eb8572e201ea..2c0a411f23aa 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -261,7 +261,7 @@ unsigned long pcpu_handlers[NR_CPUS];
>  #endif
>  extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>
> -void setup_tlb_handler(int cpu)
> +static void setup_tlb_handler(int cpu)
>  {
>         setup_ptwalker();
>         local_flush_tlb_all();
>
> base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
> --
> 2.27.0
>
