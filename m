Return-Path: <linux-kernel+bounces-68841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A78580E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58CE1C22D64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8314E2D6;
	Fri, 16 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gszsz3Nq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="km4hko4p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6914C58D;
	Fri, 16 Feb 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096649; cv=none; b=hC0yY8XEzrOnRK492gGkCHr1qhIDKFsyORKa/18Xl05D7Q3Q5VgSthyqbdrveWHVFzWtHYgtG4MJgjax1fze3kNYqxegf8zlWigNGCEpxyfZ7Xm/HAQ6bsLv4HUX576XFUwWYeqe03Cz/sXoMb9EvVoc9tHn5y9Jodl7VqJbv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096649; c=relaxed/simple;
	bh=oCNrqi6YLVqsC49hndzWduzzzIdR5RO5dvFJXVkE1xk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p4VvdohoVskQY94nmkdUAsXYHfyzvG8aLo7SxLmoRr4R+917FQWN2E4+4bkYo5MvigbRJsCYgwcg0GWLyStBmXgF8Q+Sy+sQMXTPCgq2uU6YyFwyFFQ0MbNwFPiyf/4DJpXX7zDgbjePuh8nao2yEDXlaxDG/XD6tZzb7LcvbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gszsz3Nq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=km4hko4p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vHMzDcvGoW40HWXMMzL98dkTDeSlr81RiEj5oza8wg=;
	b=Gszsz3NqkLJC3CQWztjNwzYAKKsxAoIXhUHjmYDF8E5HfIViC3m25UcszDVGqfO8Sa8UNK
	q0Ai3nRy9vdT4xTOBs+lGIIC6EIEebvLtteqS6CE96PStVxKVIZwvgxdiUThP1mzTC5f3P
	NKa/cYF2t5vwyKqWgOB7kLWe6vFN1hYScySOpGwiO7BSmaJPURJ2L4irCFyE9GSkqfcVAn
	hqUt2P4FPjk40CdMEsh9PNRxwof3xr3vXjl9vF5jwHfMOZKCNILsCp8CKazB0fa8Dy9IJX
	vetpDWUJeYqoAzS/azkGeiWFxAHfBaNVRv5wVPcxCAVUjFibj9B2K1UL5j20yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vHMzDcvGoW40HWXMMzL98dkTDeSlr81RiEj5oza8wg=;
	b=km4hko4pNlGshN/8jcO3hhvib7PG+E94MewIG+AmETv3K1o4NhKQ/7Z+9Zq8eg8J4bA+Lp
	L773ribmqS05HKBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Make the APIC mismatch warnings complete
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154638.867699078@linutronix.de>
References: <20240212154638.867699078@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664416.398.11582676369485509436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     52128a7a21f79d5d0be62f10cb0b73d115ab492e
Gitweb:        https://git.kernel.org/tip/52128a7a21f79d5d0be62f10cb0b73d115ab492e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/cpu/topology: Make the APIC mismatch warnings complete

Detect all possible combinations of mismatch right in the CPUID evaluation
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154638.867699078@linutronix.de



---
 arch/x86/include/asm/apic.h           |  5 ++---
 arch/x86/kernel/cpu/common.c          | 15 ++-------------
 arch/x86/kernel/cpu/topology_common.c | 12 ++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 80d6383..6c5cffc 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 33064e6..b221e14 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1716,22 +1716,11 @@ static void generic_identify(struct cpuinfo_x86 *c)
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
@@ -1923,7 +1912,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	validate_apic_and_package_id(c);
+	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index afea34d..3876a33 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -177,6 +177,18 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 
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

