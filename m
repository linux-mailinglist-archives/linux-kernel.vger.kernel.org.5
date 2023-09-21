Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CE7A9976
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjIUSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIUSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:14:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343217B455
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B934DC433AB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695279913;
        bh=7Df8txX6tNh8+z8O5qnNPlJhaZR/jAFhkKBaNPawCzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9Vi0M1ZsDsklANl78Xa6ScOHr6g1CIdNmo7AS65q5i3Wqe5CXuwybAEC65EqagUC
         zDJe2/Ca52cD4TOdb9ZmFHN3b9vhl9yu9U9/BN1tZKG8xydznEZAUbGHPG5/uLt4tv
         JOGsA0T/nFT2UbACt9pJtJ/v7yCzwPtNskC/Rfe22wbFv6rIkgzKuAvR3HJ2EgbHNM
         9Bn5Ec9uWyEdyys2sRfxAPW891MZINBjZQDzydLSqSYDvQelznzvQXU0Dqr2nEWBSo
         vVfgFg3LfPdF1Dgj0aM2LD2JtZAuuhOuas69oyPR5waOYj5YIP8xcXYJcBd5BdkIEi
         9zAOSauRVO4bA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so386389666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 00:05:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz316t2LZDXNjM0XmC4tzSYhLFPo1WBtaoCO8qJOoHoUfyBIM9N
        fyifAH9EDQ6Xe5/x1WL4SJeHLC1Ll31PL15kdKw=
X-Google-Smtp-Source: AGHT+IGJKORn42R8Iq9fBVkx2yqbmcOnkcbAEThoFyikuru3SHpO6vv3HEkzsiWrW4s4ysv339n69atRuTfCMlwLrBc=
X-Received: by 2002:a17:907:3f8c:b0:9ad:f17a:c712 with SMTP id
 hr12-20020a1709073f8c00b009adf17ac712mr12245452ejc.25.1695279912013; Thu, 21
 Sep 2023 00:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230920032810.1392548-1-maobibo@loongson.cn>
In-Reply-To: <20230920032810.1392548-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 21 Sep 2023 15:04:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H79p8gmb7b=YQQjY45g9QexsAnu0MtPG0qREdArM3D0aw@mail.gmail.com>
Message-ID: <CAAhV-H79p8gmb7b=YQQjY45g9QexsAnu0MtPG0qREdArM3D0aw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix some build warnings with W=1 option
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

I applied this patch with even more fixes:
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/commit/?h=3Dloongarch-next&id=3Dc718a0bad75ccef117000223b00fd6a14f849135

Huacai

