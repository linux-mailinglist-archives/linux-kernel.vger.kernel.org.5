Return-Path: <linux-kernel+bounces-35372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EFF838FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F38289E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17539679EA;
	Tue, 23 Jan 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42W8aOdE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKuaeNvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08067745
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015502; cv=none; b=sFLyXDaKBYmENPsS4/1InT5hF1E0lgGL1CAW7rpFOgvwwFpctWrR1GwnzEdIiiKe8GNWaJHQzqGqfcKrcI1u3j/DeVYi+0eGMtlPol0tOcrpp3pFSrnBHMp79OQJXuiHrCWxgA4FVv4cV1OUZIsfXeeHZcxvHxSiTzTZMtnh+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015502; c=relaxed/simple;
	bh=a7hyVcNtgOTV6ZyFP0GW+8CW5gYxmQj62A/C5scuKns=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=t4oz0AmiVAatRx2mnD/UkSNQfxmFGh16aowg1TvW/0BXTBiX+oTIsBvv4kNaHwAKLfFSjLhMRQ/H5XrQx/YY+4hpEJUW04jiT7lvXLgsKmpNxv53XjFjkakLv/DWqNHS5dyG7J4bWSTpmZwCw3lJ6hOitCyCNYzQ7J/32AjF8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=42W8aOdE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKuaeNvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123650.197180058@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NchMEj6plFXnohvx3VS5b0MwN9MQsuMGVmncnXh1rOQ=;
	b=42W8aOdEwEdn3K3q6XuslbgC4efbM2IOiP0Fhz3ZoXmZF5eeSMorjJ+MKzDG0lV16wFJnK
	luTuVgt1qXuhf+yaIJFa1TgrzT5fQaW4T23zpQ1hqZAHDwzFL9Oy92u7HY4wz4seAiEQcq
	GX9jbHADZdBc312C20iLXhJZT7EMDzBMMRoLUvxUKZ3dJesJ7ueDBHlhlg+tXJoTeziCUV
	Pa/8NQVIdKKFGZKyQWWpIv/ns1LxHI5B1lPH05Rt5gnyKzAYhoZZBXtoRjMMrS7axOoJ/U
	6lIcd38pbFtxkwuC48Uq5GC175ah7Kiu7a63cEtnvtyZGqnIgOqP+Qq6RmxYHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NchMEj6plFXnohvx3VS5b0MwN9MQsuMGVmncnXh1rOQ=;
	b=zKuaeNvg/k+WXNIadQ3+SuKDxFRN6mz0sowRiaks93gSgk9VHhPPlRiNWSQdEfbihloJLR
	YeisJGt7nCFRWFDQ==
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
Subject: [patch v2 29/30] x86/cpu/topology: Provide
 __num_[cores|threads]_per_package
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:37 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Expose properly accounted information and accessors so the fiddling with
other topology variables can be replaced.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/include/asm/topology.h |   12 ++++++++++++
 arch/x86/kernel/cpu/common.c    |    6 ++++++
 arch/x86/kernel/cpu/topology.c  |    8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,6 +146,8 @@ extern const struct cpumask *cpu_cluster
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
 extern unsigned int __max_threads_per_core;
+extern unsigned int __num_threads_per_package;
+extern unsigned int __num_cores_per_package;
 
 static inline unsigned int topology_max_packages(void)
 {
@@ -157,6 +159,16 @@ static inline unsigned int topology_max_
 	return __max_dies_per_package;
 }
 
+static inline unsigned int topology_num_cores_per_package(void)
+{
+	return __num_cores_per_package;
+}
+
+static inline unsigned int topology_num_threads_per_package(void)
+{
+	return __num_threads_per_package;
+}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
 #else
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -81,6 +81,12 @@ EXPORT_SYMBOL(__max_dies_per_package);
 unsigned int __max_logical_packages __ro_after_init = 1;
 EXPORT_SYMBOL(__max_logical_packages);
 
+unsigned int __num_cores_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_cores_per_package);
+
+unsigned int __num_threads_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_threads_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -386,7 +386,7 @@ void __init topology_init_possible_cpus(
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	u32 apicid;
+	u32 apicid, firstid;
 
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
@@ -422,6 +422,12 @@ void __init topology_init_possible_cpus(
 	__max_threads_per_core = 1U << (get_count_order(cntb) - get_count_order(cnta));
 	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
+	firstid = find_first_bit(apic_maps[TOPO_SMT_DOMAIN].map, MAX_LOCAL_APIC);
+	__num_cores_per_package = topology_unit_count(firstid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. cores per package:   %3u\n", __num_cores_per_package);
+	__num_threads_per_package = topology_unit_count(firstid, TOPO_SMT_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
+
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);


