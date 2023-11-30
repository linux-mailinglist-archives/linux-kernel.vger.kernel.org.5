Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC967FFD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbjK3VQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376848AbjK3VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90C170F;
        Thu, 30 Nov 2023 13:16:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQJ87u2AnKlqVOtzAOTWmogwTb6/DRmjMhXviCOIGf4=;
        b=OVNu9j/PxfLbmXGVHiwSRKtA0P/+R+JBCCj9e+BiM0nluM1n5+pfmBGnMN2QQEPnXL9QSL
        nqsIWySC2jBFcd4Xnwu6gWHgggBNVBHiq1z3nAhyVbriaib2LVdp1wXwXqBcn/MOsucGqd
        JsGi7D4Ah0dpiSTdD4LNZXGOPKCaCCqYM9dxRer5FzF5uyg82csnVOGzkKopIDp01FZb0N
        L7d/UgjbWZmmGdLdSaxu4DsOVB8xqaXOnf7GXybJEZRyfeJ1KJMVokap7iQpK0iDWW8+iH
        ammv57S0ftJv8Ogdy5LYJuAqDJKSHAySRx3qxsfQrm5zp8dfzOEKuWm8TvUpdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQJ87u2AnKlqVOtzAOTWmogwTb6/DRmjMhXviCOIGf4=;
        b=1UQkAye5UH+q/QRprzMGtNKw+JHLJDW3NJ6oYws0BD2wJ9HaxYpHUpBQSDvv79tpTWfRVI
        F/5nE/PAZvKoOiBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/callthunks: Mark apply_relocation() as __init_or_module
Cc:     Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231105213731.1878100-3-ubizjak@gmail.com>
References: <20231105213731.1878100-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899106.398.14613676631297252898.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     6724ba89e0b03667d56616614f55e1f772d38fdb
Gitweb:        https://git.kernel.org/tip/6724ba89e0b03667d56616614f55e1f772d38fdb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 30 Nov 2023 20:15:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:15:51 +01:00

x86/callthunks: Mark apply_relocation() as __init_or_module

Do it like the rest of the methods using it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20231105213731.1878100-3-ubizjak@gmail.com
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index ba8d900..fb338f0 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,7 +18,7 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
-void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len);
+extern void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len);
 
 /*
  * Currently, the max observed size in the kernel code is
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index aa86415..5052371 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -325,7 +325,7 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+void __init_or_module apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
 	int prev, target = 0;
 
