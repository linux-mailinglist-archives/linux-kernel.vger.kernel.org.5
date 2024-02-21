Return-Path: <linux-kernel+bounces-74645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB485D734
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556E01F21AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3047781;
	Wed, 21 Feb 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLT/YX0e"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C646424
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515376; cv=none; b=qSS0szPhjmfux98QLZQx0xXT9IAuWZpHN8gVf2cp2DwAevEr3BEn8vNN5f9Kl7u1oIxdAUYURDIqg3UOgdSrEeSnOUAA+DnY5Esmqcr23B1vAqr0/zdcxPjl+QJmI2J+q24fIPYMxSAsViFmILResaT3jVBViZuMbfizjCx+bYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515376; c=relaxed/simple;
	bh=dRE0REehaE79mQAOudLPe6thvzCULsyHIPQfD/woex8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IvyskZXL2deWUelzrshGul0HPozM/FdtLN+IqnifClPUMKwztfyI4X3tqncx+rh1cXDlvWtOFY2LTVv2+z++Cs2y8w5i9usybW6ro2yd+HQ7DUjnDjuSAWYEOiAy1lvVkhKnJI+CE4zavenWy18TXWrvqOf8CQ6lvWPzWvNn+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLT/YX0e; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d51bb9353so1411308f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515372; x=1709120172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1RTMbx8aPOdGUmQigoxFTqq7Alxv8e0fhW/7jCZ7hc=;
        b=fLT/YX0e4chPUubpXwC0TiRwEMV4uyxTkoSIYf4GlhfXFHW1v364iiVM0S3467ldkG
         9IZDxigEnAosVskv2/hwsbI3id0E5mOox7Az1x/rwjy8r8vA1zozD2u6+h+s3x1rNehh
         n4nG054R7I8guua93NlbTPrzi9VIlaOlMRR3C58GNMELWwi7dr42HjXc62eG7VnXMFbd
         Fq/2sTqshJGe/1gCzzp2TqkV34blrrz3Lc1LAP1ja7G9X72wyQIcH9rIJ+zDyBL252On
         2wp60/f7WD7GXjZ8Os0lFoa8cHxYqcKE6RRJPTwpbfjIgWcIr7nuCPghe/0VBp9bIh5d
         XLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515372; x=1709120172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1RTMbx8aPOdGUmQigoxFTqq7Alxv8e0fhW/7jCZ7hc=;
        b=wL8uf8/nHGllSJeoyMh9wAHvZG3vH0v1gz71DRgWm5Ym0PPZEkmy05YpE6DzpEwiHE
         YDoUqr0G6bW12T4F7DTJ0vO7i+49Hzio+F3PWdZ4htFMfOOhHYjHa8iR7sM87+Ia7GMO
         GgQUOicM0TC3HSs7AGUlk1KNLctqZTD/obxmpKKPgRlacGZ9CrlhE+OSCzM5Q99M6cg0
         34X63bSZT49gvs+WDe4QWe+uHLVxMdmneselMb6va4u4fQQHaih3yy4MxNsA4GSZxeMF
         xjhubGNnAGEarLVDZml7OscxrqtRz6vGhtnkvoazkHCliL/95AIzuZxuoM77iBUMLO4y
         gBtw==
X-Gm-Message-State: AOJu0Yy+2FzS+IU5D9pYT/YFULjh4UjVNhvNpO+Fv+q3TgOkHUQdiRoo
	mrqIzwUzgABoV3nWtjZdjVt0b7SzIjl/DmeUKaJzn5EqXhyyIiqofYJUbCAFxiL/XeHeIqgOI0D
	N/xqbskUL7tRuf0nKKbKcHiNjtrHmuZRYNr0ROsCuRqFNsq/hjtSctNB8O/DMDCaxp6lqdFqRav
	AkEcm2as0AX/d3PgdbziEek/DbcxOL8Q==
