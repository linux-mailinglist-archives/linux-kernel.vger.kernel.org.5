Return-Path: <linux-kernel+bounces-105113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08F87D942
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D11F216F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F0FC12;
	Sat, 16 Mar 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k/LSJ+5C"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53692E574;
	Sat, 16 Mar 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710576835; cv=none; b=PzKavr6oIsiw2d6gudGBe77ciukafKjEy/c/ob9sxC3cB5+nfjzCCGUsWfdiYGuAqBwkyolq2vjUdJyhb5eq+xLoh9G/b/IpBw0ONKEC0G1usYVV0IxyuJNhv8J3XYbvI7O2uIbeph5NJ0Q8xrM7n1eeZcR1M/pOBHMUywR+xZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710576835; c=relaxed/simple;
	bh=MG0yFGZd8NGqG68fXGVPGoIIF4RPiMFDjImRupyiJQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UaML/KbE0Y1S27rmVypnTb75bqpovRIdeawKYPk68MKhtZACFZX2gwzL7zKPUUq9KX99giAmCdWNXBrnr7iz9e1A+yiCuhCQ/OkHz4QboFUQKoGIyG1Mb2BIN+0kvDYVSuPMKMd9rp+/QMg/3P8wtk77wsTUuWj4+NPlxVUjRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k/LSJ+5C; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d52b13ee36d11eeb8927bc1f75efef4-20240316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ymrk5mBiwUCU/ytZC04QGRDtL4o+ZcHTqKjjTVEao+s=;
	b=k/LSJ+5CwS6xKfszSqocImu22Twza7pP2Rxvi28l9T/LbZ3BrEc8FkCR8er8PK6kcLuH14q2M1cTL6zxeoYP6gHn9E/5xwxO+hdCb6Hn5KQzaqiUrB/SCd8zwJDfFoiow6YzNDeaGwVb6qXe1ITp49L+wg6NBU27qm938xHTpoM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ce905900-684c-4264-b148-b9df08d4c87e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:931df6ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1d52b13ee36d11eeb8927bc1f75efef4-20240316
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1081411707; Sat, 16 Mar 2024 16:13:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 16 Mar 2024 16:13:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 16 Mar 2024 16:13:45 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
CC: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, Yunfei
 Dong <yunfei.dong@mediatek.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2] media: mediatek: vcodec: add decoder command to support stateless decoder
Date: Sat, 16 Mar 2024 16:13:44 +0800
Message-ID: <20240316081344.4262-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The supported decoder commands are different for stateless and
stateful architecture. Add stateless decoder commands to fix
the v4l2-compliance test error below.

Codec ioctls:
    VIDIOC_ENCODER_CMD returned -1 (Inappropriate ioctl for device)
    VIDIOC_TRY_ENCODER_CMD returned -1 (Inappropriate ioctl for device)
 test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
    VIDIOC_G_ENC_INDEX returned -1 (Inappropriate ioctl for device)
 test VIDIOC_G_ENC_INDEX: OK (Not Supported)
    VIDIOC_DECODER_CMD returned -1 (Invalid argument)
    VIDIOC_TRY_DECODER_CMD returned -1 (Invalid argument)
    VIDIOC_TRY_DECODER_CMD returned -1 (Invalid argument)
    fail: v4l2-test-codecs.cpp(126): ret
 test VIDIOC_(TRY_)DECODER_CMD: FAIL

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
changed with v1:
- remove the static function prefix.
- fix some messages not reasonable.
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index ba742f0e391d..c2b64a528028 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -80,21 +80,18 @@ static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx *ctx,
 	return &ctx->q_data[MTK_Q_DATA_DST];
 }
 
-static int vidioc_try_decoder_cmd(struct file *file, void *priv,
-				struct v4l2_decoder_cmd *cmd)
+static int stateful_try_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
 {
 	return v4l2_m2m_ioctl_try_decoder_cmd(file, priv, cmd);
 }
 
-
-static int vidioc_decoder_cmd(struct file *file, void *priv,
-				struct v4l2_decoder_cmd *cmd)
+static int stateful_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
 {
 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct vb2_queue *src_vq, *dst_vq;
 	int ret;
 
-	ret = vidioc_try_decoder_cmd(file, priv, cmd);
+	ret = stateful_try_decoder_cmd(file, priv, cmd);
 	if (ret)
 		return ret;
 
@@ -128,6 +125,57 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 	return 0;
 }
 
+static int stateless_try_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
+{
+	return v4l2_m2m_ioctl_stateless_try_decoder_cmd(file, priv, cmd);
+}
+
+static int stateless_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
+{
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
+	int ret;
+
+	ret = v4l2_m2m_ioctl_stateless_try_decoder_cmd(file, priv, cmd);
+	if (ret)
+		return ret;
+
+	mtk_v4l2_vdec_dbg(3, ctx, "decoder cmd=%u", cmd->cmd);
+	switch (cmd->cmd) {
+	case V4L2_DEC_CMD_FLUSH:
+		/*
+		 * If the flag of the output buffer is equals V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF,
+		 * this command will prevent dequeueing the capture buffer containing the last
+		 * decoded frame. Or do nothing
+		 */
+		break;
+	default:
+		mtk_v4l2_vdec_err(ctx, "invalid stateless decoder cmd=%u", cmd->cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vidioc_try_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
+{
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
+
+	if (ctx->dev->vdec_pdata->uses_stateless_api)
+		return stateless_try_decoder_cmd(file, priv, cmd);
+
+	return stateful_try_decoder_cmd(file, priv, cmd);
+}
+
+static int vidioc_decoder_cmd(struct file *file, void *priv, struct v4l2_decoder_cmd *cmd)
+{
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
+
+	if (ctx->dev->vdec_pdata->uses_stateless_api)
+		return stateless_decoder_cmd(file, priv, cmd);
+
+	return stateful_decoder_cmd(file, priv, cmd);
+}
+
 void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx)
 {
 	mutex_unlock(&ctx->dev->dec_mutex[ctx->hw_id]);
-- 
2.18.0


