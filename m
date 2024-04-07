Return-Path: <linux-kernel+bounces-134413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CEE89B133
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C21F219CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10664F898;
	Sun,  7 Apr 2024 13:11:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2162487BF;
	Sun,  7 Apr 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495496; cv=none; b=Y7jM1zv5vVOriL5pra2kB1JRCdV/T3tNT45rQJLLcayvFQCtNXzvqgOxq+HFvZCSj4+EnJIFiQoSgwtx7cP2yOFavSDAOkdEnFJ2NNCUaJTFeeIA+p0KutXfyqr0EP4/mdtSUy/0apQ2G0/kDUkieczdywWsDhPom512oKkm3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495496; c=relaxed/simple;
	bh=SEey+bss8z2u+WwX2dsVTGkvGPe6bvz4cljBhfIUzAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5gfHIh0fTzjAqOMq2UYsicwtdXukLNRExguLzEw+n9gVJj2wImKSUnVfb/Dj9nHMZ3622EotGCecSdv/03pk0i8rh6lNJUSq6iAfwpMhlLe7+ye/lmdsruLtXRlze0pYwAEp83nexGBcNPQR1PhPat2V02VE/uv/grBerYHfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VCCGF5qDXzwQcX;
	Sun,  7 Apr 2024 21:08:37 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 27C061404F7;
	Sun,  7 Apr 2024 21:11:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 21:11:29 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v1 12/12] mm: page_frag: update documentation and maintainer for page_frag
Date: Sun, 7 Apr 2024 21:08:49 +0800
Message-ID: <20240407130850.19625-13-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240407130850.19625-1-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Update documentation about design, implementation and API usages
for page_frag.

Also update MAINTAINERS for page_frag. Alexander seems to be the
orginal author for page_frag, we can add him to the MAINTAINERS
later if we have an ack from him.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 115 ++++++++++++++++++----------
 MAINTAINERS                     |  10 +++
 include/linux/page_frag_cache.h | 128 ++++++++++++++++++++++++++++++++
 mm/page_frag_cache.c            |  51 ++++++++++---
 4 files changed, 256 insertions(+), 48 deletions(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..77256dfb58bf 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,43 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============
 Page fragments
 ==============
 
-A page fragment is an arbitrary-length arbitrary-offset area of memory
-which resides within a 0 or higher order compound page.  Multiple
-fragments within that page are individually refcounted, in the page's
-reference counter.
-
-The page_frag functions, page_frag_alloc and page_frag_free, provide a
-simple allocation framework for page fragments.  This is used by the
-network stack and network device drivers to provide a backing region of
-memory for use as either an sk_buff->head, or to be used in the "frags"
-portion of skb_shared_info.
-
-In order to make use of the page fragment APIs a backing page fragment
-cache is needed.  This provides a central point for the fragment allocation
-and tracks allows multiple calls to make use of a cached page.  The
-advantage to doing this is that multiple calls to get_page can be avoided
-which can be expensive at allocation time.  However due to the nature of
-this caching it is required that any calls to the cache be protected by
-either a per-cpu limitation, or a per-cpu limitation and forcing interrupts
-to be disabled when executing the fragment allocation.
-
-The network stack uses two separate caches per CPU to handle fragment
-allocation.  The netdev_alloc_cache is used by callers making use of the
-netdev_alloc_frag and __netdev_alloc_skb calls.  The napi_alloc_cache is
-used by callers of the __napi_alloc_frag and napi_alloc_skb calls.  The
-main difference between these two calls is the context in which they may be
-called.  The "netdev" prefixed functions are usable in any context as these
-functions will disable interrupts, while the "napi" prefixed functions are
-only usable within the softirq context.
-
-Many network device drivers use a similar methodology for allocating page
-fragments, but the page fragments are cached at the ring or descriptor
-level.  In order to enable these cases it is necessary to provide a generic
-way of tearing down a page cache.  For this reason __page_frag_cache_drain
-was implemented.  It allows for freeing multiple references from a single
-page via a single call.  The advantage to doing this is that it allows for
-cleaning up the multiple references that were added to a page in order to
-avoid calling get_page per allocation.
-
-Alexander Duyck, Nov 29, 2016.
+.. kernel-doc:: mm/page_frag_cache.c
+   :doc: page_frag allocator
+
+Architecture overview
+=====================
+
+.. code-block:: none
+
+    +----------------------+
+    | page_frag API caller |
+    +----------------------+
+            ^
+            |
+            |
+            |
+            v
+    +----------------------------------------------+
+    |          request page fragment               |
+    +----------------------------------------------+
+        ^                                        ^
+        |                                        |
+        | Cache empty or not enough              |
+        |                                        |
+        v                                        |
+    +--------------------------------+           |
+    | refill cache with order 3 page |           |
+    +--------------------------------+           |
+     ^                  ^                        |
+     |                  |                        |
+     |                  | Refill failed          |
+     |                  |                        | Cache is enough
+     |                  |                        |
+     |                  v                        |
+     |    +----------------------------------+   |
+     |    |  refill cache with order 0 page  |   |
+     |    +----------------------------------+   |
+     |                       ^                   |
+     | Refill succeed        |                   |
+     |                       | Refill succeed    |
+     |                       |                   |
+     v                       v                   v
+    +----------------------------------------------+
+    |       allocate fragment from cache           |
+    +----------------------------------------------+
+
+API interface
+=============
+As the design and implementation of page_frag API, the allocation side does not
+allow concurrent calling, it is assumed that the caller must ensure there is not
+concurrent alloc calling to the same page_frag_cache instance by using it's own
+lock or rely on some lockless guarantee like NAPI softirq.
+
+Depending on different use cases, callers expecting to deal with va, page or
+both va and page for them may call page_frag_alloc_va(), page_frag_alloc_pg(),
+or page_frag_alloc() accordingly.
+
+There is also a use case that need minimum memory in order for forward
+progressing, but can do better if there is more memory available. Introduce
+page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
+requests the minimum memory it need and the prepare API will return the maximum
+size of the fragment returned, caller need to report back to the page_frag core
+how much memory it actually use by calling commit API, or not calling the commit
+API if deciding to not use any memory.
+
+.. kernel-doc:: include/linux/page_frag_cache.h
+   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
+                 page_frag_alloc_va __page_frag_alloc_va_align
+                 page_frag_alloc_va_align page_frag_alloc_va_prepare
+                 page_frag_alloc_va_prepare_align page_frag_alloc_pg_prepare
+                 page_frag_alloc_prepare page_frag_alloc_commit
+                 page_frag_alloc_commit_noref page_frag_free_va
+
+.. kernel-doc:: mm/page_frag_cache.c
+   :identifiers: page_frag_cache_drain
diff --git a/MAINTAINERS b/MAINTAINERS
index 4745ea94d463..2f84aba59428 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16683,6 +16683,16 @@ F:	mm/page-writeback.c
 F:	mm/readahead.c
 F:	mm/truncate.c
 
+PAGE FRAG
+M:	Yunsheng Lin <linyunsheng@huawei.com>
+L:	linux-mm@kvack.org
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/mm/page_frags.rst
+F:	include/linux/page_frag_cache.h
+F:	mm/page_frag_cache.c
+F:	mm/page_frag_test.c
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 28185969cd2c..d8edbecdd179 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -31,11 +31,23 @@ struct page_frag_cache {
 #endif
 };
 
+/**
+ * page_frag_cache_init() - Init page_frag cache.
+ * @nc: page_frag cache from which to init
+ *
+ * Inline helper to init the page_frag cache.
+ */
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	nc->va = NULL;
 }
 
