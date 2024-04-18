Return-Path: <linux-kernel+bounces-149984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C28A98C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744FC1C20A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2A16133E;
	Thu, 18 Apr 2024 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLihn+7d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70D161321;
	Thu, 18 Apr 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440227; cv=none; b=YrwnQXcgH7iGUXrMvYKTYPLlYjoDy/2Ppqzw/FyE2FANUqVfc3nXmTED/kWtcFI+Uqn8mQkc4Xy8bKB/zH+H+XWtqIBBAoAi+4lkqyz68BTDbNXzy/ZcEIorGCn+S8GqDcLeo4CLssidbtj+437K7k/j+I/HlwEVSHUnBnSfquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440227; c=relaxed/simple;
	bh=2CVyn5njvQE0SmNlFiwWLUfAppDNCRHyl28DZcBT/XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4qKAr5+fuuWl3a8KiLhVYjttep/M6nj5M39MKy7tDG4kr0YfxRnZv+ejHxxPxRAfm+cCHEfpPyc5goD09zU/eqw9eqpz9DSCRXFppHPUmDwyK9rho/vTLPz2EhUal9hOg3A7M0G4qI2NhZmvlLIF80OWWhUKjH9+pHeVrZuJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLihn+7d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440225; x=1744976225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2CVyn5njvQE0SmNlFiwWLUfAppDNCRHyl28DZcBT/XM=;
  b=fLihn+7d+nqek+q648R+TvFstDVawhGMdmtdF/whdplNzANuuw1xYUL/
   IGt04/qGemrBnct+nl2M2hopIqMt1cfGK/vfhKPtxr2TT2sLtxVcTcMOz
   hqxC/2SoIpQ30e/OVF1JxssNjCo+O/8RPZ/pRthRPUXomrY1S9XrQDuQ+
   eKame1y/FlasWQXA7FsZZod/DsejXwrEtQA8EEDG/oZw9kYfa/gbo0m3v
   4YFSdxpiTJsglFCqwTRpPOSO2WM22NZt3KBg3RPGaB0rFp4ZCC25mAxR0
   NbR2hyyfWe7qY7pGnh0I3mtpMv9SjnhUPaAIaykn4asqOzvoSK9X/3FC/
   A==;
X-CSE-ConnectionGUID: yCKzsUCTRWGQmfswf2jsIw==
X-CSE-MsgGUID: B7utFVOgQxi0Z5h/rGNcLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19587802"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19587802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:37:05 -0700
X-CSE-ConnectionGUID: 3+s884BpQHi4ovI0Aj2zqQ==
X-CSE-MsgGUID: 1lymngatQ2WWD+7QviMoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27586137"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 18 Apr 2024 04:37:01 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 07/10] libeth: add Rx buffer management
Date: Thu, 18 Apr 2024 13:36:13 +0200
Message-ID: <20240418113616.1108566-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
References: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple intuitive helpers to hide Rx buffer implementation details
in the library and not multiplicate it between drivers. The settings are
sorta optimized for 100G+ NICs, but nothing really HW-specific here.
Use the new page_pool_dev_alloc() to dynamically switch between
split-page and full-page modes depending on MTU, page size, required
headroom etc. For example, on x86_64 with the default driver settings
each page is shared between 2 buffers. Turning on XDP (not in this
series) -> increasing headroom requirement pushes truesize out of 2048
boundary, leading to that each buffer starts getting a full page.
The "ceiling" limit is %PAGE_SIZE, as only order-0 pages are used to
avoid compound overhead. For the above architecture, this means maximum
linear frame size of 3712 w/o XDP.
Not that &libeth_buf_queue is not a complete queue/ring structure for
now, rather a shim, but eventually the libeth-enabled drivers will move
to it, with iavf being the first one.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
kernel-doc for libeth_fq::fp generates an "Excess struct member" warning
currently, here's patch which fixes the script: [0]

[0] https://lore.kernel.org/linux-doc/20240411093208.2483580-1-aleksander.lobakin@intel.com
---
 drivers/net/ethernet/intel/libeth/Kconfig |   1 +
 include/net/libeth/rx.h                   | 117 ++++++++++++++++++++++
 drivers/net/ethernet/intel/libeth/rx.c    |  98 ++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/net/ethernet/intel/libeth/Kconfig b/drivers/net/ethernet/intel/libeth/Kconfig
