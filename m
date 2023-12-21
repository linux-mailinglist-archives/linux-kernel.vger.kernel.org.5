Return-Path: <linux-kernel+bounces-8505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7981B8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C9D28F3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1027C66C;
	Thu, 21 Dec 2023 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv+BHf8q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD17C653;
	Thu, 21 Dec 2023 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166055; x=1734702055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tov8wWJ5efMQB+MBw6ZRhy90dLcQ3ea0IO1FuVFBmws=;
  b=cv+BHf8q+U3I/8gphyqmJvKYC8dWSobres4n2zI1Wdx0HAdFrg5rNPVR
   OwUDopqpxYib053dIBEL0cct33VUbUDn+UvTP0GOhDOZ+LTKHIaaCfz3Z
   00FYi0EblZl6ZGgK7yBG8/UuXdyLBO8eZXLgLBBOjIvlgiVF9omEScfUs
   ERWca5DQ66g8Clto4+aMlxtvBnvd7DAR//Qlv5oiaTvdD9WSbSxmBE3lo
   lKC+t3BZOjA7myg8LExQUCu0F38WTjGIVLjp5g2SiijKUut/q/AmyCjrN
   SPhSlnqvRKSEoTOmMR4a2fSMZYrNkVriPjjb+exvxrr37GSyLO2XwcYss
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9446065"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9446065"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:40:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108105173"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108105173"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:40:51 -0800
From: <deepakx.nagaraju@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdavem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] net: ethernet: altera: fix indentation warnings
Date: Thu, 21 Dec 2023 21:40:39 +0800
Message-Id: <20231221134041.27104-3-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231221134041.27104-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-6-deepakx.nagaraju@intel.com>
 <20231221134041.27104-1-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>

Fix indentation issues such as missing a blank line after declarations
and alignment issues.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
---
 drivers/net/ethernet/altera/altera_sgdma.c    | 22 +++++++++----------
 drivers/net/ethernet/altera/altera_tse_main.c |  9 +++-----
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_sgdma.c b/drivers/net/ethernet/altera/altera_sgdma.c
index 5517f89f1ef9..d4edfb3e09e8 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.c
+++ b/drivers/net/ethernet/altera/altera_sgdma.c
@@ -20,7 +20,7 @@ static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 				int wfixed);

 static int sgdma_async_write(struct altera_tse_private *priv,
-			      struct sgdma_descrip __iomem *desc);
+			     struct sgdma_descrip __iomem *desc);

 static int sgdma_async_read(struct altera_tse_private *priv);

@@ -63,7 +63,6 @@ int sgdma_initialize(struct altera_tse_private *priv)
 	INIT_LIST_HEAD(&priv->txlisthd);
 	INIT_LIST_HEAD(&priv->rxlisthd);

-
 	priv->rxdescphys = dma_map_single(priv->device,
 					  (void __force *)priv->rx_dma_desc,
 					  priv->rxdescmem, DMA_BIDIRECTIONAL);
@@ -192,9 +191,7 @@ int sgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *buffer)
 	return 1;
 }

