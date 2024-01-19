Return-Path: <linux-kernel+bounces-31115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A24832934
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C331C20EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A84BABE;
	Fri, 19 Jan 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WScjcf6x"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18473C464;
	Fri, 19 Jan 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665101; cv=none; b=Aog19d9i86gFiKE0na54jG5ortoT0xHsWwDTZRKZlOvJie8Dvv3QMZSzCOUXKk+OOtk9qwU/ZKFbJM2Y+ZNr+crj4jmL8ccad8XSyOSahdZwPVCs+MB//Ir8VBmyl3nu1SrpP9M3/klVkmZYpwljX9jocAhz2eQTWB/fdAVBJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665101; c=relaxed/simple;
	bh=Ht/O6Oo6MWFVXpqHh3FdYYNcHmWGXGum2bCSVsJ6e8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/OepAgC2umjNjeuHMd4ardAhi+Egx2dT+NfTqHm7X9J3zyMpkOHLIW7WUom98PGCROw6AWswLhWP7G8+rSru6dUNdnL5znNv0MSkRq/WeNmEIfoGc7UE0f7EFnigZQnBl/V0U5sItfufNzSM/0kPx1AHDXa6uoOWHajCJHdCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WScjcf6x; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbc57d15daso254566b3a.1;
        Fri, 19 Jan 2024 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705665099; x=1706269899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsMtSG02+SgL2OGOt8NnKhjAQx8tT5hgSxfk3EraV8=;
        b=WScjcf6xIr6+CCIiQGae1NHIVGNaRHCMvGOedJ/V2bCorQENoPW5A5Tp2h9/BkbDSX
         +jCXzqS4pStqj43Jd7c1okClsSRFt7fWNbvwRJxN4/8unMsBHoPanWaCxgFpgWy00FzX
         da5lTlVmyE0UrcYH0UkYciDGzx1iOXQzHUw4qP2aO1coBhQLhNK2lnKY4kmbz1wzNIPd
         rX1mwhM4PJFZw44SoFm0/YNYe+b1bua6wkmY3I5bNW8s8yqNhcmG0dRnWtAJqymf2rbJ
         0R9gMSUjqPkBcqG9ulYDGzyERmhKcgguPiZrp50j9kBojTdzeDAFWTx/G/hI5PsjCvXL
         Wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665099; x=1706269899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKsMtSG02+SgL2OGOt8NnKhjAQx8tT5hgSxfk3EraV8=;
        b=J0w/NFNcaaPxvQ0/i/3RFUm4u7FjrlU9fYmiioGXWuiCYcYd+AZWOiXQkYl5/izY2t
         3LmwFi8kSSz2JRxBsaFpcgsd1Gw3qyCGnqJGiVvkCryH5DrQuTDq0jKcIu6h6pSaIf7F
         uTgxh9VPs5kIYtAD8kB9QdK5N+AXov7pVLJU/H+qZwNl6tgjqN1TDXAJ624rlrPYgbLf
         L/9scR58aZWtXILPp9rANvRliQxg9KrcLhwyM0MuOz7WGX01HHAgQrJxDvAzI0TAesBn
         5gaJoVFo8rjWRKVvK6QUWlJU/1Ym8nD9SxgbXiiDPONn1HC7c2zpgmla32MbxXdF53t5
         w93w==
X-Gm-Message-State: AOJu0Yxb/jxh8A9sVyn89+ncEn3uqr5MHAziNortrthh1MWC6ZvWrPGE
	+ST5Z79yVuH0B1OJuijkY7/1m/l2EjyvlxPGndD02P9XTR5I5IBG
X-Google-Smtp-Source: AGHT+IHTBrMFUwcUVGCdBx8TZimYHjoLwtVuHRdfjA276aEWTzc/0O+SRRgzJy2c35SlK3n4aHpSYA==
X-Received: by 2002:a05:6a21:1506:b0:19a:e2aa:ff23 with SMTP id nq6-20020a056a21150600b0019ae2aaff23mr2747669pzb.9.1705665098975;
        Fri, 19 Jan 2024 03:51:38 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.24])
        by smtp.gmail.com with ESMTPSA id f11-20020a63f74b000000b005cd821a01d4sm3213572pgk.28.2024.01.19.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:51:38 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	david@redhat.com,
	songmuchun@bytedance.com,
	shy828301@gmail.com,
	peterx@redhat.com,
	mknyszek@google.com,
	minchan@kernel.org,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT flag to process_madvise()
