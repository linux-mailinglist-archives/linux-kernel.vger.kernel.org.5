Return-Path: <linux-kernel+bounces-148660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC738A85AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0161FB23C01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57911411DB;
	Wed, 17 Apr 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1T31Z6Q"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1713F444
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363302; cv=none; b=pdeflXqAMNMamhiH5mA43UlMDA2l/GYsucQMvmENrKxZoN8izGsINM6+Z4doszqllAUPlxS2SWGq1qxNpL/WLj4Tnhn/SfCJFf33hR5ILBr9Tg8DcGuC0MBAqaKC813l/EzV4J8TbBhuOF9fCSJ+ub548yUGU6Y4gARjGvutL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363302; c=relaxed/simple;
	bh=YS1E84UOxIjSnPESm8G/PnNhVqV2TAef9FqSYBszYkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jnzvi4ndO0TR/daBmj4G07HcDQ93MvxfWGu5NoAggHNdGxcJu+atg+Lo51J60pJfrWfdCxjrkX248lN53Ic0TW/B9VizHJEdvRLj8RYf/eeQAZgEUOXrQN+/pCfodMI6fJyt0tOclbKeltjh4lPq3c0owd+7bbC15FMJAjMJuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1T31Z6Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e455b630acso26569155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363300; x=1713968100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=T1T31Z6Q9K5WNrP/QX8ppTSLI0WeqLu/fV2mLIUXHVQLso8lOqESHCiU77o3wRDUci
         T3iQ9yG/LbIgw9jQjd8LJQ7qQ27XF5VQ5oo4mVClrmRNuoaarjJQbISm09GVLXGa98CH
         sHKkUK1JBhF8Le7bD1v5msL49q9nn8jrR67Q9SNtXgpDG6biZ9aEj+pc8mAiwHrSJC5e
         UTI1HCNzcwn3gXzeDtDWPUg77A1Uvwht8msd5abq9EPek3+U7xMFi6nFW4kaiTDkvk6H
         7ZX6CH3QDgQW936sxCnr0jA3/g1McJ53qMNi4DqYQziTjxpApGnKrJQg/Qbdmv4TiPV7
         mzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363300; x=1713968100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=qjOjk3K9vANGE3dSVOGaKpbkrt8Pzbwq+0lx942lUuoxs1gtbMvwMUnDWv1YLl5gx+
         yze8XUVXbpjEYidlLgZ4etP9ksj1eeck71j7kCUXbXcRGHGDPCoUdEXfEk39+UFF7s+c
         vVAXt4u1mBnjlZU9ALs95WrwXcp2nkZyLUL64wea80+rTZfu/I3ojAfhqxqtC8hGhCCm
         4d1JUi8oCliVx/WMdwfNmuBCJV8K+zprluYdT8jwIpVr554zxhtNz9f//wOBsW1RQbU8
         LtVwILoK+bG6vpsXVEqTCbswhahFyCunJHAsU36YFNbFXhEexhwjqiSQug+itioUuK4X
         GK6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQDWjz6ZJ1YS0DT3/osfSikLQ64adiUJwh5PMiEX4yS/x/C+wKCxp5aIfZ8+Zzf9kFr2mhNwpsCIFfxmyuayatNmBlLKNB/LqK6aom
X-Gm-Message-State: AOJu0YxfI0/nisOf0916Z/n2MlRAU2xaGfhhqIGV66PxQ0IWiYOodFvl
	9QcKuSIp0Nfu8CiJLgzDSKGklearAs92ZH2GepgwiUDme2oN4vSM
X-Google-Smtp-Source: AGHT+IFNu14u7a3I7+Ll1HOcTWP+Tr+CtfofRjw+IGm+xSJjJO923Owls7pUFZJGkbba4Ch4IATTlg==
X-Received: by 2002:a17:903:2303:b0:1e4:b1eb:7dee with SMTP id d3-20020a170903230300b001e4b1eb7deemr16402525plh.47.1713363299859;
        Wed, 17 Apr 2024 07:14:59 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902a50e00b001ddc83fda95sm11613562plq.186.2024.04.17.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:14:59 -0700 (PDT)
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
Subject: [PATCH v8 1/3] mm/madvise: introduce clear_young_dirty_ptes() batch helper
Date: Wed, 17 Apr 2024 22:14:34 +0800
Message-Id: <20240417141436.77963-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240417141436.77963-1-ioworker0@gmail.com>
References: <20240417141436.77963-1-ioworker0@gmail.com>
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


