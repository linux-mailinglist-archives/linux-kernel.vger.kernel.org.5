Return-Path: <linux-kernel+bounces-64402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A09853E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A022CB2ECFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF962A0F;
	Tue, 13 Feb 2024 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RN2es7S"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EF626DD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861482; cv=none; b=eQjeHQG5/Fva7P+aQQd4Jm8MqKJr5F9lBzIN0J2vIwmPJAiM3OesdShUZvRyWWGEnUWpYaB6k3F7OP70lNMbPrNg52nLIo3oGioKoUuYmd4JGr+2mcF+knriszz4HUVCcRM3FpaigpQ6ctHoD1bB3pzCCIPRP/Q4t9XG4/jpzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861482; c=relaxed/simple;
	bh=XUGeHpQkV/9HsTCyFVXOfk5NMRMbRKZRbtNS631SG20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=heBtX1XHrKViqb9ohLHkFt4cwAjff4WmjpwP5QoSskcyAdqzqPOlO1L1kcrOmwVdRB+AQKvVwklHWYzGwxqRWJLyVVus89DMllpuUz9/jXXxoMBvNqOHyuO8mgFNLfkKqU1cRpDE/2fX5xqcuEY9cXtuVKILiHFUcrgLKX58NeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RN2es7S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047a047f4cso125729187b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707861479; x=1708466279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/WOyhn1Esqfkwtwj2LaOT451Ry7/NR5qcNsraXDTSQ=;
        b=2RN2es7S+8jcAW4vQ9pIu6TB5UZSayYOWEgLsV8s5G739pWQy7olFzCuOFUtxPY5sA
         PwV4JciqsUJKLECahVL7Bq528lmhEqAuaojS57NC4Tz9MWpXhl5XWs8CRbKAzdzaXmfe
         pUkjhiXZ5K5wzSZv/kio9UTOinhn0vbBucxg4AxjKF0C+ZJ7jKBBNc6yD9YkZDKEkDOy
         Hr1U6BGWoXFZf8telrGTs1cq5foCggSy+gOfCB5HFIl1I/yosoHxGPppyWwdRgZCqHP7
         279QPd1eJt2QKcrs5cBoB+n/l4cdZ2GKqxQ517SIvAlw4hgjJsdWlMFbbs2od1TZ8xo1
         ViyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861479; x=1708466279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/WOyhn1Esqfkwtwj2LaOT451Ry7/NR5qcNsraXDTSQ=;
        b=EdWw5iIJdsNQWXqsinx74vNIXkjmkdyrJ2n7qKDd+n17PE0Y1u14KfMWtfc5DjZ6WM
         lsmN4raHjZ97CHEExPYGogTqxJRIFybQD9UAQcZclAzoBlTqyhrXFcIB/oGZHEXVE7Rg
         LaDjrPLrMqkrKdbFYWQCNXGGqabRr2HN8wB0gEsYqWFLf/IyOMK41ftepemwGkDwOuoe
         AJiV6uc2K0yaGV0iApt9jpEqEz41TsBMKRdA7F7PoU9q7v1K+X3xVkExB6tAfMXS+m4/
         lRIbqpQEbprKlqEqf8vmhyOOmOWshZmuMHjRlR9yHgxOQKbW7ro0OUQStN7Rk3LVh/fQ
         fA2A==
X-Forwarded-Encrypted: i=1; AJvYcCV33kNLHmJ5LC+WvQ5LUBGnSV+BRyY+BOrqPil8UN6y804E5mMI9yofyf6uMhsrcZ4MqsoQBvkLOY38fmE5pOyeVIY95QVR+BFbzB7z
X-Gm-Message-State: AOJu0Yz42Bp8GTsvR7YmIWumy8mL0wse28ekd3oLHCRfVqjQlIwgNzkO
	z/6blL9jpSi0i8k97WNPZ26qPQe0V48Vh6zYfCMEigaN3R5nyQJLM8N1ckS6+xmyBV/4yoVc/jZ
	pgCHvHIP58rFeJL9BZN0YOA==