X-Google-Smtp-Source: AGHT+IFEK0Hqt+PVuK1w1JZ0bLodz+vrVvbwYJui0gZBFyrqTY4XzM8zlae7RVEvcY21NCVb0DyAs1aD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1e8f:b0:33d:269e:1327 with SMTP id
 dd15-20020a0560001e8f00b0033d269e1327mr25078wrb.3.1708515370396; Wed, 21 Feb
 2024 03:36:10 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:22 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7382; i=ardb@kernel.org;
 h=from:subject; bh=LAOkk6glECx/a1Ernwj65OY7RC++QF53CdqPGnTSEFg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/a9zp7AHbTt95WHF51ipif/fyz7k4uw6+lfOhzWta
 4nT/X+pHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiCvMYGa5L3HbU9bzJxPI9
 2lxkOpMmX7/gqZcsp/RPRq3SEok8HM/w35GDq+sKW+6KvmlOpiGSCbe+5ygfuSIVw/S3ob1itv0 6BgA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-33-ardb+git@google.com>
Subject: [PATCH v5 15/16] x86/sev: Move early startup code into .head.text section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for implementing rigorous build time checks to enforce
that only code that can support it will be called from the early 1:1
mapping of memory, move SEV init code that is called in this manner to
the .head.text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c |  3 +++
 arch/x86/include/asm/sev.h     | 10 ++++-----
 arch/x86/kernel/sev-shared.c   | 23 +++++++++-----------
 arch/x86/kernel/sev.c          | 14 +++++++-----
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 073291832f44..bea0719d70f2 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -116,6 +116,9 @@ static bool fault_in_kernel_space(unsigned long address)
 #undef __init
 #define __init
 
+#undef __head
+#define __head
+
 #define __BOOT_COMPRESSED
 
 /* Basic instruction decoding support needed */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index bed95e1f4d52..cf671138feef 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -213,16 +213,16 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned long npages);
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages);
+void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+				  unsigned long npages);
+void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+				 unsigned long npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __init __noreturn snp_abort(void);
+void __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ae79f9505298..0bd7ccbe8732 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -93,7 +93,8 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void __noreturn sev_es_terminate(unsigned int set, unsigned int reason)
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
 {
 	u64 val = GHCB_MSR_TERM_REQ;
 
@@ -330,13 +331,7 @@ static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid
  */
 static const struct snp_cpuid_table *snp_cpuid_get_table(void)
 {
-	void *ptr;
-
-	asm ("lea cpuid_table_copy(%%rip), %0"
-	     : "=r" (ptr)
-	     : "p" (&cpuid_table_copy));
-
-	return ptr;
+	return &RIP_REL_REF(cpuid_table_copy);
 }
 
 /*
@@ -395,7 +390,7 @@ static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
 	return xsave_size;
 }
 
-static bool
+static bool __head
 snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
@@ -532,7 +527,8 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -574,7 +570,7 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
  * page yet, so it only supports the MSR based communication with the
  * hypervisor and only the CPUID exit-code.
  */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
@@ -1025,7 +1021,8 @@ struct cc_setup_data {
  * Search for a Confidential Computing blob passed in as a setup_data entry
  * via the Linux Boot Protocol.
  */
-static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
 {
 	struct cc_setup_data *sd = NULL;
 	struct setup_data *hdr;
@@ -1052,7 +1049,7 @@ static struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
  * mapping needs to be updated in sync with all the changes to virtual memory
  * layout and related mapping facilities throughout the boot process.
  */
-static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 {
 	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
 	int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ef7ae806a01..33c14aa1f06c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -25,6 +25,7 @@
 #include <linux/psp-sev.h>
 #include <uapi/linux/sev-guest.h>
 
+#include <asm/init.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
@@ -682,8 +683,9 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-				  unsigned long npages, enum psc_op op)
+static void __head
+early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+		      unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -739,7 +741,7 @@ static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned long npages)
 {
 	/*
@@ -2062,7 +2064,7 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
  *
  * Scan for the blob in that order.
  */
-static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2088,7 +2090,7 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
-bool __init snp_init(struct boot_params *bp)
+bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
 
@@ -2110,7 +2112,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init __noreturn snp_abort(void)
+void __head __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


