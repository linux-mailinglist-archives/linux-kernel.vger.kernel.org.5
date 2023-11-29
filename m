Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DA7FD582
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjK2LWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjK2LWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EB172E;
        Wed, 29 Nov 2023 03:22:30 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA9vhfzIXaSAQHK/BcA4eWekW0YPp/eISi/VhG2VkNA=;
        b=EoTMIsMBgj7Wpx9u+wILiOSRQHWZ9GRYZbpXVRmKhdGP3a+AqIeDerx+mGeYMU/tfhjIDD
        7Pt/3iThUpOLbtb+sp7h1e9Xd5LVzzHznGjy2+rlgCwqV72jU4xkpQBYhopktkgicB3yMF
        BnvCPU3Df+LuLEm4OhrYvWtIQ2BxBxtDzHWnS+djpPDP7UN7yyAdR2BfzCrGye5VHscmJN
        qqpD5M976dhi2sJqJeJHA1PHIyZ7AFqxQMl2SwRUt2vCQSkWOOzuePUqOh3fgKGWMqT74H
        hCj8A/kSgtzt77I0CQBwiKpNhEHg0ngfIvMDSqvc3XxQr6ekS+UQkLNA+PCVnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA9vhfzIXaSAQHK/BcA4eWekW0YPp/eISi/VhG2VkNA=;
        b=UbDpVCQZ8XDC8ftB9/j82ytUOF0ztjCWGNpDDnFQeLxcDgscX2Sk/jWHXWUUVkuBHHOy01
        w6p8RWngBYB6FCAQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Move the DIV0 bug detection to the Zen1
 init function
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-9-bp@alien8.de>
References: <20231120104152.13740-9-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694868.398.10343927971091524715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     bfff3c6692ce64fa9d86eb829d18229c307a0855
Gitweb:        https://git.kernel.org/tip/bfff3c6692ce64fa9d86eb829d18229c307a0855
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 12:52:01 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:12:42 +01:00

x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-9-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3c3b4c1..13ad44b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -70,10 +70,6 @@ static const int amd_erratum_383[] =
 static const int amd_erratum_1054[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
-static const int amd_div0[] =
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
-
 static const int amd_erratum_1485[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -1030,6 +1026,9 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
 	}
+
+	pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
+	setup_force_cpu_bug(X86_BUG_DIV0);
 }
 
 static bool cpu_has_zenbleed_microcode(void)
@@ -1067,7 +1066,6 @@ static void zen2_zenbleed_check(struct cpuinfo_x86 *c)
 	} else {
 		msr_clear_bit(MSR_AMD64_DE_CFG, MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT);
 	}
-
 }
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
@@ -1219,11 +1217,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
 
-	if (cpu_has_amd_erratum(c, amd_div0)) {
-		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protection.\n");
-		setup_force_cpu_bug(X86_BUG_DIV0);
-	}
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
 	     cpu_has_amd_erratum(c, amd_erratum_1485))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
