Return-Path: <linux-kernel+bounces-42168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B983FD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA84FB23161
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321984BABE;
	Mon, 29 Jan 2024 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ipRr/bMi"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC83D3AC;
	Mon, 29 Jan 2024 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504615; cv=none; b=i93bu5/NrPLHFxtDCKtKKYQG97Fl/0aG/S7OZ+0TBaYGZnKm25VYXo3TWN/M8SWdpG6tDKY6c0WbniecxXtz7OixY7VM7trVCy1JLhsh2GqOoXURIyobCcQAju0Fm9BoKaH0w6MIhr1ne9c1XSjzGJScoCwJqOFkkpGfqRUO/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504615; c=relaxed/simple;
	bh=1lTCkQTpZN81IgFFc3JD5K/XSqjlUGKctUGfQFoU8vU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7bJu3rimPghXMvA8tW+wUnlzD8xFv4Fu54TUITqj5jDcJReW2WAOAbCHuLXO6AJZRIhIV5bmLuu5QHn4EX2tdCqjczuD/+lONXYUCFb4EgJsVGMLwoPh9qkEAujMlEx1IhOS+EnorgQiztd8zLdXTo/4KvMKmj/a2nThA4irL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ipRr/bMi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4KEj8027114;
	Sun, 28 Jan 2024 21:03:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=PB+N5h7yZv9JTdTdW/MGDW07pdnWyzsKllq+tEyOXQs=; b=ipR
	r/bMiascvm0uxtKc2QDNpjZsaXNDG3TyCqADutNnyGu7sUVpCiHSXtiSnbrHDt59
	mJuopI1A1p3Dkun1WrJELU79Duc1uZ4zqa+9+q2fe0V2gotFqRWQOU1LuHd8E+TG
	BsxN4WvisEcyhZgMFHaeVp4KVrcSGw9D1Zzfm5AKz6Lp5a8hP6WgZ8MwW+qnXRjp
	li/2MmNSstkyGmcfgtkwhjA2CMxk7nE/FhyRSNRpXFbv4tWZnkyxXkUZsoueMdLW
	a7Bo62/7K2BVlpYhP22PGLmKRiiyZ93/KVgJ4iaBxQQITo2UjTIo5Hm9vWzP5DpJ
	iEzs2dJ+CM/1jtoSGeg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vr82d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 21:03:23 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 21:03:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 28 Jan 2024 21:03:22 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id C47603F7045;
	Sun, 28 Jan 2024 21:03:21 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v5 4/8] octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
Date: Sun, 28 Jan 2024 21:02:50 -0800
Message-ID: <20240129050254.3047778-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129050254.3047778-1-srasheed@marvell.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yxvu4NzjFVsaFPMSMzMGaY7YvjBjuSwg
X-Proofpoint-GUID: yxvu4NzjFVsaFPMSMzMGaY7YvjBjuSwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02

Implement Tx/Rx ring resource allocation and cleanup.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V5:
  - No changes

V4: https://lore.kernel.org/all/20240108124213.2966536-5-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20240105203823.2953604-5-srasheed@marvell.com/
  - Moved vfree and vzalloc null pointer casting corrections to this
    patch
  - Corrected return values to follow standard kernel error codes

V2: https://lore.kernel.org/all/20231223134000.2906144-5-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20231221092844.2885872-5-srasheed@marvell.com/

 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 223 +++++++++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_tx.c        | 216 +++++++++++++++++
 2 files changed, 438 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 4f1a8157ce39..330d6e72bc0b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -7,10 +7,198 @@
 
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
+#include <linux/vmalloc.h>
 
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
 
