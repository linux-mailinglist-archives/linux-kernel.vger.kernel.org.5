Return-Path: <linux-kernel+bounces-43420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22984139F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D69C1C2128E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995476028;
	Mon, 29 Jan 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKqYfZQq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369F1552F2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556940; cv=none; b=Tp1ACQxX0OJc73q/aym5B2fQ4nGxJ4HR26FaCIE2zGUpFbvRbzsJK6R6abmbCszLtapPwc24PepY0SFjDvbzCj6nLdJAbopOs211Pf1vz/dFT2ZEMk1hiNBWXyTaXwz1y3bfHST4BRatCVp8g2Vu29PcK1gUFZPizPOTaSH1+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556940; c=relaxed/simple;
	bh=+HdbbaQZa8+A0lATLROmSrWayDBc8cSfyhmoQJXBCs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3fch7pzYQ3w6TdmZcDR7TrFQqkmfDMn/kQstTUB00gB2h4fF+8C8AV5zvu2Iefqymjqppj/B5V7wKavKHQbWBMwX6PwnCFBpBRZcqRCd4FwRDTTPAxgZscsvWwvay33LGIa0cy4JLiYyRMepGxY7QQvyk4+Zo9chZnpS2Wyun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKqYfZQq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc265e7a67cso5381174276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706556936; x=1707161736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rTTdTkZrF1wexi3aiNZ7/0XWdKeqDeZCcom0yepX1o=;
        b=xKqYfZQq1gwh+Hwvnyx8H8UOCQVCqg+uLZGLmvDznYQtjy6KAv1iQ4zydpQd/ucLUc
         iEt7a6rGibfEbm/wAldZJcHq0M1qF6XjN8frVZAxLVLUGX4a6t439GrENNxxrlxCNRCL
         5+YHF+i34KUUmaWxtObdkPcjaBHIPQxJ2WKeDreKZ4XgVMrYSIggqOrVDNKlt7T9fL5W
         A0/MHsiPaktsqVoTCfDFKhUZVnbsEpqYSqkeU3Nxe6XfZWhVlli70K1a/qZbW4jw8cxh
         R2Rl1Sxc8YAV6uy5aI9HQVQhPjG1Vf72Vj/e2iqNZTEFKGUGgoCA3EGXQ1QeTSh4D+I1
         z8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556936; x=1707161736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rTTdTkZrF1wexi3aiNZ7/0XWdKeqDeZCcom0yepX1o=;
        b=G1S6moeI8rwJSyAX7qsO0xE3Lu5tPtbjCVEOdkqDirfyXHfCB0cJcaTRDYPXDfwnqI
         26e54iI/yg6JNOkpw+Ablg1wPcO6ACvXCfIFSQbbdeGPzDdV1F+KoEpLd5e9P30U+ywb
         Nmww2tk7affDBF3T68Mdqe/dog/SkO0fIUy6hVnxWU2oM6xvQhAYm1F0jB3t+7Jc7mSc
         OINeBaxYxitpuI3smXyiS286UxwBgDG41CG4elxSzce3QJ8PmYoDso1+GjB1XEOQufwq
         +YXH5ZMmX0YqhqRsRrkoMJYl5kywNlLncH4O1lAfADYdNp/YSQSRb3SBJesa7VVoo14b
         GAUw==
X-Gm-Message-State: AOJu0YxqRIc8sxIbgezFVuycQF9H3ADcVoZ9UVwkAi2KdChQ1uGHU9/K
	fvvJQ3XljK7AMK0s4xNdlMvtUM5fy6CaafHyHPuPzviQg+b7ZgbpKapyq9M9+KVJQYDYBc4WIBD
	S5Q5wT7C4xtKKzAfluqJbJQ==
X-Google-Smtp-Source: AGHT+IHg5bBsWt55Rz1Rugqar6MZ+VAZSQCpoEjW8I0EHN+ywy05kgFpt3/w0bymXcr1SFJEZK7hul4bbbOZB2g6+g==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9b1d:f1ee:f750:93f1])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:250b:b0:dbe:d0a9:2be3 with
 SMTP id dt11-20020a056902250b00b00dbed0a92be3mr2244340ybb.3.1706556936414;
 Mon, 29 Jan 2024 11:35:36 -0800 (PST)
Date: Mon, 29 Jan 2024 11:35:12 -0800
In-Reply-To: <20240129193512.123145-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129193512.123145-4-lokeshgidra@google.com>
Subject: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

All userfaultfd operations, except write-protect, opportunistically use
per-vma locks to lock vmas. If we fail then fall back to locking
mmap-lock in read-mode.

