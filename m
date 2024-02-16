Return-Path: <linux-kernel+bounces-68794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECD85807B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB45A283462
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911812FF87;
	Fri, 16 Feb 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrBIn4GY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWba9NgV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F312F5B4;
	Fri, 16 Feb 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096613; cv=none; b=B76RqKt24dNrgvDfxwd2Be06RrlCZITxQM/tHovU2SnaUx7XHrgeF8Ff9riWCSQrhyoP0+K4jhdge3oMHhcLs2BCBrDUtNib5r5ujDXs6nyUyU1zTCRIBXuVhHlYSZTCLfSoyyNOpzXsaxCts5Mdrpj7hT2HRq6fqOICcRWkFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096613; c=relaxed/simple;
	bh=XPCt0X7p2Cgxh9KrMX/CnY3Is6sOoufggL7SPjrY0hY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CTsfy1SaNWFlMTPmnuDElyi5A0l3z+qUadpmZdjujcvbKSwJp/dIkzFbyKiyG8NtEDZz85y7zsZ43WFhqG97zga5EA+tR0ij7G6K+e0/1adydyzACVkkJDEkNSoH/YGTA9bb99dwIS6nxIB6wbLYTG3SLLTIJ2u9PAIOY7PDrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrBIn4GY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWba9NgV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAx8kB162tET0vwf6DFPGsSa+4x9f+vUYMUc53vcN2A=;
	b=ZrBIn4GYs/dhwSE/2Xr1Kb6OvE7QpmtI2TdL0kDWuCIT3QbiuxvKMYpwH/O5TM5FD4eLCg
	1miD4LYQuIItplgJe5eMYBou24YNqYtD0SkcIZN2R42NuNjTy//vfXbOq21Ozr+m6jpF87
	GjyJMnvqfKYJa9iO3SDJFlotANspuKSfLz+TFxBtIpMaGuKBNgBLuRrtHZaJ1A0sAY6ptG
	dS480YXYKOAP6xypWUEwxaB8V2brIZ7Rvi8ZQkNW6pi/pTb49XpMK1UStxL51LN4t7Bfig
	K55n9Y9VRX4eqP1OLGCIZp3i0hhioaGvkMiNV2b7LaUayvEKVc06KBtQHouQ8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAx8kB162tET0vwf6DFPGsSa+4x9f+vUYMUc53vcN2A=;
	b=fWba9NgVMrBFQoNjET1oTFn0WGJdq/v4QJzAoQVulCvedKfHmmRAtfPSaLPst6rHXLEScR
	UUalRwnl5fXYAfAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Retrieve cores per package from
 topology bitmaps
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.956858282@linutronix.de>
References: <20240213210252.956858282@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660823.398.3113097382222160955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3205c9833d69b97e8694efe3e193312dea4c571f
Gitweb:        https://git.kernel.org/tip/3205c9833d69b97e8694efe3e193312dea4c571f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:45 +01:00

x86/cpu/topology: Retrieve cores per package from topology bitmaps

Similar to other sizing information the number of cores per package can be
established from the topology bitmap.

Provide a function for retrieving that information and replace the buggy
hack in the CPUID evaluation with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.956858282@linutronix.de





---
 arch/x86/kernel/cpu/topology.c        | 43 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/topology.h        | 11 +++++++-
 arch/x86/kernel/cpu/topology_common.c | 18 +----------
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 29759b4..7db9df5 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -257,6 +257,49 @@ int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
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
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 2a3c838..3732629 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -53,4 +53,15 @@ static inline void topology_update_dom(struct topo_scan *tscan, enum x86_topolog
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
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index c21a387..a2c3f8f 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -155,25 +155,15 @@ static void topo_set_ids(struct topo_scan *tscan)
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
@@ -201,7 +191,6 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -223,7 +212,6 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to

