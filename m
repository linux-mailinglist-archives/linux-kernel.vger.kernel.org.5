Return-Path: <linux-kernel+bounces-35344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E9838F94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B058CB29040
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7E627EF;
	Tue, 23 Jan 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySL+U1nZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/kXnXlc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F46168B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015456; cv=none; b=lg89C2zvLK69n31ioTNJ7InojezWT5GpInNiBjYxdf1q9vcyHxp7LCt1BBy4c27YfA/wJ+rat4I4ZPb4R1M+agqXZTZZzzn5ibr5ieog6zRRNobrpFG8SmINrsYoMdo8ec6hWsD0PFRjiHdV4Nv7i49Ikz/7lczLCGm8Fn6w/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015456; c=relaxed/simple;
	bh=A6DRTtYolM0nxyqcZ/KT0BAawXUk3qAODO455OFbZPI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tQk4S/Z9MC6FPqQfK/Ce2laGrnVaHtEX6pgjC/9lQtlF5ooeZGrEZ03jmwEdU946MrsttW5+9M5YXYhp+unNCD/e2Sm/KqiVmpf4aS/p4l/BB601N9DyeNwTeDhG++yZPP/VxJ0r1bm33vLMcUHqG3IfTu/2uhbxQ1ZWpd+FgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySL+U1nZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/kXnXlc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.663415387@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VhgEhXRzZ2arG5ALV1ivGA8kAeYK0sQE/cl9vrjuqJo=;
	b=ySL+U1nZ3n4UeNsfDzhEtMIaoDIdADkBisarGWQxnluqfB/jLJN2TpOFAILJ6MtI+1EmBA
	MVqtFmJLLiedbo2Nhtku+tNEqMHO0x9siZm+eYM2Lggp+Ssg+wbmMaBwhMVCItoqKDAGVA
	sLVNezQxFy44k2hQ9Xq34P5DY1TNDRhnodotUT5wIKSdwOQfM405FRBO3GA9DcXOdvulxx
	wZS5O5oHjXjDhJYoIw4giYGkN/tIXmAMBobhlmGWZB6ViOdYdF0zUkylYKIWMRdG9dZLT3
	bZ0tbvWYCFSUajuL4wEI3KnNLI4ylw3+VsYAhwEp9S9Dh8Tq7v6tZW7MM8J7Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VhgEhXRzZ2arG5ALV1ivGA8kAeYK0sQE/cl9vrjuqJo=;
	b=m/kXnXlctEnP1vZKB/ro8rRsdv6Y8oB8PWZXg7KgBzNDeGIYgTiVEasVZ0cbvkL0zZe26Z
	a5tHqp5cOGz2yADw==
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
Subject: [patch v2 02/30] x86/cpu/topology: Provide separate APIC registration
 functions
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:52 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

generic_processor_info() aside of being a complete misnomer is used for
both early boot registration and ACPI CPU hotplug.

While it's arguable that this can share some code, it results in code which
is hard to understand and kept around post init for no real reason.

Also the call sites do lots of manual fiddling in topology related
variables instead of having proper interfaces for the purpose which handle
the topology internals correctly.

Provide topology_register_apic(), topology_hotplug_apic() and
topology_hotunplug_apic() which have the extra magic of the call sites
incorporated and for now are wrappers around generic_processor_info().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h    |    3 +
 arch/x86/kernel/cpu/topology.c |  113 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 18 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -171,7 +171,10 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern void topology_register_apic(u32 apic_id, u32 acpi_id, bool present);
 extern void topology_register_boot_apic(u32 apic_id);
+extern int topology_hotplug_apic(u32 apic_id, u32 acpi_id);
+extern void topology_hotunplug_apic(unsigned int cpu);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -84,32 +84,38 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(int apicid)
+static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
 
-	/*
-	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
-	 * check if the kernel has allocated a cpuid for it.
-	 */
+	/* CPU# to APICID mapping is persistent once it is established */
 	for (i = 0; i < nr_logical_cpuids; i++) {
-		if (cpuid_to_apicid[i] == apicid)
+		if (cpuid_to_apicid[i] == apic_id)
 			return i;
 	}
+	return -ENODEV;
+}
+
+/*
+ * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
+ * and cpuid_to_apicid[] synchronized.
+ */
+static int allocate_logical_cpuid(u32 apic_id)
+{
+	int cpu = topo_lookup_cpuid(apic_id);
+
+	if (cpu >= 0)
+		return cpu;
 
 	/* Allocate a new cpuid. */
 	if (nr_logical_cpuids >= nr_cpu_ids) {
 		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
 			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apicid);
+			     nr_cpu_ids, nr_logical_cpuids, apic_id);
 		return -EINVAL;
 	}
 
-	cpuid_to_apicid[nr_logical_cpuids] = apicid;
+	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
 	return nr_logical_cpuids++;
 }
 
@@ -127,12 +133,6 @@ static void cpu_update_apic(int cpu, u32
 		cpu_mark_primary_thread(cpu, apicid);
 }
 
-void __init topology_register_boot_apic(u32 apic_id)
-{
-	cpuid_to_apicid[0] = apic_id;
-	cpu_update_apic(0, apic_id);
-}
-
 int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
@@ -174,6 +174,83 @@ int generic_processor_info(int apicid)
 	return cpu;
 }
 
+/**
+ * topology_register_apic - Register an APIC in early topology maps
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ * @present:	True if the corresponding CPU is present
+ */
+void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
+{
+	int cpu;
+
+	if (apic_id >= MAX_LOCAL_APIC) {
+		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
+		return;
+	}
+
+	if (!present) {
+		disabled_cpus++;
+		return;
+	}
+
+	cpu = generic_processor_info(apic_id);
+	if (cpu >= 0)
+		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+}
+
+/**
+ * topology_register_boot_apic - Register the boot CPU APIC
+ * @apic_id:	The APIC ID to set up
+ *
+ * Separate so CPU #0 can be assigned
+ */
+void __init topology_register_boot_apic(u32 apic_id)
+{
+	cpuid_to_apicid[0] = apic_id;
+	cpu_update_apic(0, apic_id);
+}
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/**
+ * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ */
+int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
+{
+	int cpu;
+
+	if (apic_id >= MAX_LOCAL_APIC)
+		return -EINVAL;
+
+	cpu = topo_lookup_cpuid(apic_id);
+	if (cpu < 0) {
+		cpu = generic_processor_info(apic_id);
+		if (cpu >= 0)
+			per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+	}
+	return cpu;
+}
+
+/**
+ * topology_hotunplug_apic - Remove a physical hotplugged APIC after boot
+ * @cpu:	The CPU number for which the APIC ID is removed
+ */
+void topology_hotunplug_apic(unsigned int cpu)
+{
+	u32 apic_id = cpuid_to_apicid[cpu];
+
+	if (apic_id == BAD_APICID)
+		return;
+
+	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
+	clear_bit(apic_id, phys_cpu_present_map);
+	set_cpu_present(cpu, false);
+	num_processors--;
+}
+#endif
+
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
 	if (!arg || !get_option(&arg, &disabled_cpu_apicid))


