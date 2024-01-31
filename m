Return-Path: <linux-kernel+bounces-47118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2D844992
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D6C1F2A25D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442A39AE1;
	Wed, 31 Jan 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARsrVK5H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v842x7GS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A539ACB;
	Wed, 31 Jan 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735684; cv=none; b=iiTWlLnKLrofZADOIYIH8nGctAwl2Yr1+PKw+8UGMjlbpwQmh+4/IZRO7MYSg3m3Bbf56XK2aAJRGpjvwBcikvz1grN/KvEJIKFAdX2JeMCWGPuIjjz9MH4PvTs+LEYpFjkgsGxD0PfFMdS55KDI6Ak5dnl6ahoQmPacmlsX/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735684; c=relaxed/simple;
	bh=9ykMrphsrV3gOqS9CEnTDd8zPfyb7x2fjopZpH5jeUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kdb7w+w8yYTp5IOr2iJGbFaOMJM3aD0ZjUTdWPjGXWJA9ZvNwf/D/YzfQ5ZbY0FCSXaaMzWAt1ySHaJvhjKsnMjHj8kK/bJ8LmJCx+/QJFJYiGtnREEqpd49mguN6DymnYhWbqzhkjSfvQ7KfyS832lWRoYyxgQCd/9nc4QUj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARsrVK5H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v842x7GS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzT4fBdeD+AxykjrUzhzPCyuCsO7X1550Lr6D+eVDQM=;
	b=ARsrVK5HRXm3MT5OipcZfvtRC92EQMaEcGN0kcQDgjOfhCfDEELgzMDTPk5UMPTv5bXG4d
	kiSCX/GM5+oANG50a4QrljLqGmvdM3JYu576y9lCW73wfFa8jD/dk+YTyTJYVkuYpH+mLd
	kPYDWTvj3RN45UcVWoG/ybJWM5ITyDwULgOo3oKfUrnQY7JbNFIWeMHRFuti2O/qsnTnr0
	p+qadgm1JBVbJk4hIYLhgk49x02zs3C6zXuBDyzNjX5IydPS1yN5Z0XXdsG1WWzGdTVQBU
	ERnA3nAOqVPC8w7VuhB8yhJMjeKpOQQfcM0x3SA33rS0t1R+mea/dYwBc4V+2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzT4fBdeD+AxykjrUzhzPCyuCsO7X1550Lr6D+eVDQM=;
	b=v842x7GSHZxLkp2vKZ8yFqEpEep+oavL/GKUYp2gvSMulREVUVMz45YRqxiD479KUL02+j
	pPZzy10tkcHqljAA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add FRED initialization functions
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-35-xin3.li@intel.com>
References: <20231205105030.8698-35-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673567962.398.15247656787676456855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     cdd99dd873cb11c40adf1ef70693f72c622ac8f3
Gitweb:        https://git.kernel.org/tip/cdd99dd873cb11c40adf1ef70693f72c622ac8f3
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:23 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:03:32 +01:00

x86/fred: Add FRED initialization functions

Add cpu_init_fred_exceptions() to:
  - Set FRED entrypoints for events happening in ring 0 and 3.
  - Specify the stack level for IRQs occurred ring 0.
  - Specify dedicated event stacks for #DB/NMI/#MCE/#DF.
  - Enable FRED and invalidtes IDT.
  - Force 32-bit system calls to use "int $0x80" only.

Add fred_complete_exception_setup() to:
  - Initialize system_vectors as done for IDT systems.
  - Set unused sysvec_table entries to fred_handle_spurious_interrupt().

Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-35-xin3.li@intel.com
---
 arch/x86/entry/entry_fred.c | 21 +++++++++++++-
 arch/x86/include/asm/fred.h |  5 +++-
 arch/x86/kernel/Makefile    |  1 +-
 arch/x86/kernel/fred.c      | 59 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 86 insertions(+)
 create mode 100644 arch/x86/kernel/fred.c

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 6ecc08b..ac120cb 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -133,6 +133,27 @@ void __init fred_install_sysvec(unsigned int sysvec, idtentry_t handler)
 		 sysvec_table[sysvec - FIRST_SYSTEM_VECTOR] = handler;
 }
 
