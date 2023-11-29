Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AD7FD589
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjK2LXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjK2LWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC51BCC;
        Wed, 29 Nov 2023 03:22:35 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTJP4GuZWQvoaacJKCszms5BpWIpa1KbHZbw56B8K0g=;
        b=SSPMj8IbwjwyeBVkVJdNQHR7DEjHlWQEIs1TnppVcy6pMj+UEuvl4/2DkFkY7gJWZxoOeU
        PRXs6+xJKMY32x1N3rQlsvG47lEN0Gn1H7RSUkA1aKX5nnrk9N1Elwhi02Pvbju3U/QYLE
        MAvoxKpjEN+BFpZSArd9cpuapuC9xCyTIQPIsZ8t8TUwFUdS6np81zd9ZQSoJnFRGx5WP5
        6XzXUmU9t5PGUDBuXvYVxRzCHV5+EIRLpLX8EhB7ZkZavTlgWhFXcRFwKLeV3RrpukGdYr
        2s3U702weYiUdU5Zru1DaxQ7MnkwBU7mHfS9CNc/dR8YhhYVyf1LtBwswFPdAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTJP4GuZWQvoaacJKCszms5BpWIpa1KbHZbw56B8K0g=;
        b=XtVCgPEGtZq+DBYtql/jMQXlVRkaWVYLSVzlJAakL4uVuFbj+E0dmydaE2Dny5ynqupN2L
        dzEWTcKBijon8fAg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Add ZenX generations flags
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-2-bp@alien8.de>
References: <20231120104152.13740-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125695376.398.6501830714490872202.tip-bot2@tip-bot2>
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

Commit-ID:     30fa92832f405d5ac9f263e99f62445fa3084008
Gitweb:        https://git.kernel.org/tip/30fa92832f405d5ac9f263e99f62445fa3084008
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 31 Oct 2023 23:30:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:11:01 +01:00

x86/CPU/AMD: Add ZenX generations flags

Add X86_FEATURE flags for each Zen generation. They should be used from
now on instead of checking f/m/s.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/r/20231120104152.13740-2-bp@alien8.de
---
 arch/x86/include/asm/cpufeatures.h |  5 +-
 arch/x86/kernel/cpu/amd.c          | 70 ++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3e973ff..149cc5d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,7 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen microarchitecture */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU based on Zen microarchitecture */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
@@ -312,6 +312,9 @@
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
 #define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
+#define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
+#define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
+#define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 841e212..6aba224 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -616,6 +616,49 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	/* Figure out Zen generations: */
+	switch (c->x86) {
+	case 0x17: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x2f:
+		case 0x50 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN);
+			break;
+		case 0x30 ... 0x4f:
+		case 0x60 ... 0x7f:
+		case 0x90 ... 0x91:
+		case 0xa0 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN2);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	case 0x19: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+		case 0x20 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN3);
+			break;
+		case 0x10 ... 0x1f:
+		case 0x60 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN4);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	return;
+
+warn:
+	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -974,8 +1017,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
-	set_cpu_cap(c, X86_FEATURE_ZEN);
-
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
@@ -1037,6 +1078,22 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_amd_zen(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen2(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen3(struct cpuinfo_x86 *c)
+{
+}
+
+static void init_amd_zen4(struct cpuinfo_x86 *c)
+{
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	u64 vm_cr;
@@ -1077,6 +1134,15 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x19: init_amd_zn(c); break;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		init_amd_zen(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN2))
+		init_amd_zen2(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN3))
+		init_amd_zen3(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN4))
+		init_amd_zen4(c);
+
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
 	 * without a XSaveErPtr feature
