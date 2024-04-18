Return-Path: <linux-kernel+bounces-149932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D98A9802
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E91F2207B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4D15E7F6;
	Thu, 18 Apr 2024 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WooYMqLb"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573515E1EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437901; cv=none; b=nwlN68Ov6WY2NSGn9W1pgz72UZoHwOTuiE05eUuAY+VVd4i1S9IcRT0FRn2+33sD7DkdGvgxHLFyydYSh51Bb0G2QyX1RH6x9DcZwuqFZsR0EBVd1IBAVr/WYRY0Yp9vR6HzTJYFN+RaAoHt6YgDBpaWlRnO173RM4wih4WuP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437901; c=relaxed/simple;
	bh=YS1E84UOxIjSnPESm8G/PnNhVqV2TAef9FqSYBszYkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpwQkdyDqvyX0YqFjFsdhN7L0g0Ar1UCIvPNZJ+8lxKAnvlrQqfqyLReK5+PQ0uYUR4wWoCCP+Id19gQpavIn6EKMZqGc3reQ/pZ2cwx17+GJGhfU4yWNoSLNtYH4khSQSqtGXXgE787/b4ajfU8KXfbaZBeff7BjiQfc0ncHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WooYMqLb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so765703b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437899; x=1714042699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=WooYMqLbQWuw4ih3+vlrZIERruXz85GZSfMW810uVOF8nV8hplh1rJ+RARKxSebTj9
         JwAzHVvuuSUw02z47rQANtxkfgzFGePLqYin2xkdQLC3YzOh+ALt9lQMYUwlcq6LiabX
         mSkbFQJ1yf4vy0A+qVwPBrExjrrfASFeARt9dRIh+ZYgolGMh1NzvPIOP4FBeWNOJyfB
         vPj1A1huHcys+PYFnVwYw1PZEDxmXPf0w7O77Iqtb1yJiSH8WwQobgcrTfoSIzd9L7Da
         Vx64LQAJEH/yO1+yXAQ/wJxkl7jQ2F4m3/2OZ/v3Uvfyq+8MJVM9yGiPHlIbW4AENhKm
         r+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437899; x=1714042699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=AahIU/2gpbckai0Czx67eZrRXQh9WeYo8Z42x+DDbGnr4eV1Ng2YuL2z6HLqLVjWp3
         ez6AVpAN6orMu2NN04UadBgJoBaBgQmsR7X6x6L2P4sWYzeZEgXZkTQwlaRNG6/QmDTm
         joA/WzUQPgmQk3rZ4NiZGlKeBWsjfePBbyU61pqep4NZ2Z6fTGg2iBLtFHZNB16dJnsB
         4U3typ4zp1dKJuXNMBAw7GvKblxqoEcL6nsGQOSftbqTL07JLQvVTi5BCYUr6Rg5A7VQ
         lIjjBpGKGI/vh7jWEBHXXpOCJVJulpxO4JGhFHXJZx4pS3h1QPbUwQJqb5MGhNZVLNVt
         kDIw==
X-Forwarded-Encrypted: i=1; AJvYcCWuRbDu9P6iE2pEb4XSVcNZ8Hb5WePQmKd0Y/6zRBfpzmGMtnKlVzFUoYKzJ96SIAwaonoIWqxsoWSQ/gIaEBVKKwG0mSLfApDpK9Tg
X-Gm-Message-State: AOJu0Yx3AhU3HfzKnrrEvwtS+BHMbnKzIRNwd7XvDZ4Ohf97avwUtkdE
	xNmq9UC1r+6luKTF7o2lESCg28DelnnSaHG/VpNDR3Ux64zJBI7h
X-Google-Smtp-Source: AGHT+IF4GTJLmtDlsAiq1UBHnJLKlM7tfb3a1b5r2w5ICLJMQHsjTAFqJxOVL/DbBjBw6Z9Mr8QknQ==
X-Received: by 2002:a05:6a00:1749:b0:6ea:d740:62a4 with SMTP id j9-20020a056a00174900b006ead74062a4mr2701566pfc.25.1713437898934;
        Thu, 18 Apr 2024 03:58:18 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm1200487pfb.137.2024.04.18.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:58:18 -0700 (PDT)
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
Subject: [PATCH v9 1/4] mm/madvise: introduce clear_young_dirty_ptes() batch helper
Date: Thu, 18 Apr 2024 18:57:47 +0800
Message-Id: <20240418105750.98866-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418105750.98866-1-ioworker0@gmail.com>
References: <20240418105750.98866-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces clear_young_dirty_ptes() to replace mkold_ptes().
By doing so, we can use the same function for both use cases
(madvise_pageout and madvise_free), and it also provides the flexibility
to only clear the dirty flag in the future if needed.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/mm_types.h |  9 +++++
 include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
 mm/madvise.c             |  3 +-
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index db0adf5721cc..24323c7d0bd4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1368,6 +1368,15 @@ enum fault_flag {
 
 typedef unsigned int __bitwise zap_flags_t;
 
+/* Flags for clear_young_dirty_ptes(). */
+typedef int __bitwise cydp_t;
+
+/* Clear the access bit */
+#define CYDP_CLEAR_YOUNG		((__force cydp_t)BIT(0))
+
+/* Clear the dirty bit */
+#define CYDP_CLEAR_DIRTY		((__force cydp_t)BIT(1))
+
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
  * other. Here is what they mean, and how to use them:
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e2f45e22a6d1..18019f037bae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-#ifndef mkold_ptes
-/**
- * mkold_ptes - Mark PTEs that map consecutive pages of the same folio as old.
- * @vma: VMA the pages are mapped into.
- * @addr: Address the first page is mapped at.
- * @ptep: Page table pointer for the first entry.
- * @nr: Number of entries to mark old.
- *
- * May be overridden by the architecture; otherwise, implemented as a simple
- * loop over ptep_test_and_clear_young().
- *
- * Note that PTE bits in the PTE range besides the PFN can differ. For example,
- * some PTEs might be write-protected.
- *
- * Context: The caller holds the page table lock.  The PTEs map consecutive
- * pages that belong to the same folio.  The PTEs are all in the same PMD.
- */
-static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
-		pte_t *ptep, unsigned int nr)
-{
-	for (;;) {
-		ptep_test_and_clear_young(vma, addr, ptep);
-		if (--nr == 0)
-			break;
-		ptep++;
-		addr += PAGE_SIZE;
-	}
-}
-#endif
-
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
@@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_young_dirty_ptes
+/**
+ * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of the
+ *		same folio as old/clean.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to mark old/clean.
+ * @flags: Flags to modify the PTE batch semantics.
+ *
+ * May be overridden by the architecture; otherwise, implemented by
+ * get_and_clear/modify/set for each pte in the range.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		if (flags == CYDP_CLEAR_YOUNG)
+			ptep_test_and_clear_young(vma, addr, ptep);
+		else {
+			pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
+			if (flags & CYDP_CLEAR_YOUNG)
+				pte = pte_mkold(pte);
+			if (flags & CYDP_CLEAR_DIRTY)
+				pte = pte_mkclean(pte);
+			set_pte_at(vma->vm_mm, addr, ptep, pte);
+		}
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
+
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 4b869b682fd5..f5e3699e7b54 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -507,7 +507,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		if (!pageout && pte_young(ptent)) {
-			mkold_ptes(vma, addr, pte, nr);
+			clear_young_dirty_ptes(vma, addr, pte, nr,
+					       CYDP_CLEAR_YOUNG);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 
-- 
2.33.1


