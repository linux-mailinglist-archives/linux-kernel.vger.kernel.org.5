Return-Path: <linux-kernel+bounces-120282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D788D549
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6DF1C25037
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BF223758;
	Wed, 27 Mar 2024 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ItZDHs8O"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291322EF3;
	Wed, 27 Mar 2024 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512153; cv=none; b=T8M1pf62M0fHiKFlnPiiZlH0Afw+afQO1oJhHJQcGzZ0Fu1co56Gs1jGDR4iToSajYoXCpHew69AKQ8MlKR3FKXl4u/98i+muVEbaeEeCPHOgihxZpBlfNxqtjKoTBuzrWzQWRCRIrFgEGa55g2C3T6iaaHWZ5DnSUY+6Nh9E7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512153; c=relaxed/simple;
	bh=a/RRgE2vckIzqOGDcrTA1ID5lK71azclNgLmvRy9DQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nI3QD0+OAjInUzemuo2CWt/nJryD0lPYTATwHM0ERy+N2QX7+IYShzDwedBk9QmBPvl7uJo+vUPh6k/fzQbniU0tBYWw+smbSIhWK6RfDA/xlf7ajxzUHUFFqv5sODJqoUCndzyPdnsSQjeI7Wlmy0T1geWjQdJpnkCk9GW5S3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ItZDHs8O; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cf45ea44ebee11ee935d6952f98a51a9-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ICxoIA3FuYr1cYD4XdF2t3OB6P4d2d4HnenSa4v540g=;
	b=ItZDHs8OLORLKV7fDRPWM24p8HB52Jw/ckBrsNJuM53rrz20vEmVjFRDJlTop2kmBEHDHJy8wSTH50jCH11Xn32u4J9R787Ev4j8n/1q46HM6KqPp1Vuk/PciI2kUhk2fC1CcC2z4uJN6+0WJNGM11KjDaEQZA+6WT2jsPqNPmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8389a201-7cc9-4055-9fb3-f9e6a01557f1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:d288e190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cf45ea44ebee11ee935d6952f98a51a9-20240327
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jianhua.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2111069534; Wed, 27 Mar 2024 12:02:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 12:02:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 12:02:19 +0800
From: Jianhua Lin <jianhua.lin@mediatek.com>
To: <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jianhua Lin
	<jianhua.lin@mediatek.com>
Subject: [PATCH] media: mediatek: jpeg: support 34bits
Date: Wed, 27 Mar 2024 12:01:45 +0800
Message-ID: <20240327040145.7155-1-jianhua.lin@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

the iommu HW supported 34bits iova space(16GB),
but mediatek jpeg enc/dec driver still is 32bit,
then need to set the bit32/bit33 iova to jpeg HW.

Signed-off-by: Jianhua Lin <jianhua.lin@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 13 +++-
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  2 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 59 +++++++++++++++----
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |  1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |  8 +++
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 40 +++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.h  | 11 +++-
 7 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index ac48658e2de4..101245030ac6 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1030,6 +1030,7 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,
+				jpeg->support_34bit,
 				&jpeg_src_buf->dec_param,
 				jpeg_src_buf->bs_size,
 				&bs,
@@ -1317,6 +1318,14 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = of_property_read_u32(pdev->dev.of_node, "mediatek,34bits",
+			&jpeg->support_34bit);
+	if (ret != 0) {
+		dev_info(&pdev->dev, "default for 32bits");
+		jpeg->support_34bit = 0;
+	}
+	dev_info(&pdev->dev, "use 34bits: %d", jpeg->support_34bit);
+
 	if (!jpeg->variant->multi_core) {
 		ret = mtk_jpeg_single_core_init(pdev, jpeg);
 		if (ret) {
@@ -1564,7 +1573,8 @@ static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
 	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
-	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
+	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base,
+			ctx->jpeg->support_34bit);
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
 
 	buf_state = VB2_BUF_STATE_DONE;
@@ -1764,6 +1774,7 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	ctx->total_frame_num++;
 	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
 	mtk_jpeg_dec_set_config(comp_jpeg[hw_id]->reg_base,
+				jpeg->support_34bit,
 				&jpeg_src_buf->dec_param,
 				jpeg_src_buf->bs_size,
 				&bs,
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 8ba6e757e11a..8237c07ac743 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -209,6 +209,7 @@ struct mtk_jpegdec_comp_dev {
  * @reg_decbase:	jpg decode register base addr
  * @dec_hw_dev:	jpg decode hardware device
  * @hw_index:		jpg hw index
+ * @support_34bit:	flag to check if support dma_address 34bit
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -231,6 +232,7 @@ struct mtk_jpeg_dev {
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
 	atomic_t hw_index;
+	u32 support_34bit;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 4a6ee211e18f..cedc12a32927 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -270,7 +270,7 @@ void mtk_jpeg_dec_reset(void __iomem *base)
 EXPORT_SYMBOL_GPL(mtk_jpeg_dec_reset);
 
 static void mtk_jpeg_dec_set_brz_factor(void __iomem *base, u8 yscale_w,
-					u8 yscale_h, u8 uvscale_w, u8 uvscale_h)
+				u8 yscale_h, u8 uvscale_w, u8 uvscale_h)
 {
 	u32 val;
 
@@ -279,23 +279,43 @@ static void mtk_jpeg_dec_set_brz_factor(void __iomem *base, u8 yscale_w,
 	writel(val, base + JPGDEC_REG_BRZ_FACTOR);
 }
 
-static void mtk_jpeg_dec_set_dst_bank0(void __iomem *base, u32 addr_y,
-				       u32 addr_u, u32 addr_v)
+static void mtk_jpeg_dec_set_dst_bank0(void __iomem *base, u32 support_34bit,
+		dma_addr_t addr_y, dma_addr_t addr_u, dma_addr_t addr_v)
 {
+	u32 val;
+
 	mtk_jpeg_verify_align(addr_y, 16, JPGDEC_REG_DEST_ADDR0_Y);
 	writel(addr_y, base + JPGDEC_REG_DEST_ADDR0_Y);
 	mtk_jpeg_verify_align(addr_u, 16, JPGDEC_REG_DEST_ADDR0_U);
 	writel(addr_u, base + JPGDEC_REG_DEST_ADDR0_U);
 	mtk_jpeg_verify_align(addr_v, 16, JPGDEC_REG_DEST_ADDR0_V);
 	writel(addr_v, base + JPGDEC_REG_DEST_ADDR0_V);
+	if (support_34bit) {
+		val = upper_32_bits(addr_y) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR0_Y_EXT);
+		val = upper_32_bits(addr_u) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR0_U_EXT);
+		val = upper_32_bits(addr_v) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR0_V_EXT);
+	}
 }
 
-static void mtk_jpeg_dec_set_dst_bank1(void __iomem *base, u32 addr_y,
-				       u32 addr_u, u32 addr_v)
+static void mtk_jpeg_dec_set_dst_bank1(void __iomem *base, u32 support_34bit,
+		dma_addr_t addr_y, dma_addr_t addr_u, dma_addr_t addr_v)
 {
+	u32 val;
+
 	writel(addr_y, base + JPGDEC_REG_DEST_ADDR1_Y);
 	writel(addr_u, base + JPGDEC_REG_DEST_ADDR1_U);
 	writel(addr_v, base + JPGDEC_REG_DEST_ADDR1_V);
+	if (support_34bit) {
+		val = upper_32_bits(addr_y) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR1_Y_EXT);
+		val = upper_32_bits(addr_u) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR1_U_EXT);
+		val = upper_32_bits(addr_v) & 0x3;
+		writel(val, base + JPGDEC_REG_DEST_ADDR1_V_EXT);
+	}
 }
 
 static void mtk_jpeg_dec_set_mem_stride(void __iomem *base, u32 stride_y,
@@ -322,18 +342,31 @@ static void mtk_jpeg_dec_set_dec_mode(void __iomem *base, u32 mode)
 	writel(mode & 0x03, base + JPGDEC_REG_OPERATION_MODE);
 }
 
