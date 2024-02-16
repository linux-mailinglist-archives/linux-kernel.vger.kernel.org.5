Return-Path: <linux-kernel+bounces-68817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C38580AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62FA5B250EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2D13B280;
	Fri, 16 Feb 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWCmAuSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3xx8CL7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0E137C5E;
	Fri, 16 Feb 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096632; cv=none; b=mHsHbnvu3JL2QRr4CJVD2SN88oPCHSl+ZeIE5TMPdLgw3RKUIhrNodl/LQlJ/niJefYZ+pVPKXMv9i/D5lBLF6/20bdztSBIxIwY0waGjXWx3FpJhDYpDT6t61MGj4BlEOW5DVIIyJAIej3mWRz32wxBjcKYxtuYXAYXooRT2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096632; c=relaxed/simple;
	bh=wqnbccenWTssE7jb6dT91tsuNNHqNNXWwXmxYRD8CYE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kRPeibpHn2D/v7AQEduphMYnoWbI87z581ssKZJ6cEVSaVIA68Nh55Rb1WxEagAyZcLA5kMs46l0AD72S290zIIZCyIy3oJ+mc8q2ihUUzvMCj4KFGtcaPyk8nlmGRE2HWwOPQ7THIJ9rp7d2rzw69hJZYiQkiNS2piEsO94XZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWCmAuSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3xx8CL7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHKojW3GmVKz8LSkyL2Rlcy7Xcf4dNYoWgoN+rKWH3A=;
	b=AWCmAuSn3eDDFcrL64EOdqadl3VW+z1ibaetOdz5C0YSG9n4mLRY6Y4+eLzL7fyyspW5eg
	2E8dRXN6duDtA7Oa3FxmFVW4D6fSUW1OiY4HRAWpzqomr1Cmari5uoId32CdFrU98Wyf9g
	5zMukBJ8pF2xmONwZD2uRYTECaGVJm25+arRrJiaVIp1YfSRAQcTmfsUv7gw+TIffTkWuI
	xE+R5efkJdmXDqMucsAb3KOh5waLyHkqXSKrl9HHTPBuASZ0umsb6l1iukRW4l6Xek9Xpr
	tZxYOW7FwrOBlOP6Cuav3i0Y8IGPiS7X3KtyhkztabTapLcKG8p0ItMmgEa7DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHKojW3GmVKz8LSkyL2Rlcy7Xcf4dNYoWgoN+rKWH3A=;
	b=Q3xx8CL7L+2fdziCHTYVYR2E6nFoRu/VR5kNu1vrDaTkk7PJseOY1PtzFAZKyu+mZ/C/jz
	zrmeixvY3XyqMHAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/acpi: Use new APIC registration functions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.664738831@linutronix.de>
References: <20240213210251.664738831@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662825.398.15564953742200532798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ff37b09c8495ed897ea470014d1461660db6a942
Gitweb:        https://git.kernel.org/tip/ff37b09c8495ed897ea470014d1461660db6a942
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/acpi: Use new APIC registration functions

Use the new topology registration functions and make the early boot code
path __init. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.664738831@linutronix.de



---
 arch/x86/kernel/acpi/boot.c | 44 +++++-------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 85a3ce2..42799d5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -164,33 +164,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
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
@@ -844,12 +820,10 @@ static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
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

