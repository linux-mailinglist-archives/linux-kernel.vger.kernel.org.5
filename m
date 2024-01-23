Return-Path: <linux-kernel+bounces-35352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1F838FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2851DB29E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996E63414;
	Tue, 23 Jan 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fem8r3jZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4aAwjwRh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7D2633EA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015468; cv=none; b=ZyEjbfNs+WCHcolXZw0hLDX8y67WHnZIKk9K5OgSg4QJ7M1Hpc60Kp9qBSc4CZM1BQIeU+8XbNV1msQQS3RYGiqZcI5RbqAZ9Zh9NRqWait/seJdH34V3Hvfu/il2nclh1F7ukzuT3YJooQYu0+vuUWHrYEiM7yoTXkpiy6bGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015468; c=relaxed/simple;
	bh=XBmMDfZ0gz2+VnrQJ9myM2OfczhLs81dGTuYtvW/uC0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nOwvAikGXpZZyrFifXCjDNA8csKuM5X1z6WKZ6KRR2fq4h/2AcHC2Qb17YviYPiEOiMXWEFA9UZPPUl/eLWtuj/V1mo4TRPPVrx6wIY/C14VD+U/lOU5Sy6DDk0qyGm8CgMNwXrqo7LIJKtAVTRN8kxhJfc0WaJRghHES++HoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fem8r3jZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4aAwjwRh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.060808881@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TTj/Kz9C0JKUULVztd5kGPjD2rrtKpaEznufq9qVeRw=;
	b=fem8r3jZdpIU2irArkJuEdoK6c00kWvNfcj98kNu8vDgQUFt3U7nMu+/Y0zTt+zw4ws6iF
	tRESMqKpDkbPJfA4epYGd8riY5T3S02RVGNlu0xuq4RaiWKYYv6YTegY1mX90sTzkf0Wgo
	TivkN3KkTlPrsCdig3yCuzq1IZKJJLcPN9VyMmmz05+FOPQavWQKxq+vKolqQTk4bl91l7
	8mN0GzCO6GPVdRIHpNv19VuO2TDtkYf5LSAb7ho+Rsdq6Amn8i89y05u+hNzVs0j0allRh
	Tdy9+vtKRZ4tJUSoGpP3zTD0TKDxQaUVZmd088bkK9CORpi6qD4X9pDKRBu70w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TTj/Kz9C0JKUULVztd5kGPjD2rrtKpaEznufq9qVeRw=;
	b=4aAwjwRhigkMn8/qA7i7OnsVchgdSkTn7ICM+7IWFl42FYWdjcIKxnTcR02X5FTa0huoKN
	fKFBY6zHYcTKBfAg==
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
Subject: [patch v2 09/30] x86/cpu/topology: Confine topology information
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:04 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that all external fiddling with num_processors and disabled_cpus is
gone, move the last user prefill_possible_map() into the topology code too
and remove the global visibility of these variables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/smp.h     |    3 -
 arch/x86/kernel/apic/apic.c    |    1 
 arch/x86/kernel/cpu/topology.c |   76 +++++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/smpboot.c      |   72 --------------------------------------
 4 files changed, 74 insertions(+), 78 deletions(-)
---
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -9,7 +9,6 @@
 #include <asm/thread_info.h>
 
 extern int smp_num_siblings;
-extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -174,8 +173,6 @@ static inline struct cpumask *cpu_llc_sh
 }
 #endif /* CONFIG_SMP */
 
-extern unsigned disabled_cpus;
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2054,7 +2054,6 @@ void __init init_apic_mappings(void)
 			pr_info("APIC: disable apic facility\n");
 			apic_disable();
 		}