+static void octep_vf_oq_reset_indices(struct octep_vf_oq *oq)
+{
+	oq->host_read_idx = 0;
+	oq->host_refill_idx = 0;
+	oq->refill_count = 0;
+	oq->last_pkt_count = 0;
+	oq->pkts_pending = 0;
+}
+
+/**
+ * octep_vf_oq_fill_ring_buffers() - fill initial receive buffers for Rx ring.
+ *
+ * @oq: Octeon Rx queue data structure.
+ *
+ * Return: 0, if successfully filled receive buffers for all descriptors.
+ *         -ENOMEM, if failed to allocate a buffer or failed to map for DMA.
+ */
+static int octep_vf_oq_fill_ring_buffers(struct octep_vf_oq *oq)
+{
+	struct octep_vf_oq_desc_hw *desc_ring = oq->desc_ring;
+	struct page *page;
+	u32 i;
+
+	for (i = 0; i < oq->max_count; i++) {
+		page = dev_alloc_page();
+		if (unlikely(!page)) {
+			dev_err(oq->dev, "Rx buffer alloc failed\n");
+			goto rx_buf_alloc_err;
+		}
+		desc_ring[i].buffer_ptr = dma_map_page(oq->dev, page, 0,
+						       PAGE_SIZE,
+						       DMA_FROM_DEVICE);
+		if (dma_mapping_error(oq->dev, desc_ring[i].buffer_ptr)) {
+			dev_err(oq->dev,
+				"OQ-%d buffer alloc: DMA mapping error!\n",
+				oq->q_no);
+			goto dma_map_err;
+		}
+		oq->buff_info[i].page = page;
+	}
+
+	return 0;
+
+dma_map_err:
+	put_page(page);
+rx_buf_alloc_err:
+	while (i) {
+		i--;
+		dma_unmap_page(oq->dev, desc_ring[i].buffer_ptr, PAGE_SIZE, DMA_FROM_DEVICE);
+		put_page(oq->buff_info[i].page);
+		oq->buff_info[i].page = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+/**
+ * octep_vf_setup_oq() - Setup a Rx queue.
+ *
+ * @oct: Octeon device private data structure.
+ * @q_no: Rx queue number to be setup.
+ *
+ * Allocate resources for a Rx queue.
+ */
+static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
+{
+	struct octep_vf_oq *oq;
+	u32 desc_ring_size;
+
+	oq = vzalloc(sizeof(*oq));
+	if (!oq)
+		goto create_oq_fail;
+	oct->oq[q_no] = oq;
+
+	oq->octep_vf_dev = oct;
+	oq->netdev = oct->netdev;
+	oq->dev = &oct->pdev->dev;
+	oq->q_no = q_no;
+	oq->max_count = CFG_GET_OQ_NUM_DESC(oct->conf);
+	oq->ring_size_mask = oq->max_count - 1;
+	oq->buffer_size = CFG_GET_OQ_BUF_SIZE(oct->conf);
+	oq->max_single_buffer_size = oq->buffer_size - OCTEP_VF_OQ_RESP_HW_SIZE;
+
+	/* When the hardware/firmware supports additional capabilities,
+	 * additional header is filled-in by Octeon after length field in
+	 * Rx packets. this header contains additional packet information.
+	 */
+	if (oct->fw_info.rx_ol_flags)
+		oq->max_single_buffer_size -= OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
+
+	oq->refill_threshold = CFG_GET_OQ_REFILL_THRESHOLD(oct->conf);
+
+	desc_ring_size = oq->max_count * OCTEP_VF_OQ_DESC_SIZE;
+	oq->desc_ring = dma_alloc_coherent(oq->dev, desc_ring_size,
+					   &oq->desc_ring_dma, GFP_KERNEL);
+
+	if (unlikely(!oq->desc_ring)) {
+		dev_err(oq->dev,
+			"Failed to allocate DMA memory for OQ-%d !!\n", q_no);
+		goto desc_dma_alloc_err;
+	}
+
+	oq->buff_info = vzalloc(oq->max_count * OCTEP_VF_OQ_RECVBUF_SIZE);
+
+	if (unlikely(!oq->buff_info)) {
+		dev_err(&oct->pdev->dev,
+			"Failed to allocate buffer info for OQ-%d\n", q_no);
+		goto buf_list_err;
+	}
+
+	if (octep_vf_oq_fill_ring_buffers(oq))
+		goto oq_fill_buff_err;
+
+	octep_vf_oq_reset_indices(oq);
+	oct->hw_ops.setup_oq_regs(oct, q_no);
+	oct->num_oqs++;
+
+	return 0;
+
+oq_fill_buff_err:
+	vfree(oq->buff_info);
+	oq->buff_info = NULL;
+buf_list_err:
+	dma_free_coherent(oq->dev, desc_ring_size,
+			  oq->desc_ring, oq->desc_ring_dma);
+	oq->desc_ring = NULL;
+desc_dma_alloc_err:
+	vfree(oq);
+	oct->oq[q_no] = NULL;
+create_oq_fail:
+	return -ENOMEM;
+}
+
+/**
+ * octep_vf_oq_free_ring_buffers() - Free ring buffers.
+ *
+ * @oq: Octeon Rx queue data structure.
+ *
+ * Free receive buffers in unused Rx queue descriptors.
+ */
+static void octep_vf_oq_free_ring_buffers(struct octep_vf_oq *oq)
+{
+	struct octep_vf_oq_desc_hw *desc_ring = oq->desc_ring;
+	int  i;
+
+	if (!oq->desc_ring || !oq->buff_info)
+		return;
+
+	for (i = 0; i < oq->max_count; i++)  {
+		if (oq->buff_info[i].page) {
+			dma_unmap_page(oq->dev, desc_ring[i].buffer_ptr,
+				       PAGE_SIZE, DMA_FROM_DEVICE);
+			put_page(oq->buff_info[i].page);
+			oq->buff_info[i].page = NULL;
+			desc_ring[i].buffer_ptr = 0;
+		}
+	}
+	octep_vf_oq_reset_indices(oq);
+}
+
+/**
+ * octep_vf_free_oq() - Free Rx queue resources.
+ *
+ * @oq: Octeon Rx queue data structure.
+ *
+ * Free all resources of a Rx queue.
+ */
+static int octep_vf_free_oq(struct octep_vf_oq *oq)
+{
+	struct octep_vf_device *oct = oq->octep_vf_dev;
+	int q_no = oq->q_no;
+
+	octep_vf_oq_free_ring_buffers(oq);
+
+	vfree(oq->buff_info);
+
+	if (oq->desc_ring)
+		dma_free_coherent(oq->dev,
+				  oq->max_count * OCTEP_VF_OQ_DESC_SIZE,
+				  oq->desc_ring, oq->desc_ring_dma);
+
+	vfree(oq);
+	oct->oq[q_no] = NULL;
+	oct->num_oqs--;
+	return 0;
+}
+
 /**
  * octep_vf_setup_oqs() - setup resources for all Rx queues.
  *
@@ -18,7 +206,27 @@
  */
 int octep_vf_setup_oqs(struct octep_vf_device *oct)
 {
-	return -1;
+	int i, retval = 0;
+
+	oct->num_oqs = 0;
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+		retval = octep_vf_setup_oq(oct, i);
+		if (retval) {
+			dev_err(&oct->pdev->dev,
+				"Failed to setup OQ(RxQ)-%d.\n", i);
+			goto oq_setup_err;
+		}
+		dev_dbg(&oct->pdev->dev, "Successfully setup OQ(RxQ)-%d.\n", i);
+	}
+
+	return 0;
+
+oq_setup_err:
+	while (i) {
+		i--;
+		octep_vf_free_oq(oct->oq[i]);
+	}
+	return retval;
 }
 
 /**
@@ -30,6 +238,10 @@ int octep_vf_setup_oqs(struct octep_vf_device *oct)
  */
 void octep_vf_oq_dbell_init(struct octep_vf_device *oct)
 {
+	int i;
+
+	for (i = 0; i < oct->num_oqs; i++)
+		writel(oct->oq[i]->max_count, oct->oq[i]->pkts_credit_reg);
 }
 
 /**
@@ -39,4 +251,13 @@ void octep_vf_oq_dbell_init(struct octep_vf_device *oct)
  */
 void octep_vf_free_oqs(struct octep_vf_device *oct)
 {
+	int i;
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+		if (!oct->oq[i])
+			continue;
+		octep_vf_free_oq(oct->oq[i]);
+		dev_dbg(&oct->pdev->dev,
+			"Successfully freed OQ(RxQ)-%d.\n", i);
+	}
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
index 232ba479ecf6..1a3e1a651dc4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
@@ -7,10 +7,73 @@
 
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
+#include <linux/vmalloc.h>
 
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
 
+/* Reset various index of Tx queue data structure. */
+static void octep_vf_iq_reset_indices(struct octep_vf_iq *iq)
+{
+	iq->fill_cnt = 0;
+	iq->host_write_index = 0;
+	iq->octep_vf_read_index = 0;
+	iq->flush_index = 0;
+	iq->pkts_processed = 0;
+	iq->pkt_in_done = 0;
+}
+
+/**
+ * octep_vf_iq_free_pending() - Free Tx buffers for pending completions.
+ *
+ * @iq: Octeon Tx queue data structure.
+ */
+static void octep_vf_iq_free_pending(struct octep_vf_iq *iq)
+{
+	struct octep_vf_tx_buffer *tx_buffer;
+	struct skb_shared_info *shinfo;
+	u32 fi = iq->flush_index;
+	struct sk_buff *skb;
+	u8 frags, i;
+
+	while (fi != iq->host_write_index) {
+		tx_buffer = iq->buff_info + fi;
+		skb = tx_buffer->skb;
+
+		fi++;
+		if (unlikely(fi == iq->max_count))
+			fi = 0;
+
+		if (!tx_buffer->gather) {
+			dma_unmap_single(iq->dev, tx_buffer->dma,
+					 tx_buffer->skb->len, DMA_TO_DEVICE);
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
+		/* Scatter/Gather */
+		shinfo = skb_shinfo(skb);
+		frags = shinfo->nr_frags;
+
+		dma_unmap_single(iq->dev,
+				 tx_buffer->sglist[0].dma_ptr[0],
+				 tx_buffer->sglist[0].len[0],
+				 DMA_TO_DEVICE);
+
+		i = 1; /* entry 0 is main skb, unmapped above */
+		while (frags--) {
+			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
+				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+			i++;
+		}
+
+		dev_kfree_skb_any(skb);
+	}
+
+	iq->flush_index = fi;
+	netdev_tx_reset_queue(netdev_get_tx_queue(iq->netdev, iq->q_no));
+}
+
 /**
  * octep_vf_clean_iqs()  - Clean Tx queues to shutdown the device.
  *
@@ -21,6 +84,132 @@
  */
 void octep_vf_clean_iqs(struct octep_vf_device *oct)
 {
+	int i;
+
+	for (i = 0; i < oct->num_iqs; i++) {
+		octep_vf_iq_free_pending(oct->iq[i]);
+		octep_vf_iq_reset_indices(oct->iq[i]);
+	}
+}
+
+/**
+ * octep_vf_setup_iq() - Setup a Tx queue.
+ *
+ * @oct: Octeon device private data structure.
+ * @q_no: Tx queue number to be setup.
+ *
+ * Allocate resources for a Tx queue.
+ */
+static int octep_vf_setup_iq(struct octep_vf_device *oct, int q_no)
+{
+	u32 desc_ring_size, buff_info_size, sglist_size;
+	struct octep_vf_iq *iq;
+	int i;
+
+	iq = vzalloc(sizeof(*iq));
+	if (!iq)
+		goto iq_alloc_err;
+	oct->iq[q_no] = iq;
+
+	iq->octep_vf_dev = oct;
+	iq->netdev = oct->netdev;
+	iq->dev = &oct->pdev->dev;
+	iq->q_no = q_no;
+	iq->max_count = CFG_GET_IQ_NUM_DESC(oct->conf);
+	iq->ring_size_mask = iq->max_count - 1;
+	iq->fill_threshold = CFG_GET_IQ_DB_MIN(oct->conf);
+	iq->netdev_q = netdev_get_tx_queue(iq->netdev, q_no);
+
+	/* Allocate memory for hardware queue descriptors */
+	desc_ring_size = OCTEP_VF_IQ_DESC_SIZE * CFG_GET_IQ_NUM_DESC(oct->conf);
+	iq->desc_ring = dma_alloc_coherent(iq->dev, desc_ring_size,
+					   &iq->desc_ring_dma, GFP_KERNEL);
+	if (unlikely(!iq->desc_ring)) {
+		dev_err(iq->dev,
+			"Failed to allocate DMA memory for IQ-%d\n", q_no);
+		goto desc_dma_alloc_err;
+	}
+
+	/* Allocate memory for hardware SGLIST descriptors */
+	sglist_size = OCTEP_VF_SGLIST_SIZE_PER_PKT *
+		      CFG_GET_IQ_NUM_DESC(oct->conf);
+	iq->sglist = dma_alloc_coherent(iq->dev, sglist_size,
+					&iq->sglist_dma, GFP_KERNEL);
+	if (unlikely(!iq->sglist)) {
+		dev_err(iq->dev,
+			"Failed to allocate DMA memory for IQ-%d SGLIST\n",
+			q_no);
+		goto sglist_alloc_err;
+	}
+
+	/* allocate memory to manage Tx packets pending completion */
+	buff_info_size = OCTEP_VF_IQ_TXBUFF_INFO_SIZE * iq->max_count;
+	iq->buff_info = vzalloc(buff_info_size);
+	if (!iq->buff_info) {
+		dev_err(iq->dev,
+			"Failed to allocate buff info for IQ-%d\n", q_no);
+		goto buff_info_err;
+	}
+
+	/* Setup sglist addresses in tx_buffer entries */
+	for (i = 0; i < CFG_GET_IQ_NUM_DESC(oct->conf); i++) {
+		struct octep_vf_tx_buffer *tx_buffer;
+
+		tx_buffer = &iq->buff_info[i];
+		tx_buffer->sglist =
+			&iq->sglist[i * OCTEP_VF_SGLIST_ENTRIES_PER_PKT];
+		tx_buffer->sglist_dma =
+			iq->sglist_dma + (i * OCTEP_VF_SGLIST_SIZE_PER_PKT);
+	}
+
+	octep_vf_iq_reset_indices(iq);
+	oct->hw_ops.setup_iq_regs(oct, q_no);
+
+	oct->num_iqs++;
+	return 0;
+
+buff_info_err:
+	dma_free_coherent(iq->dev, sglist_size, iq->sglist, iq->sglist_dma);
+sglist_alloc_err:
+	dma_free_coherent(iq->dev, desc_ring_size,
+			  iq->desc_ring, iq->desc_ring_dma);
+desc_dma_alloc_err:
+	vfree(iq);
+	oct->iq[q_no] = NULL;
+iq_alloc_err:
+	return -1;
+}
+
+/**
+ * octep_vf_free_iq() - Free Tx queue resources.
+ *
+ * @iq: Octeon Tx queue data structure.
+ *
+ * Free all the resources allocated for a Tx queue.
+ */
+static void octep_vf_free_iq(struct octep_vf_iq *iq)
+{
+	struct octep_vf_device *oct = iq->octep_vf_dev;
+	u64 desc_ring_size, sglist_size;
+	int q_no = iq->q_no;
+
+	desc_ring_size = OCTEP_VF_IQ_DESC_SIZE * CFG_GET_IQ_NUM_DESC(oct->conf);
+
+	vfree(iq->buff_info);
+
+	if (iq->desc_ring)
+		dma_free_coherent(iq->dev, desc_ring_size,
+				  iq->desc_ring, iq->desc_ring_dma);
+
+	sglist_size = OCTEP_VF_SGLIST_SIZE_PER_PKT *
+		      CFG_GET_IQ_NUM_DESC(oct->conf);
+	if (iq->sglist)
+		dma_free_coherent(iq->dev, sglist_size,
+				  iq->sglist, iq->sglist_dma);
+
+	vfree(iq);
+	oct->iq[q_no] = NULL;
+	oct->num_iqs--;
 }
 
 /**
@@ -30,6 +219,25 @@ void octep_vf_clean_iqs(struct octep_vf_device *oct)
  */
 int octep_vf_setup_iqs(struct octep_vf_device *oct)
 {
+	int i;
+
+	oct->num_iqs = 0;
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+		if (octep_vf_setup_iq(oct, i)) {
+			dev_err(&oct->pdev->dev,
+				"Failed to setup IQ(TxQ)-%d.\n", i);
+			goto iq_setup_err;
+		}
+		dev_dbg(&oct->pdev->dev, "Successfully setup IQ(TxQ)-%d.\n", i);
+	}
+
+	return 0;
+
+iq_setup_err:
+	while (i) {
+		i--;
+		octep_vf_free_iq(oct->iq[i]);
+	}
 	return -1;
 }
 
@@ -40,4 +248,12 @@ int octep_vf_setup_iqs(struct octep_vf_device *oct)
  */
 void octep_vf_free_iqs(struct octep_vf_device *oct)
 {
+	int i;
+
+	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
+		octep_vf_free_iq(oct->iq[i]);
+		dev_dbg(&oct->pdev->dev,
+			"Successfully destroyed IQ(TxQ)-%d.\n", i);
+	}
+	oct->num_iqs = 0;
 }
-- 
2.25.1


