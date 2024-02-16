Return-Path: <linux-kernel+bounces-68804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9185808F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA30AB22E61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF49133426;
	Fri, 16 Feb 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAKW3MTw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c54mnmiH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D6132C17;
	Fri, 16 Feb 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096620; cv=none; b=C7t8M2WjY9qiiPzH5VtFu+utyT+7yLv6UYO2rE7OUSC/gBcN6uainJzNToKwymsz9iwpa6lgHRQlHvvDpWbpUD1q+dtASAss1cdah2JQd5iS1UBD5RN3krta/aKj2fnKppuCL7Ng7NxMFlmJ4a8EI2jYxdzJxJXgQ1E5wzumqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096620; c=relaxed/simple;
	bh=rrc95VUl9gVTI8r7qaQ+EUqObQC/soxbjDEsU7e2Y0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QNznkhVkhyoocx8hq5kDnqPGo1TLvlyv27ncSOGGVWXIyufas8n9b7KesMRnbSlG21u3qW5Y2jb6drSP+5t5P80WqDuT5KCz+FHsLbOtpL29OuQgPbTAuE8VumKHCNt6GfqlWJCaiStaVBGRK291Qk3eOQcVmN+TFUBwsDSdS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAKW3MTw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c54mnmiH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50l9icOH/NAqXqEeRWrba18Ol7cGxCxpc530wur+gIc=;
	b=uAKW3MTwHylznqsQTDwedI9YtK6M+EIS/lMFpzaeHU80EVhYMw7ZcC2E9mN6ksck8yyZdw
	/eACJZ2P/lZK902C2euYEoIQk/Nz6Oo109yrGnszB9jVju7kSeYa6RiFHfZeVOcq5JS3+g
	pbpUIe6We0BFk4J435m2xAGDWwgSd55nFU2oISi1Ip9iO4BHSL+8yOzSjTkA2zpMFeVKN2
	SoMu92/LSnC2ypLXkv4XgBAiv9KPY0IN4v3D/KOTVpVDoGxh7ysGEHpbFhRfSnHUD8cBE+
	OtNfg5IkyrvPg5Sq2we483iqdUzntLBptkMb3DRuswdlY8sIC/KQwhTWY4oZeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50l9icOH/NAqXqEeRWrba18Ol7cGxCxpc530wur+gIc=;
	b=c54mnmiHTjke78vY11oU+0d+/XExY76ArqHd+EugXCZA6mUfmzIZfo+dBpPJO/buE61oM9
	3KcciSRn3yAnGICQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/topology: Add a mechanism to track topology via APIC IDs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.406985021@linutronix.de>
References: <20240213210252.406985021@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661674.398.8569533723035710889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f1f758a80516775b5d12d7c93cbedb2a08cd4c98
Gitweb:        https://git.kernel.org/tip/f1f758a80516775b5d12d7c93cbedb2a08cd4c98
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/topology: Add a mechanism to track topology via APIC IDs

Topology on X86 is determined by the registered APIC IDs and the
segmentation information retrieved from CPUID. Depending on the granularity
of the provided CPUID information the most fine grained scheme looks like
this according to Intel terminology:

   [PKG][DIEGRP][DIE][TILE][MODULE][CORE][THREAD]

Not enumerated domain levels consume 0 bits in the APIC ID. This allows to
provide a consistent view at the topology and determine other information
precisely like the number of cores in a package on hybrid systems, where
the existing assumption that number or cores == number of threads / threads
per core does not hold.

Provide per domain level bitmaps which record the APIC ID split into the
domain levels to make later evaluation of domain level specific information
simple. This allows to calculate e.g. the logical IDs without any further
extra logic.

Contrary to the existing registration mechanism this records disabled CPUs,
which are subject to later hotplug as well. That's useful for boot time
sizing of package or die dependent allocations without using heuristics.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.406985021@linutronix.de



---
 arch/x86/kernel/cpu/topology.c | 48 +++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d555331..c671206 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -1,5 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
+/*
+ * CPU/APIC topology
+ *
+ * The APIC IDs describe the system topology in multiple domain levels.
+ * The CPUID topology parser provides the information which part of the
+ * APIC ID is associated to the individual levels:
+ *
+ * [PACKAGE][DIEGRP][DIE][TILE][MODULE][CORE][THREAD]
+ *
+ * The root space contains the package (socket) IDs.
+ *
+ * Not enumerated levels consume 0 bits space, but conceptually they are
+ * always represented. If e.g. only CORE and THREAD levels are enumerated
+ * then the DIE, MODULE and TILE have the same physical ID as the PACKAGE.
+ *
+ * If SMT is not supported, then the THREAD domain is still used. It then
+ * has the same physical ID as the CORE domain and is the only child of
+ * the core domain.
+ *
+ * This allows a unified view on the system independent of the enumerated
+ * domain levels without requiring any conditionals in the code.
+ */
+#define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
 
 #include <xen/xen.h>
@@ -9,6 +31,8 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 
+#include "cpu.h"
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -23,6 +47,9 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
 /* Used for CPU number allocation and parallel CPU bringup */
 u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
+/* Bitmaps to mark registered APICs at each topology domain */
+static struct { DECLARE_BITMAP(map, MAX_LOCAL_APIC); } apic_maps[TOPO_MAX_DOMAIN] __ro_after_init;
+
 /*
  * Keep track of assigned, disabled and rejected CPUs. Present assigned
  * with 1 as CPU #0 is reserved for the boot CPU.
@@ -39,6 +66,8 @@ static struct {
 	.real_bsp_apic_id	= BAD_APICID,
 };
 
+#define domain_weight(_dom)	bitmap_weight(apic_maps[_dom].map, MAX_LOCAL_APIC)
+
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -81,6 +110,17 @@ early_initcall(smp_init_primary_thread_mask);
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
+/*
+ * Convert the APIC ID to a domain level ID by masking out the low bits
+ * below the domain level @dom.
+ */
+static inline u32 topo_apicid(u32 apicid, enum x86_topology_domains dom)
+{
+	if (dom == TOPO_SMT_DOMAIN)
+		return apicid;
+	return apicid & (UINT_MAX << x86_topo_system.dom_shifts[dom - 1]);
+}
+
 static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
@@ -151,7 +191,7 @@ static __init bool check_for_real_bsp(u32 apic_id)
 
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
+	int cpu, dom;
 
 	if (present) {
 		set_bit(apic_id, phys_cpu_present_map);
@@ -170,6 +210,10 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 	} else {
 		topo_info.nr_disabled_cpus++;
 	}
+
+	/* Register present and possible CPUs in the domain maps */
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
+		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }
 
 /**

