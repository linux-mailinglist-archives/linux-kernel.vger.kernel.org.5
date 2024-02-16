Return-Path: <linux-kernel+bounces-68800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E5858088
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8671C2159D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99012F5A7;
	Fri, 16 Feb 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sl93zbkn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PE/rMggH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5D12F590;
	Fri, 16 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096617; cv=none; b=u+oOYX4Sh6nAYcmVIj+q5z05opsaTIW45mgwa4906mq77E06Q/LV5OuCNxEUHEV6Qu1SEmyOeUir0HxIlPWAkeZ54ae9szIW7HwgLcrc7gS2h9akSjrCHbJ03jwmscfeSncfjjx1FSzRIRHB1gCnGDqICe+6K0Y5EqT5mQhcWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096617; c=relaxed/simple;
	bh=+XYyH0X4LqNz/ud5Odxa5nl9Dj0yPEJYpVmJs5Ok9p0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kehlTy5yM2b7sUDdoMUsb0711h95SNtaog5vXnGR4bl0VdYlXjCQ/ajQAr3wDYbsciyDBAGM5w69dbmm9hZz0tZWrO9w387HxHowO70eWJH32amLYRqVXMMQmHAM3rt7Wx4JzAqjfuvjSeSf7XOrLkXBHz9BEARnmTr8b3BhRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sl93zbkn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PE/rMggH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5/8/aLLXz9RfSNC8H3jsllxQyKpHjM57EMETjBQtaw=;
	b=sl93zbkntHsGUBm0cL1m9h5INEvFLM/M0OwJg8hCBjWb44R0eomWxLUxIX2F9bcpaVCeUo
	gsiu2cgqeee6wd5+OiOUfqU/sa43+Sdz6sHmGtmcK5F+rnSpssFJpXGx6eEyX5i7gMI36R
	UlvWIoLnSJZ7Ux9d+n7OwjqNG6izPvRZ7rr0v8FqwYA9sSg4h8vQWZNdVwH7P3gXvZk8TM
	9KEwIKbloczY3qawU9s2EPedkLNyt0l28vk20xI+Vouq8+rAIG4pOAy6+XlEYyBEqpi+hf
	OBkvr9jFR7rxFBQE+itKvUD48B/uHcXQGXDJcsJfrtav1AzDOLTObGJnzwb3cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5/8/aLLXz9RfSNC8H3jsllxQyKpHjM57EMETjBQtaw=;
	b=PE/rMggHZlqBFxYjAeI6ToIC4rxFzu+uzS3/WHuOa28zdORmEbSNF87OkuSPvN6qD6asPI
	qqVmPwcsk8PcdIBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Let XEN/PV use topology from CPUID/MADT
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.626195405@linutronix.de>
References: <20240213210252.626195405@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661330.398.9115116026114184217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     354da4cf57af5d8b5302251204d6077600b6d3d6
Gitweb:        https://git.kernel.org/tip/354da4cf57af5d8b5302251204d6077600b6d3d6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Let XEN/PV use topology from CPUID/MADT

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.626195405@linutronix.de





---
 arch/x86/kernel/acpi/boot.c           | 25 ++++++++-----------------
 arch/x86/kernel/cpu/topology_common.c |  2 +-
 arch/x86/xen/apic.c                   | 14 +++++++-------
 arch/x86/xen/smp_pv.c                 | 13 ++++++++-----
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index df741fb..4bf82db 100644
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
@@ -166,12 +164,6 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
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
@@ -233,7 +225,7 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 		return 0;
 	}
 
-	acpi_register_lapic(apic_id, processor->uid, enabled);
+	topology_register_apic(apic_id, processor->uid, enabled);
 #else
 	pr_warn("x2apic entry ignored\n");
 #endif
@@ -268,9 +260,9 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
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
@@ -288,9 +280,9 @@ acpi_parse_sapic(union acpi_subtable_headers *header, const unsigned long end)
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_register_lapic((processor->id << 8) | processor->eid,/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic((processor->id << 8) | processor->eid,/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
 	return 0;
 }
@@ -1090,8 +1082,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 		return count;
 	}
 
-	if (!xen_pv_domain())
-		register_lapic_address(acpi_lapic_addr);
+	register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 3876a33..b0b68c8 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -77,7 +77,7 @@ static bool fake_topology(struct topo_scan *tscan)
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
-	return tscan->c->cpuid_level < 1 || xen_pv_domain();
+	return tscan->c->cpuid_level < 1;
 }
 
 static void parse_topology(struct topo_scan *tscan, bool early)
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 8835d1c..8b045dd 100644
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
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 44706f0..27d1a5b 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -156,11 +156,9 @@ static void __init xen_pv_smp_config(void)
 
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