+/**
+ * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
+ * @nc: page_frag cache from which to check
+ *
+ * Used to check if the current page in page_frag cache is pfmemalloc'ed.
+ */
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
 	return !!nc->pfmemalloc;
@@ -46,6 +58,17 @@ void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
 			     gfp_t gfp_mask);
 
+/**
+ * page_frag_alloc_va() - Alloc a page fragment.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Get a page fragment from page_frag cache.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 				       unsigned int fragsz, gfp_t gfp_mask)
 {
@@ -63,6 +86,19 @@ static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 	return va + offset;
 }
 
+/**
+ * __page_frag_alloc_va_align() - Alloc a page fragment with aligning
+ * requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement
+ *
+ * Get a page fragment from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 					       unsigned int fragsz,
 					       gfp_t gfp_mask,
@@ -75,6 +111,19 @@ static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return page_frag_alloc_va(nc, fragsz, gfp_mask);
 }
 
+/**
+ * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement
+ *
+ * WARN_ON_ONCE() checking for align and fragsz before getting a page fragment
+ * from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 					     unsigned int fragsz,
 					     gfp_t gfp_mask,
@@ -86,6 +135,19 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
 }
 
+/**
+ * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 					       unsigned int *offset,
 					       unsigned int *size,
@@ -108,6 +170,21 @@ static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 	return va + *offset;
 }
 
+/**
+ * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment with
+ * aligning requirement.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @align: the requested aligning requirement
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare an aligned page fragment with minimum size of ‘size’, 'size' is also
+ * used to report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
 						     unsigned int *offset,
 						     unsigned int *size,
@@ -144,6 +221,19 @@ static inline void *__page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
 	return va;
 }
 
+/**
+ * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @gfp: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return the page fragment, otherwise return NULL.
+ */
 #define page_frag_alloc_pg_prepare(nc, offset, size, gfp)		\
 ({									\
 	struct page *__page = NULL;					\
@@ -179,6 +269,21 @@ static inline void *__page_frag_alloc_prepare(struct page_frag_cache *nc,
 	return nc_va;
 }
 
+/**
+ * page_frag_alloc_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @va: out as the va of the returned page fragment
+ * @gfp: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment. Return both 'page' and 'va' of
+ * the fragment to the caller.
+ *
+ * Return:
+ * Return the page fragment, otherwise return NULL.
+ */
 #define page_frag_alloc_prepare(nc, offset, size, va, gfp)		\
 ({									\
 	struct page *__page = NULL;					\
@@ -191,6 +296,14 @@ static inline void *__page_frag_alloc_prepare(struct page_frag_cache *nc,
 	__page;								\
 })
 
+/**
+ * page_frag_alloc_commit - Commit allocing a page fragment.
+ * @nc: page_frag cache from which to commit
+ * @offset: offset of the page fragment
+ * @size: size of the page fragment has been used
+ *
+ * Commit the alloc preparing by passing offset and the actual used size.
+ */
 static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 					  unsigned int offset,
 					  unsigned int size)
@@ -199,6 +312,17 @@ static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 	nc->offset = offset + size;
 }
 
+/**
+ * page_frag_alloc_commit_noref - Commit allocing a page fragment without taking
+ * page refcount.
+ * @nc: page_frag cache from which to commit
+ * @offset: offset of the page fragment
+ * @size: size of the page fragment has been used
+ *
+ * Commit the alloc preparing by passing offset and the actual used size, but
+ * not taking page refcount. Mostly used for fragmemt coaleasing case when the
+ * current fragmemt can share the same refcount with previous fragmemt.
+ */
 static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 						unsigned int offset,
 						unsigned int size)
