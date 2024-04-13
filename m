Return-Path: <linux-kernel+bounces-143441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9478A3915
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04451F21D29
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6C4C83;
	Sat, 13 Apr 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA163uBU"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F334A24
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967781; cv=none; b=jrdjbT4d0ol1sw9kQn7fl3CJbLj/Jld3yIxXIecC/Dx2F18NEcXWuPfz5WGXYQe0OxWv0hIk21x3wCh1g0mqrhenJs7W7rxPkjmUmnjrEaD4q9H/lQbBnlwAVVfXNu3BO/eVY7MExgw5eotBkc5ZAL/XslZ3/tZ5wo6qtKnbCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967781; c=relaxed/simple;
	bh=KF/2qsAtMNyFsi0x5yQQgTmdnX4ZegKINAVOh0xmpXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFynXGrrvfcgADQCIB1RSAv9IL0VZW7bu4rklx+fclPhpIGMFx8aWzQs9orosmBzXfMi1ufMuh+ucEJxsSAyue5Dec8rH7Nz3vz5n+WUqFLlq151AJSCQfNahYIXxXsfGQOmRjAzJtPenyJ86qy30CMOI+ZkZMEEo7Q84yQWO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA163uBU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3ff14f249so11126195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712967779; x=1713572579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OvPRCdhoiay+bQidKgk1FXNIyrlSTLCMUCQGI9Z8wE=;
        b=eA163uBU9qFga5qEnpwMCjq6dKE+aTEg8KemKiU0mpATuAq0c9L5VvM1CyGLjf4AR1
         +WLRXAJ0cH1HW0fRJkuBW7BW7/GyeoZBR69B4G81kFrhrLljwkvfgap1YdP6cFuibHUq
         2He6/iB/qRAg9zxWnlGvZo1VZ5a1L7ulO6aRn0uwfFBJl3rZ29tWJgcABuxDBMPtEdmk
         So1B7ZxfUPHJPsDjrvD+GpGBSS3R9i550WxDuGZ4r/J+89107ku9o9+w6Ce44zuGbK5r
         2Y3nfsHxqveaxkWsE//inAd37RfwZ/+CRqcpsP02mRUnTgOjAqxdsai3qK1IN02OmYLE
         aUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967779; x=1713572579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OvPRCdhoiay+bQidKgk1FXNIyrlSTLCMUCQGI9Z8wE=;
        b=TMpoPiNqUctgInZikZ55r8meGAp2a6sOeJCFyF9fyRVMhx2/aHnWFpfqGZFHIZmEwu
         WFI9der9qmsfZPgIov++AN8w4kaNUszpBcDn8uMU5+/n4uKP0MJBpFVRQ97F5KdYbVfk
         Z1ekPuCZ5lGmBvaQuR0WdzslRYH5ogUR1CIiEqyzFx4tfqvK8RddCifmPIWewVS/oVeo
         J2nQrwEwIMu/s5cRmciFsLEbfJbg3foB8mqfSsh58kdmKfY1xM8ltfdnZOKnFr0EyaKw
         Af28u0HQ1yV5r0v4TIFlwRuPV/jqPXXzyGaac4omQOKUj1MEHEDglKPN5adLqu0LOvVY
         GuAA==
X-Forwarded-Encrypted: i=1; AJvYcCX/SmS3dUn0yjJ9ncXmXirYDFyUWi5hOKuFGuJJ4iqTt6IItj7+qo1xJgHGidABIaF0SLywJBM35mpOHz6OOwn2FBkRTlyszEpHsNNp
X-Gm-Message-State: AOJu0YzQ93vQ4a9HD9saJH/TDitSb9Q1xKnxmnJ55oMnEXM3WRcYNAde
	pzlrnUJhx/cpsAqaKBYgQsejYjiCVsXqQ/6QUq6ZZ9sxVybA2cwU
X-Google-Smtp-Source: AGHT+IE6RtlVv/rhkh0e6s0wZJMcHXtBBXCMRcTjEYkjnCpyvQLOKnLnjHsAXiCwN9+1akOrIapfJw==
X-Received: by 2002:a17:903:2443:b0:1e5:62:7a81 with SMTP id l3-20020a170903244300b001e500627a81mr5783849pls.22.1712967778837;
        Fri, 12 Apr 2024 17:22:58 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001e2a4ac7bf9sm3569618pld.111.2024.04.12.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:22:58 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v6 2/2] mm/arm64: override clear_young_dirty_ptes() batch helper
Date: Sat, 13 Apr 2024 08:22:19 +0800
Message-Id: <20240413002219.71246-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240413002219.71246-1-ioworker0@gmail.com>
References: <20240413002219.71246-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-pte get_and_clear/modify/set approach would result in
unfolding/refolding for contpte mappings on arm64. So we need
to override clear_young_dirty_ptes() for arm64 to avoid it.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 28 ++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9fd8613b2db2..f951774dd2d6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1223,6 +1223,28 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
 		__ptep_set_wrprotect(mm, address, ptep);
 }
 
+static inline void __clear_young_dirty_ptes(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		pte = __ptep_get(ptep);
+
+		if (flags | CYDP_CLEAR_YOUNG)
+			pte = pte_mkold(pte);
+		if (flags | CYDP_CLEAR_DIRTY)
+			pte = pte_mkclean(pte);
+
+		__set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
@@ -1379,6 +1401,9 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
+extern void contpte_clear_young_dirty_ptes(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep,
+				unsigned int nr, cydp_t flags);
 
 static __always_inline void contpte_try_fold(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep, pte_t pte)
@@ -1603,6 +1628,17 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
+#define clear_young_dirty_ptes clear_young_dirty_ptes
+static inline void clear_young_dirty_ptes(struct mm_struct *mm,
+					  unsigned long addr, pte_t *ptep,
+					  unsigned int nr, cydp_t flags)
+{
+	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
+		__clear_young_dirty_ptes(mm, addr, ptep, nr, flags);
+	else
+		contpte_clear_young_dirty_ptes(mm, addr, ptep, nr, flags);
+}
+
 #else /* CONFIG_ARM64_CONTPTE */
 
 #define ptep_get				__ptep_get
@@ -1622,6 +1658,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
+#define clear_young_dirty_ptes			__clear_young_dirty_ptes
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..bf3b089d9641 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -361,6 +361,34 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
 
+void contpte_clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, unsigned int nr, cydp_t flags)
+{
+	/*
+	 * We can safely clear access/dirty without needing to unfold from
+	 * the architectures perspective, even when contpte is set. If the
+	 * range starts or ends midway through a contpte block, we can just
+	 * expand to include the full contpte block. While this is not
+	 * exactly what the core-mm asked for, it tracks access/dirty per
+	 * folio, not per page. And since we only create a contpte block
+	 * when it is covered by a single folio, we can get away with
+	 * clearing access/dirty for the whole block.
+	 */
+	unsigned int start = addr;
+	unsigned int end = start + nr;
+
+	if (pte_cont(__ptep_get(ptep + nr - 1)))
+		end = ALIGN(end, CONT_PTE_SIZE);
+
+	if (pte_cont(__ptep_get(ptep))) {
+		start = ALIGN_DOWN(start, CONT_PTE_SIZE);
+		ptep = contpte_align_down(ptep);
+	}
+
+	__clear_young_dirty_ptes(mm, start, ptep, end - start, flags);
+}
+EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
-- 
2.33.1


