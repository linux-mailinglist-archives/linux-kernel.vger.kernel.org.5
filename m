Return-Path: <linux-kernel+bounces-42093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342E83FC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E131C20C27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545BFC02;
	Mon, 29 Jan 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bivIIOiT"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1D8BF0;
	Mon, 29 Jan 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495525; cv=none; b=HInf8meii5l1WarNZPZg5DvGhCHRnKQRIi0cpdurFalyWs0G/OCWB+IaGMY+wrsZwEZJnkz/X+Y9XEyUIwJgpZQ7o9KElNl/ze//wDTslZhECYDLhsUFsxQPbqqW1UQVMOSJevd8gy6Z4NCJpEdYzyx2cYXRLD2I32aXirdMvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495525; c=relaxed/simple;
	bh=JwvxBmlm+9CVolHkNRXe6O09omli9ELIUSOBEwad/Ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRzwN8onJzcUolP4/t05gEeCdTLONVap9HevEwL7kic72Xq6796JiMrPWSoF1lJqoxZBNRRmSfHAD4uFEVn7FxMWJFfT1zgqFsyI4StIBDiLLAzX7hMaDh+nxJl7EvbaAx5uhzj+fCBceNa9l95KbNP0Z791ProleplKlEXoyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bivIIOiT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92e4e38ebe4e11eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nG4MEfOtjTMFozhR+MMBa06cMwHk78fvnsRUvGipajY=;
	b=bivIIOiTZW8mqQeE8LtWK9mECiyRQDDNfma1AT9C3W21Tl8K/dCImorXDKZyV23Ho2EpLvkKL9L/sN2CnPH1ftTgWb9N+nL4Azas8bVEEEhhZ+kSORh+etJWIETEL8iYiqRHIOCfrac0Wl3jASRf98JhZlbnlw5fHlan2PdEHFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:9f196e97-f054-40df-b937-65e984b85e74,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-24
X-CID-META: VersionHash:6e16cf4,CLOUDID:40533ffe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 92e4e38ebe4e11eea2298b7352fd921d-20240129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1117991193; Mon, 29 Jan 2024 10:31:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 10:31:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 10:31:55 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, Irui
 Wang <irui.wang@mediatek.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,2/2] media: mediatek: vcodec: adding lock to protect encoder context list
Date: Mon, 29 Jan 2024 10:31:53 +0800
Message-ID: <20240129023153.28521-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129023153.28521-1-yunfei.dong@mediatek.com>
References: <20240129023153.28521-1-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The ctx_list will be deleted when scp getting unexpected behavior, then the
ctx_list->next will be NULL, the kernel driver maybe access NULL pointer in
function vpu_enc_ipi_handler when going through each context, then reboot.

Need to add lock to protect the ctx_list to make sure the ctx_list->next isn't
NULL pointer.

'Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")'
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
change in v2:
- fix unlock issue.
---
 .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 4 ++--
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c    | 5 +++++
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h    | 2 ++
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index 9a11a2c24804..8d578b690214 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -73,12 +73,12 @@ static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
 
-	mutex_lock(&dev->dev_mutex);
+	mutex_lock(&dev->dev_ctx_lock);
 	list_for_each_entry(ctx, &dev->ctx_list, list) {
 		ctx->state = MTK_STATE_ABORT;
 		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
 	}
-	mutex_unlock(&dev->dev_mutex);
+	mutex_unlock(&dev->dev_ctx_lock);
 }
 
 static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 6319f24bc714..3cb8a1622222 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -177,7 +177,9 @@ static int fops_vcodec_open(struct file *file)
 	mtk_v4l2_venc_dbg(2, ctx, "Create instance [%d]@%p m2m_ctx=%p ",
 			  ctx->id, ctx, ctx->m2m_ctx);
 
+	mutex_lock(&dev->dev_ctx_lock);
 	list_add(&ctx->list, &dev->ctx_list);
+	mutex_unlock(&dev->dev_ctx_lock);
 
 	mutex_unlock(&dev->dev_mutex);
 	mtk_v4l2_venc_dbg(0, ctx, "%s encoder [%d]", dev_name(&dev->plat_dev->dev),
@@ -212,7 +214,9 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	mutex_lock(&dev->dev_ctx_lock);
 	list_del_init(&ctx->list);
+	mutex_unlock(&dev->dev_ctx_lock);
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
 	return 0;
@@ -294,6 +298,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	mutex_init(&dev->enc_mutex);
 	mutex_init(&dev->dev_mutex);
+	mutex_init(&dev->dev_ctx_lock);
 	spin_lock_init(&dev->irqlock);
 
 	snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
index a042f607ed8d..0bd85d0fb379 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
@@ -178,6 +178,7 @@ struct mtk_vcodec_enc_ctx {
  *
  * @enc_mutex: encoder hardware lock.
  * @dev_mutex: video_device lock
+ * @dev_ctx_lock: the lock of context list
  * @encode_workqueue: encode work queue
  *
  * @enc_irq: h264 encoder irq resource
@@ -205,6 +206,7 @@ struct mtk_vcodec_enc_dev {
 	/* encoder hardware mutex lock */
 	struct mutex enc_mutex;
 	struct mutex dev_mutex;
+	struct mutex dev_ctx_lock;
 	struct workqueue_struct *encode_workqueue;
 
 	int enc_irq;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
index 84ad1cc6ad17..51bb7ee141b9 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -47,12 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, struct ven
 	struct mtk_vcodec_enc_ctx *ctx;
 	int ret = false;
 
+	mutex_lock(&enc_dev->dev_ctx_lock);
 	list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
 		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
 			ret = true;
 			break;
 		}
 	}
+	mutex_unlock(&enc_dev->dev_ctx_lock);
 
 	return ret;
 }
-- 
2.18.0


