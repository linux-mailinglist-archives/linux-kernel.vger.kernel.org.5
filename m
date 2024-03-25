Return-Path: <linux-kernel+bounces-118190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A793F88B596
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1B31C3C4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB012839E;
	Mon, 25 Mar 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSvnx+/Y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE484D22
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410634; cv=none; b=J9VCBHcbsh8m14n5wH3Ffp/kyrn+cHf9dNVZyGKjt+ZqReWPDtY8sA4YlG7nJHiaIr7DwUea4JwEACA/SeQDJH3QGdvEL1XX1QhBWseoeXwqIJWuT4l0Xv5BphnRFvq1ZPMoYqwKItsgQTtWSrrMZ1p9OGCEBYzz24v135Nflxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410634; c=relaxed/simple;
	bh=fxQJhfVXwAFATlTYI8RkyDsQTt5NtB3avUf74PP922A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxZ3T7jzt9krMGlDI5aA6IVs1iYtHvX5s2lA/ixnNcwokLx3BMvv7SgwL8glWKvWHuQ49jp3XTeb6Ok7xOkQydCi29YId6Oggu6YiuY2sr5Relu6eIR5DskXBr0yF0rP3cCPcnPzeu9jW2mOh+HwSWBIF5BeVIfBlp6tHm36dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSvnx+/Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fb151752so88889077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410632; x=1712015432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UL7FjpWvNZHo/XDshUAVHcqtRsHSd5BUf04PTKRvwLE=;
        b=MSvnx+/YRfpIh73y9ZqhTd/g08l4Nan1jtS/Emh+L9Hl6EJlYmOxDbqVbHp89YooDf
         UkFDiRhiAHCp1Ag48TDtbk98KriXTEv/63M/C6ofPnnVEfQ+gyG5i0GnclMzPpxoi809
         ypNAy6yDn6fcIwbdT7hxURgzTY4ECJOx9m56TsL1BpYzjs8ByVnWD+wVGJX6h1bL+D8A
         aenPjESx+ndrhStLQ+WP39WcjLFHX43ohNoYvMp9n+QRlZODScefKOWuUsvE6DOu8ns3
         k4CFYjNrBnvgTu1b32cP7Zpz5+SE1aF9llYoTHBJi1Hp3A2yiX5HkGbRIeuX/pttVpAQ
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410632; x=1712015432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL7FjpWvNZHo/XDshUAVHcqtRsHSd5BUf04PTKRvwLE=;
        b=Ve4zs3zdvNMafU6vwAv5UeU5Z17ld9JJ5Muz+mB0C4ZnBmwJ4Npl1Wi/FqkCgl2oZb
         FwgEYL/jEJPOtVEvllYIjOqsdOuohh1XH9Z9h8lCm6fXesJ/F3QBtCXaqvmdgMOADAA1
         7PIztAaeETZBuSNEdCveVlIe+GwG0uNkUX58UKwoplpMU4qNJt2MYRczLwcP/Bu00ULn
         BgT6UKwuR+voHxfn3iz5ONoGNDg5lu6lkFuIqoZSNKWCGurUeWRhB6cOaaKC3XcYFL+G
         sSMo56Wv+XFECCxnGjEMC97Ol0f8iDm+W1u7Lnb52cHwKUpVoDO2vHXE9T9VHgpNq3bQ
         YbMA==
X-Forwarded-Encrypted: i=1; AJvYcCWTsvu6pFbHaSWzTO01f+cjhAmXrEJ7H2M5HCeAhEoa4rZIy6WMugxdlxwYFvBp89wO+/oNiaYOL5Rp2fs7RNU+n8FO6tXnqoPiV56D
X-Gm-Message-State: AOJu0Yxwc7nz1N/bunNFOC6IBOrvQkOaTEIPfj1xp3057AF3SISiXqL+
	WG5AggomCCo12XyAC3UGBPdABPZAwl0GaLfWH7vozxRcn5GC/eOU/5aiBR0pMQ/rHV1uVeu/WHi
	ByfXnA3Nqe3M+uofiTw==
X-Google-Smtp-Source: AGHT+IG+TLfwzbh3JCRDIgWmOJOjvnZ/+V3sJUz+/QQZSrlaneyk9M9ZmZQb1PVEN8h1tDdQ5SE3NK8iK22/6mCW
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1507:b0:dc6:e8a7:fdba with
 SMTP id q7-20020a056902150700b00dc6e8a7fdbamr2612541ybu.4.1711410631787; Mon,
 25 Mar 2024 16:50:31 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:15 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-8-yosryahmed@google.com>
