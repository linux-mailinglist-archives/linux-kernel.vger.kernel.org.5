Return-Path: <linux-kernel+bounces-35354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59080838FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C225CB22283
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BF63519;
	Tue, 23 Jan 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGCvFzQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7yl43YI7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863B6341D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015471; cv=none; b=TB16r72hVdmTicb7TLe7zPycZcLalrqWAeYnRAFL3uKoHxeacaOmvBZ5Kt6XT1VFMs69LgWL0jZkogYT8mcSAuDv/e2Kqd/mewjHpQOB+Dy9b7IxzMEZsZWAlLs/1OW02lIMW06dFrrUbLR1m2zaQ9ybN/e+8yDTiSa8MTeg3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015471; c=relaxed/simple;
	bh=FUTIECry+bQ8RFAh9yFkdIi5+DkzHs3f3p6NIjEa5cs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DLqZRyQ8i2SQRb0NVk2FG0IalVL0pw/mO4BCz8ENf0MDuBvKQEJQcdIYCRTnIC8JG9AB+vGr3DmqiK1fg6x2T5X+K/r3KTosNfT54FEUCBusY+Vfa3I/AwCnk5HaDxT5bEwz8ADVV51sK7Actds1tyKvp8s4yGLEJtuXYJ8x3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGCvFzQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7yl43YI7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.174566214@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/3oc2ZLZMtT1GGSM+F50BJRwamFMmJoEtBLGA//oVEY=;
	b=LGCvFzQdipix4lYAMkP64YXKblLZ0oE1+UmXNAMOr4NQjyA1/Ef5jqXmba3WkYuCOlXYB1
	dUZ7lqIRF0Gua20ldNVYUo2Nm9b4bBipmWba3Y3ZVzNqmX9QvuZaA9BkxOama3ADlh7h2O
	fEFQZdHKGRw+rmYTlEXJVyPEj8P72VEmAnT/Cv7nIztGbQaGJTIb6xHBA64I9FJr8w+Kl7
	n/MpnIacIX5b3u95wws6JWH7Ee8y+AmO7vFFjXNe0yBKSI1AiMI1Bkq4kfA+/TDfl+7LBe
	YKpn5xsXAaPLSPlPamvfZPj9VARaCNALKN9/PsHSGr6wA8sG5Vbs21knCgL9cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/3oc2ZLZMtT1GGSM+F50BJRwamFMmJoEtBLGA//oVEY=;
	b=7yl43YI79rGp6vymn3HGbqztV+AblmSSKw4IFL/BdnI0SgIWs46yXnSIZ5R+Z17GJIXbko
	q850XISawTCaB1Bw==
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
Subject: [patch v2 11/30] x86/cpu/topology: Use a data structure for topology
 info
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:07 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Put the processor accounting into a data structure, which will gain more
topology related information in the next steps, and sanitize the accounting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/topology.c |   59 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 30 deletions(-)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,25 +23,24 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX
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
@@ -75,7 +74,7 @@ static int __init smp_init_primary_threa
 		return 0;
 	}
 
-	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;
 }
@@ -89,7 +88,7 @@ static int topo_lookup_cpuid(u32 apic_id
 	int i;
 
 	/* CPU# to APICID mapping is persistent once it is established */
-	for (i = 0; i < nr_logical_cpuids; i++) {
+	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
 		if (cpuid_to_apicid[i] == apic_id)
 			return i;
 	}
@@ -107,22 +106,21 @@ static int allocate_logical_cpuid(u32 ap
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
@@ -137,18 +135,18 @@ static int generic_processor_info(int ap
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
 
@@ -178,14 +176,16 @@ static int __initdata setup_possible_cpu
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
@@ -238,7 +238,7 @@ void __init topology_register_apic(u32 a
 	}
 
 	if (!present) {
-		disabled_cpus++;
+		topo_info.nr_disabled_cpus++;
 		return;
 	}
 
@@ -295,7 +295,6 @@ void topology_hotunplug_apic(unsigned in
 	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	clear_bit(apic_id, phys_cpu_present_map);
 	set_cpu_present(cpu, false);
-	num_processors--;
 }
 #endif
 


