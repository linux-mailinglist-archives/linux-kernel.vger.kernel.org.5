Return-Path: <linux-kernel+bounces-95738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333B8751E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAD8B28256
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654F12F377;
	Thu,  7 Mar 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZfuQbC1D"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEE12EBE8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821850; cv=none; b=hwXsIRsPklb8/XOEJvbizLMNgSMUH9yZRgGNlMXSjpFkjsB69paaKhIi3s664L/ziYvANO+Bf1snvZqioeq9lWvCo6CsppgD4Rm+bwOaeHHak07rEZFnh8tndvtH/+SJB/N0+EaXY74AqjEcyRhnKholHqDeOMdk6HeSFuYMFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821850; c=relaxed/simple;
	bh=dz3vpzkIqCyUY6rWLBTonujjrYe27+TIW/fETFTlXh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gx7e/akxGPanSG7AU1shXd1s/KoiVICBwQ7c3GotZuNXkyZzpNF15BPkB91vW0+i0ffghAWa1RFVF8i7IUvZEEue+VXGmQ7AKA5j79tK6SccLr7QGCbegiai31RH6Q7HL0V3VKZ8UTlFRWKUKsOzS1lp1MGwUn+eXV9hCjtiKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZfuQbC1D; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412de861228so5797835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709821847; x=1710426647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUPVa2Hyx2zSqpHxd6Af/Rf3HKl55LwuFuyrPdRcwAE=;
        b=ZfuQbC1DiE14O5pr3QioaGFD22pgM8ON+3agK+n73NHJBO+ZCBJ5NtmccsfCqQSqJJ
         mTU7zQzkB5VVt5iCV+tYj67LWJ0mT7y0xWA9dj4o+CJrbWdAdPk6pITqU9LrknWYo7/3
         LrtJzRDu2XL+S0FvjSPOogr52SzAqfpdQ/4Rt3Ly3tpsoAaAyVyHP6aQNO0myob/vzSO
         Md0q6NhR3gVmCJTygLdbvM+Ne4B6lPqBEoec3KtRC7z9s9wQTx0KSfmP5osuji4KkVD8
         bfleHCjZ594OpasjTN2WsfgayhsumzYlL3ipj//2ATlIWauSP9015C8XqjB0yCxUglZE
         N8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821847; x=1710426647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUPVa2Hyx2zSqpHxd6Af/Rf3HKl55LwuFuyrPdRcwAE=;
        b=GH7COz13Zkj6Z8RmsHhhANYZJIBugxWCqf8byfYldNzOMPHpeU4ZDODUM+AqX1JmhP
         +ucPt8tt34XGB1fIaj4HPTimgJ4bYAEDKRSZzhe/1jossiFyJJqFxmqGc0HnsDgApcMo
         kCyIpoCmw/V8ZLyVGjnx3C5InWkFBEFZBMedSo3qHmCnqNiMiaHCe74RlgQJb5p7L5Df
         ykGPGjFSmRfcH5EFz29g3fqL8ac+tlDVRt1ptLvy2SdADNgju+TjwSU4l5qw+3HuOLaE
         aUDsmKwVX2ZVnw8hYlZJq5i7j0sZOH+NTV33wxOcFEiuUgtWMmyr2SRZngxmxpvhOzGJ
         Q+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfcHqA8fp5scgoYbwvCfEXud0TzehsSHDZ7qW1sVO3nDumm9SuHosuJJsFrhyvbjUz0P2ghhmCBnOaKUmSU2mH5l5GRMTpGWo4l7cw
X-Gm-Message-State: AOJu0YxnHHQxdLdGzGhZULM2JaUNLm0EtU4yIQ/KDhOF4gvrzjs9frH4
	OyM4MWKFlbrtUuoF4hLm3QkVFgWN7UPfvKA5sOxqRnJq3xzrxWNwxJjNUJDttIaul39H6g==
X-Google-Smtp-Source: AGHT+IEIvz439vkfTG48qPLZx3L/XT1Rpuv9FNQCGg/8+fFw23Icnwq61FBDJ7fHZiI/e17hMlJ401VX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:5405:b0:412:f751:d692 with SMTP id
 he5-20020a05600c540500b00412f751d692mr75644wmb.4.1709821847170; Thu, 07 Mar
 2024 06:30:47 -0800 (PST)
Date: Thu,  7 Mar 2024 15:30:32 +0100
In-Reply-To: <20240307143027.206179-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307143027.206179-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4634; i=ardb@kernel.org;
 h=from:subject; bh=VMr6NZlefn1pID564dxT72LlWE97dhEcw6Eet4966XM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXl+Q4H3xuTVZKvKgTXvF7FI9xwhIGpavsbXWb2Hlb79
 IB10X86SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERc1Bj+ykeVZG/x3V2y/dEC
 n6SDUel1D2p3GbetiltvuV/kkPdzA0aG6z+reP/eCPKcmD8vW6YyJPO27I3g6U9D7b7fl7rNKy3 FCQA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307143027.206179-10-ardb+git@google.com>
Subject: [RFC PATCH v6.10 4/4] x86/boot/64: Avoid intentional absolute symbol
 references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@google.com
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The code in .head.text executes from a 1:1 mapping and cannot generally
refer to global variables using their kernel virtual addresses. However,
there are some occurrences of such references that are valid: the kernel
virtual addresses of _text and _end are needed to populate the page
tables correctly, and some other section markers are used in a similar
way.

To avoid the need for making exceptions to the rule that .head.text must
not contain any absolute symbol references, derive these addresses from
the RIP-relative 1:1 mapped physical addresses, which can be safely
determined using RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8fd80cf07691..ce1a77e26ce3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -84,9 +84,11 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long va_offset)
 {
-	unsigned long vaddr, vaddr_end;
+	unsigned long paddr, paddr_end;
 	int i;
 
 	/* Encrypt the kernel and related (if SME is active) */
@@ -99,10 +101,10 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
+		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
 
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
 			/*
 			 * On SNP, transition the page to shared in the RMP table so that
 			 * it is consistent with the page table attribute change.
@@ -111,11 +113,11 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			 * mapping (kernel .text). PVALIDATE, by way of
 			 * early_snp_set_memory_shared(), requires a valid virtual
 			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 * mapping so use the PA to get a *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
 
-			i = pmd_index(vaddr);
+			i = pmd_index(paddr - va_offset);
 			pmd[i] -= sme_get_me_mask();
 		}
 	}
@@ -139,6 +141,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 				  unsigned long va_offset)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
+	unsigned long va_text, va_end;
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -165,6 +168,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	if (load_delta & ~PMD_MASK)
 		for (;;);
 
+	va_text = physaddr - va_offset;
+	va_end  = (unsigned long)&RIP_REL_REF(_end) - va_offset;
+
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
@@ -225,7 +231,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
 		int idx = i + (physaddr >> PMD_SHIFT);
 
 		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
@@ -250,11 +256,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(va_text); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(va_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -262,7 +268,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	return sme_postprocess_startup(bp, pmd);
+	return sme_postprocess_startup(bp, pmd, va_offset);
 }
 
 /* Wipe all early page tables except for the kernel symbol map */
-- 
2.44.0.278.ge034bb2e1d-goog