On Wed, Sep 20, 2023 at 11:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> There are some building warnings when building LoongArch kernel
> with W=3D1 option as following, this patch fixes these building
> warnings.
>
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
> Changes in v2:
>   1. Remove modification about file arch/loongarch/kernel/asm-offsets.c,
> since it is refacted now.
>   2. Add more modification and eliminate almost all building warnings in
> arch/loongarch tree.
> ---
>  arch/loongarch/include/asm/exception.h | 26 ++++++++++++++++++++++++++
>  arch/loongarch/include/asm/io.h        |  4 +---
>  arch/loongarch/include/asm/smp.h       |  1 +
>  arch/loongarch/include/asm/syscall.h   |  1 +
>  arch/loongarch/kernel/Makefile         |  1 +
>  arch/loongarch/kernel/process.c        |  1 +
>  arch/loongarch/kernel/signal.c         |  6 +++---
>  arch/loongarch/kernel/smp.c            |  3 +++
>  arch/loongarch/kernel/syscall.c        |  1 +
>  arch/loongarch/kernel/time.c           |  2 +-
>  arch/loongarch/kernel/traps.c          | 10 ++++++----
>  arch/loongarch/mm/fault.c              |  1 +
>  arch/loongarch/mm/tlb.c                |  2 +-
>  13 files changed, 47 insertions(+), 12 deletions(-)
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
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm=
/io.h
> index 0dcb36b32cb2..58bc88c5a9e5 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -10,6 +10,7 @@
>
>  #include <asm/addrspace.h>
>  #include <asm/cpu.h>
> +#include <asm/early_ioremap.h>
>  #include <asm/page.h>
>  #include <asm/pgtable-bits.h>
>  #include <asm/string.h>
> @@ -19,9 +20,6 @@
>   */
>  #define page_to_phys(page)     ((phys_addr_t)page_to_pfn(page) << PAGE_S=
HIFT)
>
> -extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long s=
ize);
> -extern void __init early_iounmap(void __iomem *addr, unsigned long size)=
;
> -
>  #define early_memremap early_ioremap
>  #define early_memunmap early_iounmap
>
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index 66ecb480c894..a845ed3a6456 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -19,6 +19,7 @@ extern cpumask_t cpu_sibling_map[];
>  extern cpumask_t cpu_core_map[];
>  extern cpumask_t cpu_foreign_map[];
>
> +asmlinkage void start_secondary(void);
>  void loongson_smp_setup(void);
>  void loongson_prepare_cpus(unsigned int max_cpus);
>  void loongson_boot_secondary(int cpu, struct task_struct *idle);
> diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/includ=
e/asm/syscall.h
> index e286dc58476e..089a58d2a45f 100644
> --- a/arch/loongarch/include/asm/syscall.h
> +++ b/arch/loongarch/include/asm/syscall.h
> @@ -20,6 +20,7 @@
>
>  extern void *sys_call_table[];
>
> +void noinstr do_syscall(struct pt_regs *regs);
>  static inline long syscall_get_nr(struct task_struct *task,
>                                   struct pt_regs *regs)
>  {
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
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/proc=
ess.c
> index 3cb082e0c992..767d94cce0de 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -37,6 +37,7 @@
>  #include <asm/bootinfo.h>
>  #include <asm/cpu.h>
>  #include <asm/elf.h>
> +#include <asm/exec.h>
>  #include <asm/fpu.h>
>  #include <asm/lbt.h>
>  #include <asm/io.h>
> diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signa=
l.c
> index 504fdfe85203..aa482eae5e79 100644
> --- a/arch/loongarch/kernel/signal.c
> +++ b/arch/loongarch/kernel/signal.c
> @@ -13,6 +13,7 @@
>  #include <linux/audit.h>
>  #include <linux/cache.h>
>  #include <linux/context_tracking.h>
> +#include <linux/entry-common.h>
>  #include <linux/irqflags.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
> @@ -891,7 +892,7 @@ static unsigned long setup_extcontext(struct extctx_l=
ayout *extctx, unsigned lon
>         return new_sp;
>  }
>
> -void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
> +static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *r=
egs,
>                           struct extctx_layout *extctx)
>  {
>         unsigned long sp;
> @@ -921,8 +922,7 @@ void __user *get_sigframe(struct ksignal *ksig, struc=
t pt_regs *regs,
>  /*
>   * Atomically swap in the new signal mask, and wait for a signal.
>   */
> -
> -asmlinkage long sys_rt_sigreturn(void)
> +SYSCALL_DEFINE0(rt_sigreturn)
>  {
>         int sig;
>         sigset_t set;
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
> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/sysc=
all.c
> index 3fc4211db989..b73218ce55e8 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -15,6 +15,7 @@
>  #include <asm/asm.h>
>  #include <asm/signal.h>
>  #include <asm/switch_to.h>
> +#include <asm/syscall.h>
>  #include <asm-generic/syscalls.h>
>
>  #undef __SYSCALL
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index c189e03cd5da..3064af94db9c 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -29,7 +29,7 @@ static void constant_event_handler(struct clock_event_d=
evice *dev)
>  {
>  }
>
> -irqreturn_t constant_timer_interrupt(int irq, void *data)
> +static irqreturn_t constant_timer_interrupt(int irq, void *data)
>  {
>         int cpu =3D smp_processor_id();
>         struct clock_event_device *cd;
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
