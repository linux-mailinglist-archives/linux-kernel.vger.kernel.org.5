Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F6794682
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbjIFWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjIFWqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:46:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AABB19BE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:46:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26d63b60934so446847a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694040387; x=1694645187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a8kBLbMJIUfrDOfQ2nMnVDZgkBkWKK9DgBH83jtLTQY=;
        b=o8vzXdMhjyKi3KiF4DbMjHhELdaCSwheMfH9B//LAn+u0zmD1jIkTu8W7kghs3BFK1
         rrt3e8wpAFlXes/Jwz3We+KhNF2ml9hKjRf8wAIsFcqQ3W+EuTUm487rDXdTyvglJMdi
         FHKR7o9v5IlNuyEYdU9CQi2NQ9yOKtTVgCFV/kGQX0ZgYw1qa+BG3lwODNAxS1pLn0Xn
         5brSe0UlCPgsiW0pTtPTnopOROoOBsYM3zhptBnRlKAS9xrrxTdRrpjb1pDWgI0YBGO1
         nvrX0kIruCl9qwmLFLO/s0xrzePlKlXrc+8guNZiC57Gf44oTIeY+DpTvruf91KM2O8f
         lrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694040387; x=1694645187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8kBLbMJIUfrDOfQ2nMnVDZgkBkWKK9DgBH83jtLTQY=;
        b=S2tB3lGnVVeebIRjrAu8Kx/y6jKGSI1Gey89vXZ4P8Tpl9KdSKqqF7pZNAJzVyvB+h
         TcajZt+YDOGQChoYpoJ+zM8szMbw3/s3cJwU6d4vPyJ05fhj1KVPxnPEtHI+NL1w+ZNu
         ueZ736xHoPMFgJa1I57IP9F4wY6pM6Sj44wdK8PEP+ZIiKEhV9Lh1QU9KS6CKGwkCDox
         NlQA0ckon3DiikEpod/Ch1G6Kx+iWNtGFKop5cDwTwuqoIhARw1kX6siiBMvTwpx0phm
         Nz0CtRWnuob0yIzocFtyuhK0lA0dAOrGH+zuZVxIAyDNVLVKycVBgcH8ZPg6xzb9LpRk
         FaCw==
X-Gm-Message-State: AOJu0YyXfV1Wq8GThZ3wiPKg5DEtTiDOYKWXsbvKPd68k/6gmipytt/X
        FtTjkwocIwIYmoeG0kdUDozJsVyLE5T17/h5Kwx9QJBneY9RLdFQJS0FDHScW6pJhcv9AniA4Lq
        B94ogi0be8JZwxBu4RSGE2RLBUfdfPZraTa1hPvg15JL+/sweCx/BTZZASb6Jfu5y6aWaZypxVw
        Q=
X-Google-Smtp-Source: AGHT+IEUAS5dVw1yy/udY/GOoBYfA+aaazD2euPW5YHvhBX91zWVOARIhHL6D7WMTA+yb3YtZSppclRuT8xhtw==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a17:90a:cd03:b0:26d:1fd8:135e with SMTP
 id d3-20020a17090acd0300b0026d1fd8135emr4208700pju.2.1694040387325; Wed, 06
 Sep 2023 15:46:27 -0700 (PDT)
Date:   Wed,  6 Sep 2023 15:45:41 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906224541.2778523-1-acdunlap@google.com>
Subject: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early #VC handler
From:   Adam Dunlap <acdunlap@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Adam Dunlap <acdunlap@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the early #VC handler before start_kernel,
boot_cpu_data.x86_virt_bits is not yet initialized.
copy_from_kernel_nofault references this variable, so it cannot be
called. Instead, simply use memcpy.

Usage of this uninitialized variable is currently causing boot failures
in the latest version of ubuntu2204 in the gcp project, but in general
reading the uninitialized variable is undefined behavior. If the
variable happens to be 0, UB also happens due to a bit shift by 64.

Fixes: 1aa9aa8ee517 ("x86/sev-es: Setup GHCB-based boot #VC handler")

Tested-by: Jacob Xu <jacobhxu@google.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
---
 arch/x86/boot/compressed/sev.c |  4 ++--
 arch/x86/kernel/sev-shared.c   |  4 ++--
 arch/x86/kernel/sev.c          | 22 ++++++++++++++--------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3c..0829ae00a885 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -73,7 +73,7 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 	boot_wrmsr(MSR_AMD64_SEV_ES_GHCB, &m);
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt, bool is_early)
 {
 	char buffer[MAX_INSN_SIZE];
 	int ret;
@@ -290,7 +290,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code, true);
 	if (result != ES_OK)
 		goto finish;
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2eabccde94fb..616be2e9a663 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -176,7 +176,7 @@ static bool vc_decoding_needed(unsigned long exit_code)
 
 static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 				      struct pt_regs *regs,
-				      unsigned long exit_code)
+				      unsigned long exit_code, bool is_early)
 {
 	enum es_result ret = ES_OK;
 
@@ -184,7 +184,7 @@ static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 	ctxt->regs = regs;
 
 	if (vc_decoding_needed(exit_code))
-		ret = vc_decode_insn(ctxt);
+		ret = vc_decode_insn(ctxt, is_early);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed453de..93f117e5cddf 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -270,9 +270,15 @@ static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
-				unsigned char *buffer)
+				unsigned char *buffer, bool is_early)
 {
-	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+	if (is_early) {
+		memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+		return 0;
+	} else {
+		return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip,
+			MAX_INSN_SIZE);
+	}
 }
 
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
@@ -304,12 +310,12 @@ static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 		return ES_DECODE_FAILED;
 }
 
-static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt, bool is_early)
 {
 	char buffer[MAX_INSN_SIZE];
 	int res, ret;
 
-	res = vc_fetch_insn_kernel(ctxt, buffer);
+	res = vc_fetch_insn_kernel(ctxt, buffer, is_early);
 	if (res) {
 		ctxt->fi.vector     = X86_TRAP_PF;
 		ctxt->fi.error_code = X86_PF_INSTR;
@@ -324,12 +330,12 @@ static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 		return ES_OK;
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt, bool is_early)
 {
 	if (user_mode(ctxt->regs))
 		return __vc_decode_user_insn(ctxt);
 	else
-		return __vc_decode_kern_insn(ctxt);
+		return __vc_decode_kern_insn(ctxt, is_early);
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
@@ -1829,7 +1835,7 @@ static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_co
 	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, error_code);
+	result = vc_init_em_ctxt(&ctxt, regs, error_code, false);
 
 	if (result == ES_OK)
 		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
@@ -1969,7 +1975,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 
 	vc_ghcb_invalidate(boot_ghcb);
 
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code, true);
 	if (result == ES_OK)
 		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
 
-- 
2.42.0.283.g2d96d420d3-goog

