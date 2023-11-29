Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49E17FD579
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjK2LWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjK2LWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8331999;
        Wed, 29 Nov 2023 03:22:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgsSLktVnVLWUAoHl8Zsn2zYL7+t5Ae+iJ8uyuFak0s=;
        b=PsMEnS3C3st1Fd6uW6tDfdXfDbsw9lXHIAyB4qktqeoy5LnQwuT2SMG+ONuBxqyraT0EMd
        IQhPGdJikLjF/shMmLovWjyG3wHqFKp9GmsnvRA1tSXamjgoqCarXqu9YjtnmTVzuIc24b
        nmVJEeG5wY/GW7zkc4oERWzRqxQC6rEbSdpUOsO8r+d0dRge48f/6egojSBMAH5MMBZ+K/
        O4NgH+il/RZCB7++cNCG962hA1RLP2T+fphWlDiQtD/RYnqfoTB8DioVkXFtCwEJVifuJW
        3YzPekzo8sspU3muEZL3MujGurVyTyEd7fFrPpdZj+QYMIrmO0d/FkcNj04LUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgsSLktVnVLWUAoHl8Zsn2zYL7+t5Ae+iJ8uyuFak0s=;
        b=nqpAIP83WGLDO6EENwYQYx6DMf0FPhAA38rQ4xgqAJF5fLL7bUpUvswsxEZX7Mhozqj3y2
        rcWFo1HZzixOJ/AA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Get rid of amd_erratum_1485[]
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-13-bp@alien8.de>
References: <20231120104152.13740-13-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694578.398.3923463783976438824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     794c68b20408bb6899f90314e36e256924cc85a1
Gitweb:        https://git.kernel.org/tip/794c68b20408bb6899f90314e36e256924cc85a1
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Nov 2023 23:21:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:13:31 +01:00

x86/CPU/AMD: Get rid of amd_erratum_1485[]

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-13-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 550ac25..f8be7ac 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -59,10 +59,6 @@ static u32 nodes_per_socket = 1;
 #define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
 #define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
 
-static const int amd_erratum_1485[] =
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
-			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
-
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1093,6 +1089,9 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
@@ -1216,10 +1215,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
 
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-	     cpu_has_amd_erratum(c, amd_erratum_1485))
-		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
-
 	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
 	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
 }