+static noinstr void fred_handle_spurious_interrupt(struct pt_regs *regs)
+{
+	spurious_interrupt(regs, regs->fred_ss.vector);
+}
+
+void __init fred_complete_exception_setup(void)
+{
+	unsigned int vector;
+
+	for (vector = 0; vector < FIRST_EXTERNAL_VECTOR; vector++)
+		set_bit(vector, system_vectors);
+
+	for (vector = 0; vector < NR_SYSTEM_VECTORS; vector++) {
+		if (sysvec_table[vector])
+			set_bit(vector + FIRST_SYSTEM_VECTOR, system_vectors);
+		else
+			sysvec_table[vector] = fred_handle_spurious_interrupt;
+	}
+	fred_setup_done = true;
+}
+
 static noinstr void fred_extint(struct pt_regs *regs)
 {
 	unsigned int vector = regs->fred_ss.vector;
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2fa9f34..e86c7ba 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -83,8 +83,13 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int 
 	asm_fred_entry_from_kvm(ss);
 }
 
+void cpu_init_fred_exceptions(void);
+void fred_complete_exception_setup(void);
+
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
+static inline void cpu_init_fred_exceptions(void) { }
+static inline void fred_complete_exception_setup(void) { }
 static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325..0dcbfc1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y			+= platform-quirks.o
 obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
+obj-$(CONFIG_X86_FRED)	+= fred.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
 obj-$(CONFIG_X86_KERNEL_IBT)		+= ibt_selftest.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
new file mode 100644
index 0000000..4bcd879
--- /dev/null
+++ b/arch/x86/kernel/fred.c
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/kernel.h>
+
+#include <asm/desc.h>
+#include <asm/fred.h>
+#include <asm/tlbflush.h>
+#include <asm/traps.h>
+
+/* #DB in the kernel would imply the use of a kernel debugger. */
+#define FRED_DB_STACK_LEVEL		1UL
+#define FRED_NMI_STACK_LEVEL		2UL
+#define FRED_MC_STACK_LEVEL		2UL
+/*
+ * #DF is the highest level because a #DF means "something went wrong
+ * *while delivering an exception*." The number of cases for which that
+ * can happen with FRED is drastically reduced and basically amounts to
+ * "the stack you pointed me to is broken." Thus, always change stacks
+ * on #DF, which means it should be at the highest level.
+ */
+#define FRED_DF_STACK_LEVEL		3UL
+
+#define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
+
+void cpu_init_fred_exceptions(void)
+{
+	/* When FRED is enabled by default, remove this log message */
+	pr_info("Initialize FRED on CPU%d\n", smp_processor_id());
+
+	wrmsrl(MSR_IA32_FRED_CONFIG,
+	       /* Reserve for CALL emulation */
+	       FRED_CONFIG_REDZONE |
+	       FRED_CONFIG_INT_STKLVL(0) |
+	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
+
+	/*
+	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
+	 * (remember that user space faults are always taken on stack level 0)
+	 * is to avoid overflowing the kernel stack.
+	 */
+	wrmsrl(MSR_IA32_FRED_STKLVLS,
+	       FRED_STKLVL(X86_TRAP_DB,  FRED_DB_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_NMI, FRED_NMI_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_MC,  FRED_MC_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
+
+	/* The FRED equivalents to IST stacks... */
+	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
+	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
+	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
+
+	/* Enable FRED */
+	cr4_set_bits(X86_CR4_FRED);
+	/* Any further IDT use is a bug */
+	idt_invalidate();
+
+	/* Use int $0x80 for 32-bit system calls in FRED mode */
+	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+}

