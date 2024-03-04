Return-Path: <linux-kernel+bounces-90557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B879870114
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EA41F21D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E713E47A;
	Mon,  4 Mar 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRLSZpbC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ppw8y05"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C923D3A4;
	Mon,  4 Mar 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554512; cv=none; b=XLWa6pdahmQjZhV+yCj2xf257nvcjCs1LoLwUS9VSRXH+CDpGCU6W49JKSwZQZsx09DcSY/23FTLWhb/8WrDhSz6itB8VCsrv+aFat3A6QMvKxz6gvwDPGn5g6NQTiYQ4JbwhR/0GvoMvTmjVgL2HsdLPgRl1391Yu8z49zUTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554512; c=relaxed/simple;
	bh=O4YPBXk06Z/LswFItKphIK70oMVrjDQkBBmiAgD6Ytg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AcsCL4nw328GionqmVd70dlvsh3qcJQf5LP2nEHuPk4P2kI8JdXYD3rGpN30hLfNtFXkYIfjD1VcWlfN8T69eGrCmC1mjZ4hg8OVuHFxlHLRX70W7bCm0BBDVFa6Di1BehlbNwyNkBRKlIU220K0wGvDMwB7BRQSGF7fXty6yz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRLSZpbC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ppw8y05; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geDnCpFgvxB2oKuj16bvG/AKad282wxpMr9/+JHwrUs=;
	b=oRLSZpbCB5QNoPjWYrnk0rPtJeGnZBmnQPIlj2cN64PaNTfLcdCiGPm6H4CXH9Csrfn7yz
	iSj6FDWAKGQZ+yHbKlq+uenpD6ZOoVFlQKStI0a4kcywgxStbJC1/BoFcz6iXKOI64dzT4
	AbuBibodT/n+tbyUnIpwmooIR+IRTQd4SOo4kgxRkA0WW4VfQ0L/XF1eRGBOnkq7/Eh2At
	LhceOOidUDw1jfpI1BK3SsTJPOqqELgRi5QZeeIpnSnwrjpY1Xrwo9wWMTa7MUmtuc0GCs
	Xhy78PHPR7G0cSE+qxAMHOAAWkEzroEUoszVG30JbIgoteCJxLXSA0qjmH6SOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geDnCpFgvxB2oKuj16bvG/AKad282wxpMr9/+JHwrUs=;
	b=2ppw8y05MWorFOd7EMG30tXdeIfn8zEvSZnCKQlTVroWcRXLGmi/H+MfnQ+GMC8OgMcRGm
	iPotwwRHLnvzCYBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Prepare for including <linux/percpu.h>
 into <asm/msr.h>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.454678686@linutronix.de>
References: <20240304005104.454678686@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450788.398.5285179242265335833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     154fcf3a788868cb87d8c2e50c0b5b3a2fe89853
Gitweb:        https://git.kernel.org/tip/154fcf3a788868cb87d8c2e50c0b5b3a2fe89853
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:01:39 +01:00

x86/msr: Prepare for including <linux/percpu.h> into <asm/msr.h>

To clean up the per CPU insanity of UP which causes sparse to be rightfully
unhappy and prevents the usage of the generic per CPU accessors on cpu_info
it is necessary to include <linux/percpu.h> into <asm/msr.h>.

Including <linux/percpu.h> into <asm/msr.h> is impossible because it ends
up in header dependency hell. The problem is that <asm/processor.h>
includes <asm/msr.h>. The inclusion of <linux/percpu.h> results in a
compile fail where the compiler cannot longer handle an include in
<asm/cpufeature.h> which references boot_cpu_data which is
defined in <asm/processor.h>.

The only reason why <asm/msr.h> is included in <asm/processor.h> are the
set/get_debugctlmsr() inlines. They are defined there because <asm/processor.h>
is such a nice dump ground for everything. In fact they belong obviously
into <asm/debugreg.h>.

