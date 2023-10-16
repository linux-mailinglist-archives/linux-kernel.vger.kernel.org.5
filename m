Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3C7C9FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjJPGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjJPGoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:44:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C8A2;
        Sun, 15 Oct 2023 23:43:58 -0700 (PDT)
X-UUID: 5cd146686bef11eea33bb35ae8d461a2-20231016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IwOkqyzoE6mDo8cw/0FXt9hr2/pYnq8pP5H1PTNxgrA=;
        b=Ux+xXG6tCKjNd3ZhZIWFWjMfL5nll0+qPr93fqvmHWuGmnzC5mfXFV/4Iu4r+Skq/QWReUKZn594iYFKlcJfeLEJUzUiF1K936wcnw6ozn7oaPFP6qhdmN4pQcYjge4dclq2L6sGHIpG1HOzpUeCpkjjK3v7Nofvl2d2Ww6xCVY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:447a1c49-019b-469f-9bb5-bafd0594ea89,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:4ccdf9bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5cd146686bef11eea33bb35ae8d461a2-20231016
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 420164673; Mon, 16 Oct 2023 14:43:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Oct 2023 14:43:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Oct 2023 14:43:47 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 1/7] media: mediatek: vcodec: Getting the chip name of each platform
Date:   Mon, 16 Oct 2023 14:43:40 +0800
Message-ID: <20231016064346.31451-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting the chip name of each platform according to the device
compatible to set different parameter.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 24 +----------------
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       | 26 +++++++++++++++++++
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       | 17 ++++++++++++
 3 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 91ed576d6821..ba742f0e391d 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -208,36 +208,14 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 	return v4l2_m2m_dqbuf(file, ctx->m2m_ctx, buf);
 }
 
-static int mtk_vcodec_dec_get_chip_name(void *priv)
-{
-	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
-	struct device *dev = &ctx->dev->plat_dev->dev;
-
-	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
-		return 8173;
-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"))
-		return 8183;
-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec"))
-		return 8192;
-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
-		return 8195;
-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8186-vcodec-dec"))
-		return 8186;
-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8188-vcodec-dec"))
-		return 8188;
-	else
-		return 8173;
-}
-
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
-	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
 	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
-	snprintf(cap->card, sizeof(cap->card), "MT%d video decoder", platform_name);
+	snprintf(cap->card, sizeof(cap->card), "MT%d video decoder", ctx->dev->chip_name);
 
 	return 0;
 }
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index 0a89ce452ac3..f47c98faf068 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -326,6 +326,26 @@ static const struct v4l2_file_operations mtk_vcodec_fops = {
 	.mmap		= v4l2_m2m_fop_mmap,
 };
 
+static void mtk_vcodec_dec_get_chip_name(struct mtk_vcodec_dec_dev *vdec_dev)
+{
+	struct device *dev = &vdec_dev->plat_dev->dev;
+
+	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8173;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8183;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8192;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8195;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8186-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8186;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8188-vcodec-dec"))
+		vdec_dev->chip_name = MTK_VDEC_MT8188;
+	else
+		vdec_dev->chip_name = MTK_VDEC_INVAL;
+}
+
 static int mtk_vcodec_probe(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dec_dev *dev;
@@ -341,6 +361,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&dev->ctx_list);
 	dev->plat_dev = pdev;
 
+	mtk_vcodec_dec_get_chip_name(dev);
+	if (dev->chip_name == MTK_VDEC_INVAL) {
+		dev_err(&pdev->dev, "Failed to get decoder chip name");
+		return -EINVAL;
+	}
+
 	dev->vdec_pdata = of_device_get_match_data(&pdev->dev);
 	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
 				  &rproc_phandle)) {
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index 7e36b2c69b7d..8f228ba9aa47 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -18,6 +18,19 @@
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
 #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
 
+/*
+ * enum mtk_vcodec_dec_chip_name - Structure used to separate different platform
+ */
+enum mtk_vcodec_dec_chip_name {
+	MTK_VDEC_INVAL = 0,
+	MTK_VDEC_MT8173 = 8173,
+	MTK_VDEC_MT8183 = 8183,
+	MTK_VDEC_MT8186 = 8186,
+	MTK_VDEC_MT8188 = 8188,
+	MTK_VDEC_MT8192 = 8192,
+	MTK_VDEC_MT8195 = 8195,
+};
+
 /*
  * enum mtk_vdec_format_types - Structure used to get supported
  *		  format types according to decoder capability
@@ -249,6 +262,8 @@ struct mtk_vcodec_dec_ctx {
  * @vdec_racing_info: record register value
  * @dec_racing_info_mutex: mutex lock used for inner racing mode
  * @dbgfs: debug log related information
+ *
+ * @chip_name: the chip name used to separate different platform
  */
 struct mtk_vcodec_dec_dev {
 	struct v4l2_device v4l2_dev;
@@ -289,6 +304,8 @@ struct mtk_vcodec_dec_dev {
 	/* Protects access to vdec_racing_info data */
 	struct mutex dec_racing_info_mutex;
 	struct mtk_vcodec_dbgfs dbgfs;
+
+	enum mtk_vcodec_dec_chip_name chip_name;
 };
 
 static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
-- 
2.18.0

