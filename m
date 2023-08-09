Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7864776A49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHIUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AC2683;
        Wed,  9 Aug 2023 13:36:15 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SQaraEsbSixXoPnRx04X9hn4T2+ucJufNUse7jO/W+Y=;
        b=LZmdt7FzPYPnopC6gEt3PjRGca4XrEo7YKDpx4SyVeLZ2ZBWDUshY8HhoRWZ3BL+woJZDq
        zmtATF2IqkJPgIsZuANwrpOPbktJ6MvLiV5JeL4T1ta55nkJ/Fd1f+u6mFdF5r7uW6lufR
        F3Cg4YDEFq2tkuMAmlf62vOWnnMnRdyYWGpA3EZquaQSlkkqwxIRZgsFqSW+FG5ATn1bTm
        VWrxjjI5F/5uQhJvOWxLpUpCqMQlsLgpP/FL2jCNfXIUIBt2N3t79JEEKQVZU3jr5rEIjZ
        2P+8oV+YoKhOyzxH8GI1kqPomfYHh5UT4/rgvtRs1CsYm44ZoHnih4X4PLf49Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SQaraEsbSixXoPnRx04X9hn4T2+ucJufNUse7jO/W+Y=;
        b=vewH+6vINzIaRQr16xr+LNA1e3zCfDlvlF+cD04mO4c+7K5zrARgOjt7rfHR49yaokU04P
        r0O4q433T8PjKTDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/x2apic: Share all common IPI functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337366.27769.13093753809701907931.tip-bot2@tip-bot2>
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

Commit-ID:     96ae35c75bdd8a327c686cf39030d8ed7f82f558
Gitweb:        https://git.kernel.org/tip/96ae35c75bdd8a327c686cf39030d8ed7f82f558
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:29 -07:00

x86/apic/x2apic: Share all common IPI functions

Yet more copy and pasta gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/local.h          |  4 +-
 arch/x86/kernel/apic/x2apic_cluster.c | 10 +------
 arch/x86/kernel/apic/x2apic_phys.c    | 44 +++++++++++++-------------
 arch/x86/kernel/apic/x2apic_uv_x.c    | 14 +-------
 4 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 98cfe78..a250675 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -19,8 +19,10 @@ void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
 int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+
+void x2apic_send_IPI_all(int vector);
+void x2apic_send_IPI_allbutself(int vector);
 void x2apic_send_IPI_self(int vector);
-void __x2apic_send_IPI_shorthand(int vector, u32 which);
 
 /* IPI */
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 355da47..afd2676 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -83,16 +83,6 @@ x2apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
 	__x2apic_send_IPI_mask(mask, vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_allbutself(int vector)
-{
-	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
-}
-
-static void x2apic_send_IPI_all(int vector)
-{
-	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
-}
-
 static u32 x2apic_calc_apicid(unsigned int cpu)
 {
 	return x86_cpu_to_logical_apicid[cpu];
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 2c9a884..c40d19b 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -81,16 +81,36 @@ static void
 	__x2apic_send_IPI_mask(mask, vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_allbutself(int vector)
+static void __x2apic_send_IPI_shorthand(int vector, u32 which)
+{
+	unsigned long cfg = __prepare_ICR(which, vector, 0);
+
+	/* x2apic MSRs are special and need a special fence: */
+	weak_wrmsr_fence();
+	native_x2apic_icr_write(cfg, 0);
+}
+
+void x2apic_send_IPI_allbutself(int vector)
 {
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
-static void x2apic_send_IPI_all(int vector)
+void x2apic_send_IPI_all(int vector)
 {
 	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
+void x2apic_send_IPI_self(int vector)
+{
+	apic_write(APIC_SELF_IPI, vector);
+}
+
+void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
+{
+	unsigned long cfg = __prepare_ICR(0, vector, dest);
+	native_x2apic_icr_write(cfg, apicid);
+}
+
 static int x2apic_phys_probe(void)
 {
 	if (!x2apic_mode)
@@ -111,21 +131,6 @@ int x2apic_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
-{
-	unsigned long cfg = __prepare_ICR(0, vector, dest);
-	native_x2apic_icr_write(cfg, apicid);
-}
-
-void __x2apic_send_IPI_shorthand(int vector, u32 which)
-{
-	unsigned long cfg = __prepare_ICR(which, vector, 0);
-
-	/* x2apic MSRs are special and need a special fence: */
-	weak_wrmsr_fence();
-	native_x2apic_icr_write(cfg, 0);
-}
-
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
@@ -141,11 +146,6 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
 	return initial_apicid >> index_msb;
 }
 
-void x2apic_send_IPI_self(int vector)
-{
-	apic_write(APIC_SELF_IPI, vector);
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f0580a6..a8ed237 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -25,6 +25,8 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
+#include "local.h"
+
 static enum uv_system_type	uv_system_type;
 static int			uv_hubbed_system;
 static int			uv_hubless_system;
@@ -783,11 +785,6 @@ static int uv_apic_id_valid(u32 apicid)
 	return 1;
 }
 
-static unsigned int x2apic_get_apic_id(unsigned long id)
-{
-	return id;
-}
-
 static u32 set_apic_id(unsigned int id)
 {
 	return id;
@@ -803,11 +800,6 @@ static int uv_phys_pkg_id(int initial_apicid, int index_msb)
 	return uv_read_apic_id() >> index_msb;
 }
 
-static void uv_send_IPI_self(int vector)
-{
-	apic_write(APIC_SELF_IPI, vector);
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -840,7 +832,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.send_IPI_mask_allbutself	= uv_send_IPI_mask_allbutself,
 	.send_IPI_allbutself		= uv_send_IPI_allbutself,
 	.send_IPI_all			= uv_send_IPI_all,
-	.send_IPI_self			= uv_send_IPI_self,
+	.send_IPI_self			= x2apic_send_IPI_self,
 
 	.wakeup_secondary_cpu		= uv_wakeup_secondary,
 
