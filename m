Return-Path: <linux-kernel+bounces-79388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F9B86217D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BF51C22D89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574B469E;
	Sat, 24 Feb 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klNlTuNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016917CE;
	Sat, 24 Feb 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736975; cv=none; b=bm+H/hXj03sl1WJSkomiE2Xua6mZiZzFuy1icD/uouXcc89Bz75QR/BxyTMiuaRn5oTOjReeO5x05Iz07u+gFZQhGe/zkSl8h8sOgRndHtznmepwKAFpWVoAPos1D+kBvvdECaNgaSPePrrab+H50362xZoYTirM+fsMBsdYBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736975; c=relaxed/simple;
	bh=FedLd3OyqEeojNFCrXvGZNm8G6ll6/PZ6Q/S99on0HQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2xsNzmC9oQySZuUCGckcWIWnQvHf8ERQHAHBoIszuoAdaJhI8iGey713FMQ0d8gaaJdFYT50E+YXYpwjITTtMlPsOXaP47QfM+8PjQaQ2q36SPkef8M03QsoxzzymrXV33YhRIHEVinYQJKkZgaPVJdYLBa+9ermW9R0kpwumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klNlTuNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F6C433C7;
	Sat, 24 Feb 2024 01:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708736974;
	bh=FedLd3OyqEeojNFCrXvGZNm8G6ll6/PZ6Q/S99on0HQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=klNlTuNKhOa/VYeauwyi4Ahxt92A0QxYYKZCPEK5kIt9csGiVEZCW9XCrmQa8Vmh6
	 7SXcZ4FgHJf2gnf36NNpEztrwaTHtZ+KDnnNG3Bpv+fftLIwxSPKAScIMkkLWOpEBK
	 HmvJ+4V8LnJLb5b8N0WoKyTywWf3SdaRU7pNOsL1pqJFH1Khrt5AJJLOeiT9yvI7Ed
	 8X4WZSrX3V1IXewLDuRug8mLPkzDJB+zh5Db3ozoZi3EGvcy8gPhakOrq9hf4D+BXU
	 tw1ORbvYULG/tr23lXnLmq4hIVIsTdeJ8FJfuyBCyGow8OfJgbanl5R+OtwlN2Bx0o
	 V7AajO08K9oEw==
Date: Fri, 23 Feb 2024 17:09:34 -0800
Subject: [PATCH 2/4] eytzinger: Promote to include/linux/
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873667529.1860799.13732440135792774698.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
References: <170873667479.1860799.16660964083961996807.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

eytzinger trees are a faster alternative to binary search. They're a bit
more expensive to setup, but lookups perform much better assuming the
tree isn't entirely in cache.

Binary search is a worst case scenario for branch prediction and
prefetching, but eytzinger trees have children adjacent in memory and
thus we can prefetch before knowing the result of a comparison.

An eytzinger tree is a binary tree laid out in an array, with the same
geometry as the usual binary heap construction, but used as a search
tree instead.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                         |    6 +
 fs/bcachefs/bset.c                  |    2 
 fs/bcachefs/journal_seq_blacklist.c |    6 +
 fs/bcachefs/replicas.c              |   19 +++--
 fs/bcachefs/replicas.h              |    3 -
 fs/bcachefs/super-io.h              |    2 
 fs/bcachefs/util.c                  |  145 -----------------------------------
 fs/bcachefs/util.h                  |    4 -
 include/linux/eytzinger.h           |   58 ++++++++------
 lib/sort.c                          |   89 +++++++++++++++++++++
 10 files changed, 148 insertions(+), 186 deletions(-)
 rename fs/bcachefs/eytzinger.h => include/linux/eytzinger.h (77%)


diff --git a/MAINTAINERS b/MAINTAINERS
index 3e13de69b7f07..98a17270566d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8066,6 +8066,12 @@ L:	iommu@lists.linux.dev
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
 