Subject: [RFC PATCH 7/9] mm: zswap: store zero-filled pages without a zswap_entry
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

After the rbtree to xarray conversion, and dropping zswap_entry.refcount
and zswap_entry.value, the only members of zswap_entry utilized by
zero-filled pages are zswap_entry.length (always 0) and
zswap_entry.objcg. Store the objcg pointer directly in the xarray as a
tagged pointer and avoid allocating a zswap_entry completely for
zero-filled pages.

This simplifies the code as we no longer need to special case
zero-length cases. We are also able to further separate the zero-filled
pages handling logic and completely isolate them within store/load
helpers.  Handling tagged xarray pointers is handled in these two
helpers, as well as the newly introduced helper for freeing tree
elements, zswap_tree_free_element().

There is also a small performance improvement observed over 50 runs of
kernel build test (kernbench) comparing the mean build time on a skylake
machine when building the kernel in a cgroup v1 container with a 3G
limit. This is on top of the improvement from dropping support for
non-zero same-filled pages:

		base            patched         % diff
real            69.915          69.757		-0.229%
user            2956.147        2955.244	-0.031%
sys             2594.718        2575.747	-0.731%

This probably comes from avoiding the zswap_entry allocation and
cleanup/freeing for zero-filled pages. Note that the percentage of
zero-filled pages during this test was only around 1.5% on average.
Practical workloads could have a larger proportion of such pages (e.g.
Johannes observed around 10% [1]), so the performance improvement should
be larger.

This change also saves a small amount of memory due to less allocated
zswap_entry's. In the kernel build test above, we save around 2M of
slab usage when we swap out 3G to zswap.

[1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 137 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 59 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 413d9242cf500..efc323bab2f22 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -183,12 +183,11 @@ static struct shrinker *zswap_shrinker;
  * struct zswap_entry
  *
  * This structure contains the metadata for tracking a single compressed
- * page within zswap.
+ * page within zswap, it does not track zero-filled pages.
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
  * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a zero-filled page length is 0, and both
- *          pool and lru are invalid and must be ignored.
+ *          decompression.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
  * objcg - the obj_cgroup that the compressed memory is charged to
@@ -794,30 +793,35 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 	return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
 }
 
-/*
- * Carries out the common pattern of freeing and entry's zpool allocation,
- * freeing the entry itself, and decrementing the number of stored pages.
- */
 static void zswap_entry_free(struct zswap_entry *entry)
 {
-	if (!entry->length)
-		atomic_dec(&zswap_zero_filled_pages);
-	else {
-		zswap_lru_del(&zswap_list_lru, entry);
-		zpool_free(zswap_find_zpool(entry), entry->handle);
-		zswap_pool_put(entry->pool);
-	}
+	zswap_lru_del(&zswap_list_lru, entry);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
+	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
 	}
 	zswap_entry_cache_free(entry);
-	atomic_dec(&zswap_stored_pages);
 }
 
 /*********************************
 * zswap tree functions
 **********************************/
+static void zswap_tree_free_element(void *elem)
+{
+	if (!elem)
+		return;
+
+	if (xa_pointer_tag(elem)) {
+		obj_cgroup_put(xa_untag_pointer(elem));
+		atomic_dec(&zswap_zero_filled_pages);
+	} else {
+		zswap_entry_free((struct zswap_entry *)elem);
+	}
+	atomic_dec(&zswap_stored_pages);
+}
+
 static int zswap_tree_store(struct xarray *tree, pgoff_t offset, void *new)
 {
 	void *old;
@@ -834,7 +838,7 @@ static int zswap_tree_store(struct xarray *tree, pgoff_t offset, void *new)
 		 * the folio was redirtied and now the new version is being
 		 * swapped out. Get rid of the old.
 		 */
-		zswap_entry_free(old);
+		zswap_tree_free_element(old);
 	}
 	return err;
 }
@@ -1089,7 +1093,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPWB);
 
-	zswap_entry_free(entry);
+	zswap_tree_free_element(entry);
 
 	/* folio is up to date */
 	folio_mark_uptodate(folio);
