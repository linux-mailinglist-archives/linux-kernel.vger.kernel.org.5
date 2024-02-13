Return-Path: <linux-kernel+bounces-64301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31D853CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FEAFB27280
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAD81AC4;
	Tue, 13 Feb 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LhAFgIyf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q2OklErl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DA8172D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858359; cv=none; b=HIvFNbMWtvhw9MRk0JK6MwLUc/b7YiL81wjqyPgwkZYZnAelUDVwSTzIgRZEt1FuGPTc2GQ+AoPmIr6bnkOTYxWoh1pDhSECP/oLhMogLvBFd5Wp5X+8TxgE4N7w+ezZE5huh9FFsO9kiFHyzGMVH+2YlzwFUAn8deCx/Mv3JbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858359; c=relaxed/simple;
	bh=oD2vI5Tet2FqH3VOQ1L2xdWVrfJsPig0S2CwRAglma4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bEUS280kTxQqBA5mUXwWHBUJ9JZ0r6TjhlBnKC0bELL/36VJQnBDFqDlCeVoBV0R25mbfJPUAGwz7gGG50chaVNv1Oc3U8k0NW5ly6l3xXRI5MVzlPGsheDifRaBGc8CnloR/xi3jUWisyEoUx88HrSSo1uheh3t6o7mxJn9syM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LhAFgIyf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q2OklErl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.406985021@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6N/WUbTSEcHybys5fcjgpX9vLfa80Wg5DfRxfxs6bpg=;
	b=LhAFgIyfHqbKTPEAtcur6KWgyxDXtpb2rVxlj7EQk4jnFLQWzAOP59Mr46lJn1Tobva6pp
	K0GyOnSZXKRHrKWY9ug9zITwnUe5tKgs3wPQB0DH2yJbOZZoA9oDtM7OBhUomVMIHMS7gL
	hQps2qyeyn9B3XfT9XqG8XZ6cJXCE7pCsA4KY64eOgFefJWFfJdZPjDArtxKlL73vXYIDb
	NyRhopg5s2Wqwonk5Lo7gYC4PX6dUbLmu31CFJBVFwUI5kTQwcCAW1uquvlLsAYtKnh1Aj
	feUx6b3FSKhJpl97wlwm4JsUNpmPleF4mIluxfI7KPV1vccGSohanc8o+S69oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6N/WUbTSEcHybys5fcjgpX9vLfa80Wg5DfRxfxs6bpg=;
	b=q2OklErlIHp7vOEBa5ADKui58zGpHKITpmjdJml0Rvxc9BhY+u3geJUBx2taztELInOFF1
	VrhzbhofB6dE0rDQ==
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
Subject: [patch 16/30] x86/topology: Add a mechanism to track topology via
 APIC IDs
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:56 +0100 (CET)

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
 		set_bit(apic_id, phys_cpu_present_map);
@@ -170,6 +210,10 @@ static __init void topo_register_apic(u3
 	} else {
 		topo_info.nr_disabled_cpus++;
 	}
+
+	/* Register present and possible CPUs in the domain maps */
+	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
+		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }
 
 /**


