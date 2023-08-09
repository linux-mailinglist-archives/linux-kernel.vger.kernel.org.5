Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BD77657F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHIQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjHIQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844F91FCC;
        Wed,  9 Aug 2023 09:49:33 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OFs3NMhd5gzi5ueDtVWTqkP7VuFvuvi5oFckrMFgPnM=;
        b=f1VCqKNME+BfIRUb9nTJB8Q4f8lAoBQlWxR9lhCzKRhr4dyAtvgR+fgqqAcw61E3MOh81h
        hKY3fxtTSB1xsNUmj+KjU7ZFgKNl3GyWEWW57r5bSiMgfJtKoq6m1zwxwMCKnziRdINecW
        F34PO1mNH9CbS4KcTqfVKeyb4N7iCM3ZhZqmM+VnaJ/2CtSQbB552EOHVPr6HUVp3jUYBJ
        KswZRgf6pX7iZ1leo3ny24LH0WMXg0IHdbXMViE1lQWYHkf2gmz86g+zJJpGfxd0obQ2jU
        Ze3VXDYUE76mNeiEzDlxhCeYy42H/GCPt/2kvjl/RwDoFQBp3h0PX92gDQk6+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599772;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OFs3NMhd5gzi5ueDtVWTqkP7VuFvuvi5oFckrMFgPnM=;
        b=O1E07jyxsPVmxRW6SKbORI+lsLY7+uICgccHm/JXLjEySCq6SazT9mTCrBjDj0mMYWeBRK
        Geg0fznMUgohlqAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/ipi: Tidy up the code and fixup comments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159977164.27769.5654893944215049912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1584514b72d612abd3343e98167fc09033e208d9
Gitweb:        https://git.kernel.org/tip/1584514b72d612abd3343e98167fc09033e208d9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic/ipi: Tidy up the code and fixup comments

Replace the undecodable comment on top of the function, replace the space
consuming zero content comments with useful ones and tidy up the
implementation to prevent further eye bleed.

Make __default_send_IPI_shortcut() static as it has no other users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/ipi.c   | 74 +++++++++++++++--------------------
 arch/x86/kernel/apic/local.h |  2 +-
 2 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 2ff9cf9..614ac55 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -108,68 +108,58 @@ static inline void __xapic_wait_icr_idle(void)
 		cpu_relax();
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
+/*
+ * This is safe against interruption because it only writes the lower 32
+ * bits of the APIC_ICR register. The destination field is ignored for
+ * short hand IPIs.
+ *
+ *  wait_icr_idle()
+ *  write(ICR2, dest)
+ *  NMI
+ *	wait_icr_idle()
+ *	write(ICR)
+ *	wait_icr_idle()
+ *  write(ICR)
+ *
+ * This function does not need to disable interrupts as there is no ICR2
+ * interaction. The memory write is direct except when the machine is
+ * affected by the 11AP Pentium erratum, which turns the plain write into
+ * an XCHG operation.
+ */
+static void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
-	 * Subtle. In the case of the 'never do double writes' workaround
-	 * we have to lock out interrupts to be safe.  As we don't care
-	 * of the value read we use an atomic rmw access to avoid costly
-	 * cli/sti.  Otherwise we use an even cheaper single atomic write
-	 * to the APIC.
-	 */
-	unsigned int cfg;
-
-	/*
-	 * Wait for idle.
+	 * Wait for the previous ICR command to complete.  Use
+	 * safe_apic_wait_icr_idle() for the NMI vector as there have been
+	 * issues where otherwise the system hangs when the panic CPU tries
+	 * to stop the others before launching the kdump kernel.
 	 */
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
 		__xapic_wait_icr_idle();
 
-	/*
-	 * No need to touch the target chip field. Also the destination
-	 * mode is ignored when a shorthand is used.
-	 */
-	cfg = __prepare_ICR(shortcut, vector, 0);
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	native_apic_mem_write(APIC_ICR, cfg);
+	/* Destination field (ICR2) and the destination mode are ignored */
+	native_apic_mem_write(APIC_ICR, __prepare_ICR(shortcut, vector, 0));
 }
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).
  */
-void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest)
+void __default_send_IPI_dest_field(unsigned int dest_mask, int vector,
+				   unsigned int dest_mode)
 {
-	unsigned long cfg;
-
-	/*
-	 * Wait for idle.
-	 */
+	/* See comment in __default_send_IPI_shortcut() */
 	if (unlikely(vector == NMI_VECTOR))
 		safe_apic_wait_icr_idle();
 	else
 		__xapic_wait_icr_idle();
 
-	/*
-	 * prepare target chip field
-	 */
-	cfg = __prepare_ICR2(mask);
-	native_apic_mem_write(APIC_ICR2, cfg);
-
-	/*
-	 * program the ICR
-	 */
-	cfg = __prepare_ICR(0, vector, dest);
-
-	/*
-	 * Send the IPI. The write to APIC_ICR fires this off.
-	 */
-	native_apic_mem_write(APIC_ICR, cfg);
+	/* Set the IPI destination field in the ICR */
+	native_apic_mem_write(APIC_ICR2, __prepare_ICR2(dest_mask));
+	/* Send it with the proper destination mode */
+	native_apic_mem_write(APIC_ICR, __prepare_ICR(0, vector, dest_mode));
 }
 
 void default_send_IPI_single_phys(int cpu, int vector)
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 0c47711..5b0a0e7 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -44,8 +44,6 @@ static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 
 void default_init_apic_ldr(void);
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
-
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
  * specified in bits 56 to 63 of the ICR).
