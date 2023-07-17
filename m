Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E375755E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGQINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGQINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:13:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E60A11F;
        Mon, 17 Jul 2023 01:13:29 -0700 (PDT)
X-UUID: cca7a684247911ee9cb5633481061a41-20230717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U+HorF4LeKiLNz5w8pGzA0k69aZAzTVqZHElBYNhWvo=;
        b=BwBoGDK2gE85ELT8uBv92DoRaJG0WCeu/RnSyZ4mnKR1I1y+AKp0tschm/JKsxj70Hff6/9HnWf2Kb8h3tNs/ECaJNvFkuBfz4U8MxamtrFXEqqdiK2IDFpk0aioIfPNmukMcjBATC0vGsaMgVs1nZdaaVsPdzcds7pucrct5NY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:541827b2-0dde-4382-81dc-8116111618f6,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.28,REQID:541827b2-0dde-4382-81dc-8116111618f6,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:176cd25,CLOUDID:30e7be8e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:2307171613254T7HCBU9,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: cca7a684247911ee9cb5633481061a41-20230717
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1171733526; Mon, 17 Jul 2023 16:13:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jul 2023 16:13:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jul 2023 16:13:21 +0800
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
Subject: [PATCH 2/2] media: mediatek: vcodec: checking encoder ack message parameter
Date:   Mon, 17 Jul 2023 16:13:19 +0800
Message-ID: <20230717081319.12542-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717081319.12542-1-yunfei.dong@mediatek.com>
References: <20230717081319.12542-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to checking all parameters of msg data are valid or not,
in case of access null pointer or unreasonable value leading
to kernel reboot.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/encoder/mtk_vcodec_enc_drv.h       |  2 +
 .../mediatek/vcodec/encoder/venc_vpu_if.c     | 40 +++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
index c07010e56649..a042f607ed8d 100644
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
index 708db1bb32d4..213544e55166 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -42,19 +42,47 @@ static void handle_enc_encode_msg(struct venc_vpu_inst *vpu, const void *data)
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
 
 	mtk_venc_debug(vpu->ctx, "msg_id %x inst %p status %d", msg->msg_id, vpu, msg->status);
 
-	vpu->signaled = 1;
+	enc_dev = (struct mtk_vcodec_enc_dev *)priv;
+	vpu = (struct venc_vpu_inst *)(unsigned long)msg->venc_inst;
+	if (!priv || !vpu) {
+		mtk_v4l2_venc_err(vpu->ctx, "venc_inst is NULL, did the SCP hang or crash?");
+		return;
+	}
+
+	if (!vpu_enc_check_ap_inst(enc_dev, vpu) || msg->msg_id < VPU_IPIMSG_ENC_INIT_DONE ||
+	    msg->msg_id > VPU_IPIMSG_ENC_DEINIT_DONE) {
+		mtk_v4l2_venc_err(vpu->ctx, "venc msg id not correctly => 0x%x", msg->msg_id);
+		vpu->failure = -EINVAL;
+		goto error;
+	}
+
 	vpu->failure = (msg->status != VENC_IPI_MSG_STATUS_OK);
 	if (vpu->failure) {
 		mtk_venc_err(vpu->ctx, "vpu enc status failure %d", vpu->failure);
-		return;
+		goto error;
 	}
 
 	switch (msg->msg_id) {
@@ -72,6 +100,9 @@ static void vpu_enc_ipi_handler(void *data, unsigned int len, void *priv)
 		mtk_venc_err(vpu->ctx, "unknown msg id %x", msg->msg_id);
 		break;
 	}
+
+error:
+	vpu->signaled = 1;
 }
 
 static int vpu_enc_send_msg(struct venc_vpu_inst *vpu, void *msg,
@@ -105,6 +136,7 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 	init_waitqueue_head(&vpu->wq_hd);
 	vpu->signaled = 0;
 	vpu->failure = 0;
+	vpu->ctx->vpu_inst = vpu;
 
 	status = mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler, vpu->id,
 					    vpu_enc_ipi_handler, "venc", NULL);
-- 
2.18.0

