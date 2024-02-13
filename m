Return-Path: <linux-kernel+bounces-64310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC3853CED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCEF1F289A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832B85941;
	Tue, 13 Feb 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0JUjk1Nb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKyhgdLo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71558562F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858371; cv=none; b=GVhuYRMm3Fxec2SzpDeQbY7Msfi1QUaormJp37i3u/ks8s3mlWSkKTKMFsjlddTH7QTwhR1TeH1jeud2QbwapDXYdzq2LDUKd+0KoHxL7K0Hb0A14CpI2FwoiO2NDp4DNymXq/j+054NPLRQYRXRLvDDM++ldlSweWusVS9olcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858371; c=relaxed/simple;
	bh=dzZg/qbHJvAs2UTwP+S3YTraj0xonaKUEUGBDYOq4Ys=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hO7KoINDvHMilB8U+zE4chCXRkRgGLBwQ7A5pEbmOMcOetzP7GH2agG0nudYQ8ZwYHiGoO3mLZdkyRO+5EREIgZaL6vNIM8zGq/tAlbRrURSLSYvh6Hr4HnhG3MBR0AZavyzJXRntmfwoXzbRQWZsR0fUlm9Ok64KLIJJ7QMUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0JUjk1Nb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKyhgdLo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.846136196@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VSt0e/pJgXOuwhWfq+S+zmb74FzHu/CZzfV9Bz+FkzQ=;
	b=0JUjk1NbcZdKyEcWK408QIMwYUEaGUYAKKNJ74i87P8E8w6szqsv7OePZ3tcOXQ94++mbV
	eDbPHX75r9nyjMFwpD2GZiQqJxDfZfudq+iEtNggN5pHOci/VKhTOJgKtZ7rm9NmUQHsb2
	XqU8bbKeZ3dA0iJXH9xlflyBcN2zMY7kDrpKQZ+Dzi1vSi7i9698g/FF9PEOSycCsuPRO3
	BwQLTgCfmszEhtfHRa/EJEX/RstNFKEotR1xE901wAxx8YetfATEr+XbCuKQd5B5PEAe/1
	XgtCnnWgJUCYECm7Xzz7RjY81FX54JZcaD1PjTPfwBSbj5yXXdi6UKZ2TExmoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VSt0e/pJgXOuwhWfq+S+zmb74FzHu/CZzfV9Bz+FkzQ=;
	b=pKyhgdLod3f79cGRjJsb3nBPliUbF3C9bSowopxEVo5WMqdabcozXoC10wIa7UCUQno3M3
	F4zfClkK9ZstF8AQ==
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
Subject: [patch 24/30] x86/cpu/topology: Provide logical pkg/die mapping
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:07 +0100 (CET)

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



