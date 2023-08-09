Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB8F776567
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjHIQtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHIQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:49:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114361BF7;
        Wed,  9 Aug 2023 09:49:30 -0700 (PDT)
Date:   Wed, 09 Aug 2023 16:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J7hAAA9xgdDSVLUfzr4ZCNcE2fFKQLk8bvire+70PSA=;
        b=PwgIVzeRC+eHR2QhNR5TsKbbAqRYl57R0VbeeIrN+piku5vjrUhF6FNFLF//0e8Ygl07NX
        O1RNlNAzW/Kuo4Kv+alR61rdA+z4DyWDHKB7myIoPYkjvVq4RCow1oRaA8cnHH4etXdwzZ
        DYFZX809fdY3cPV3NjrO7aK4DvZ722rZKYSi6ilR9y00wG360W2T4iijtaDYKXCyicqrAq
        JlZFlPygBYdeTtH4UH3CkVdUioZu/ob2QHcnP751ZuQKln0h4B0P14w0laF3yekR1UMUYk
        2JmXistRKNkVwenGCfkliKM6nFAR2eoyEhvgahlQaQ5UGCrcgwT3EnDYFtqXEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691599769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J7hAAA9xgdDSVLUfzr4ZCNcE2fFKQLk8bvire+70PSA=;
        b=EF2NxXZLuS9vOwPoaK+sVnsEj9HbGHqTPzzLgFQpVXhNzCR3Xae3iKneVKidQxenn3N/cf
        G/z4dkyxQiFKaiDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/64: Uncopypaste probing
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159976830.27769.1143180202055854109.tip-bot2@tip-bot2>
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

Commit-ID:     169a37eb5403f7fcbc1d317c5995faa9eac4a9c6
Gitweb:        https://git.kernel.org/tip/169a37eb5403f7fcbc1d317c5995faa9eac4a9c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:08 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:12 -07:00

x86/apic/64: Uncopypaste probing

No need for the same thing twice. Also prepares for simplifying the APIC ID
validation checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/probe_64.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index 7c9f1a8..a82bb52 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -13,6 +13,15 @@
 
 #include "local.h"
 
+static __init void apic_install_driver(struct apic *driver)
+{
+	if (apic == driver)
+		return;
+
+	apic = driver;
+	pr_info("Switched APIC routing to %s:\n", apic->name);
+}
+
 /* Select the appropriate APIC driver */
 void __init x86_64_probe_apic(void)
 {
@@ -22,11 +31,7 @@ void __init x86_64_probe_apic(void)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->probe && (*drv)->probe()) {
-			if (apic != *drv) {
-				apic = *drv;
-				pr_info("Switched APIC routing to %s.\n",
-					apic->name);
-			}
+			apic_install_driver(*drv);
 			break;
 		}
 	}
@@ -38,11 +43,7 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		if ((*drv)->acpi_madt_oem_check(oem_id, oem_table_id)) {
-			if (apic != *drv) {
-				apic = *drv;
-				pr_info("Setting APIC routing to %s.\n",
-					apic->name);
-			}
+			apic_install_driver(*drv);
 			return 1;
 		}
 	}
