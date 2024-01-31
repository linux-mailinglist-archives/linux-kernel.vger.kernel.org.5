Return-Path: <linux-kernel+bounces-45900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F98437AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FB42879A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCE67A1A;
	Wed, 31 Jan 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BGbuIC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0JonEoGx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCC50A66;
	Wed, 31 Jan 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685678; cv=none; b=JL3su2etAfGKWndMiTMHNMIDjNKwSRrITscQsdog5WQh4hzhvWD+wcPtLYPO5iCyodxaBJeA6YiabiqeTifnSi9H3s8nQO8s3afPke9x1hfycUKouih8FhRcgoPVWwjns6ird+XoGOz9F0w0/7/Bw9M48f4DiqjPM/OcutQpNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685678; c=relaxed/simple;
	bh=NTEGLHsQuz+8ZyQcZ8PdBxdIwfek/WSNzWptEUk/BNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ja6xM4EqJsjUlsJ6UkblDZAtayTPOzKoSZOY1Aa7rJE8jiXCR/20gwT20ngWIHp7GkL3szcgek6EaPRD80zillwl5i3XB2fs7+mGQxBBnYfoWheuBPvRCnQGJ4t49Yf4d2lbgr1JBTc8eNNWUdNajgpbi+RjeTBPbyXR2X7Bu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BGbuIC4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0JonEoGx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AuSJ2pWjqBo0r/+ceND6kTcLht0UsNfC3NtM3ccuyA=;
	b=3BGbuIC4F67H+vW/7Wyvo4e70balMeU7Da/Ev4TYB3BIEkGlwheniot/AU1Iv2M/zYow3B
	kePz6PNWGacAv9YKMHPueBT2ISv1ivOtHIPPUDo8x/NnWWQOqJavsOOF3IZGn0GevGENsN
	1annBHY6fPf82vkgTBrVY8izIU4VrLzbmtG/pQGGc1fvp+LXYs2PejSN6AyLGPAwbvBnVn
	l4dpMPTFkU4h9pxWMty1uqxfwtM/9LvtBDSpV7CAB5LiR5Gexcmt6hUaKf/OwmAAr5Ep8a
	UEO5U80hG9VPN8v9peTPcSL6ne0Vz6nTF8kVDbEVIVWOakc8oNHW8u6OqQyzUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AuSJ2pWjqBo0r/+ceND6kTcLht0UsNfC3NtM3ccuyA=;
	b=0JonEoGx8x+0RORIktl/GBuouZ60Ml3LR1C6B5I0cz6RdIYFtYIm7B4sllJEkstDHLYLUN
	JuUyPweREPmfviBg==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: FRED entry/exit and dispatch code
Cc: Thomas Gleixner <tglx@linutronix.de>, Megha Dey <megha.dey@intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231209214214.2932-1-xin3.li@intel.com>
References: <20231209214214.2932-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668567408.398.17732725010445600033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     6786137bf8fd717bed7ff9ce4eee34ce03a26631
Gitweb:        https://git.kernel.org/tip/6786137bf8fd717bed7ff9ce4eee34ce03a26631
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Sat, 09 Dec 2023 13:42:14 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: FRED entry/exit and dispatch code

