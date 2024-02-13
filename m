Return-Path: <linux-kernel+bounces-64288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FE853CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3643FB26F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898F7A73B;
	Tue, 13 Feb 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ce3LpaRN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="64BvwSJU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8462810
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858341; cv=none; b=blOOjGTyWJS4ENibPDv5I396yvstWs09BswbD/tqNlrgYEfUkj9olA72niQPgF6Tk3IkzNFtcz/AJkhgi5d7JBcJgfnehul/+HhffnkfVDDQiVGg9JfIH9IlMJw5RtNdCoCgWVLXNVbMmLsZZPmt2hlwq8g5oYZKNZUTG9fSlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858341; c=relaxed/simple;
	bh=S0168uuAgX+OrtNzHUht82jJ6HfNesiRsOyCjpNYZ7E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=k2g7anb0A8ztHcom/Hx3JWKwQ7b3jrf/hwdCUAnozVg/mYEo3SrqYZFMirt5udH19pUmSsenV90T8+BQMBAuObdmpPI497Sj0bjsjkPrsGmG1L2Q+Ag5x+QzZPswsJrfGVn7U/TWoOeO2uuHXZmhoSHYVLLfeTrDYrzHT+VMxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ce3LpaRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=64BvwSJU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.664738831@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=60uaXjzkNtRqK9qiefJswJS4h5SaG8mwJ8oA6CldzTE=;
	b=ce3LpaRNnfo33v7j673mjkQr97RSvDyOzY62Hs4KuE8ZAYsa2mwM/GlZnXsQzYx9HR9bTa
	L1ONPZyUjUedLdg9p948l2Tad2nSvIM96L1kGRtw7MDKTBn46eCOrFr0+7/VUSQNpOR93L
	u9b0mstk4XSBvr4gXnHehd+iIk5bFHnW5eBocSmIw2jyTOKjZghCKnEVd+DHJv5xSeVg8s
	E3/JG0SmT63I6kzkQVwJT93M4RIVS+hvAjMwg0uWPo66QGjoipJAgUZ7Yx3aRgarIQCkm5
	KQFEAKdU923g+5I0fx/T3LcFDXUXygw34YXVD1QxbrxjZK32ZWi8SIoneUprhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=60uaXjzkNtRqK9qiefJswJS4h5SaG8mwJ8oA6CldzTE=;
	b=64BvwSJUP0ZVY7lHZRMW/pKRyHRncODWW73ez6S9h/kTlUB+6Glp8u6m7bSfuBspon8H7w
	zlzi/sSdnHMlKZBA==
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
Subject: [patch 03/30] x86/acpi: Use new APIC registration functions
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:37 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Use the new topology registration functions and make the early boot code
path __init. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/acpi/boot.c |   44 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)
---

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -164,33 +164,9 @@ static int __init acpi_parse_madt(struct
 	return 0;
 }
 
-/**
- * acpi_register_lapic - register a local apic and generates a logic cpu number
- * @id: local apic id to register
- * @acpiid: ACPI id to register
- * @enabled: this cpu is enabled or not
- *
- * Returns the logic cpu number which maps to the local apic
- */
-static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
+static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
-
-	if (id >= MAX_LOCAL_APIC) {
-		pr_info("skipped apicid that is too big\n");
-		return -EINVAL;
-	}
-
-	if (!enabled) {
-		++disabled_cpus;
-		return -EINVAL;
-	}
-
-	cpu = generic_processor_info(id);
-	if (cpu >= 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
-
-	return cpu;
+	topology_register_apic(apic_id, acpi_id, present);
 }
 
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
@@ -844,12 +820,10 @@ static int acpi_map_cpu2node(acpi_handle
 	return 0;
 }
 
-int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
-		 int *pcpu)
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
 {
-	int cpu;
+	int cpu = topology_hotplug_apic(physid, acpi_id);
 
-	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
 		pr_info("Unable to map lapic to logical cpu number\n");
 		return cpu;
@@ -868,15 +842,11 @@ int acpi_unmap_cpu(int cpu)
 #ifdef CONFIG_ACPI_NUMA
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
-
-	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
-	set_cpu_present(cpu, false);
-	num_processors--;
-
-	return (0);
+	topology_hotunplug_apic(cpu);
+	return 0;
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif	/* CONFIG_ACPI_HOTPLUG_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {



