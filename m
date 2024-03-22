Return-Path: <linux-kernel+bounces-111969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DE887373
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131951C219A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0007763F6;
	Fri, 22 Mar 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfxiHH89";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGM8XIEd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E064CC6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133799; cv=none; b=o10GDkoZOOMxI4HwIGLAIBiUlf37tE9Smjqn2EDp14t7/Ty+lYGVHhfZRMbgeMxwmLF9f1I0dmSmxUpKGus202FAX6w10uigd90JeeqjLGrd+EkyBWObvCgr9R8CuVnarKHawONQcPGD800xjTj9oYfYiOjgI1Eozd6NG3x2WCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133799; c=relaxed/simple;
	bh=uomzOZuBi433o2v1ed+UcKQaRwy+hYsqDKT9B2pxFfY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JXZ3KyIY7yxEJ35o5EX0xUXRIHQGlo4fD9oFrZ3Vdfb/55OSH0/1plVjgMHGT55NyluoOSjFGrWpgX6cSR+NAEal1AvOAAwOmZNmtGT+ltu2VleRMpXYR6AZ2Q/sayecfajA9rO0d1Fku9Ihddj/052uqmH08mej1JzYaeGyMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfxiHH89; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGM8XIEd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240322185305.127642785@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711133795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eZ/a9nXCdsBTmjGBvNQgGg+XL89AYLjxmhpcQGovN9I=;
	b=ZfxiHH8988QpsLCJTP0+mCGEeej3+qd2ocVY7p0By7o+WkVYwdvCgXf/Unq0Pmp7nH9Ad5
	ENeuz3Q5KSSwJkCLru+XoDpHhkN4hlAjr1EwBJB43EuxvfTVRd4n0zd5LGD10lvkTG8V2p
	RU7yek5mKrsr2Ft5jWs4Sp2GQyonHVpfpb/bWIn1hMzA67kHW83aKbp2uEVlZ7OWmrpn+0
	+s9dXYrC8YKUEUZPGxRtHX+tfi3OhOqxO2efijTf8DXXSIu1pVS2BdI2Asce+0VV/AIKPE
	wMYd/TvKb6WWSwl01rfZRM753pcTeq31U+b4i8Pj41Th99hyVdO5UHd8+JquOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711133795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eZ/a9nXCdsBTmjGBvNQgGg+XL89AYLjxmhpcQGovN9I=;
	b=pGM8XIEdZdDQAHR8w1Oyeshiey+V1ROK785qBtqc/PNbkxOxNebtV0J4FyVYwNgzM9mjZb
	PSURCB31Gy+s9xCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 1/4] x86/cpu: Ensure that CPU info updates are propagated on
 UP
References: <20240322184944.141421692@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 19:56:35 +0100 (CET)

The boot sequence evaluates CPUID information twice:

  1) During early boot

  2) When finalizing the early setup right before
     mitigations are selected and alternatives are patched.

In both cases the evaluation is stored in boot_cpu_data, but on UP the
copying of boot_cpu_data to the per CPU info of the boot CPU happens
between #1 and #2. So any update which happens in #2 is never propagated to
the per CPU info instance.

Consolidate the whole logic and copy boot_cpu_data right before applying
alternatives as that's the point where boot_cpu_data is in it's final state
and not supposed to change anymore.

This also removes the voodoo mb() from smp_prepare_cpus_common() which had
absolutely no purpose.

Fixes: 71eb4893cfaf ("x86/percpu: Cure per CPU madness on UP")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |    9 +++++++++
 arch/x86/kernel/setup.c      |   10 ----------
 arch/x86/kernel/smpboot.c    |   32 +++++---------------------------
 3 files changed, 14 insertions(+), 37 deletions(-)

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
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -313,14 +313,6 @@ static void notrace start_secondary(void
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


