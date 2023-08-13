Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C477AA5A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjHMR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHMR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24310DD;
        Sun, 13 Aug 2023 10:26:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8LGehJNTJbownToq2PBq86XXUmUG/UNqrjBht0bAvk=;
        b=lN+KfnS1ECrF2z/N/NTjHmgE4wUI4GuaNFA9xnOOB2c8ofmbvWVPZGtIvcfi5Eik0eD1wN
        mipQPAd0o7VT1+0OPzJPaaQVsj2cCNyXOltv/sKYZhvgvKtpW0yNy0vQ52Bv5rG+2SGG3d
        qxueYQvEPReKbTvo4PRekcfOuXiJBQEGikCQ2AM4Zt80ETiU0YkVABN03v2k7XH9LAjOMh
        rA7380amp0luZQevxSNBD3au9hHiwnRJpPe88cW7p5yv4Bjzqjui1izQvFGkoVfEqK/KuN
        CPJlcID/LdbGY9AUf5Zoq0RoQ6wWrr3r4CuZf+r13BW0ckbUIr/QN00ce2xMvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8LGehJNTJbownToq2PBq86XXUmUG/UNqrjBht0bAvk=;
        b=bx3E2F5KzHyQUzlkZGZDcFtxmyzy2+FPhghaJp0oPN9ndKaIxdr68rITAglGFwRhEzqZYC
        BUhKu6Hbejnmf/CQ==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Rename get_datasize() since
 its used externally
Cc:     Boris Petkov <bp@alien8.de>, Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.894165745@linutronix.de>
References: <20230812195727.894165745@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759234.27769.9182026169292220932.tip-bot2@tip-bot2>
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

Commit-ID:     b0e67db12d769cc308a50c1c0ac3721c4f6aead7
Gitweb:        https://git.kernel.org/tip/b0e67db12d769cc308a50c1c0ac3721c4f6aead7
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Sat, 12 Aug 2023 21:58:45 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode/intel: Rename get_datasize() since its used externally

Rename get_datasize() to intel_microcode_get_datasize() and make it an inline.

  [ tglx: Make the argument typed and fix up the IFS code ]

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.894165745@linutronix.de
---
 arch/x86/include/asm/microcode_intel.h | 7 ++++---
 arch/x86/kernel/cpu/microcode/intel.c  | 8 ++++----
 drivers/platform/x86/intel/ifs/load.c  | 5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 9951a4b..7bd4c29 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -26,9 +26,10 @@ struct microcode_intel {
 #define MC_HEADER_TYPE_IFS		2
 #define DEFAULT_UCODE_DATASIZE		(2000)
 
-#define get_datasize(mc) \
-	(((struct microcode_intel *)mc)->hdr.datasize ? \
-	 ((struct microcode_intel *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
+static inline int intel_microcode_get_datasize(struct microcode_header_intel *hdr)
+{
+	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
+}
 
 static inline u32 intel_get_microcode_revision(void)
 {
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 171d96b..9866672 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -118,10 +118,10 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
 		return 1;
 
 	/* Look for ext. headers: */
-	if (get_totalsize(mc_hdr) <= get_datasize(mc_hdr) + MC_HEADER_SIZE)
+	if (get_totalsize(mc_hdr) <= intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE)
 		return 0;
 
-	ext_hdr = mc + get_datasize(mc_hdr) + MC_HEADER_SIZE;
+	ext_hdr = mc + intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE;
 	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
 
 	for (i = 0; i < ext_hdr->count; i++) {
@@ -156,7 +156,7 @@ int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 	struct extended_signature *ext_sig;
 
 	total_size = get_totalsize(mc_header);
-	data_size = get_datasize(mc_header);
+	data_size = intel_microcode_get_datasize(mc_header);
 
 	if (data_size + MC_HEADER_SIZE > total_size) {
 		if (print_err)
@@ -438,7 +438,7 @@ static void show_saved_mc(void)
 		date	= mc_saved_header->date;
 
 		total_size	= get_totalsize(mc_saved_header);
-		data_size	= get_datasize(mc_saved_header);
+		data_size	= intel_microcode_get_datasize(mc_saved_header);
 
 		pr_debug("mc_saved[%d]: sig=0x%x, pf=0x%x, rev=0x%x, total size=0x%x, date = %04x-%02x-%02x\n",
 			 i++, sig, pf, rev, total_size,
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 390862a..cefd0d8 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -56,12 +56,13 @@ struct metadata_header {
 
 static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_type)
 {
+	struct microcode_header_intel *hdr = &((struct microcode_intel *)ucode)->hdr;
 	struct metadata_header *meta_header;
 	unsigned long data_size, total_meta;
 	unsigned long meta_size = 0;
 
-	data_size = get_datasize(ucode);
-	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
+	data_size = intel_microcode_get_datasize(hdr);
+	total_meta = hdr->metasize;
 	if (!total_meta)
 		return NULL;
 