The code to actually handle kernel and event entry/exit using
FRED. It is split up into two files thus:

 - entry_64_fred.S contains the actual entrypoints and exit code, and
   saves and restores registers.

 - entry_fred.c contains the two-level event dispatch code for FRED.
   The first-level dispatch is on the event type, and the second-level
   is on the event vector.

  [ bp: Fold in an allmodconfig clang build fix:
    https://lore.kernel.org/r/20240129064521.5168-1-xin3.li@intel.com
    and a CONFIG_IA32_EMULATION=n build fix:
    https://lore.kernel.org/r/20240127093728.1323-3-xin3.li@intel.com]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Originally-by: Megha Dey <megha.dey@intel.com>
Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231209214214.2932-1-xin3.li@intel.com
---
 arch/x86/entry/Makefile               |   5 +-
 arch/x86/entry/entry_64_fred.S        |  50 +++++-
 arch/x86/entry/entry_fred.c           | 245 +++++++++++++++++++++++++-
 arch/x86/include/asm/asm-prototypes.h |   1 +-
 arch/x86/include/asm/fred.h           |   6 +-
 arch/x86/include/asm/ia32.h           |   4 +-
 6 files changed, 308 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/entry/entry_64_fred.S
 create mode 100644 arch/x86/entry/entry_fred.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ca2fe18..c93e7f5 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -18,6 +18,9 @@ obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
+CFLAGS_entry_fred.o		+= -fno-stack-protector
+CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
+
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
-
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
new file mode 100644
index 0000000..c1ddaf6
--- /dev/null
+++ b/arch/x86/entry/entry_64_fred.S
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The actual FRED entry points.
+ */
+
+#include <asm/fred.h>
+
+#include "calling.h"
+
+	.code64
+	.section .noinstr.text, "ax"
+
+.macro FRED_ENTER
+	UNWIND_HINT_END_OF_STACK
+	ENDBR
+	PUSH_AND_CLEAR_REGS
+	movq	%rsp, %rdi	/* %rdi -> pt_regs */
+.endm
+
+.macro FRED_EXIT
+	UNWIND_HINT_REGS
+	POP_REGS
+.endm
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * IA32_FRED_CONFIG & ~FFFH for events that occur in ring 3.
+ * Thus the FRED ring 3 entry point must be 4K page aligned.
+ */
+	.align 4096
+
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
+	FRED_ENTER
+	call	fred_entry_from_user
+	FRED_EXIT
+	ERETU
+SYM_CODE_END(asm_fred_entrypoint_user)
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
+ * ring 0, i.e., asm_fred_entrypoint_user + 256.
+ */
+	.org asm_fred_entrypoint_user + 256, 0xcc
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
+	FRED_ENTER
+	call	fred_entry_from_kernel
+	FRED_EXIT
+	ERETS
+SYM_CODE_END(asm_fred_entrypoint_kernel)
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
new file mode 100644
index 0000000..125b623
--- /dev/null
+++ b/arch/x86/entry/entry_fred.c
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The FRED specific kernel/user entry functions which are invoked from
+ * assembly code and dispatch to the associated handlers.
+ */
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/nospec.h>
+
+#include <asm/desc.h>
+#include <asm/fred.h>
+#include <asm/idtentry.h>
+#include <asm/syscall.h>
+#include <asm/trapnr.h>
+#include <asm/traps.h>
+
+/* FRED EVENT_TYPE_OTHER vector numbers */
+#define FRED_SYSCALL			1
+#define FRED_SYSENTER			2
+
+static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code)
+{
+	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
+	instrumentation_begin();
+
+	/* Panic on events from a high stack level */
+	if (regs->fred_cs.sl > 0) {
+		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+		die("invalid or fatal FRED event", regs, regs->orig_ax);
+		panic("invalid or fatal FRED event");
+	} else {
+		unsigned long flags = oops_begin();
+		int sig = SIGKILL;
+
+		pr_alert("BUG: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+
+		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
+			sig = 0;
+
+		oops_end(flags, regs, sig);
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
+static noinstr void fred_intx(struct pt_regs *regs)
+{
+	switch (regs->fred_ss.vector) {
+	/* Opcode 0xcd, 0x3, NOT INT3 (opcode 0xcc) */
+	case X86_TRAP_BP:
+		return exc_int3(regs);
+
+	/* Opcode 0xcd, 0x4, NOT INTO (opcode 0xce) */
+	case X86_TRAP_OF:
+		return exc_overflow(regs);
+
+#ifdef CONFIG_IA32_EMULATION
+	/* INT80 */
+	case IA32_SYSCALL_VECTOR:
+		if (ia32_enabled())
+			return int80_emulation(regs);
+		fallthrough;
+#endif
+
+	default:
+		return exc_general_protection(regs, 0);
+	}
+}
+
+static __always_inline void fred_other(struct pt_regs *regs)
+{
+	/* The compiler can fold these conditions into a single test */
+	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.lm)) {
+		regs->orig_ax = regs->ax;
+		regs->ax = -ENOSYS;
+		do_syscall_64(regs, regs->orig_ax);
+		return;
+	} else if (ia32_enabled() &&
+		   likely(regs->fred_ss.vector == FRED_SYSENTER && !regs->fred_ss.lm)) {
+		regs->orig_ax = regs->ax;
+		regs->ax = -ENOSYS;
+		do_fast_syscall_32(regs);
+		return;
+	} else {
+		exc_invalid_op(regs);
+		return;
+	}
+}
+
+#define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR] = fred_sysvec_##_function
+
+static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
+	SYSVEC(ERROR_APIC_VECTOR,		error_interrupt),
+	SYSVEC(SPURIOUS_APIC_VECTOR,		spurious_apic_interrupt),
+	SYSVEC(LOCAL_TIMER_VECTOR,		apic_timer_interrupt),
+	SYSVEC(X86_PLATFORM_IPI_VECTOR,		x86_platform_ipi),
+
+	SYSVEC(RESCHEDULE_VECTOR,		reschedule_ipi),
+	SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	call_function_single),
+	SYSVEC(CALL_FUNCTION_VECTOR,		call_function),
+	SYSVEC(REBOOT_VECTOR,			reboot),
+
+	SYSVEC(THRESHOLD_APIC_VECTOR,		threshold),
+	SYSVEC(DEFERRED_ERROR_VECTOR,		deferred_error),
+	SYSVEC(THERMAL_APIC_VECTOR,		thermal),
+
+	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
+
+	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
+	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
+	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+};
+
+static noinstr void fred_extint(struct pt_regs *regs)
+{
+	unsigned int vector = regs->fred_ss.vector;
+	unsigned int index = array_index_nospec(vector - FIRST_SYSTEM_VECTOR,
+						NR_SYSTEM_VECTORS);
+
+	if (WARN_ON_ONCE(vector < FIRST_EXTERNAL_VECTOR))
+		return;
+
+	if (likely(vector >= FIRST_SYSTEM_VECTOR)) {
+		irqentry_state_t state = irqentry_enter(regs);
+
+		instrumentation_begin();
+		sysvec_table[index](regs);
+		instrumentation_end();
+		irqentry_exit(regs, state);
+	} else {
+		common_interrupt(regs, vector);
+	}
+}
+
+static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Optimize for #PF. That's the only exception which matters performance wise */
+	if (likely(regs->fred_ss.vector == X86_TRAP_PF))
+		return exc_page_fault(regs, error_code);
+
+	switch (regs->fred_ss.vector) {
+	case X86_TRAP_DE: return exc_divide_error(regs);
+	case X86_TRAP_DB: return fred_exc_debug(regs);
+	case X86_TRAP_BR: return exc_bounds(regs);
+	case X86_TRAP_UD: return exc_invalid_op(regs);
+	case X86_TRAP_NM: return exc_device_not_available(regs);
+	case X86_TRAP_DF: return exc_double_fault(regs, error_code);
+	case X86_TRAP_TS: return exc_invalid_tss(regs, error_code);
+	case X86_TRAP_NP: return exc_segment_not_present(regs, error_code);
+	case X86_TRAP_SS: return exc_stack_segment(regs, error_code);
+	case X86_TRAP_GP: return exc_general_protection(regs, error_code);
+	case X86_TRAP_MF: return exc_coprocessor_error(regs);
+	case X86_TRAP_AC: return exc_alignment_check(regs, error_code);
+	case X86_TRAP_XF: return exc_simd_coprocessor_error(regs);
+
+#ifdef CONFIG_X86_MCE
+	case X86_TRAP_MC: return fred_exc_machine_check(regs);
+#endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	case X86_TRAP_VE: return exc_virtualization_exception(regs);
+#endif
+#ifdef CONFIG_X86_CET
+	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
+#endif
+	default: return fred_bad_type(regs, error_code);
+	}
+
+}
+
+static noinstr void fred_swexc(struct pt_regs *regs, unsigned long error_code)
+{
+	switch (regs->fred_ss.vector) {
+	case X86_TRAP_BP: return exc_int3(regs);
+	case X86_TRAP_OF: return exc_overflow(regs);
+	default: return fred_bad_type(regs, error_code);
+	}
+}
+
+__visible noinstr void fred_entry_from_user(struct pt_regs *regs)
+{
+	unsigned long error_code = regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax = -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
+			return fred_exc_nmi(regs);
+		break;
+	case EVENT_TYPE_HWEXC:
+		return fred_hwexc(regs, error_code);
+	case EVENT_TYPE_SWINT:
+		return fred_intx(regs);
+	case EVENT_TYPE_PRIV_SWEXC:
+		if (likely(regs->fred_ss.vector == X86_TRAP_DB))
+			return fred_exc_debug(regs);
+		break;
+	case EVENT_TYPE_SWEXC:
+		return fred_swexc(regs, error_code);
+	case EVENT_TYPE_OTHER:
+		return fred_other(regs);
+	default: break;
+	}
+
+	return fred_bad_type(regs, error_code);
+}
+
+__visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
+{
+	unsigned long error_code = regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax = -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
+			return fred_exc_nmi(regs);
+		break;
+	case EVENT_TYPE_HWEXC:
+		return fred_hwexc(regs, error_code);
+	case EVENT_TYPE_PRIV_SWEXC:
+		if (likely(regs->fred_ss.vector == X86_TRAP_DB))
+			return fred_exc_debug(regs);
+		break;
+	case EVENT_TYPE_SWEXC:
+		return fred_swexc(regs, error_code);
+	default: break;
+	}
+
+	return fred_bad_type(regs, error_code);
+}
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa..076bf8d 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/fred.h>
 #include <asm/gsseg.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index f514fdb..16a64ff 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -60,6 +60,12 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
 	return fred_info(regs)->edata;
 }
 
+void asm_fred_entrypoint_user(void);
+void asm_fred_entrypoint_kernel(void);
+
+__visible void fred_entry_from_user(struct pt_regs *regs);
+__visible void fred_entry_from_kernel(struct pt_regs *regs);
+
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 #endif /* CONFIG_X86_FRED */
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index c7ef6ea..4212c00 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -69,7 +69,7 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 extern bool __ia32_enabled;
 
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return __ia32_enabled;
 }
@@ -81,7 +81,7 @@ static inline void ia32_disable(void)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return IS_ENABLED(CONFIG_X86_32);
 }

