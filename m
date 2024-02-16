Return-Path: <linux-kernel+bounces-68807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF511858096
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E33D1F22100
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAD134CFE;
	Fri, 16 Feb 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0jFZ03R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VrkG+rdn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C523133411;
	Fri, 16 Feb 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096623; cv=none; b=liKsUAFAzTtJjp0pyRhGo5AXpqLNyDrJFqUr01A5/anp2JZlLrMV3JYNXcHgLTrLzscIgj4EOH6LP7hPrqxNQ1DxPMUKDjmbIyMR8/ksVzAiTebeUZ9LorIjyqD8cuGIZaWaaKgVWRc2Spck4PmOfYrL1Vs3+7ktXCsBXEukOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096623; c=relaxed/simple;
	bh=kIkN0lGzwjzjkHGuB6DvcPTPwVJMTcWgxsQc/VxRAhs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AkrHqo8MmO4Fy5G9bna4A4dWOfebsMQ++zIk/RyaSJAbZ5TJu66106yAWYJaS+j4GAc4Kzt0iMb9V7EDfwFwH5qOdTPrCXcnHrgqbpFtxhmMsImf1WAd2bo4sr3qKjmbjvzJ1F6GQloWNb0pKS3DhRNbfcvYd+cIj6k/ENNJrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0jFZ03R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VrkG+rdn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXzHFg+vypqJy5OLbhKArEUycMyqBto0RysgpIql1Xs=;
	b=x0jFZ03RSZT4Yz5TV8GbzJmwOYagUQrVzNaFVBbheRVUgN7IrBdOrCKJIwZRHIRTV61bSG
	4CDSE0afxhr4lUjZN2oqLwxDpABb1Wsc/2edym5yDZvAO1gm195YTfC/Ta0jw5Yu8kssKj
	IX62JeXVodPRNAcEYH971aslhTriBcz0grue//14MFw9A8jJpArYA+f47WtoJWyDv24H7i
	d0oViv+xLlTSDPJV+praMnQPXBcztsf6rR+L1HysIS0kigC87jthrGxRvvk0GzS5unfZw5
	lztT9sCdikS8lSgAEhTgEm4Y3hkBuUrZdySTCgbQP4GZsKdI7zmE/9T7XTVw/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXzHFg+vypqJy5OLbhKArEUycMyqBto0RysgpIql1Xs=;
	b=VrkG+rdnoL+7WHJmPJQY4XphF/8wjRC/adengmfhpWP/5dtQZ4U/pGwMcH6LPQPkH8A5DM
	0E+9FVE2PuGTEEAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Sanitize the APIC admission logic
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.230433953@linutronix.de>
References: <20240213210252.230433953@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661935.398.294162971927878327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     0e53e7b656cf5aa67c08eca381cec858478195a7
Gitweb:        https://git.kernel.org/tip/0e53e7b656cf5aa67c08eca381cec858478195a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu/topology: Sanitize the APIC admission logic

Move the actually required content of generic_processor_id() into the call
sites and use common helper functions for them. This separates the early
boot registration and the ACPI hotplug mechanism completely which allows
further cleanups and improvements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.230433953@linutronix.de

---
 arch/x86/kernel/cpu/topology.c | 159 +++++++++++++++-----------------
 1 file changed, 77 insertions(+), 82 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 815e3ee..80625f4 100644
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
@@ -83,78 +85,6 @@ early_initcall(smp_init_primary_thread_mask);
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
@@ -222,6 +152,43 @@ __init void prefill_possible_map(void)
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
@@ -234,17 +201,40 @@ void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
 
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
@@ -255,8 +245,10 @@ void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
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
@@ -274,10 +266,13 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 
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
 

