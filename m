Return-Path: <linux-kernel+bounces-35359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98299838FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6222DB2A72D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916064CFD;
	Tue, 23 Jan 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4gSjzZfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gZlxwr6n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834464CC6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015479; cv=none; b=VgBjSMkuT4Q1ygMEJIcUXsJ35TsKCUaSmYoR4omEcInymhymOK6gEvafVNpJsuirQ4z42QfOuTb7uciy7h8kXgkz05ADQlOU+7EY+Aa/wFmuIhNQAy+SamP8ilAmZ4bdoKl29Ivudevlh04Sd0HE9hxpGBXS4yvK6n92BIUu2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015479; c=relaxed/simple;
	bh=I1SQtnTLZUxsrxlA6hOJKmFREclmLqWNgnpq8GQG2Dc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=V+fU1LDMlkRmwlLm2iZKCXQv4Ku4HvvWcFGk8vxMJFZaZScudnorAy4AF9pm+PsgmOiYcGsUCmFMev8KgF9nNHrRtNepqQqRljksFlmKwiaYj42TiS6Wq3UM7D6FSFTO6MnfYla+LoShXq6Rxl8xpcNaDnxnPG9/Y5h5T5CPinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4gSjzZfW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gZlxwr6n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.457293914@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k+aJuv8k1/XFPGcpFKqCzFGQQLJcSJpnrwligUkpyog=;
	b=4gSjzZfWP8b0oymelZ2lj37G/Bi2nbqhBjC7B/nG1yL3liRcOQ4ltxxSmyvNxAsVUXXnlX
	kkYlKw9228N23dl+x9gj606rBQblumQWf70MKKFmZzML+GXgO30i3UpVcLCFJqP3K0NuSX
	IdWF80z+KlM2RuO1a7vS/6wpZ5RwPUQZZqKRVG2D3vmpYQuWgzVor5NsqPIuE+dbT26LHY
	B9HLCgLfQwVbDlFRIDUZu8mEQJXeU5uj6zcDBtcxM+H+nUspQTnC6BXYlUw08P7bgbtxIA
	jOwHS9mHGHay86UznsvSc2Ctu4KKHBuPVOPW6Q2NNwlsw3OoCPDdaCQQGeGPtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k+aJuv8k1/XFPGcpFKqCzFGQQLJcSJpnrwligUkpyog=;
	b=gZlxwr6nvXbpV7D5Fv0Pv1cx5/G/5if5Hx/DL158dtFHioqlKdL383kspd0v1og9dhjBKz
	BdKrJV6dNR8zalCw==
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
Subject: [patch v2 16/30] x86/topology: Add a mechanism to track topology via
 APIC IDs
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:15 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

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

---
 arch/x86/kernel/cpu/topology.c |   48 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)
---
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
@@ -23,6 +47,9 @@ DECLARE_BITMAP(phys_cpu_present_map, MAX
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
@@ -81,6 +110,17 @@ early_initcall(smp_init_primary_thread_m
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
@@ -151,7 +191,7 @@ static __init bool check_for_real_bsp(u3
 
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
+	int cpu, dom;
 
 	if (present) {
 		/*
@@ -171,6 +211,10 @@ static __init void topo_register_apic(u3
 	} else {
 		topo_info.nr_disabled_cpus++;
 	}
+
+	/* Register present and possible CPUs in the domain maps */
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
+		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }
 
 /**


