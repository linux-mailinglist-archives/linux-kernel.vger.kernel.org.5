Return-Path: <linux-kernel+bounces-146180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0928A61BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7611F2114B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC317BD9;
	Tue, 16 Apr 2024 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCAObNmx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210221379
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238519; cv=none; b=gIhYr2wnLG4hsLseV9xHrfxP/m2ZjFr9syig47RGFpffNGzBFt/mdktFfnMXoyZDwwQW2NnJ5kZ2kXaeBS5KFzKfHpoQIWHMpebBs8pu4UkYFOXg0P7VeCzGeXfIhzi1eqlS0akz+V9Azlh4LhnTQS1BHgpF05hXqYws/cpeHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238519; c=relaxed/simple;
	bh=QJ1PsiOtB8Xg26rcpVnJMLNlvHitX5kEJEfVsFo1BVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0EUm/PJkJwwiDizWfZlQwHEdbhbUbpCh4gM7eSPbrg1pS5SCqXzZX8lZvILu/1ihfpjV33BGBPlt586B6HZpRARv/fbKOUR7/gcMcB9RkxI7wECSiJlFOOgXmJHZaox9ZtwbXKuzoyyoyXqQwEQqCsXWoouDbPg5Gs5Z1W88SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCAObNmx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ee12766586so2576290b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713238517; x=1713843317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y26dypB16OA0SVhjpIF+OcTwWxmNUbTnikqr5y0M6Fc=;
        b=fCAObNmxpKj6pA1OLGEbqaKnt5rvaJ+GKxmZdDFmfwLeEBZPg9kys07/LgGR/C2MLN
         dWm0Tqqrf+AD8a1beeCntuxaaeNzSPmhR2IAD1xwBx5nRRIK/ewNuo6syIZtAQ7jhyYV
         2IFd7WWMStnD/C03Keg6NlIWNBJ0tgkl2S4r6MSYOr5F078WghoWeNYp29mrDHTymABj
         Qm8GdAxL5BdkY52r8OEayjA7iJ5ykr/MTw4ei2i6IvCdQ4Ce2QmN1d7BAOO24Tk/A5/r
         9gYsZ54HaOyBLkSOiVPwY3AY7+7jmaR5ylkpQutYiuL/cwK45vAV8dUqVcjOXROCoMcN
         zGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713238517; x=1713843317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y26dypB16OA0SVhjpIF+OcTwWxmNUbTnikqr5y0M6Fc=;
        b=Gc9LmcClLB8G2vfT2woFNSAUSlE82R11W1Uy2omfenNMJHKY0Ali6CPFuoXfRcpV64
         ZHB8EGBkj4P2LIyg9P4QtUnYTIzuH4Bs5H9h7RlS+TgqvjyPkSV33LhXpxxvXar34AFx
         qkm9SB1UBkPwNLPumGfjItUeccXXDtkd247m8rR8TNPcNvrp985orGEs1kKxy71z1PgV
         jFwsncviKf1ZlRePmEVJSIXxQAOzv2ai0R20HtmWR6yLZHo0gzs2SSqhMM4IiIAvV/zN
         7g14GjiEfeOxNhqFwCxjzjUqLDEtC81vbIQvqfifaRamdPANjdy/yg1lmK0CbMQOddt2
         E+ig==
X-Forwarded-Encrypted: i=1; AJvYcCVBxbQnollb87o4eMeDhf/I6opRKGAts51zkcwGWvKwyHzMho/xfZ+EVHu7+rkMptyuROFFxuHAX+f26M6OCVmo1KQ104OeusXJCOBO
X-Gm-Message-State: AOJu0Yw0EZwkniJAdnyQfefFn12PAbsGuVnV7IL20ELFexQoHgSKciQ9
	yDYYtAZsM20/d8NV0Vt5hi5BSL2j9TtPM5bEHLcMCVK6nCTBrtYB
X-Google-Smtp-Source: AGHT+IFyV0ITDY9sKZfPnYg4et6b+fPHhV71ixJ7FoSU2qMU9HkaIvNCBw2dcpvFdL4KgCCgbcP34w==
X-Received: by 2002:a05:6a00:2382:b0:6ed:ca65:68b with SMTP id f2-20020a056a00238200b006edca65068bmr2029849pfc.4.1713238516924;
        Mon, 15 Apr 2024 20:35:16 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm7906737pfb.8.2024.04.15.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:35:16 -0700 (PDT)
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
Subject: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes() batch helper
Date: Tue, 16 Apr 2024 11:34:55 +0800
Message-Id: <20240416033457.32154-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240416033457.32154-1-ioworker0@gmail.com>
References: <20240416033457.32154-1-ioworker0@gmail.com>
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
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/mm_types.h |  9 +++++
 include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
 mm/madvise.c             |  3 +-
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c432add95913..28822cd65d2a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1367,6 +1367,15 @@ enum fault_flag {
 
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
index f59169888b8e..edb592adb749 100644
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


