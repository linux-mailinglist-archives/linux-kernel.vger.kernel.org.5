Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3B79D4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjILPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjILPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3F10D9;
        Tue, 12 Sep 2023 08:32:05 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hxFR6Wg/jvs1LFtHNzrklZneA4csg3LuRH7zRjYTyXE=;
        b=xzgD91+t5jn69Da6KHIKbIZAt41uYLdocLg9FjWds4vHn0ypuO9QIHGTEU+7HSm8N5RlUY
        DLu2tWMZk9BxgITW1fZeM/UY7SwNfEman7ye5AEv57KrT/3wYlKl1GAuXaHjoz7dGie1qC
        QJjnXGtfCLrihb8i0Yfuo+lQ4Xpgpm6j81mNZ586S7PuEWHE1XMUgaWzpFoVjLNW9qH6LZ
        Cs78DxN+wiRvh9AGo/ckNrZXwbtcuu00okU2jG8DgUX0y86t96qlJTUtQ/+twXUhD3I658
        jaLjZSlrP2mKEMrOBSsmaQlTuuoDyIFo0DvhlmvA7nISWwEeJCaSf5UAMKsfiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hxFR6Wg/jvs1LFtHNzrklZneA4csg3LuRH7zRjYTyXE=;
        b=lonIWQBpkjuK1iX4H/5B2XaBWpUmpvLN5pgJ0b5yNPnqNaeh4yMCoxZMe/vlGCQMe7xG8F
        Onla9i4fBLGZZHBQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Rename __tdx_module_call() to __tdcall()
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272358.27769.3326143267530497134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     5efb96289e581c187af1bc288ce5d26ed6181749
Gitweb:        https://git.kernel.org/tip/5efb96289e581c187af1bc288ce5d26ed6181749
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:01:58 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:33:32 -07:00

x86/tdx: Rename __tdx_module_call() to __tdcall()

__tdx_module_call() is only used by the TDX guest to issue TDCALL to the
TDX module.  Rename it to __tdcall() to match its behaviour, e.g., it
cannot be used to make host-side SEAMCALL.

Also rename tdx_module_call() which is a wrapper of __tdx_module_call()
to tdcall().

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/785d20d99fbcd0db8262c94da6423375422d8c75.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdcall.S        | 10 +++++-----
 arch/x86/coco/tdx/tdx-shared.c    |  2 +-
 arch/x86/coco/tdx/tdx.c           | 18 +++++++++---------
 arch/x86/include/asm/shared/tdx.h |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index e5d4b7d..6aebac0 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -40,8 +40,8 @@
 .section .noinstr.text, "ax"
 
 /*
- * __tdx_module_call()  - Used by TDX guests to request services from
- * the TDX module (does not include VMM services) using TDCALL instruction.
+ * __tdcall()  - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction.
  *
  * Transforms function call register arguments into the TDCALL register ABI.
  * After TDCALL operation, TDX module output is saved in @out (if it is
@@ -62,7 +62,7 @@
  *
  *-------------------------------------------------------------------------
  *
- * __tdx_module_call() function ABI:
+ * __tdcall() function ABI:
  *
  * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
  * @rcx (RSI)          - Input parameter 1, moved to RCX
@@ -77,9 +77,9 @@
  *
  * Return status of TDCALL via RAX.
  */
-SYM_FUNC_START(__tdx_module_call)
+SYM_FUNC_START(__tdcall)
 	TDX_MODULE_CALL host=0
-SYM_FUNC_END(__tdx_module_call)
+SYM_FUNC_END(__tdcall)
 
 /*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index f10cd3e..90631ab 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	}
 
 	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index dd16bf1..9833c81 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -66,10 +66,10 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-				   struct tdx_module_output *out)
+static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+			  struct tdx_module_output *out)
 {
-	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall(fn, rcx, rdx, r8, r9, out))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -91,9 +91,9 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
 	u64 ret;
 
-	ret = __tdx_module_call(TDG_MR_REPORT, virt_to_phys(tdreport),
-				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-				0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
+			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+			0, NULL);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -152,7 +152,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -594,7 +594,7 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
 
 	/* Transfer the output parameters */
 	ve->exit_reason = out.rcx;
@@ -814,7 +814,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 05874a5..c11c0d9 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -90,8 +90,8 @@ struct tdx_module_output {
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
+u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+	     struct tdx_module_output *out);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
