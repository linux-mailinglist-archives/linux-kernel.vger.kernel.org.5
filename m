Return-Path: <linux-kernel+bounces-64312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B13853CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBCA1C26AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B78663E;
	Tue, 13 Feb 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHR6gcNm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+AOL6JEK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC985950
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858374; cv=none; b=c4ZgwenqZsLSlE8i1F1vQTABnoSgRSKWXuFNqiweaQZAnEqoBahN0hYN4OQOffJi0Jw+6GpcRTHxeVpw5BEIX7oimMujn7lBVaGaFEjXYJRkVXiwIga1dkGORy49nVAhQ2AH0+E/Vl7A5OAmw9XaOKWuyMgdmlOPanLAVKpGvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858374; c=relaxed/simple;
	bh=YxTfdJnty9Os89Sb2GGXBFkpPozcwbCxUT9AWMe/2Kw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gldsWz96GhzxbQ3ga8itTNL9NdLhVDiJkvxRJDMTEOt2gNngK2mg4Ult236Q7KTaXABfRZvV42vTssxqGQBcP/5kiEnQj1SN7UmObfkg9Sp5vsQ03m3OPKKU2xH7vF69k0h4A1p1p1lEvvw1iPr5/pgAiNtBHxCFgSP3DCHV5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHR6gcNm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+AOL6JEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.956858282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hKp0SumwdMdW6ZHjFxH6LZU4vhmrmECwOTrjjSTK/SA=;
	b=BHR6gcNmYJRTvXtBPOS+hbP/3i/RFARjh/DJZSBq0792N5j/6z+raERUfhE2eg43tmPNdD
	AO5XMzISTdy4P9nKmVO71/BLsmybwPoum5LoqeFAU/nEkbDKlQmyx9WbvFDyb16FkXx20o
	pEv7tQqZmLWdnKS7sphQ6sU+0AymwmOU974eLhXutC7OetjGrmyLaORzdwrHCElYdSNAHc
	GAYiETKwviuWr2J89cDnN4Zvqad6cLBJTkJ2DSGYP7MS2Bc6jbKbMc4XrsWPcaw3bfAEBk
	WqYe6safGw+rq3huodw3HcMRXaeMQsvIXVH4NlDnjqKVwYcCo15I7Q6/Qvr5Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hKp0SumwdMdW6ZHjFxH6LZU4vhmrmECwOTrjjSTK/SA=;
	b=+AOL6JEKhHTOx4AIFdYPU5LOsLqTaNIRZMcQQGEUMKZahsWF18CH6xgAoVpTrKmfZ+xKN3
	+F0HNFEI2qRrAICQ==
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
Subject: [patch 26/30] x86/cpu/topology: Retrieve cores per package from
 topology bitmaps
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:10 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Similar to other sizing information the number of cores per package can be
established from the topology bitmap.

Provide a function for retrieving that information and replace the buggy
hack in the CPUID evaluation with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>




---
 arch/x86/kernel/cpu/topology.c        |   43 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/topology.h        |   11 ++++++++
 arch/x86/kernel/cpu/topology_common.c |   18 ++------------
 3 files changed, 57 insertions(+), 15 deletions(-)
---

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -217,6 +217,49 @@ int topology_get_logical_id(u32 apicid,
 }
 EXPORT_SYMBOL_GPL(topology_get_logical_id);
 
+/**
+ * topology_unit_count - Retrieve the count of specified units at a given topology domain level
+ * @apicid:		The APIC ID which specifies the search range
+ * @which_units:	The domain level specifying the units to count
+ * @at_level:		The domain level at which @which_units have to be counted
+ *
+ * This returns the number of possible units according to the enumerated
+ * information.
+ *
+ * E.g. topology_count_units(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN)
+ * counts the number of possible cores in the package to which @apicid
+ * belongs.
+ *
+ * @at_level must obviously be greater than @which_level to produce useful
+ * results.  If @at_level is equal to @which_units the result is
+ * unsurprisingly 1. If @at_level is less than @which_units the results
+ * is by definition undefined and the function returns 0.
+ */
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_units,
+				 enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid = topo_apicid(apicid, at_level);
+	unsigned int id, end, cnt = 0;
+
+	if (lvlid >= MAX_LOCAL_APIC)
+		return 0;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return 0;
+	if (which_units > at_level)
+		return 0;
+	if (which_units == at_level)
+		return 1;
+
+	/* Calculate the exclusive end */
+	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+	/* Unfortunately there is no bitmap_weight_range() */
+	for (id = find_next_bit(apic_maps[which_units].map, end, lvlid);
+	     id < end; id = find_next_bit(apic_maps[which_units].map, end, ++id))
+		cnt++;
+	return cnt;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -53,4 +53,15 @@ static inline void topology_update_dom(s
 	tscan->dom_ncpus[dom] = ncpus;
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_units,
+				 enum x86_topology_domains at_level);
+#else
+static inline unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_units,
+					       enum x86_topology_domains at_level)
+{
+	return 1;
+}
+#endif
+
 #endif /* ARCH_X86_TOPOLOGY_H */
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -155,25 +155,15 @@ static void topo_set_ids(struct topo_sca
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
 
+	/* Maximum number of cores on this package */
+	c->x86_max_cores = topology_unit_count(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
+
 	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
 }
 
-static void topo_set_max_cores(struct topo_scan *tscan)
-{
-	/*
-	 * Bug compatible for now. This is broken on hybrid systems:
-	 * 8 cores SMT + 8 cores w/o SMT
-	 * tscan.dom_ncpus[TOPO_DIEGRP_DOMAIN] = 24; 24 / 2 = 12 !!
-	 *
-	 * Cannot be fixed without further topology enumeration changes.
-	 */
-	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_DIEGRP_DOMAIN] >>
-		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
-}
-
 void cpu_parse_topology(struct cpuinfo_x86 *c)
 {
 	unsigned int dom, cpu = smp_processor_id();
@@ -201,7 +191,6 @@ void cpu_parse_topology(struct cpuinfo_x
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -223,7 +212,6 @@ void __init cpu_init_topology(struct cpu
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to



