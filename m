Return-Path: <linux-kernel+bounces-88169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883886DE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A363B22276
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EF6A337;
	Fri,  1 Mar 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hrytu87r"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D341E886
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285004; cv=none; b=DmQWnLbYqRk+o9w+v45B20FmrJ2ZHHZE8mLGPOrZ0c3YV55QUISRxTc7hPDajkv94AB6Ej3fZ6UoF2adY+8CpTdCSXLKn18Z8G8yPKIR1o9s98GidOyH6Y69Cybi9GmstZhaEWLRX/dzrwTLqDspSrxCk4bPT3gQJRkumG+kbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285004; c=relaxed/simple;
	bh=GXAk2kN1CTNZcSPb0xo/khVDgAjh/yl/yqVe3qPZCWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMGQPOi4u5OjVDGMWdCTBMIPAAkxegJMGVlRCf4FVCCCG5kRk3P6eN7SUXrYdhg52OSAyO443F65ulVaFuqnX/u8yp6LhUXjVnS/pPalfXtL/raLgONk3aBwoL64aWcK6s7O4lD5UPMjtqWDlhlPZ7mCN6uZiLu405speu/lXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hrytu87r; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so23166141fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709285000; x=1709889800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bwm42ASg+Pn4jchqsA5u8tprYh0PuExgujdSk24Zd8=;
        b=hrytu87rixLQYgV1MR6B5Go6MbsecCNyDU8wutYVMIaP67Dx+eIYH43Gfip7lo+71y
         ZMcPF1kUqjUG2RZqrTNI2brU9CneXP8QD1lv7tB6qADON4O58gEgox7HWBlYO5V+6aXX
         BCbLi32Fudvfo8947uzFYGXiJUTY1xXk8DuS9W6v2/PM+gSTBqc1gIiH1LqBVlcfbKY5
         NGaSYShAYdZw0fz/fhECIPFK3WRQctxAXiB/0TJzv6ZyUhi5631Uoj/P022pcGPRcdzh
         LU1wxRBiHbVe4YdxS/92I7Zml1dfopPMKG8ksnQiZRXmcWMuG/acOaAhmlanjEsaKVmZ
         38UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285000; x=1709889800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bwm42ASg+Pn4jchqsA5u8tprYh0PuExgujdSk24Zd8=;
        b=hmlhCHY1HYbNnh7je/tFfrdmqkW2y2PJb9H58ho84X5ZSJUtL0Uic0GbPBN1LR3gBw
         8UhsUHVtbm/Jt+9291sE80lDbgV5YXKXZ26jbvvxBPkMgdfwtiVMByPzDOkOKWj9UnK4
         kh8EOntybH/dr+aAuGAXmhNuXR9NflzVLhT81cF1Tg4gfBBe9z7HIvrFpyGzflK2IoUr
         qmAe5C/JfjHAYR1xGYcCkcxds5rLzFMDWRNEvcaHKF62YWxwjDBJbG2HRQ2yP7hq6p7t
         qlMQDZcXKMXEMzpeiWmGcOMDbH4wb7ya7g2TKzrlbVZJZYKE/Yt4gSh5nbqO42tkOhqP
         A+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXg1fbTxX5QngY2ZubfNCf9z1pMrM4b794v7qAecLWuGKwWLnGHmzayNWaqJyZFPTj5scc2ViKIQOaJjgy8FWGQwueLfc4ipsNZIjTP
X-Gm-Message-State: AOJu0YyLjuE+WfTLbRzvucWYwOVnYzsXoEEk7AmvTwmabC1Eucr0CCOG
	V0E/kuz8+zPkaAjyoI76ShfIZdxRSfnSgwl8Qff8kNccch1J1b/C73o2YuFbA4s=
X-Google-Smtp-Source: AGHT+IFkOrueHwu+dCituNGudpmJQSWFJOG3RRqM9+lTLTigiW3MgJH56JMq1RpUEmcE9Sa98B2xOQ==
X-Received: by 2002:a2e:a4cb:0:b0:2d3:365e:9d02 with SMTP id p11-20020a2ea4cb000000b002d3365e9d02mr635537ljm.28.1709285000535;
        Fri, 01 Mar 2024 01:23:20 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l33-20020a05600c1d2100b00412ca88537dsm374810wms.0.2024.03.01.01.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:23:20 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 8/9] mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:54 +0100
Message-Id: <20240301091455.246686-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After some adjustments, both architectures have the same implementation
so move it to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c | 27 ---------------------------
 arch/riscv/mm/hugetlbpage.c | 22 ----------------------
 mm/contpte.c                | 21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b8abbd5ace4f..d6ddaf282a94 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,33 +284,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_ptep_set_wrprotect(struct mm_struct *mm,
-			     unsigned long addr, pte_t *ptep)
-{
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
-	int ncontig, i;
-	size_t pgsize;
-	pte_t pte;
-
-	if (!pte_cont(READ_ONCE(*ptep))) {
-		ptep_set_wrprotect(mm, addr, ptep);
-		return;
-	}
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
-
-	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-	pte = pte_wrprotect(pte);
-
-	hugeprot = pte_pgprot(pte);
-	pfn = pte_pfn(pte);
-
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
-}
-
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index fdb633844d4b..e6cbb6fb2904 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,28 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_ptep_set_wrprotect(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep)
-{
-	pte_t pte = ptep_get(ptep);
-	size_t pgsize;
-	pte_t orig_pte;
-	int pte_num;
-
-	if (!pte_napot(pte)) {
-		ptep_set_wrprotect(mm, addr, ptep);
-		return;
-	}
-
-	pte_num = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-	orig_pte = pte_wrprotect(orig_pte);
-
-	set_ptes(mm, addr, ptep, orig_pte, pte_num);
-}
-
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr,
 			    pte_t *ptep)
diff --git a/mm/contpte.c b/mm/contpte.c
index 3b65c49c6d4b..f7f26d2cfa23 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -22,6 +22,7 @@
  * huge_pte_clear()
  * huge_ptep_get_and_clear()
  * huge_ptep_set_access_flags()
+ * huge_ptep_set_wrprotect()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -230,3 +231,23 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	return 1;
 }
+
+void huge_ptep_set_wrprotect(struct mm_struct *mm,
+			     unsigned long addr, pte_t *ptep)
+{
+	int ncontig;
+	size_t pgsize;
+	pte_t pte;
+
+	if (!pte_cont(ptep_get(ptep))) {
+		ptep_set_wrprotect(mm, addr, ptep);
+		return;
+	}
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+
+	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+	pte = pte_wrprotect(pte);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+}
-- 
2.39.2


