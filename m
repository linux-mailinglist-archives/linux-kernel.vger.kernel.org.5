Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A7767C02
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjG2Drv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG2Drs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:47:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5A1BF4;
        Fri, 28 Jul 2023 20:47:45 -0700 (PDT)
X-UUID: a9a41ef42dc211eeb20a276fd37b9834-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VEEwb4tnPlSsH6KiOPFjEFlmYoO7OdGBRVj4QRhhkX8=;
        b=QWcKjRfNKBgRomPpJKTqceViG5ZSiTlcPlAFn3LxWgOtT6QFfNirfFOYXmOxwpPGsxnuS8HdMrP6M9Rqop7fjMafY2oTWSf7TivQoN23VRJmIAmwEpWw1g4ZK27UpoEoDrJ+NO/R96uBgjVVZFNbSkstxJ6kMC1kiXh3m6cuzto=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:38872fc2-1c6e-4c2c-8807-fa4d6781310a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:38872fc2-1c6e-4c2c-8807-fa4d6781310a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:314b73d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:23072911474039E37PVW,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: a9a41ef42dc211eeb20a276fd37b9834-20230729
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 652089822; Sat, 29 Jul 2023 11:47:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 11:47:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 11:47:36 +0800
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
        "Steve Cho" <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,2/2] media: mediatek: vcodec: Fix possible invalid memory access for encoder
Date:   Sat, 29 Jul 2023 11:47:35 +0800
Message-ID: <20230729034735.17213-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729034735.17213-1-yunfei.dong@mediatek.com>
References: <20230729034735.17213-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpu maybe null pointer or unreasonable value when scp crash, need to
validate that the vpu pointer and the vpu instance within this context is
valid in case of leading to kernel reboot.

Fixes: 27a274db6b4c6 ("[media] vcodec: mediatek: Add Mediatek VP8 Video Encoder Driver")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reported-by: Steve Cho <stevecho@google.com>
---
 .../vcodec/encoder/mtk_vcodec_enc_drv.h       |  2 +
 .../mediatek/vcodec/encoder/venc_vpu_if.c     | 39 +++++++++++++++++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
index c07010e566492..a042f607ed8d1 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
@@ -123,6 +123,7 @@ struct mtk_enc_params {
  * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
  *
  * @q_mutex: vb2_queue mutex.
+ * @vpu_inst: vpu instance pointer.
  */
 struct mtk_vcodec_enc_ctx {
 	enum mtk_instance_type type;
@@ -156,6 +157,7 @@ struct mtk_vcodec_enc_ctx {
 	enum v4l2_xfer_func xfer_func;
 
 	struct mutex q_mutex;
+	void *vpu_inst;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
index 708db1bb32d44..b10f3544b2411 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -42,19 +42,46 @@ static void handle_enc_encode_msg(struct venc_vpu_inst *vpu, const void *data)
 	vpu->is_key_frm = msg->is_key_frm;
 }
 
+static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, struct venc_vpu_inst *vpu)
+{
+	struct mtk_vcodec_enc_ctx *ctx;
+	int ret = false;
+
+	list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
+		if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst == vpu) {
+			ret = true;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
 {
+	struct mtk_vcodec_enc_dev *enc_dev;
 	const struct venc_vpu_ipi_msg_common *msg = data;
-	struct venc_vpu_inst *vpu =
-		(struct venc_vpu_inst *)(unsigned long)msg->venc_inst;
+	struct venc_vpu_inst *vpu;
+
+	enc_dev = (struct mtk_vcodec_enc_dev *)priv;
+	vpu = (struct venc_vpu_inst *)(unsigned long)msg->venc_inst;
+	if (!priv || !vpu) {
+		mtk_v4l2_venc_err(vpu->ctx, "venc_inst is NULL, did the SCP hang or crash?");
+		return;
+	}
 
 	mtk_venc_debug(vpu->ctx, "msg_id %x inst %p status %d", msg->msg_id, vpu, msg->status);
+	if (!vpu_enc_check_ap_inst(enc_dev, vpu) || msg->msg_id < VPU_IPIMSG_ENC_INIT_DONE ||
+	    msg->msg_id > VPU_IPIMSG_ENC_DEINIT_DONE) {
+		mtk_v4l2_venc_err(vpu->ctx, "venc msg id not correctly => 0x%x", msg->msg_id);
+		vpu->failure = -EINVAL;
+		goto error;
+	}
 
-	vpu->signaled = 1;
 	vpu->failure = (msg->status != VENC_IPI_MSG_STATUS_OK);
 	if (vpu->failure) {
 		mtk_venc_err(vpu->ctx, "vpu enc status failure %d", vpu->failure);
-		return;
+		goto error;
 	}
 
 	switch (msg->msg_id) {
@@ -72,6 +99,9 @@ static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
 		mtk_venc_err(vpu->ctx, "unknown msg id %x", msg->msg_id);
 		break;
 	}
+
+error:
+	vpu->signaled = 1;
 }
 
 static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
@@ -105,6 +135,7 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 	init_waitqueue_head(&vpu->wq_hd);
 	vpu->signaled = 0;
 	vpu->failure = 0;
+	vpu->ctx->vpu_inst = vpu;
 
 	status = mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler, vpu->id,
 					    vpu_enc_ipi_handler, "venc", NULL);
-- 
2.18.0

