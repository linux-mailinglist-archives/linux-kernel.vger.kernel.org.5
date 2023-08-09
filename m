Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6E776576
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHIQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjHIQtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037731FCC;
        Wed,  9 Aug 2023 09:49:31 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9DRlMd6dGzM/4XEmIyUphM8I9Tgh4ZcIpPqm6yUoKo0=;
        b=kKR21BRHkRBULkKXZqfICEVVMEv+34WParQjYFMquAaxDENUe9Y/mJjwvSDKBXYcdFb307
        CSed2HGaoAjdc2vYJumAy5KVdSX4rBFKmKMW8cg0b+5xPWbbdgvToNs1DzfIv9iH/CPBqZ
        GSTjQLjXOHYI5uuQLqrd3gRVfRetb4tAPrlMB/0B0PlSMw0ALUcvhyMQXRpyefILJCN1eT
        /iSCI3rc7f0+zfXFyEvRfKP1fo1k2JqNVQMy2jPV7ENRcpJfIvxY7tDmbg5jbgWC6/q/HF
        sN2qagdvD6s+gdcwpFT8VdyoAm8F1L9On/cc5Iv2ci6NklxIWT4N925DJTh2sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9DRlMd6dGzM/4XEmIyUphM8I9Tgh4ZcIpPqm6yUoKo0=;
        b=Ot2sEmNsxRIvEkw7ATvdLLQVbAWyT0JASaOSogJgxhs4HbbQHeP+019Mg0i5eehsP/BHS8
        v6pz/F2OSFes2oCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Move safe wait_icr_idle() next to
 apic_mem_wait_icr_idle()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159976980.27769.15512341418119100114.tip-bot2@tip-bot2>
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

Commit-ID:     97b9d715efd4979fda58a300689e09e5dbbbd975
Gitweb:        https://git.kernel.org/tip/97b9d715efd4979fda58a300689e09e5dbbbd975
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:06 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic: Move safe wait_icr_idle() next to apic_mem_wait_icr_idle()

Move it next to apic_mem_wait_icr_idle(), rename it so that it's clear what
it does and rewrite it in readable form.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h         |  1 -
 arch/x86/kernel/apic/apic.c         | 17 -----------------
 arch/x86/kernel/apic/apic_flat_64.c |  4 ++--
 arch/x86/kernel/apic/bigsmp_32.c    |  2 +-
 arch/x86/kernel/apic/ipi.c          | 19 +++++++++++++++++--
 arch/x86/kernel/apic/local.h        |  1 +
 arch/x86/kernel/apic/probe_32.c     |  2 +-
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index dd0a05d..49b6c7e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,7 +98,6 @@ static inline u32 native_apic_mem_read(u32 reg)
 	return *((volatile u32 *)(APIC_BASE + reg));
 }
 
-extern u32 native_safe_apic_wait_icr_idle(void);
 extern void native_apic_icr_write(u32 low, u32 id);
 extern u64 native_apic_icr_read(void);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ab26a61..80a31f2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -240,23 +240,6 @@ static void __init apic_disable(void)
 	apic = &apic_noop;
 }
 
-u32 native_safe_apic_wait_icr_idle(void)
-{
-	u32 send_status;
-	int timeout;
-
-	timeout = 0;
-	do {
-		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
-		if (!send_status)
-			break;
-		inc_irq_stat(icr_read_retry_count);
-		udelay(100);
-	} while (timeout++ < 1000);
-
-	return send_status;
-}
-
 void native_apic_icr_write(u32 low, u32 id)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 57d3afb..1da865f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -112,7 +112,7 @@ static struct apic apic_flat __ro_after_init = {
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 /*
@@ -188,7 +188,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 /*
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 57077fc..32984bf 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -109,7 +109,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 bool __init apic_bigsmp_possible(bool cmdline_override)
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index e0e0567..460df02 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/smp.h>
+
 #include <asm/io_apic.h>
 
 #include "local.h"
@@ -102,6 +104,19 @@ static inline int __prepare_ICR2(unsigned int mask)
 	return SET_XAPIC_DEST_FIELD(mask);
 }
 
+u32 apic_mem_wait_icr_idle_timeout(void)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < 1000; cnt++) {
+		if (!(apic_read(APIC_ICR) & APIC_ICR_BUSY))
+			return 0;
+		inc_irq_stat(icr_read_retry_count);
+		udelay(100);
+	}
+	return APIC_ICR_BUSY;
+}
+
 void apic_mem_wait_icr_idle(void)
 {
 	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
@@ -135,7 +150,7 @@ static void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 	 * to stop the others before launching the kdump kernel.
 	 */
 	if (unlikely(vector == NMI_VECTOR))
-		safe_apic_wait_icr_idle();
+		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
 
@@ -152,7 +167,7 @@ void __default_send_IPI_dest_field(unsigned int dest_mask, int vector,
 {
 	/* See comment in __default_send_IPI_shortcut() */
 	if (unlikely(vector == NMI_VECTOR))
-		safe_apic_wait_icr_idle();
+		apic_mem_wait_icr_idle_timeout();
 	else
 		apic_mem_wait_icr_idle();
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 2eb49d4..98cfe78 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -45,6 +45,7 @@ static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 void default_init_apic_ldr(void);
 
 void apic_mem_wait_icr_idle(void);
+u32 apic_mem_wait_icr_idle_timeout(void);
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 52f3c6f..a861a77 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -65,7 +65,7 @@ static struct apic apic_default __ro_after_init = {
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
+	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
 apic_driver(apic_default);