X-Google-Smtp-Source: AGHT+IHJIuj37L0FH95ttZFfcm6tTpnuKI2ov+Gsmwkus7z86ConSVyz4Fbc9PZvGiQunLpi5PNtvfrZ0M1s41aMJA==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:ce6c:821f:a756:b4b8])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:1007:b0:dc9:5ef8:2b2d with
 SMTP id w7-20020a056902100700b00dc95ef82b2dmr149426ybt.4.1707861479206; Tue,
 13 Feb 2024 13:57:59 -0800 (PST)
Date: Tue, 13 Feb 2024 13:57:41 -0800
In-Reply-To: <20240213215741.3816570-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213215741.3816570-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213215741.3816570-4-lokeshgidra@google.com>
Subject: [PATCH v6 3/3] userfaultfd: use per-vma locks in userfaultfd operations
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

All userfaultfd operations, except write-protect, opportunistically use
per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
critical section.

Write-protect operation requires mmap_lock as it iterates over multiple
vmas.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c              |  13 +-
 include/linux/userfaultfd_k.h |   5 +-
 mm/userfaultfd.c              | 380 ++++++++++++++++++++++++++--------
 3 files changed, 296 insertions(+), 102 deletions(-)

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
index 74aad0831e40..4744d6a96f96 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -20,19 +20,11 @@
 #include "internal.h"
 
 static __always_inline
-struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
-				    unsigned long dst_start,
-				    unsigned long len)
+bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
-	/*
-	 * Make sure that the dst range is both valid and fully within a
-	 * single existing vma.
-	 */
-	struct vm_area_struct *dst_vma;
-
-	dst_vma = find_vma(dst_mm, dst_start);
-	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
-		return NULL;
+	/* Make sure that the dst range is fully within dst_vma. */
+	if (dst_end > dst_vma->vm_end)
+		return false;
 
 	/*
 	 * Check the vma is registered in uffd, this is required to
@@ -40,11 +32,122 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
 	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
-		return NULL;
+		return false;
+
+	return true;
+}
+
+static __always_inline
+struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
+						 unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	mmap_assert_locked(mm);
+	vma = vma_lookup(mm, addr);
+	if (!vma)
+		vma = ERR_PTR(-ENOENT);
+	else if (!(vma->vm_flags & VM_SHARED) &&
+		 unlikely(anon_vma_prepare(vma)))
+		vma = ERR_PTR(-ENOMEM);
+
+	return vma;
+}
+
+#ifdef CONFIG_PER_VMA_LOCK
+/*
+ * lock_vma() - Lookup and lock vma corresponding to @address.
+ * @mm: mm to search vma in.
+ * @address: address that the vma should contain.
+ *
+ * Should be called without holding mmap_lock. vma should be unlocked after use
+ * with unlock_vma().
+ *
+ * Return: A locked vma containing @address, -ENOENT if no vma is found, or
+ * -ENOMEM if anon_vma couldn't be allocated.
+ */
+static struct vm_area_struct *lock_vma(struct mm_struct *mm,
+				       unsigned long address)
+{
+	struct vm_area_struct *vma;
+
+	vma = lock_vma_under_rcu(mm, address);
+	if (vma) {
+		/*
+		 * lock_vma_under_rcu() only checks anon_vma for private
+		 * anonymous mappings. But we need to ensure it is assigned in
+		 * private file-backed vmas as well.
+		 */
+		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
+			vma_end_read(vma);
+		else
+			return vma;
+	}
+
+	mmap_read_lock(mm);
+	vma = find_vma_and_prepare_anon(mm, address);
+	if (!IS_ERR(vma)) {
+		/*
+		 * We cannot use vma_start_read() as it may fail due to
+		 * false locked (see comment in vma_start_read()). We
+		 * can avoid that by directly locking vm_lock under
+		 * mmap_lock, which guarantees that nobody can lock the
+		 * vma for write (vma_start_write()) under us.
+		 */
+		down_read(&vma->vm_lock->lock);
+	}
+
+	mmap_read_unlock(mm);
+	return vma;
+}
+
+static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
+					      unsigned long dst_start,
+					      unsigned long len)
+{
+	struct vm_area_struct *dst_vma;
 
+	dst_vma = lock_vma(dst_mm, dst_start);
+	if (IS_ERR(dst_vma) || validate_dst_vma(dst_vma, dst_start + len))
+		return dst_vma;
+
+	vma_end_read(dst_vma);
+	return ERR_PTR(-ENOENT);
+}
+
+static void uffd_mfill_unlock(struct vm_area_struct *vma)
+{
+	vma_end_read(vma);
+}
+
+#else
+
+static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
+					      unsigned long dst_start,
+					      unsigned long len)
+{
+	struct vm_area_struct *dst_vma;
+
+	mmap_read_lock(dst_mm);
+	dst_vma = find_vma_and_prepare_anon(dst_mm, dst_start);
+	if (IS_ERR(dst_vma))
+		goto out_unlock;
+
+	if (validate_dst_vma(dst_vma, dst_start + len))
+		return dst_vma;
+
+	dst_vma = ERR_PTR(-ENOENT);
+out_unlock:
+	mmap_read_unlock(dst_mm);
 	return dst_vma;
 }
 
