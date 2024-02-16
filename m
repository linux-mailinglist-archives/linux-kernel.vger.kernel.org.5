Return-Path: <linux-kernel+bounces-68809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DB85809A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E8B283C99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F113134CE5;
	Fri, 16 Feb 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wr8PRE0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srvYKC5B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDB134CCB;
	Fri, 16 Feb 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096625; cv=none; b=iP+Md1p9FB6Q4Yuln22I80GcQCP7qCEDNAMBVwnF8eWWLYqtveVuYoKr8LI8pJ+NeaPNJ8oM9f4q7XHApWLii0mb7HJrCuG+HRVTm+yjec0zd+gow0wGFwC3dhfdmUy2Vg87sRXdXM5/x8fJksOzsy02yPoXXtmOMwF0Oao0dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096625; c=relaxed/simple;
	bh=RTx+H+vBhQMbKg6b2qhlPjHWtSlweeJGFro/wRY4EZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kmdhb9Ob0saKyxL6+YiiW1RJ3mmaZgb5sdeBOQNoxLjAxZmTIaCXBWFhi+PYLTDqHTLEYdAMQxWqKoibTP3gq1cyvALYj51wu50ABMOCl0qzMsV7Qq1Pslvj7+S1xs/h+rHLqtPmob35v4/rZJIg4GKktW8qOoBOETWv7tKkTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wr8PRE0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srvYKC5B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIkNn5y9RDjsmq+FKmQznWLW0Cv0Je6Y9XSM3DuE1Qk=;
	b=wr8PRE0V6SFHQnW2wnaeVd/+UjAKMoBpfIRzl2Rp6fJcawS5zIBth50nJ5eyFuER7Xxpn1
	ts1lNzziAuiQg0XyljYqyV5tPC2pfRCotBvVUIgsyB78uzYGNUi1ff/83iuFJtp2C68++E
	m85vh86AFnYymo/nhkE6Ngf8z4Telygzvai244YdBH1qnxyI38bQPjlyjkgIQf9bqnHqXM
	GjLYsADtPBYy4AdNOh+tPBocuOCGqFXZV7/imUAWr9tK8lgNLYCt+8BgKAnkJzN0tdjR5a
	KENQR+8ylDloAvsyfUEu63JWP+Xc8spXRcY5nPkH9Rhz7daMbLRNiZ4XhOfyuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIkNn5y9RDjsmq+FKmQznWLW0Cv0Je6Y9XSM3DuE1Qk=;
	b=srvYKC5B2mFRTX7WuBpBR9hI4nxk4tlkNMGH/f90uH9k7woSCbLfK5RERS0JfBZ6B5a+3/
	Riuwd2BhNOERm5Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Use a data structure for topology info
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.111451909@linutronix.de>
References: <20240213210252.111451909@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662109.398.3557889395932667096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     72530464ed609bcdd49a760e9d0bc3b16717ff2b
Gitweb:        https://git.kernel.org/tip/72530464ed609bcdd49a760e9d0bc3b16717ff2b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu/topology: Use a data structure for topology info

Put the processor accounting into a data structure, which will gain more
topology related information in the next steps, and sanitize the accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.111451909@linutronix.de



---
 arch/x86/kernel/cpu/topology.c | 59 ++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 8b42918..815e3ee 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,25 +23,24 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
 u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 /*
+ * Keep track of assigned, disabled and rejected CPUs. Present assigned
+ * with 1 as CPU #0 is reserved for the boot CPU.
+ */
+static struct {
+	unsigned int		nr_assigned_cpus;
+	unsigned int		nr_disabled_cpus;
+	unsigned int		nr_rejected_cpus;
+} topo_info __read_mostly = {
+	.nr_assigned_cpus	= 1,
+};
+
+/*
  * Processor to be disabled specified by kernel parameter
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
 static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
-static unsigned int num_processors;
-static unsigned int disabled_cpus;
-
-/*
- * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
- * contiguously, it equals to current allocated max logical CPU ID plus 1.
- * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
- * so the maximum of nr_logical_cpuids is nr_cpu_ids.
- *
- * NOTE: Reserve 0 for BSP.
- */
-static int nr_logical_cpuids = 1;
-
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -75,7 +74,7 @@ static int __init smp_init_primary_thread_mask(void)
 		return 0;
 	}
 
-	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;
 }
@@ -89,7 +88,7 @@ static int topo_lookup_cpuid(u32 apic_id)
 	int i;
 
 	/* CPU# to APICID mapping is persistent once it is established */
-	for (i = 0; i < nr_logical_cpuids; i++) {
+	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
 		if (cpuid_to_apicid[i] == apic_id)
 			return i;
 	}
@@ -107,22 +106,21 @@ static int allocate_logical_cpuid(u32 apic_id)
 	if (cpu >= 0)
 		return cpu;
 
-	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
-	return nr_logical_cpuids++;
+	return topo_info.nr_assigned_cpus++;
 }
 
-static void cpu_update_apic(int cpu, u32 apicid)
+static void cpu_update_apic(unsigned int cpu, u32 apic_id)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 #endif
+	cpuid_to_apicid[cpu] = apic_id;
 	set_cpu_possible(cpu, true);
-	set_bit(apicid, phys_cpu_present_map);
+	set_bit(apic_id, phys_cpu_present_map);
 	set_cpu_present(cpu, true);
-	num_processors++;
 
 	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apicid);
+		cpu_mark_primary_thread(cpu, apic_id);
 }
 
 static int generic_processor_info(int apicid)
@@ -137,18 +135,18 @@ static int generic_processor_info(int apicid)
 		return 0;
 
 	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
+		int thiscpu = topo_info.nr_assigned_cpus + topo_info.nr_disabled_cpus;
 
 		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
 			thiscpu, apicid);
 
-		disabled_cpus++;
+		topo_info.nr_rejected_cpus++;
 		return -ENODEV;
 	}
 
-	if (num_processors >= nr_cpu_ids) {
+	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
 		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
-		disabled_cpus++;
+		topo_info.nr_rejected_cpus++;
 		return -ENOSPC;
 	}
 
@@ -178,14 +176,16 @@ static int __initdata setup_possible_cpus = -1;
  */
 __init void prefill_possible_map(void)
 {
+	unsigned int num_processors = topo_info.nr_assigned_cpus;
+	unsigned int disabled_cpus = topo_info.nr_disabled_cpus;
 	int i, possible;
 
 	i = setup_max_cpus ?: 1;
 	if (setup_possible_cpus == -1) {
-		possible = num_processors;
+		possible = topo_info.nr_assigned_cpus;
 #ifdef CONFIG_HOTPLUG_CPU
 		if (setup_max_cpus)
-			possible += disabled_cpus;
+			possible += num_processors;
 #else
 		if (possible > i)
 			possible = i;
@@ -238,7 +238,7 @@ void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
 	}
 
 	if (!present) {
-		disabled_cpus++;
+		topo_info.nr_disabled_cpus++;
 		return;
 	}
 
@@ -295,7 +295,6 @@ void topology_hotunplug_apic(unsigned int cpu)
 	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	clear_bit(apic_id, phys_cpu_present_map);
 	set_cpu_present(cpu, false);
-	num_processors--;
 }
 #endif
 

