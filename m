Return-Path: <linux-kernel+bounces-8507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D281B8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83C11C25BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3FD7D5E5;
	Thu, 21 Dec 2023 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHqWS/lU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1A7CD16;
	Thu, 21 Dec 2023 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703166063; x=1734702063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cz48Y4qZLURbq32KD66ok0FDqbnk4bAgO3dQp0SGvc=;
  b=lHqWS/lUDwy4uy2euiSP/oH5Y+wP1viegPDOBMIQr2L4po1uCuvCKNcs
   pRYhsNNWBJ7KaiwkrQVW63iZsu/ub0n9jhllH33ItvrQ1Sh4DxkZ1cxuI
   SNc/eUpd56KeRX3TfmLRWC+AuxshljfvX9Kxv+Q84zFDGmfLYJ5qIARFp
   whWr0mS4Dg937D+6WLnXpEduUH4mcsXwdTg7HRZfKl1gg35lVQcA6ABnh
   FG8A2uS+dZJ0LTLpyq2ib/NfPGKyQR0S9HKeaPiqwSPSG+fK9BXaTNPfs
   sE/TXpdOFqka8uoh4q20zeUCr2XCgB9texZ16ItwuKvCi5M4EOf+Ohxvu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9446078"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9446078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1108105189"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1108105189"
Received: from pglc00021.png.intel.com ([10.221.207.41])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2023 05:41:00 -0800
From: <deepakx.nagaraju@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdavem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mun.yew.tham@intel.com,
	Nagaraju DeepakX <deepakx.nagaraju@intel.com>,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] net: ethernet: altera: rename functions and their prototypes
Date: Thu, 21 Dec 2023 21:40:41 +0800
Message-Id: <20231221134041.27104-5-deepakx.nagaraju@intel.com>
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

Move standard DMA interface for sgdma and msgdma and rename them
from tse_private to dma_private.

Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>
---
 drivers/net/ethernet/altera/Makefile          |   5 +-
 drivers/net/ethernet/altera/altera_eth_dma.c  |  58 ++++
 drivers/net/ethernet/altera/altera_eth_dma.h  | 121 +++++++++
 drivers/net/ethernet/altera/altera_msgdma.c   |  38 +--
 drivers/net/ethernet/altera/altera_msgdma.h   |  28 +-
 drivers/net/ethernet/altera/altera_sgdma.c    | 110 ++++----
 drivers/net/ethernet/altera/altera_sgdma.h    |  30 +--
 drivers/net/ethernet/altera/altera_tse.h      |  26 +-
 .../net/ethernet/altera/altera_tse_ethtool.c  |   1 +
 drivers/net/ethernet/altera/altera_tse_main.c | 248 +++++++-----------
 drivers/net/ethernet/altera/altera_utils.c    |   1 +
 11 files changed, 390 insertions(+), 276 deletions(-)
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.c
 create mode 100644 drivers/net/ethernet/altera/altera_eth_dma.h

diff --git a/drivers/net/ethernet/altera/Makefile b/drivers/net/ethernet/altera/Makefile
index a52db80aee9f..ce723832edc4 100644
--- a/drivers/net/ethernet/altera/Makefile
+++ b/drivers/net/ethernet/altera/Makefile
@@ -3,6 +3,9 @@
 # Makefile for the Altera device drivers.
 #

+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=NET_ALTERA
+
 obj-$(CONFIG_ALTERA_TSE) += altera_tse.o
 altera_tse-objs := altera_tse_main.o altera_tse_ethtool.o \
