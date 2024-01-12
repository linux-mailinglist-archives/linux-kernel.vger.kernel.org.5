Return-Path: <linux-kernel+bounces-24467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34882BCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E48D1C25098
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351E5DF06;
	Fri, 12 Jan 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aFRe8pWA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B15DF01;
	Fri, 12 Jan 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f94cf632b12b11eea2298b7352fd921d-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1qcdQjBZ56QTpzafWL1QFw5tiD6+cbZEjg74O5FAPTo=;
	b=aFRe8pWAfypydnYqJkIZcT+ALa1vxjZ4v+ax9V7suFPn8MHWq7J0peszdkt35l7Qv4gPEa4SF9dO/bsOXUpfbw6P0znHiviEEJGQ/+sCie/5DWGWMvwer5ifGwaW5le2pSM1vuVEMvALLGJ7rIVLLG6UlXVrByzetN1INYpO9vU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7889b8a9-b305-4718-bf0c-1b679a933ea5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:c7a6182f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f94cf632b12b11eea2298b7352fd921d-20240112
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1870276530; Fri, 12 Jan 2024 17:21:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 17:21:30 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 17:21:29 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, <christian.koenig@amd.com>, Sumit Semwal
	<sumit.semwal@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
	<tjmercier@google.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yong Wu <yong.wu@mediatek.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>, Joakim Bech
	<joakim.bech@linaro.org>, Jeffrey Kardatzke <jkardatzke@google.com>, Pavel
 Machek <pavel@ucw.cz>, Simon Ser <contact@emersion.fr>, Pekka Paalanen
	<ppaalanen@gmail.com>, <jianjiao.zeng@mediatek.com>,
	<kuohong.wang@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH v4 6/7] dma-buf: heaps: restricted_heap_mtk: Add TEE memory service call
Date: Fri, 12 Jan 2024 17:20:13 +0800
Message-ID: <20240112092014.23999-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112092014.23999-1-yong.wu@mediatek.com>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add TEE service call for MediaTek heap. We have a limited number of
hardware entries to protect memory, therefore we cannot protect memory
arbitrarily, and our secure memory management is actually inside OPTEE.

The kernel just tells the TEE what size I want and the TEE will return a
"secure handle"/"secure address". To make the name more general, We call
it "restricted_addr" here. The restricted_addr is a reference to a secure
buffer within TEE. We put it in the sg_dma_address, please see the comment
in code.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/dma-buf/heaps/restricted_heap.c     | 17 ++++
 drivers/dma-buf/heaps/restricted_heap.h     |  3 +
 drivers/dma-buf/heaps/restricted_heap_mtk.c | 93 +++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/restricted_heap.c
index 4e9869ab4a85..148dbf5662c2 100644
--- a/drivers/dma-buf/heaps/restricted_heap.c
+++ b/drivers/dma-buf/heaps/restricted_heap.c
@@ -96,8 +96,23 @@ static struct sg_table *
 restricted_heap_map_dma_buf(struct dma_buf_attachment *attachment, enum dma_data_direction direct)
 {
 	struct restricted_heap_attachment *a = attachment->priv;
+	struct dma_buf *dmabuf = attachment->dmabuf;
+	struct restricted_buffer *restricted_buf = dmabuf->priv;
 	struct sg_table *table = a->table;
 
+	/*
+	 * Technically dma_address refers to the address used by HW, But for restricted buffer
+	 * we don't know its dma_address in kernel, Instead, we may know its restricted address
+	 * which refers to the real buffer in the trusted or secure world. Here use this property
+	 * to save the restricted address, and the user will use it to obtain the real address in
+	 * trusted or secure world.
+	 *
+	 * Note: CONFIG_DMA_API_DEBUG requires this to be aligned with PAGE_SIZE.
+	 */
+	if (restricted_buf->restricted_addr) {
+		sg_dma_address(table->sgl) = restricted_buf->restricted_addr;
+		sg_dma_len(table->sgl) = restricted_buf->size;
+	}
 	return table;
 }
 
@@ -108,6 +123,8 @@ restricted_heap_unmap_dma_buf(struct dma_buf_attachment *attachment, struct sg_t
 	struct restricted_heap_attachment *a = attachment->priv;
 
 	WARN_ON(a->table != table);
+	sg_dma_address(table->sgl) = 0;
+	sg_dma_len(table->sgl) = 0;
 }
 
 static int
diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/heaps/restricted_heap.h
index cf5865f829fc..6c93f6d257dc 100644
--- a/drivers/dma-buf/heaps/restricted_heap.h
+++ b/drivers/dma-buf/heaps/restricted_heap.h
@@ -11,6 +11,9 @@
 struct restricted_buffer {
 	struct dma_heap		*heap;
 	size_t			size;
+
+	/* A reference to a buffer in the trusted or secure world. */
+	u64			restricted_addr;
 };
 
 struct restricted_heap {
diff --git a/drivers/dma-buf/heaps/restricted_heap_mtk.c b/drivers/dma-buf/heaps/restricted_heap_mtk.c
index a5f5365059cd..902add95bb7e 100644
--- a/drivers/dma-buf/heaps/restricted_heap_mtk.c
+++ b/drivers/dma-buf/heaps/restricted_heap_mtk.c
@@ -25,6 +25,27 @@ enum mtk_secure_mem_type {
 	MTK_SECURE_MEMORY_TYPE_CM_TZ	= 1,
 };
 
+enum mtk_secure_buffer_tee_cmd {
+	/*
+	 * Allocate the zeroed secure memory from TEE.
+	 *
+	 * [in]  value[0].a: The buffer size.
+	 *       value[0].b: alignment.
+	 * [in]  value[1].a: enum mtk_secure_mem_type.
+	 * [out] value[3].a: The secure handle.
+	 */
+	MTK_TZCMD_SECMEM_ZALLOC	= 0x10000, /* MTK TEE Command ID Base */
+
+	/*
+	 * Free secure memory.
+	 *
+	 * [in]  value[0].a: The secure handle of this buffer, It's value[3].a of
+	 *                   MTK_TZCMD_SECMEM_ZALLOC.
+	 * [out] value[1].a: return value, 0 means successful, otherwise fail.
+	 */
+	MTK_TZCMD_SECMEM_FREE	= 0x10001,
+};
+
 struct mtk_restricted_heap_data {
 	struct tee_context	*tee_ctx;
 	u32			tee_session;
@@ -74,6 +95,74 @@ static int mtk_tee_session_init(struct mtk_restricted_heap_data *data)
 	return ret;
 }
 
+static int mtk_tee_service_call(struct tee_context *tee_ctx, u32 session,
+				unsigned int command, struct tee_param *params)
+{
+	struct tee_ioctl_invoke_arg arg = {0};
+	int ret;
+
+	arg.num_params = TEE_PARAM_NUM;
+	arg.session = session;
+	arg.func = command;
+
+	ret = tee_client_invoke_func(tee_ctx, &arg, params);
+	if (ret < 0 || arg.ret) {
+		pr_err("%s: cmd %d ret %d:%x.\n", __func__, command, ret, arg.ret);
+		ret = -EOPNOTSUPP;
+	}
+	return ret;
+}
+
+static int mtk_tee_restrict_memory(struct restricted_heap *heap, struct restricted_buffer *buf)
+{
+	struct mtk_restricted_heap_data *data = heap->priv_data;
+	struct tee_param params[TEE_PARAM_NUM] = {0};
+	int ret;
+
+	params[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	params[0].u.value.a = buf->size;
+	params[0].u.value.b = PAGE_SIZE;
+	params[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	params[1].u.value.a = data->mem_type;
+	params[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	params[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	ret = mtk_tee_service_call(data->tee_ctx, data->tee_session,
+				   MTK_TZCMD_SECMEM_ZALLOC, params);
+	if (ret)
+		return -ENOMEM;
+
+	buf->restricted_addr = params[3].u.value.a;
+	return 0;
+}
+
+static void mtk_tee_unrestrict_memory(struct restricted_heap *heap, struct restricted_buffer *buf)
+{
+	struct mtk_restricted_heap_data *data = heap->priv_data;
+	struct tee_param params[TEE_PARAM_NUM] = {0};
+
+	params[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	params[0].u.value.a = buf->restricted_addr;
+	params[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	mtk_tee_service_call(data->tee_ctx, data->tee_session,
+			     MTK_TZCMD_SECMEM_FREE, params);
+	if (params[1].u.value.a)
+		pr_err("%s, Unrestrict buffer(0x%llx) fail(%lld) from TEE.\n",
+		       heap->name, buf->restricted_addr, params[1].u.value.a);
+}
+
+static int
+mtk_restricted_memory_allocate(struct restricted_heap *heap, struct restricted_buffer *buf)
+{
+	/* The memory allocating is within the TEE. */
+	return 0;
+}
+
+static void
+mtk_restricted_memory_free(struct restricted_heap *heap, struct restricted_buffer *buf)
+{
+}
+
 static int mtk_restricted_heap_init(struct restricted_heap *heap)
 {
 	struct mtk_restricted_heap_data *data = heap->priv_data;
@@ -85,6 +174,10 @@ static int mtk_restricted_heap_init(struct restricted_heap *heap)
 
 static const struct restricted_heap_ops mtk_restricted_heap_ops = {
 	.heap_init		= mtk_restricted_heap_init,
+	.memory_alloc		= mtk_restricted_memory_allocate,
+	.memory_free		= mtk_restricted_memory_free,
+	.memory_restrict	= mtk_tee_restrict_memory,
+	.memory_unrestrict	= mtk_tee_unrestrict_memory,
 };
 
 static struct mtk_restricted_heap_data mtk_restricted_heap_data = {
-- 
2.25.1


