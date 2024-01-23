Return-Path: <linux-kernel+bounces-35363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B5838FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04C31C2151E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555765BCB;
	Tue, 23 Jan 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwMKRsBe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4T75ydKM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F72657DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015486; cv=none; b=G79AiT1FZroBiTk4zmbAvREy0fOuWYIeVyTr7jhBUh6pSrf1rtpmn4CJHpAKyf2A2G8W7ejxWxPUoZ0ooZpzrhyUfEsBpjbPEVly3g6Ditm7F5MFDAqpMFRa8ouVP7CtTgEZQvJUnhnVZh71Xj6vxS3jr7AG9j9crGvJ8rKgepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015486; c=relaxed/simple;
	bh=HC82UXbxGN1Hi6aLHsZ3ND2lVinY2vYNx0+m3CpHTwM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VqELLqmCI+/3L9BtyZ+UK5zvxyTS1HOaVbQOMRU2BnKKhHLWqLSbWFAcC8UgFxMyBMHk75fAeEPWxOv2US9j7qeI4wEddMU2yLyxqiH1h5Dd015aHLMrFZEsekHO3TNx+sGy/K8aZIRom8J0649Z1QieFOgOM6DqckmxIibn3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwMKRsBe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4T75ydKM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.681917612@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GstJkdj4dzJr9Ab3z0mxhqERtIepnLSH1sYrgV3hkW4=;
	b=wwMKRsBeiYdmd0dpP7w1n+82pS/nLejWtW2GAs0RO+m1+MUFM85UJ7cti1JCH57kNhzYil
	O7AJeALTl2964UStLG4Gstf7cAIfGnPDNRvd/VZl7KI15I0rJBUxgrSl/EjS7Yhtf3OwPz
	jjOHF+frBsGuKV1gJq+03s4FLFmJrx8QOmM+F5p+v81Sfk+w8QQfjB1yinwTuIz6YIUWGk
	O+0T3dSHetb0rvvva9Ws+k9ruNcwJ/FJ5OY95rJbrUXc1l6x20R8pppGetFLj2RlapLOfN
	tOhZuJKGyzPNAEQTdY2G9bGuueAQcbpW2X6WA+SEHxHtry6wkkrNA8s0/C9w/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GstJkdj4dzJr9Ab3z0mxhqERtIepnLSH1sYrgV3hkW4=;
	b=4T75ydKMf4OOkNimbbkD1vq/BWEk5vWqXQjYrvPugdepBNa9m2DSKycRTps6FP7w0Dj1hC
	yVRR8piDevyN3eDQ==
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
Subject: [patch v2 20/30] x86/cpu/topology: Let XEN/PV use topology from
 CPUID/MADT
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:22 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

It turns out that XEN/PV Dom0 has halfways usable CPUID/MADT enumeration
except that it cannot deal with CPUs which are enumerated as disabled in
MADT.

DomU has no MADT and provides at least rudimentary topology information in
CPUID leaves 1 and 4.

For both it's important that there are not more possible Linux CPUs than
vCPUs provided by the hypervisor.

As this is ensured by counting the vCPUs before enumeration happens:

  - lift the restrictions in the CPUID evaluation and the MADT parser

  - Utilize MADT registration for Dom0

  - Keep the fake APIC ID registration for DomU

  - Fix the XEN APIC fake so the readout of the local APIC ID works for
    Dom0 via the hypercall and for DomU by returning the registered
    fake APIC IDs.

With that the XEN/PV fake approximates usefulness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/kernel/acpi/boot.c           |   25 ++++++++-----------------
 arch/x86/kernel/cpu/topology_common.c |    2 +-
 arch/x86/xen/apic.c                   |   14 +++++++-------
 arch/x86/xen/smp_pv.c                 |   13 ++++++++-----
 4 files changed, 24 insertions(+), 30 deletions(-)
---
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,8 +23,6 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
-#include <xen/xen.h>
-
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -166,12 +164,6 @@ static int __init acpi_parse_madt(struct
 	return 0;
 }
 
-static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
-{
-	if (!xen_pv_domain())
-		topology_register_apic(apic_id, acpi_id, present);
-}
-
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
 {
 	if (lapic_flags & ACPI_MADT_ENABLED)
@@ -233,7 +225,7 @@ acpi_parse_x2apic(union acpi_subtable_he
 		return 0;
 	}
 
-	acpi_register_lapic(apic_id, processor->uid, enabled);
+	topology_register_apic(apic_id, processor->uid, enabled);
 #else
 	pr_warn("x2apic entry ignored\n");
 #endif
@@ -268,9 +260,9 @@ acpi_parse_lapic(union acpi_subtable_hea
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	acpi_register_lapic(processor->id,	/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic(processor->id,	/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
 	has_lapic_cpus = true;
 	return 0;
@@ -288,9 +280,9 @@ acpi_parse_sapic(union acpi_subtable_hea
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_register_lapic((processor->id << 8) | processor->eid,/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic((processor->id << 8) | processor->eid,/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
 	return 0;
 }
@@ -1090,8 +1082,7 @@ static int __init early_acpi_parse_madt_
 		return count;
 	}
 
-	if (!xen_pv_domain())
-		register_lapic_address(acpi_lapic_addr);
+	register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -77,7 +77,7 @@ static bool fake_topology(struct topo_sc
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
-	return tscan->c->cpuid_level < 1 || xen_pv_domain();
+	return tscan->c->cpuid_level < 1;
 }
 
 static void parse_topology(struct topo_scan *tscan, bool early)
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -43,20 +43,20 @@ static u32 xen_apic_read(u32 reg)
 	struct xen_platform_op op = {
 		.cmd = XENPF_get_cpuinfo,
 		.interface_version = XENPF_INTERFACE_VERSION,
-		.u.pcpu_info.xen_cpuid = 0,
 	};
-	int ret;
-
-	/* Shouldn't need this as APIC is turned off for PV, and we only
-	 * get called on the bootup processor. But just in case. */
-	if (!xen_initial_domain() || smp_processor_id())
-		return 0;
+	int ret, cpu;
 
 	if (reg == APIC_LVR)
 		return 0x14;
 	if (reg != APIC_ID)
 		return 0;
 
+	cpu = smp_processor_id();
+	if (!xen_initial_domain())
+		return cpu ? cpuid_to_apicid[cpu] << 24 : 0;
+
+	op.u.pcpu_info.xen_cpuid = cpu;
+
 	ret = HYPERVISOR_platform_op(&op);
 	if (ret)
 		op.u.pcpu_info.apic_id = BAD_APICID;
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -156,11 +156,9 @@ static void __init xen_pv_smp_config(voi
 
 	topology_register_boot_apic(apicid++);
 
-	for (i = 1; i < nr_cpu_ids; i++) {
-		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL) < 0)
-			break;
+	for (i = 1; i < nr_cpu_ids; i++)
 		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
-	}
+
 	/* Pretend to be a proper enumerated system */
 	smp_found_config = 1;
 }
@@ -451,5 +449,10 @@ void __init xen_smp_init(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
+
+	/* XEN/PV Dom0 has halfways sane topology information via CPUID/MADT */
+	if (xen_initial_domain())
+		x86_init.mpparse.parse_smp_cfg	= x86_init_noop;
+	else
+		x86_init.mpparse.parse_smp_cfg	= xen_pv_smp_config;
 }


