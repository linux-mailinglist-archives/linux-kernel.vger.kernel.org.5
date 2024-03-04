Return-Path: <linux-kernel+bounces-90393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0F86FE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF13FB23EAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77403A8C9;
	Mon,  4 Mar 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxyWzpcY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gm6AaC64"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605439AE1;
	Mon,  4 Mar 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547145; cv=none; b=i4jOh2E2Cz8G9JxUHMqOU7rEFV8pJ4o2TlCwmRw9YRopIGqWdAAN5r2l19eFjAj9oPoOp2d0DM6o5aQpavl8A/CiS9rT04N4IsUIaxbCUQCYD/ElUpS1ngvwyr1syDh/SgjTA98jVJVC8xfk8mDk0EleCblxTLN0rbnem0VREOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547145; c=relaxed/simple;
	bh=+qLR+q/uBoLyfdu4Kb2bde98nuE8brKvaeX/RFH++3g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ExCMIXtRIVdx4VBFeSDw+exi8SR8MQJgosdHHEmKFk6DbTzToLw6MDGvB37gV/nU61MNpVQnD4wyku3WGa/KnyUyKkPFkxvqYYsJyV9KY9ySJ73HGtlMvs4w+PbGNH7ecPe5xxP9AJ6OLqqBSjUobOyOet+hNs8wJASFRv/co8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxyWzpcY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gm6AaC64; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.567671691@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oaBlEsAnKVJlhuCSShod/Mz5x/UHGwu5Y/M9GU3TTqY=;
	b=bxyWzpcYBU4vojC6l9Sr4UrKwz/800Vj5PVoGEx/Jsz6+3lxwDBlb6WHt9RzHMSLu3VEVJ
	2EQGz2kadaVkthhryfkpapXpIjICn8OA96//bSzhi8HQYGBhybGd5je96yycbg3Ndtxd/V
	/S2EIQ7DsBjsq919POW8zkcg57qBA28uMYSLOI/Z8exNkrfj0nPl3HmwPkiOE/Fb1KQWiJ
	IUoipgMsuvsM/brDvw+SPDWoMTbZswCCrO1EUH6i+kP6ktDwrz/mDyWt2HjHz78ZWRx3Jn
	Gh5kbQYBRxtK/3/ion2peua7KPX9NNdidIs1L6Hmw4hSQQpEPVwt8zzf4zG45A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=oaBlEsAnKVJlhuCSShod/Mz5x/UHGwu5Y/M9GU3TTqY=;
	b=gm6AaC648uSUhApkGjnoS+zQ5LiSzriiW9rugLnsQm+58Dgp/rElOwOUUrCPOY2ELxclZn
	JQrQJkdcZMOh+oCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 4/9] smp: Consolidate smp_prepare_boot_cpu()
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:22 +0100 (CET)

There is no point in having seven architectures implementing the same empty
stub.

Provide a weak function in the init code and remove the stubs.

This also allows to utilize the function on UP which is required to
sanitize the percpu handling on X86 UP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/kernel/smp.c     |    5 -----
 arch/arc/kernel/smp.c       |    5 -----
 arch/csky/kernel/smp.c      |    4 ----
 arch/hexagon/kernel/smp.c   |    4 ----
 arch/openrisc/kernel/smp.c  |    4 ----
 arch/riscv/kernel/smpboot.c |    4 ----
 arch/sparc/kernel/smp_64.c  |    4 ----
 arch/x86/include/asm/smp.h  |    5 -----
 arch/x86/kernel/smpboot.c   |    5 +++++
 include/linux/smp.h         |   13 ++++++-------
 init/main.c                 |    4 ++++
 11 files changed, 15 insertions(+), 42 deletions(-)

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
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -39,11 +39,6 @@ struct plat_smp_ops  __weak plat_smp_ops
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
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,10 +114,6 @@ void send_ipi(const struct cpumask *cpum
 	local_irq_restore(flags);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 /*
  * interrupts should already be disabled from the VM
  * SP should already be correct; need to set THREADINFO_REG
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -57,10 +57,6 @@ static void boot_secondary(unsigned int
 	spin_unlock(&boot_lock);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_init_cpus(void)
 {
 	struct device_node *cpu;
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
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1206,10 +1206,6 @@ void __init smp_prepare_cpus(unsigned in
 {
 }
 
-void smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_setup_processor_id(void)
 {
 	if (tlb_type == spitfire)
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
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1187,6 +1187,11 @@ void __init smp_prepare_cpus_common(void
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
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,12 @@ static inline void on_each_cpu_cond(smp_
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
@@ -171,12 +177,6 @@ void generic_smp_call_function_single_in
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
@@ -203,7 +203,6 @@ static inline void up_smp_call_function(
 			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
-#define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_many(mask, func, info, wait) \
 			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,10 @@ void __init __weak smp_setup_processor_i
 {
 }
 
+void __init __weak smp_prepare_boot_cpu(void)
+{
+}
+
 # if THREAD_SIZE >= PAGE_SIZE
 void __init __weak thread_stack_cache_init(void)
 {


