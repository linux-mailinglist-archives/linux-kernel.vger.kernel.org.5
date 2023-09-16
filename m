Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC97A2EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjIPJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjIPJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:23:40 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8A101981
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:23:32 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxV_ETdAVlGwcpAA--.13846S3;
        Sat, 16 Sep 2023 17:23:31 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxO9wSdAVl2Z8IAA--.17036S2;
        Sat, 16 Sep 2023 17:23:30 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix some build warnings with -W1 option
Date:   Sat, 16 Sep 2023 17:23:30 +0800
Message-Id: <20230916092330.971630-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxO9wSdAVl2Z8IAA--.17036S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr1fuFyxWw1rZF43GrykJFc_yoWDJw4rpF
        9Iyr1DGrWrCFn7uasFy34DZrnxJrnag3y2va42kFWFvFy3tw1rXr1ktFyDZF1DtaykWF10
        vFy5tw1SqFs8XwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some building warnings when building LoongArch kernel
with -W1 option as following, this patch fixes these building
warnings.

arch/loongarch/kernel/asm-offsets.c:18:6: warning: no previous
prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
   18 | void output_ptreg_defines(void)
      |      ^~~~~~~~~~~~~~~~~~~~
arch/loongarch/kernel/traps.c:496:25: warning: no previous prototype
for 'do_fpe' [-Wmissing-prototypes]
  496 | asmlinkage void noinstr do_fpe(struct pt_regs *regs
      |                         ^~~~~~
arch/loongarch/kernel/syscall.c:21:40: warning: initialized field
overwritten [-Woverride-init]
   21 | #define __SYSCALL(nr, call)     [nr] = (call),
      |                                        ^

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/exception.h | 26 ++++++++++++++++++++++++++
 arch/loongarch/kernel/Makefile         |  1 +
 arch/loongarch/kernel/asm-offsets.c    | 24 ++++++++++++------------
 arch/loongarch/kernel/smp.c            |  3 +++
 arch/loongarch/kernel/traps.c          | 10 ++++++----
 arch/loongarch/mm/fault.c              |  1 +
 arch/loongarch/mm/tlb.c                |  2 +-
 7 files changed, 50 insertions(+), 17 deletions(-)
 create mode 100644 arch/loongarch/include/asm/exception.h

diff --git a/arch/loongarch/include/asm/exception.h b/arch/loongarch/include/asm/exception.h
new file mode 100644
index 000000000000..ffa068aa6ac9
--- /dev/null
+++ b/arch/loongarch/include/asm/exception.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_EXCEPTION_H
+#define __ASM_EXCEPTION_H
+
+#include <asm/ptrace.h>
+
+asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr);
+asmlinkage void noinstr do_ade(struct pt_regs *regs);
+asmlinkage void noinstr do_ale(struct pt_regs *regs);
+asmlinkage void noinstr do_bce(struct pt_regs *regs);
+asmlinkage void noinstr do_bp(struct pt_regs *regs);
+asmlinkage void noinstr do_watch(struct pt_regs *regs);
+asmlinkage void noinstr do_ri(struct pt_regs *regs);
+asmlinkage void noinstr do_fpu(struct pt_regs *regs);
+asmlinkage void noinstr do_lsx(struct pt_regs *regs);
+asmlinkage void noinstr do_lasx(struct pt_regs *regs);
+asmlinkage void noinstr do_lbt(struct pt_regs *regs);
+asmlinkage void noinstr do_reserved(struct pt_regs *regs);
+asmlinkage void cache_parity_error(void);
+asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs);
+asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp);
+asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
+				unsigned long write, unsigned long address);
+
+#endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c56ea0b75448..1e94764005e1 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_HAS_LBT)	+= lbt.o
 
 obj-$(CONFIG_ARCH_STRICT_ALIGN)	+= unaligned.o
 
+CFLAGS_syscall.o	+= $(call cc-option,-Wno-override-init,)
 ifdef CONFIG_FUNCTION_TRACER
   ifndef CONFIG_DYNAMIC_FTRACE
     obj-y += mcount.o ftrace.o
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 8da0726777ed..202873bcfeb0 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ftrace.h>
 
-void output_ptreg_defines(void)
+static void __used output_ptreg_defines(void)
 {
 	COMMENT("LoongArch pt_regs offsets.");
 	OFFSET(PT_R0, pt_regs, regs[0]);
@@ -61,7 +61,7 @@ void output_ptreg_defines(void)
 	BLANK();
 }
 
-void output_task_defines(void)
+static void __used output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
 	OFFSET(TASK_STATE, task_struct, __state);
@@ -76,7 +76,7 @@ void output_task_defines(void)
 	BLANK();
 }
 
-void output_thread_info_defines(void)
+static void __used output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
@@ -92,7 +92,7 @@ void output_thread_info_defines(void)
 	BLANK();
 }
 