index af970a63c227..480293b71dbc 100644
--- a/drivers/net/ethernet/intel/libeth/Kconfig
+++ b/drivers/net/ethernet/intel/libeth/Kconfig
@@ -3,6 +3,7 @@
 
 config LIBETH
 	tristate
+	select PAGE_POOL
 	help
 	  libeth is a common library containing routines shared between several
 	  drivers, but not yet promoted to the generic kernel API.
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0807e19f44b3..f29ea3e34c6c 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -4,8 +4,125 @@
 #ifndef __LIBETH_RX_H
 #define __LIBETH_RX_H
 
+#include <linux/if_vlan.h>
+
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 
+/* Rx buffer management */
+
+/* Space reserved in front of each frame */
+#define LIBETH_SKB_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+/* Maximum headroom for worst-case calculations */
+#define LIBETH_MAX_HEADROOM	LIBETH_SKB_HEADROOM
+/* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
+#define LIBETH_RX_LL_LEN	(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+
+/* Always use order-0 pages */
+#define LIBETH_RX_PAGE_ORDER	0
+/* Pick a sane buffer stride and align to a cacheline boundary */
+#define LIBETH_RX_BUF_STRIDE	SKB_DATA_ALIGN(128)
+/* HW-writeable space in one buffer: truesize - headroom/tailroom, aligned */
+#define LIBETH_RX_PAGE_LEN(hr)						  \
+	ALIGN_DOWN(SKB_MAX_ORDER(hr, LIBETH_RX_PAGE_ORDER),		  \
+		   LIBETH_RX_BUF_STRIDE)
+
+/**
+ * struct libeth_fqe - structure representing an Rx buffer (fill queue element)
+ * @page: page holding the buffer
+ * @offset: offset from the page start (to the headroom)
+ * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
+ *
+ * Depending on the MTU, API switches between one-page-per-frame and shared
+ * page model (to conserve memory on bigger-page platforms). In case of the
+ * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
+ */
+struct libeth_fqe {
+	struct page		*page;
+	u32			offset;
+	u32			truesize;
+} __aligned_largest;
+
+/**
+ * struct libeth_fq - structure representing a buffer (fill) queue
+ * @fp: hotpath part of the structure
+ * @pp: &page_pool for buffer management
+ * @fqes: array of Rx buffers
+ * @truesize: size to allocate per buffer, w/overhead
+ * @count: number of descriptors/buffers the queue has
+ * @buf_len: HW-writeable length per each buffer
+ * @nid: ID of the closest NUMA node with memory
+ */
+struct libeth_fq {
+	struct_group_tagged(libeth_fq_fp, fp,
+		struct page_pool	*pp;
+		struct libeth_fqe	*fqes;
+
+		u32			truesize;
+		u32			count;
+	);
+
+	/* Cold fields */
+	u32			buf_len;
+	int			nid;
+};
+
+int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
+void libeth_rx_fq_destroy(struct libeth_fq *fq);
+
+/**
+ * libeth_rx_alloc - allocate a new Rx buffer
+ * @fq: fill queue to allocate for
+ * @i: index of the buffer within the queue
+ *
+ * Return: DMA address to be passed to HW for Rx on successful allocation,
+ * ```DMA_MAPPING_ERROR``` otherwise.
+ */
+static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
+{
+	struct libeth_fqe *buf = &fq->fqes[i];
+
+	buf->truesize = fq->truesize;
+	buf->page = page_pool_dev_alloc(fq->pp, &buf->offset, &buf->truesize);
+	if (unlikely(!buf->page))
+		return DMA_MAPPING_ERROR;
+
+	return page_pool_get_dma_addr(buf->page) + buf->offset +
+	       fq->pp->p.offset;
+}
+
+void libeth_rx_recycle_slow(struct page *page);
+
+/**
+ * libeth_rx_sync_for_cpu - synchronize or recycle buffer post DMA
+ * @fqe: buffer to process
+ * @len: frame length from the descriptor
+ *
+ * Process the buffer after it's written by HW. The regular path is to
+ * synchronize DMA for CPU, but in case of no data it will be immediately
+ * recycled back to its PP.
+ *
+ * Return: true when there's data to process, false otherwise.
+ */
+static inline bool libeth_rx_sync_for_cpu(const struct libeth_fqe *fqe,
+					  u32 len)
+{
+	struct page *page = fqe->page;
+
+	/* Very rare, but possible case. The most common reason:
+	 * the last fragment contained FCS only, which was then
+	 * stripped by the HW.
+	 */
+	if (unlikely(!len)) {
+		libeth_rx_recycle_slow(page);
+		return false;
+	}
+
+	page_pool_dma_sync_for_cpu(page->pp, page, fqe->offset, len);
+
+	return true;
+}
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 879c4dfd6a4e..6221b88c34ac 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -3,6 +3,104 @@
 
 #include <net/libeth/rx.h>
 
