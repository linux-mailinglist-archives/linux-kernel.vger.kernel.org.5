Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1953477685F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHITOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjHITNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657AB30F9;
        Wed,  9 Aug 2023 12:12:55 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MXwcVDDBW7sqU63OU7EilLSmlL9E7utdV3gPELnQmJo=;
        b=o0rzwTz2S5TfAMabCVr3L7x/Tj5EAkKsUY9O5iyj4V5P/4rYerraWI3iEXOsiycwZTRR2u
        Yp+yJtAaVKdPO+DzB/U3RpkV4Wu7YGrxNajdgmtxKLgVL4Cw7W5OomKpkszTCq1RQsVip9
        CHdAF4iK4LPTVZiTCj3T4J2KKU+Nl0W0wretTIS9o7MtJtaC3ma+nU7GB3bL7CupIstDU2
        WynBDXUZvPgG8EDy4ekB4BE+e1fOAWJ0ZBbcnXWNZ0GjY4Ty/5xFg1qMa0Y0JUDy30NZqM
        L9Rc/QKzYpgAZ0HX31RRg5u68EL2obg3vg+bmuPf1eKxxxs7XHGDb0xOjqViXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MXwcVDDBW7sqU63OU7EilLSmlL9E7utdV3gPELnQmJo=;
        b=F1sJ9EG5Sf8qfiRaNRIk0SMEghcMG3qFVs12Zpspz2XqoIEqmujuc2OlrijN5K/oH+8bnX
        0dj9kvCoq6J1f7CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Rename disable_apic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834951.27769.4037911057470052100.tip-bot2@tip-bot2>
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

Commit-ID:     49062454a3eb4a27add7a3df57e7a34266f6a760
Gitweb:        https://git.kernel.org/tip/49062454a3eb4a27add7a3df57e7a34266f6a760
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:16 -07:00

x86/apic: Rename disable_apic

It reflects a state and not a command. Make it bool while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
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
