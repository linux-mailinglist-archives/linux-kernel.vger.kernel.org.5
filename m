Return-Path: <linux-kernel+bounces-90554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF087010F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB02E1C214EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A593D565;
	Mon,  4 Mar 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zi02m4mf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzN6kN+A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED533C48C;
	Mon,  4 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554510; cv=none; b=s+VpcC61nRvqN1KCVQgpHLJ0XIiMursgPKE141MdsDfQ/NgYQOLMXIgn94Xn9ZUkUGhX2qKIRpjPwHAAhtVvo7dy3mY/bnSIK3X0BRe7LCpYqcRUaxFcf8N7ubLODJJwo24Lz+tcmxWI+NnQie0adoqXC5JZ0ftqHgOB01jDbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554510; c=relaxed/simple;
	bh=nhAPL9y2KxO+2jXbqXyN9OL+t4E10NC+M/+MS4tvp7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ltIQfSy3XD2f23NjoiUHubco9khm47lx2yZZDbu7v8G+nsen1QHqkqhoRhzrMpW6TCe3CCHcKydi70DqeVxZoPCPidHpXpOJ9yqqbHVaETVtjaExm5vAn9wX1Lqdhd1EbOcmx4tfnuUD9uIzINGq3jaJ6eDuGKnSZJo+CT7E9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zi02m4mf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzN6kN+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4+VQ/SiOTH7NZbdNcIsDTPflajM/nzVAGWxROgwsCA=;
	b=Zi02m4mfR3fEqnI69bZVjB/RnlXRBuMrmZXck89zHCV3gQQrMJ2vAvVWE0TNqmqnWgpBhJ
	KouD7JzRrsl4vzRzHAof9j9puaKOv9ekHOrN8tqJXmx9bj+0RTlH9xBpeVzgvpSe46iqQO
	62LBA/eIrzfH8a664vLHOpZCBIq2OGXwXe/N4GMPe4OrJqFe19v/emBSP68FY01BrTCR+F
	8zvcfNEUZWCWBwyjh9SXUFt3rG//Zj3NeD2StTbi0WXjhEXHHdGbXNUwEzZs+Bzw4Ewe8v
	m1NS4KX8nY6QI4clfOn+4DFgAiLPEQuZFwHefBUHVK91AvAoPvUDMTa6NgUo+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4+VQ/SiOTH7NZbdNcIsDTPflajM/nzVAGWxROgwsCA=;
	b=mzN6kN+AVYshzuTevndgtcSTvJXH2uVH1Wjv7kSE/GxzmDLSw5BopsbrCL7kNMGYMwnwKR
	b11DNc9cuduoHyDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] smp: Consolidate smp_prepare_boot_cpu()
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.567671691@linutronix.de>
References: <20240304005104.567671691@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450642.398.11996171883596347966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     712610725c48c829e42bebfc9908cd92468e2731
Gitweb:        https://git.kernel.org/tip/712610725c48c829e42bebfc9908cd92468e2731
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:01:54 +01:00

smp: Consolidate smp_prepare_boot_cpu()

There is no point in having seven architectures implementing the same empty
stub.

Provide a weak function in the init code and remove the stubs.

This also allows to utilize the function on UP which is required to
sanitize the per CPU handling on X86 UP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.567671691@linutronix.de
---
 arch/alpha/kernel/smp.c     |  5 -----
 arch/arc/kernel/smp.c       |  5 -----
 arch/csky/kernel/smp.c      |  4 ----
 arch/hexagon/kernel/smp.c   |  4 ----
 arch/openrisc/kernel/smp.c  |  4 ----
 arch/riscv/kernel/smpboot.c |  4 ----
 arch/sparc/kernel/smp_64.c  |  4 ----
 arch/x86/include/asm/smp.h  |  5 -----
 arch/x86/kernel/smpboot.c   |  5 +++++
 include/linux/smp.h         | 13 ++++++-------
 init/main.c                 |  4 ++++
 11 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7439b23..8e9dd63 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -467,11 +467,6 @@ smp_prepare_cpus(unsigned int max_cpus)
 	smp_num_cpus = smp_num_probed;
 }
 
-void
-smp_prepare_boot_cpu(void)
-{
-}
-
 int
 __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 8d9b188..b2f2c59 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -39,11 +39,6 @@ struct plat_smp_ops  __weak plat_smp_ops;
 /* XXX: per cpu ? Only needed once in early secondary boot */
 struct task_struct *secondary_idle_tsk;
 
-/* Called from start_kernel */
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 static int __init arc_get_cpu_map(const char *name, struct cpumask *cpumask)
 {
 	unsigned long dt_root = of_get_flat_dt_root();
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 8e42352..92dbbf3 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -152,10 +152,6 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 608884b..65e1fdf 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,10 +114,6 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	local_irq_restore(flags);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 /*
  * interrupts should already be disabled from the VM
  * SP should already be correct; need to set THREADINFO_REG
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 1c5a2d7..86da4bc 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -57,10 +57,6 @@ static void boot_secondary(unsigned int cpu, struct task_struct *idle)
 	spin_unlock(&boot_lock);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_init_cpus(void)
 {
 	struct device_node *cpu;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 519b6bd..c4ed7d9 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -42,10 +42,6 @@
 
 static DECLARE_COMPLETION(cpu_running);
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f3969a3..a0cc9bb 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1206,10 +1206,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-void smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_setup_processor_id(void)
 {
 	if (tlb_type == spitfire)
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed..31edeab 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -59,11 +59,6 @@ static inline void stop_other_cpus(void)
 	smp_ops.stop_other_cpus(1);
 }
 
-static inline void smp_prepare_boot_cpu(void)
-{
-	smp_ops.smp_prepare_boot_cpu();
-}
-
 static inline void smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_ops.smp_prepare_cpus(max_cpus);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce6..980782b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1187,6 +1187,11 @@ void __init smp_prepare_cpus_common(void)
 	set_cpu_sibling_map(0);
 }
 
+void __init smp_prepare_boot_cpu(void)
+{
+	smp_ops.smp_prepare_boot_cpu();
+}
+
 #ifdef CONFIG_X86_64
 /* Establish whether parallel bringup can be supported. */
 bool __init arch_cpuhp_init_parallel_bringup(void)
diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520d..b845929 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,12 @@ static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
 	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 
+/*
+ * Architecture specific boot CPU setup.  Defined as empty weak function in
+ * init/main.c. Architectures can override it.
+ */
+void smp_prepare_boot_cpu(void);
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -171,12 +177,6 @@ void generic_smp_call_function_single_interrupt(void);
 #define generic_smp_call_function_interrupt \
 	generic_smp_call_function_single_interrupt
 
-/*
- * Mark the boot cpu "online" so that it can call console drivers in
- * printk() and can access its per-cpu storage.
- */
-void smp_prepare_boot_cpu(void);
-
 extern unsigned int setup_max_cpus;
 extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
@@ -203,7 +203,6 @@ static inline void up_smp_call_function(smp_call_func_t func, void *info)
 			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
-#define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_many(mask, func, info, wait) \
 			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
diff --git a/init/main.c b/init/main.c
index e24b078..d60bc4b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,10 @@ void __init __weak smp_setup_processor_id(void)
 {
 }
 
+void __init __weak smp_prepare_boot_cpu(void)
+{
+}
+
 # if THREAD_SIZE >= PAGE_SIZE
 void __init __weak thread_stack_cache_init(void)
 {

