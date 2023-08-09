Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C27763D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHIPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjHIPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAAF2111;
        Wed,  9 Aug 2023 08:34:14 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Nt+zZaVdwUgZFTmuy7LkcH09d8Xhbf6cCuO0YE8P3J8=;
        b=vjWcYxDs2GIQkOcN89mHUrLP10ctZmLfSYtGYhVpQyPM/GrfjYdMyh9oUk7LCs3ESlo5S9
        F1r0sdZJnk268qSm6HvhRYp4bQ2SA8VZtWlEFBgRez617TkiVxPsawCBHVGdcN+0Op3qei
        uWLcNl9Wrrli9hmmcwwtgLqmuyRPfgLqHlZUOxAsrTXRHe3qR3rBSp/bHINarr6Bc+NJXJ
        4aEOqWxmtri+Oiv4ZVlYVNStAxn1zoAmAjqjwB3/d15xZzEo/oNnUqUPe04tUdaxse2JnG
        xCt4NXNCHACfPF/UO5SRgVeL1/TfyQzMzfUUy+8m52Cvz/6yV0Zg2Qd4mesDrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Nt+zZaVdwUgZFTmuy7LkcH09d8Xhbf6cCuO0YE8P3J8=;
        b=quxzvLlcEmxwv/yVKiKZEY8dTWWPc3ebtIVtGCwpu1A2Imiqh91gLlK5veo9wH0G3E6tqy
        E+AAowdjx4D1tACg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Nuke another processor check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525273.27769.947618313714395207.tip-bot2@tip-bot2>
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

Commit-ID:     1ad49dcd9f85ed507a9a7543e2db360cf70005ba
Gitweb:        https://git.kernel.org/tip/1ad49dcd9f85ed507a9a7543e2db360cf70005ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Nuke another processor check

The boot CPUs local APIC is now always registered, so there is no point to
have another unreadable validatation for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/smpboot.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fc2173b..da795f7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1181,23 +1181,6 @@ static void __init smp_sanity_check(void)
 		set_nr_cpu_ids(8);
 	}
 #endif
-
-	if (!physid_isset(read_apic_id(), phys_cpu_present_map)) {
-		pr_warn("weird, boot CPU (#%d) not listed by the BIOS\n",
-			read_apic_id());
-
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
-
-	/*
-	 * Should not be necessary because the MP table should list the boot
-	 * CPU too, but we do it for the sake of robustness anyway.
-	 */
-	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
-		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
-			  boot_cpu_physical_apicid);
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
 	preempt_enable();
 }
 