Date: Fri, 19 Jan 2024 19:51:04 +0800
Message-Id: <20240119115104.75456-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].

The MADV_F_COLLAPSE_LIGHT flag provides a more relaxed (opportunistic)
and lightweight alternative to the default behavior of MADV_COLLAPSE
advice, specifically designed to avoid direct reclaim and/or compaction,
and quickly fail on allocation errors.

In the era of cloud-native computing, it's challenging for users to be
aware of the THP configurations on all nodes in a cluster, let alone have
fine-grained control over them. Simply disabling the use of huge pages due
to concerns about potential direct reclaim and/or compaction may be
regrettable, as users are deprived of the opportunity to experiment with
huge page allocations. However, relying solely on MADV_HUGEPAGE introduces
the risk of unpredictable stalls, making it a trade-off that users must
carefully consider.

With the introduction of MADV_COLLAPSE into the kernel, it is not governed
by the defrag mode. MADV_COLLAPSE offers the potential for more fine-grained
control over the huge page allocation strategy.

Semantics

This call is independent of the system-wide THP sysfs settings, but will
fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
multiple VMAs, the semantics of the collapse over each VMA is independent
from the others.  This implies a hugepage cannot cross a VMA boundary.  If
collapse of a given hugepage-aligned/sized region fails, the operation may
continue to attempt collapsing the remainder of memory specified.

The memory ranges provided must be page-aligned, but are not required to
be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
start/end of the range will be clamped to the first/last hugepage-aligned
address covered by said range.  The memory ranges must span at least one
hugepage-sized region.

All non-resident pages covered by the range will first be
swapped/faulted-in, before being internally copied onto a freshly
allocated hugepage.  Unmapped pages will have their data directly
initialized to 0 in the new hugepage.  However, for every eligible
hugepage aligned/sized region to-be collapsed, at least one page must
currently be backed by memory (a PMD covering the address range must
already exist).

Allocation for the new hugepage will not enter direct reclaim and/or
compaction, quickly failing if allocation fails. When the system has
multiple NUMA nodes, the hugepage will be allocated from the node providing
the most native pages. This operation operates on the current state of the
specified process and makes no persistent changes or guarantees on how pages
will be mapped, constructed, or faulted in the future.

[1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404faca29a82689c77

[v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmail.com/
[v2] https://lore.kernel.org/lkml/20240118120347.61817-1-ioworker0@gmail.com/

Signed-off-by: Lance Yang <ioworker0@gmail.com>
Suggested-by: Zach O'Keefe <zokeefe@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
V3 -> V2: Add MADV_F_COLLAPSE_LIGHT flag
V1 -> V2: Treat process_madvise(MADV_F_COLLAPSE_LIGHT) as the lighter-weight
alternative to madvise(MADV_COLLAPSE)

 arch/alpha/include/uapi/asm/mman.h           |  4 ++
 arch/mips/include/uapi/asm/mman.h            |  4 ++
 arch/parisc/include/uapi/asm/mman.h          |  4 ++
 arch/xtensa/include/uapi/asm/mman.h          |  4 ++
 include/linux/huge_mm.h                      |  5 ++-
 include/uapi/asm-generic/mman-common.h       |  4 ++
 mm/khugepaged.c                              | 15 +++++--
 mm/madvise.c                                 | 45 ++++++++++++++------
 tools/include/uapi/asm-generic/mman-common.h |  4 ++
 9 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..c9f973f86585 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index c6e1fc77c996..aa25dfe58a44 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..d9f38ff86efe 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,10 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..f36399192f75 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..bfa52c7f8c25 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
 		     int advice);
 int madvise_collapse(struct vm_area_struct *vma,
 		     struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end);
+		     unsigned long start, unsigned long end, unsigned int flags);
 void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, long adjust_next);
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
@@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
 
 static inline int madvise_collapse(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev,
-				   unsigned long start, unsigned long end)
+				   unsigned long start, unsigned long end,
+				   unsigned int flags)
 {
 	return -EINVAL;
 }
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..0e0fac5c9219 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..90c62c57a3f9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -97,6 +97,8 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
 struct collapse_control {
 	bool is_khugepaged;
 
+	unsigned int flags;
+
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
 
@@ -1058,10 +1060,16 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 			      struct collapse_control *cc)
 {
-	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
-		     GFP_TRANSHUGE);
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
+	gfp_t gfp;
+
+	if (cc->is_khugepaged)
+		gfp = alloc_hugepage_khugepaged_gfpmask();
+	else
+		gfp = (cc->flags & MADV_F_COLLAPSE_LIGHT ?
+			       GFP_TRANSHUGE_LIGHT :
+			       GFP_TRANSHUGE);
 
 	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
 		*hpage = NULL;