Write-protect operation requires mmap_lock as it iterates over multiple vmas.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c              |  13 +--
 include/linux/userfaultfd_k.h |   5 +-
 mm/userfaultfd.c              | 175 +++++++++++++++++++++++-----------
 3 files changed, 122 insertions(+), 71 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index c00a021bcce4..60dcfafdc11a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 		return -EINVAL;
 
 	if (mmget_not_zero(mm)) {
-		mmap_read_lock(mm);
-
-		/* Re-check after taking map_changing_lock */
-		down_read(&ctx->map_changing_lock);
-		if (likely(!atomic_read(&ctx->mmap_changing)))
-			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
-					 uffdio_move.len, uffdio_move.mode);
-		else
-			ret = -EAGAIN;
-		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(mm);
+		ret = move_pages(ctx, uffdio_move.dst, uffdio_move.src,
+				 uffdio_move.len, uffdio_move.mode);
 		mmput(mm);
 	} else {
 		return -ESRCH;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3210c3552976..05d59f74fc88 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vma,
 /* move_pages */
 void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
 void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
-ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
-		   unsigned long dst_start, unsigned long src_start,
-		   unsigned long len, __u64 flags);
+ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+		   unsigned long src_start, unsigned long len, __u64 flags);
 int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
 			struct vm_area_struct *dst_vma,
 			struct vm_area_struct *src_vma,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 6e2ca04ab04d..d55bf18b80db 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -19,20 +19,39 @@
 #include <asm/tlb.h>
 #include "internal.h"
 
-static __always_inline
-struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+void unpin_vma(struct mm_struct *mm, struct vm_area_struct *vma, bool *mmap_locked)
+{
+	BUG_ON(!vma && !*mmap_locked);
+
+	if (*mmap_locked) {
+		mmap_read_unlock(mm);
+		*mmap_locked = false;
+	} else
+		vma_end_read(vma);
+}
+
+/*
+ * Search for VMA and make sure it is stable either by locking it or taking
+ * mmap_lock.
+ */
+struct vm_area_struct *find_and_pin_dst_vma(struct mm_struct *dst_mm,
+					    unsigned long dst_start,
+					    unsigned long len,
+					    bool *mmap_locked)
 {
+	struct vm_area_struct *dst_vma = lock_vma_under_rcu(dst_mm, dst_start);
+	if (!dst_vma) {
+		mmap_read_lock(dst_mm);
+		*mmap_locked = true;
+		dst_vma = find_vma(dst_mm, dst_start);
+	}
+
 	/*
 	 * Make sure that the dst range is both valid and fully within a
 	 * single existing vma.
 	 */
-	struct vm_area_struct *dst_vma;
-
-	dst_vma = find_vma(dst_mm, dst_start);
 	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
-		return NULL;
+		goto unpin;
 
 	/*
 	 * Check the vma is registered in uffd, this is required to
@@ -40,9 +59,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		return NULL;
+		goto unpin;
 
 	return dst_vma;
+
+unpin:
+	unpin_vma(dst_mm, dst_vma, mmap_locked);
+	return NULL;
 }
 
 /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
@@ -350,7 +373,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
- * called with mmap_lock held, it will release mmap_lock before returning.
+ * called with either vma-lock or mmap_lock held, it will release the lock
+ * before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct userfaultfd_ctx *ctx,
@@ -358,7 +382,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      uffd_flags_t flags)
+					      uffd_flags_t flags,
+					      bool *mmap_locked)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -380,7 +405,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(dst_mm);
+		unpin_vma(dst_mm, dst_vma, mmap_locked);
 		return -EINVAL;
 	}
 
@@ -404,12 +429,25 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (!dst_vma) {
 		err = -ENOENT;
-		dst_vma = find_dst_vma(dst_mm, dst_start, len);
-		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
-			goto out_unlock;
+		dst_vma = find_and_pin_dst_vma(dst_mm, dst_start,
+					       len, mmap_locked);
+		if (!dst_vma)
+			goto out;
+		if (!is_vm_hugetlb_page(dst_vma))
+			goto out_unlock_vma;
 
 		err = -EINVAL;
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
+			goto out_unlock_vma;
+
+		/*
+		 * If memory mappings are changing because of non-cooperative
+		 * operation (e.g. mremap) running in parallel, bail out and
+		 * request the user to retry later
+		 */
+		down_read(&ctx->map_changing_lock);
+		err = -EAGAIN;
+		if (atomic_read(&ctx->mmap_changing))
 			goto out_unlock;
 
 		vm_shared = dst_vma->vm_flags & VM_SHARED;
@@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unpin_vma(dst_mm, dst_vma, mmap_locked);
 			BUG_ON(!folio);
 
 			err = copy_folio_from_user(folio,
@@ -474,17 +512,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				err = -EFAULT;
 				goto out;
 			}
-			mmap_read_lock(dst_mm);
-			down_read(&ctx->map_changing_lock);
-			/*
-			 * If memory mappings are changing because of non-cooperative
-			 * operation (e.g. mremap) running in parallel, bail out and
-			 * request the user to retry later
-			 */
-			if (atomic_read(ctx->mmap_changing)) {
-				err = -EAGAIN;
-				break;
-			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -505,7 +532,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+out_unlock_vma:
+	unpin_vma(dst_mm, dst_vma, mmap_locked);
 out:
 	if (folio)
 		folio_put(folio);
@@ -521,7 +549,8 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
-				    uffd_flags_t flags);
+				    uffd_flags_t flags,
+				    bool *mmap_locked);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
@@ -581,6 +610,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct folio *folio;
+	bool mmap_locked = false;
 
 	/*
 	 * Sanitize the command parameters:
@@ -597,7 +627,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	copied = 0;
 	folio = NULL;
 retry:
-	mmap_read_lock(dst_mm);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	err = -ENOENT;
+	dst_vma = find_and_pin_dst_vma(dst_mm, dst_start, len, &mmap_locked);
+	if (!dst_vma)
+		goto out;
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -609,15 +646,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	err = -ENOENT;
-	dst_vma = find_dst_vma(dst_mm, dst_start, len);
-	if (!dst_vma)
-		goto out_unlock;
-
 	err = -EINVAL;
 	/*
 	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
@@ -638,8 +666,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start, src_start
+					     len, flags, &mmap_locked);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
@@ -699,7 +727,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			unpin_vma(dst_mm, dst_vma, &mmap_locked);
+
 			BUG_ON(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
@@ -730,7 +759,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+	unpin_vma(dst_mm, dst_vma, &mmap_locked);
 out:
 	if (folio)
 		folio_put(folio);
@@ -1285,8 +1314,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * @len: length of the virtual memory range
  * @mode: flags from uffdio_move.mode
  *
- * Must be called with mmap_lock held for read.
- *
  * move_pages() remaps arbitrary anonymous pages atomically in zero
  * copy. It only works on non shared anonymous pages because those can
  * be relocated without generating non linear anon_vmas in the rmap
@@ -1353,15 +1380,16 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
  * could be obtained. This is the only additional complexity added to
  * the rmap code to provide this anonymous page remapping functionality.
  */
-ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
-		   unsigned long dst_start, unsigned long src_start,
-		   unsigned long len, __u64 mode)
+ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
+		   unsigned long src_start, unsigned long len, __u64 mode)
 {
+	struct mm_struct *mm = ctx->mm;
 	struct vm_area_struct *src_vma, *dst_vma;
 	unsigned long src_addr, dst_addr;
 	pmd_t *src_pmd, *dst_pmd;
 	long err = -EINVAL;
 	ssize_t moved = 0;
+	bool mmap_locked = false;
 
 	/* Sanitize the command parameters. */
 	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
@@ -1374,28 +1402,52 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	    WARN_ON_ONCE(dst_start + len <= dst_start))
 		goto out;
 
+	dst_vma = NULL;
+	src_vma = lock_vma_under_rcu(mm, src_start);
+	if (src_vma) {
+		dst_vma = lock_vma_under_rcu(mm, dst_start);
+		if (!dst_vma)
+			vma_end_read(src_vma);
+	}
+
+	/* If we failed to lock both VMAs, fall back to mmap_lock */
+	if (!dst_vma) {
+		mmap_read_lock(mm);
+		mmap_locked = true;
+		src_vma = find_vma(mm, src_start);
+		if (!src_vma)
+			goto out_unlock_mmap;
+		dst_vma = find_vma(mm, dst_start);
+		if (!dst_vma)
+			goto out_unlock_mmap;
+	}
+
+	/* Re-check after taking map_changing_lock */
+	down_read(&ctx->map_changing_lock);
+	if (likely(atomic_read(&ctx->mmap_changing))) {
+		err = -EAGAIN;
+		goto out_unlock;
+	}
 	/*
 	 * Make sure the vma is not shared, that the src and dst remap
 	 * ranges are both valid and fully within a single existing
 	 * vma.
 	 */
-	src_vma = find_vma(mm, src_start);
-	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
-		goto out;
+	if (src_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
 	if (src_start < src_vma->vm_start ||
 	    src_start + len > src_vma->vm_end)
-		goto out;
+		goto out_unlock;
 
-	dst_vma = find_vma(mm, dst_start);
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
-		goto out;
+	if (dst_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
 	if (dst_start < dst_vma->vm_start ||
 	    dst_start + len > dst_vma->vm_end)
-		goto out;
+		goto out_unlock;
 
 	err = validate_move_areas(ctx, src_vma, dst_vma);
 	if (err)
-		goto out;
+		goto out_unlock;
 
 	for (src_addr = src_start, dst_addr = dst_start;
 	     src_addr < src_start + len;) {
@@ -1512,6 +1564,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 		moved += step_size;
 	}
 
+out_unlock:
+	up_read(&ctx->map_changing_lock);
+out_unlock_mmap:
+	if (mmap_locked)
+		mmap_read_unlock(mm);
+	else {
+		vma_end_read(dst_vma);
+		vma_end_read(src_vma);
+	}
 out:
 	VM_WARN_ON(moved < 0);
 	VM_WARN_ON(err > 0);
-- 
2.43.0.429.g432eaa2c6b-goog


