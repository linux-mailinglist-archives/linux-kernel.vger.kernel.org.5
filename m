Return-Path: <linux-kernel+bounces-35356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DB838FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193CBB2A260
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2680064AA5;
	Tue, 23 Jan 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGYIsjwz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+Kjv5uP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F35FB88
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015475; cv=none; b=i3bteHFBAtOn6Z931l7iKObgkG0QgiCgc8Y5lg4GBkmrlbRCZ7HYkc++q/5pEIROZFGGorSgTI4K05UfpiW00PEhCa7M9+cqzU1ogp4Es/FEdUSQ9TeoTVf4j3mXstBNGACkn0OIqPhSOlvYAarvLJ/y2VZEbZxLUNpgTDvJAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015475; c=relaxed/simple;
	bh=wnrsINmLR+LY+VkLruv5uhfAC/mCv21ArAmJxh4gDa8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nc0KZRajUSwucPThOtdhECYHTIV86UnvjvonzaHS+WLxAoTTMPFxlQ8CzZRXkDIrzMX7O2lH2qsftAg7uhNc4ptbVUBW3D2EcUP16JOm3c8eGF9Fk4+AIgurAGwQJKcrOM/ao7MoPmSzOVtoJvSvMqaBS8p4uhMyVCLrptTp9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGYIsjwz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+Kjv5uP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.287143098@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4JRDe/V227lnSowfg1qZVmiYTNeEvNK8Z2s6JWMeTBE=;
	b=UGYIsjwzRkrzbQ//xiJu31ZvmHqmlzu/UOvSDcdlcOdwoqAKhnQ33Z6iM4oFCpFDQ95Gbc
	vup7xJV345SKfpNXgKIHwOC6OINO5tWrirCmDRqBASNm9dvSnzPCWhiFCAqHcw+/8u5a4F
	nr/LTGkV4FJXXmv1fBJVTQBV0oijM3TSFLZi+gemd/zUBLOpatJTAHCXySu9ZDYf346d5c
	gdgBzuprvk+AZ3/dc3C3F4ngJ+yablDC+MbdKjtX2C+URLeTxNbEKIx6Zzg6nHRwEI9BzF
	XpK3Nqgn0EOh7jZ8lmrL88NKJm02WBaDRRZ/Q/5L/9M9wDe/amxcYNuFIrqS0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4JRDe/V227lnSowfg1qZVmiYTNeEvNK8Z2s6JWMeTBE=;
	b=9+Kjv5uPWtRINcrHi/ni5j8f83ccWoCyLO91ni8NQoWt9KlFHQtDrh4JvxZpLgD6MZmE/O
	gwhz3FgT6et/2cBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v2 13/30] x86/cpu/topology: Sanitize the APIC admission logic
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:10 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Move the actually required content of generic_processor_id() into the call
sites and use common helper functions for them. This separates the early
boot registration and the ACPI hotplug mechanism completely which allows
further cleanups and improvements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/topology.c |  160 +++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 82 deletions(-)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -30,8 +30,10 @@ static struct {
 	unsigned int		nr_assigned_cpus;
 	unsigned int		nr_disabled_cpus;
 	unsigned int		nr_rejected_cpus;
+	u32			boot_cpu_apic_id;
 } topo_info __read_mostly = {
 	.nr_assigned_cpus	= 1,
+	.boot_cpu_apic_id	= BAD_APICID,
 };
 
 /*
@@ -83,78 +85,6 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-static int topo_lookup_cpuid(u32 apic_id)
-{
-	int i;
-
-	/* CPU# to APICID mapping is persistent once it is established */
-	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
-		if (cpuid_to_apicid[i] == apic_id)
-			return i;
-	}
-	return -ENODEV;
-}
-
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(u32 apic_id)
-{
-	int cpu = topo_lookup_cpuid(apic_id);
-
-	if (cpu >= 0)
-		return cpu;
-
-	return topo_info.nr_assigned_cpus++;
-}
-
-static void cpu_update_apic(unsigned int cpu, u32 apic_id)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
-#endif
-	cpuid_to_apicid[cpu] = apic_id;
-	set_cpu_possible(cpu, true);
-	set_bit(apic_id, phys_cpu_present_map);
-	set_cpu_present(cpu, true);
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apic_id);
-}
-
-static int generic_processor_info(int apicid)
-{
-	int cpu;
-
-	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
-	if (cpuid_to_apicid[0] == BAD_APICID)
-		panic("Boot CPU APIC not registered yet\n");
-
-	if (apicid == boot_cpu_physical_apicid)
-		return 0;
-
-	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = topo_info.nr_assigned_cpus + topo_info.nr_disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		topo_info.nr_rejected_cpus++;
-		return -ENODEV;
-	}
-
-	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
-		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
-		topo_info.nr_rejected_cpus++;
-		return -ENOSPC;
-	}
-
-	cpu = allocate_logical_cpuid(apicid);
-	cpu_update_apic(cpu, apicid);
-	return cpu;
-}
-
 static int __initdata setup_possible_cpus = -1;
 
 /*
@@ -222,6 +152,43 @@ static int __initdata setup_possible_cpu
 		set_cpu_possible(i, true);
 }
 
+static int topo_lookup_cpuid(u32 apic_id)
+{
+	int i;
+
+	/* CPU# to APICID mapping is persistent once it is established */
+	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
+		if (cpuid_to_apicid[i] == apic_id)
+			return i;
+	}
+	return -ENODEV;
+}
+
+static int topo_assign_cpunr(u32 apic_id)
+{
+	int cpu = topo_lookup_cpuid(apic_id);
+
+	if (cpu >= 0)
+		return cpu;
+
+	return topo_info.nr_assigned_cpus++;
+}
+
+static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
+	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+#endif
+	cpuid_to_apicid[cpu] = apic_id;
+
+	set_cpu_possible(cpu, true);
+	set_cpu_present(cpu, true);
+
+	if (system_state != SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apic_id);
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -234,17 +201,41 @@ void __init topology_register_apic(u32 a
 
 	if (apic_id >= MAX_LOCAL_APIC) {
 		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	if (!present) {
-		topo_info.nr_disabled_cpus++;
+	/* CPU numbers exhausted? */
+	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
+		pr_warn_once("CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	cpu = generic_processor_info(apic_id);
-	if (cpu >= 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+	if (disabled_cpu_apicid == apic_id) {
+		pr_info("Disabling CPU as requested via 'disable_cpu_apicid=0x%x'.\n", apic_id);
+		topo_info.nr_rejected_cpus++;
+		return;
+	}
+
+	if (present) {
+		/*
+		 * Prevent double registration, which is valid in case of
+		 * the boot CPU APIC because that is registered before the
+		 * enumeration of the APICs via firmware parsers or VM
+		 * guest mechanisms.
+		 */
+		if (test_and_set_bit(apic_id, phys_cpu_present_map))
+			return;
+
+		if (apic_id == topo_info.boot_cpu_apic_id)
+			cpu = 0;
+		else
+			cpu = topo_assign_cpunr(apic_id);
+		topo_set_cpuids(cpu, apic_id, acpi_id);
+	} else {
+		topo_info.nr_disabled_cpus++;
+	}
 }
 
 /**
@@ -255,8 +246,10 @@ void __init topology_register_apic(u32 a
  */
 void __init topology_register_boot_apic(u32 apic_id)
 {
-	cpuid_to_apicid[0] = apic_id;
-	cpu_update_apic(0, apic_id);
+	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
+
+	topo_info.boot_cpu_apic_id = apic_id;
+	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -274,10 +267,13 @@ int topology_hotplug_apic(u32 apic_id, u
 
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
-		cpu = generic_processor_info(apic_id);
-		if (cpu >= 0)
-			per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)
+			return -ENOSPC;
+
+		cpu = topo_assign_cpunr(apic_id);
 	}
+	set_bit(apic_id, phys_cpu_present_map);
+	topo_set_cpuids(cpu, apic_id, acpi_id);
 	return cpu;
 }
 


