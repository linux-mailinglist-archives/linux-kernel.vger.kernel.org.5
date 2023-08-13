Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425077AA55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHMR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHMR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141E10FB;
        Sun, 13 Aug 2023 10:26:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ml8FmwzrGUL0cDZP6Dx80nGHWdATwlWTLMNiFVmxrTQ=;
        b=D4H8VW1/5cSw3OvO7+I+4eUhoe1xeausxSC2Ze9BiDrPFne4X82k8g4q8AIleQ0Zzfk/jZ
        iEmPxgOIW65D9jsYZJrKiRGPkymI2Ch/5UeWjB18uZNAzCjsHlT1GQbgVCcBonpRI/68ZG
        UOOi7sGGaFJv+fstaCIWGZRu4uIycTErheQz6t36iZmXpAF997DC/WzFk4n77JSw0eGjIv
        YWN+8d+k03qIAz9tdop12Qn85/1Q2678C1gCnX4BxJjD+mUOy3SwX3XFyyXWkiV0PlXYIf
        vSDqRvzfZYazry1GyL35ujSnBD5IbsJMs/oxHl7UiAyJoOkTJU94WRFnOMvFkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ml8FmwzrGUL0cDZP6Dx80nGHWdATwlWTLMNiFVmxrTQ=;
        b=8GowjzxmkmKI3Vo3x3LHHmQY6WWU68ih+LEixwYr+yVjhgnaV1aB405C4pEFmJrUDjOe7v
        zHmCEy0Sq7WVEYBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Remove pointless mutex
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195728.069849788@linutronix.de>
References: <20230812195728.069849788@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759091.27769.17557260574183887104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d2700f406713d04573803b9fe8a0fb02c015df39
Gitweb:        https://git.kernel.org/tip/d2700f406713d04573803b9fe8a0fb02c015df39
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Aug 2023 21:58:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode/intel: Remove pointless mutex

There is no concurrency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195728.069849788@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 8621ef4..94dd6af 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -397,22 +397,6 @@ next:
 	return patch;
 }
 
-/*
- * Save this microcode patch. It will be loaded early when a CPU is
- * hot-added or resumes.
- */
-static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int size)
-{
-	/* Synchronization during CPU hotplug. */
-	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
-
-	mutex_lock(&x86_cpu_microcode_mutex);
-
-	save_microcode_patch(uci, mc, size);
-
-	mutex_unlock(&x86_cpu_microcode_mutex);
-}
-
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
 {
 	unsigned int eax = 1, ebx, ecx = 0, edx;
@@ -829,12 +813,8 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 	vfree(uci->mc);
 	uci->mc = (struct microcode_intel *)new_mc;
 
-	/*
-	 * If early loading microcode is supported, save this mc into
-	 * permanent memory. So it will be loaded early when a CPU is hot added
-	 * or resumes.
-	 */
-	save_mc_for_early(uci, new_mc, new_mc_size);
+	/* Save for CPU hotplug */
+	save_microcode_patch(uci, new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