+EYTZINGER TREE LIB
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-bcachefs@vger.kernel.org
+S:	Maintained
+F:	include/linux/eytzinger.h
+
 F2FS FILE SYSTEM
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
 M:	Chao Yu <chao@kernel.org>
diff --git a/fs/bcachefs/bset.c b/fs/bcachefs/bset.c
index 3fd1085b6c61e..1d77aa55d641c 100644
--- a/fs/bcachefs/bset.c
+++ b/fs/bcachefs/bset.c
@@ -9,12 +9,12 @@
 #include "bcachefs.h"
 #include "btree_cache.h"
 #include "bset.h"
-#include "eytzinger.h"
 #include "trace.h"
 #include "util.h"
 
 #include <asm/unaligned.h>
 #include <linux/console.h>
+#include <linux/eytzinger.h>
 #include <linux/random.h>
 #include <linux/prefetch.h>
 
diff --git a/fs/bcachefs/journal_seq_blacklist.c b/fs/bcachefs/journal_seq_blacklist.c
index 0200e299cfbb9..024c9b1b323f8 100644
--- a/fs/bcachefs/journal_seq_blacklist.c
+++ b/fs/bcachefs/journal_seq_blacklist.c
@@ -2,10 +2,11 @@
 
 #include "bcachefs.h"
 #include "btree_iter.h"
-#include "eytzinger.h"
 #include "journal_seq_blacklist.h"
 #include "super-io.h"
 
+#include <linux/eytzinger.h>
+
 /*
  * journal_seq_blacklist machinery:
  *
@@ -119,8 +120,7 @@ int bch2_journal_seq_blacklist_add(struct bch_fs *c, u64 start, u64 end)
 	return ret ?: bch2_blacklist_table_initialize(c);
 }
 
-static int journal_seq_blacklist_table_cmp(const void *_l,
-					   const void *_r, size_t size)
+static int journal_seq_blacklist_table_cmp(const void *_l, const void *_r)
 {
 	const struct journal_seq_blacklist_table_entry *l = _l;
 	const struct journal_seq_blacklist_table_entry *r = _r;
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index cc2672c120312..678b9c20e2514 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -6,12 +6,15 @@
 #include "replicas.h"
 #include "super-io.h"
 
+#include <linux/sort.h>
+
 static int bch2_cpu_replicas_to_sb_replicas(struct bch_fs *,
 					    struct bch_replicas_cpu *);
 
 /* Some (buggy!) compilers don't allow memcmp to be passed as a pointer */
-static int bch2_memcmp(const void *l, const void *r, size_t size)
+static int bch2_memcmp(const void *l, const void *r,  const void *priv)
 {
+	size_t size = (size_t) priv;
 	return memcmp(l, r, size);
 }
 
