Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF37A70FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjITD2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjITD2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:28:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6452DB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:28:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8CxfOrKZgplJyYqAA--.53937S3;
        Wed, 20 Sep 2023 11:28:10 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxG9zKZgpl6jUMAA--.24496S2;
        Wed, 20 Sep 2023 11:28:10 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Fix some build warnings with W=1 option
Date:   Wed, 20 Sep 2023 11:28:10 +0800
Message-Id: <20230920032810.1392548-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxG9zKZgpl6jUMAA--.24496S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3ur47Xr1rWFyUJF47ZF13trc_yoWDKF17pF
        ZrAr1kGrZ5Gw1kZF9rA3yjvr13Jws5Kw12v3W2kFyrAF12qrn5Xr4v9FyDXF18ta95KFy0
        vFWfKw1SvF45XwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some building warnings when building LoongArch kernel
with W=1 option as following, this patch fixes these building
warnings.

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
Changes in v2:
  1. Remove modification about file arch/loongarch/kernel/asm-offsets.c,
since it is refacted now.
  2. Add more modification and eliminate almost all building warnings in
arch/loongarch tree.
---
 arch/loongarch/include/asm/exception.h | 26 ++++++++++++++++++++++++++
 arch/loongarch/include/asm/io.h        |  4 +---
 arch/loongarch/include/asm/smp.h       |  1 +
 arch/loongarch/include/asm/syscall.h   |  1 +
 arch/loongarch/kernel/Makefile         |  1 +
 arch/loongarch/kernel/process.c        |  1 +
 arch/loongarch/kernel/signal.c         |  6 +++---
 arch/loongarch/kernel/smp.c            |  3 +++
 arch/loongarch/kernel/syscall.c        |  1 +
 arch/loongarch/kernel/time.c           |  2 +-
 arch/loongarch/kernel/traps.c          | 10 ++++++----
 arch/loongarch/mm/fault.c              |  1 +
 arch/loongarch/mm/tlb.c                |  2 +-
 13 files changed, 47 insertions(+), 12 deletions(-)
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
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 0dcb36b32cb2..58bc88c5a9e5 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -10,6 +10,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/cpu.h>
+#include <asm/early_ioremap.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
@@ -19,9 +20,6 @@
  */
 #define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
-extern void __init early_iounmap(void __iomem *addr, unsigned long size);
-
 #define early_memremap early_ioremap
 #define early_memunmap early_iounmap
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 66ecb480c894..a845ed3a6456 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -19,6 +19,7 @@ extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 extern cpumask_t cpu_foreign_map[];
 
+asmlinkage void start_secondary(void);
 void loongson_smp_setup(void);
 void loongson_prepare_cpus(unsigned int max_cpus);
 void loongson_boot_secondary(int cpu, struct task_struct *idle);
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index e286dc58476e..089a58d2a45f 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -20,6 +20,7 @@
 
 extern void *sys_call_table[];
 
+void noinstr do_syscall(struct pt_regs *regs);
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
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
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 3cb082e0c992..767d94cce0de 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -37,6 +37,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/elf.h>
+#include <asm/exec.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
 #include <asm/io.h>
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 504fdfe85203..aa482eae5e79 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -13,6 +13,7 @@
 #include <linux/audit.h>
 #include <linux/cache.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/irqflags.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -891,7 +892,7 @@ static unsigned long setup_extcontext(struct extctx_layout *extctx, unsigned lon
 	return new_sp;
 }
 
-void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
+static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 			  struct extctx_layout *extctx)
 {
 	unsigned long sp;
@@ -921,8 +922,7 @@ void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-
-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	int sig;
 	sigset_t set;
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
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 3fc4211db989..b73218ce55e8 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/signal.h>
 #include <asm/switch_to.h>
+#include <asm/syscall.h>
 #include <asm-generic/syscalls.h>
 
 #undef __SYSCALL
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index c189e03cd5da..3064af94db9c 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -29,7 +29,7 @@ static void constant_event_handler(struct clock_event_device *dev)
 {
 }
 
-irqreturn_t constant_timer_interrupt(int irq, void *data)
+static irqreturn_t constant_timer_interrupt(int irq, void *data)
 {
 	int cpu = smp_processor_id();
 	struct clock_event_device *cd;
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