-static void mtk_jpeg_dec_set_bs_write_ptr(void __iomem *base, u32 ptr)
+static void mtk_jpeg_dec_set_bs_write_ptr(void __iomem *base,
+				u32 support_34bit, dma_addr_t ptr)
 {
+	u32 val;
+
 	mtk_jpeg_verify_align(ptr, 16, JPGDEC_REG_FILE_BRP);
 	writel(ptr, base + JPGDEC_REG_FILE_BRP);
+	if (support_34bit) {
+		val = upper_32_bits(ptr) & 0x3;
+		writel(val, base + JPGDEC_REG_FILE_BRP_EXT);
+	}
 }
 
-static void mtk_jpeg_dec_set_bs_info(void __iomem *base, u32 addr, u32 size,
-				     u32 bitstream_size)
+static void mtk_jpeg_dec_set_bs_info(void __iomem *base, u32 support_34bit,
+		dma_addr_t addr, u32 size, u32 bitstream_size)
 {
+	u32 val;
+
 	mtk_jpeg_verify_align(addr, 16, JPGDEC_REG_FILE_ADDR);
 	mtk_jpeg_verify_align(size, 128, JPGDEC_REG_FILE_TOTAL_SIZE);
 	writel(addr, base + JPGDEC_REG_FILE_ADDR);
+	if (support_34bit) {
+		val = upper_32_bits(addr) & 0x3;
+		writel(val, base + JPGDEC_REG_FILE_ADDR_EXT);
+	}
 	writel(size, base + JPGDEC_REG_FILE_TOTAL_SIZE);
 	writel(bitstream_size, base + JPGDEC_REG_BIT_STREAM_SIZE);
 }
