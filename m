Return-Path: <linux-kernel+bounces-118189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6F888B595
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40912E7613
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EE12838F;
	Mon, 25 Mar 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbE/R+nq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75425127B62
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410633; cv=none; b=biClwxuSCXCBmTbUKwTfMLgA7l3+X8iMwdIHsAKGaF9m9rs3Er8pIUJDoSQLZ3Bp1QDKAmrSMG4OgEtfebGJc3t3J6MCTxOS7DPbwWBFrBNoRqMud8vWkJhhHnaxoaR0dg+Aq/XKZI/svoTxc6eqa1YbHHm2oLmFnVRLbxfEyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410633; c=relaxed/simple;
	bh=ms64h5+7StXPRldy0PEcIOWgPm2l+gGBLc2kLYJLR1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LE6+FqSd1ZdrmgLAK2MC/TI8StlLRqilk7y6jBgl05pcymrTGhQb2KBmnCIei3Sq0mvODCFj2dkMK2Auc9znpecH1MZD6jpcDUO6ULd1NY4Z6bigN8O58J/Kk4gBk6kXkawMaLpwIGYY+QlhddNdpmt7FxtvpqDVkd5XJSlDtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbE/R+nq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so6169641276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410630; x=1712015430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaCCk+fj5n3OUjEVk3zw3Mi2iE3P+5rpOrMtgAMtN6o=;
        b=XbE/R+nqRlBZWK8wzY0OUcAleromwQSEwlCj8re6CMPOKtNVk5b5DMNqTIZajbwmma
         sZGqGXoKgfHkzsg+dYVY2dQBnxEHijBx/Yt9gMHfPPOh57JOGMEvabBYxyfc0z1gIXe1
         tkJyW4SKfm8lkxUBATx7BhjpLRPgBL0v4bk2V7o7/vxWYKDoiaNuntan9sItk8jc3HxO
         kMHXxTaeI8QZJiSryeh12g11TNoj7VUcRvN3UfE3bRt0NOQ6u5fb9UJTn+HK1IUUrAv2
         htwYa7eeDqoRwUromp207jyFMQpPkxGVMpxlH6V1kekA8GTiXycK2nEnoEr575tbeEbg
         Gb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410630; x=1712015430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaCCk+fj5n3OUjEVk3zw3Mi2iE3P+5rpOrMtgAMtN6o=;
        b=YdXu1LDA5jMzjQHU5WvEJjP0fas9lGoXzu3483u7VSz8ctTKe5GFWnOjhbUZxHZ36X
         r3rkqLq3Nv2wu0BUHS4k58Cy39m5/dVrkFa8vWmfkYaBHUjVjgc1EGa/pPbOYubd0WpT
         h+Jml22fiZxpQFxroB7peZHux5sk/uVdiOXHDEFWl+E+Tlho+Emta9EYUaUoqaIFRBV2
         xTdOqXYwEWrJSlUeooJc5bJTUA0H01XVzv+FK5oE7ls9OF/Btjq9Iu09p6Ebi24FaHao
         Yt0yoBRX2bbfktTJ7cz3FK+sWW/8fRcfltk3GeXDOYK3IUfS5nMmOeWniCNVZ/xsL+nz
         avoA==
X-Forwarded-Encrypted: i=1; AJvYcCVY38t5dhXAQLuQ47A1ELoexp62kZllmYFtRMq3Hv83g5mFo+yIfL1hx+xgXOCtSGUfcmw6cvpQJxKsA6zvJXldr0nh7b76jOjye2c8
X-Gm-Message-State: AOJu0Yy+Oi63J5DQNIQXLAuBV3a3dJbwR4Xh8etyUJpV3hgwxF2RBGEJ
	vQR+Z98N7ZxgfYqGIFMzT+uBDItmbeWJjTlXiKsmDVyu+jifMlpYyWmmPsZ8e8SWJBRhLYuDrSF
	VOU7qwrbq+AHAqed5JQ==
X-Google-Smtp-Source: AGHT+IEOvQVqxv2Y0ouP0PCwiv8cpiRAswb4b3lmfWQXPAhEkV469xAOUnqSRda9DyCx6d0T4Sypd2qE7f/9L3CU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:705:b0:dcd:59a5:7545 with SMTP
 id k5-20020a056902070500b00dcd59a57545mr451342ybt.10.1711410629980; Mon, 25
 Mar 2024 16:50:29 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:14 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-7-yosryahmed@google.com>
Subject: [RFC PATCH 6/9] mm: zswap: drop support for non-zero same-filled
 pages handling
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The current same-filled pages handling supports pages filled with any
repeated word-sized pattern. However, in practice, most of these should
be zero pages anyway. Other patterns should be nearly as common.

Drop the support for non-zero same-filled pages, but keep the names of
knobs exposed to userspace as "same_filled", which isn't entirely
inaccurate.

This yields some nice code simplification and enables a following patch
that eliminates the need to allocate struct zswap_entry for those pages
completely.