@@ -1373,6 +1377,33 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
+/*********************************
+* zero-filled functions
+**********************************/
+#define ZSWAP_ZERO_FILLED_TAG 1UL
+
+static int zswap_store_zero_filled(struct xarray *tree, pgoff_t offset,
+				   struct obj_cgroup *objcg)
+{
+	int err = zswap_tree_store(tree, offset,
+			xa_tag_pointer(objcg, ZSWAP_ZERO_FILLED_TAG));
+
+	if (!err)
+		atomic_inc(&zswap_zero_filled_pages);
+	return err;
+}
+
+static bool zswap_load_zero_filled(void *elem, struct page *page,
+				   struct obj_cgroup **objcg)
+{
+	if (!xa_pointer_tag(elem))
+		return false;
+
+	clear_highpage(page);
+	*objcg = xa_untag_pointer(elem);
+	return true;
+}
+
 static bool zswap_is_folio_zero_filled(struct folio *folio)
 {
 	unsigned long *kaddr;
@@ -1432,22 +1463,21 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_check_limit())
 		goto reject;
 
-	/* allocate entry */
+	if (zswap_is_folio_zero_filled(folio)) {
+		if (zswap_store_zero_filled(tree, offset, objcg))
+			goto reject;
+		goto stored;
+	}
+
+	if (!zswap_non_zero_filled_pages_enabled)
+		goto reject;
+
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
 	if (!entry) {
 		zswap_reject_kmemcache_fail++;
 		goto reject;
 	}
 
-	if (zswap_is_folio_zero_filled(folio)) {
-		entry->length = 0;
-		atomic_inc(&zswap_zero_filled_pages);
-		goto insert_entry;
-	}
-
-	if (!zswap_non_zero_filled_pages_enabled)
-		goto freepage;
-
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
@@ -1465,17 +1495,14 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-insert_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
 	if (zswap_tree_store(tree, offset, entry))
 		goto store_failed;
 
-	if (objcg) {
+	if (objcg)
 		obj_cgroup_charge_zswap(objcg, entry->length);
-		count_objcg_event(objcg, ZSWPOUT);
-	}
 
 	/*
 	 * We finish initializing the entry while it's already in xarray.
@@ -1487,25 +1514,21 @@ bool zswap_store(struct folio *folio)
 	 *    The publishing order matters to prevent writeback from seeing
 	 *    an incoherent entry.
 	 */
-	if (entry->length) {
-		INIT_LIST_HEAD(&entry->lru);
-		zswap_lru_add(&zswap_list_lru, entry);
-	}
+	INIT_LIST_HEAD(&entry->lru);
+	zswap_lru_add(&zswap_list_lru, entry);
 
-	/* update stats */
+stored:
+	if (objcg)
+		count_objcg_event(objcg, ZSWPOUT);
 	atomic_inc(&zswap_stored_pages);
 	count_vm_event(ZSWPOUT);
 
 	return true;
 
 store_failed:
-	if (!entry->length)
-		atomic_dec(&zswap_zero_filled_pages);
-	else {
-		zpool_free(zswap_find_zpool(entry), entry->handle);
+	zpool_free(zswap_find_zpool(entry), entry->handle);
 put_pool:
-		zswap_pool_put(entry->pool);
-	}
+	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
 reject:
@@ -1518,9 +1541,7 @@ bool zswap_store(struct folio *folio)
 	 * possibly stale entry which was previously stored at this offset.
 	 * Otherwise, writeback could overwrite the new data in the swapfile.
 	 */
-	entry = xa_erase(tree, offset);
-	if (entry)
-		zswap_entry_free(entry);
+	zswap_tree_free_element(xa_erase(tree, offset));
 	return false;
 }
 
@@ -1531,26 +1552,27 @@ bool zswap_load(struct folio *folio)
 	struct page *page = &folio->page;
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
+	struct obj_cgroup *objcg;
+	void *elem;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
-	entry = xa_erase(tree, offset);
-	if (!entry)
+	elem = xa_erase(tree, offset);
+	if (!elem)
 		return false;
 
-	if (entry->length)
+	if (!zswap_load_zero_filled(elem, page, &objcg)) {
+		entry = elem;
+		objcg = entry->objcg;
 		zswap_decompress(entry, page);
-	else
-		clear_highpage(page);
+	}
 
 	count_vm_event(ZSWPIN);
-	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWPIN);
-
-	zswap_entry_free(entry);
+	if (objcg)
+		count_objcg_event(objcg, ZSWPIN);
 
+	zswap_tree_free_element(elem);
 	folio_mark_dirty(folio);
-
 	return true;
 }
 
@@ -1558,11 +1580,8 @@ void zswap_invalidate(swp_entry_t swp)
 {
 	pgoff_t offset = swp_offset(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry;
 
-	entry = xa_erase(tree, offset);
-	if (entry)
-		zswap_entry_free(entry);
+	zswap_tree_free_element(xa_erase(tree, offset));
 }
 
 int zswap_swapon(int type, unsigned long nr_pages)
-- 
2.44.0.396.g6e790dbe36-goog


