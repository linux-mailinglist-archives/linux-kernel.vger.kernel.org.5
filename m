Return-Path: <linux-kernel+bounces-83056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E21868DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D711C22EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1A1386A6;
	Tue, 27 Feb 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgEY8iJa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776B53376
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030541; cv=none; b=GMODCxe+5kEQvNXeohcH/F12gseTHaKRz/N8hmlD+irilDt7TqH2puOvbOLPHcw+KbGYB0ppkkfALkN4bXielNRyzu3pXf4DlZjsLXmtjHAGC96S0KcCnrbFl5ztWLRr3n0ksmeIS/r5UA0qD3WMDpxqBy7SCruvUALi794PDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030541; c=relaxed/simple;
	bh=NrYSYdLAeUS9fj8Dz49Rkdu09PkkrSFZfWUWUpNtGfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gn3CLBVuP9A5CqaiGnyBVnHROPqIpCbEIRgJ2NshtiUX4pPl0CkgliJN+cAJ33IIoiZD3xuNxR+g6R5RTKuGU77FZhWvGAW8jicigaRoloOzbcLDLzwvFuAiCwdWsJH58yUzDvFI4L9R/DIcbDfcV6zrNkRc0wOd5JDtfSqpK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgEY8iJa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc09556599so35551135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030539; x=1709635339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xc/mHpkbpsXJNXubnJiBOjrnoRZ+b03kcs1waaJkuu8=;
        b=kgEY8iJak1CfcGVjDaTUx+T+vPJiGTBAA1T6XK92JZGVsenHX+m43cCVB80M+aKDec
         WKwg3FSpzVHsSIzXTTzmNFpfqqKR9gkjOU6pmdq6BgKzaIlkO8JPhszrFjXbDWXmE5GA
         Z4MuT0rSKsCmIUw4T8l0xhzowGRE6OXkU6q0eE6nMNOYG6MvLSEnJftu0PbFMu75G3y3
         TT8IS0kRDjYv3kZX4YjwcT/ty/jWUxyC8bY5Z7TZsWba0h/1TT87OzjLK/eyVFQakkGK
         +i2a6gysgZGqjepuCBcbIyim4i3gj3THhGBXsS8nXvd2RMhnY6pYeK9QerZY+WIbwxOw
         RQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030539; x=1709635339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc/mHpkbpsXJNXubnJiBOjrnoRZ+b03kcs1waaJkuu8=;
        b=QtFWnHZnNLKuUtwjLWXNkJic7ikF8wN2niY8gpmM/5d1XjHzDQtTvmjzc0BgN/nbpL
         03IhzlBUqmLUuqS8I7tFvw73nbPC1kayTnuka+VnXZeXROl7lVRYEJLH+Rp0P0n91TwU
         ClikB8+aSZjixNR86/SO1OPAtWT565sw/FZ01zc5dtJAeC335QMT5NBIlkw0W1KZ3QD1
         EYwx94FywHUATdZUzmwP38mdgku7DoCu5fPYmuxV1fY9pGLqtKyHjxBSvjTtgT1di3ZN
         Bpogw+W21QDqiWznogynVtgRKbVqMCP3nFtll324sRGNXDN51QqIfE7hSQA/k/rasLYx
         Z77g==
X-Gm-Message-State: AOJu0YwDYx13ymQWaynf9pSIzvNncfR40V5E8HIMhS/jPbPlb27NCgxp
	oL8pfzZuE87a/DrvToGo2WJDK22u1oVoMzC4qxbGzPpCnP9qFEd3
X-Google-Smtp-Source: AGHT+IFl3DlU+8FIJDJtobznhFfgjJejB3j080t0M48PmFZhrpr8DyoarR+P7+ByoKZSHtj98PZTGg==
X-Received: by 2002:a17:902:e74e:b0:1dc:211f:96d0 with SMTP id p14-20020a170902e74e00b001dc211f96d0mr14194047plf.3.1709030538757;
        Tue, 27 Feb 2024 02:42:18 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id o5-20020a170902e00500b001dbb14e6feesm1239740plo.189.2024.02.27.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:42:18 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>
Subject: [PATCH v2] mm: make folio_pte_batch available outside of mm/memory.c
Date: Tue, 27 Feb 2024 23:42:01 +1300
Message-Id: <20240227104201.337988-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

