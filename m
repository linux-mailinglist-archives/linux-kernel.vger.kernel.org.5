Return-Path: <linux-kernel+bounces-68806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D86858095
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6BB1C21FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41440134CF6;
	Fri, 16 Feb 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5KiQ0tn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5+i/1X79"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6E1332B1;
	Fri, 16 Feb 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096623; cv=none; b=kYKYGttPtlWBt8A/dtwUvY3PhBjdlL37SYyBu2ExGke9UPPM35wsgpthp4rSTMDQiuxf/+YPcmAOvulBg3RtxkerGVkEPc3YtrlfbZOOMFzfi73KTL1p7MsPOgKn7j6zXeZnyzdw3uEKcmpPFaPemtdFH5rxKBSIzqiuN/qrSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096623; c=relaxed/simple;
	bh=4zhYXeqy+CtGZQFhigFmFxxa2utczh1kBKg3X+fhjok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iHlNxzsn2Ng4pCn1R/2JFBNL7npOP6xAXhglrFBvJchX2zkLOcCKCrD3l0x5qwl+HsieQVFq+LdHYvyyaLaLEJMANyXZnLc/TniVE9ZmDR29mMdcyKJ1dAtoLn7tQnEysw9ZuUN9udeguwJ+yYXEudUZ6T7T4lluVP4jLgV9UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5KiQ0tn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5+i/1X79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hDPo6YjuINzBCgUWrdRxDknFl2SedIzdeYmKgRDJc=;
	b=X5KiQ0tne9X9McDdVj25Migq6mr/jNEMSggFrOvbRNGn9mVdU6NjFmmcspvi7joJFaTSSP
	xbNYy/ZZr/i1I/IUECi7Yeqp8t2wN2r5FEsOtNyF/5KUxuOygLNz4ibXW5bjcuOfrKzTPE
	d0wU9XYOCBsGCw+aU6W0hP1ITx0oORK3inuVPd2PtnaHOUT5hxRk5byuxcQR7cpZuZ7IZr
	P4FpCjRCFVil4ANgEZyJi21kfGakZKvaH6RTuIY7WrQqyR1LHhH6WniYR734M1Qvdj1X2n
	bS74cbKP1G+2naNUQmrTu9hqQabYS0cbg08uFo7jDE8olw1c/+QqGXOLrj3MIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hDPo6YjuINzBCgUWrdRxDknFl2SedIzdeYmKgRDJc=;
	b=5+i/1X79x3VFAKGRjz257aKpjWb6rOtzopdrxIjNzPcQ6trNVFL2bgIFWBc/bA8goDy8Ka
	owHTAA1elAa5M2AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Rework possible CPU management
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.290098853@linutronix.de>
References: <20240213210252.290098853@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661848.398.4655632957989376186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7c0edad3643f4493c4dafa6f5dfcfb1a86432156
Gitweb:        https://git.kernel.org/tip/7c0edad3643f4493c4dafa6f5dfcfb1a86432156
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu/topology: Rework possible CPU management

Managing possible CPUs is an unreadable and uncomprehensible maze. Aside of
that it's backwards because it applies command line limits after
registering all APICs.

Rewrite it so that it:

  - Applies the command line limits upfront so that only the allowed amount
    of APIC IDs can be registered.

  - Applies eventual late restrictions in an understandable way

  - Uses simple min_t() calculations which are trivial to follow.

  - Provides a separate function for resetting to UP mode late in the
    bringup process.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.290098853@linutronix.de



---
 arch/x86/include/asm/apic.h     |   5 +-
 arch/x86/include/asm/cpu.h      |  10 +--
 arch/x86/include/asm/topology.h |   1 +-
 arch/x86/kernel/cpu/topology.c  | 176 ++++++++++++++++++-------------
 arch/x86/kernel/setup.c         |   9 +--
 arch/x86/kernel/smpboot.c       |   6 +-
 6 files changed, 118 insertions(+), 89 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 28e9aa4..94ce0f7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -175,6 +175,9 @@ extern void topology_register_apic(u32 apic_id, u32 acpi_id, bool present);
 extern void topology_register_boot_apic(u32 apic_id);
 extern int topology_hotplug_apic(u32 apic_id, u32 acpi_id);
 extern void topology_hotunplug_apic(unsigned int cpu);
+extern void topology_apply_cmdline_limits_early(void);
+extern void topology_init_possible_cpus(void);
+extern void topology_reset_possible_cpus_up(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -190,6 +193,8 @@ static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
 static inline bool apic_needs_pit(void) { return true; }
+static inline void topology_apply_cmdline_limits_early(void) { }
+static inline void topology_init_possible_cpus(void) { }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index f8f9a9b..aa30fd8 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -9,18 +9,10 @@
 #include <linux/percpu.h>
 #include <asm/ibt.h>
 
-#ifdef CONFIG_SMP
-
-extern void prefill_possible_map(void);
-
-#else /* CONFIG_SMP */
-
-static inline void prefill_possible_map(void) {}
-
+#ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
 #define cpu_acpi_id(cpu)			0
 #define safe_smp_processor_id()			0
-
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cb6bafd..3e11a5a 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -191,6 +191,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
 }
