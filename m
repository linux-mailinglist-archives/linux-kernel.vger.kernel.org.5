Return-Path: <linux-kernel+bounces-35361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B88838FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A881C2129B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7898657C4;
	Tue, 23 Jan 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45hvOrlB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jcmhl8rm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB5651A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015483; cv=none; b=OROf5tfBvdRu1Z3A8XguhBu+41IhdbC+cLDlrEoMvvXxLKAAPEKSGKzkLwVmFeeWJNFhjPZf0JRSBfbOL2AhcxKkC0h8UdsoTZVSrD5Px0gB22PqOG/0gdZJFnLfDoV+dQBm21ysuWnueKmzGMsA2xyd4IX1b1itx/LSC5L84F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015483; c=relaxed/simple;
	bh=LL+PI2JUCSitbXIgL7C3Pzx3ABaDIfTVeVFPuGTNxPY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sjMUJzjB/QLJOHmPd7tJs4hFos4kW8thE/wnl7BXmNyk/T6bzgOTXsFoaTYbSI+jqqNDHkKEjZBay1g5kCZkJfLcR3DeO3qa0v/9cmuIG5xDKXPA+ftV8r4w2usQBX2Qr1F0pzGaTHBtFJfe00gHCbQIz5i6jkQU4ulMf2bSuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45hvOrlB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jcmhl8rm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.569833701@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1VEpaCzatSS1m78r8ucv1MaTrOUKxCMYoRkuUIJ9K54=;
	b=45hvOrlBFQnUc8jJdQos5iNICeC7pAp8FQdhqAzi9dhFJp7pl3RdXkzhqLPt4SXY5wYt6h
	EBH1aINGE9ZRYJWQ6RIOUSps4aioJr6tWVzpcpJ16+Ir3nYn+5qLaSKGdMCg+6Tbl21m6I
	L7JARKiMH/rcwESBx/cSjIFpq3D5D0OnkhtFhwidKvYbKAndVJBnaOrJOUAeJsTdNNqQvM
	b31YSfSwkeQ6bv/shMjGl8EhQe8btXI/+2cE7UGj48GsT14u1hmwBw2ZsML7zGznSvttaE
	9RDhZ5EfIUtTKKF2lSO+T2Y/TS6wSSsJy+NIEzceIA5pquF8YtPdQcv1DwYX0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1VEpaCzatSS1m78r8ucv1MaTrOUKxCMYoRkuUIJ9K54=;
	b=jcmhl8rmsEm6bqHidSV68CqF3PpvCJNe5yZN55wjy1Q09ke+VTVO9hxYzlsNxpyeVGU3aT
	F+TC2AtrlM33NcBw==
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
Subject: [patch v2 18/30] x86/cpu/topology: Assign hotpluggable CPUIDs during
 init
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:19 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no point in assigning the CPU numbers during ACPI physical
hotplug. The number of possible hotplug CPUs is known when the possible map
is initialized, so the CPU numbers can be associated to the registered
non-present APIC IDs right there.

This allows to put more code into the __init section and makes the related
data __ro_after_init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/topology.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -45,7 +45,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_a
 DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
 
 /* Used for CPU number allocation and parallel CPU bringup */
-u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
+u32 cpuid_to_apicid[] __ro_after_init = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 /* Bitmaps to mark registered APICs at each topology domain */
 static struct { DECLARE_BITMAP(map, MAX_LOCAL_APIC); } apic_maps[TOPO_MAX_DOMAIN] __ro_after_init;
@@ -60,7 +60,7 @@ static struct {
 	unsigned int		nr_rejected_cpus;
 	u32			boot_cpu_apic_id;
 	u32			real_bsp_apic_id;
-} topo_info __read_mostly = {
+} topo_info __ro_after_init = {
 	.nr_assigned_cpus	= 1,
 	.boot_cpu_apic_id	= BAD_APICID,
 	.real_bsp_apic_id	= BAD_APICID,
@@ -133,7 +133,7 @@ static int topo_lookup_cpuid(u32 apic_id
 	return -ENODEV;
 }
 
-static int topo_assign_cpunr(u32 apic_id)
+static __init int topo_assign_cpunr(u32 apic_id)
 {
 	int cpu = topo_lookup_cpuid(apic_id);
 
@@ -149,8 +149,6 @@ static void topo_set_cpuids(unsigned int
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	cpuid_to_apicid[cpu] = apic_id;
-
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 
@@ -207,6 +205,8 @@ static __init void topo_register_apic(u3
 			cpu = 0;
 		else
 			cpu = topo_assign_cpunr(apic_id);
+
+		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
 		topo_info.nr_disabled_cpus++;
@@ -276,12 +276,9 @@ int topology_hotplug_apic(u32 apic_id, u
 		return -ENODEV;
 
 	cpu = topo_lookup_cpuid(apic_id);
-	if (cpu < 0) {
-		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)
-			return -ENOSPC;
+	if (cpu < 0)
+		return -ENOSPC;
 
-		cpu = topo_assign_cpunr(apic_id);
-	}
 	set_bit(apic_id, phys_cpu_present_map);
 	topo_set_cpuids(cpu, apic_id, acpi_id);
 	return cpu;
@@ -352,6 +349,7 @@ void __init topology_init_possible_cpus(
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int total = assigned + disabled;
 	unsigned int cpu, allowed = 1;
+	u32 apicid;
 
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
@@ -380,8 +378,17 @@ void __init topology_init_possible_cpus(
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
 
+	/* Assign CPU numbers to non-present CPUs */
+	for (apicid = 0; disabled; disabled--, apicid++) {
+		apicid = find_next_andnot_bit(apic_maps[TOPO_SMT_DOMAIN].map, phys_cpu_present_map,
+					      MAX_LOCAL_APIC, apicid);
+		if (apicid >= MAX_LOCAL_APIC)
+			break;
+		cpuid_to_apicid[topo_info.nr_assigned_cpus++] = apicid;
+	}
+
 	for (cpu = 0; cpu < allowed; cpu++) {
-		u32 apicid = cpuid_to_apicid[cpu];
+		apicid = cpuid_to_apicid[cpu];
 
 		set_cpu_possible(cpu, true);
 


