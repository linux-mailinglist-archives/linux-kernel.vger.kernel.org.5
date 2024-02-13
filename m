Return-Path: <linux-kernel+bounces-64261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE1853CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AD02853E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67B62160;
	Tue, 13 Feb 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0XAlcCZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0vq0FNi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27461687
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858295; cv=none; b=hmlnYYvUV2ovh6cAI8Z7zNTfwNvYR8kYpFKAQTSCU0Lb2gwjFX4tuPMb9z0DLRBlhxI1u9/fJ2D64UecprID4wubBCYS3QwFaJn7amiYzhGCjua+BlXClW9MX//ncmg2LYn2yaxrJJ9MSY2HKYJG7PGiqYRW3xngSbrAeL2+qFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858295; c=relaxed/simple;
	bh=3awkOOoO8G9BJISNINVkNbJtDYkDqRW7NjVuJ0C6ZNA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bXrnzjwE1DuUjFerQeyCz9YT0+D+uhtItKNBnaLY40AHgHU0nmBtCxWqqvdwb7sbCz5dSKFDrHHj0DKH5xhBdKctivMERiGZ7SqrT6oshjQymm2YTghW9iY3VPfMRKvxg8WA/B2nCiK9dA7YfUHy6CCoVDovUPgOEomQr8+AtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0XAlcCZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0vq0FNi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154638.867699078@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p1hwX9LEu/e1+Ot1b5cejKkCoScMTR5JGuQ827RCDFo=;
	b=0XAlcCZyuOa8v7jWBN/5z2layZSVZc6d0B5W9uHypJJNA+T38IBMxO+qHuIsNcSuEHtG1p
	1wj0dHk8lFwt1XyjMGLbuUVWb9ik2wafUp0DQuOnJdUO80Do5S5bEPmpn3382OtwNQ0CB/
	XOKfHdeMXgZ2gOJzPdtwoMUAj13qcTOTzrFSt4aVr7mrw10wY07ExpowNPJ/UKozOFfokk
	yhHDtegU5KGixeY0A5L3hAa3MtpY4k4URgWqbEk34cKsuWSZsJIQYo/vIhwnUA68y9Erzf
	Lhuogx/yp78O/8HZq+pbjTn5BvAa10AtxRulOvExN6tsNU+GLKacw7qDagvnfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=p1hwX9LEu/e1+Ot1b5cejKkCoScMTR5JGuQ827RCDFo=;
	b=f0vq0FNiLDIk6lHL1E56iHaU8Pzkz7cd0ngfJjidXgooWtThEbtG7rjKaLo3XpENkyEdoH
	coiugVsjEmBAEwCg==
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
Subject: [patch V3 01/22] x86/cpu/topology: Make the APIC mismatch warnings
 complete
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:52 +0100 (CET)

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
@@ -1716,22 +1716,11 @@ static void generic_identify(struct cpui
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
@@ -1923,7 +1912,7 @@ void identify_secondary_cpu(struct cpuin
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


