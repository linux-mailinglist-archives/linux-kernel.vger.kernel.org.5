Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063180E92F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbjLLKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjLLKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:33:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259BAA6;
        Tue, 12 Dec 2023 02:33:20 -0800 (PST)
Date:   Tue, 12 Dec 2023 10:33:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702377198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+a2nGAgihtQNR6oAJmNTsSqLsllRV9xD2+EzyHqLHp0=;
        b=3KwgS6THwNO5qsR1XlqzEDMeWxmfnhHBw6JGgYoe4TPVGNsOH1PZHS4mNF47fnd2PqkUOv
        tmeUvqrVWdSm4a+j5StACC0AtSIokNPf2KYFcprZFKDwYW+S2hXd4YshaoLWIFqMARkwjj
        LlBMSMIQntdpoKU3NFWk8VvDlsX4jD0+sMm+EVNRR1KQnwTSXshQhFlbtaVzu/PBEIVgBl
        lpP7iaj4ZE+pJpfaaBmgzE8WGKyY/BME+LJpOJEIszUTFrHWs2GrdHwAHqBN3z5EUrOQnP
        I64lurAbMO9sB/x49dOq3H5JJKkGtCfqvE8PXhSks16oSXpNwplkMOrAbtfN5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702377198;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+a2nGAgihtQNR6oAJmNTsSqLsllRV9xD2+EzyHqLHp0=;
        b=cJuygFpDB8+tgVqMRDy8xfDhU7iRjm/eEUFUKUXwwgu6PSnEykqcbUt8qjSpIRtXaI3iWV
        1ECAUazdr4J3v7BA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Add X86_FEATURE_ZEN1
Cc:     Brian Gerst <brgerst@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
References: <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
MIME-Version: 1.0
Message-ID: <170237719725.398.5191492346336231574.tip-bot2@tip-bot2>
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

Commit-ID:     232afb557835d6f6859c73bf610bad308c96b131
Gitweb:        https://git.kernel.org/tip/232afb557835d6f6859c73bf610bad308c96b131
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 02 Dec 2023 12:50:23 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 12 Dec 2023 11:17:37 +01:00

x86/CPU/AMD: Add X86_FEATURE_ZEN1

Add a synthetic feature flag specifically for first generation Zen
machines. There's need to have a generic flag for all Zen generations so
make X86_FEATURE_ZEN be that flag.

Fixes: 30fa92832f40 ("x86/CPU/AMD: Add ZenX generations flags")
Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com
---
 arch/x86/include/asm/cpufeatures.h       |  3 ++-
 arch/x86/kernel/cpu/amd.c                | 11 ++++++-----
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 149cc5d..632c26c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
@@ -315,6 +315,7 @@
 #define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
 #define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
 #define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ZEN1		(11*32+31) /* "" CPU based on Zen1 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 89bbb1a..3395863 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -542,7 +542,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x50 ... 0x5f:
-			setup_force_cpu_cap(X86_FEATURE_ZEN);
+			setup_force_cpu_cap(X86_FEATURE_ZEN1);
 			break;
 		case 0x30 ... 0x4f:
 		case 0x60 ... 0x7f:
@@ -948,12 +948,13 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 
 static void init_amd_zen_common(void)
 {
+	setup_force_cpu_cap(X86_FEATURE_ZEN);
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
 }
 
-static void init_amd_zen(struct cpuinfo_x86 *c)
+static void init_amd_zen1(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
 	fix_erratum_1386(c);
@@ -1075,8 +1076,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x16: init_amd_jg(c); break;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ZEN))
-		init_amd_zen(c);
+	if (boot_cpu_has(X86_FEATURE_ZEN1))
+		init_amd_zen1(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN2))
 		init_amd_zen2(c);
 	else if (boot_cpu_has(X86_FEATURE_ZEN3))
@@ -1143,7 +1144,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 * Counter May Be Inaccurate".
 	 */
 	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    (boot_cpu_has(X86_FEATURE_ZEN) && c->x86_model > 0x2f))
+	    (boot_cpu_has(X86_FEATURE_ZEN1) && c->x86_model > 0x2f))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 798e60b..845a402 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