-
-/* tx_lock held to protect access to queued tx list
- */
+/* tx_lock held to protect access to queued tx list */
 u32 sgdma_tx_completions(struct altera_tse_private *priv)
 {
 	u32 ready = 0;
@@ -237,10 +234,9 @@ u32 sgdma_rx_status(struct altera_tse_private *priv)
 	if (sts & SGDMA_STSREG_EOP) {
 		unsigned int pktlength;
 		unsigned int pktstatus;
-		dma_sync_single_for_cpu(priv->device,
-					priv->rxdescphys,
-					SGDMA_DESC_LEN,
-					DMA_FROM_DEVICE);
+
+		dma_sync_single_for_cpu(priv->device, priv->rxdescphys,
+					SGDMA_DESC_LEN,	DMA_FROM_DEVICE);

 		pktlength = csrrd16(desc, sgdma_descroffs(bytes_xferred));
 		pktstatus = csrrd8(desc, sgdma_descroffs(status));
@@ -286,7 +282,6 @@ u32 sgdma_rx_status(struct altera_tse_private *priv)
 	return rxstatus;
 }

-
 /* Private functions */
 static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 				struct sgdma_descrip __iomem *ndesc,
@@ -301,6 +296,7 @@ static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 	/* Clear the next descriptor as not owned by hardware */

 	u32 ctrl = csrrd8(ndesc, sgdma_descroffs(control));
+
 	ctrl &= ~SGDMA_CONTROL_HW_OWNED;
 	csrwr8(ctrl, ndesc, sgdma_descroffs(control));

@@ -406,6 +402,7 @@ sgdma_txphysaddr(struct altera_tse_private *priv,
 {
 	dma_addr_t paddr = priv->txdescmem_busaddr;
 	uintptr_t offs = (uintptr_t)desc - (uintptr_t)priv->tx_dma_desc;
+
 	return (dma_addr_t)((uintptr_t)paddr + offs);
 }

@@ -415,6 +412,7 @@ sgdma_rxphysaddr(struct altera_tse_private *priv,
 {
 	dma_addr_t paddr = priv->rxdescmem_busaddr;
 	uintptr_t offs = (uintptr_t)desc - (uintptr_t)priv->rx_dma_desc;
+
 	return (dma_addr_t)((uintptr_t)paddr + offs);
 }

@@ -445,7 +443,6 @@ queue_tx(struct altera_tse_private *priv, struct tse_buffer *buffer)
 	list_add_tail(&buffer->lh, &priv->txlisthd);
 }

-
 /* adds a tse_buffer to the tail of a rx buffer list
  * assumes the caller is managing and holding a mutual exclusion
  * primitive to avoid simultaneous pushes/pops to the list.
@@ -465,6 +462,7 @@ static struct tse_buffer *
 dequeue_tx(struct altera_tse_private *priv)
 {
 	struct tse_buffer *buffer = NULL;
+
 	list_remove_head(&priv->txlisthd, buffer, struct tse_buffer, lh);
 	return buffer;
 }
@@ -478,6 +476,7 @@ static struct tse_buffer *
 dequeue_rx(struct altera_tse_private *priv)
 {
 	struct tse_buffer *buffer = NULL;
+
 	list_remove_head(&priv->rxlisthd, buffer, struct tse_buffer, lh);
 	return buffer;
 }
@@ -492,6 +491,7 @@ static struct tse_buffer *
 queue_rx_peekhead(struct altera_tse_private *priv)
 {
 	struct tse_buffer *buffer = NULL;
+
 	list_peek_head(&priv->rxlisthd, buffer, struct tse_buffer, lh);
 	return buffer;
 }
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 1c8763be0e4b..6a1a004ea693 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -258,14 +258,12 @@ static int alloc_init_skbufs(struct altera_tse_private *priv)
 	int i;

 	/* Create Rx ring buffer */
-	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer),
-				GFP_KERNEL);
+	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
 	if (!priv->rx_ring)
 		goto err_rx_ring;

 	/* Create Tx ring buffer */
-	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer),
-				GFP_KERNEL);
+	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
 	if (!priv->tx_ring)
 		goto err_tx_ring;

@@ -319,8 +317,7 @@ static inline void tse_rx_refill(struct altera_tse_private *priv)
 	unsigned int entry;
 	int ret;

-	for (; priv->rx_cons - priv->rx_prod > 0;
-			priv->rx_prod++) {
+	for (; priv->rx_cons - priv->rx_prod > 0; priv->rx_prod++) {
 		entry = priv->rx_prod % rxsize;
 		if (likely(priv->rx_ring[entry].skb == NULL)) {
 			ret = tse_init_rx_buffer(priv, &priv->rx_ring[entry],
--
2.26.2


