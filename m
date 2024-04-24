Return-Path: <linux-kernel+bounces-157694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550618B14AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0C283834
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52442157494;
	Wed, 24 Apr 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGQhxOLb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF404156999;
	Wed, 24 Apr 2024 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990986; cv=none; b=mW8kpEaTCenyfJW4+0ZETwGquVcqulCVS5M1MXsStnl6iBvQFHoegxC1WCbx7/pytT7stH5yIs2l55N6Zl5hwkuOk3otUaJhXqH4wmZl/cQX0I2X8SyDIm+wVdOFGUb2678d91yFRvGbJHw79myBXWH8bPbNIP+hV/ZYspyzQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990986; c=relaxed/simple;
	bh=+iBdN9qwYsupLiRtcC8aLfPs0tyeYkHT2kfHxgn2bRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg6MT+yc2zjXzAGuNv+dUEcNqIaJbobZXl2dI8ibKXvImgQZGQqCEiE/GT2KkixVtiTgJcJ5DE1Ds/XbimfCkiV/SQf5cqrf44wGxE7n2t1elD+lvoCd+8Jj30VOLAdj1JrhIoIGndSB2cbfFgGMMrawISEhr8JuKpCfqcFCknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGQhxOLb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713990985; x=1745526985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iBdN9qwYsupLiRtcC8aLfPs0tyeYkHT2kfHxgn2bRg=;
  b=oGQhxOLbiTBuT9OUSbjMjfySmdwqdkdyqwJ8CR4pUGmYYjp7od7oWrEe
   UWSG497KfUqDUJK7LKl5Frrp93xOrOFHLvhGqobP/IFv0qVfL4pNZWvey
   Iyif6DMg626f9128hACYAZwuhIu8hUPlf4F7G6jpnlk38rAMIx60u+y+s
   KiSBY1ljYdTgInM5VIpZETrpmQ8Qkd4IY6Yms6BBSWHU22iHKXzxf0euf
   ErkOkaxIQABBwWSMsCyuQPaKkF7Fdw8zHTKuT2jpZ0hWzAWdp0oLkC1eK
   QWMFSGZOzfrdx5sB5SSOr3xkoANF2zILzNYff1Rkb+9/lRIiEMJZ0YJC1
   A==;
X-CSE-ConnectionGUID: lG/2E6fRTe6wyH+gn8r5hw==
X-CSE-MsgGUID: Oexk7rFuRnCMBF96kOYcwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9511950"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9511950"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:36:20 -0700
X-CSE-ConnectionGUID: mWMM8WDnQp+Y6dBCNkE1Xg==
X-CSE-MsgGUID: PNbhioqHSf22kA2GPD2tPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29314989"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 13:36:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	hawk@kernel.org,
	linux-mm@kvack.org,
	przemyslaw.kitszel@intel.com,
	alexanderduyck@fb.com,
	ilias.apalodimas@linaro.org,
	linux-kernel@vger.kernel.org,
	linyunsheng@huawei.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz
Subject: [PATCH net-next v11 05/10] page_pool: constify some read-only function arguments
Date: Wed, 24 Apr 2024 13:35:52 -0700
Message-ID: <20240424203559.3420468-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
References: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

There are several functions taking pointers to data they don't modify.
This includes statistics fetching, page and page_pool parameters, etc.
Constify the pointers, so that call sites will be able to pass const
pointers as well.
No functional changes, no visible changes in functions sizes.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/page_pool/helpers.h | 10 +++++-----
 include/net/page_pool/types.h   |  4 ++--
 net/core/page_pool.c            | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 1d397c1a0043..c7bb06750e85 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -58,7 +58,7 @@
 /* Deprecated driver-facing API, use netlink instead */
 int page_pool_ethtool_stats_get_count(void);
 u8 *page_pool_ethtool_stats_get_strings(u8 *data);
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);
 
 bool page_pool_get_stats(const struct page_pool *pool,
 			 struct page_pool_stats *stats);
@@ -73,7 +73,7 @@ static inline u8 *page_pool_ethtool_stats_get_strings(u8 *data)
 	return data;
 }
 
-static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
 	return data;
 }
@@ -204,8 +204,8 @@ static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
  * Get the stored dma direction. A driver might decide to store this locally
  * and avoid the extra cache line from page_pool to determine the direction.
  */
-static
-inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
+static inline enum dma_data_direction
+page_pool_get_dma_dir(const struct page_pool *pool)
 {
 	return pool->p.dma_dir;
 }
@@ -370,7 +370,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  * Fetch the DMA address of the page. The page pool to which the page belongs
  * must had been created with PP_FLAG_DMA_MAP.
  */
-static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 {
 	dma_addr_t ret = page->dma_addr;
 
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5e43a08d3231..a6ebed002216 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -213,7 +213,7 @@ struct xdp_mem_info;
 #ifdef CONFIG_PAGE_POOL
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem);
+			   const struct xdp_mem_info *mem);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
 #else
@@ -223,7 +223,7 @@ static inline void page_pool_destroy(struct page_pool *pool)
 
 static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 					 void (*disconnect)(void *),
-					 struct xdp_mem_info *mem)
+					 const struct xdp_mem_info *mem)
 {
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4c175091fc0a..273c24429bce 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -123,9 +123,9 @@ int page_pool_ethtool_stats_get_count(void)
 }
 EXPORT_SYMBOL(page_pool_ethtool_stats_get_count);
 
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
+u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
 {
-	struct page_pool_stats *pool_stats = stats;
+	const struct page_pool_stats *pool_stats = stats;
 
 	*data++ = pool_stats->alloc_stats.fast;
 	*data++ = pool_stats->alloc_stats.slow;
@@ -383,8 +383,8 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
+static void page_pool_dma_sync_for_device(const struct page_pool *pool,
+					  const struct page *page,
 					  unsigned int dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
@@ -987,7 +987,7 @@ static void page_pool_release_retry(struct work_struct *wq)
 }
 
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem)
+			   const struct xdp_mem_info *mem)
 {
 	refcount_inc(&pool->user_cnt);
 	pool->disconnect = disconnect;
-- 
2.41.0