@@ -206,6 +330,10 @@ static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 	nc->offset = offset + size;
 }
 
+/**
+ * page_frag_free_va - Free a page fragment by va.
+ * @addr: va of page fragment to be freed
+ */
 void page_frag_free_va(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index cbd0ed82a596..0c76ec006c22 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -1,15 +1,44 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Page fragment allocator
+
+/**
+ * DOC: page_frag allocator
+ *
+ * A page fragment is an arbitrary-length arbitrary-offset area of memory which
+ * resides within a 0 or higher order compound page.  Multiple fragments within
+ * that page are individually refcounted, in the page's reference counter.
+ *
+ * The page_frag functions, page_frag_alloc* and page_frag_free*, provide a
+ * simple allocation framework for page fragments.  This is used by the network
+ * stack and network device drivers to provide a backing region of memory for
+ * use as either an sk_buff->head, or to be used in the "frags" portion of
+ * skb_shared_info.
  *
- * Page Fragment:
- *  An arbitrary-length arbitrary-offset area of memory which resides within a
- *  0 or higher order page.  Multiple fragments within that page are
- *  individually refcounted, in the page's reference counter.
+ * In order to make use of the page fragment APIs a backing page fragment cache
+ * is needed.  This provides a central point for the fragment allocation and
+ * tracks allows multiple calls to make use of a cached page.  The advantage to
+ * doing this is that multiple calls to get_page can be avoided which can be
+ * expensive at allocation time.  However due to the nature of this caching it
+ * is required that any calls to the cache be protected by either a per-cpu
+ * limitation, or a per-cpu limitation and forcing interrupts to be disabled
+ * when executing the fragment allocation.
  *
- * The page_frag functions provide a simple allocation framework for page
- * fragments.  This is used by the network stack and network device drivers to
- * provide a backing region of memory for use as either an sk_buff->head, or to
- * be used in the "frags" portion of skb_shared_info.
+ * The network stack uses two separate caches per CPU to handle fragment
+ * allocation.  The netdev_alloc_cache is used by callers making use of the
+ * netdev_alloc_frag and __netdev_alloc_skb calls.  The napi_alloc_cache is
+ * used by callers of the __napi_alloc_frag and napi_alloc_skb calls.  The
+ * main difference between these two calls is the context in which they may be
+ * called.  The "netdev" prefixed functions are usable in any context as these
+ * functions will disable interrupts, while the "napi" prefixed functions are
+ * only usable within the softirq context.
+ *
+ * Many network device drivers use a similar methodology for allocating page
+ * fragments, but the page fragments are cached at the ring or descriptor
+ * level.  In order to enable these cases it is necessary to provide a generic
+ * way of tearing down a page cache.  For this reason __page_frag_cache_drain
+ * was implemented.  It allows for freeing multiple references from a single
+ * page via a single call.  The advantage to doing this is that it allows for
+ * cleaning up the multiple references that were added to a page in order to
+ * avoid calling get_page per allocation.
  */
 
 #include <linux/export.h>
@@ -57,6 +86,10 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,
 	return true;
 }
 
+/**
+ * page_frag_cache_drain - Drain the current page from page_frag cache.
+ * @nc: page_frag cache from which to drain
+ */
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->va)
-- 
2.33.0


