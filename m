Return-Path: <linux-kernel+bounces-112354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9B8878D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C372841E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5541207;
	Sat, 23 Mar 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eu4cQVQi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/gmSf/lP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0F376FC;
	Sat, 23 Mar 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200301; cv=none; b=T425TXNwbrQ7LfF4sZyM8pLAwvXbvsHctY4KIDfpa3wtitCGgJYVeda30qijAMn/zR3KqypkGEBuJIEofXzuZVkkDe8ECvBBHelOKAjNPuqWN4z5p28ApcUg1GDe2YKV47m6KP6guYBrzwsdxL5txCNIyFC9EL8VUh7rRXE1roA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200301; c=relaxed/simple;
	bh=giUpDOquo0wGUWB5aOiAEKwHycSE+id3YWMRG+VI7Lk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZOyJAXSfRggr+wpmZkC4veYmer52rCUce1o+/ukmORWlAC7m0UEzrmycafgRX51NXke7nUwVnSfVvmDBEFQtt9T2JdI9laiKD47vgpfuwv3aBJ1Z0sgrJk5EVy91SXvtaOucceihqHFyMeCKRuQwkzEUhRjVNvKonaQasaalFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eu4cQVQi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/gmSf/lP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Mar 2024 13:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711200291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yknblz/LAqXJWfctfMltGiYL7kYAYN3zaEb0g8apq4=;
	b=Eu4cQVQidMIDbrkyql4hSXatfIKj8zZ+7XJLa2r6eUuKuvK1Xa4GA1HevJpaMI5f3BQ5tv
	jcb0EF1UUJB6gaSzLyukHlxaHbIpo81z/wQ9qmlP7gyfJcO86HiWW0ZKPMjdMfaPfDDUgS
	r8Nw5m/XQbCGs/qi4CGd1RiP/eizbekA3FbhuNWbmvOUE3B4VOKjyIPLoPR7aKvDqGHKE1
	3luC9uaJcuGsbxGRnMmVV5QjveBOJXEHr/oRDsWAIOSJLSfyJgq6k0UMIxVEeMZacYTkGO
	bKeVH1RDN4ddmXfbl1Kj8l4AKkXL9N173wFxd/7cM90bhFq9PROtGhTy4l1q/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711200291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yknblz/LAqXJWfctfMltGiYL7kYAYN3zaEb0g8apq4=;
	b=/gmSf/lP5LmaN9FOXYZjD8EQbb6ngg7cHYo9c9OaqPjUlkVc27erhR7ff13pZ9eYKm/qho
	H5nVOPya/Wx+/1AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu: Ensure that CPU info updates are propagated on UP
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322185305.127642785@linutronix.de>
References: <20240322185305.127642785@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171120029074.10875.2828451664654889730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c90399fbd74a0713d5972a6d931e4a9918621e88
Gitweb:        https://git.kernel.org/tip/c90399fbd74a0713d5972a6d931e4a9918621e88
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Mar 2024 19:56:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 23 Mar 2024 12:22:04 +01:00

x86/cpu: Ensure that CPU info updates are propagated on UP

The boot sequence evaluates CPUID information twice:

  1) During early boot

  2) When finalizing the early setup right before
     mitigations are selected and alternatives are patched.

In both cases the evaluation is stored in boot_cpu_data, but on UP the
copying of boot_cpu_data to the per CPU info of the boot CPU happens
between #1 and #2. So any update which happens in #2 is never propagated to
the per CPU info instance.

Consolidate the whole logic and copy boot_cpu_data right before applying
alternatives as that's the point where boot_cpu_data is in it's final
state and not supposed to change anymore.

This also removes the voodoo mb() from smp_prepare_cpus_common() which
had absolutely no purpose.

Fixes: 71eb4893cfaf ("x86/percpu: Cure per CPU madness on UP")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240322185305.127642785@linutronix.de
---
 arch/x86/kernel/cpu/common.c |  9 +++++++++
 arch/x86/kernel/setup.c      | 10 ----------
 arch/x86/kernel/smpboot.c    | 32 +++++---------------------------
 3 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e..5c1e6d6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2307,6 +2307,8 @@ void arch_smt_update(void)
 
 void __init arch_cpu_finalize_init(void)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
+
 	identify_boot_cpu();
 
 	select_idle_routine();
@@ -2345,6 +2347,13 @@ void __init arch_cpu_finalize_init(void)
 	fpu__init_system();
 	fpu__init_cpu();
 
+	/*
+	 * Ensure that access to the per CPU representation has the initial
+	 * boot CPU configuration.
+	 */
+	*c = boot_cpu_data;
+	c->initialized = true;
+
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e1e96e..ef20650 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1206,16 +1206,6 @@ void __init i386_reserve_resources(void)
 
 #endif /* CONFIG_X86_32 */
 
-#ifndef CONFIG_SMP
-void __init smp_prepare_boot_cpu(void)
-{
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	*c = boot_cpu_data;
-	c->initialized = true;
-}
-#endif
-
 static struct notifier_block kernel_offset_notifier = {
 	.notifier_call = dump_kernel_offset
 };
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe355c8..76bb650 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -313,14 +313,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-static void __init smp_store_boot_cpu_info(void)
-{
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	*c = boot_cpu_data;
-	c->initialized = true;
-}
-
 /*
  * The bootstrap kernel entry code has set these up. Save them for
  * a given CPU
@@ -1039,29 +1031,15 @@ static __init void disable_smp(void)
 	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
-static void __init smp_cpu_index_default(void)
-{
-	int i;
-	struct cpuinfo_x86 *c;
-
-	for_each_possible_cpu(i) {
-		c = &cpu_data(i);
-		/* mark all to hotplug */
-		c->cpu_index = nr_cpu_ids;
-	}
-}
-
 void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
 
-	smp_cpu_index_default();
-
-	/*
-	 * Setup boot CPU information
-	 */
-	smp_store_boot_cpu_info(); /* Final full version of the data */
-	mb();
+	/* Mark all except the boot CPU as hotpluggable */
+	for_each_possible_cpu(i) {
+		if (i)
+			per_cpu(cpu_info.cpu_index, i) = nr_cpu_ids;
+	}
 
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);