@@ -39,7 +42,8 @@ void bch2_replicas_entry_sort(struct bch_replicas_entry_v1 *e)
 
 static void bch2_cpu_replicas_sort(struct bch_replicas_cpu *r)
 {
-	eytzinger0_sort(r->entries, r->nr, r->entry_size, bch2_memcmp, NULL);
+	eytzinger0_sort_r(r->entries, r->nr, r->entry_size,
+			  bch2_memcmp, NULL, (void *)(size_t)r->entry_size);
 }
 
 static void bch2_replicas_entry_v0_to_text(struct printbuf *out,
@@ -228,7 +232,7 @@ static inline int __replicas_entry_idx(struct bch_replicas_cpu *r,
 
 	verify_replicas_entry(search);
 
-#define entry_cmp(_l, _r, size)	memcmp(_l, _r, entry_size)
+#define entry_cmp(_l, _r)	memcmp(_l, _r, entry_size)
 	idx = eytzinger0_find(r->entries, r->nr, r->entry_size,
 			      entry_cmp, search);
 #undef entry_cmp
@@ -824,10 +828,11 @@ static int bch2_cpu_replicas_validate(struct bch_replicas_cpu *cpu_r,
 {
 	unsigned i;
 
-	sort_cmp_size(cpu_r->entries,
-		      cpu_r->nr,
-		      cpu_r->entry_size,
-		      bch2_memcmp, NULL);
+	sort_r(cpu_r->entries,
+	       cpu_r->nr,
+	       cpu_r->entry_size,
+	       bch2_memcmp, NULL,
+	       (void *)(size_t)cpu_r->entry_size);
 
 	for (i = 0; i < cpu_r->nr; i++) {
 		struct bch_replicas_entry_v1 *e =
diff --git a/fs/bcachefs/replicas.h b/fs/bcachefs/replicas.h
index 654a4b26d3a3c..983cce782ac2a 100644
--- a/fs/bcachefs/replicas.h
+++ b/fs/bcachefs/replicas.h
@@ -3,9 +3,10 @@
 #define _BCACHEFS_REPLICAS_H
 
 #include "bkey.h"
-#include "eytzinger.h"
 #include "replicas_types.h"
 
+#include <linux/eytzinger.h>
+
 void bch2_replicas_entry_sort(struct bch_replicas_entry_v1 *);
 void bch2_replicas_entry_to_text(struct printbuf *,
 				 struct bch_replicas_entry_v1 *);
diff --git a/fs/bcachefs/super-io.h b/fs/bcachefs/super-io.h
index 95e80e06316bf..f37620919e11a 100644
--- a/fs/bcachefs/super-io.h
+++ b/fs/bcachefs/super-io.h
@@ -3,12 +3,12 @@
 #define _BCACHEFS_SUPER_IO_H
 
 #include "extents.h"
-#include "eytzinger.h"
 #include "super_types.h"
 #include "super.h"
 #include "sb-members.h"
 
 #include <asm/byteorder.h>
+#include <linux/eytzinger.h>
 
 static inline bool bch2_version_compatible(u16 version)
 {
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index c9d13dcf3ef1a..902f6b1a8a142 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -11,6 +11,7 @@
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/eytzinger.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/log2.h>
@@ -24,7 +25,6 @@
 #include <linux/sched/clock.h>
 #include <linux/mean_and_variance.h>
 
-#include "eytzinger.h"
 #include "util.h"
 
 static const char si_units[] = "?kMGTPEZY";
@@ -864,149 +864,6 @@ void memcpy_from_bio(void *dst, struct bio *src, struct bvec_iter src_iter)
 	}
 }
 
-static int alignment_ok(const void *base, size_t align)
-{
-	return IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
-		((unsigned long)base & (align - 1)) == 0;
-}
-
-static void u32_swap(void *a, void *b, size_t size)
-{
-	u32 t = *(u32 *)a;
-	*(u32 *)a = *(u32 *)b;
-	*(u32 *)b = t;
-}
-
-static void u64_swap(void *a, void *b, size_t size)
-{
-	u64 t = *(u64 *)a;
-	*(u64 *)a = *(u64 *)b;
-	*(u64 *)b = t;
-}
-
-static void generic_swap(void *a, void *b, size_t size)
-{
-	char t;
-
-	do {
-		t = *(char *)a;
-		*(char *)a++ = *(char *)b;
-		*(char *)b++ = t;
-	} while (--size > 0);
-}
-
-static inline int do_cmp(void *base, size_t n, size_t size,
-			 int (*cmp_func)(const void *, const void *, size_t),
-			 size_t l, size_t r)
-{
-	return cmp_func(base + inorder_to_eytzinger0(l, n) * size,
-			base + inorder_to_eytzinger0(r, n) * size,
-			size);
-}
-
-static inline void do_swap(void *base, size_t n, size_t size,
-			   void (*swap_func)(void *, void *, size_t),
-			   size_t l, size_t r)
-{
-	swap_func(base + inorder_to_eytzinger0(l, n) * size,
-		  base + inorder_to_eytzinger0(r, n) * size,
-		  size);
-}
-
-void eytzinger0_sort(void *base, size_t n, size_t size,
-		     int (*cmp_func)(const void *, const void *, size_t),
-		     void (*swap_func)(void *, void *, size_t))
-{
-	int i, c, r;
-
-	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
-		else
-			swap_func = generic_swap;
-	}
-
-	/* heapify */
-	for (i = n / 2 - 1; i >= 0; --i) {
-		for (r = i; r * 2 + 1 < n; r = c) {
-			c = r * 2 + 1;
-
-			if (c + 1 < n &&
-			    do_cmp(base, n, size, cmp_func, c, c + 1) < 0)
-				c++;
-
-			if (do_cmp(base, n, size, cmp_func, r, c) >= 0)
-				break;
-
-			do_swap(base, n, size, swap_func, r, c);
-		}
-	}
-
-	/* sort */
-	for (i = n - 1; i > 0; --i) {
-		do_swap(base, n, size, swap_func, 0, i);
-
-		for (r = 0; r * 2 + 1 < i; r = c) {
-			c = r * 2 + 1;
-
-			if (c + 1 < i &&
-			    do_cmp(base, n, size, cmp_func, c, c + 1) < 0)
-				c++;
-
-			if (do_cmp(base, n, size, cmp_func, r, c) >= 0)
-				break;
-
-			do_swap(base, n, size, swap_func, r, c);
-		}
-	}
-}
-
-void sort_cmp_size(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *, size_t),
-	  void (*swap_func)(void *, void *, size_t size))
-{
-	/* pre-scale counters for performance */
-	int i = (num/2 - 1) * size, n = num * size, c, r;
-
-	if (!swap_func) {
-		if (size == 4 && alignment_ok(base, 4))
-			swap_func = u32_swap;
-		else if (size == 8 && alignment_ok(base, 8))
-			swap_func = u64_swap;
-		else
-			swap_func = generic_swap;
-	}
-
-	/* heapify */
-	for ( ; i >= 0; i -= size) {
-		for (r = i; r * 2 + size < n; r  = c) {
-			c = r * 2 + size;
-			if (c < n - size &&
-			    cmp_func(base + c, base + c + size, size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c, size) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
-		}
-	}
-
-	/* sort */
-	for (i = n - size; i > 0; i -= size) {
-		swap_func(base, base + i, size);
-		for (r = 0; r * 2 + size < i; r = c) {
-			c = r * 2 + size;
-			if (c < i - size &&
-			    cmp_func(base + c, base + c + size, size) < 0)
-				c += size;
-			if (cmp_func(base + r, base + c, size) >= 0)
-				break;
-			swap_func(base + r, base + c, size);
-		}
-	}
-}
-
 static void mempool_free_vp(void *element, void *pool_data)
 {
 	size_t size = (size_t) pool_data;
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 0059481995ef7..c3b11c3d24ea9 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -737,10 +737,6 @@ static inline void memset_u64s_tail(void *s, int c, unsigned bytes)
 	memset(s + bytes, c, rem);
 }
 
-void sort_cmp_size(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *, size_t),
-	  void (*swap_func)(void *, void *, size_t));
-
 /* just the memmove, doesn't update @_nr */
 #define __array_insert_item(_array, _nr, _pos)				\
 	memmove(&(_array)[(_pos) + 1],					\
diff --git a/fs/bcachefs/eytzinger.h b/include/linux/eytzinger.h
similarity index 77%
rename from fs/bcachefs/eytzinger.h
rename to include/linux/eytzinger.h
index b04750dbf870b..1031501030449 100644
--- a/fs/bcachefs/eytzinger.h
+++ b/include/linux/eytzinger.h
@@ -1,27 +1,37 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _EYTZINGER_H
-#define _EYTZINGER_H
+#ifndef _LINUX_EYTZINGER_H
+#define _LINUX_EYTZINGER_H
 
 #include <linux/bitops.h>
 #include <linux/log2.h>
 
-#include "util.h"
+#ifdef EYTZINGER_DEBUG
+#define EYTZINGER_BUG_ON(cond)		BUG_ON(cond)
+#else
+#define EYTZINGER_BUG_ON(cond)
+#endif
 
 /*
  * Traversal for trees in eytzinger layout - a full binary tree layed out in an
- * array
- */
-
-/*
- * One based indexing version:
+ * array.
  *
- * With one based indexing each level of the tree starts at a power of two -
- * good for cacheline alignment:
+ * Consider using an eytzinger tree any time you would otherwise be doing binary
+ * search over an array. Binary search is a worst case scenario for branch
+ * prediction and prefetching, but in an eytzinger tree every node's children
+ * are adjacent in memory, thus we can prefetch children before knowing the
+ * result of the comparison, assuming multiple nodes fit on a cacheline.
+ *
+ * Two variants are provided, for one based indexing and zero based indexing.
+ *
+ * Zero based indexing is more convenient, but one based indexing has better
+ * alignment and thus better performance because each new level of the tree
+ * starts at a power of two, and thus if element 0 was cacheline aligned, each
+ * new level will be as well.
  */
 
 static inline unsigned eytzinger1_child(unsigned i, unsigned child)
 {
-	EBUG_ON(child > 1);
+	EYTZINGER_BUG_ON(child > 1);
 
 	return (i << 1) + child;
 }
@@ -58,7 +68,7 @@ static inline unsigned eytzinger1_last(unsigned size)
 
 static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 {
-	EBUG_ON(i > size);
+	EYTZINGER_BUG_ON(i > size);
 
 	if (eytzinger1_right_child(i) <= size) {
 		i = eytzinger1_right_child(i);
@@ -74,7 +84,7 @@ static inline unsigned eytzinger1_next(unsigned i, unsigned size)
 
 static inline unsigned eytzinger1_prev(unsigned i, unsigned size)
 {
-	EBUG_ON(i > size);
+	EYTZINGER_BUG_ON(i > size);
 
 	if (eytzinger1_left_child(i) <= size) {
 		i = eytzinger1_left_child(i) + 1;
@@ -101,7 +111,7 @@ static inline unsigned __eytzinger1_to_inorder(unsigned i, unsigned size,
 	unsigned shift = __fls(size) - b;
 	int s;
 
-	EBUG_ON(!i || i > size);
+	EYTZINGER_BUG_ON(!i || i > size);
 
 	i  ^= 1U << b;
 	i <<= 1;
@@ -126,7 +136,7 @@ static inline unsigned __inorder_to_eytzinger1(unsigned i, unsigned size,
 	unsigned shift;
 	int s;
 
-	EBUG_ON(!i || i > size);
+	EYTZINGER_BUG_ON(!i || i > size);
 
 	/*
 	 * sign bit trick:
@@ -164,7 +174,7 @@ static inline unsigned inorder_to_eytzinger1(unsigned i, unsigned size)
 
 static inline unsigned eytzinger0_child(unsigned i, unsigned child)
 {
-	EBUG_ON(child > 1);
+	EYTZINGER_BUG_ON(child > 1);
 
 	return (i << 1) + 1 + child;
 }
@@ -231,11 +241,9 @@ static inline unsigned inorder_to_eytzinger0(unsigned i, unsigned size)
 	     (_i) != -1;				\
 	     (_i) = eytzinger0_next((_i), (_size)))
 
-typedef int (*eytzinger_cmp_fn)(const void *l, const void *r, size_t size);
-
 /* return greatest node <= @search, or -1 if not found */
 static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
-					 eytzinger_cmp_fn cmp, const void *search)
+					 cmp_func_t cmp, const void *search)
 {
 	unsigned i, n = 0;
 
@@ -244,7 +252,7 @@ static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
 
 	do {
 		i = n;
-		n = eytzinger0_child(i, cmp(search, base + i * size, size) >= 0);
+		n = eytzinger0_child(i, cmp(search, base + i * size) >= 0);
 	} while (n < nr);
 
 	if (n & 1) {
@@ -269,13 +277,13 @@ static inline ssize_t eytzinger0_find_le(void *base, size_t nr, size_t size,
 	int _res;							\
 									\
 	while (_i < _nr &&						\
-	       (_res = _cmp(_search, _base + _i * _size, _size)))	\
+	       (_res = _cmp(_search, _base + _i * _size)))		\
 		_i = eytzinger0_child(_i, _res > 0);			\
 	_i;								\
 })
 
-void eytzinger0_sort(void *, size_t, size_t,
-		    int (*cmp_func)(const void *, const void *, size_t),
-		    void (*swap_func)(void *, void *, size_t));
+void eytzinger0_sort_r(void *, size_t, size_t,
+		       cmp_r_func_t, swap_r_func_t, const void *);
+void eytzinger0_sort(void *, size_t, size_t, cmp_func_t, swap_func_t);
 
-#endif /* _EYTZINGER_H */
+#endif /* _LINUX_EYTZINGER_H */
diff --git a/lib/sort.c b/lib/sort.c
index b399bf10d6759..f5b2206c73461 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -290,3 +290,92 @@ void sort(void *base, size_t num, size_t size,
 	return sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
 }
 EXPORT_SYMBOL(sort);
+
+#include <linux/eytzinger.h>
+
+static inline int eytzinger0_do_cmp(void *base, size_t n, size_t size,
+			 cmp_r_func_t cmp_func, const void *priv,
+			 size_t l, size_t r)
+{
+	return do_cmp(base + inorder_to_eytzinger0(l, n) * size,
+		      base + inorder_to_eytzinger0(r, n) * size,
+		      cmp_func, priv);
+}
+
+static inline void eytzinger0_do_swap(void *base, size_t n, size_t size,
+			   swap_r_func_t swap_func, const void *priv,
+			   size_t l, size_t r)
+{
+	do_swap(base + inorder_to_eytzinger0(l, n) * size,
+		base + inorder_to_eytzinger0(r, n) * size,
+		size, swap_func, priv);
+}
+
+void eytzinger0_sort_r(void *base, size_t n, size_t size,
+		       cmp_r_func_t cmp_func,
+		       swap_r_func_t swap_func,
+		       const void *priv)
+{
+	int i, c, r;
+
+	/* called from 'sort' without swap function, let's pick the default */
+	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap)
+		swap_func = NULL;
+
+	if (!swap_func) {
+		if (is_aligned(base, size, 8))
+			swap_func = SWAP_WORDS_64;
+		else if (is_aligned(base, size, 4))
+			swap_func = SWAP_WORDS_32;
+		else
+			swap_func = SWAP_BYTES;
+	}
+
+	/* heapify */
+	for (i = n / 2 - 1; i >= 0; --i) {
+		for (r = i; r * 2 + 1 < n; r = c) {
+			c = r * 2 + 1;
+
+			if (c + 1 < n &&
+			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
+				c++;
+
+			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
+				break;
+
+			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		}
+	}
+
+	/* sort */
+	for (i = n - 1; i > 0; --i) {
+		eytzinger0_do_swap(base, n, size, swap_func, priv, 0, i);
+
+		for (r = 0; r * 2 + 1 < i; r = c) {
+			c = r * 2 + 1;
+
+			if (c + 1 < i &&
+			    eytzinger0_do_cmp(base, n, size, cmp_func, priv, c, c + 1) < 0)
+				c++;
+
+			if (eytzinger0_do_cmp(base, n, size, cmp_func, priv, r, c) >= 0)
+				break;
+
+			eytzinger0_do_swap(base, n, size, swap_func, priv, r, c);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eytzinger0_sort_r);
+
+void eytzinger0_sort(void *base, size_t n, size_t size,
+		     cmp_func_t cmp_func,
+		     swap_func_t swap_func)
+{
+	struct wrapper w = {
+		.cmp  = cmp_func,
+		.swap = swap_func,
+	};
+
+	return eytzinger0_sort_r(base, n, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
+}
+EXPORT_SYMBOL_GPL(eytzinger0_sort);


