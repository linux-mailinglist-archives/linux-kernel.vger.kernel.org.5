Return-Path: <linux-kernel+bounces-125474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657768926A5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0F71F22F80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0AA13CFB6;
	Fri, 29 Mar 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNOWxZAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2613C9AF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750476; cv=none; b=i4UVGCOa7gZVSfeK4GKPGpQv8+OoAntPv7NN0QhOkoZ9a5ZHpzNWaCP9tVsH9NquNzn/XGefLyqrfIt3WaMj/vt5kHCGh5zgNBekUK9yXg5e875JB8f6lZ/Niqh5a+2TBo03ar85akdF5tKDrYta8QqMz0RL4GSOEGRuW+8D4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750476; c=relaxed/simple;
	bh=dKDPe7B9dEWJewRnbiLgD4Bln99u6/3pg6yCpafqg7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahROnnpQUFqLmAHxRm5d3YiaLyamrMDGekUsdBk1hc5K6FNXPxIWyJh4MzNVaQLx5sZjDmt9iSUX/spbXwSzvecFxfbymFuVyaPLGbzQB7JX70PFIcI6vZ71HZVZreWvChJm/5nQ9uJB4De6/bh00EsjRB2YjzhnAaA1LO+0lCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNOWxZAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE32EC433C7;
	Fri, 29 Mar 2024 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750476;
	bh=dKDPe7B9dEWJewRnbiLgD4Bln99u6/3pg6yCpafqg7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNOWxZAQtBI101BtGTLaZ2x7N0vyDZ9GfWQCyMBnhI/d90hHttxc61HZlY2KoPKpI
	 daJee32EVcyNUkpTOWy7oU0NX+ruT2O5N5QhHZgWXSsisJ/JYzS52FqYkfoeLH8o+X
	 wAjO+PqzLRlPl3ZMG1eM9oD93nixLGkWSPrGVDjEIOUz8tHwkcFlWQLOBj3jmKFyil
	 7pM0LsNvGv+47rdfSIF3vXrE5uZW6M7/hmCR6pm9VDqwZdlvMOwMfPQkepcaOyyyJX
	 M3stJDGd8hnWOWBx1Xqxt7CLxCydDUS3c1vr8GYrNJ0T2XmAQKsMIZcn1rS2zQ+2GI
	 AhfK2nWasJKpA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] ARC: Fix typos
Date: Fri, 29 Mar 2024 17:14:32 -0500
Message-Id: <20240329221432.1658516-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/arc".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arc/boot/Makefile                    |  4 ++--
 arch/arc/boot/dts/axc003.dtsi             |  4 ++--
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi      |  2 +-
 arch/arc/include/asm/dsp.h                |  2 +-
 arch/arc/include/asm/entry-compact.h      | 10 +++++-----
 arch/arc/include/asm/entry.h              |  4 ++--
 arch/arc/include/asm/irq.h                |  2 +-
 arch/arc/include/asm/irqflags-compact.h   |  2 +-
 arch/arc/include/asm/mmu_context.h        |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h |  2 +-
 arch/arc/include/asm/shmparam.h           |  2 +-
 arch/arc/include/asm/smp.h                |  4 ++--
 arch/arc/include/asm/thread_info.h        |  2 +-
 arch/arc/include/uapi/asm/swab.h          |  2 +-
 arch/arc/kernel/entry-arcv2.S             |  8 ++++----
 arch/arc/kernel/entry.S                   |  4 ++--
 arch/arc/kernel/head.S                    |  2 +-
 arch/arc/kernel/intc-arcv2.c              |  2 +-
 arch/arc/kernel/perf_event.c              |  2 +-
 arch/arc/kernel/setup.c                   |  2 +-
 arch/arc/kernel/signal.c                  |  7 ++++---
 arch/arc/kernel/traps.c                   |  2 +-
 arch/arc/kernel/vmlinux.lds.S             |  4 ++--
 arch/arc/mm/tlb.c                         |  4 ++--
 arch/arc/mm/tlbex.S                       |  8 ++++----
 25 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
