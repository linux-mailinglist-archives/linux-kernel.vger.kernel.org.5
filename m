Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED17FD573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjK2LWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjK2LWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7BFDA;
        Wed, 29 Nov 2023 03:22:27 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycDmQyS/ZUYSu95nNY8Gky809ktQ/s5nNewRtZsfpwk=;
        b=bD0lF3r7X2mKAaQ9Rr9iJCXTYnUyrCBzNEcTMBtdP5evUpqxyFPrauhKsObWjFXbvwmb3b
        ePqi2KDu8eSS1cEfus5I8XfFED+4hBLMvzq7szSx9kSM5FAOT78prWFil2vTl9lx2dzVw1
        6gv4JDA8xZ9ajIwEnWZXb5yqg6zILKgHiu4BCOJzvfWF+hcUlu0wURg0NBc2Ug90tfolZk
        Y6ykBLtXzZF0RMeeU30HljfnIFR3SqprUoiAD/7SFHui+/APm+31k9mG2fx5V40vD9eiGb
        BdV/tlk7aGk8R8v95cGiP9xSQk/U5Akx7RxeJiXc3zKiKZUI0lip2FhfrQ7RuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycDmQyS/ZUYSu95nNY8Gky809ktQ/s5nNewRtZsfpwk=;
        b=GlpnFQ1ZgwU4Spwf/j6JI+zO56HX+A6nQ40lzTPEkVZPTPLmEAYZIuBPZTdIRV+MTmo0jX
        XGig4eNdIg1MIpDw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Drop now unused CPU erratum checking function
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-14-bp@alien8.de>
References: <20231120104152.13740-14-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694499.398.14869637705569913920.tip-bot2@tip-bot2>
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

Commit-ID:     05f5f73936fa4c1bc0a852702edf53789398d278
Gitweb:        https://git.kernel.org/tip/05f5f73936fa4c1bc0a852702edf53789398d278
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Nov 2023 23:40:48 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:13:53 +01:00

x86/CPU/AMD: Drop now unused CPU erratum checking function

Bye bye.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-14-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 56 +--------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f8be7ac..89bbb1a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -34,62 +34,6 @@
  */
 static u32 nodes_per_socket = 1;
 
-/*
- * AMD errata checking
- *
- * Errata are defined as arrays of ints using the AMD_LEGACY_ERRATUM() or
- * AMD_OSVW_ERRATUM() macros. The latter is intended for newer errata that
- * have an OSVW id assigned, which it takes as first argument. Both take a
- * variable number of family-specific model-stepping ranges created by
- * AMD_MODEL_RANGE().
- *
- * Example:
- *
- * const int amd_erratum_319[] =
- *	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0x4, 0x2),
- *			   AMD_MODEL_RANGE(0x10, 0x8, 0x0, 0x8, 0x0),
- *			   AMD_MODEL_RANGE(0x10, 0x9, 0x0, 0x9, 0x0));
- */
-
-#define AMD_LEGACY_ERRATUM(...)		{ -1, __VA_ARGS__, 0 }
-#define AMD_OSVW_ERRATUM(osvw_id, ...)	{ osvw_id, __VA_ARGS__, 0 }
-#define AMD_MODEL_RANGE(f, m_start, s_start, m_end, s_end) \
-	((f << 24) | (m_start << 16) | (s_start << 12) | (m_end << 4) | (s_end))
-#define AMD_MODEL_RANGE_FAMILY(range)	(((range) >> 24) & 0xff)
-#define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
-#define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
-
-static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
-{
-	int osvw_id = *erratum++;
-	u32 range;
-	u32 ms;
-
-	if (osvw_id >= 0 && osvw_id < 65536 &&
-	    cpu_has(cpu, X86_FEATURE_OSVW)) {
-		u64 osvw_len;
-
-		rdmsrl(MSR_AMD64_OSVW_ID_LENGTH, osvw_len);
-		if (osvw_id < osvw_len) {
-			u64 osvw_bits;
-
-			rdmsrl(MSR_AMD64_OSVW_STATUS + (osvw_id >> 6),
-			    osvw_bits);
-			return osvw_bits & (1ULL << (osvw_id & 0x3f));
-		}
-	}
-
-	/* OSVW unavailable or ID unknown, match family-model-stepping range */
-	ms = (cpu->x86_model << 4) | cpu->x86_stepping;
-	while ((range = *erratum++))
-		if ((cpu->x86 == AMD_MODEL_RANGE_FAMILY(range)) &&
-		    (ms >= AMD_MODEL_RANGE_START(range)) &&
-		    (ms <= AMD_MODEL_RANGE_END(range)))
-			return true;
-
-	return false;
-}
-
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