-void output_thread_defines(void)
+static void __used output_thread_defines(void)
 {
 	COMMENT("LoongArch specific thread_struct offsets.");
 	OFFSET(THREAD_REG01, task_struct, thread.reg01);
@@ -128,7 +128,7 @@ void output_thread_defines(void)
 	BLANK();
 }
 
-void output_thread_fpu_defines(void)
+static void __used output_thread_fpu_defines(void)
 {
 	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
 	OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
@@ -169,7 +169,7 @@ void output_thread_fpu_defines(void)
 	BLANK();
 }
 
-void output_thread_lbt_defines(void)
+static void __used output_thread_lbt_defines(void)
 {
 	OFFSET(THREAD_SCR0,  loongarch_lbt, scr0);
 	OFFSET(THREAD_SCR1,  loongarch_lbt, scr1);
@@ -179,7 +179,7 @@ void output_thread_lbt_defines(void)
 	BLANK();
 }
 
-void output_mm_defines(void)
+static void __used output_mm_defines(void)
 {
 	COMMENT("Size of struct page");
 	DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
@@ -211,7 +211,7 @@ void output_mm_defines(void)
 	BLANK();
 }
 
-void output_sc_defines(void)
+static void __used output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
 	OFFSET(SC_REGS, sigcontext, sc_regs);
@@ -219,7 +219,7 @@ void output_sc_defines(void)
 	BLANK();
 }
 
-void output_signal_defines(void)
+static void __used output_signal_defines(void)
 {
 	COMMENT("Linux signal numbers.");
 	DEFINE(_SIGHUP, SIGHUP);
@@ -257,7 +257,7 @@ void output_signal_defines(void)
 }
 
 #ifdef CONFIG_SMP
-void output_smpboot_defines(void)
+static void __used output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
 	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
@@ -267,7 +267,7 @@ void output_smpboot_defines(void)
 #endif
 
 #ifdef CONFIG_HIBERNATION
-void output_pbe_defines(void)
+static void __used output_pbe_defines(void)
 {
 	COMMENT("Linux struct pbe offsets.");
 	OFFSET(PBE_ADDRESS, pbe, address);
@@ -279,7 +279,7 @@ void output_pbe_defines(void)
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void output_fgraph_ret_regs_defines(void)
+static void __used output_fgraph_ret_regs_defines(void)
 {
 	COMMENT("LoongArch fgraph_ret_regs offsets.");
 	OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 6667b0a90f81..ef35c871244f 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -13,6 +13,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/profile.h>
 #include <linux/seq_file.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
@@ -556,10 +557,12 @@ void smp_send_stop(void)
 	smp_call_function(stop_this_cpu, NULL, 0);
 }
 
+#ifdef CONFIG_PROFILING
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return 0;
 }
+#endif
 
 static void flush_tlb_all_ipi(void *info)
 {
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 65214774ef7c..e6429047b6d9 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -35,6 +35,7 @@
 #include <asm/branch.h>
 #include <asm/break.h>
 #include <asm/cpu.h>
+#include <asm/exception.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
 #include <asm/inst.h>
@@ -371,7 +372,7 @@ void show_regs(struct pt_regs *regs)
 	dump_stack();
 }
 
-void show_registers(struct pt_regs *regs)
+static void show_registers(struct pt_regs *regs)
 {
 	__show_regs(regs);
 	print_modules();
@@ -439,7 +440,7 @@ static inline void setup_vint_size(unsigned int size)
  * happen together with Overflow or Underflow, and `ptrace' can set
  * any bits.
  */
-void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
+static void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
 	int si_code = FPE_FLTUNK;
@@ -458,7 +459,8 @@ void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
 	force_sig_fault(SIGFPE, si_code, fault_addr);
 }
 
-int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcsr)
+static int process_fpemu_return(int sig, void __user *fault_addr,
+				unsigned long fcsr)
 {
 	int si_code;
 
@@ -824,7 +826,7 @@ asmlinkage void noinstr do_watch(struct pt_regs *regs)
 asmlinkage void noinstr do_ri(struct pt_regs *regs)
 {
 	int status = SIGILL;
-	unsigned int opcode = 0;
+	unsigned int __maybe_unused opcode;
 	unsigned int __user *era = (unsigned int __user *)exception_era(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index e6376e3dce86..02f2a9765524 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -26,6 +26,7 @@
 #include <linux/kfence.h>
 
 #include <asm/branch.h>
+#include <asm/exception.h>
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index eb8572e201ea..2c0a411f23aa 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -261,7 +261,7 @@ unsigned long pcpu_handlers[NR_CPUS];
 #endif
 extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 
-void setup_tlb_handler(int cpu)
+static void setup_tlb_handler(int cpu)
 {
 	setup_ptwalker();
 	local_flush_tlb_all();

base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
-- 
2.27.0

