Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082B7763E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjHIPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjHIPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE82126;
        Wed,  9 Aug 2023 08:34:19 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=68pNK2WSfqBsYNWLreuIeEoYAihEbeOUP9b2PdtCLhk=;
        b=OG/J39N+r/YfWsFnM5RDgo+oq7npFvI/k81pX5c7253atXpUWrxRB0b/SDbEzSCD04sMq2
        SsGBl7y5qRLGR4XpiHrspYAJqNqwmBtD944Kru7g+L7zNYfOo4dCfh6YinJwJJJcCeiNMG
        pQCBsVr9kXtwKOXZ1czRrku4SkDKXWeajnWP70mHbUT/bdMN8em2eKnf7428cs88qMfBXj
        wHluBxZx2ba2bdkRaB3EVlJ7Vf7obxO6f2+1Bmwexx16ko0nZMubBDh0gKf7XsEK2XHnTc
        U0cKr3cEevEnHaTUVhB/r4LloUlStCLB6ktO8/g6gTtJ1E9QFkSLuxA58SOO+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=68pNK2WSfqBsYNWLreuIeEoYAihEbeOUP9b2PdtCLhk=;
        b=x7QfIAil13KS9m5aN/ywHB8HK23z2egmYc9mCThk7knbXS/m8OTc0wdpUSZLScYw0GgZv/
        0ysBDqTW/lsOI+Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove unused max_physical_apicid
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525780.27769.2426680572871085690.tip-bot2@tip-bot2>
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

Commit-ID:     3fd3664b8e1a8dc088334a9410bc86635b9964f0
Gitweb:        https://git.kernel.org/tip/3fd3664b8e1a8dc088334a9410bc86635b9964f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:43 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:10 -07:00

x86/apic: Remove unused max_physical_apicid

max_physical_apicid is assigned but never read.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ee64f8f..d6b5059 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -74,11 +74,6 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 u8 boot_cpu_apic_version __ro_after_init;
 
 /*
- * The highest APIC ID seen during enumeration.
- */
-static unsigned int max_physical_apicid;
-
-/*
  * Bitmask of physically existing CPUs:
  */
 physid_mask_t phys_cpu_present_map;
@@ -2541,9 +2536,6 @@ int generic_processor_info(int apicid, int version)
 			boot_cpu_apic_version, cpu, version);
 	}
 
-	if (apicid > max_physical_apicid)
-		max_physical_apicid = apicid;
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