There is also a very small performance improvement observed over 50 runs
of kernel build test (kernbench) comparing the mean build time on a
skylake machine when building the kernel in a cgroup v1 container with a
3G limit:

		base		patched		% diff
real		70.167		69.915		-0.359%
user		2953.068	2956.147	+0.104%
sys		2612.811	2594.718	-0.692%

This probably comes from more optimized operations like memchr_inv() and
clear_highpage(). Note that the percentage of zero-filled pages during
this test was only around 1.5% on average, and was not affected by this
patch. Practical workloads could have a larger proportion of such pages
(e.g. Johannes observed around 10% [1]), so the performance improvement
should be larger.

[1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 76 ++++++++++++++----------------------------------------
 1 file changed, 20 insertions(+), 56 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0fc27ae950c74..413d9242cf500 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -44,8 +44,8 @@
 **********************************/
 /* The number of compressed pages currently stored in zswap */
 atomic_t zswap_stored_pages = ATOMIC_INIT(0);
-/* The number of same-value filled pages currently stored in zswap */
-static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
+/* The number of zero-filled pages currently stored in zswap */
+static atomic_t zswap_zero_filled_pages = ATOMIC_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
@@ -123,9 +123,9 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/* Enable/disable handling non-same-value filled pages (enabled by default) */
-static bool zswap_non_same_filled_pages_enabled = true;
-module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
+/* Enable/disable handling non-zero-filled pages (enabled by default) */
+static bool zswap_non_zero_filled_pages_enabled = true;
+module_param_named(non_same_filled_pages_enabled, zswap_non_zero_filled_pages_enabled,
 		   bool, 0644);
 
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
@@ -187,11 +187,10 @@ static struct shrinker *zswap_shrinker;
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0, and both
+ *          decompression. For a zero-filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
@@ -199,10 +198,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	struct zswap_pool *pool;
-	union {
-		unsigned long handle;
-		unsigned long value;
-	};
+	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
 };
@@ -805,7 +801,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
+		atomic_dec(&zswap_zero_filled_pages);
 	else {
 		zswap_lru_del(&zswap_list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
@@ -1377,43 +1373,17 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
-static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
+static bool zswap_is_folio_zero_filled(struct folio *folio)
 {
-	unsigned long *page;
-	unsigned long val;
-	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	unsigned long *kaddr;
 	bool ret;
 
-	page = kmap_local_folio(folio, 0);
-	val = page[0];
-
-	if (val != page[last_pos]) {
-		ret = false;
-		goto out;
-	}
-
-	for (pos = 1; pos < last_pos; pos++) {
-		if (val != page[pos]) {
-			ret = false;
-			goto out;
-		}
-	}
-
-	*value = val;
-	ret = true;
-out:
-	kunmap_local(page);
+	kaddr = kmap_local_folio(folio, 0);
+	ret = !memchr_inv(kaddr, 0, PAGE_SIZE);
+	kunmap_local(kaddr);
 	return ret;
 }
 
-static void zswap_fill_page(void *ptr, unsigned long value)
-{
-	unsigned long *page;
-
-	page = (unsigned long *)ptr;
-	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
-}
-
 static bool zswap_check_limit(void)
 {
 	unsigned long cur_pages = zswap_total_pages();
@@ -1437,7 +1407,6 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_entry *entry;
-	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1470,14 +1439,13 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (zswap_is_folio_zero_filled(folio)) {
 		entry->length = 0;
-		entry->value = value;
-		atomic_inc(&zswap_same_filled_pages);
+		atomic_inc(&zswap_zero_filled_pages);
 		goto insert_entry;
 	}
 
-	if (!zswap_non_same_filled_pages_enabled)
+	if (!zswap_non_zero_filled_pages_enabled)
 		goto freepage;
 
 	/* if entry is successfully added, it keeps the reference */
@@ -1532,7 +1500,7 @@ bool zswap_store(struct folio *folio)
 
 store_failed:
 	if (!entry->length)
-		atomic_dec(&zswap_same_filled_pages);
+		atomic_dec(&zswap_zero_filled_pages);
 	else {
 		zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
@@ -1563,7 +1531,6 @@ bool zswap_load(struct folio *folio)
 	struct page *page = &folio->page;
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
-	u8 *dst;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
@@ -1573,11 +1540,8 @@ bool zswap_load(struct folio *folio)
 
 	if (entry->length)
 		zswap_decompress(entry, page);
-	else {
-		dst = kmap_local_page(page);
-		zswap_fill_page(dst, entry->value);
-		kunmap_local(dst);
-	}
+	else
+		clear_highpage(page);
 
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)
@@ -1679,7 +1643,7 @@ static int zswap_debugfs_init(void)
 	debugfs_create_atomic_t("stored_pages", 0444,
 				zswap_debugfs_root, &zswap_stored_pages);
 	debugfs_create_atomic_t("same_filled_pages", 0444,
-				zswap_debugfs_root, &zswap_same_filled_pages);
+				zswap_debugfs_root, &zswap_zero_filled_pages);
 
 	return 0;
 }
-- 
2.44.0.396.g6e790dbe36-goog