@@ -2697,7 +2705,7 @@ static int madvise_collapse_errno(enum scan_result r)
 }
 
 int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end)
+		     unsigned long start, unsigned long end, unsigned int flags)
 {
 	struct collapse_control *cc;
 	struct mm_struct *mm = vma->vm_mm;
@@ -2718,6 +2726,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!cc)
 		return -ENOMEM;
 	cc->is_khugepaged = false;
+	cc->flags = flags;
 
 	mmgrab(mm);
 	lru_add_drain_all();
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..c41eb8656a42 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1014,7 +1014,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				unsigned long behavior)
+				unsigned long behavior, unsigned int flags)
 {
 	int error;
 	struct anon_vma_name *anon_name;
@@ -1083,7 +1083,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 			goto out;
 		break;
 	case MADV_COLLAPSE:
-		return madvise_collapse(vma, prev, start, end);
+		return madvise_collapse(vma, prev, start, end, flags);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1194,6 +1194,15 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
+
+static bool process_madvise_flags_valid(unsigned int flags)
+{
+	if (flags & ~(MADV_F_NORMAL|MADV_F_COLLAPSE_LIGHT))
+		return false;
+
+	return true;
+}
+
 static bool process_madvise_behavior_valid(int behavior)
 {
 	switch (behavior) {
@@ -1217,10 +1226,10 @@ static bool process_madvise_behavior_valid(int behavior)
  */
 static
 int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
-		      unsigned long end, unsigned long arg,
+		      unsigned long end, unsigned long arg, unsigned int flags,
 		      int (*visit)(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev, unsigned long start,
-				   unsigned long end, unsigned long arg))
+				   unsigned long end, unsigned long arg, unsigned int flags))
 {
 	struct vm_area_struct *vma;
 	struct vm_area_struct *prev;
@@ -1257,7 +1266,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = visit(vma, &prev, start, tmp, arg);
+		error = visit(vma, &prev, start, tmp, arg, flags);
 		if (error)
 			return error;
 		start = tmp;
@@ -1278,7 +1287,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long anon_name)
+				 unsigned long anon_name, unsigned int flags)
 {
 	int error;
 
@@ -1320,7 +1329,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 		return 0;
 
 	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
-				 madvise_vma_anon_name);
+				MADV_F_NORMAL, madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 /*
@@ -1381,6 +1390,11 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
  *		triggering write faults if required
  *
+ * flags values:
+ *  MADV_F_NORMAL - the default flag.
+ *  MADV_F_COLLAPSE_LIGHT - only for MADV_COLLAPSE, avoids direct reclaim and/or
+ *		compaction.
+ *
  * return values:
  *  zero    - success
  *  -EINVAL - start + len < 0, start is not page-aligned,
@@ -1394,7 +1408,9 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
+static
+int _do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
+		int behavior, unsigned int flags)
 {
 	unsigned long end;
 	int error;
@@ -1437,7 +1453,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	end = start + len;
 
 	blk_start_plug(&plug);
-	error = madvise_walk_vmas(mm, start, end, behavior,
+	error = madvise_walk_vmas(mm, start, end, behavior, flags,
 			madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	if (write)
@@ -1448,6 +1464,11 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	return error;
 }
 
+int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
+{
+	return _do_madvise(mm, start, len_in, behavior, MADV_F_NORMAL);
+}
+
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
 	return do_madvise(current->mm, start, len_in, behavior);
@@ -1465,7 +1486,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	size_t total_len;
 	unsigned int f_flags;
 
-	if (flags != 0) {
+	if (!process_madvise_flags_valid(flags)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1504,8 +1525,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
-					iter_iov_len(&iter), behavior);
+		ret = _do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
+					iter_iov_len(&iter), behavior, flags);
 		if (ret < 0)
 			break;
 		iov_iter_advance(&iter, iter_iov_len(&iter));
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..0e0fac5c9219 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,10 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+/* process_madvise flags */
+#define MADV_F_NORMAL	0	/* the default flag */
+#define MADV_F_COLLAPSE_LIGHT	0x1	/* only for MADV_COLLAPSE, avoids direct reclaim and/or compaction */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-- 
2.33.1


