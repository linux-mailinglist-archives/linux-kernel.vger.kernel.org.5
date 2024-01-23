Return-Path: <linux-kernel+bounces-35367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C7838FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E1283B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237D5FBA8;
	Tue, 23 Jan 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uX7ei09C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VupscB6T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F6664D0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015493; cv=none; b=IrlW84IVAir9KDj/f2pWcdJWhlBwqTIZrfIOSs9JtrlAHqxsD72Po4XTveIjq4/vFW0zCJUSLrEEHnxLJHBH4aTxzESRU+FfFoolOmOZCwe8eVi64HIgQGapH4P26lNMDclzUiifHO/mhVaozxYbV4Y/n6eJG3xmnRW4FTNqc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015493; c=relaxed/simple;
	bh=Ct1lFW4Zt/3ZqqheSth0KhDYtCQXFpSWEQCu55WXYkw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bigcGeYAJNyVXHYIYWgJw5prH4iGFH34m9bVEDVJvPKngLRSkFQl0SQIj/Z60oQNDwowTe48NlqaK9J4dgaoSavwzB9DZy3Cc+O+wWl4KucKqUY2deIbTqONEltIosDBTcYp2+jTt169iwBBtKBp+V2X8fOlVol0OS9xVbcCFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uX7ei09C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VupscB6T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.915802822@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6dhXYTos6w2yCRv5UATW39ekFguDcopd4GmFr46wLNc=;
	b=uX7ei09CmEb2eLpMfy2gC3gSHRHchP66lsJYQAt6PCqGtokPPQ+6SpykwWKm2iilmGd2/b
	we3INiR+R+4PjECbR9AITlaUa2W4z12zuirWewkule9D8qunYkYGR4vDu08ccYKDut60XD
	XeTc4DCNgediYHZH+oxQX/ZLJXxPKCR/3FHh/or3fiKuokDyoo7GZHQwVNKjZg3gZY57gU
	7vJ0Vg0xmQH4ChZvi0uPJ6bSE/wNTa/ZT2g2wSDrJaXlDmcD88aFUL9xp/sdAhGfjNT0/O
	S2GNVW+AKM+/UUfmoFsOinb6OLpzn0LVklyrCCg46UW3nG3iycF9dGAanxsWKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6dhXYTos6w2yCRv5UATW39ekFguDcopd4GmFr46wLNc=;
	b=VupscB6TiZJvbX/r88yiwLAU9JMmN9+p80jDdh2UfuBQ3F12tKQs+qfR9A+MpPthaW/k72
	dDKCL98TdIizKoCw==
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
Subject: [patch v2 24/30] x86/cpu/topology: Provide logical pkg/die mapping
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:29 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

With the topology bitmaps in place the logical package and die IDs can
trivially be retrieved by determining the bitmap weight of the relevant
topology domain level up to and including the physical ID in question.

Provide a function to that effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/include/asm/topology.h |    9 +++++++++
 arch/x86/kernel/cpu/topology.c  |   28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -156,6 +156,15 @@ static inline unsigned int topology_max_
 	return __max_dies_per_package;
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+#else
+static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -230,6 +230,34 @@ void __init topology_register_boot_apic(
 	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
+/**
+ * topology_get_logical_id - Retrieve the logical ID at a given topology domain level
+ * @apicid:		The APIC ID for which to lookup the logical ID
+ * @at_level:		The topology domain level to use
+ *
+ * @apicid must be a full APIC ID, not the normalized variant. It's valid to have
+ * all bits below the domain level specified by @at_level to be clear. So both
+ * real APIC IDs and backshifted normalized APIC IDs work correctly.
+ *
+ * Returns:
+ *  - >= 0:	The requested logical ID
+ *  - -ERANGE:	@apicid is out of range
+ *  - -ENODEV:	@apicid is not registered
+ */
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid = topo_apicid(apicid, at_level);
+
+	if (lvlid >= MAX_LOCAL_APIC)
+		return -ERANGE;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return -ENODEV;
+	/* Get the number of set bits before @lvlid. */
+	return bitmap_weight(apic_maps[at_level].map, lvlid);
+}
+EXPORT_SYMBOL_GPL(topology_get_logical_id);
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot


