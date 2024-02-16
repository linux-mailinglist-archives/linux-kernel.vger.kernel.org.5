Return-Path: <linux-kernel+bounces-68818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D040B8580AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0103C1C21B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90C1420D0;
	Fri, 16 Feb 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvoUwiS1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FdXgtut7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865591386B1;
	Fri, 16 Feb 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096633; cv=none; b=eL1VkDzBj5mPs1DZqEItRhwe8o5qPd2mnQsjiSr2OX7DQPdTWWtmAM96lYWMIiq61GDA7ee5QUd4GRVRdj/rAxuQUaYOZiAwVWAYsRsGQJJNjQaEjLmtrWwEjcwMSEiUDRuIHDEKqb1r7DmAdZ541xmkpEHsok9jlE+5MNVAEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096633; c=relaxed/simple;
	bh=S76px3p4SlTuSXKi3pBrh151x/xo6dsu93RZPuL3CUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tSgQN29PGvCm2XzyEp2BoxVTm5auPjrR0dV4n962KerlDrUcgX/OJYauxVwo7s/XNfWqxU4D/jul40GimVyebUTkX4FFfDdvyaeysSVXAXQZRZSD6yTeo0OptqINDvvO4rrHSvZOQNozC3dBENi+oJ3/Q9v0+Sxygprh3UbUF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvoUwiS1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FdXgtut7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHExEcJ0c6MGbApLz/GjwedrSBDXbAEvCorQDf3at0I=;
	b=tvoUwiS1w6VWbWgUpCqbJhvm9WWRB2VKoZ4L/gpdcrqsL7yONJq6L8gT1NBt4flY6cjDr+
	S3fjlPlv4AvPvEutvJ9bxHkJjPHH9/lNxrcVcSHxk+BRKXLKT46tCZU3lLiC/KXnUv82x5
	3Z3wvUDc9cyh/UUcX/bV+WVLX0l+qnj+e5WngAOZl5WKdeZWV/BB/IEEafA4iXGzcnsLxj
	cgHkb3VCjNR6HcdYk8IzSm2V8ysjC25aD1wXemV9fS6bzKA0rYJMglpU6RMoVKv3FXxoZn
	7UOfIO6seLjZeWkOHa/AQjS+3fDWBblFALnjS+HpGYH8Ix0jtLPyIEHcosugtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHExEcJ0c6MGbApLz/GjwedrSBDXbAEvCorQDf3at0I=;
	b=FdXgtut7pDlf3TYA1UUgd+en/6ogHD8fJo8DyGBtUADsJW9e94DocRwUt75RMuYqbKwWyF
	jPcM+GyuoLhdTYDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Provide separate APIC registration
 functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.605007456@linutronix.de>
References: <20240213210251.605007456@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662916.398.16668894521706484040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4176b541c2c68bf79d0a05f316713ed8f0c9cdb4
Gitweb:        https://git.kernel.org/tip/4176b541c2c68bf79d0a05f316713ed8f0c9cdb4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/cpu/topology: Provide separate APIC registration functions

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.605007456@linutronix.de



---
 arch/x86/include/asm/apic.h    |   3 +-
 arch/x86/kernel/cpu/topology.c | 113 ++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 11938d5..28e9aa4 100644
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
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index b99cd19..3dd7e6c 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -84,32 +84,38 @@ early_initcall(smp_init_primary_thread_mask);
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
 
@@ -127,12 +133,6 @@ static void cpu_update_apic(int cpu, u32 apicid)
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