Move them to <asm/debugreg.h> and fix up the resulting damage which is just
exposing the reliance on random include chains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.454678686@linutronix.de
---
 arch/x86/events/intel/core.c         |  1 +
 arch/x86/events/intel/ds.c           |  1 +
 arch/x86/include/asm/debugreg.h      | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/fsgsbase.h      |  2 +-
 arch/x86/include/asm/processor.h     | 22 ----------------------
 arch/x86/include/asm/special_insns.h |  4 ++--
 arch/x86/kernel/cpu/intel_pconfig.c  |  2 ++
 arch/x86/kernel/cpu/rdrand.c         |  1 +
 arch/x86/kernel/fpu/bugs.c           |  2 ++
 arch/x86/kernel/step.c               |  2 ++
 10 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3804f21..768d141 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
+#include <asm/debugreg.h>
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
 #include <asm/intel_pt.h>
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d49d661..2641ba6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -5,6 +5,7 @@
 #include <linux/sched/clock.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/debugreg.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 0cec92c..fdbbbfe 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -5,7 +5,9 @@
 #include <linux/bug.h>
 #include <linux/percpu.h>
 #include <uapi/asm/debugreg.h>
+
 #include <asm/cpufeature.h>
+#include <asm/msr.h>
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
@@ -159,4 +161,26 @@ static inline unsigned long amd_get_dr_addr_mask(unsigned int dr)
 }
 #endif
 
+static inline unsigned long get_debugctlmsr(void)
+{
+	unsigned long debugctlmsr = 0;
+
+#ifndef CONFIG_X86_DEBUGCTLMSR
+	if (boot_cpu_data.x86 < 6)
+		return 0;
+#endif
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+
+	return debugctlmsr;
+}
+
+static inline void update_debugctlmsr(unsigned long debugctlmsr)
+{
+#ifndef CONFIG_X86_DEBUGCTLMSR
+	if (boot_cpu_data.x86 < 6)
+		return;
+#endif
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+}
+
 #endif /* _ASM_X86_DEBUGREG_H */
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 35cff5f..9e7e8ca 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_X86_64
 
-#include <asm/msr-index.h>
+#include <asm/msr.h>
 
 /*
  * Read/write a task's FSBASE or GSBASE. This returns the value that
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7..d2ef4f5 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -576,28 +576,6 @@ extern void cpu_init(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
-static inline unsigned long get_debugctlmsr(void)
-{
-	unsigned long debugctlmsr = 0;
-
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
-		return 0;
-#endif
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
-
-	return debugctlmsr;
-}
-
-static inline void update_debugctlmsr(unsigned long debugctlmsr)
-{
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
-		return;
-#endif
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
-}
-
 extern void set_task_blockstep(struct task_struct *task, bool on);
 
 /* Boot loader type from the setup header: */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 48f8dd4..f13df37 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -2,11 +2,11 @@
 #ifndef _ASM_X86_SPECIAL_INSNS_H
 #define _ASM_X86_SPECIAL_INSNS_H
 
-
 #ifdef __KERNEL__
-
 #include <asm/nops.h>
 #include <asm/processor-flags.h>
+
+#include <linux/errno.h>
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
 
diff --git a/arch/x86/kernel/cpu/intel_pconfig.c b/arch/x86/kernel/cpu/intel_pconfig.c
index 0771a90..5be2b17 100644
--- a/arch/x86/kernel/cpu/intel_pconfig.c
+++ b/arch/x86/kernel/cpu/intel_pconfig.c
@@ -7,6 +7,8 @@
  * Author:
  *	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
  */
+#include <linux/bug.h>
+#include <linux/limits.h>
 
 #include <asm/cpufeature.h>
 #include <asm/intel_pconfig.h>
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 26a427f..eeac00d 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -6,6 +6,7 @@
  * Authors: Fenghua Yu <fenghua.yu@intel.com>,
  *          H. Peter Anvin <hpa@linux.intel.com>
  */
+#include <linux/printk.h>
 
 #include <asm/processor.h>
 #include <asm/archrandom.h>
diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index a06b876..edbafc5 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -2,6 +2,8 @@
 /*
  * x86 FPU bug checks:
  */
+#include <linux/printk.h>
+
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 8e2b255..3e29526 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -6,7 +6,9 @@
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
+
 #include <asm/desc.h>
+#include <asm/debugreg.h>
 #include <asm/mmu_context.h>
 
 unsigned long convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs)