+static void uffd_mfill_unlock(struct vm_area_struct *vma)
+{
+	mmap_read_unlock(vma->vm_mm);
+}
+#endif
+
 /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
 static bool mfill_file_over_size(struct vm_area_struct *dst_vma,
 				 unsigned long dst_addr)
@@ -350,7 +453,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 #ifdef CONFIG_HUGETLB_PAGE
 /*
  * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
- * called with mmap_lock held, it will release mmap_lock before returning.
+ * called with either vma-lock or mmap_lock held, it will release the lock
+ * before returning.
  */
 static __always_inline ssize_t mfill_atomic_hugetlb(
 					      struct userfaultfd_ctx *ctx,
@@ -361,7 +465,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
-	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
 	pte_t *dst_pte;
 	unsigned long src_addr, dst_addr;
@@ -380,7 +483,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 */
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		up_read(&ctx->map_changing_lock);
-		mmap_read_unlock(dst_mm);
+		uffd_mfill_unlock(dst_vma);
 		return -EINVAL;
 	}
 
@@ -403,24 +506,28 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * retry, dst_vma will be set to NULL and we must lookup again.
 	 */
 	if (!dst_vma) {
+		dst_vma = uffd_mfill_lock(dst_mm, dst_start, len);
+		if (IS_ERR(dst_vma)) {
+			err = PTR_ERR(dst_vma);
+			goto out;
+		}
+
 		err = -ENOENT;
-		dst_vma = find_dst_vma(dst_mm, dst_start, len);
-		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
-			goto out_unlock;
+		if (!is_vm_hugetlb_page(dst_vma))
+			goto out_unlock_vma;
 
 		err = -EINVAL;
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
-			goto out_unlock;
-
-		vm_shared = dst_vma->vm_flags & VM_SHARED;
-	}
+			goto out_unlock_vma;
 
-	/*
-	 * If not shared, ensure the dst_vma has a anon_vma.
-	 */
-	err = -ENOMEM;
-	if (!vm_shared) {
-		if (unlikely(anon_vma_prepare(dst_vma)))
+		/*
+		 * If memory mappings are changing because of non-cooperative
+		 * operation (e.g. mremap) running in parallel, bail out and
+		 * request the user to retry later
+		 */
+		down_read(&ctx->map_changing_lock);
+		err = -EAGAIN;
+		if (atomic_read(&ctx->mmap_changing))
 			goto out_unlock;
 	}
 
