Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85A77AA57
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHMR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjHMR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BA10FA;
        Sun, 13 Aug 2023 10:26:33 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9g6wafFE0TX2vxDL1r12AgYaUDRlw2j8fDT0M+x+k8A=;
        b=t+zdgeZTjuIlmcTvMeyi7JlL1VTQOvFE/7bP3qwzBCicNepXCfS/xPmnCOrZd0Ib3yOj+c
        40YXuFywW4MyPT3bO81eKm3EYihutFgh6QroWm2qoihtoyMlxNnIjXU//n8ADHeF4Dr4nZ
        foJ49v2DOoceBTlk59y+zIUIfshrGSdit4dOKBfsBNnze40qEo1f6XvVv0i+VFSLRV5uLd
        fL3+u6rTYwU618zdnfRmxseoOWOgDC2CUn4CO1DWx29wre6Wvgr6Mn19ZHGcLY+kJF6jUo
        8AnSh97VaOJMreJBu8wpMzkGHsYRha4AD8YofpqOmwQk/e8njS2DNNxY8cF5Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9g6wafFE0TX2vxDL1r12AgYaUDRlw2j8fDT0M+x+k8A=;
        b=5npoWuLqmZL20dlQ7a5k24y21HzkTn3NSkrBtv5Pyxb++3ChEkGIShX+jHQ5hXwYSU6mDq
        zQl/6WSW7lUmusAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Remove debug code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195728.010895747@linutronix.de>
References: <20230812195728.010895747@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759141.27769.2999860222151032837.tip-bot2@tip-bot2>
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

Commit-ID:     d44450c5939949fe37e4e94db69429de1ab1aad6
Gitweb:        https://git.kernel.org/tip/d44450c5939949fe37e4e94db69429de1ab1aad6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Aug 2023 21:58:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode/intel: Remove debug code

This is really of dubious value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195728.010895747@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 75 +--------------------------
 1 file changed, 75 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d983a3e..8621ef4 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -10,15 +10,7 @@
  * Copyright (C) 2012 Fenghua Yu <fenghua.yu@intel.com>
  *		      H Peter Anvin" <hpa@zytor.com>
  */
-
-/*
- * This needs to be before all headers so that pr_debug in printk.h doesn't turn
- * printk calls into no_printk().
- *
- *#define DEBUG
- */
 #define pr_fmt(fmt) "microcode: " fmt
-
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
@@ -405,69 +397,6 @@ next:
 	return patch;
 }
 
-static void show_saved_mc(void)
-{
-#ifdef DEBUG
-	int i = 0, j;
-	unsigned int sig, pf, rev, total_size, data_size, date;
-	struct ucode_cpu_info uci;
-	struct ucode_patch *p;
-
-	if (list_empty(&microcode_cache)) {
-		pr_debug("no microcode data saved.\n");
-		return;
-	}
-
-	intel_cpu_collect_info(&uci);
-
-	sig	= uci.cpu_sig.sig;
-	pf	= uci.cpu_sig.pf;
-	rev	= uci.cpu_sig.rev;
-	pr_debug("CPU: sig=0x%x, pf=0x%x, rev=0x%x\n", sig, pf, rev);
-
-	list_for_each_entry(p, &microcode_cache, plist) {
-		struct microcode_header_intel *mc_saved_header;
-		struct extended_sigtable *ext_header;
-		struct extended_signature *ext_sig;
-		int ext_sigcount;
-
-		mc_saved_header = (struct microcode_header_intel *)p->data;
-
-		sig	= mc_saved_header->sig;
-		pf	= mc_saved_header->pf;
-		rev	= mc_saved_header->rev;
-		date	= mc_saved_header->date;
-
-		total_size	= get_totalsize(mc_saved_header);
-		data_size	= intel_microcode_get_datasize(mc_saved_header);
-
-		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
-			 i++, sig, pf, rev, total_size,
-			 date & 0xffff,
-			 date >> 24,
-			 (date >> 16) & 0xff);
-
-		/* Look for ext. headers: */
-		if (total_size <= data_size + MC_HEADER_SIZE)
-			continue;
-
-		ext_header = (void *)mc_saved_header + data_size + MC_HEADER_SIZE;
-		ext_sigcount = ext_header->count;
-		ext_sig = (void *)ext_header + EXT_HEADER_SIZE;
-
-		for (j = 0; j < ext_sigcount; j++) {
-			sig = ext_sig->sig;
-			pf = ext_sig->pf;
-
-			pr_debug("\tExtended[%d]: sig=0x%x, pf=0x%x\n",
-				 j, sig, pf);
-
-			ext_sig++;
-		}
-	}
-#endif
-}
-
 /*
  * Save this microcode patch. It will be loaded early when a CPU is
  * hot-added or resumes.
@@ -480,7 +409,6 @@ static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int s
 	mutex_lock(&x86_cpu_microcode_mutex);
 
 	save_microcode_patch(uci, mc, size);
-	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
 }
@@ -631,9 +559,6 @@ int __init save_microcode_in_initrd_intel(void)
 	intel_cpu_collect_info(&uci);
 
 	scan_microcode(cp.data, cp.size, &uci, true);
-
-	show_saved_mc();
-
 	return 0;
 }
 
