Return-Path: <linux-kernel+bounces-149935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB028A9806
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA21F2226E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91415E5AB;
	Thu, 18 Apr 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng74V5Of"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA815E1EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437915; cv=none; b=lDzJbT+X6Vpn/q0cqBlv6+4wA0s9eo0FALfGl8VasCtrRW7Z2GVUUsGFv3Y0pWrB4b+Kfvi6z29l2wcIjPm/JG0F8lzLyFkBNDPmcMHTKGPw/xgEF33/tLFfQjeAlxkvSlJc0XTzCR9L3ebfIhXLGNCZ7ohrXROf6vaEZKX8Vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437915; c=relaxed/simple;
	bh=rSOnYKIaNy2WDcnD3ryzRYahieMXCry0i3m8v4tO+t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCwT0RhkgEjITnGWxAVETT8bRsjkopQ2wJJkTdpzdZCFYyVYIL4Rc0MPwHT//kaNTs+stt+PI8oHitIMvN3YDbepp/rLPjIvmIutlOOmrDqffDfD38uFgDPC3JZDynoLbYt50MdmaRL22Xam0zC+N7QXFJFMw72YvJwaLu8I89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng74V5Of; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c709e5e4f9so504199b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437912; x=1714042712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCDKyy/HK4fLjIHRec29GbYvLewmbRt2hV7S2QYdA34=;
        b=ng74V5OfR1p+0K8qFGTzZOvwQrsj8e4e7igaZ+4A4NBLxV1jZc1CVDzk3X9Ad6DiAA
         6TDn9CCBlCzzqaOj488BvrCHMfkjnIXjhsx0T6RKuW4YeIp08dtieQwjMGJQ7udsquiM
         yz42KpeICvV4OYxHm0rtfyabZz2mkVIY7cO7QW6PWdD+prncFhLbm6c8vrV16bJIr/8q
         nS9rJ1bgF4RXdk0ho+qQZlUctfF8qKdfFShaaQ9kPh7zzMzt8WO3RelC32t+ssWJcKe6
         geM0VVNeGtUm5OcsP6ylcnYTdtSuzs4ajs6PICGDdzy+lw4Bu5V8wl9kWPQ2CGZJ0fa3
         RU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437912; x=1714042712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCDKyy/HK4fLjIHRec29GbYvLewmbRt2hV7S2QYdA34=;
        b=ctvrXSTupYCn2QLoDrI5Nu36B2lToqCZbqE4j9By/84voovWZUlFlDAbzZ1wePmH8I
         UDUBhORYzu54bVuULBEOqRPlixgbIhDHqOs0pliGugNQMuuv91t4AZIf0bIy+7D1xikY
         JfykYYTPFBnt2tXzzhP9iLW1PzZh5ayELzrR+6sSL/1ytwMcWmgrjmEFnyMjXUBy9ve6
         yNSjVaTaWlZZmWG9oY2eBgXSClPLwC65cXM+UQYvPB0aE8j/RxNPfhevKrjhO7jURLhf
         8PT+ajkVs4fmKnVsGpZ8x00Py5yxm9a8rEG8E+PUtE96uc/NNadBoRK0a5cwe3FMGI+D
         cbbg==
X-Forwarded-Encrypted: i=1; AJvYcCWjoRtKT7/d1U4lmrK9xtOwgfT8/15xqtAQ0w5AQ/Nw7Jav7vwaj5HkgAngMpZlKwnFQ8oLiQBKWiDP8XMcxr/H2fUu9rXUoR8ffRx3
X-Gm-Message-State: AOJu0YzNuZXUIDZJfA+InTXWCw4EhVFMiu6X8/LduRGtrwfn92u0KSYz
	IiTP5zb49bmevNDT6Bt6pUpSlTBkzXpboB8su5uOr2jizcQo5mT6
X-Google-Smtp-Source: AGHT+IFiJWFYcIrSf2RPRltS/8C34Y5gwlKmlTV5x2wUCcZ1LqdcLz5TQFv4JEnEdVetJ6UiO6Fzxg==
X-Received: by 2002:a05:6808:8f3:b0:3c7:3b1d:bb59 with SMTP id d19-20020a05680808f300b003c73b1dbb59mr1553476oic.2.1713437911086;
        Thu, 18 Apr 2024 03:58:31 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm1200487pfb.137.2024.04.18.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:58:30 -0700 (PDT)
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
Subject: [PATCH v9 3/4] mm/memory: add any_dirty optional pointer to folio_pte_batch()
Date: Thu, 18 Apr 2024 18:57:49 +0800
Message-Id: <20240418105750.98866-4-ioworker0@gmail.com>
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

This commit adds the any_dirty pointer as an optional parameter to
folio_pte_batch() function. By using both the any_young and any_dirty pointers,
madvise_free can make smarter decisions about whether to clear the PTEs when
marking large folios as lazyfree.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/internal.h | 12 ++++++++++--
 mm/madvise.c  | 19 ++++++++++++++-----
 mm/memory.c   |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c6483f73ec13..daa59cef85d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  *		  first one is writable.
  * @any_young: Optional pointer to indicate whether any entry except the
  *		  first one is young.
+ * @any_dirty: Optional pointer to indicate whether any entry except the
+ *		  first one is dirty.
  *
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same large folio.
@@ -149,18 +151,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
-		bool *any_writable, bool *any_young)
+		bool *any_writable, bool *any_young, bool *any_dirty)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
-	bool writable, young;
+	bool writable, young, dirty;
 	int nr;
 
 	if (any_writable)
 		*any_writable = false;
 	if (any_young)
 		*any_young = false;
+	if (any_dirty)
+		*any_dirty = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
@@ -176,6 +180,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			writable = !!pte_write(pte);
 		if (any_young)
 			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -193,6 +199,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			*any_writable |= writable;
 		if (any_young)
 			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index f5e3699e7b54..4597a3568e7e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,18 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *ptep,
+					  pte_t pte, bool *any_young,
+					  bool *any_dirty)
+{
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	int max_nr = (end - addr) / PAGE_SIZE;
+
+	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
+			       any_young, any_dirty);
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -456,13 +468,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
 			bool any_young;
 
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL, &any_young);
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, NULL);
 			if (any_young)
 				ptent = pte_mkyoung(ptent);
 
diff --git a/mm/memory.c b/mm/memory.c
index 33d87b64d15d..9e07d1b9020c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			flags |= FPB_IGNORE_SOFT_DIRTY;
 
 		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
-				     &any_writable, NULL);
+				     &any_writable, NULL, NULL);
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
@@ -1558,7 +1558,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


