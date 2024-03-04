Return-Path: <linux-kernel+bounces-90391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01D86FE97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE6F1C21F59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86B24B28;
	Mon,  4 Mar 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/53tueK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/WAp4UrI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8A22EEF;
	Mon,  4 Mar 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547143; cv=none; b=oayFqG/4p0hitIE2V/lHnV2oE9jk1QUjqK+fGmJUd6MdeUkL8y+gMJUs0q5zGrWMB9qFBf/oadNo89gpBEF91CSGOCCeGISnmML49Hw4Fah5frlDquJSmcZ3MLQmzMDXCZ3zPHIq+9vBOgzbLctp4kCUftIuifN4VtqopmZzz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547143; c=relaxed/simple;
	bh=oe6F4lKWB++RV3X/5FOu3DsK+9122S04xUjZlqb7KBk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tE53gvllkDKZUkJrFSvmpLQUPsflMSM8qHgDhaOaEq+XrkyMaHDCEdMo2rG4jEWKhIeIrDNoTf9ccSb6FkoCcUXP1VkNW5fy7YkyUzPeAe2Gb7YW9BdTwUHBXrEow3e4l4Y/ALJgmEcv9dNCs8SKCP96iyGt2LlqD+9WvUoGlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/53tueK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/WAp4UrI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.454678686@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JjiiERu9azu6SWbDWr4pKpCYy2SlURHt/nrJBAl1h1Y=;
	b=T/53tueKe10l1d+k71sAf8TP1Hj98kgPukmmg7e9npKY0SbnwTXurPJEINjp3sop4ispQH
	zRXHcPzn5+l8Q6vSmRvB5AUr8lymIZZ1EwmHaHyZpK8Iky5opS49s7GjFQnh/e5QoXkZGr
	+8Bf8hirsVGHAo3f9B05aQ/mFhm4jIiSQrySYEkYhMWjFFCQxYMIt3qpHOGjqkl0cuO2jj
	pvrg62BavUrUEY9h/DaMjk5dDmyQ2dL2dAFA0AO2weYA4kLtRic6c5IC8j6ndW0Hde2qvP
	oc00Gvk860ZFz9HWijHppw3Gw01z7LoZfKTIoGYyRGHa3KQQ4jwW7wP3ZpH1+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JjiiERu9azu6SWbDWr4pKpCYy2SlURHt/nrJBAl1h1Y=;
	b=/WAp4UrICNOMuK6YuFiovxtgIq4qvrMbHE2iTwY9A85zUpHj8F9CFJpKKWXB1n29tO4ORy
	ovTj+gEjKENOOCCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 2/9] x86/msr: Prepare for including percpu.h
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:19 +0100 (CET)

To cleanup the per CPU insanity of UP which causes sparse to be rightfully
unhappy and prevents the usage of the generic per cpu accessors on cpu_info
it is necessary to include linux/percpu.h into asm/msr.h.

Including percpu.h into msr.h is impossible because it ends up in header
dependency hell. The problem is that processor.h includes msr.h. The
inclusion of percpu.h results in a compile fail where the compiler cannot
longer handle an include in cpufeature.h which references boot_cpu_data
which is defined in processor.h

The only reason why msr.h is included in processor.h are the
set/get_debugctlmsr() inlines. They are defined there because processor.h
is such a nice dump ground for everything. In fact they belong obviously
into debugreg.h.

Move them to debugreg.h and fixup the resulting damage which is just
exposing the reliance on random include chains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/events/intel/core.c         |    1 +
 arch/x86/events/intel/ds.c           |    1 +
 arch/x86/include/asm/debugreg.h      |   24 ++++++++++++++++++++++++
 arch/x86/include/asm/fsgsbase.h      |    2 +-
 arch/x86/include/asm/processor.h     |   22 ----------------------
 arch/x86/include/asm/special_insns.h |    4 ++--
 arch/x86/kernel/cpu/intel_pconfig.c  |    2 ++
 arch/x86/kernel/cpu/rdrand.c         |    1 +
 arch/x86/kernel/fpu/bugs.c           |    2 ++
 arch/x86/kernel/step.c               |    2 ++
 10 files changed, 36 insertions(+), 25 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
+#include <asm/debugreg.h>
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
 #include <asm/intel_pt.h>
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -5,6 +5,7 @@
 #include <linux/sched/clock.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/debugreg.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
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
 
@@ -159,4 +161,26 @@ static inline unsigned long amd_get_dr_a
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
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_X86_64
 
-#include <asm/msr-index.h>
+#include <asm/msr.h>
 
 /*
  * Read/write a task's FSBASE or GSBASE. This returns the value that
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -578,28 +578,6 @@ extern void cpu_init(void);
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
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -6,6 +6,7 @@
  * Authors: Fenghua Yu <fenghua.yu@intel.com>,
  *          H. Peter Anvin <hpa@linux.intel.com>
  */
+#include <linux/printk.h>
 
 #include <asm/processor.h>
 #include <asm/archrandom.h>
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


