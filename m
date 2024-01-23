Return-Path: <linux-kernel+bounces-35319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FD838F72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E984F1F25CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177955EE95;
	Tue, 23 Jan 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAySKzRV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IK7kKJTs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE15D8E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015408; cv=none; b=ACAlLpZLF4PobCkavgfRTCpH062elaRpwAoEr0wbC05bwCXQVwh3I5ztYTe5ZbirMFNJKZpA64cRZoAXvOzj00gE5hgv/VlfD99X/uU7oYF/G7U73rjNCnPG62dAd2kd4rXQ3hAPXZtlv8WFmmWniV0zPe9ejE7891TIBPVmpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015408; c=relaxed/simple;
	bh=zithzGkCqNJB367BBEWSiQ+4P2EA2zr/ipn8U2Vqt8I=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bvyQog/fQvvoqWbL2Wl5MneB7rFM5OSU9bvxSU8hpqhAR2lyZFXs6RZjBhrrNWdnLZyOLKBvnhtcJaGz77wJd1pJQpds9Hvl/kgjj5vHpLQOElryNlPtdP6okVSbjzOJjFMz3I/euCcBtSILYTrDfv1iF0u3Fds1LIuXqyiPjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAySKzRV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IK7kKJTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.403342409@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZOO7+NN4xzTqgEXoDn63w0a/IxQXntDYLCJ8J9cgjBU=;
	b=DAySKzRV6HdCuyIWpx3teGuiU1+Q8+fx+b0nIMVtBOfkHLu0WB3CaXPW3Z9rvpNZUrJVd+
	uHSDW/kByB2GmXgEHtmYSdCeYkP3YReZY/1gWExxNCrQr0zP4PHi3sSRql5IHQjMxlUYle
	rHC5LyuG70WNldFVrKh4rDHkG1hrKns0rsaMY/pIe2JBg6NBW/7x6M9Rx4xrRqM0D1w5vY
	tYW6MjlxRw+aPg+DEcH0b07QwOdOIOr4zn25IdPIUcUIdDQFMcnei3Ag0DJ8M0Bs8CDBuN
	ApEpzJo3w5fjkgePKYCkORUOfb4P+V8NpazoxMGXtOmpU0I+2VtgEskKqcY7tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZOO7+NN4xzTqgEXoDn63w0a/IxQXntDYLCJ8J9cgjBU=;
	b=IK7kKJTsuqNf/N1XYkVczeHUEcBTOF2eVmOgXn4Umvkgt8LUIprMBMlDEqTXFauZ3UuYb3
	7yirfshHrah3+ECQ==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 01/22] x86/cpu/topology: Make the APIC mismatch warnings
 complete
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:04 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Detect all possible combinations of mismatch right in the CPUID evaluation
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h           |    5 ++---
 arch/x86/kernel/cpu/common.c          |   15 ++-------------
 arch/x86/kernel/cpu/topology_common.c |   12 ++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -46,16 +46,15 @@ extern void x86_32_probe_apic(void);
 static inline void x86_32_probe_apic(void) { }
 #endif
 
-#ifdef CONFIG_X86_LOCAL_APIC
+extern u32 cpuid_to_apicid[];
 
+#ifdef CONFIG_X86_LOCAL_APIC
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
 
-extern u32 cpuid_to_apicid[];
-
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
 	APIC_PIC,
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1715,22 +1715,11 @@ static void generic_identify(struct cpui
 #endif
 }
 
-/*
- * Validate that ACPI/mptables have the same information about the
- * effective APIC id and update the package map.
- */
-static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
+static void update_package_map(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int cpu = smp_processor_id();
-	u32 apicid;
 
-	apicid = apic->cpu_present_to_apicid(cpu);
-
-	if (apicid != c->topo.apicid) {
-		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->topo.initial_apicid);
-	}
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
@@ -1921,7 +1910,7 @@ void identify_secondary_cpu(struct cpuin
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	validate_apic_and_package_id(c);
+	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -177,6 +177,18 @@ void cpu_parse_topology(struct cpuinfo_x
 
 	parse_topology(&tscan, false);
 
+	if (IS_ENABLED(CONFIG_X86_LOCAL_APIC)) {
+		if (c->topo.initial_apicid != c->topo.apicid) {
+			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
+			       cpu, c->topo.initial_apicid, c->topo.apicid);
+		}
+
+		if (c->topo.apicid != cpuid_to_apicid[cpu]) {
+			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
+			       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
+		}
+	}
+
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
 		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
 			continue;


