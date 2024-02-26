Return-Path: <linux-kernel+bounces-81630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE56867886
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C721F2D917
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B7412C806;
	Mon, 26 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QEPb+Mj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAB12C55D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957821; cv=none; b=H2SltgSxdgHq3p+tuAZnjTpVJqcvHHhrE4BiQV/fSNJPXjbU5sTxUnlUicl7JBLVIJeUcWf73hcMHjaIke1Hic8zrdU3IBRpde0ueGQ3PIlB+PVFgg62XYBZexFvOZV448w+sivXm7qvA3qFdB5G/gRsnXqZvqdWKUZF87nPliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957821; c=relaxed/simple;
	bh=WZPNjU+tKWbG1/7EwXfp1HjOJvLOdEPU1KuRuZ22CGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bm7V92jCUs1jbnVf2S6aLPSpeYfRE8yIOztToaqHwNR2tkjy1JchPuhRfNcCnGSOUt+uUPPpN/LMFNLUq8vLG9HKVOfuNgp/kdqKfiIvYjodMVXWv4p8dSc1WPQUjILJ4IBMeqClh74rqPqq9q9/HkxUWbzhOM5V//bvimEec74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QEPb+Mj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so4271653276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957818; x=1709562618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBDJ41pn3iOna4rTXtxPzeJ6vfMVADf3iDfGB7g+R4=;
        b=2QEPb+MjnI56wEfb45TsVm3qQ9DWpl1NDS/j2MgF8PlRNmOKCcXGcvwpLz1e9I6sqx
         hO4m69w2NtRCo3MyTwaQwt8IVdXEWI6coOB4IG6/MgQaX0u4GEKgrdjnflL/ymJkZ+F0
         vKUhSNIF4Zf6yt/NV8Q0I1dsujzFFzxL265oXueGWwufVlrqWrOEVfqH0fMkAlDzj9cd
         Z66lQLsSQ7+uT5rONPHqjvtH/enY17ms1I6xfcCj+d4gvGFX/I3MSWVJb3KdOdo3/cnL
         /KcuLqe3AujVzukS99Ns+GjDqzW8oGZeIqcCAA+/v9qr+9R48Qp4NhmQuXlkWCT0/amw
         P11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957818; x=1709562618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBDJ41pn3iOna4rTXtxPzeJ6vfMVADf3iDfGB7g+R4=;
        b=kE0Uq60hCoHmPK/YF0EvU3jCE6qXVacDxd9eWOrobzfRtf/zYk9tBcn0ZqRdJGtPps
         kUfISCXbyxJib6Hxjtsk0Uo/y0MdiHi6T1rv2MhCCwOxALfNRgPWgHd3gnRmLAGg7Xu/
         rkX+kGZmGmULDef7tcov/Uk9GmbWlnOPp5K8qXnsg6fxzsKI/ORF0QDjBnTLE9h2XDyP
         p3VQNsbch4yPXQ+FqCjuLEiHBk7rBj+Lblkx3auhjliifjnK7jm4AgboWrtVsBXP255I
         IRuoIbNT0XjBWAQNoOAQ9KKXbFtlx3wJ0xXJ6e+InzVcswuqzRBMqc+IFcUerytQ07VV
         qklg==
X-Gm-Message-State: AOJu0Yz15EXecM9LadPmmSQCShzCWF6PFZDpFYiKRhjht7c9VGhy/L61
	RJ+4Nxdfg4CbHnQg/LbbQ3ji0qZdeZPNVSOB7iUQ0I8R+LK2QhwczsUXIhyvnRGVadMIFo6qJnb
	fVWNHVnaGlqdhPP32BG0A42F4AgEtLfNnB4/s/uHRxSxUMPwI3PjyVHaHiJIGJ3DeNI5oOMs1YJ
	P5C0jkatCvkWzv4Lk2w3EGspQR3/a2bw==
X-Google-Smtp-Source: AGHT+IGhfWgLDKjgKBzD9HHo/JGuu3u5CiubkHT0Pq0lnQt5M9sGLUKvkoIJLTqVuGN9vlyXVUFm/y8e
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1003:b0:dc6:e5e9:f3af with SMTP id
 w3-20020a056902100300b00dc6e5e9f3afmr2087407ybt.9.1708957818551; Mon, 26 Feb
 2024 06:30:18 -0800 (PST)
