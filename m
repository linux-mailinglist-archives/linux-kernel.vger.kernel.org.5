Return-Path: <linux-kernel+bounces-35345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C44838F95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4964E1C20E68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3F62807;
	Tue, 23 Jan 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxDs/roc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjfiEL4S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE661694
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015457; cv=none; b=LYTMiH8PSevRQqWXTFp6miARbXvCSehxsblnXbcoCu/yowrxV7ujNKGlAiCffKWB592KBKeL87bgljMTusFD1JVQga5gVEBQ29JsewY2/2VsFHOC1EM+v0NL07D3Tt9wr2iM9UoGrZKr3nJszmKlnA4cpVdB2ZWTh9FY3nuCBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015457; c=relaxed/simple;
	bh=PwaE2HACFCDykj/yrcUgOvhSX8G9pW7cBDNkwdCX7Zs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rKwDH5+lYTA1EMs9Zyhl4tk3anmexaViC7yyB+caX52GPt4HkyfQkJZXopiTceNVpN3QgB4JsYBlawJArGorL4qTELWUPp4l35FtDZ9u0rRQ2o9fmZntO/B1lgF59PQCktE9GTo2voP20QPc9XdEMP5NYXQnLPY87rS6W4uIOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxDs/roc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjfiEL4S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.722879332@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u90NYRT/ZphVmVk3QeLAx65kqZq+Kn/J4FFlTTjOKYY=;
	b=kxDs/rocR0TOrKjLmasrpQ+VJegqjYOGjvJ2NmtacOW/fuGynZWyCQDiv5YvZDIpWh0osa
	zrCb2cx/lO9ZJWtPapNA1yiqnxNhbuBehpoBJDd8M44IgZQEFk02wlYfxfGz3F37hUoafe
	kXQXkpGitGE4PSWGy1ftW4GNV0RIzN9sV4ywChVahLAFYoGQD3WD9MlCf+anjyj34h4ow1
	ICCNWRf1UEgoZsp7VVnkgdEMFuAGvWjeyBZC9phJf92tl4GY3EX8mvP9M3l0YnLJKXEiU0
	qnPy6gBq392UFp0zDthhZUMz+eP3eZNErtswHm/m+qvAhBfoT3lBAKXvUCgabA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u90NYRT/ZphVmVk3QeLAx65kqZq+Kn/J4FFlTTjOKYY=;
	b=XjfiEL4SILgkYyJFEDNYXY95Bykqjalwo2YJ8aWpBkvhT1DcN2PONkttEvnB8DvtsiIG2I
	7tl5zgxFrk/Ax5BQ==
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
Subject: [patch v2 03/30] x86/acpi: Use new APIC registration functions
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:53 +0100 (CET)

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


