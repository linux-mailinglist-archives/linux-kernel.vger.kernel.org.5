Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD17FD586
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjK2LWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjK2LW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3810EA;
        Wed, 29 Nov 2023 03:22:32 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP6IetWerb4+s0lyyeErZdEKVor8JXULEZZsowb3yMw=;
        b=ia72P5Py7AFe2crsrm8OGsAhFhHwuQJ6zy/YYqcqHHTZrnB2Aox5fE2Iq7Zyu9RIpA7F/8
        YZKwX2RC1rpa1hr4rScmNo/Qe8VLFrFpMg0MwstL7UMxsE7R5rz7+0NDxRsFqWRyuT7dCT
        RQnGRlspUbFXrZ1OvQQi0kn6sxz/Kg2t04M65mMMBJgxZuNp96joRPC6rootf1rWf9Ah2b
        Kl8Re+76cUcVQzHelLk4zBKT9yWSFpCva/8qttRfoBFvKn58NNqoqbgdbW6U366A+npD+L
        W/o9HzFZc7RgNuGtXuq21HCiOzkHMeT90+pZrjMRYyQ9wi0l2BgEUJfpAVC07w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP6IetWerb4+s0lyyeErZdEKVor8JXULEZZsowb3yMw=;
        b=KtYI+ssIeavASL4MpznGdGJsPw+d3YP548Rnl9znnXOYWTV/FMOFHwWrx3y/NrYdKxxzMc
        NxubNC3M/jlNybAw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Call the spectral chicken in the Zen2
 init function
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-6-bp@alien8.de>
References: <20231120104152.13740-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125695080.398.11018191952633732992.tip-bot2@tip-bot2>
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

Commit-ID:     cfbf4f992bfce1fa9f2f347a79cbbea0368e7971
Gitweb:        https://git.kernel.org/tip/cfbf4f992bfce1fa9f2f347a79cbbea0368e7971
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 11:20:01 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:12:20 +01:00

x86/CPU/AMD: Call the spectral chicken in the Zen2 init function

No functional change.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-6-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ebe6be8..82747b6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1007,10 +1007,8 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	 *
 	 * This suppresses speculation from the middle of a basic block, i.e. it
 	 * suppresses non-branch predictions.
-	 *
-	 * We use STIBP as a heuristic to filter out Zen2 from the rest of F17H
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_AMD_STIBP)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
 			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
@@ -1081,6 +1079,7 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 }
 
@@ -1136,7 +1135,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_spectral_chicken(c);
+	case 0x17:
 		   fallthrough;
 	case 0x19: init_amd_zn(c); break;
 	}