@@ -404,6 +437,7 @@ static void mtk_jpeg_dec_set_sampling_factor(void __iomem *base, u32 comp_num,
 }
 
 void mtk_jpeg_dec_set_config(void __iomem *base,
+			     u32 support_34bits,
 			     struct mtk_jpeg_dec_param *cfg,
 			     u32 bitstream_size,
 			     struct mtk_jpeg_bs *bs,
@@ -413,8 +447,9 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 	mtk_jpeg_dec_set_dec_mode(base, 0);
 	mtk_jpeg_dec_set_comp0_du(base, cfg->unit_num);
 	mtk_jpeg_dec_set_total_mcu(base, cfg->total_mcu);
-	mtk_jpeg_dec_set_bs_info(base, bs->str_addr, bs->size, bitstream_size);
-	mtk_jpeg_dec_set_bs_write_ptr(base, bs->end_addr);
+	mtk_jpeg_dec_set_bs_info(base, support_34bits, bs->str_addr,
+				       bs->size, bitstream_size);
+	mtk_jpeg_dec_set_bs_write_ptr(base, support_34bits, bs->end_addr);
 	mtk_jpeg_dec_set_du_membership(base, cfg->membership, 1,
 				       (cfg->comp_num == 1) ? 1 : 0);
 	mtk_jpeg_dec_set_comp_id(base, cfg->comp_id[0], cfg->comp_id[1],
@@ -432,9 +467,9 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 				    cfg->mem_stride[1]);
 	mtk_jpeg_dec_set_img_stride(base, cfg->img_stride[0],
 				    cfg->img_stride[1]);
-	mtk_jpeg_dec_set_dst_bank0(base, fb->plane_addr[0],
+	mtk_jpeg_dec_set_dst_bank0(base, support_34bits, fb->plane_addr[0],
 				   fb->plane_addr[1], fb->plane_addr[2]);
-	mtk_jpeg_dec_set_dst_bank1(base, 0, 0, 0);
+	mtk_jpeg_dec_set_dst_bank1(base, support_34bits, 0, 0, 0);
 	mtk_jpeg_dec_set_dma_group(base, cfg->dma_mcu, cfg->dma_group,
 				   cfg->dma_last_mcu);
 	mtk_jpeg_dec_set_pause_mcu_idx(base, cfg->total_mcu);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
index 8c31c6b12417..14c6e6cb387d 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
@@ -71,6 +71,7 @@ int mtk_jpeg_dec_fill_param(struct mtk_jpeg_dec_param *param);
 u32 mtk_jpeg_dec_get_int_status(void __iomem *dec_reg_base);
 u32 mtk_jpeg_dec_enum_result(u32 irq_result);
 void mtk_jpeg_dec_set_config(void __iomem *base,
+			     u32 support_34bits,
 			     struct mtk_jpeg_dec_param *cfg,
 			     u32 bitstream_size,
 			     struct mtk_jpeg_bs *bs,
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
index 27b7711ca341..e94f52de7c69 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
@@ -46,5 +46,13 @@
 #define JPGDEC_REG_INTERRUPT_STATUS	0x0274
 #define JPGDEC_REG_STATUS		0x0278
 #define JPGDEC_REG_BIT_STREAM_SIZE	0x0344
+#define JPGDEC_REG_DEST_ADDR0_Y_EXT	0x0360
+#define JPGDEC_REG_DEST_ADDR0_U_EXT	0x0364
+#define JPGDEC_REG_DEST_ADDR0_V_EXT	0x0368
+#define JPGDEC_REG_DEST_ADDR1_Y_EXT	0x036c
+#define JPGDEC_REG_DEST_ADDR1_U_EXT	0x0370
+#define JPGDEC_REG_DEST_ADDR1_V_EXT	0x0374
+#define JPGDEC_REG_FILE_ADDR_EXT	0x0378
+#define JPGDEC_REG_FILE_BRP_EXT		0x037c
 
 #endif /* _MTK_JPEG_REG_H */
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index f8fa3b841ccf..c0a8730cb108 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -62,9 +62,14 @@ void mtk_jpeg_enc_reset(void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_enc_reset);
 
-u32 mtk_jpeg_enc_get_file_size(void __iomem *base)
+u32 mtk_jpeg_enc_get_file_size(void __iomem *base, u32 support_34bit)
 {
-	return readl(base + JPEG_ENC_DMA_ADDR0) -
+	u32 value = 1;
+
+	if (support_34bit)
+		value = 4;
+
+	return readl(base + JPEG_ENC_DMA_ADDR0) * value -
 	       readl(base + JPEG_ENC_DST_ADDR0);
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_enc_get_file_size);
@@ -75,6 +80,9 @@ void mtk_jpeg_enc_start(void __iomem *base)
 
 	value = readl(base + JPEG_ENC_CTRL);
 	value |= JPEG_ENC_CTRL_INT_EN_BIT | JPEG_ENC_CTRL_ENABLE_BIT;
+	value |= JPEG_ENC_CTRL_RDMA_PADDING_EN;
+	value |= JPEG_ENC_CTRL_RDMA_RIGHT_PADDING_EN;
+	value &= ~JPEG_ENC_CTRL_RDMA_PADDING_0_EN;
 	writel(value, base + JPEG_ENC_CTRL);
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_enc_start);
@@ -84,14 +92,25 @@ void mtk_jpeg_set_enc_src(struct mtk_jpeg_ctx *ctx,  void __iomem *base,
 {
 	int i;
 	dma_addr_t dma_addr;
+	u32 val;
+	u32 support_34bit = ctx->jpeg->support_34bit;
 
 	for (i = 0; i < src_buf->num_planes; i++) {
 		dma_addr = vb2_dma_contig_plane_dma_addr(src_buf, i) +
 			   src_buf->planes[i].data_offset;
-		if (!i)
+		if (!i) {
 			writel(dma_addr, base + JPEG_ENC_SRC_LUMA_ADDR);
-		else
+			if (support_34bit) {
+				val = upper_32_bits(dma_addr) & 0x3;
+				writel(val, base + JPEG_ENC_SRC_LUMA_ADDR_EXT);
+			}
+		} else {
 			writel(dma_addr, base + JPEG_ENC_SRC_CHROMA_ADDR);
+			if (support_34bit) {
+				val = upper_32_bits(dma_addr) & 0x3;
+				writel(val, base + JPEG_ENC_SRC_CHROMA_ADDR_EXT);
+			}
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_src);
@@ -103,6 +122,8 @@ void mtk_jpeg_set_enc_dst(struct mtk_jpeg_ctx *ctx, void __iomem *base,
 	size_t size;
 	u32 dma_addr_offset;
 	u32 dma_addr_offsetmask;
+	u32 val;
+	u32 support_34bit = ctx->jpeg->support_34bit;
 
 	dma_addr = vb2_dma_contig_plane_dma_addr(dst_buf, 0);
 	dma_addr_offset = ctx->enable_exif ? MTK_JPEG_MAX_EXIF_SIZE : 0;
@@ -112,7 +133,15 @@ void mtk_jpeg_set_enc_dst(struct mtk_jpeg_ctx *ctx, void __iomem *base,
 	writel(dma_addr_offset & ~0xf, base + JPEG_ENC_OFFSET_ADDR);
 	writel(dma_addr_offsetmask & 0xf, base + JPEG_ENC_BYTE_OFFSET_MASK);
 	writel(dma_addr & ~0xf, base + JPEG_ENC_DST_ADDR0);
+	if (support_34bit) {
+		val = upper_32_bits(dma_addr) & 0x3;
+		writel(val, base + JPEG_ENC_DEST_ADDR0_EXT);
+	}
 	writel((dma_addr + size) & ~0xf, base + JPEG_ENC_STALL_ADDR0);
+	if (support_34bit) {
+		val = upper_32_bits(dma_addr + size) & 0x3;
+		writel(val, base + JPEG_ENC_STALL_ADDR0_EXT);
+	}
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_dst);
 
@@ -278,7 +307,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
 		dev_warn(jpeg->dev, "Jpg Enc occurs unknown Err.");
 
-	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
+	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base,
+			ctx->jpeg->support_34bit);
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
 	buf_state = VB2_BUF_STATE_DONE;
 	v4l2_m2m_buf_done(src_buf, buf_state);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.h
index 61c60e4e58ea..2f03a1a5de98 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.h
@@ -68,6 +68,15 @@
 #define JPEG_ENC_DCM_CTRL		0x300
 #define JPEG_ENC_CODEC_SEL		0x314
 #define JPEG_ENC_ULTRA_THRES		0x318
+#define JPEG_ENC_SRC_LUMA_ADDR_EXT      0x584
+#define JPEG_ENC_SRC_CHROMA_ADDR_EXT    0x588
+#define JPEG_ENC_Q_TBL_ADDR_EXT         0x58C
+#define JPEG_ENC_DEST_ADDR0_EXT         0x590
+#define JPEG_ENC_STALL_ADDR0_EXT        0x594
+
+#define JPEG_ENC_CTRL_RDMA_PADDING_EN           (1 << 20)
+#define JPEG_ENC_CTRL_RDMA_RIGHT_PADDING_EN     (1 << 29)
+#define JPEG_ENC_CTRL_RDMA_PADDING_0_EN         (1 << 30)
 
 /**
  * struct mtk_jpeg_enc_qlt - JPEG encoder quality data
@@ -80,7 +89,7 @@ struct mtk_jpeg_enc_qlt {
 };
 
 void mtk_jpeg_enc_reset(void __iomem *base);
-u32 mtk_jpeg_enc_get_file_size(void __iomem *base);
+u32 mtk_jpeg_enc_get_file_size(void __iomem *base, u32 support_34bit);
 void mtk_jpeg_enc_start(void __iomem *enc_reg_base);
 void mtk_jpeg_set_enc_src(struct mtk_jpeg_ctx *ctx,  void __iomem *base,
 			  struct vb2_buffer *src_buf);
-- 
2.18.0