@@ -465,7 +572,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 		if (unlikely(err == -ENOENT)) {
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			uffd_mfill_unlock(dst_vma);
 			BUG_ON(!folio);
 
 			err = copy_folio_from_user(folio,
@@ -474,17 +581,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
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
-			if (atomic_read(&ctx->mmap_changing)) {
-				err = -EAGAIN;
-				break;
-			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -505,7 +601,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+out_unlock_vma:
+	uffd_mfill_unlock(dst_vma);
 out:
 	if (folio)
 		folio_put(folio);
@@ -597,7 +694,15 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	copied = 0;
 	folio = NULL;
 retry:
-	mmap_read_lock(dst_mm);
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	dst_vma = uffd_mfill_lock(dst_mm, dst_start, len);
+	if (IS_ERR(dst_vma)) {
+		err = PTR_ERR(dst_vma);
+		goto out;
+	}
 
 	/*
 	 * If memory mappings are changing because of non-cooperative
@@ -609,15 +714,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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
@@ -647,16 +743,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
-	/*
-	 * Ensure the dst_vma has a anon_vma or this page
-	 * would get a NULL anon_vma when moved in the
-	 * dst_vma.
-	 */
-	err = -ENOMEM;
-	if (!(dst_vma->vm_flags & VM_SHARED) &&
-	    unlikely(anon_vma_prepare(dst_vma)))
-		goto out_unlock;
-
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 
@@ -699,7 +785,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			void *kaddr;
 
 			up_read(&ctx->map_changing_lock);
-			mmap_read_unlock(dst_mm);
+			uffd_mfill_unlock(dst_vma);
 			BUG_ON(!folio);
 
 			kaddr = kmap_local_folio(folio, 0);
@@ -730,7 +816,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 out_unlock:
 	up_read(&ctx->map_changing_lock);
-	mmap_read_unlock(dst_mm);
+	uffd_mfill_unlock(dst_vma);
 out:
 	if (folio)
 		folio_put(folio);
@@ -1267,27 +1353,136 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
 	if (!vma_is_anonymous(src_vma) || !vma_is_anonymous(dst_vma))
 		return -EINVAL;
 
+	return 0;
+}
+
+static __always_inline
+int find_vmas_mm_locked(struct mm_struct *mm,
+			unsigned long dst_start,
+			unsigned long src_start,
+			struct vm_area_struct **dst_vmap,
+			struct vm_area_struct **src_vmap)
+{
+	struct vm_area_struct *vma;
+
+	mmap_assert_locked(mm);
+	vma = find_vma_and_prepare_anon(mm, dst_start);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
+
+	*dst_vmap = vma;
+	/* Skip finding src_vma if src_start is in dst_vma */
+	if (src_start >= vma->vm_start && src_start < vma->vm_end)
+		goto out_success;
+
+	vma = vma_lookup(mm, src_start);
+	if (!vma)
+		return -ENOENT;
+out_success:
+	*src_vmap = vma;
+	return 0;
+}
+
+#ifdef CONFIG_PER_VMA_LOCK
+static int uffd_move_lock(struct mm_struct *mm,
+			  unsigned long dst_start,
+			  unsigned long src_start,
+			  struct vm_area_struct **dst_vmap,
+			  struct vm_area_struct **src_vmap)
+{
+	struct vm_area_struct *vma;
+	int err;
+
+	vma = lock_vma(mm, dst_start);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
+
+	*dst_vmap = vma;
 	/*
-	 * Ensure the dst_vma has a anon_vma or this page
-	 * would get a NULL anon_vma when moved in the
-	 * dst_vma.
+	 * Skip finding src_vma if src_start is in dst_vma. This also ensures
+	 * that we don't lock the same vma twice.
 	 */
-	if (unlikely(anon_vma_prepare(dst_vma)))
-		return -ENOMEM;
+	if (src_start >= vma->vm_start && src_start < vma->vm_end) {
+		*src_vmap = vma;
+		return 0;
+	}
 
-	return 0;
+	/*
+	 * Using lock_vma() to get src_vma can lead to following deadlock:
+	 *
+	 * Thread1				Thread2
+	 * -------				-------
+	 * vma_start_read(dst_vma)
+	 *					mmap_write_lock(mm)
+	 *					vma_start_write(src_vma)
+	 * vma_start_read(src_vma)
+	 * mmap_read_lock(mm)
+	 *					vma_start_write(dst_vma)
+	 */
+	*src_vmap = lock_vma_under_rcu(mm, src_start);
+	if (likely(*src_vmap))
+		return 0;
+
+	/* Undo any locking and retry in mmap_lock critical section */
+	vma_end_read(*dst_vmap);
+
+	mmap_read_lock(mm);
+	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
+	if (!err) {
+		/*
+		 * See comment in lock_vma() as to why not using
+		 * vma_start_read() here.
+		 */
+		down_read(&(*dst_vmap)->vm_lock->lock);
+		if (*dst_vmap != *src_vmap)
+			down_read(&(*src_vmap)->vm_lock->lock);
+	}
+	mmap_read_unlock(mm);
+	return err;
+}
+
+static void uffd_move_unlock(struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma)
+{
+	vma_end_read(src_vma);
+	if (src_vma != dst_vma)
+		vma_end_read(dst_vma);
 }
 
+#else
+
+static int uffd_move_lock(struct mm_struct *mm,
+			  unsigned long dst_start,
+			  unsigned long src_start,
+			  struct vm_area_struct **dst_vmap,
+			  struct vm_area_struct **src_vmap)
+{
+	int err;
+
+	mmap_read_lock(mm);
+	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
+	if (err)
+		mmap_read_unlock(mm);
+	return err;
+}
+
+static void uffd_move_unlock(struct vm_area_struct *dst_vma,
+			     struct vm_area_struct *src_vma)
+{
+	mmap_assert_locked(src_vma->vm_mm);
+	mmap_read_unlock(dst_vma->vm_mm);
+}
+#endif
+
 /**
  * move_pages - move arbitrary anonymous pages of an existing vma
  * @ctx: pointer to the userfaultfd context
- * @mm: the address space to move pages
  * @dst_start: start of the destination virtual memory range
  * @src_start: start of the source virtual memory range
  * @len: length of the virtual memory range
  * @mode: flags from uffdio_move.mode
  *
- * Must be called with mmap_lock held for read.
+ * It will either use the mmap_lock in read mode or per-vma locks
  *
  * move_pages() remaps arbitrary anonymous pages atomically in zero
  * copy. It only works on non shared anonymous pages because those can
@@ -1355,10 +1550,10 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
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
@@ -1376,28 +1571,34 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 	    WARN_ON_ONCE(dst_start + len <= dst_start))
 		goto out;
 
+	err = uffd_move_lock(mm, dst_start, src_start, &dst_vma, &src_vma);
+	if (err)
+		goto out;
+
+	/* Re-check after taking map_changing_lock */
+	err = -EAGAIN;
+	down_read(&ctx->map_changing_lock);
+	if (likely(atomic_read(&ctx->mmap_changing)))
+		goto out_unlock;
 	/*
 	 * Make sure the vma is not shared, that the src and dst remap
 	 * ranges are both valid and fully within a single existing
 	 * vma.
 	 */
-	src_vma = find_vma(mm, src_start);
-	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
-		goto out;
-	if (src_start < src_vma->vm_start ||
-	    src_start + len > src_vma->vm_end)
-		goto out;
+	err = -EINVAL;
+	if (src_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
+	if (src_start + len > src_vma->vm_end)
+		goto out_unlock;
 
-	dst_vma = find_vma(mm, dst_start);
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
-		goto out;
-	if (dst_start < dst_vma->vm_start ||
-	    dst_start + len > dst_vma->vm_end)
-		goto out;
+	if (dst_vma->vm_flags & VM_SHARED)
+		goto out_unlock;
+	if (dst_start + len > dst_vma->vm_end)
+		goto out_unlock;
 
 	err = validate_move_areas(ctx, src_vma, dst_vma);
 	if (err)
-		goto out;
+		goto out_unlock;
 
 	for (src_addr = src_start, dst_addr = dst_start;
 	     src_addr < src_start + len;) {
@@ -1514,6 +1715,9 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
 		moved += step_size;
 	}
 
+out_unlock:
+	up_read(&ctx->map_changing_lock);
+	uffd_move_unlock(dst_vma, src_vma);
 out:
 	VM_WARN_ON(moved < 0);
 	VM_WARN_ON(err > 0);
-- 
2.43.0.687.g38aa6559b0-goog


