Return-Path: <linux-kernel+bounces-68802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82785808C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ED61C2099A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AFA12F5AE;
	Fri, 16 Feb 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xbi5Jlzl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUX+1I5K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5913174F;
	Fri, 16 Feb 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096619; cv=none; b=uMD6TXm/0+ZuLqLWj7rR9BthVbx5Dm79J236p7ArlzuTbPUPbwhJL64trFER+nVT5nYYOF59kS2OTZRmErXvByuh/jWQjzWKSChNg9SrY1SA+TvyNKn/GxKU+ivTty7eak2yOkVNRwNows+LxSH3CpNqobWHu8xzGB8Grb0MbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096619; c=relaxed/simple;
	bh=LETyoloJedXx1b+sAONj+NOFStj6ukHJ24/6x/0PMdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TNqjEKmDt9WR0AqRcO4ijc3Y5wu3u8eTtz64EVoKbksV3weTv99AqPtkpNA0RkTVkG6Jfm+crRyvSoVX9z8AO6RNOgKONQt6kWcZdx0BuV99sY1f7Z/uRTdsY1nNX2cI69hXmaObGfvfN4/Us6N8VuTRP7/mz4GXwCaCM8sOI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xbi5Jlzl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUX+1I5K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSx/qm1J/TDTo6Nd+gjCLrRWkqvxLS281TW7IK694zA=;
	b=Xbi5JlzlpSVf/jyC/NNoVb4DwfuAtm5tWcD7eoWTSTN2R3j4Fan4ADKWSZiwdKyrdI/51k
	sznkBtBGo4mrahC3D9x0pRfde4FnQfnCc32etMeg03VHzGDr88h0nVoCMe1DRrVAURH8vP
	q3xL6j0zvqEgEoCLnkeyi2W05AHdcU9cCwb+aM+sYX/5S9QlSJDGIc9DrUKST2bWubEZFY
	GTxmqmvGnSDW/R8dJE5IlwuH/tOZmn5EiBsazv5ZPdGpYelfRH2sI7xQiudHFwEeT0cqd5
	wmISuiuqHS6xyKEHMsPFUPBOQzawihHHVlSmQCFJHX2kOHCgIKSGZgywvYdJxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSx/qm1J/TDTo6Nd+gjCLrRWkqvxLS281TW7IK694zA=;
	b=EUX+1I5KJJGMYBq9afrRWPtRCN5JEFRto6HHVU3EiSmrhC10LG3hpytzBXodlrtZUQARL4
	e7me/m6a3AIR6GBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Assign hotpluggable CPUIDs during init
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.517339971@linutronix.de>
References: <20240213210252.517339971@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661500.398.10544882873165794828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ea2dd8a5d4361ef0b000196043fa407f05b16f1d
Gitweb:        https://git.kernel.org/tip/ea2dd8a5d4361ef0b000196043fa407f05b16f1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Assign hotpluggable CPUIDs during init

There is no point in assigning the CPU numbers during ACPI physical
hotplug. The number of possible hotplug CPUs is known when the possible map
is initialized, so the CPU numbers can be associated to the registered
non-present APIC IDs right there.

This allows to put more code into the __init section and makes the related
data __ro_after_init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.517339971@linutronix.de



---
 arch/x86/kernel/cpu/topology.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index a6d045b..07124da 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -45,7 +45,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
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
@@ -133,7 +133,7 @@ static int topo_lookup_cpuid(u32 apic_id)
 	return -ENODEV;
 }
 
-static int topo_get_cpunr(u32 apic_id)
+static __init int topo_get_cpunr(u32 apic_id)
 {
 	int cpu = topo_lookup_cpuid(apic_id);
 
@@ -149,8 +149,6 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	cpuid_to_apicid[cpu] = apic_id;
-
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 
@@ -206,6 +204,8 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 			cpu = 0;
 		else
 			cpu = topo_get_cpunr(apic_id);
+
+		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
 		topo_info.nr_disabled_cpus++;
@@ -277,12 +277,9 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
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
@@ -353,6 +350,7 @@ void __init topology_init_possible_cpus(void)
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int total = assigned + disabled;
 	unsigned int cpu, allowed = 1;
+	u32 apicid;
 
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
@@ -381,8 +379,17 @@ void __init topology_init_possible_cpus(void)
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
 