madvise, mprotect and some others might need folio_pte_batch to check if
a range of PTEs are completely mapped to a large folio with contiguous
physical addresses. Let's make it available in mm/internal.h.

Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
[david@redhat.com: improve the doc for the exported func]
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 * inline folio_pte_batch according to Ryan and David;
 * improve the doc, thanks to David's work on this;
 * fix tags of David and add David's s-o-b;
 -v1:
 https://lore.kernel.org/all/20240227024050.244567-1-21cnbao@gmail.com/

 mm/internal.h | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/memory.c   | 76 -------------------------------------------
 2 files changed, 90 insertions(+), 76 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 13b59d384845..fa9e2f7db506 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,96 @@ static inline void *folio_raw_mapping(struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/* Flags for folio_pte_batch(). */
+typedef int __bitwise fpb_t;
+
+/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
+#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
+
+/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
+#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
+
+static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
+{
+	if (flags & FPB_IGNORE_DIRTY)
+		pte = pte_mkclean(pte);
+	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
+		pte = pte_clear_soft_dirty(pte);
+	return pte_wrprotect(pte_mkold(pte));
+}
+
+/**
+ * folio_pte_batch - detect a PTE batch for a large folio
+ * @folio: The large folio to detect a PTE batch for.
+ * @addr: The user virtual address the first page is mapped at.
+ * @start_ptep: Page table pointer for the first entry.
+ * @pte: Page table entry for the first page.
+ * @max_nr: The maximum number of table entries to consider.
+ * @flags: Flags to modify the PTE batch semantics.
+ * @any_writable: Optional pointer to indicate whether any entry except the
+ *		  first one is writable.
+ *
+ * Detect a PTE batch: consecutive (present) PTEs that map consecutive
+ * pages of the same large folio.
+ *
+ * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
+ * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
+ * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
+ *
+ * start_ptep must map any page of the folio. max_nr must be at least one and
+ * must be limited by the caller so scanning cannot exceed a single page table.
+ *
+ * Return: the number of table entries in the batch.
+ */
+static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
+		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
+		bool *any_writable)
+{
+	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
+	const pte_t *end_ptep = start_ptep + max_nr;
+	pte_t expected_pte, *ptep;
+	bool writable;
+	int nr;
+
+	if (any_writable)
+		*any_writable = false;
+
+	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
+	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
+
+	nr = pte_batch_hint(start_ptep, pte);
+	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
+	ptep = start_ptep + nr;
+
+	while (ptep < end_ptep) {
+		pte = ptep_get(ptep);
+		if (any_writable)
+			writable = !!pte_write(pte);
+		pte = __pte_batch_clear_ignored(pte, flags);
+
+		if (!pte_same(pte, expected_pte))
+			break;
+
+		/*
+		 * Stop immediately once we reached the end of the folio. In
+		 * corner cases the next PFN might fall into a different
+		 * folio.
+		 */
+		if (pte_pfn(pte) >= folio_end_pfn)
+			break;
+
+		if (any_writable)
+			*any_writable |= writable;
+
+		nr = pte_batch_hint(ptep, pte);
+		expected_pte = pte_advance_pfn(expected_pte, nr);
+		ptep += nr;
+	}
+
+	return min(ptep - start_ptep, max_nr);
+}
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/memory.c b/mm/memory.c
index 1c45b6a42a1b..a7bcc39de56b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -953,82 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
 }
 
-/* Flags for folio_pte_batch(). */
-typedef int __bitwise fpb_t;
-
-/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
-#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
-
-/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
-#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
-
-static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
-{
-	if (flags & FPB_IGNORE_DIRTY)
-		pte = pte_mkclean(pte);
-	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
-		pte = pte_clear_soft_dirty(pte);
-	return pte_wrprotect(pte_mkold(pte));
-}
-
-/*
- * Detect a PTE batch: consecutive (present) PTEs that map consecutive
- * pages of the same folio.
- *
- * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
- * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
- * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
- *
- * If "any_writable" is set, it will indicate if any other PTE besides the
- * first (given) PTE is writable.
- */
-static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
-		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
-		bool *any_writable)
-{
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
-	const pte_t *end_ptep = start_ptep + max_nr;
-	pte_t expected_pte, *ptep;
-	bool writable;
-	int nr;
-
-	if (any_writable)
-		*any_writable = false;
-
-	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
-
-	nr = pte_batch_hint(start_ptep, pte);
-	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
-	ptep = start_ptep + nr;
-
-	while (ptep < end_ptep) {
-		pte = ptep_get(ptep);
-		if (any_writable)
-			writable = !!pte_write(pte);
-		pte = __pte_batch_clear_ignored(pte, flags);
-
-		if (!pte_same(pte, expected_pte))
-			break;
-
-		/*
-		 * Stop immediately once we reached the end of the folio. In
-		 * corner cases the next PFN might fall into a different
-		 * folio.
-		 */
-		if (pte_pfn(pte) >= folio_end_pfn)
-			break;
-
-		if (any_writable)
-			*any_writable |= writable;
-
-		nr = pte_batch_hint(ptep, pte);
-		expected_pte = pte_advance_pfn(expected_pte, nr);
-		ptep += nr;
-	}
-
-	return min(ptep - start_ptep, max_nr);
-}
-
 /*
  * Copy one present PTE, trying to batch-process subsequent PTEs that map
  * consecutive pages of the same folio by copying them as well.
-- 
2.34.1


