Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EED77AA5D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjHMR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjHMR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F510FD;
        Sun, 13 Aug 2023 10:26:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFv/WGD4ae9CWzDQzX25v0TJdEoRSiky32t7iTcaZU4=;
        b=wuVKSAz39zBSj3vWKc0OWVv9NMyB79BmZxnbP6/c1YbnvkCR/oL1PnhfWhzXlZ5D4chmql
        9W9ywVjwVvbvKHlQ3dCCL1ZbWLm9RjKOrj7hRHWbBalJ8Vu+FwWZaCvWVPA85l3kXBvyis
        VXR6nowJUUqK79bJwup1jlIfyyb+P9UoBhWLIm+mkeVO9VityCrKuMXTPClYnNRlrppFDJ
        ENNzjJnn0Wv+2qCAIMRHBZO/u9mnFLt7ce+nueufdgyKDXH0QwQRol/nP2E3dqbZ2JXjJF
        KegrsnO5qZtcdz8BBoKO9RQiw4Icj8XrhOnxWZYYE5Fs4BMDoV+sOuFo2nGCcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFv/WGD4ae9CWzDQzX25v0TJdEoRSiky32t7iTcaZU4=;
        b=VsViDXB6L/79Lb8zaDoeQzKEyDPK03VienIgenYX9KDUHVXG5942XWiFBJmNsWac4dhIBg
        wL8EW9fkuURe3IAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Make reload_early_microcode() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.834943153@linutronix.de>
References: <20230812195727.834943153@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759276.27769.3507811104748487881.tip-bot2@tip-bot2>
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

Commit-ID:     18648dbd3338b75e7b2895d725ee3a7187d6e3a3
Gitweb:        https://git.kernel.org/tip/18648dbd3338b75e7b2895d725ee3a7187d6e3a3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Aug 2023 21:58:44 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode: Make reload_early_microcode() static

fe055896c040 ("x86/microcode: Merge the early microcode loader") left this
needlessly public. Git archaeology provided by Borislav.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.834943153@linutronix.de
---
 arch/x86/include/asm/microcode.h     | 2 --
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 9c713b7..166a633 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -128,13 +128,11 @@ static inline unsigned int x86_cpuid_family(void)
 #ifdef CONFIG_MICROCODE
 extern void __init load_ucode_bsp(void);
 extern void load_ucode_ap(void);
-void reload_early_microcode(unsigned int cpu);
 extern bool initrd_gone;
 void microcode_bsp_resume(void);
 #else
 static inline void __init load_ucode_bsp(void)			{ }
 static inline void load_ucode_ap(void)				{ }
-static inline void reload_early_microcode(unsigned int cpu)	{ }
 static inline void microcode_bsp_resume(void)			{ }
 #endif
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 73a3c22..75c5bc7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -293,7 +293,7 @@ struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa)
 #endif
 }
 
-void reload_early_microcode(unsigned int cpu)
+static void reload_early_microcode(unsigned int cpu)
 {
 	int vendor, family;
 
