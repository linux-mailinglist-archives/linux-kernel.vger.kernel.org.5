Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844F776571
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjHIQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHIQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150E1BFA;
        Wed,  9 Aug 2023 09:49:30 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UKw5/C1uPchbtj+s2u/z0diGoWi9F8PI/gN2xtNLYsU=;
        b=MUahpj6Prx5w9b+LGRrkJnio+xCb2ct5iKFQ/7K9A6bgaIDM0ce3jNhIVsrkrqfmX3dVbs
        a2JgyYRgwdggImuW4AkZTzPNnVtqMqQuF/AzTLpJP2RaNRB6fQJpOrPAvM3YbPE5RzCy79
        ejUkbrjPpeh2Gjz6S/RBFC7bvxYl0my4N7TcibI+OXcDT/bLZGBTRRYcKck7+2GN4893Yc
        OyjqaH/C23fCPg4bPw+oyIbF8yQ4OFdN3bxqNMQ1OsjVhePdYEbOPu2OeP6391219YIr8u
        cJTgP/8ePlx2z31DNeycwYJoRtJHIUiEhTu74zHHWe4NilTkzX4Lt5hxTdBi8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UKw5/C1uPchbtj+s2u/z0diGoWi9F8PI/gN2xtNLYsU=;
        b=m+qLr8wNwdOsfbDtnL3xh1I3mW+GVoCDSeKD1Q3XldLSHKLVH9MZsD+7HQwdqgZnis2Q1C
        WJEG0saB/PBXEODQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/x2apic: Share all common IPI functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159976883.27769.14480642651891900714.tip-bot2@tip-bot2>
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

Commit-ID:     aea264b9b09883cb53963f608d225f90b4195372
Gitweb:        https://git.kernel.org/tip/aea264b9b09883cb53963f608d225f90b4195372
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic/x2apic: Share all common IPI functions

Yet more copy and pasta gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