index 5648748c285f..5a8550124b73 100644
--- a/arch/arc/boot/Makefile
+++ b/arch/arc/boot/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# uImage build relies on mkimage being availble on your host for ARC target
+# uImage build relies on mkimage being available on your host for ARC target
 # You will need to build u-boot for ARC, rename mkimage to arc-elf32-mkimage
-# and make sure it's reacable from your PATH
+# and make sure it's reachable from your PATH
 
 OBJCOPYFLAGS= -O binary -R .note -R .note.gnu.build-id -R .comment -S
 
diff --git a/arch/arc/boot/dts/axc003.dtsi b/arch/arc/boot/dts/axc003.dtsi
index 3434c8131ecd..c0a812674ce9 100644
--- a/arch/arc/boot/dts/axc003.dtsi
+++ b/arch/arc/boot/dts/axc003.dtsi
@@ -119,9 +119,9 @@ mmc@15000 {
 	/*
 	 * The DW APB ICTL intc on MB is connected to CPU intc via a
 	 * DT "invisible" DW APB GPIO block, configured to simply pass thru
-	 * interrupts - setup accordinly in platform init (plat-axs10x/ax10x.c)
+	 * interrupts - setup accordingly in platform init (plat-axs10x/ax10x.c)
 	 *
-	 * So here we mimic a direct connection betwen them, ignoring the
+	 * So here we mimic a direct connection between them, ignoring the
 	 * ABPG GPIO. Thus set "interrupts = <24>" (DW APB GPIO to core)
 	 * instead of "interrupts = <12>" (DW APB ICTL to DW APB GPIO)
 	 *
diff --git a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
index 90a412026e64..0e0e2d337bf8 100644
--- a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
@@ -113,7 +113,7 @@ mmc@15000 {
 	/*
 	 * Embedded Vision subsystem UIO mappings; only relevant for EV VDK
 	 *
-	 * This node is intentionally put outside of MB above becase
+	 * This node is intentionally put outside of MB above because
 	 * it maps areas outside of MB's 0xez-0xfz.
 	 */
 	uio_ev: uio@d0000000 {
diff --git a/arch/arc/include/asm/dsp.h b/arch/arc/include/asm/dsp.h
index 202c78e56704..f496dbc4640b 100644
--- a/arch/arc/include/asm/dsp.h
+++ b/arch/arc/include/asm/dsp.h
@@ -12,7 +12,7 @@
 /*
  * DSP-related saved registers - need to be saved only when you are
  * scheduled out.
- * structure fields name must correspond to aux register defenitions for
+ * structure fields name must correspond to aux register definitions for
  * automatic offset calculation in DSP_AUX_SAVE_RESTORE macros
  */
 struct dsp_callee_regs {
diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 92c3e9f13252..00946fe04c9b 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -7,7 +7,7 @@
  *  Stack switching code can no longer reliably rely on the fact that
  *  if we are NOT in user mode, stack is switched to kernel mode.
  *  e.g. L2 IRQ interrupted a L1 ISR which had not yet completed
- *  it's prologue including stack switching from user mode
+ *  its prologue including stack switching from user mode
  *
  * Vineetg: Aug 28th 2008: Bug #94984
  *  -Zero Overhead Loop Context shd be cleared when entering IRQ/EXcp/Trap
@@ -143,7 +143,7 @@
 	 * 2. L1 IRQ taken, ISR starts (CPU auto-switched to KERNEL mode)
 	 * 3. But before it could switch SP from USER to KERNEL stack
 	 *      a L2 IRQ "Interrupts" L1
-	 * Thay way although L2 IRQ happened in Kernel mode, stack is still
+	 * That way although L2 IRQ happened in Kernel mode, stack is still
 	 * not switched.
 	 * To handle this, we may need to switch stack even if in kernel mode
 	 * provided SP has values in range of USER mode stack ( < 0x7000_0000 )
@@ -173,7 +173,7 @@
 
 	GET_CURR_TASK_ON_CPU   r9
 
-	/* With current tsk in r9, get it's kernel mode stack base */
+	/* With current tsk in r9, get its kernel mode stack base */
 	GET_TSK_STACK_BASE  r9, r9
 
 	/* save U mode SP @ pt_regs->sp */
@@ -282,7 +282,7 @@
  * NOTE:
  *
  * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
- * for memory load operations. If used in that way interrupts are deffered
+ * for memory load operations. If used in that way interrupts are deferred
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
@@ -350,7 +350,7 @@
  * NOTE:
  *
  * It is recommended that lp_count/ilink1/ilink2 not be used as a dest reg
- * for memory load operations. If used in that way interrupts are deffered
+ * for memory load operations. If used in that way interrupts are deferred
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
 .macro INTERRUPT_EPILOGUE  LVL
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index cf1ba376e992..38c35722cebf 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARC_ENTRY_H
 #define __ASM_ARC_ENTRY_H
 
-#include <asm/unistd.h>		/* For NR_syscalls defination */
+#include <asm/unistd.h>		/* For NR_syscalls definition */
 #include <asm/arcregs.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>	/* For VMALLOC_START */
@@ -56,7 +56,7 @@
 .endm
 
 /*-------------------------------------------------------------
- * given a tsk struct, get to the base of it's kernel mode stack
+ * given a tsk struct, get to the base of its kernel mode stack
  * tsk->thread_info is really a PAGE, whose bottom hoists stack
  * which grows upwards towards thread_info
  *------------------------------------------------------------*/
diff --git a/arch/arc/include/asm/irq.h b/arch/arc/include/asm/irq.h
index c574712ad865..9cd79263acba 100644
--- a/arch/arc/include/asm/irq.h
+++ b/arch/arc/include/asm/irq.h
@@ -10,7 +10,7 @@
  * ARCv2 can support 240 interrupts in the core interrupts controllers and
  * 128 interrupts in IDU. Thus 512 virtual IRQs must be enough for most
  * configurations of boards.
- * This doesnt affect ARCompact, but we change it to same value
+ * This doesn't affect ARCompact, but we change it to same value
  */
 #define NR_IRQS		512
 
diff --git a/arch/arc/include/asm/irqflags-compact.h b/arch/arc/include/asm/irqflags-compact.h
index 0d63e568d64c..936a2f21f315 100644
--- a/arch/arc/include/asm/irqflags-compact.h
+++ b/arch/arc/include/asm/irqflags-compact.h
@@ -46,7 +46,7 @@
  * IRQ Control Macros
  *
  * All of them have "memory" clobber (compiler barrier) which is needed to
- * ensure that LD/ST requiring irq safetly (R-M-W when LLSC is not available)
+ * ensure that LD/ST requiring irq safety (R-M-W when LLSC is not available)
  * are redone after IRQs are re-enabled (and gcc doesn't reuse stale register)
  *
  * Noted at the time of Abilis Timer List corruption
diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index dda471f5f05b..9963bb1a5733 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -165,7 +165,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * for retiring-mm. However destroy_context( ) still needs to do that because
  * between mm_release( ) = >deactive_mm( ) and
  * mmput => .. => __mmdrop( ) => destroy_context( )
- * there is a good chance that task gets sched-out/in, making it's ASID valid
+ * there is a good chance that task gets sched-out/in, making its ASID valid
  * again (this teased me for a whole day).
  */
 
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index f3eea3f30b2e..8ebec1b21d24 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -66,7 +66,7 @@
  * Other rules which cause the divergence from 1:1 mapping
  *
  *  1. Although ARC700 can do exclusive execute/write protection (meaning R
- *     can be tracked independet of X/W unlike some other CPUs), still to
+ *     can be tracked independently of X/W unlike some other CPUs), still to
  *     keep things consistent with other archs:
  *      -Write implies Read:   W => R
  *      -Execute implies Read: X => R
diff --git a/arch/arc/include/asm/shmparam.h b/arch/arc/include/asm/shmparam.h
index 8b0251464ffd..719112af0f41 100644
--- a/arch/arc/include/asm/shmparam.h
+++ b/arch/arc/include/asm/shmparam.h
@@ -6,7 +6,7 @@
 #ifndef __ARC_ASM_SHMPARAM_H
 #define __ARC_ASM_SHMPARAM_H
 
-/* Handle upto 2 cache bins */
+/* Handle up to 2 cache bins */
 #define	SHMLBA	(2 * PAGE_SIZE)
 
 /* Enforce SHMLBA in shmat */
diff --git a/arch/arc/include/asm/smp.h b/arch/arc/include/asm/smp.h
index e0913f52c2cd..990f834909f0 100644
--- a/arch/arc/include/asm/smp.h
+++ b/arch/arc/include/asm/smp.h
@@ -77,7 +77,7 @@ static inline const char *arc_platform_smp_cpuinfo(void)
 
 /*
  * ARC700 doesn't support atomic Read-Modify-Write ops.
- * Originally Interrupts had to be disabled around code to gaurantee atomicity.
+ * Originally Interrupts had to be disabled around code to guarantee atomicity.
  * The LLOCK/SCOND insns allow writing interrupt-hassle-free based atomic ops
  * based on retry-if-irq-in-atomic (with hardware assist).
  * However despite these, we provide the IRQ disabling variant
@@ -86,7 +86,7 @@ static inline const char *arc_platform_smp_cpuinfo(void)
  *	support needed.
  *
  * (2) In a SMP setup, the LLOCK/SCOND atomicity across CPUs needs to be
- *	gaurantted by the platform (not something which core handles).
+ *	guaranteed by the platform (not something which core handles).
  *	Assuming a platform won't, SMP Linux needs to use spinlocks + local IRQ
  *	disabling for atomicity.
  *
diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 4c530cf131f3..12daaf3a61ea 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -38,7 +38,7 @@
 struct thread_info {
 	unsigned long flags;		/* low level flags */
 	unsigned long ksp;		/* kernel mode stack top in __switch_to */
-	int preempt_count;		/* 0 => preemptable, <0 => BUG */
+	int preempt_count;		/* 0 => preemptible, <0 => BUG */
 	int cpu;			/* current CPU */
 	unsigned long thr_ptr;		/* TLS ptr */
 	struct task_struct *task;	/* main task structure */
diff --git a/arch/arc/include/uapi/asm/swab.h b/arch/arc/include/uapi/asm/swab.h
index 02109cd48ee1..8d1f1ef44ba7 100644
--- a/arch/arc/include/uapi/asm/swab.h
+++ b/arch/arc/include/uapi/asm/swab.h
@@ -62,7 +62,7 @@
  * 8051fdc4:	st     r2,[r1,20]	; Mem op : save result back to mem
  *
  * Joern suggested a better "C" algorithm which is great since
- * (1) It is portable to any architecure
+ * (1) It is portable to any architecture
  * (2) At the same time it takes advantage of ARC ISA (rotate intrns)
  */
 
diff --git a/arch/arc/kernel/entry-arcv2.S b/arch/arc/kernel/entry-arcv2.S
index 2e49c81c8086..e238b5fd3c8c 100644
--- a/arch/arc/kernel/entry-arcv2.S
+++ b/arch/arc/kernel/entry-arcv2.S
@@ -5,7 +5,7 @@
  * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
  */
 
-#include <linux/linkage.h>   /* ARC_{EXTRY,EXIT} */
+#include <linux/linkage.h>   /* ARC_{ENTRY,EXIT} */
 #include <asm/entry.h>       /* SAVE_ALL_{INT1,INT2,TRAP...} */
 #include <asm/errno.h>
 #include <asm/arcregs.h>
@@ -31,7 +31,7 @@ VECTOR	res_service		; Reset Vector
 VECTOR	mem_service		; Mem exception
 VECTOR	instr_service		; Instrn Error
 VECTOR	EV_MachineCheck		; Fatal Machine check
-VECTOR	EV_TLBMissI		; Intruction TLB miss
+VECTOR	EV_TLBMissI		; Instruction TLB miss
 VECTOR	EV_TLBMissD		; Data TLB miss
 VECTOR	EV_TLBProtV		; Protection Violation
 VECTOR	EV_PrivilegeV		; Privilege Violation
@@ -76,11 +76,11 @@ ENTRY(handle_interrupt)
 	# query in hard ISR path would return false (since .IE is set) which would
 	# trips genirq interrupt handling asserts.
 	#
-	# So do a "soft" disable of interrutps here.
+	# So do a "soft" disable of interrupts here.
 	#
 	# Note this disable is only for consistent book-keeping as further interrupts
 	# will be disabled anyways even w/o this. Hardware tracks active interrupts
-	# seperately in AUX_IRQ_ACT.active and will not take new interrupts
+	# separately in AUX_IRQ_ACT.active and will not take new interrupts
 	# unless this one returns (or higher prio becomes pending in 2-prio scheme)
 
 	IRQ_DISABLE
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 089f6680518f..3c7e74aba679 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -95,7 +95,7 @@ ENTRY(EV_MachineCheck)
 	lr  r0, [efa]
 	mov r1, sp
 
-	; MC excpetions disable MMU
+	; MC exceptions disable MMU
 	ARC_MMU_REENABLE r3
 
 	lsr  	r3, r10, 8
@@ -209,7 +209,7 @@ trap_with_param:
 
 ; ---------------------------------------------
 ; syscall TRAP
-; ABI: (r0-r7) upto 8 args, (r8) syscall number
+; ABI: (r0-r7) up to 8 args, (r8) syscall number
 ; ---------------------------------------------
 
 ENTRY(EV_Trap)
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 9152782444b5..8d541f53fae3 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -165,7 +165,7 @@ ENTRY(first_lines_of_secondary)
 	; setup stack (fp, sp)
 	mov	fp, 0
 
-	; set it's stack base to tsk->thread_info bottom
+	; set its stack base to tsk->thread_info bottom
 	GET_TSK_STACK_BASE r0, sp
 
 	j	start_kernel_secondary
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 678898757e47..f324f0e3341a 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -56,7 +56,7 @@ void arc_init_IRQ(void)
 	WRITE_AUX(AUX_IRQ_CTRL, ictrl);
 
 	/*
-	 * ARCv2 core intc provides multiple interrupt priorities (upto 16).
+	 * ARCv2 core intc provides multiple interrupt priorities (up to 16).
 	 * Typical builds though have only two levels (0-high, 1-low)
 	 * Linux by default uses lower prio 1 for most irqs, reserving 0 for
 	 * NMI style interrupts in future (say perf)
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index adff957962da..6e5a651cd75c 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -38,7 +38,7 @@
  * (based on a specific RTL build)
  * Below is the static map between perf generic/arc specific event_id and
  * h/w condition names.
- * At the time of probe, we loop thru each index and find it's name to
+ * At the time of probe, we loop thru each index and find its name to
  * complete the mapping of perf event_id to h/w index as latter is needed
  * to program the counter really
  */
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index d08a5092c2b4..7b6a9beba9db 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -390,7 +390,7 @@ static void arc_chk_core_config(struct cpuinfo_arc *info)
 #ifdef CONFIG_ARC_HAS_DCCM
 	/*
 	 * DCCM can be arbit placed in hardware.
-	 * Make sure it's placement/sz matches what Linux is built with
+	 * Make sure its placement/sz matches what Linux is built with
 	 */
 	if ((unsigned int)__arc_dccm_base != info->dccm.base)
 		panic("Linux built with incorrect DCCM Base address\n");
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 8f6f4a542964..fefa705a8638 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -8,15 +8,16 @@
  *
  * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
  *  -do_signal() supports TIF_RESTORE_SIGMASK
- *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
- *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implemen
+ *  -do_signal() no longer needs oldset, required by OLD sys_sigsuspend
+ *  -sys_rt_sigsuspend() now comes from generic code, so discard arch
+ *   implementation
  *  -sys_sigsuspend() no longer needs to fudge ptregs, hence that arg removed
  *  -sys_sigsuspend() no longer loops for do_signal(), sets TIF_xxx and leaves
  *   the job to do_signal()
  *
  * vineetg: July 2009
  *  -Modified Code to support the uClibc provided userland sigreturn stub
- *   to avoid kernel synthesing it on user stack at runtime, costing TLB
+ *   to avoid kernel synthesizing it on user stack at runtime, costing TLB
  *   probes and Cache line flushes.
  *
  * vineetg: July 2009
diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
index 9b9570b79362..a19751e824fb 100644
--- a/arch/arc/kernel/traps.c
+++ b/arch/arc/kernel/traps.c
@@ -89,7 +89,7 @@ int do_misaligned_access(unsigned long address, struct pt_regs *regs,
 
 /*
  * Entry point for miscll errors such as Nested Exceptions
- *  -Duplicate TLB entry is handled seperately though
+ *  -Duplicate TLB entry is handled separately though
  */
 void do_machine_check_fault(unsigned long address, struct pt_regs *regs)
 {
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 549c3f407918..61a1b2b96e1d 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -41,8 +41,8 @@ SECTIONS
 #endif
 
 	/*
-	 * The reason for having a seperate subsection .init.ramfs is to
-	 * prevent objump from including it in kernel dumps
+	 * The reason for having a separate subsection .init.ramfs is to
+	 * prevent objdump from including it in kernel dumps
 	 *
 	 * Reason for having .init.ramfs above .init is to make sure that the
 	 * binary blob is tucked away to one side, reducing the displacement
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index ad702b49aeb3..cae4a7aae0ed 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -212,7 +212,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	unsigned long flags;
 
 	/* If range @start to @end is more than 32 TLB entries deep,
-	 * its better to move to a new ASID rather than searching for
+	 * it's better to move to a new ASID rather than searching for
 	 * individual entries and then shooting them down
 	 *
 	 * The calc above is rough, doesn't account for unaligned parts,
@@ -408,7 +408,7 @@ static void create_tlb(struct vm_area_struct *vma, unsigned long vaddr, pte_t *p
 	 * -More importantly it makes this handler inconsistent with fast-path
 	 *  TLB Refill handler which always deals with "current"
 	 *
-	 * Lets see the use cases when current->mm != vma->mm and we land here
+	 * Let's see the use cases when current->mm != vma->mm and we land here
 	 *  1. execve->copy_strings()->__get_user_pages->handle_mm_fault
 	 *     Here VM wants to pre-install a TLB entry for user stack while
 	 *     current->mm still points to pre-execve mm (hence the condition).
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index e054780a8fe0..dc65e87a531f 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -5,19 +5,19 @@
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * Vineetg: April 2011 :
- *  -MMU v1: moved out legacy code into a seperate file
+ *  -MMU v1: moved out legacy code into a separate file
  *  -MMU v3: PD{0,1} bits layout changed: They don't overlap anymore,
  *      helps avoid a shift when preparing PD0 from PTE
  *
  * Vineetg: July 2009
- *  -For MMU V2, we need not do heuristics at the time of commiting a D-TLB
- *   entry, so that it doesn't knock out it's I-TLB entry
+ *  -For MMU V2, we need not do heuristics at the time of committing a D-TLB
+ *   entry, so that it doesn't knock out its I-TLB entry
  *  -Some more fine tuning:
  *   bmsk instead of add, asl.cc instead of branch, delay slot utilise etc
  *
  * Vineetg: July 2009
  *  -Practically rewrote the I/D TLB Miss handlers
- *   Now 40 and 135 instructions a peice as compared to 131 and 449 resp.
+ *   Now 40 and 135 instructions apiece as compared to 131 and 449 resp.
  *   Hence Leaner by 1.5 K
  *   Used Conditional arithmetic to replace excessive branching
  *   Also used short instructions wherever possible
-- 
2.34.1


