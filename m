Return-Path: <linux-kernel+bounces-134783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E521389B6D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139FC1C2090D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC38BFC;
	Mon,  8 Apr 2024 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKNww+Uo"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801996AAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550306; cv=none; b=iu5oV3slU0Q67kOC171Nn01LSTpFF78HdPww5Kn7pHzNviuV4U76zO2dsZHfgToN23GYtbJQRxU29Muv4Nl3JJfHuycRLwHC4rFzxA0uNTPWBCx4aNXIhizulIMJZ/nZ2/00HV6ZJ41uqe90qrZZ65rUyQEAhfzedJlMEsRWnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550306; c=relaxed/simple;
	bh=YW7VK/A8bX+Jk0VyN9W9ja6ai86K1Q+9Mqf2wWqFOo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlBg/Aarpw+WC0VUGCxsdv4WRzSrR8XptqRe5jLk01bZrS7/GyoqxwhmYxXbGCdhGfxyx/shiH9MSFeBTl6UW2OGM3aHBkJIdee5wGQT5sAYWHZ9f8EIU/FWlTTRa4X3JOqjZ5Zkgdu/Bt+i0H8cq9iLk0ydW7KcdY4F4myNr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKNww+Uo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so3543934b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712550304; x=1713155104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PrJ/ANkryEW7CJ+WJBbTdeBa44gWubQPwVbhS14t9k=;
        b=nKNww+Uo9b6DCLHBQbAf0kgxLXcibZZyVKzB2N3KvihiOmIsLWtlNgPXX7c993BaKp
         aK5yLoBesGez4QSE5Iu3OzXvJZbfdh3hIvrEUz0OxXo7HprMIcawkzDTNeRnQinVkMyA
         geg+HyfsadXcIDF0j9vvPyrAZYTLEgDpFa4L25LT+LjmG4t7gCSr/19XGR0Chi1xcCop
         MovvpELowQXmdxNNJMvDR4gYC6z4rqJzvcLUjbSulyhTU7UskMIpMQA910xzqOyf4gYJ
         cE3HfwjsLOHnw/VH2T8LZlHHODa+oPt6gUCSx4cro6u4wT9uIq0C6tIss/7LcfDwct8O
         1vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712550304; x=1713155104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PrJ/ANkryEW7CJ+WJBbTdeBa44gWubQPwVbhS14t9k=;
        b=jXvJURpG5W6OXsMA12VgysXqMunAn7fapZHsfTAoM+Sad8WslWNC49fYePoK5426ZB
         m0/jXx6SL3VycTM/dTThQVHyRhISK0s/AV2CSKwU0392ModlBfucRPXP7xxUgHpcL7sn
         2dzYmpfYPoly+yoUX034k3DFCwYYf7TSn613iWyhlvJePwPQ/6ahp+d300RMjcnLeFBZ
         ADaEwybziUVDR8uvEHFF2M9atLF0w3N7XDUZX6qbVTLhhlPgHpO1IpA/pAp1P99kUuFe
         H9TRjESu7jPqe8dzyKX/XQtE9XvaC31rm0NMHithCWAsR3pRq1pUBbYNa9Y35272luBb
         c4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxJclGNE0wnuRcoZE9uZuC+FR1ae6hiXpic96qiq3ue8YBBkBR3ZEjbvTa/Y+uKrLdEVbdQQKRNgJVB6tsPCvooaY7+y+9W7N/DdRo
X-Gm-Message-State: AOJu0YyGGbkNgMo39EeSMtY0G+zxeR+o+eCKtg/xEDmPbuM1PvFP6HzH
	AaeGS+l4HYdRzfxAE3b2sjoC1iDDCzYI71ZUoqQFcus1hbF5oHA/
X-Google-Smtp-Source: AGHT+IHgvW4D9q14vF5+KTBGSUvoeHTEnFznIzfkTxepc4GsFqzcMQKJQZJGvDAWWKml0EBiM0dg1g==
X-Received: by 2002:a05:6a00:4f84:b0:6ea:afd1:90e6 with SMTP id ld4-20020a056a004f8400b006eaafd190e6mr7988047pfb.6.1712550303756;
        Sun, 07 Apr 2024 21:25:03 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a000b5400b006eab6ac1f83sm5465628pfo.0.2024.04.07.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:25:03 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v5 2/2] mm/arm64: override mkold_clean_ptes() batch helper
Date: Mon,  8 Apr 2024 12:24:37 +0800
Message-Id: <20240408042437.10951-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240408042437.10951-1-ioworker0@gmail.com>
References: <20240408042437.10951-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-pte get_and_clear/modify/set approach would result in
unfolding/refolding for contpte mappings on arm64. So we need
to override mkold_clean_ptes() for arm64 to avoid it.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 15 +++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9fd8613b2db2..395754638a9a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1223,6 +1223,34 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
 		__ptep_set_wrprotect(mm, address, ptep);
 }
 
+static inline void ___ptep_mkold_clean(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep, pte_t pte)
+{
+	pte_t old_pte;
+
+	do {
+		old_pte = pte;
+		pte = pte_mkclean(pte_mkold(pte));
+		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
+					       pte_val(old_pte), pte_val(pte));
+	} while (pte_val(pte) != pte_val(old_pte));
+}
+
+static inline void __ptep_mkold_clean(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
+{
+	___ptep_mkold_clean(mm, addr, ptep, __ptep_get(ptep));
+}
+
+static inline void __mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep, unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, addr += PAGE_SIZE, ptep++)
+		__ptep_mkold_clean(mm, addr, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
@@ -1379,6 +1407,8 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
+extern void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr);
 
 static __always_inline void contpte_try_fold(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep, pte_t pte)
@@ -1603,6 +1633,30 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
+#define mkold_clean_ptes mkold_clean_ptes
+static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, unsigned int nr)
+{
+	if (likely(nr == 1)) {
+		/*
+		 * Optimization: mkold_clean_ptes() can only be called for present
+		 * ptes so we only need to check contig bit as condition for unfold,
+		 * and we can remove the contig bit from the pte we read to avoid
+		 * re-reading. This speeds up madvise(MADV_FREE) which is sensitive
+		 * for order-0 folios. Equivalent to contpte_try_unfold().
+		 */
+		pte_t orig_pte = __ptep_get(ptep);
+
+		if (unlikely(pte_cont(orig_pte))) {
+			__contpte_try_unfold(mm, addr, ptep, orig_pte);
+			orig_pte = pte_mknoncont(orig_pte);
+		}
+		___ptep_mkold_clean(mm, addr, ptep, orig_pte);
+	} else {
+		contpte_mkold_clean_ptes(mm, addr, ptep, nr);
+	}
+}
+
 #else /* CONFIG_ARM64_CONTPTE */
 
 #define ptep_get				__ptep_get
@@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
+#define mkold_clean_ptes			__mkold_clean_ptes
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..dbff9c5e9eff 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -361,6 +361,21 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
 
+void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned int nr)
+{
+	/*
+	 * If clearing the young and dirty bits for an entire contig range, we can
+	 * avoid unfolding. Just set old/clean and wait for the later mmu_gather
+	 * flush to invalidate the tlb. If it's a partial range though, we need to
+	 * unfold.
+	 */
+
+	contpte_try_unfold_partial(mm, addr, ptep, nr);
+	__mkold_clean_ptes(mm, addr, ptep, nr);
+}
+EXPORT_SYMBOL_GPL(contpte_mkold_clean_ptes);
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
-- 
2.33.1


