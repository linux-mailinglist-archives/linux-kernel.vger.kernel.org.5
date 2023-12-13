Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB4810B60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjLMHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjLMHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:11:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20CAD;
        Tue, 12 Dec 2023 23:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702451491; x=1733987491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tov8wWJ5efMQB+MBw6ZRhy90dLcQ3ea0IO1FuVFBmws=;
  b=OCgbRyQ2HqRzZxlmRB2tlnMpjiBJiNytS/J9EYaa7M96Rl+HLhHAfOM6
   bP0oSO5l3IHzEjPGkE8oBxw9oXxueeKLgNGKNiBoMa6N1pMC6toQh97vy
   ndSE/G5DIxKD+6P+ON0fyiM9+0oL+a41BNJzpXhJWkGA+Vmh+y6SqvW8c
   v16CZYncxAvEo1EER/2lUawExw6JIcZ25N43EotklYbEUUnwuZL9eU4kQ
   POf2GAkaRlcRydYduiyFS8tC90+hfq0PwuW+0GWpeUinmLJAL/pxuEvid
   wXdL4TPrN01ia2M24s+LRcMqFp8LHFgx7BBQO/6Z8BsixPXaX41B4fPpB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481126106"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="481126106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 23:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="767109231"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="767109231"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2023 23:11:28 -0800
From:   <deepakx.nagaraju@intel.com>
To:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
        Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH 2/5] net: ethernet: altera: fix indentation warnings
Date:   Wed, 13 Dec 2023 15:11:09 +0800
Message-Id: <20231213071112.18242-3-deepakx.nagaraju@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

