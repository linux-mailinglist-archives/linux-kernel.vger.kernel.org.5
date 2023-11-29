Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9188E7FD584
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjK2LWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjK2LWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2BDA;
        Wed, 29 Nov 2023 03:22:32 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1ltcc3b3mRyT/av5cRPGcM+cJbBi7H6S2KjhqFQk0Y=;
        b=Wyp0Y7Rzr4X6m0aWOBQlaQeKCXM3sCpKLZAMY3Fda1stpvvCBPZRkcfU4bwBFSoYNsdxZl
        Yxzqj+AteUvlYhxpPXW91hx5YHEE0FoAmQLIJ1DTlK+80/IjU29TiVhhZobuirYLqHI802
        54txw/WfB63briaMobMhhWXCguguUeoj1cvrpSqtDCFKAnR0CVtiNLs5x+xJinaigAJC/+
        +kCKZHTyZOawjwgeU++dC9TZGkp2LawOiKlr77vKuK672iGLTtDP8kO/RzEjvzbsx5nxGY
        VJW9L6xztlt/L0h4UgsI0EheXVA4UwK8r08ZXoItULqqzlpbHigm5Gyawdeo2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1ltcc3b3mRyT/av5cRPGcM+cJbBi7H6S2KjhqFQk0Y=;
        b=WXnLMWeDaMwyZ1Ls1gG9ycDYRJ7WHTBwIVBGDeW30Vr7Uq4n9DY4N9tEYB+1MM/42z/2Gm
        c1tpH31tR5ZrTdAg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-7-bp@alien8.de>
References: <20231120104152.13740-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125695011.398.3115550737578725186.tip-bot2@tip-bot2>
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

Commit-ID:     7c81ad8e8bc28a1847e87c5afe1bae6bffb2f73e
Gitweb:        https://git.kernel.org/tip/7c81ad8e8bc28a1847e87c5afe1bae6bffb2f73e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 12:34:29 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:12:27 +01:00

x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()

Call it from all Zen init functions.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-7-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 82747b6..f53e0a2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1017,7 +1017,7 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void init_amd_zn(struct cpuinfo_x86 *c)
+static void init_amd_zen_common(void)
 {
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
@@ -1026,6 +1026,7 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 
 static void init_amd_zen(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 	fix_erratum_1386(c);
 
 	/* Fix up CPUID bits, but only if not virtualised. */
@@ -1075,16 +1076,20 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	} else {
 		msr_clear_bit(MSR_AMD64_DE_CFG, MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT);
 	}
+
 }
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 }
 
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
+
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		/*
 		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
@@ -1098,6 +1103,7 @@ static void init_amd_zen3(struct cpuinfo_x86 *c)
 
 static void init_amd_zen4(struct cpuinfo_x86 *c)
 {
+	init_amd_zen_common();
 }
 
 static void init_amd(struct cpuinfo_x86 *c)
@@ -1135,9 +1141,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17:
-		   fallthrough;
-	case 0x19: init_amd_zn(c); break;
 	}
 
 	if (boot_cpu_has(X86_FEATURE_ZEN))
