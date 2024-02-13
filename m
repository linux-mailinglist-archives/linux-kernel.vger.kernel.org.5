Return-Path: <linux-kernel+bounces-64298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86354853CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB11F24B62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900D6629F8;
	Tue, 13 Feb 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQx8cm/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsiW4iL/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98080040
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858355; cv=none; b=qtQkK0A3q7iQdUledmOKoP7cR0+OB/ZDnuxuhh1TyGO+4+ClO/eqmsV7DU93eibfbZBEZecXTzcEsX49dvu88+9IppOdaCUBucJOGCphDtZso9KN/pLQ380O05iBw3vjUaSr5k3o5y78glgbgr50czMAQzP9UzcupV5EmVt53Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858355; c=relaxed/simple;
	bh=D/x2pZmXYVi1aeoQgeo6/HbqC0uU3avn6Qrbh4JB+Bc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=re2Qsao3Na5CBrdN7c9TQUNzixfzL9NHMrbuAilbecNaSKE8KZKB3NAroMQxfkhl2GhOvIragNUjwSKsrnClZF5Jc83sSSosgaMMMHHNklRoSnuIMjonS5f+k2hWs0KK49DaTz8lvB0Q1pwzChz1FM+oarjyknMe48/HK0M6WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQx8cm/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsiW4iL/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.230433953@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=De/C8B6JlgmBVTvJK21S3TwnUST7UJwZGYAmiPz2Plg=;
	b=tQx8cm/gxd7WIJbLhuAnBwQ/NwKlo+twl+nVOcR8cAk8fSK8NPlLaUWQbRyAm4xrrausC8
	RFuxowPH8WKHCZQ0ivRwcMScM+mi+Jt7v9sb5dr7yxOeHbhRr/So8taz6TIkuJimttUcAW
	EP9z26kaFK54F7QMlC6Rs/URIAk+EY0ly4D9bz6YEVnvB1XKJOsVQO6ZgQd7O2diwVAXwn
	ufjOhPPV+nH1flP8tLPCsE14QAlIRycw0KpdU2b3viB0y5Zokfy9352tdwzwPSpmPC2T8R
	68BK6DAj3sl6HvliUnEmbdXDdcNccfKvRo7prSC1mMv3s08JZ9ZFLukHM5YIRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=De/C8B6JlgmBVTvJK21S3TwnUST7UJwZGYAmiPz2Plg=;
	b=tsiW4iL/9VrO7T84ROI94S4EljMFr1gET9WCFtWkLp01zFGHoHDsqs6jkM8izUnf1HVLvt
	9Yubkdq0VWUq42Dw==
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
Subject: [patch 13/30] x86/cpu/topology: Sanitize the APIC admission logic
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:52 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Move the actually required content of generic_processor_id() into the call
sites and use common helper functions for them. This separates the early
boot registration and the ACPI hotplug mechanism completely which allows
further cleanups and improvements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3:
    Check for disabled APIC early and exclude the boot APIC ID from
    the CPUNR exhaustion check. - Sohil, Michael

    Rename topo_assign_cpunr() to topo_get_cpunr() as the assignment
    happens elsewhere - Arjan

---
 arch/x86/kernel/cpu/topology.c |  159 +++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 82 deletions(-)
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
+static int topo_get_cpunr(u32 apic_id)
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
@@ -234,17 +201,40 @@ void __init topology_register_apic(u32 a
 
 	if (apic_id >= MAX_LOCAL_APIC) {
 		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	if (!present) {
-		topo_info.nr_disabled_cpus++;
+	if (disabled_cpu_apicid == apic_id) {
+		pr_info("Disabling CPU as requested via 'disable_cpu_apicid=0x%x'.\n", apic_id);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	cpu = generic_processor_info(apic_id);
-	if (cpu >= 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+	/* CPU numbers exhausted? */
+	if (apic_id != topo_info.boot_cpu_apic_id && topo_info.nr_assigned_cpus >= nr_cpu_ids) {
+		pr_warn_once("CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
+		topo_info.nr_rejected_cpus++;
+		return;
+	}
+
+	if (present) {
+		set_bit(apic_id, phys_cpu_present_map);
+
+		/*
+		 * Double registration is valid in case of the boot CPU
+		 * APIC because that is registered before the enumeration
+		 * of the APICs via firmware parsers or VM guest
+		 * mechanisms.
+		 */
+		if (apic_id == topo_info.boot_cpu_apic_id)
+			cpu = 0;
+		else
+			cpu = topo_get_cpunr(apic_id);
+		topo_set_cpuids(cpu, apic_id, acpi_id);
+	} else {
+		topo_info.nr_disabled_cpus++;
+	}
 }
 
 /**
@@ -255,8 +245,10 @@ void __init topology_register_apic(u32 a
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
@@ -274,10 +266,13 @@ int topology_hotplug_apic(u32 apic_id, u
 
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
 


