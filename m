Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331587763EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjHIPfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjHIPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59C210A;
        Wed,  9 Aug 2023 08:34:21 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iYnoxAnC8XL9TfWuoJ7PzLPdLQN0d9Qk9yev9e3LHac=;
        b=TTYDWf4ddGnB/COAe3jhe+lTqiwcqH1aLthPvngqU0JsmO/x6sfX6GtzQ3cWylpU3rP7am
        nKbGLMY2NRppSTjelPpKNJPpQC3dFJKjkUOphZ/uudpj363LCwu9AljXD0/Bbl0sBjNZ/A
        7d4Oy5SNTDTnvLHOY0XfhsNuyZfAU8V8yDPbxj2Dl8U8g8pfL766Yu6Oykv6kLMnb1sWNB
        Ztduz1gXA8Pa+06ElBLwtsCyD38OLFejC8/iz8R7KkgNwP2NwHJdUKcxMPb1OXfL3tkDBx
        G+NLZKuEUlW3Uzrrd8n7G0bBvaTIr4vh82urKPWuyxG+uSDG7IoZVKtQAd9a5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iYnoxAnC8XL9TfWuoJ7PzLPdLQN0d9Qk9yev9e3LHac=;
        b=6XsYpMhkoSVpD4Mdf2FLZX6zntMAXDLUW27/oecCTjXsH3uwbehdLRLdSUUZVl2TGJt0eR
        YnY3RB18IVJrqJDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Rename disable_apic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525944.27769.12829019706345454480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5214126b38b852bdf84656353e9f70ecacb09703
Gitweb:        https://git.kernel.org/tip/5214126b38b852bdf84656353e9f70ecacb09703
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:10 -07:00

x86/apic: Rename disable_apic

It reflects a state and not a command. Make it bool while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h      |  4 ++--
 arch/x86/kernel/apic/apic.c      | 22 +++++++++++-----------
 arch/x86/kernel/apic/apic_noop.c |  6 +++---
 arch/x86/kernel/apic/msi.c       |  2 +-
 arch/x86/kernel/apic/vector.c    |  2 +-
 arch/x86/kernel/setup.c          |  2 +-
 arch/x86/pci/xen.c               |  2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 98c32aa..4b1110a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -52,7 +52,7 @@ static inline void generic_apic_probe(void)
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
-extern int disable_apic;
+extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
 
 extern int cpuid_to_apicid[];
@@ -90,7 +90,7 @@ static inline void default_inquire_remote_apic(int apicid)
  */
 static inline bool apic_from_smp_config(void)
 {
-	return smp_found_config && !disable_apic;
+	return smp_found_config && !apic_is_disabled;
 }
 
 /*
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index af49e24..a9dd903 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -180,7 +180,7 @@ __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
 unsigned long mp_lapic_addr __ro_after_init;
-int disable_apic __ro_after_init;
+bool apic_is_disabled __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
 /* Local APIC timer works in C2 */
@@ -810,7 +810,7 @@ bool __init apic_needs_pit(void)
 		return true;
 
 	/* Is there an APIC at all or is it disabled? */
-	if (!boot_cpu_has(X86_FEATURE_APIC) || disable_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC) || apic_is_disabled)
 		return true;
 
 	/*
@@ -1299,7 +1299,7 @@ enum apic_intr_mode_id apic_intr_mode __ro_after_init;
 static int __init __apic_intr_mode_select(void)
 {
 	/* Check kernel option */
-	if (disable_apic) {
+	if (apic_is_disabled) {
 		pr_info("APIC disabled via kernel command line\n");
 		return APIC_PIC;
 	}
@@ -1308,7 +1308,7 @@ static int __init __apic_intr_mode_select(void)
 #ifdef CONFIG_X86_64
 	/* On 64-bit, the APIC must be integrated, Check local APIC only */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		pr_info("APIC disabled by BIOS\n");
 		return APIC_PIC;
 	}
@@ -1317,14 +1317,14 @@ static int __init __apic_intr_mode_select(void)
 
 	/* Neither 82489DX nor integrated APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC) && !smp_found_config) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		return APIC_PIC;
 	}
 
 	/* If the BIOS pretends there is an integrated APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC) &&
 		APIC_INTEGRATED(boot_cpu_apic_version)) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		pr_err(FW_BUG "Local APIC %d not detected, force emulation\n",
 				       boot_cpu_physical_apicid);
 		return APIC_PIC;
@@ -1567,7 +1567,7 @@ static void setup_local_APIC(void)
 	int cpu = smp_processor_id();
 	unsigned int value;
 
-	if (disable_apic) {
+	if (apic_is_disabled) {
 		disable_ioapic_support();
 		return;
 	}
@@ -1943,7 +1943,7 @@ void __init check_x2apic(void)
 	pr_err("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2APIC.\n");
 	pr_err("Disabling APIC, expect reduced performance and functionality.\n");
 
-	disable_apic = 1;
+	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 }
 
@@ -2037,7 +2037,7 @@ int __init apic_force_enable(unsigned long addr)
 {
 	u32 h, l;
 
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -1;
 
 	/*
@@ -2064,7 +2064,7 @@ int __init apic_force_enable(unsigned long addr)
 static int __init detect_init_APIC(void)
 {
 	/* Disabled by kernel option? */
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -1;
 
 	switch (boot_cpu_data.x86_vendor) {
@@ -2919,7 +2919,7 @@ int apic_is_clustered_box(void)
  */
 static int __init setup_disableapic(char *arg)
 {
-	disable_apic = 1;
+	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 	return 0;
 }
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index fe78319..f310dc2 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -71,13 +71,13 @@ static int noop_apic_id_registered(void)
 
 static u32 noop_apic_read(u32 reg)
 {
-	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 	return 0;
 }
 
-static void noop_apic_write(u32 reg, u32 v)
+static void noop_apic_write(u32 reg, u32 val)
 {
-	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 35d5b8f..6b6b711 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -269,7 +269,7 @@ static const struct msi_parent_ops x86_vector_msi_parent_ops = {
 
 struct irq_domain * __init native_create_pci_msi_domain(void)
 {
-	if (disable_apic)
+	if (apic_is_disabled)
 		return NULL;
 
 	x86_vector_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 01c359a..04655b7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -547,7 +547,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	struct irq_data *irqd;
 	int i, err, node;
 
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -ENXIO;
 
 	/*
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4..a5ef400 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1020,7 +1020,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
-		disable_apic = 1;
+		apic_is_disabled = true;
 #endif
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 014c508..652cd53 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -517,7 +517,7 @@ int __init pci_xen_init(void)
 #ifdef CONFIG_PCI_MSI
 static void __init xen_hvm_msi_init(void)
 {
-	if (!disable_apic) {
+	if (!apic_is_disabled) {
 		/*
 		 * If hardware supports (x2)APIC virtualization (as indicated
 		 * by hypervisor's leaf 4) then we don't need to use pirqs/