+
 #else /* CONFIG_SMP */
 #define topology_max_packages()			(1)
 static inline int
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 80625f4..fc47f52 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -5,6 +5,7 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 
@@ -85,73 +86,6 @@ early_initcall(smp_init_primary_thread_mask);
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-static int __initdata setup_possible_cpus = -1;
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
-	unsigned int num_processors = topo_info.nr_assigned_cpus;
-	unsigned int disabled_cpus = topo_info.nr_disabled_cpus;
-	int i, possible;
-
-	i = setup_max_cpus ?: 1;
-	if (setup_possible_cpus == -1) {
-		possible = topo_info.nr_assigned_cpus;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible += num_processors;
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
 static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
@@ -293,12 +227,114 @@ void topology_hotunplug_apic(unsigned int cpu)
 }
 #endif
 
-static int __init _setup_possible_cpus(char *str)
+#ifdef CONFIG_SMP
+static unsigned int max_possible_cpus __initdata = NR_CPUS;
+
+/**
+ * topology_apply_cmdline_limits_early - Apply topology command line limits early
+ *
+ * Ensure that command line limits are in effect before firmware parsing
+ * takes place.
+ */
+void __init topology_apply_cmdline_limits_early(void)
 {
-	get_option(&str, &setup_possible_cpus);
+	unsigned int possible = nr_cpu_ids;
+
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+		possible = 1;
+
+	/* 'possible_cpus=N' */
+	possible = min_t(unsigned int, max_possible_cpus, possible);
+
+	if (possible < nr_cpu_ids) {
+		pr_info("Limiting to %u possible CPUs\n", possible);
+		set_nr_cpu_ids(possible);
+	}
+}
+
+static __init bool restrict_to_up(void)
+{
+	if (!smp_found_config || ioapic_is_disabled)
+		return true;
+	/*
+	 * XEN PV is special as it does not advertise the local APIC
+	 * properly, but provides a fake topology for it so that the
+	 * infrastructure works. So don't apply the restrictions vs. APIC
+	 * here.
+	 */
+	if (xen_pv_domain())
+		return false;
+
+	return apic_is_disabled;
+}
+
+void __init topology_init_possible_cpus(void)
+{
+	unsigned int assigned = topo_info.nr_assigned_cpus;
+	unsigned int disabled = topo_info.nr_disabled_cpus;
+	unsigned int total = assigned + disabled;
+	unsigned int cpu, allowed = 1;
+
+	if (!restrict_to_up()) {
+		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
+			disabled += assigned - nr_cpu_ids;
+			assigned = nr_cpu_ids;
+		}
+		allowed = min_t(unsigned int, total, nr_cpu_ids);
+	}
+
+	if (total > allowed)
+		pr_warn("%u possible CPUs exceed the limit of %u\n", total, allowed);
+
+	assigned = min_t(unsigned int, allowed, assigned);
+	disabled = allowed - assigned;
+
+	topo_info.nr_assigned_cpus = assigned;
+	topo_info.nr_disabled_cpus = disabled;
+
+	total_cpus = allowed;
+	set_nr_cpu_ids(allowed);
+
+	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
+	if (topo_info.nr_rejected_cpus)
+		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
+
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
+
+	for (cpu = 0; cpu < allowed; cpu++) {
+		u32 apicid = cpuid_to_apicid[cpu];
+
+		set_cpu_possible(cpu, true);
+
+		if (apicid == BAD_APICID)
+			continue;
+
+		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
+	}
+}
+
+/*
+ * Late SMP disable after sizing CPU masks when APIC/IOAPIC setup failed.
+ */
+void __init topology_reset_possible_cpus_up(void)
+{
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
+
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	if (topo_info.boot_cpu_apic_id != BAD_APICID)
+		set_bit(topo_info.boot_cpu_apic_id, phys_cpu_present_map);
+}
+
+static int __init setup_possible_cpus(char *str)
+{
+	get_option(&str, &max_possible_cpus);
 	return 0;
 }
-early_param("possible_cpus", _setup_possible_cpus);
+early_param("possible_cpus", setup_possible_cpus);
+#endif
 
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b1e52ac..4e320d4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1131,6 +1131,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_quirks();
 
+	topology_apply_cmdline_limits_early();
+
 	/*
 	 * Parse SMP configuration. Try ACPI first and then the platform
 	 * specific parser.
@@ -1138,13 +1140,10 @@ void __init setup_arch(char **cmdline_p)
 	acpi_boot_init();
 	x86_init.mpparse.parse_smp_cfg();
 
-	/*
-	 * Systems w/o ACPI and mptables might not have it mapped the local
-	 * APIC yet, but prefill_possible_map() might need to access it.
-	 */
+	/* Last opportunity to detect and map the local APIC */
 	init_apic_mappings();
 
-	prefill_possible_map();
+	topology_init_possible_cpus();
 
 	init_cpu_to_node();
 	init_gi_nodes();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d850fac..7f85f17 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1147,11 +1147,7 @@ static __init void disable_smp(void)
 	pr_info("SMP disabled\n");
 
 	disable_ioapic_support();
-
-	init_cpu_present(cpumask_of(0));
-	init_cpu_possible(cpumask_of(0));
-
-	reset_phys_cpu_present_map(smp_found_config ? boot_cpu_physical_apicid : 0);
+	topology_reset_possible_cpus_up();
 
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));

