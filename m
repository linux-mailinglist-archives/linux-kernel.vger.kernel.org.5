Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21709776856
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjHITOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjHITNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA030F4;
        Wed,  9 Aug 2023 12:12:54 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dVgVTUAoh1BK44Kkv8nO2eoQb496E1j95WjsiDi/76Q=;
        b=d8Zei5YGokUS9g+y/3V9eMCmLrWrhDnSdGLAQvqKi2sXuhAAQQKSkCyQ8NJu3PHBxsuMak
        RAtOs5HsQPi4PD9XKENEUTQ9reYLmSvZ8vs8a96ezkpGIoTZzS0q0VSfRB3Xqmv2qwUPee
        8GQtL9kcfQA+/XlGDlwB6NmzSo3W2QQ8fV8kR7HqOG3pv4HJ4XGWQku3BFClCT8TNkRE+3
        1KtcBTPoEQgvbb7v1DDtKH8hD0bHWp0lKtvrJYWpQ6XvlYCRPOM5aaFyfsvPmldLLe80L4
        da+eJ6bDitRWWdygYl7SmjhevGGVA7JEeOgw54A8x3zLyVXeYhIVgIS2X09gBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dVgVTUAoh1BK44Kkv8nO2eoQb496E1j95WjsiDi/76Q=;
        b=C0CxyfmcvDqaN3HYeVRDPjyGYKfS7xybtH9kozGdRbNniOZJqoZQ/hdpA8MJFfRQ8W9Tp3
        Hm+X13NJobn7i2AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove pointless x86_bios_cpu_apicid
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834860.27769.3962806241553688721.tip-bot2@tip-bot2>
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

Commit-ID:     d23c977fb0785bd32dd54f0a3d24e003942b00a6
Gitweb:        https://git.kernel.org/tip/d23c977fb0785bd32dd54f0a3d24e003942b00a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:42 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:17 -07:00

x86/apic: Remove pointless x86_bios_cpu_apicid

It's a useless copy of x86_cpu_to_apicid.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h        | 2 --
 arch/x86/include/asm/smp.h         | 1 -
 arch/x86/kernel/apic/apic.c        | 5 +----
 arch/x86/kernel/apic/apic_common.c | 2 +-
 arch/x86/kernel/apic/bigsmp_32.c   | 2 +-
 arch/x86/kernel/apic/probe_64.c    | 4 +---
 arch/x86/kernel/setup_percpu.c     | 3 ---
 7 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 4b1110a..36f0be7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -477,8 +477,6 @@ extern void generic_bigsmp_probe(void);
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
-
 extern struct apic apic_noop;
 
 static inline unsigned int read_apic_id(void)
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 600cf25..1db6faa 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -22,7 +22,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid);
 #endif
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index cffec1f..8af0ec8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -108,10 +108,8 @@ unsigned long apic_mmio_base __ro_after_init;
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid, BAD_APICID);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_bios_cpu_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
 #ifdef CONFIG_X86_32
@@ -2511,7 +2509,7 @@ int generic_processor_info(int apicid, int version)
 
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
-		 * x86_bios_cpu_apicid is required to have processors listed
+		 * x86_cpu_to_apicid is required to have processors listed
 		 * in same order as logical cpu numbers. Hence the first
 		 * entry is BSP, and so on.
 		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
@@ -2548,7 +2546,6 @@ int generic_processor_info(int apicid, int version)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
-	early_per_cpu(x86_bios_cpu_apicid, cpu) = apicid;
 #endif
 #ifdef CONFIG_X86_32
 	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 02b4839..e892506 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -29,7 +29,7 @@ void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
 int default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
-		return (int)per_cpu(x86_bios_cpu_apicid, mps_cpu);
+		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
 	else
 		return BAD_APICID;
 }
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 77555f6..628b008 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -52,7 +52,7 @@ static void bigsmp_setup_apic_routing(void)
 static int bigsmp_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids)
-		return (int) per_cpu(x86_bios_cpu_apicid, mps_cpu);
+		return (int) per_cpu(x86_cpu_to_apicid, mps_cpu);
 
 	return BAD_APICID;
 }
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f..3c0c8d3 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,9 +13,7 @@
 
 #include "local.h"
 
-/*
- * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
- */
+/* Select the appropriate APIC driver */
 void __init default_setup_apic_routing(void)
 {
 	struct apic **drv;
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index c242dc4..f6767d2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -181,8 +181,6 @@ void __init setup_per_cpu_areas(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 		per_cpu(x86_cpu_to_apicid, cpu) =
 			early_per_cpu_map(x86_cpu_to_apicid, cpu);
-		per_cpu(x86_bios_cpu_apicid, cpu) =
-			early_per_cpu_map(x86_bios_cpu_apicid, cpu);
 		per_cpu(x86_cpu_to_acpiid, cpu) =
 			early_per_cpu_map(x86_cpu_to_acpiid, cpu);
 #endif
@@ -214,7 +212,6 @@ void __init setup_per_cpu_areas(void)
 	/* indicate the early static arrays will soon be gone */
 #ifdef CONFIG_X86_LOCAL_APIC
 	early_per_cpu_ptr(x86_cpu_to_apicid) = NULL;
-	early_per_cpu_ptr(x86_bios_cpu_apicid) = NULL;
 	early_per_cpu_ptr(x86_cpu_to_acpiid) = NULL;
 #endif
 #ifdef CONFIG_X86_32
