Return-Path: <linux-kernel+bounces-35369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBC838FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CB5B2B753
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9D66B3B;
	Tue, 23 Jan 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJQ9QwoG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tBIZzr0z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3C5FBBA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015496; cv=none; b=FmnNdoy114g4fz9VMKtrCeoyAhmslVnd+WslnvV9kKLmUreTPlFNYGycKHM7DYUsAo0Xs9P41E7Xw3qxUfkBRTDk/tnHJcDNgEOEtkFNlvxZWiFfsblW9BcWEv608ezqyp10CDZdMlRpEgpq3dhz8eJfEHsxzM4Mya2JIw+A4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015496; c=relaxed/simple;
	bh=Z9yw3YyaWf/olDEzkdLgsFrWom4D6GNMQs0khKomLNA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u6cQgEOkPnbFxA3+aov4giDOSWfUAijQHeYuyDjRxMLk6gGFw21BALZ/5ZTLNcVx+sUxVpnoBv7gUg5IEZZ6DGYzrOAJyusIOBUUJYR3tfSrEiKjb6DnLW2VzUIG7VVlq33QalWBug8646arRVigV+NS3as1Jt2V9yIFvTgs+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJQ9QwoG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tBIZzr0z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123650.028320632@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Kanh4hNmVgcEwESDgRk7QWiOR9DqNwiGAJLu7VeT5K8=;
	b=FJQ9QwoGLpV5KQ7JkDijCKEG7ND0BHqtBLKciJelC+Ls3KGt4c+GrtfJgq6e2P/YimOOKl
	B5evuxh/z6GfeBxoQ+pM8zh+osMTfoPw7fDu/jkPMKVlAobOTH7nUM5m5StAJzUB5IEXRK
	wbijvK0Hv2rLcWtgQk4dlZKvCFTJMc91/CBsk7IITQa6PpZFPRMLGikgh0GJvXWrbBs52Z
	pjqAdy1cv9I1NBh5QW37aN6owpBreKjoVsr4HPz3glOSds0sBx7Y6AoTTiTWqYaGsSp1k9
	xlryqBV7GlH412l+YrDQHUJzXpqw7ONTmlwPWqlajV019TdTbClXws7YVb4iaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Kanh4hNmVgcEwESDgRk7QWiOR9DqNwiGAJLu7VeT5K8=;
	b=tBIZzr0zcd41M3KUVhreoomqEKMc4lU+YzqBUputj1joT31gm9NbhlIsHfmqVYR0YExC9+
	cvt7WX4hlb7N58Dw==
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
Subject: [patch v2 26/30] x86/cpu/topology: Retrieve cores per package from
 topology bitmaps
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:32 +0100 (CET)

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