+/* Rx buffer management */
+
+/**
+ * libeth_rx_hw_len - get the actual buffer size to be passed to HW
+ * @pp: &page_pool_params of the netdev to calculate the size for
+ * @max_len: maximum buffer size for a single descriptor
+ *
+ * Return: HW-writeable length per one buffer to pass it to the HW accounting:
+ * MTU the @dev has, HW required alignment, minimum and maximum allowed values,
+ * and system's page size.
+ */
+static u32 libeth_rx_hw_len(const struct page_pool_params *pp, u32 max_len)
+{
+	u32 len;
+
+	len = READ_ONCE(pp->netdev->mtu) + LIBETH_RX_LL_LEN;
+	len = ALIGN(len, LIBETH_RX_BUF_STRIDE);
+	len = min3(len, ALIGN_DOWN(max_len ? : U32_MAX, LIBETH_RX_BUF_STRIDE),
+		   pp->max_len);
+
+	return len;
+}
+
+/**
+ * libeth_rx_fq_create - create a PP with the default libeth settings
+ * @fq: buffer queue struct to fill
+ * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
+{
+	struct page_pool_params pp = {
+		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order		= LIBETH_RX_PAGE_ORDER,
+		.pool_size	= fq->count,
+		.nid		= fq->nid,
+		.dev		= napi->dev->dev.parent,
+		.netdev		= napi->dev,
+		.napi		= napi,
+		.dma_dir	= DMA_FROM_DEVICE,
+		.offset		= LIBETH_SKB_HEADROOM,
+	};
+	struct libeth_fqe *fqes;
+	struct page_pool *pool;
+
+	/* HW-writeable / syncable length per one page */
+	pp.max_len = LIBETH_RX_PAGE_LEN(pp.offset);
+
+	/* HW-writeable length per buffer */
+	fq->buf_len = libeth_rx_hw_len(&pp, fq->buf_len);
+	/* Buffer size to allocate */
+	fq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
+							 fq->buf_len));
+
+	pool = page_pool_create(&pp);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	fqes = kvcalloc_node(fq->count, sizeof(*fqes), GFP_KERNEL, fq->nid);
+	if (!fqes)
+		goto err_buf;
+
+	fq->fqes = fqes;
+	fq->pp = pool;
+
+	return 0;
+
+err_buf:
+	page_pool_destroy(pool);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_create, LIBETH);
+
+/**
+ * libeth_rx_fq_destroy - destroy a &page_pool created by libeth
+ * @fq: buffer queue to process
+ */
+void libeth_rx_fq_destroy(struct libeth_fq *fq)
+{
+	kvfree(fq->fqes);
+	page_pool_destroy(fq->pp);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_fq_destroy, LIBETH);
+
+/**
+ * libeth_rx_recycle_slow - recycle a libeth page from the NAPI context
+ * @page: page to recycle
+ *
+ * To be used on exceptions or rare cases not requiring fast inline recycling.
+ */
+void libeth_rx_recycle_slow(struct page *page)
+{
+	page_pool_recycle_direct(page->pp, page);
+}
+EXPORT_SYMBOL_NS_GPL(libeth_rx_recycle_slow, LIBETH);
+
 /* Converting abstract packet type numbers into a software structure with
  * the packet parameters to do O(1) lookup on Rx.
  */
-- 
2.44.0