-		num_processors = 1;
 	}
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,8 +29,8 @@ u32 cpuid_to_apicid[] __read_mostly = {
  */
 static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
-unsigned int num_processors;
-unsigned disabled_cpus;
+static unsigned int num_processors;
+static unsigned int disabled_cpus;
 
 /*
  * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
@@ -174,6 +174,71 @@ static int generic_processor_info(int ap
 	return cpu;
 }
 
+static int __initdata setup_possible_cpus = -1;
+
+/*
+ * cpu_possible_mask should be static, it cannot change as cpu's
+ * are onlined, or offlined. The reason is per-cpu data-structures
+ * are allocated by some modules at init time, and don't expect to
+ * do this dynamically on cpu arrival/departure.
+ * cpu_present_mask on the other hand can change dynamically.
+ * In case when cpu_hotplug is not compiled, then we resort to current
+ * behaviour, which is cpu_possible == cpu_present.
+ * - Ashok Raj
+ *
+ * Three ways to find out the number of additional hotplug CPUs:
+ * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
+ * - The user can overwrite it with possible_cpus=NUM
+ * - Otherwise don't reserve additional CPUs.
+ * We do this because additional CPUs waste a lot of memory.
+ * -AK
+ */
+__init void prefill_possible_map(void)
+{
+	int i, possible;
+
+	i = setup_max_cpus ?: 1;
+	if (setup_possible_cpus == -1) {
+		possible = num_processors;
+#ifdef CONFIG_HOTPLUG_CPU
+		if (setup_max_cpus)
+			possible += disabled_cpus;
+#else
+		if (possible > i)
+			possible = i;
+#endif
+	} else
+		possible = setup_possible_cpus;
+
+	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
+
+	/* nr_cpu_ids could be reduced via nr_cpus= */
+	if (possible > nr_cpu_ids) {
+		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
+			possible, nr_cpu_ids);
+		possible = nr_cpu_ids;
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!setup_max_cpus)
+#endif
+	if (possible > i) {
+		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
+			possible, setup_max_cpus);
+		possible = i;
+	}
+
+	set_nr_cpu_ids(possible);
+
+	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
+		possible, max_t(int, possible - num_processors, 0));
+
+	reset_cpu_possible_mask();
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -251,6 +316,13 @@ void topology_hotunplug_apic(unsigned in
 }
 #endif
 
+static int __init _setup_possible_cpus(char *str)
+{
+	get_option(&str, &setup_possible_cpus);
+	return 0;
+}
+early_param("possible_cpus", _setup_possible_cpus);
+
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
 	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1291,78 +1291,6 @@ void __init native_smp_cpus_done(unsigne
 	cache_aps_init();
 }
 
-static int __initdata setup_possible_cpus = -1;
-static int __init _setup_possible_cpus(char *str)
-{
-	get_option(&str, &setup_possible_cpus);
-	return 0;
-}
-early_param("possible_cpus", _setup_possible_cpus);
-
-
-/*
- * cpu_possible_mask should be static, it cannot change as cpu's
- * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and don't expect to
- * do this dynamically on cpu arrival/departure.
- * cpu_present_mask on the other hand can change dynamically.
- * In case when cpu_hotplug is not compiled, then we resort to current
- * behaviour, which is cpu_possible == cpu_present.
- * - Ashok Raj
- *
- * Three ways to find out the number of additional hotplug CPUs:
- * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
- * - The user can overwrite it with possible_cpus=NUM
- * - Otherwise don't reserve additional CPUs.
- * We do this because additional CPUs waste a lot of memory.
- * -AK
- */
-__init void prefill_possible_map(void)
-{
-	int i, possible;
-
-	i = setup_max_cpus ?: 1;
-	if (setup_possible_cpus == -1) {
-		possible = num_processors;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible += disabled_cpus;
-#else
-		if (possible > i)
-			possible = i;
-#endif
-	} else
-		possible = setup_possible_cpus;
-
-	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
-
-	/* nr_cpu_ids could be reduced via nr_cpus= */
-	if (possible > nr_cpu_ids) {
-		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
-			possible, nr_cpu_ids);
-		possible = nr_cpu_ids;
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (!setup_max_cpus)
-#endif
-	if (possible > i) {
-		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
-			possible, setup_max_cpus);
-		possible = i;
-	}
-
-	set_nr_cpu_ids(possible);
-
-	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
-		possible, max_t(int, possible - num_processors, 0));
-
-	reset_cpu_possible_mask();
-
-	for (i = 0; i < possible; i++)
-		set_cpu_possible(i, true);
-}
-
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {


