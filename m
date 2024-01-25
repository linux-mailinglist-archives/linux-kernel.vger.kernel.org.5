Return-Path: <linux-kernel+bounces-39082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9B83CABA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B6DB253D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372411339B5;
	Thu, 25 Jan 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFwhTBAH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2GH0D6a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F613399E;
	Thu, 25 Jan 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206879; cv=none; b=ej6OgkBp22qBuUUNfsvXqLXHpHkYErNdh7X0TdZzut9X5s2HIUYMU2inaIYjZAVGDf9CFAtk/n9tkgEvMzTaHQFsmj2+UY94e4D068mD710jiESb4hVAcrfYSoiHWzeFug726ud6uV/iEiJ6bJEkbdjIvav6wSe+IBbCu4m/1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206879; c=relaxed/simple;
	bh=skethUZn7yzqVqZNGJKy5duMHwnZLoHacfwAjQEikDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RHVx4M5FY4IU4s+SSOobbb6FbOuynks1InZsS8eKjOag+q35+JXbJJajKHv2dZWiqTebr2aRQnOd3tUpWajEyyX6blsIqxczNc9qX//XSbfF0Fp+j2v8ocHAhyn6m8ZzxIFDTM0mzUohQOCcmqwZNBseUxzA1pHj8YtncCu5F9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFwhTBAH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2GH0D6a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARLx4ZTG2OHVkw5C82zUJWsG5Mon6Bo9mVg7LmvLrIY=;
	b=YFwhTBAHg59TOLVroeI6NwchlWIWx3PW9dlNs7G26+kxeVA21fOYd300EmfPRXx/IhFueQ
	swvLQlMGRRo7BrVmU9FN/+5m+uFcF5JIFkYsJ3GcDpEUTPTSLqkgTifbmrcu+1eADvGjbL
	Afz2I/AhMBBLQKLw4CC2CgdaXpybWNezxn+2xRDRADFCfGxhPTqUSsVs1jKBkpcY0FKSo4
	gG+uJL456fXW3nPcdfxJnmaBEnnG+OipMH/moTPBuKD4gniF/OCwQdjMAe6Z/1V2EdL6PN
	YYyliIu92g4twOCnyEsvrlGTuWXCWkyG5Imvgrj8GWmaPzCas9iYtOKbVxVkbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARLx4ZTG2OHVkw5C82zUJWsG5Mon6Bo9mVg7LmvLrIY=;
	b=z2GH0D6anMp3NQpknwe3AZZzIV9gXnTgQYUoDdUp4H4MiP1XA7lBIfBWG5fQ6TtneFyKYG
	ZOehFHXXvsp4/eDA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add FRED initialization functions
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-35-xin3.li@intel.com>
References: <20231205105030.8698-35-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687470.398.11868717065374762467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     705dc2f2c8eba23abf24aff49ae87ee059a74744
Gitweb:        https://git.kernel.org/tip/705dc2f2c8eba23abf24aff49ae87ee059a74744
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:23 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

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
index 76aefe0..06d00c6 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -131,6 +131,27 @@ void __init fred_install_sysvec(unsigned int sysvec, idtentry_t handler)
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