Date: Mon, 26 Feb 2024 15:30:01 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-20-ardb+git@google.com>
Subject: [PATCH v6 08/10] x86/sme: Move early SME kernel encryption handling
 into .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section is the initial primary entrypoint of the core
kernel, and is entered with the CPU executing from a 1:1 mapping of
memory. Such code must never access global variables using absolute
references, as these are based on the kernel virtual mapping which is
not active yet at this point.

Given that the SME startup code is also called from this early execution
context, move it into .head.text as well. This will allow more thorough
build time checks in the future to ensure that early startup code only
uses RIP-relative references to global variables.

Also replace some occurrences of __pa_symbol() [which relies on the
compiler generating an absolute reference, which is not guaranteed] and
an open coded RIP-relative access with RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/mem_encrypt.h |  4 +-
 arch/x86/mm/mem_encrypt_identity.c | 40 ++++++++------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b1437ba0b3b8..f922b682b9b4 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -47,7 +47,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
 
-void __init sme_encrypt_kernel(struct boot_params *bp);
+void sme_encrypt_kernel(struct boot_params *bp);
 void sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
@@ -81,7 +81,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
 
-static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
+static inline void sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0180fbbcc940..174a7192c9cb 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -41,6 +41,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 
+#include <asm/init.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/coco.h>
@@ -95,7 +96,7 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
 	pgd_t *pgd_p;
@@ -110,7 +111,7 @@ static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 	memset(pgd_p, 0, pgd_size);
 }
 
-static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
+static pud_t __head *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -147,7 +148,7 @@ static pud_t __init *sme_prepare_pgd(struct sme_populate_pgd_data *ppd)
 	return pud;
 }
 
-static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -163,7 +164,7 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
-static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
+static void __head sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 {
 	pud_t *pud;
 	pmd_t *pmd;
@@ -189,7 +190,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
-static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd_large(ppd);
@@ -199,7 +200,7 @@ static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
+static void __head __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 {
 	while (ppd->vaddr < ppd->vaddr_end) {
 		sme_populate_pgd(ppd);
@@ -209,7 +210,7 @@ static void __init __sme_map_range_pte(struct sme_populate_pgd_data *ppd)
 	}
 }
 
-static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
+static void __head __sme_map_range(struct sme_populate_pgd_data *ppd,
 				   pmdval_t pmd_flags, pteval_t pte_flags)
 {
 	unsigned long vaddr_end;
@@ -233,22 +234,22 @@ static void __init __sme_map_range(struct sme_populate_pgd_data *ppd,
 	__sme_map_range_pte(ppd);
 }
 
-static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
-static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
 }
 
-static void __init sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
+static void __head sme_map_range_decrypted_wp(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC_WP, PTE_FLAGS_DEC_WP);
 }
 
-static unsigned long __init sme_pgtable_calc(unsigned long len)
+static unsigned long __head sme_pgtable_calc(unsigned long len)
 {
 	unsigned long entries = 0, tables = 0;
 
@@ -285,7 +286,7 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+void __head sme_encrypt_kernel(struct boot_params *bp)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
@@ -320,9 +321,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *     memory from being cached.
 	 */
 
-	/* Physical addresses gives us the identity mapped virtual addresses */
-	kernel_start = __pa_symbol(_text);
-	kernel_end = ALIGN(__pa_symbol(_end), PMD_SIZE);
+	kernel_start = (unsigned long)RIP_REL_REF(_text);
+	kernel_end = ALIGN((unsigned long)RIP_REL_REF(_end), PMD_SIZE);
 	kernel_len = kernel_end - kernel_start;
 
 	initrd_start = 0;
@@ -339,14 +339,6 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	}
 #endif
 
-	/*
-	 * We're running identity mapped, so we must obtain the address to the
-	 * SME encryption workarea using rip-relative addressing.
-	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
-
 	/*
 	 * Calculate required number of workarea bytes needed:
 	 *   executable encryption area size:
@@ -356,7 +348,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 *   pagetable structures for the encryption of the kernel
 	 *   pagetable structures for workarea (in case not currently mapped)
 	 */
-	execute_start = workarea_start;
+	execute_start = workarea_start = (unsigned long)RIP_REL_REF(sme_workarea);
 	execute_end = execute_start + (PAGE_SIZE * 2) + PMD_SIZE;
 	execute_len = execute_end - execute_start;
 
-- 
2.44.0.rc0.258.g7320e95886-goog