-altera_msgdma.o altera_sgdma.o altera_utils.o
+		   altera_msgdma.o altera_sgdma.o altera_utils.o \
+		   altera_eth_dma.o
diff --git a/drivers/net/ethernet/altera/altera_eth_dma.c b/drivers/net/ethernet/altera/altera_eth_dma.c
new file mode 100644
index 000000000000..6a47a3cb3406
--- /dev/null
+++ b/drivers/net/ethernet/altera/altera_eth_dma.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* DMA support for Intel FPGA Quad-Speed Ethernet MAC driver
+ * Copyright (C) 2023 Intel Corporation. All rights reserved
+ */
+
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "altera_eth_dma.h"
+#include "altera_utils.h"
+
+/* Probe DMA */
+int altera_eth_dma_probe(struct platform_device *pdev, struct altera_dma_private *priv,
+			 enum altera_dma_type type)
+{
+	void __iomem *descmap;
+
+	/* xSGDMA Rx Dispatcher address space */
+	priv->rx_dma_csr = devm_platform_ioremap_resource_byname(pdev, "rx_csr");
+	if (IS_ERR(priv->rx_dma_csr))
+		return PTR_ERR(priv->rx_dma_csr);
+
+	/* mSGDMA Tx Dispatcher address space */
+	priv->tx_dma_csr = devm_platform_ioremap_resource_byname(pdev, "tx_csr");
+	if (IS_ERR(priv->rx_dma_csr))
+		return PTR_ERR(priv->rx_dma_csr);
+
+	switch (type) {
+	case ALTERA_DTYPE_SGDMA:
+		/* Get the mapped address to the SGDMA descriptor memory */
+		descmap = devm_platform_ioremap_resource_byname(pdev, "s1");
+		if (IS_ERR(descmap))
+			return PTR_ERR(descmap);
+		break;
+	case ALTERA_DTYPE_MSGDMA:
+		priv->rx_dma_resp = devm_platform_ioremap_resource_byname(pdev, "rx_resp");
+		if (IS_ERR(priv->rx_dma_resp))
+			return PTR_ERR(priv->rx_dma_resp);
+
+		priv->tx_dma_desc = devm_platform_ioremap_resource_byname(pdev, "tx_desc");
+		if (IS_ERR(priv->tx_dma_desc))
+			return PTR_ERR(priv->tx_dma_desc);
+
+		priv->rx_dma_desc = devm_platform_ioremap_resource_byname(pdev, "rx_desc");
+		if (IS_ERR(priv->rx_dma_desc))
+			return PTR_ERR(priv->rx_dma_desc);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+
+};
+EXPORT_SYMBOL_NS(altera_eth_dma_probe, NET_ALTERA);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/altera/altera_eth_dma.h b/drivers/net/ethernet/altera/altera_eth_dma.h
new file mode 100644
index 000000000000..5007f2396221
--- /dev/null
+++ b/drivers/net/ethernet/altera/altera_eth_dma.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* DMA support for Intel FPGA Quad-Speed Ethernet MAC driver
+ * Copyright (C) 2023 Intel Corporation. All rights reserved
+ */
+
+#ifndef __ALTERA_ETH_DMA_H__
+#define __ALTERA_ETH_DMA_H__
+
+#include <linux/types.h>
+
+struct device;
+struct net_device;
+struct platform_device;
+struct sk_buff;
+
+struct altera_dma_buffer;
+struct altera_dma_private;
+struct msgdma_pref_extended_desc;
+
+/* Wrapper around a pointer to a socket buffer,
+ * so a DMA handle can be stored along with the buffer.
+ */
+
+struct altera_dma_buffer {
+	struct list_head lh;
+	struct sk_buff *skb;
+	dma_addr_t dma_addr;
+	u32 len;
+	int mapped_as_page;
+};
+
+struct altera_dma_private {
+	struct net_device *dev;
+	struct device *device;
+
+	/* mSGDMA Rx Dispatcher address space */
+	void __iomem *rx_dma_csr;
+	void __iomem *rx_dma_desc;
+	void __iomem *rx_dma_resp;
+
+	/* mSGDMA Tx Dispatcher address space */
+	void __iomem *tx_dma_csr;
+	void __iomem *tx_dma_desc;
+	void __iomem *tx_dma_resp;
+
+	/* mSGDMA Rx Prefecher address space */
+	void __iomem *rx_pref_csr;
+	struct msgdma_pref_extended_desc *pref_rxdesc;
+	dma_addr_t pref_rxdescphys;
+	u32 pref_rx_prod;
+
+	/* mSGDMA Tx Prefecher address space */
+	void __iomem *tx_pref_csr;
+	struct msgdma_pref_extended_desc *pref_txdesc;
+	dma_addr_t pref_txdescphys;
+	u32 rx_poll_freq;
+	u32 tx_poll_freq;
+
+	/* Rx buffers queue */
+	struct altera_dma_buffer *rx_ring;
+	u32 rx_cons;
+	u32 rx_prod;
+	u32 rx_ring_size;
+	u32 rx_dma_buf_sz;
+
+	/* Tx ring buffer */
+	struct altera_dma_buffer *tx_ring;
+	u32 tx_prod;
+	u32 tx_cons;
+	u32 tx_ring_size;
+
+	/* Descriptor memory info for managing SGDMA */
+	u32 txdescmem;
+	u32 rxdescmem;
+	dma_addr_t rxdescmem_busaddr;
+	dma_addr_t txdescmem_busaddr;
+	u32 txctrlreg;
+	u32 rxctrlreg;
+	dma_addr_t rxdescphys;
+	dma_addr_t txdescphys;
+
+	struct list_head txlisthd;
+	struct list_head rxlisthd;
+
+	int hwts_tx_en;
+	int hwts_rx_en;
+
+	/* ethtool msglvl option */
+	u32 msg_enable;
+};
+
+enum altera_dma_type {
+	ALTERA_DTYPE_SGDMA = 1,
+	ALTERA_DTYPE_MSGDMA = 2,
+};
+
+/* standard DMA interface for SGDMA and MSGDMA */
+struct altera_dmaops {
+	enum altera_dma_type altera_dtype;
+	int dmamask;
+	void (*reset_dma)(struct altera_dma_private *priv);
+	void (*enable_txirq)(struct altera_dma_private *priv);
+	void (*enable_rxirq)(struct altera_dma_private *priv);
+	void (*disable_txirq)(struct altera_dma_private *priv);
+	void (*disable_rxirq)(struct altera_dma_private *priv);
+	void (*clear_txirq)(struct altera_dma_private *priv);
+	void (*clear_rxirq)(struct altera_dma_private *priv);
+	int (*tx_buffer)(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+	u32 (*tx_completions)(struct altera_dma_private *priv);
+	void (*add_rx_desc)(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+	u32 (*get_rx_status)(struct altera_dma_private *priv);
+	int (*init_dma)(struct altera_dma_private *priv);
+	void (*uninit_dma)(struct altera_dma_private *priv);
+	void (*start_rxdma)(struct altera_dma_private *priv);
+	void (*start_txdma)(struct altera_dma_private *priv);
+};
+
+int altera_eth_dma_probe(struct platform_device *pdev, struct altera_dma_private *priv,
+			 enum altera_dma_type type);
+
+#endif /* __ALTERA_ETH_DMA_H__ */
diff --git a/drivers/net/ethernet/altera/altera_msgdma.c b/drivers/net/ethernet/altera/altera_msgdma.c
index ac1efd08267a..d15400c33d05 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.c
+++ b/drivers/net/ethernet/altera/altera_msgdma.c
@@ -4,26 +4,28 @@
  */

 #include <linux/netdevice.h>
-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_msgdmahw.h"
+
+#include "altera_eth_dma.h"
 #include "altera_msgdma.h"
+#include "altera_msgdmahw.h"
+#include "altera_tse.h"
+#include "altera_utils.h"

 /* No initialization work to do for MSGDMA */
-int msgdma_initialize(struct altera_tse_private *priv)
+int msgdma_initialize(struct altera_dma_private *priv)
 {
 	return 0;
 }

-void msgdma_uninitialize(struct altera_tse_private *priv)
+void msgdma_uninitialize(struct altera_dma_private *priv)
 {
 }

-void msgdma_start_rxdma(struct altera_tse_private *priv)
+void msgdma_start_rxdma(struct altera_dma_private *priv)
 {
 }

-void msgdma_reset(struct altera_tse_private *priv)
+void msgdma_reset(struct altera_dma_private *priv)
 {
 	int counter;

@@ -71,42 +73,42 @@ void msgdma_reset(struct altera_tse_private *priv)
 	csrwr32(MSGDMA_CSR_STAT_MASK, priv->tx_dma_csr, msgdma_csroffs(status));
 }

-void msgdma_disable_rxirq(struct altera_tse_private *priv)
+void msgdma_disable_rxirq(struct altera_dma_private *priv)
 {
 	tse_clear_bit(priv->rx_dma_csr, msgdma_csroffs(control),
 		      MSGDMA_CSR_CTL_GLOBAL_INTR);
 }

-void msgdma_enable_rxirq(struct altera_tse_private *priv)
+void msgdma_enable_rxirq(struct altera_dma_private *priv)
 {
 	tse_set_bit(priv->rx_dma_csr, msgdma_csroffs(control),
 		    MSGDMA_CSR_CTL_GLOBAL_INTR);
 }

-void msgdma_disable_txirq(struct altera_tse_private *priv)
+void msgdma_disable_txirq(struct altera_dma_private *priv)
 {
 	tse_clear_bit(priv->tx_dma_csr, msgdma_csroffs(control),
 		      MSGDMA_CSR_CTL_GLOBAL_INTR);
 }

-void msgdma_enable_txirq(struct altera_tse_private *priv)
+void msgdma_enable_txirq(struct altera_dma_private *priv)
 {
 	tse_set_bit(priv->tx_dma_csr, msgdma_csroffs(control),
 		    MSGDMA_CSR_CTL_GLOBAL_INTR);
 }

-void msgdma_clear_rxirq(struct altera_tse_private *priv)
+void msgdma_clear_rxirq(struct altera_dma_private *priv)
 {
 	csrwr32(MSGDMA_CSR_STAT_IRQ, priv->rx_dma_csr, msgdma_csroffs(status));
 }

-void msgdma_clear_txirq(struct altera_tse_private *priv)
+void msgdma_clear_txirq(struct altera_dma_private *priv)
 {
 	csrwr32(MSGDMA_CSR_STAT_IRQ, priv->tx_dma_csr, msgdma_csroffs(status));
 }

 /* return 0 to indicate transmit is pending */
-int msgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *buffer)
+int msgdma_tx_buffer(struct altera_dma_private *priv, struct altera_dma_buffer *buffer)
 {
 	csrwr32(lower_32_bits(buffer->dma_addr), priv->tx_dma_desc,
 		msgdma_descroffs(read_addr_lo));
@@ -123,7 +125,7 @@ int msgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *buffer)
 	return 0;
 }

-u32 msgdma_tx_completions(struct altera_tse_private *priv)
+u32 msgdma_tx_completions(struct altera_dma_private *priv)
 {
 	u32 ready = 0;
 	u32 inuse;
@@ -149,8 +151,8 @@ u32 msgdma_tx_completions(struct altera_tse_private *priv)

 /* Put buffer to the mSGDMA RX FIFO
  */
-void msgdma_add_rx_desc(struct altera_tse_private *priv,
-			struct tse_buffer *rxbuffer)
+void msgdma_add_rx_desc(struct altera_dma_private *priv,
+			struct altera_dma_buffer *rxbuffer)
 {
 	u32 len = priv->rx_dma_buf_sz;
 	dma_addr_t dma_addr = rxbuffer->dma_addr;
@@ -176,7 +178,7 @@ void msgdma_add_rx_desc(struct altera_tse_private *priv,
 /* status is returned on upper 16 bits,
  * length is returned in lower 16 bits
  */
-u32 msgdma_rx_status(struct altera_tse_private *priv)
+u32 msgdma_rx_status(struct altera_dma_private *priv)
 {
 	u32 rxstatus = 0;
 	u32 pktlength;
diff --git a/drivers/net/ethernet/altera/altera_msgdma.h b/drivers/net/ethernet/altera/altera_msgdma.h
index 9813fbfff4d3..ac04eb676bc8 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.h
+++ b/drivers/net/ethernet/altera/altera_msgdma.h
@@ -6,19 +6,19 @@
 #ifndef __ALTERA_MSGDMA_H__
 #define __ALTERA_MSGDMA_H__

-void msgdma_reset(struct altera_tse_private *);
-void msgdma_enable_txirq(struct altera_tse_private *);
-void msgdma_enable_rxirq(struct altera_tse_private *);
-void msgdma_disable_rxirq(struct altera_tse_private *);
-void msgdma_disable_txirq(struct altera_tse_private *);
-void msgdma_clear_rxirq(struct altera_tse_private *);
-void msgdma_clear_txirq(struct altera_tse_private *);
-u32 msgdma_tx_completions(struct altera_tse_private *);
-void msgdma_add_rx_desc(struct altera_tse_private *, struct tse_buffer *);
-int msgdma_tx_buffer(struct altera_tse_private *, struct tse_buffer *);
-u32 msgdma_rx_status(struct altera_tse_private *);
-int msgdma_initialize(struct altera_tse_private *);
-void msgdma_uninitialize(struct altera_tse_private *);
-void msgdma_start_rxdma(struct altera_tse_private *);
+void msgdma_reset(struct altera_dma_private *priv);
+void msgdma_enable_txirq(struct altera_dma_private *priv);
+void msgdma_enable_rxirq(struct altera_dma_private *priv);
+void msgdma_disable_rxirq(struct altera_dma_private *priv);
+void msgdma_disable_txirq(struct altera_dma_private *priv);
+void msgdma_clear_rxirq(struct altera_dma_private *priv);
+void msgdma_clear_txirq(struct altera_dma_private *priv);
+u32 msgdma_tx_completions(struct altera_dma_private *priv);
+void msgdma_add_rx_desc(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+int msgdma_tx_buffer(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+u32 msgdma_rx_status(struct altera_dma_private *priv);
+int msgdma_initialize(struct altera_dma_private *priv);
+void msgdma_uninitialize(struct altera_dma_private *priv);
+void msgdma_start_rxdma(struct altera_dma_private *priv);

 #endif /*  __ALTERA_MSGDMA_H__ */
diff --git a/drivers/net/ethernet/altera/altera_sgdma.c b/drivers/net/ethernet/altera/altera_sgdma.c
index d4edfb3e09e8..14f7b0115eda 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.c
+++ b/drivers/net/ethernet/altera/altera_sgdma.c
@@ -4,10 +4,12 @@
  */

 #include <linux/list.h>
-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_sgdmahw.h"
+#include <linux/netdevice.h>
+
+#include "altera_eth_dma.h"
 #include "altera_sgdma.h"
+#include "altera_sgdmahw.h"
+#include "altera_utils.h"

 static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 				struct sgdma_descrip __iomem *ndesc,
@@ -19,39 +21,39 @@ static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
 				int rfixed,
 				int wfixed);

-static int sgdma_async_write(struct altera_tse_private *priv,
+static int sgdma_async_write(struct altera_dma_private *priv,
 			     struct sgdma_descrip __iomem *desc);

-static int sgdma_async_read(struct altera_tse_private *priv);
+static int sgdma_async_read(struct altera_dma_private *priv);

 static dma_addr_t
-sgdma_txphysaddr(struct altera_tse_private *priv,
+sgdma_txphysaddr(struct altera_dma_private *priv,
 		 struct sgdma_descrip __iomem *desc);

 static dma_addr_t
-sgdma_rxphysaddr(struct altera_tse_private *priv,
+sgdma_rxphysaddr(struct altera_dma_private *priv,
 		 struct sgdma_descrip __iomem *desc);

-static int sgdma_txbusy(struct altera_tse_private *priv);
+static int sgdma_txbusy(struct altera_dma_private *priv);

-static int sgdma_rxbusy(struct altera_tse_private *priv);
+static int sgdma_rxbusy(struct altera_dma_private *priv);

 static void
-queue_tx(struct altera_tse_private *priv, struct tse_buffer *buffer);
+queue_tx(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);

 static void
-queue_rx(struct altera_tse_private *priv, struct tse_buffer *buffer);
+queue_rx(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);

-static struct tse_buffer *
-dequeue_tx(struct altera_tse_private *priv);
+static struct altera_dma_buffer *
+dequeue_tx(struct altera_dma_private *priv);

-static struct tse_buffer *
-dequeue_rx(struct altera_tse_private *priv);
+static struct altera_dma_buffer *
+dequeue_rx(struct altera_dma_private *priv);

-static struct tse_buffer *
-queue_rx_peekhead(struct altera_tse_private *priv);
+static struct altera_dma_buffer *
+queue_rx_peekhead(struct altera_dma_private *priv);

-int sgdma_initialize(struct altera_tse_private *priv)
+int sgdma_initialize(struct altera_dma_private *priv)
 {
 	priv->txctrlreg = SGDMA_CTRLREG_ILASTD |
 		      SGDMA_CTRLREG_INTEN;
@@ -96,7 +98,7 @@ int sgdma_initialize(struct altera_tse_private *priv)
 	return 0;
 }

-void sgdma_uninitialize(struct altera_tse_private *priv)
+void sgdma_uninitialize(struct altera_dma_private *priv)
 {
 	if (priv->rxdescphys)
 		dma_unmap_single(priv->device, priv->rxdescphys,
@@ -110,7 +112,7 @@ void sgdma_uninitialize(struct altera_tse_private *priv)
 /* This function resets the SGDMA controller and clears the
  * descriptor memory used for transmits and receives.
  */
-void sgdma_reset(struct altera_tse_private *priv)
+void sgdma_reset(struct altera_dma_private *priv)
 {
 	/* Initialize descriptor memory to 0 */
 	memset_io(priv->tx_dma_desc, 0, priv->txdescmem);
@@ -128,29 +130,29 @@ void sgdma_reset(struct altera_tse_private *priv)
  * and disable
  */

-void sgdma_enable_rxirq(struct altera_tse_private *priv)
+void sgdma_enable_rxirq(struct altera_dma_private *priv)
 {
 }

-void sgdma_enable_txirq(struct altera_tse_private *priv)
+void sgdma_enable_txirq(struct altera_dma_private *priv)
 {
 }

-void sgdma_disable_rxirq(struct altera_tse_private *priv)
+void sgdma_disable_rxirq(struct altera_dma_private *priv)
 {
 }

-void sgdma_disable_txirq(struct altera_tse_private *priv)
+void sgdma_disable_txirq(struct altera_dma_private *priv)
 {
 }

-void sgdma_clear_rxirq(struct altera_tse_private *priv)
+void sgdma_clear_rxirq(struct altera_dma_private *priv)
 {
 	tse_set_bit(priv->rx_dma_csr, sgdma_csroffs(control),
 		    SGDMA_CTRLREG_CLRINT);
 }

-void sgdma_clear_txirq(struct altera_tse_private *priv)
+void sgdma_clear_txirq(struct altera_dma_private *priv)
 {
 	tse_set_bit(priv->tx_dma_csr, sgdma_csroffs(control),
 		    SGDMA_CTRLREG_CLRINT);
@@ -161,7 +163,7 @@ void sgdma_clear_txirq(struct altera_tse_private *priv)
  *
  * tx_lock is held by the caller
  */
-int sgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *buffer)
+int sgdma_tx_buffer(struct altera_dma_private *priv, struct altera_dma_buffer *buffer)
 {
 	struct sgdma_descrip __iomem *descbase =
 		(struct sgdma_descrip __iomem *)priv->tx_dma_desc;
@@ -192,7 +194,7 @@ int sgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *buffer)
 }

 /* tx_lock held to protect access to queued tx list */
-u32 sgdma_tx_completions(struct altera_tse_private *priv)
+u32 sgdma_tx_completions(struct altera_dma_private *priv)
 {
 	u32 ready = 0;

@@ -206,13 +208,13 @@ u32 sgdma_tx_completions(struct altera_tse_private *priv)
 	return ready;
 }

-void sgdma_start_rxdma(struct altera_tse_private *priv)
+void sgdma_start_rxdma(struct altera_dma_private *priv)
 {
 	sgdma_async_read(priv);
 }

-void sgdma_add_rx_desc(struct altera_tse_private *priv,
-		       struct tse_buffer *rxbuffer)
+void sgdma_add_rx_desc(struct altera_dma_private *priv,
+		       struct altera_dma_buffer *rxbuffer)
 {
 	queue_rx(priv, rxbuffer);
 }
@@ -220,12 +222,12 @@ void sgdma_add_rx_desc(struct altera_tse_private *priv,
 /* status is returned on upper 16 bits,
  * length is returned in lower 16 bits
  */
-u32 sgdma_rx_status(struct altera_tse_private *priv)
+u32 sgdma_rx_status(struct altera_dma_private *priv)
 {
 	struct sgdma_descrip __iomem *base =
 		(struct sgdma_descrip __iomem *)priv->rx_dma_desc;
 	struct sgdma_descrip __iomem *desc = NULL;
-	struct tse_buffer *rxbuffer = NULL;
+	struct altera_dma_buffer *rxbuffer = NULL;
 	unsigned int rxstatus = 0;

 	u32 sts = csrrd32(priv->rx_dma_csr, sgdma_csroffs(status));
@@ -327,14 +329,14 @@ static void sgdma_setup_descrip(struct sgdma_descrip __iomem *desc,
  * If read status indicate not busy and a status, restart the async
  * DMA read.
  */
-static int sgdma_async_read(struct altera_tse_private *priv)
+static int sgdma_async_read(struct altera_dma_private *priv)
 {
 	struct sgdma_descrip __iomem *descbase =
 		(struct sgdma_descrip __iomem *)priv->rx_dma_desc;

 	struct sgdma_descrip __iomem *cdesc = &descbase[0];
 	struct sgdma_descrip __iomem *ndesc = &descbase[1];
-	struct tse_buffer *rxbuffer = NULL;
+	struct altera_dma_buffer *rxbuffer = NULL;

 	if (!sgdma_rxbusy(priv)) {
 		rxbuffer = queue_rx_peekhead(priv);
@@ -372,7 +374,7 @@ static int sgdma_async_read(struct altera_tse_private *priv)
 	return 0;
 }

-static int sgdma_async_write(struct altera_tse_private *priv,
+static int sgdma_async_write(struct altera_dma_private *priv,
 			     struct sgdma_descrip __iomem *desc)
 {
 	if (sgdma_txbusy(priv))
@@ -397,7 +399,7 @@ static int sgdma_async_write(struct altera_tse_private *priv,
 }

 static dma_addr_t
-sgdma_txphysaddr(struct altera_tse_private *priv,
+sgdma_txphysaddr(struct altera_dma_private *priv,
 		 struct sgdma_descrip __iomem *desc)
 {
 	dma_addr_t paddr = priv->txdescmem_busaddr;
@@ -407,7 +409,7 @@ sgdma_txphysaddr(struct altera_tse_private *priv,
 }

 static dma_addr_t
-sgdma_rxphysaddr(struct altera_tse_private *priv,
+sgdma_rxphysaddr(struct altera_dma_private *priv,
 		 struct sgdma_descrip __iomem *desc)
 {
 	dma_addr_t paddr = priv->rxdescmem_busaddr;
@@ -438,7 +440,7 @@ sgdma_rxphysaddr(struct altera_tse_private *priv,
  * primitive to avoid simultaneous pushes/pops to the list.
  */
 static void
-queue_tx(struct altera_tse_private *priv, struct tse_buffer *buffer)
+queue_tx(struct altera_dma_private *priv, struct altera_dma_buffer *buffer)
 {
 	list_add_tail(&buffer->lh, &priv->txlisthd);
 }
@@ -448,7 +450,7 @@ queue_tx(struct altera_tse_private *priv, struct tse_buffer *buffer)
  * primitive to avoid simultaneous pushes/pops to the list.
  */
 static void
-queue_rx(struct altera_tse_private *priv, struct tse_buffer *buffer)
+queue_rx(struct altera_dma_private *priv, struct altera_dma_buffer *buffer)
 {
 	list_add_tail(&buffer->lh, &priv->rxlisthd);
 }
@@ -458,12 +460,12 @@ queue_rx(struct altera_tse_private *priv, struct tse_buffer *buffer)
  * assumes the caller is managing and holding a mutual exclusion
  * primitive to avoid simultaneous pushes/pops to the list.
  */
-static struct tse_buffer *
-dequeue_tx(struct altera_tse_private *priv)
+static struct altera_dma_buffer *
+dequeue_tx(struct altera_dma_private *priv)
 {
-	struct tse_buffer *buffer = NULL;
+	struct altera_dma_buffer *buffer = NULL;

-	list_remove_head(&priv->txlisthd, buffer, struct tse_buffer, lh);
+	list_remove_head(&priv->txlisthd, buffer, struct altera_dma_buffer, lh);
 	return buffer;
 }

@@ -472,12 +474,12 @@ dequeue_tx(struct altera_tse_private *priv)
  * assumes the caller is managing and holding a mutual exclusion
  * primitive to avoid simultaneous pushes/pops to the list.
  */
-static struct tse_buffer *
-dequeue_rx(struct altera_tse_private *priv)
+static struct altera_dma_buffer *
+dequeue_rx(struct altera_dma_private *priv)
 {
-	struct tse_buffer *buffer = NULL;
+	struct altera_dma_buffer *buffer = NULL;

-	list_remove_head(&priv->rxlisthd, buffer, struct tse_buffer, lh);
+	list_remove_head(&priv->rxlisthd, buffer, struct altera_dma_buffer, lh);
 	return buffer;
 }

@@ -487,18 +489,18 @@ dequeue_rx(struct altera_tse_private *priv)
  * primitive to avoid simultaneous pushes/pops to the list while the
  * head is being examined.
  */
-static struct tse_buffer *
-queue_rx_peekhead(struct altera_tse_private *priv)
+static struct altera_dma_buffer *
+queue_rx_peekhead(struct altera_dma_private *priv)
 {
-	struct tse_buffer *buffer = NULL;
+	struct altera_dma_buffer *buffer = NULL;

-	list_peek_head(&priv->rxlisthd, buffer, struct tse_buffer, lh);
+	list_peek_head(&priv->rxlisthd, buffer, struct altera_dma_buffer, lh);
 	return buffer;
 }

 /* check and return rx sgdma status without polling
  */
-static int sgdma_rxbusy(struct altera_tse_private *priv)
+static int sgdma_rxbusy(struct altera_dma_private *priv)
 {
 	return csrrd32(priv->rx_dma_csr, sgdma_csroffs(status))
 		       & SGDMA_STSREG_BUSY;
@@ -507,7 +509,7 @@ static int sgdma_rxbusy(struct altera_tse_private *priv)
 /* waits for the tx sgdma to finish it's current operation, returns 0
  * when it transitions to nonbusy, returns 1 if the operation times out
  */
-static int sgdma_txbusy(struct altera_tse_private *priv)
+static int sgdma_txbusy(struct altera_dma_private *priv)
 {
 	int delay = 0;

diff --git a/drivers/net/ethernet/altera/altera_sgdma.h b/drivers/net/ethernet/altera/altera_sgdma.h
index 08afe1c9994f..998deb74c5f1 100644
--- a/drivers/net/ethernet/altera/altera_sgdma.h
+++ b/drivers/net/ethernet/altera/altera_sgdma.h
@@ -6,20 +6,20 @@
 #ifndef __ALTERA_SGDMA_H__
 #define __ALTERA_SGDMA_H__

-void sgdma_reset(struct altera_tse_private *);
-void sgdma_enable_txirq(struct altera_tse_private *);
-void sgdma_enable_rxirq(struct altera_tse_private *);
-void sgdma_disable_rxirq(struct altera_tse_private *);
-void sgdma_disable_txirq(struct altera_tse_private *);
-void sgdma_clear_rxirq(struct altera_tse_private *);
-void sgdma_clear_txirq(struct altera_tse_private *);
-int sgdma_tx_buffer(struct altera_tse_private *priv, struct tse_buffer *);
-u32 sgdma_tx_completions(struct altera_tse_private *);
-void sgdma_add_rx_desc(struct altera_tse_private *priv, struct tse_buffer *);
-void sgdma_status(struct altera_tse_private *);
-u32 sgdma_rx_status(struct altera_tse_private *);
-int sgdma_initialize(struct altera_tse_private *);
-void sgdma_uninitialize(struct altera_tse_private *);
-void sgdma_start_rxdma(struct altera_tse_private *);
+void sgdma_reset(struct altera_dma_private *priv);
+void sgdma_enable_txirq(struct altera_dma_private *priv);
+void sgdma_enable_rxirq(struct altera_dma_private *priv);
+void sgdma_disable_rxirq(struct altera_dma_private *priv);
+void sgdma_disable_txirq(struct altera_dma_private *priv);
+void sgdma_clear_rxirq(struct altera_dma_private *priv);
+void sgdma_clear_txirq(struct altera_dma_private *priv);
+int sgdma_tx_buffer(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+u32 sgdma_tx_completions(struct altera_dma_private *priv);
+void sgdma_add_rx_desc(struct altera_dma_private *priv, struct altera_dma_buffer *buffer);
+void sgdma_status(struct altera_dma_private *priv);
+u32 sgdma_rx_status(struct altera_dma_private *priv);
+int sgdma_initialize(struct altera_dma_private *priv);
+void sgdma_uninitialize(struct altera_dma_private *priv);
+void sgdma_start_rxdma(struct altera_dma_private *priv);

 #endif /*  __ALTERA_SGDMA_H__ */
diff --git a/drivers/net/ethernet/altera/altera_tse.h b/drivers/net/ethernet/altera/altera_tse.h
index 4874139e7cdf..020ac5946acc 100644
--- a/drivers/net/ethernet/altera/altera_tse.h
+++ b/drivers/net/ethernet/altera/altera_tse.h
@@ -368,29 +368,6 @@ struct tse_buffer {

 struct altera_tse_private;

-#define ALTERA_DTYPE_SGDMA 1
-#define ALTERA_DTYPE_MSGDMA 2
-
-/* standard DMA interface for SGDMA and MSGDMA */
-struct altera_dmaops {
-	int altera_dtype;
-	int dmamask;
-	void (*reset_dma)(struct altera_tse_private *);
-	void (*enable_txirq)(struct altera_tse_private *);
-	void (*enable_rxirq)(struct altera_tse_private *);
-	void (*disable_txirq)(struct altera_tse_private *);
-	void (*disable_rxirq)(struct altera_tse_private *);
-	void (*clear_txirq)(struct altera_tse_private *);
-	void (*clear_rxirq)(struct altera_tse_private *);
-	int (*tx_buffer)(struct altera_tse_private *, struct tse_buffer *);
-	u32 (*tx_completions)(struct altera_tse_private *);
-	void (*add_rx_desc)(struct altera_tse_private *, struct tse_buffer *);
-	u32 (*get_rx_status)(struct altera_tse_private *);
-	int (*init_dma)(struct altera_tse_private *);
-	void (*uninit_dma)(struct altera_tse_private *);
-	void (*start_rxdma)(struct altera_tse_private *);
-};
-
 /* This structure is private to each device.
  */
 struct altera_tse_private {
@@ -401,6 +378,9 @@ struct altera_tse_private {
 	/* MAC address space */
 	struct altera_tse_mac __iomem *mac_dev;

+	/* Shared DMA structure */
+	struct altera_dma_private dma_priv;
+
 	/* TSE Revision */
 	u32	revision;

diff --git a/drivers/net/ethernet/altera/altera_tse_ethtool.c b/drivers/net/ethernet/altera/altera_tse_ethtool.c
index d34373bac94a..6253bfe86e47 100644
--- a/drivers/net/ethernet/altera/altera_tse_ethtool.c
+++ b/drivers/net/ethernet/altera/altera_tse_ethtool.c
@@ -21,6 +21,7 @@
 #include <linux/netdevice.h>
 #include <linux/phy.h>

+#include "altera_eth_dma.h"
 #include "altera_tse.h"
 #include "altera_utils.h"

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 6a1a004ea693..1b66970a40e6 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -29,21 +29,23 @@
 #include <linux/mii.h>
 #include <linux/mdio/mdio-regmap.h>
 #include <linux/netdevice.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/pcs-lynx.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/skbuff.h>
+
 #include <asm/cacheflush.h>

-#include "altera_utils.h"
-#include "altera_tse.h"
-#include "altera_sgdma.h"
+#include "altera_eth_dma.h"
 #include "altera_msgdma.h"
+#include "altera_sgdma.h"
+#include "altera_tse.h"
+#include "altera_utils.h"

 static atomic_t instance_count = ATOMIC_INIT(~0);
 /* Module parameters */
@@ -78,13 +80,15 @@ MODULE_PARM_DESC(dma_tx_num, "Number of descriptors in the TX list");
 /* Allow network stack to resume queuing packets after we've
  * finished transmitting at least 1/4 of the packets in the queue.
  */
-#define TSE_TX_THRESH(x)	(x->tx_ring_size / 4)
+#define TSE_TX_THRESH(x)	(x->dma_priv.tx_ring_size / 4)

 #define TXQUEUESTOP_THRESHHOLD	2

 static inline u32 tse_tx_avail(struct altera_tse_private *priv)
 {
-	return priv->tx_cons + priv->tx_ring_size - priv->tx_prod - 1;
+	struct altera_dma_private *dma = &priv->dma_priv;
+
+	return dma->tx_cons + dma->tx_ring_size - dma->tx_prod - 1;
 }

 /* MDIO specific functions
@@ -193,7 +197,7 @@ static void altera_tse_mdio_destroy(struct net_device *dev)
 }

 static int tse_init_rx_buffer(struct altera_tse_private *priv,
-			      struct tse_buffer *rxbuffer, int len)
+			      struct altera_dma_buffer *rxbuffer, int len)
 {
 	rxbuffer->skb = netdev_alloc_skb_ip_align(priv->dev, len);
 	if (!rxbuffer->skb)
@@ -214,7 +218,7 @@ static int tse_init_rx_buffer(struct altera_tse_private *priv,
 }

 static void tse_free_rx_buffer(struct altera_tse_private *priv,
-			       struct tse_buffer *rxbuffer)
+			       struct altera_dma_buffer *rxbuffer)
 {
 	dma_addr_t dma_addr = rxbuffer->dma_addr;
 	struct sk_buff *skb = rxbuffer->skb;
@@ -233,7 +237,7 @@ static void tse_free_rx_buffer(struct altera_tse_private *priv,
 /* Unmap and free Tx buffer resources
  */
 static void tse_free_tx_buffer(struct altera_tse_private *priv,
-			       struct tse_buffer *buffer)
+			       struct altera_dma_buffer *buffer)
 {
 	if (buffer->dma_addr) {
 		if (buffer->mapped_as_page)
@@ -252,42 +256,42 @@ static void tse_free_tx_buffer(struct altera_tse_private *priv,

 static int alloc_init_skbufs(struct altera_tse_private *priv)
 {
-	unsigned int rx_descs = priv->rx_ring_size;
-	unsigned int tx_descs = priv->tx_ring_size;
+	struct altera_dma_private *dma = &priv->dma_priv;
+	unsigned int rx_descs = dma->rx_ring_size;
+	unsigned int tx_descs = dma->tx_ring_size;
 	int ret = -ENOMEM;
 	int i;

 	/* Create Rx ring buffer */
-	priv->rx_ring = kcalloc(rx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
-	if (!priv->rx_ring)
+	dma->rx_ring = kcalloc(rx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);
+	if (!dma->rx_ring)
 		goto err_rx_ring;

 	/* Create Tx ring buffer */
-	priv->tx_ring = kcalloc(tx_descs, sizeof(struct tse_buffer), GFP_KERNEL);
-	if (!priv->tx_ring)
+	dma->tx_ring = kcalloc(tx_descs, sizeof(struct altera_dma_private), GFP_KERNEL);
+	if (!dma->tx_ring)
 		goto err_tx_ring;

-	priv->tx_cons = 0;
-	priv->tx_prod = 0;
+	dma->tx_cons = 0;
+	dma->tx_prod = 0;

 	/* Init Rx ring */
 	for (i = 0; i < rx_descs; i++) {
-		ret = tse_init_rx_buffer(priv, &priv->rx_ring[i],
-					 priv->rx_dma_buf_sz);
+		ret = tse_init_rx_buffer(priv, &priv->dma_priv.rx_ring[i], dma->rx_dma_buf_sz);
 		if (ret)
 			goto err_init_rx_buffers;
 	}

-	priv->rx_cons = 0;
-	priv->rx_prod = 0;
+	dma->rx_cons = 0;
+	dma->rx_prod = 0;

 	return 0;
 err_init_rx_buffers:
 	while (--i >= 0)
-		tse_free_rx_buffer(priv, &priv->rx_ring[i]);
-	kfree(priv->tx_ring);
+		tse_free_rx_buffer(priv, &priv->dma_priv.rx_ring[i]);
+	kfree(dma->tx_ring);
 err_tx_ring:
-	kfree(priv->rx_ring);
+	kfree(dma->rx_ring);
 err_rx_ring:
 	return ret;
 }
@@ -295,36 +299,38 @@ static int alloc_init_skbufs(struct altera_tse_private *priv)
 static void free_skbufs(struct net_device *dev)
 {
 	struct altera_tse_private *priv = netdev_priv(dev);
-	unsigned int rx_descs = priv->rx_ring_size;
-	unsigned int tx_descs = priv->tx_ring_size;
+	struct altera_dma_private *dma = &priv->dma_priv;
+	unsigned int rx_descs = dma->rx_ring_size;
+	unsigned int tx_descs = dma->tx_ring_size;
 	int i;

 	/* Release the DMA TX/RX socket buffers */
 	for (i = 0; i < rx_descs; i++)
-		tse_free_rx_buffer(priv, &priv->rx_ring[i]);
+		tse_free_rx_buffer(priv, &priv->dma_priv.rx_ring[i]);
 	for (i = 0; i < tx_descs; i++)
-		tse_free_tx_buffer(priv, &priv->tx_ring[i]);
+		tse_free_tx_buffer(priv, &priv->dma_priv.tx_ring[i]);


-	kfree(priv->tx_ring);
+	kfree(dma->tx_ring);
 }

 /* Reallocate the skb for the reception process
  */
 static inline void tse_rx_refill(struct altera_tse_private *priv)
 {
-	unsigned int rxsize = priv->rx_ring_size;
+	struct altera_dma_private *dma = &priv->dma_priv;
+	unsigned int rxsize = dma->rx_ring_size;
 	unsigned int entry;
 	int ret;

-	for (; priv->rx_cons - priv->rx_prod > 0; priv->rx_prod++) {
-		entry = priv->rx_prod % rxsize;
-		if (likely(priv->rx_ring[entry].skb == NULL)) {
-			ret = tse_init_rx_buffer(priv, &priv->rx_ring[entry],
-				priv->rx_dma_buf_sz);
+	for (; dma->rx_cons - dma->rx_prod > 0; dma->rx_prod++) {
+		entry = dma->rx_prod % rxsize;
+		if (likely(dma->rx_ring[entry].skb == NULL)) {
+			ret = tse_init_rx_buffer(priv, &priv->dma_priv.rx_ring[entry],
+						 dma->rx_dma_buf_sz);
 			if (unlikely(ret != 0))
 				break;
-			priv->dmaops->add_rx_desc(priv, &priv->rx_ring[entry]);
+			priv->dmaops->add_rx_desc(&priv->dma_priv, &priv->dma_priv.rx_ring[entry]);
 		}
 	}
 }
@@ -349,7 +355,8 @@ static inline void tse_rx_vlan(struct net_device *dev, struct sk_buff *skb)
  */
 static int tse_rx(struct altera_tse_private *priv, int limit)
 {
-	unsigned int entry = priv->rx_cons % priv->rx_ring_size;
+	struct altera_dma_private *dma = &priv->dma_priv;
+	unsigned int entry = dma->rx_cons % dma->rx_ring_size;
 	unsigned int next_entry;
 	unsigned int count = 0;
 	struct sk_buff *skb;
@@ -363,7 +370,7 @@ static int tse_rx(struct altera_tse_private *priv, int limit)
 	* (reading the last byte of the response pops the value from the fifo.)
 	*/
 	while ((count < limit) &&
-	       ((rxstatus = priv->dmaops->get_rx_status(priv)) != 0)) {
+	       ((rxstatus = priv->dmaops->get_rx_status(&priv->dma_priv)) != 0)) {
 		pktstatus = rxstatus >> 16;
 		pktlength = rxstatus & 0xffff;

@@ -379,9 +386,9 @@ static int tse_rx(struct altera_tse_private *priv, int limit)
 		pktlength -= 2;

 		count++;
-		next_entry = (++priv->rx_cons) % priv->rx_ring_size;
+		next_entry = (++dma->rx_cons) % dma->rx_ring_size;

-		skb = priv->rx_ring[entry].skb;
+		skb = dma->rx_ring[entry].skb;
 		if (unlikely(!skb)) {
 			netdev_err(priv->dev,
 				   "%s: Inconsistent Rx descriptor chain\n",
@@ -389,12 +396,12 @@ static int tse_rx(struct altera_tse_private *priv, int limit)
 			priv->dev->stats.rx_dropped++;
 			break;
 		}
-		priv->rx_ring[entry].skb = NULL;
+		dma->rx_ring[entry].skb = NULL;

 		skb_put(skb, pktlength);

-		dma_unmap_single(priv->device, priv->rx_ring[entry].dma_addr,
-				 priv->rx_ring[entry].len, DMA_FROM_DEVICE);
+		dma_unmap_single(priv->device, dma->rx_ring[entry].dma_addr,
+				 dma->rx_ring[entry].len, DMA_FROM_DEVICE);

 		if (netif_msg_pktdata(priv)) {
 			netdev_info(priv->dev, "frame received %d bytes\n",
@@ -425,30 +432,31 @@ static int tse_rx(struct altera_tse_private *priv, int limit)
  */
 static int tse_tx_complete(struct altera_tse_private *priv)
 {
-	unsigned int txsize = priv->tx_ring_size;
-	struct tse_buffer *tx_buff;
+	struct altera_dma_private *dma = &priv->dma_priv;
+	unsigned int txsize = dma->tx_ring_size;
+	struct altera_dma_buffer *tx_buff;
 	unsigned int entry;
 	int txcomplete = 0;
 	u32 ready;

 	spin_lock(&priv->tx_lock);

-	ready = priv->dmaops->tx_completions(priv);
+	ready = priv->dmaops->tx_completions(&priv->dma_priv);

 	/* Free sent buffers */
-	while (ready && (priv->tx_cons != priv->tx_prod)) {
-		entry = priv->tx_cons % txsize;
-		tx_buff = &priv->tx_ring[entry];
+	while (ready && (dma->tx_cons != dma->tx_prod)) {
+		entry = dma->tx_cons % txsize;
+		tx_buff = &priv->dma_priv.tx_ring[entry];

 		if (netif_msg_tx_done(priv))
-			netdev_dbg(priv->dev, "%s: curr %d, dirty %d\n",
-				   __func__, priv->tx_prod, priv->tx_cons);
+			netdev_dbg(priv->dev, "%s: curr %d, dirty %d\n", __func__, dma->tx_prod,
+				   dma->tx_cons);

 		if (likely(tx_buff->skb))
 			priv->dev->stats.tx_packets++;

 		tse_free_tx_buffer(priv, tx_buff);
-		priv->tx_cons++;
+		dma->tx_cons++;

 		txcomplete++;
 		ready--;
@@ -491,8 +499,8 @@ static int tse_poll(struct napi_struct *napi, int budget)
 			   rxcomplete, budget);

 		spin_lock_irqsave(&priv->rxdma_irq_lock, flags);
-		priv->dmaops->enable_rxirq(priv);
-		priv->dmaops->enable_txirq(priv);
+		priv->dmaops->enable_rxirq(&priv->dma_priv);
+		priv->dmaops->enable_txirq(&priv->dma_priv);
 		spin_unlock_irqrestore(&priv->rxdma_irq_lock, flags);
 	}
 	return rxcomplete;
@@ -513,14 +521,14 @@ static irqreturn_t altera_isr(int irq, void *dev_id)

 	spin_lock(&priv->rxdma_irq_lock);
 	/* reset IRQs */
-	priv->dmaops->clear_rxirq(priv);
-	priv->dmaops->clear_txirq(priv);
+	priv->dmaops->clear_rxirq(&priv->dma_priv);
+	priv->dmaops->clear_txirq(&priv->dma_priv);
 	spin_unlock(&priv->rxdma_irq_lock);

 	if (likely(napi_schedule_prep(&priv->napi))) {
 		spin_lock(&priv->rxdma_irq_lock);
-		priv->dmaops->disable_rxirq(priv);
-		priv->dmaops->disable_txirq(priv);
+		priv->dmaops->disable_rxirq(&priv->dma_priv);
+		priv->dmaops->disable_txirq(&priv->dma_priv);
 		spin_unlock(&priv->rxdma_irq_lock);
 		__napi_schedule(&priv->napi);
 	}
@@ -539,10 +547,11 @@ static irqreturn_t altera_isr(int irq, void *dev_id)
 static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct altera_tse_private *priv = netdev_priv(dev);
+	struct altera_dma_private *dma = &priv->dma_priv;
 	unsigned int nopaged_len = skb_headlen(skb);
-	unsigned int txsize = priv->tx_ring_size;
+	unsigned int txsize = dma->tx_ring_size;
 	int nfrags = skb_shinfo(skb)->nr_frags;
-	struct tse_buffer *buffer = NULL;
+	struct altera_dma_buffer *buffer = NULL;
 	netdev_tx_t ret = NETDEV_TX_OK;
 	dma_addr_t dma_addr;
 	unsigned int entry;
@@ -562,8 +571,8 @@ static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}

 	/* Map the first skb fragment */
-	entry = priv->tx_prod % txsize;
-	buffer = &priv->tx_ring[entry];
+	entry = dma->tx_prod % txsize;
+	buffer = &priv->dma_priv.tx_ring[entry];

 	dma_addr = dma_map_single(priv->device, skb->data, nopaged_len,
 				  DMA_TO_DEVICE);
@@ -577,11 +586,11 @@ static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	buffer->dma_addr = dma_addr;
 	buffer->len = nopaged_len;

-	priv->dmaops->tx_buffer(priv, buffer);
+	priv->dmaops->tx_buffer(&priv->dma_priv, buffer);

 	skb_tx_timestamp(skb);

-	priv->tx_prod++;
+	dma->tx_prod++;
 	dev->stats.tx_bytes += skb->len;

 	if (unlikely(tse_tx_avail(priv) <= TXQUEUESTOP_THRESHHOLD)) {
@@ -874,12 +883,13 @@ static void tse_set_rx_mode(struct net_device *dev)
 static int tse_open(struct net_device *dev)
 {
 	struct altera_tse_private *priv = netdev_priv(dev);
+	struct altera_dma_private *dma = &priv->dma_priv;
 	unsigned long flags;
 	int ret = 0;
 	int i;

 	/* Reset and configure TSE MAC and probe associated PHY */
-	ret = priv->dmaops->init_dma(priv);
+	ret = priv->dmaops->init_dma(&priv->dma_priv);
 	if (ret != 0) {
 		netdev_err(dev, "Cannot initialize DMA\n");
 		goto phy_error;
@@ -909,11 +919,11 @@ static int tse_open(struct net_device *dev)
 		goto alloc_skbuf_error;
 	}

-	priv->dmaops->reset_dma(priv);
+	priv->dmaops->reset_dma(&priv->dma_priv);

 	/* Create and initialize the TX/RX descriptors chains. */
-	priv->rx_ring_size = dma_rx_num;
-	priv->tx_ring_size = dma_tx_num;
+	dma->rx_ring_size = dma_rx_num;
+	dma->tx_ring_size = dma_tx_num;
 	ret = alloc_init_skbufs(priv);
 	if (ret) {
 		netdev_err(dev, "DMA descriptors initialization failed\n");
@@ -941,12 +951,12 @@ static int tse_open(struct net_device *dev)

 	/* Enable DMA interrupts */
 	spin_lock_irqsave(&priv->rxdma_irq_lock, flags);
-	priv->dmaops->enable_rxirq(priv);
-	priv->dmaops->enable_txirq(priv);
+	priv->dmaops->enable_rxirq(&priv->dma_priv);
+	priv->dmaops->enable_txirq(&priv->dma_priv);

 	/* Setup RX descriptor chain */
-	for (i = 0; i < priv->rx_ring_size; i++)
-		priv->dmaops->add_rx_desc(priv, &priv->rx_ring[i]);
+	for (i = 0; i < priv->dma_priv.rx_ring_size; i++)
+		priv->dmaops->add_rx_desc(&priv->dma_priv, &priv->dma_priv.rx_ring[i]);

 	spin_unlock_irqrestore(&priv->rxdma_irq_lock, flags);

@@ -960,7 +970,7 @@ static int tse_open(struct net_device *dev)
 	napi_enable(&priv->napi);
 	netif_start_queue(dev);

-	priv->dmaops->start_rxdma(priv);
+	priv->dmaops->start_rxdma(&priv->dma_priv);

 	/* Start MAC Rx/Tx */
 	spin_lock(&priv->mac_cfg_lock);
@@ -993,8 +1003,8 @@ static int tse_shutdown(struct net_device *dev)

 	/* Disable DMA interrupts */
 	spin_lock_irqsave(&priv->rxdma_irq_lock, flags);
-	priv->dmaops->disable_rxirq(priv);
-	priv->dmaops->disable_txirq(priv);
+	priv->dmaops->disable_rxirq(&priv->dma_priv);
+	priv->dmaops->disable_txirq(&priv->dma_priv);
 	spin_unlock_irqrestore(&priv->rxdma_irq_lock, flags);

 	/* Free the IRQ lines */
@@ -1012,13 +1022,13 @@ static int tse_shutdown(struct net_device *dev)
 	 */
 	if (ret)
 		netdev_dbg(dev, "Cannot reset MAC core (error: %d)\n", ret);
-	priv->dmaops->reset_dma(priv);
+	priv->dmaops->reset_dma(&priv->dma_priv);
 	free_skbufs(dev);

 	spin_unlock(&priv->tx_lock);
 	spin_unlock(&priv->mac_cfg_lock);

-	priv->dmaops->uninit_dma(priv);
+	priv->dmaops->uninit_dma(&priv->dma_priv);

 	return 0;
 }
@@ -1133,11 +1143,9 @@ static int altera_tse_probe(struct platform_device *pdev)
 	struct mdio_regmap_config mrc;
 	struct resource *control_port;
 	struct regmap *pcs_regmap;
-	struct resource *dma_res;
 	struct resource *pcs_res;
 	struct mii_bus *pcs_bus;
 	struct net_device *ndev;
-	void __iomem *descmap;
 	int ret = -ENODEV;

 	ndev = alloc_etherdev(sizeof(struct altera_tse_private));
@@ -1150,69 +1158,18 @@ static int altera_tse_probe(struct platform_device *pdev)

 	priv = netdev_priv(ndev);
 	priv->device = &pdev->dev;
+	priv->dma_priv.device = &pdev->dev;
 	priv->dev = ndev;
+	priv->dma_priv.dev = ndev;
 	priv->msg_enable = netif_msg_init(debug, default_msg_level);
+	priv->dma_priv.msg_enable = netif_msg_init(debug, default_msg_level);

 	priv->dmaops = device_get_match_data(&pdev->dev);

-	if (priv->dmaops &&
-	    priv->dmaops->altera_dtype == ALTERA_DTYPE_SGDMA) {
-		/* Get the mapped address to the SGDMA descriptor memory */
-		ret = request_and_map(pdev, "s1", &dma_res, &descmap);
-		if (ret)
-			goto err_free_netdev;
-
-		/* Start of that memory is for transmit descriptors */
-		priv->tx_dma_desc = descmap;
-
-		/* First half is for tx descriptors, other half for tx */
-		priv->txdescmem = resource_size(dma_res)/2;
-
-		priv->txdescmem_busaddr = (dma_addr_t)dma_res->start;
-
-		priv->rx_dma_desc = (void __iomem *)((uintptr_t)(descmap +
-						     priv->txdescmem));
-		priv->rxdescmem = resource_size(dma_res)/2;
-		priv->rxdescmem_busaddr = dma_res->start;
-		priv->rxdescmem_busaddr += priv->txdescmem;
-
-		if (upper_32_bits(priv->rxdescmem_busaddr)) {
-			dev_dbg(priv->device,
-				"SGDMA bus addresses greater than 32-bits\n");
-			ret = -EINVAL;
-			goto err_free_netdev;
-		}
-		if (upper_32_bits(priv->txdescmem_busaddr)) {
-			dev_dbg(priv->device,
-				"SGDMA bus addresses greater than 32-bits\n");
-			ret = -EINVAL;
-			goto err_free_netdev;
-		}
-	} else if (priv->dmaops &&
-		   priv->dmaops->altera_dtype == ALTERA_DTYPE_MSGDMA) {
-		ret = request_and_map(pdev, "rx_resp", &dma_res,
-				      &priv->rx_dma_resp);
-		if (ret)
-			goto err_free_netdev;
-
-		ret = request_and_map(pdev, "tx_desc", &dma_res,
-				      &priv->tx_dma_desc);
-		if (ret)
-			goto err_free_netdev;
-
-		priv->txdescmem = resource_size(dma_res);
-		priv->txdescmem_busaddr = dma_res->start;
-
-		ret = request_and_map(pdev, "rx_desc", &dma_res,
-				      &priv->rx_dma_desc);
-		if (ret)
-			goto err_free_netdev;
-
-		priv->rxdescmem = resource_size(dma_res);
-		priv->rxdescmem_busaddr = dma_res->start;
-
-	} else {
-		ret = -ENODEV;
+	/* Map DMA */
+	ret = altera_eth_dma_probe(pdev, &priv->dma_priv, priv->dmaops->altera_dtype);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot map DMA\n");
 		goto err_free_netdev;
 	}

@@ -1232,18 +1189,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_netdev;

-	/* xSGDMA Rx Dispatcher address space */
-	ret = request_and_map(pdev, "rx_csr", &dma_res,
-			      &priv->rx_dma_csr);
-	if (ret)
-		goto err_free_netdev;
-
-
-	/* xSGDMA Tx Dispatcher address space */
-	ret = request_and_map(pdev, "tx_csr", &dma_res,
-			      &priv->tx_dma_csr);
-	if (ret)
-		goto err_free_netdev;

 	memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
 	memset(&mrc, 0, sizeof(mrc));
@@ -1340,7 +1285,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	/* The DMA buffer size already accounts for an alignment bias
 	 * to avoid unaligned access exceptions for the NIOS processor,
 	 */
-	priv->rx_dma_buf_sz = ALTERA_RXDMABUFFER_SIZE;
+	priv->dma_priv.rx_dma_buf_sz = ALTERA_RXDMABUFFER_SIZE;

 	/* get default MAC address from device tree */
 	ret = of_get_ethdev_address(pdev->dev.of_node, ndev);
@@ -1529,4 +1474,5 @@ module_platform_driver(altera_tse_driver);

 MODULE_AUTHOR("Altera Corporation");
 MODULE_DESCRIPTION("Altera Triple Speed Ethernet MAC driver");
+MODULE_IMPORT_NS(NET_ALTERA);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/ethernet/altera/altera_utils.c b/drivers/net/ethernet/altera/altera_utils.c
index e6a7fc9d8fb1..09a53f879b51 100644
--- a/drivers/net/ethernet/altera/altera_utils.c
+++ b/drivers/net/ethernet/altera/altera_utils.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014 Altera Corporation. All rights reserved
  */

+#include "altera_eth_dma.h"
 #include "altera_tse.h"
 #include "altera_utils.h"

--
2.26.2


