Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A430F767BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbjG2C4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjG2Czj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:55:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308049F5;
        Fri, 28 Jul 2023 19:55:31 -0700 (PDT)
X-UUID: 5dd880482dbb11eeb20a276fd37b9834-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6s4aflXGgFta4Fl5H1e9PSkWjjGr3OC6BJjbc2J9DJQ=;
        b=ofX861//FWGRN1nWU60hMUcjiqyPPrvQ02X0/PXMx59quxCAbg1Bct/6a/i6Ol8nTesFSf4qKUEFGhx22zb+TT9mHLmmBsqa0KTA/2GC15E/sahoSsUXzQc3l/bq5gpimwv9SDfHhLFsMeQ7hsbWYTNop6NxNKCAhXlPQBOfg3A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:e09bdc14-ec1f-4c49-9d09-a8496a019d7e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.30,REQID:e09bdc14-ec1f-4c49-9d09-a8496a019d7e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:1fcc6f8,CLOUDID:a284a7a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230729105527VICN1KGH,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 5dd880482dbb11eeb20a276fd37b9834-20230729
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 892375271; Sat, 29 Jul 2023 10:55:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:55:23 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:55:22 +0800
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
Subject: [PATCH v8,07/11] media: mediatek: vcodec: separate struct 'mtk_vcodec_ctx'
Date:   Sat, 29 Jul 2023 10:55:10 +0800
Message-ID: <20230729025515.16029-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729025515.16029-1-yunfei.dong@mediatek.com>
References: <20230729025515.16029-1-yunfei.dong@mediatek.com>
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

Adding different context struct for encoder and decoder and removing
struct 'mtk_vcodec_ctx'.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_cmn_drv.h      |  76 +++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |   6 +-
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  10 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c |  60 ++--
 .../platform/mediatek/vcodec/mtk_vcodec_dec.h |  10 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  10 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.h      | 156 ++++++++++
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_hw.h       |   2 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |   8 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |  28 +-
 .../vcodec/mtk_vcodec_dec_stateless.c         |  22 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 269 +-----------------
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c |  78 ++---
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  12 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  10 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.h      | 148 ++++++++++
 .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  35 ++-
 .../mediatek/vcodec/mtk_vcodec_intr.c         |  33 ++-
 .../mediatek/vcodec/mtk_vcodec_intr.h         |   3 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  14 +-
 .../mediatek/vcodec/mtk_vcodec_util.h         |  10 +-
 .../vcodec/vdec/vdec_av1_req_lat_if.c         |  22 +-
 .../mediatek/vcodec/vdec/vdec_h264_if.c       |   6 +-
 .../vcodec/vdec/vdec_h264_req_common.c        |   4 +-
 .../vcodec/vdec/vdec_h264_req_common.h        |   4 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |   8 +-
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |  10 +-
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  16 +-
 .../mediatek/vcodec/vdec/vdec_vp8_if.c        |   4 +-
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  10 +-
 .../mediatek/vcodec/vdec/vdec_vp9_if.c        |   8 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  18 +-
 .../platform/mediatek/vcodec/vdec_drv_base.h  |   2 +-
 .../platform/mediatek/vcodec/vdec_drv_if.c    |   8 +-
 .../platform/mediatek/vcodec/vdec_drv_if.h    |   8 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c |   8 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  10 +-
 .../platform/mediatek/vcodec/vdec_vpu_if.h    |   4 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       |  12 +-
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   8 +-
 .../platform/mediatek/vcodec/venc_drv_base.h  |   2 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |  14 +-
 .../platform/mediatek/vcodec/venc_drv_if.h    |   8 +-
 .../platform/mediatek/vcodec/venc_vpu_if.h    |   2 +-
 46 files changed, 688 insertions(+), 516 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
new file mode 100644
index 000000000000..3b6e1faf60ce
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_COM_DRV_H_
+#define _MTK_VCODEC_COM_DRV_H_
+
+#include <linux/platform_device.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/videobuf2-core.h>
+
+#define MTK_VCODEC_MAX_PLANES	3
+
+/**
+ * enum mtk_instance_state - The state of an MTK Vcodec instance.
+ * @MTK_STATE_FREE: default state when instance is created
+ * @MTK_STATE_INIT: vcodec instance is initialized
+ * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
+ *			had sps/pps header encoded
+ * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
+ * @MTK_STATE_ABORT: vcodec should be aborted
+ */
+enum mtk_instance_state {
+	MTK_STATE_FREE = 0,
+	MTK_STATE_INIT = 1,
+	MTK_STATE_HEADER = 2,
+	MTK_STATE_FLUSH = 3,
+	MTK_STATE_ABORT = 4,
+};
+
+enum mtk_fmt_type {
+	MTK_FMT_DEC = 0,
+	MTK_FMT_ENC = 1,
+	MTK_FMT_FRAME = 2,
+};
+
+/*
+ * struct mtk_video_fmt - Structure used to store information about pixelformats
+ */
+struct mtk_video_fmt {
+	u32	fourcc;
+	enum mtk_fmt_type	type;
+	u32	num_planes;
+	u32	flags;
+	struct v4l2_frmsize_stepwise frmsize;
+};
+
+/*
+ * struct mtk_q_data - Structure used to store information about queue
+ */
+struct mtk_q_data {
+	unsigned int	visible_width;
+	unsigned int	visible_height;
+	unsigned int	coded_width;
+	unsigned int	coded_height;
+	enum v4l2_field	field;
+	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
+	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
+	const struct mtk_video_fmt	*fmt;
+};
+
+/*
+ * enum mtk_instance_type - The type of an MTK Vcodec instance.
+ */
+enum mtk_instance_type {
+	MTK_INST_DECODER		= 0,
+	MTK_INST_ENCODER		= 1,
+};
+
+#endif /* _MTK_VCODEC_COM_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 6957105492ae..95fd51817b8e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -10,7 +10,7 @@
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
 
-static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_ctx *ctx, char *buf,
+static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ctx, char *buf,
 					   int *used, int total)
 {
 	int curr_len;
@@ -91,7 +91,7 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int total_len = 200 * (dbgfs->inst_count == 0 ? 1 : dbgfs->inst_count);
 	int used_len = 0, curr_len, ret;
 	bool dbgfs_index[MTK_VDEC_DBGFS_MAX] = {0};
@@ -143,7 +143,7 @@ static const struct file_operations vdec_fops = {
 	.read = mtk_vdec_dbgfs_read,
 };
 
-void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
 	struct mtk_vcodec_dev *vcodec_dev = ctx->dev;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 241ff8197e73..372413d590c5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -8,7 +8,7 @@
 #define __MTK_VCODEC_DBGFS_H__
 
 struct mtk_vcodec_dev;
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 
 /*
  * enum mtk_vdec_dbgfs_log_index  - used to get different debug information
@@ -22,12 +22,12 @@ enum mtk_vdec_dbgfs_log_index {
 /**
  * struct mtk_vcodec_dbgfs_inst  - debugfs information for each inst
  * @node:       list node for each inst
- * @vcodec_ctx: struct mtk_vcodec_ctx
+ * @vcodec_ctx: struct mtk_vcodec_dec_ctx
  * @inst_id:    index of the context that the same with ctx->id
  */
 struct mtk_vcodec_dbgfs_inst {
 	struct list_head node;
-	struct mtk_vcodec_ctx *vcodec_ctx;
+	struct mtk_vcodec_dec_ctx *vcodec_ctx;
 	int inst_id;
 };
 
@@ -50,12 +50,12 @@ struct mtk_vcodec_dbgfs {
 };
 
 #if defined(CONFIG_DEBUG_FS)
-void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx);
 void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
 void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode);
 void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
 #else
-static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_ctx *ctx)
+static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 269f90fe0a1a..619ff3dd8d50 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -35,7 +35,7 @@ mtk_vdec_find_format(struct v4l2_format *f,
 	return NULL;
 }
 
-static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
+static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_dec_ctx *ctx, int format_index)
 {
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
@@ -55,7 +55,7 @@ static bool mtk_vdec_get_cap_fmt(struct mtk_vcodec_ctx *ctx, int format_index)
 	return false;
 }
 
-static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_ctx *ctx,
+static struct mtk_q_data *mtk_vdec_get_q_data(struct mtk_vcodec_dec_ctx *ctx,
 					      enum v4l2_buf_type type)
 {
 	if (V4L2_TYPE_IS_OUTPUT(type))
@@ -74,7 +74,7 @@ static int vidioc_try_decoder_cmd(struct file *file, void *priv,
 static int vidioc_decoder_cmd(struct file *file, void *priv,
 				struct v4l2_decoder_cmd *cmd)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct vb2_queue *src_vq, *dst_vq;
 	int ret;
 
@@ -112,23 +112,23 @@ static int vidioc_decoder_cmd(struct file *file, void *priv,
 	return 0;
 }
 
-void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx)
+void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx)
 {
 	mutex_unlock(&ctx->dev->dec_mutex[ctx->hw_id]);
 }
 
-void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx)
+void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx)
 {
 	mutex_lock(&ctx->dev->dec_mutex[ctx->hw_id]);
 }
 
-void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx)
 {
 	vdec_if_deinit(ctx);
 	ctx->state = MTK_STATE_FREE;
 }
 
-void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
@@ -169,7 +169,7 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
 static int vidioc_vdec_qbuf(struct file *file, void *priv,
 			    struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_vdec_err(ctx, "[%d] Call on QBUF after unrecoverable error", ctx->id);
@@ -182,7 +182,7 @@ static int vidioc_vdec_qbuf(struct file *file, void *priv,
 static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 			     struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_vdec_err(ctx, "[%d] Call on DQBUF after unrecoverable error", ctx->id);
@@ -194,7 +194,7 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
 
 static int mtk_vcodec_dec_get_chip_name(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
@@ -216,7 +216,7 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
@@ -229,7 +229,7 @@ static int vidioc_vdec_querycap(struct file *file, void *priv,
 static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 				     const struct v4l2_event_subscription *sub)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(fh);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(fh);
 
 	if (ctx->dev->vdec_pdata->uses_stateless_api)
 		return v4l2_ctrl_subscribe_event(fh, sub);
@@ -244,7 +244,7 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 	}
 }
 
-static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
+static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *ctx, struct v4l2_format *f,
 			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
@@ -312,7 +312,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	fmt = mtk_vdec_find_format(f, dec_pdata);
@@ -330,7 +330,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	fmt = mtk_vdec_find_format(f, dec_pdata);
@@ -351,7 +351,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 static int vidioc_vdec_g_selection(struct file *file, void *priv,
 			struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct mtk_q_data *q_data;
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
@@ -400,7 +400,7 @@ static int vidioc_vdec_g_selection(struct file *file, void *priv,
 static int vidioc_vdec_s_selection(struct file *file, void *priv,
 				struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -422,7 +422,7 @@ static int vidioc_vdec_s_selection(struct file *file, void *priv,
 static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct v4l2_pix_format_mplane *pix_mp;
 	struct mtk_q_data *q_data;
 	int ret = 0;
@@ -552,7 +552,7 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 				struct v4l2_frmsizeenum *fsize)
 {
 	int i = 0;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 
 	if (fsize->index != 0)
@@ -584,7 +584,7 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 static int vidioc_enum_fmt(struct v4l2_fmtdesc *f, void *priv,
 			   bool output_queue)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
 	int i, j = 0;
@@ -630,7 +630,7 @@ static int vidioc_vdec_enum_fmt_vid_out(struct file *file, void *priv,
 static int vidioc_vdec_g_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data;
@@ -719,7 +719,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 			    unsigned int *nplanes, unsigned int sizes[],
 			    struct device *alloc_devs[])
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vq);
 	struct mtk_q_data *q_data;
 	unsigned int i;
 
@@ -761,7 +761,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 
 int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_q_data *q_data;
 	int i;
 
@@ -785,7 +785,7 @@ int vb2ops_vdec_buf_prepare(struct vb2_buffer *vb)
 
 void vb2ops_vdec_buf_finish(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct mtk_video_dec_buf *buf;
 	bool buf_error;
@@ -823,7 +823,7 @@ int vb2ops_vdec_buf_init(struct vb2_buffer *vb)
 
 int vb2ops_vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(q);
 
 	if (ctx->state == MTK_STATE_FLUSH)
 		ctx->state = MTK_STATE_HEADER;
@@ -834,7 +834,7 @@ int vb2ops_vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 {
 	struct vb2_v4l2_buffer *src_buf = NULL, *dst_buf = NULL;
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(q);
 	int ret;
 
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) state=(%x) ctx->decoded_frame_cnt=%d",
@@ -889,7 +889,7 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 
 static void m2mops_vdec_device_run(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
 	queue_work(dev->decode_workqueue, &ctx->decode_work);
@@ -897,7 +897,7 @@ static void m2mops_vdec_device_run(void *priv)
 
 static int m2mops_vdec_job_ready(void *m2m_priv)
 {
-	struct mtk_vcodec_ctx *ctx = m2m_priv;
+	struct mtk_vcodec_dec_ctx *ctx = m2m_priv;
 
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d]", ctx->id);
 
@@ -916,7 +916,7 @@ static int m2mops_vdec_job_ready(void *m2m_priv)
 
 static void m2mops_vdec_job_abort(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 
 	ctx->state = MTK_STATE_ABORT;
 }
@@ -964,7 +964,7 @@ const struct v4l2_ioctl_ops mtk_vdec_ioctl_ops = {
 int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 			   struct vb2_queue *dst_vq)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	int ret = 0;
 
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d]", ctx->id);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
index 4572f92826f2..ece27c880e50 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
@@ -11,6 +11,8 @@
 #include <media/videobuf2-core.h>
 #include <media/v4l2-mem2mem.h>
 
+#include "mtk_vcodec_dec_drv.h"
+
 #define VCODEC_DEC_ALIGNED_64 64
 #define VCODEC_CAPABILITY_4K_DISABLED	0x10
 #define VCODEC_DEC_4K_CODED_WIDTH	4096U
@@ -78,12 +80,12 @@ extern const struct mtk_vcodec_dec_pdata mtk_vdec_single_core_pdata;
  * mtk_vdec_lock get decoder hw lock and set curr_ctx
  * to ctx instance that get lock
  */
-void mtk_vdec_unlock(struct mtk_vcodec_ctx *ctx);
-void mtk_vdec_lock(struct mtk_vcodec_ctx *ctx);
+void mtk_vdec_unlock(struct mtk_vcodec_dec_ctx *ctx);
+void mtk_vdec_lock(struct mtk_vcodec_dec_ctx *ctx);
 int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 			   struct vb2_queue *dst_vq);
-void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx);
-void mtk_vcodec_dec_release(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx);
+void mtk_vcodec_dec_release(struct mtk_vcodec_dec_ctx *ctx);
 
 /*
  * VB2 ops
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 69f0a57650fb..d36a05275f11 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -29,7 +29,7 @@
 #include "mtk_vcodec_util.h"
 #include "mtk_vcodec_fw.h"
 
-static int mtk_vcodec_get_hw_count(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_dev *dev)
+static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_dev *dev)
 {
 	switch (dev->vdec_pdata->hw_arch) {
 	case MTK_VDEC_PURE_SINGLE_CORE:
@@ -57,7 +57,7 @@ static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
 static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	unsigned int dec_done_status = 0;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
 					VDEC_IRQ_CFG_REG;
@@ -81,7 +81,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 	writel((readl(vdec_misc_addr) & ~VDEC_IRQ_CLR),
 		dev->reg_base[VDEC_MISC] + VDEC_IRQ_CFG_REG);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 
 	mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=%x", ctx->id, dec_done_status);
 
@@ -194,7 +194,7 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 static int fops_vcodec_open(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	int ret = 0, i, hw_count;
 	struct vb2_queue *src_vq;
 
@@ -291,7 +291,7 @@ static int fops_vcodec_open(struct file *file)
 static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
+	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(file->private_data);
 
 	mtk_v4l2_vdec_dbg(0, ctx, "[%d] decoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
new file mode 100644
index 000000000000..468583a43b7e
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_DEC_DRV_H_
+#define _MTK_VCODEC_DEC_DRV_H_
+
+#include "mtk_vcodec_cmn_drv.h"
+#include "mtk_vcodec_fw_priv.h"
+#include "vdec_msg_queue.h"
+
+/**
+ * struct vdec_pic_info  - picture size information
+ * @pic_w: picture width
+ * @pic_h: picture height
+ * @buf_w: picture buffer width (64 aligned up from pic_w)
+ * @buf_h: picture buffer heiht (64 aligned up from pic_h)
+ * @fb_sz: bitstream size of each plane
+ * E.g. suppose picture size is 176x144,
+ *      buffer size will be aligned to 176x160.
+ * @cap_fourcc: fourcc number(may changed when resolution change)
+ * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
+ */
+struct vdec_pic_info {
+	unsigned int pic_w;
+	unsigned int pic_h;
+	unsigned int buf_w;
+	unsigned int buf_h;
+	unsigned int fb_sz[VIDEO_MAX_PLANES];
+	unsigned int cap_fourcc;
+	unsigned int reserved;
+};
+
+/*
+ * enum mtk_vdec_hw_id - Hardware index used to separate
+ *                         different hardware
+ */
+enum mtk_vdec_hw_id {
+	MTK_VDEC_CORE,
+	MTK_VDEC_LAT0,
+	MTK_VDEC_LAT1,
+	MTK_VDEC_LAT_SOC,
+	MTK_VDEC_HW_MAX,
+};
+
+/**
+ * struct mtk_vcodec_dec_ctx - Context (instance) private data.
+ *
+ * @type: type of decoder instance
+ * @dev: pointer to the mtk_vcodec_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_dev
+ *
+ * @fh: struct v4l2_fh
+ * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
+ * @q_data: store information of input and output queue of the context
+ * @id: index of the context that this structure describes
+ * @state: state of the context
+ *
+ * @dec_if: hooked decoder driver interface
+ * @drv_handle: driver handle for specific decode/encode instance
+ *
+ * @picinfo: store picture info after header parsing
+ * @dpb_size: store dpb count after header parsing
+ *
+ * @int_cond: variable used by the waitqueue
+ * @int_type: type of the last interrupt
+ * @queue: waitqueue that can be used to wait for this context to finish
+ * @irq_status: irq status
+ *
+ * @ctrl_hdl: handler for v4l2 framework
+ * @decode_work: worker for the decoding
+ * @last_decoded_picinfo: pic information get from latest decode
+ * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Used
+ *		     for stateful decoder.
+ * @is_flushing: set to true if flushing is in progress.
+ *
+ * @current_codec: current set input codec, in V4L2 pixel format
+ * @capture_fourcc: capture queue type in V4L2 pixel format
+ *
+ * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
+ * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @quantization: enum v4l2_quantization, colorspace quantization
+ * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
+ *
+ * @decoded_frame_cnt: number of decoded frames
+ * @lock: protect variables accessed by V4L2 threads and worker thread such as
+ *	  mtk_video_dec_buf.
+ * @hw_id: hardware index used to identify different hardware.
+ *
+ * @msg_queue: msg queue used to store lat buffer information.
+ */
+struct mtk_vcodec_dec_ctx {
+	enum mtk_instance_type type;
+	struct mtk_vcodec_dev *dev;
+	struct list_head list;
+
+	struct v4l2_fh fh;
+	struct v4l2_m2m_ctx *m2m_ctx;
+	struct mtk_q_data q_data[2];
+	int id;
+	enum mtk_instance_state state;
+
+	const struct vdec_common_if *dec_if;
+	void *drv_handle;
+
+	struct vdec_pic_info picinfo;
+	int dpb_size;
+
+	int int_cond[MTK_VDEC_HW_MAX];
+	int int_type[MTK_VDEC_HW_MAX];
+	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
+	unsigned int irq_status;
+
+	struct v4l2_ctrl_handler ctrl_hdl;
+	struct work_struct decode_work;
+	struct vdec_pic_info last_decoded_picinfo;
+	struct v4l2_m2m_buffer empty_flush_buf;
+	bool is_flushing;
+
+	u32 current_codec;
+	u32 capture_fourcc;
+
+	enum v4l2_colorspace colorspace;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_xfer_func xfer_func;
+
+	int decoded_frame_cnt;
+	struct mutex lock;
+	int hw_id;
+
+	struct vdec_msg_queue msg_queue;
+};
+
+static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct mtk_vcodec_dec_ctx, fh);
+}
+
+static inline struct mtk_vcodec_dec_ctx *ctrl_to_dec_ctx(struct v4l2_ctrl *ctrl)
+{
+	return container_of(ctrl->handler, struct mtk_vcodec_dec_ctx, ctrl_hdl);
+}
+
+/* Wake up context wait_queue */
+static inline void
+wake_up_dec_ctx(struct mtk_vcodec_dec_ctx *ctx, unsigned int reason, unsigned int hw_id)
+{
+	ctx->int_cond[hw_id] = 1;
+	ctx->int_type[hw_id] = reason;
+	wake_up_interruptible(&ctx->queue[hw_id]);
+}
+
+#endif /* _MTK_VCODEC_DEC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index 4a5b2eca1606..73c25b0c7678 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -66,7 +66,7 @@ static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dev *vdec_dev)
 static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 {
 	struct mtk_vdec_hw_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	u32 cg_status;
 	unsigned int dec_done_status;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_HW_MISC] +
@@ -90,7 +90,7 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 	writel(dec_done_status | VDEC_IRQ_CFG, vdec_misc_addr);
 	writel(dec_done_status & ~VDEC_IRQ_CLR, vdec_misc_addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
+	wake_up_dec_ctx(ctx, MTK_INST_IRQ_RECEIVED, dev->hw_idx);
 
 	mtk_v4l2_vdec_dbg(3, ctx, "wake up ctx %d, dec_done_status=%x",
 			  ctx->id, dec_done_status);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
index ff250e3be78e..696e9eeb03a2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
@@ -49,7 +49,7 @@ struct mtk_vdec_hw_dev {
 	struct mtk_vcodec_dev *main_dev;
 	void __iomem *reg_base[VDEC_HW_MAX];
 
-	struct mtk_vcodec_ctx *curr_ctx;
+	struct mtk_vcodec_dec_ctx *curr_ctx;
 
 	int dec_irq;
 	struct mtk_vcodec_pm pm;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 346eae2a7ef6..fe1813d72336 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -142,7 +142,7 @@ static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_i
 	}
 }
 
-static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_load_racing_info(struct mtk_vcodec_dec_ctx *ctx)
 {
 	void __iomem *vdec_racing_addr;
 	int j;
@@ -156,7 +156,7 @@ static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
 	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
 }
 
-static void mtk_vcodec_record_racing_info(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_record_racing_info(struct mtk_vcodec_dec_ctx *ctx)
 {
 	void __iomem *vdec_racing_addr;
 	int j;
@@ -230,7 +230,7 @@ static void mtk_vcodec_dec_child_dev_off(struct mtk_vcodec_dev *vdec_dev,
 	}
 }
 
-void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	mutex_lock(&ctx->dev->dec_mutex[hw_idx]);
 
@@ -246,7 +246,7 @@ void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dec_enable_hardware);
 
-void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
 		mtk_vcodec_record_racing_info(ctx);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
index dbcf3cabe6f3..f6c68e57bcc1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
@@ -11,7 +11,7 @@
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm);
 
-void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
-void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx);
+void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
+void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
 
 #endif /* _MTK_VCODEC_DEC_PM_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 3c289b08bc87..93230fe7ab97 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -55,7 +55,7 @@ static const unsigned int num_supported_formats =
  * Note the buffers returned from codec driver may still be in driver's
  * reference list.
  */
-static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_fb *disp_frame_buffer = NULL;
 	struct mtk_video_dec_buf *dstbuf;
@@ -98,7 +98,7 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
  * previous sps/pps/resolution change decode, or do nothing if user
  * space still owns this buffer
  */
-static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_video_dec_buf *dstbuf;
 	struct vdec_fb *free_frame_buffer = NULL;
@@ -173,19 +173,19 @@ static struct vb2_buffer *get_free_buffer(struct mtk_vcodec_ctx *ctx)
 	return &vb->vb2_buf;
 }
 
-static void clean_display_buffer(struct mtk_vcodec_ctx *ctx)
+static void clean_display_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	while (get_display_buffer(ctx))
 		;
 }
 
-static void clean_free_buffer(struct mtk_vcodec_ctx *ctx)
+static void clean_free_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	while (get_free_buffer(ctx))
 		;
 }
 
-static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
+static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_dec_ctx *ctx)
 {
 	static const struct v4l2_event ev_src_ch = {
 		.type = V4L2_EVENT_SOURCE_CHANGE,
@@ -196,7 +196,7 @@ static void mtk_vdec_queue_res_chg_event(struct mtk_vcodec_ctx *ctx)
 	v4l2_event_queue_fh(&ctx->fh, &ev_src_ch);
 }
 
-static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
 {
 	bool res_chg;
 	int ret;
@@ -211,7 +211,7 @@ static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
+static void mtk_vdec_update_fmt(struct mtk_vcodec_dec_ctx *ctx,
 				unsigned int pixelformat)
 {
 	const struct mtk_video_fmt *fmt;
@@ -232,7 +232,7 @@ static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
 	mtk_v4l2_vdec_err(ctx, "Cannot get fourcc(%d), using init value", pixelformat);
 }
 
-static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_pic_info_update(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int dpbsize = 0;
 	int ret;
@@ -277,8 +277,8 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
 
 static void mtk_vdec_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx =
-		container_of(work, struct mtk_vcodec_ctx, decode_work);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem buf;
@@ -420,7 +420,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 	bool res_chg = false;
 	int ret;
 	unsigned int dpbsize = 1, i;
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct mtk_q_data *dst_q_data;
 
@@ -528,7 +528,7 @@ static void vb2ops_vdec_stateful_buf_queue(struct vb2_buffer *vb)
 
 static int mtk_vdec_g_v_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct mtk_vcodec_ctx *ctx = ctrl_to_ctx(ctrl);
+	struct mtk_vcodec_dec_ctx *ctx = ctrl_to_dec_ctx(ctrl);
 	int ret = 0;
 
 	switch (ctrl->id) {
@@ -550,7 +550,7 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops = {
 	.g_volatile_ctrl = mtk_vdec_g_v_ctrl,
 };
 
-static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct v4l2_ctrl *ctrl;
 
@@ -581,7 +581,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
+static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index f4f278d4bce3..9f9d2425a060 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -218,7 +218,7 @@ static const struct v4l2_frmsize_stepwise stepwise_fhd = {
 	.step_height = 16
 };
 
-static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, int error,
+static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_dec_ctx *ctx, int error,
 					   struct media_request *src_buf_req)
 {
 	struct vb2_v4l2_buffer *vb2_dst;
@@ -242,7 +242,7 @@ static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_ctx *ctx, int error
 		v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
 }
 
-static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
+static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_video_dec_buf *framebuf;
 	struct vb2_v4l2_buffer *vb2_v4l2;
@@ -279,15 +279,15 @@ static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_ctx *ctx)
 
 static void vb2ops_vdec_buf_request_complete(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 
 	v4l2_ctrl_request_complete(vb->req_obj.req, &ctx->ctrl_hdl);
 }
 
 static void mtk_vdec_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx =
-		container_of(work, struct mtk_vcodec_ctx, decode_work);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *vb2_v4l2_src;
 	struct vb2_buffer *vb2_src;
@@ -362,7 +362,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 
 static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2 = to_vb2_v4l2_buffer(vb);
 
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d] (%d) id=%d, vb=%p", ctx->id, vb->vb2_queue->type,
@@ -383,14 +383,14 @@ static void vb2ops_vdec_stateless_buf_queue(struct vb2_buffer *vb)
 	}
 }
 
-static int mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
+static int mtk_vdec_flush_decoder(struct mtk_vcodec_dec_ctx *ctx)
 {
 	bool res_chg;
 
 	return vdec_if_decode(ctx, NULL, NULL, &res_chg);
 }
 
-static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
 
@@ -442,7 +442,7 @@ const struct media_device_ops mtk_vcodec_media_ops = {
 };
 
 static void mtk_vcodec_add_formats(unsigned int fourcc,
-				   struct mtk_vcodec_ctx *ctx)
+				   struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	const struct mtk_vcodec_dec_pdata *pdata = dev->vdec_pdata;
@@ -483,7 +483,7 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 			  count_formats, ctx->dev->dec_capability);
 }
 
-static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
+static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_dec_ctx *ctx)
 {
 	int cap_format_count = 0, out_format_count = 0;
 
@@ -526,7 +526,7 @@ static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
 			mtk_video_formats[cap_format_count + out_format_count - 1];
 }
 
-static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
+static void mtk_init_vdec_params(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vb2_queue *src_vq;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 6b056bafaf94..0b32a7869993 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -17,13 +17,14 @@
 #include <media/videobuf2-core.h>
 
 #include "mtk_vcodec_dbgfs.h"
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_util.h"
 #include "vdec_msg_queue.h"
 
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
 
-#define MTK_VCODEC_MAX_PLANES	3
 #define MTK_V4L2_BENCHMARK	0
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
@@ -53,60 +54,7 @@ enum mtk_hw_reg_idx {
 	NUM_MAX_VCODEC_REG_BASE
 };
 
-/*
- * enum mtk_instance_type - The type of an MTK Vcodec instance.
- */
-enum mtk_instance_type {
-	MTK_INST_DECODER		= 0,
-	MTK_INST_ENCODER		= 1,
-};
 
-/**
- * enum mtk_instance_state - The state of an MTK Vcodec instance.
- * @MTK_STATE_FREE: default state when instance is created
- * @MTK_STATE_INIT: vcodec instance is initialized
- * @MTK_STATE_HEADER: vdec had sps/pps header parsed or venc
- *			had sps/pps header encoded
- * @MTK_STATE_FLUSH: vdec is flushing. Only used by decoder
- * @MTK_STATE_ABORT: vcodec should be aborted
- */
-enum mtk_instance_state {
-	MTK_STATE_FREE = 0,
-	MTK_STATE_INIT = 1,
-	MTK_STATE_HEADER = 2,
-	MTK_STATE_FLUSH = 3,
-	MTK_STATE_ABORT = 4,
-};
-
-/*
- * enum mtk_encode_param - General encoding parameters type
- */
-enum mtk_encode_param {
-	MTK_ENCODE_PARAM_NONE = 0,
-	MTK_ENCODE_PARAM_BITRATE = (1 << 0),
-	MTK_ENCODE_PARAM_FRAMERATE = (1 << 1),
-	MTK_ENCODE_PARAM_INTRA_PERIOD = (1 << 2),
-	MTK_ENCODE_PARAM_FORCE_INTRA = (1 << 3),
-	MTK_ENCODE_PARAM_GOP_SIZE = (1 << 4),
-};
-
-enum mtk_fmt_type {
-	MTK_FMT_DEC = 0,
-	MTK_FMT_ENC = 1,
-	MTK_FMT_FRAME = 2,
-};
-
-/*
- * enum mtk_vdec_hw_id - Hardware index used to separate
- *                         different hardware
- */
-enum mtk_vdec_hw_id {
-	MTK_VDEC_CORE,
-	MTK_VDEC_LAT0,
-	MTK_VDEC_LAT1,
-	MTK_VDEC_LAT_SOC,
-	MTK_VDEC_HW_MAX,
-};
 
 /*
  * enum mtk_vdec_hw_count - Supported hardware count
@@ -118,17 +66,6 @@ enum mtk_vdec_hw_count {
 	MTK_VDEC_MAX_HW_COUNT,
 };
 
-/*
- * struct mtk_video_fmt - Structure used to store information about pixelformats
- */
-struct mtk_video_fmt {
-	u32	fourcc;
-	enum mtk_fmt_type	type;
-	u32	num_planes;
-	u32	flags;
-	struct v4l2_frmsize_stepwise frmsize;
-};
-
 /*
  * enum mtk_q_type - Type of queue
  */
@@ -137,54 +74,6 @@ enum mtk_q_type {
 	MTK_Q_DATA_DST = 1,
 };
 
-/*
- * struct mtk_q_data - Structure used to store information about queue
- */
-struct mtk_q_data {
-	unsigned int	visible_width;
-	unsigned int	visible_height;
-	unsigned int	coded_width;
-	unsigned int	coded_height;
-	enum v4l2_field	field;
-	unsigned int	bytesperline[MTK_VCODEC_MAX_PLANES];
-	unsigned int	sizeimage[MTK_VCODEC_MAX_PLANES];
-	const struct mtk_video_fmt	*fmt;
-};
-
-/**
- * struct mtk_enc_params - General encoding parameters
- * @bitrate: target bitrate in bits per second
- * @num_b_frame: number of b frames between p-frame
- * @rc_frame: frame based rate control
- * @rc_mb: macroblock based rate control
- * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
- *		  with the first frame
- * @intra_period: I frame period
- * @gop_size: group of picture size, it's used as the intra frame period
- * @framerate_num: frame rate numerator. ex: framerate_num=30 and
- *		   framerate_denom=1 means FPS is 30
- * @framerate_denom: frame rate denominator. ex: framerate_num=30 and
- *		     framerate_denom=1 means FPS is 30
- * @h264_max_qp: Max value for H.264 quantization parameter
- * @h264_profile: V4L2 defined H.264 profile
- * @h264_level: V4L2 defined H.264 level
- * @force_intra: force/insert intra frame
- */
-struct mtk_enc_params {
-	unsigned int	bitrate;
-	unsigned int	num_b_frame;
-	unsigned int	rc_frame;
-	unsigned int	rc_mb;
-	unsigned int	seq_hdr_mode;
-	unsigned int	intra_period;
-	unsigned int	gop_size;
-	unsigned int	framerate_num;
-	unsigned int	framerate_denom;
-	unsigned int	h264_max_qp;
-	unsigned int	h264_profile;
-	unsigned int	h264_level;
-	unsigned int	force_intra;
-};
 
 /*
  * struct mtk_vcodec_clk_info - Structure used to store clock name
@@ -211,125 +100,6 @@ struct mtk_vcodec_pm {
 	struct device	*dev;
 };
 
-/**
- * struct vdec_pic_info  - picture size information
- * @pic_w: picture width
- * @pic_h: picture height
- * @buf_w: picture buffer width (64 aligned up from pic_w)
- * @buf_h: picture buffer heiht (64 aligned up from pic_h)
- * @fb_sz: bitstream size of each plane
- * E.g. suppose picture size is 176x144,
- *      buffer size will be aligned to 176x160.
- * @cap_fourcc: fourcc number(may changed when resolution change)
- * @reserved: align struct to 64-bit in order to adjust 32-bit and 64-bit os.
- */
-struct vdec_pic_info {
-	unsigned int pic_w;
-	unsigned int pic_h;
-	unsigned int buf_w;
-	unsigned int buf_h;
-	unsigned int fb_sz[VIDEO_MAX_PLANES];
-	unsigned int cap_fourcc;
-	unsigned int reserved;
-};
-
-/**
- * struct mtk_vcodec_ctx - Context (instance) private data.
- *
- * @type: type of the instance - decoder or encoder
- * @dev: pointer to the mtk_vcodec_dev of the device
- * @list: link to ctx_list of mtk_vcodec_dev
- * @fh: struct v4l2_fh
- * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
- * @q_data: store information of input and output queue
- *	    of the context
- * @id: index of the context that this structure describes
- * @state: state of the context
- * @param_change: indicate encode parameter type
- * @enc_params: encoding parameters
- * @dec_if: hooked decoder driver interface
- * @enc_if: hooked encoder driver interface
- * @drv_handle: driver handle for specific decode/encode instance
- *
- * @picinfo: store picture info after header parsing
- * @dpb_size: store dpb count after header parsing
- * @int_cond: variable used by the waitqueue
- * @int_type: type of the last interrupt
- * @queue: waitqueue that can be used to wait for this context to
- *	   finish
- * @irq_status: irq status
- *
- * @ctrl_hdl: handler for v4l2 framework
- * @decode_work: worker for the decoding
- * @encode_work: worker for the encoding
- * @last_decoded_picinfo: pic information get from latest decode
- * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Only
- *		     to be used with encoder and stateful decoder.
- * @is_flushing: set to true if flushing is in progress.
- * @current_codec: current set input codec, in V4L2 pixel format
- * @capture_fourcc: capture queue type in V4L2 pixel format
- *
- * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
- * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
- * @quantization: enum v4l2_quantization, colorspace quantization
- * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
- * @decoded_frame_cnt: number of decoded frames
- * @lock: protect variables accessed by V4L2 threads and worker thread such as
- *	  mtk_video_dec_buf.
- * @hw_id: hardware index used to identify different hardware.
- *
- * @msg_queue: msg queue used to store lat buffer information.
- * @q_mutex: vb2_queue mutex.
- */
-struct mtk_vcodec_ctx {
-	enum mtk_instance_type type;
-	struct mtk_vcodec_dev *dev;
-	struct list_head list;
-
-	struct v4l2_fh fh;
-	struct v4l2_m2m_ctx *m2m_ctx;
-	struct mtk_q_data q_data[2];
-	int id;
-	enum mtk_instance_state state;
-	enum mtk_encode_param param_change;
-	struct mtk_enc_params enc_params;
-
-	const struct vdec_common_if *dec_if;
-	const struct venc_common_if *enc_if;
-	void *drv_handle;
-
-	struct vdec_pic_info picinfo;
-	int dpb_size;
-
-	int int_cond[MTK_VDEC_HW_MAX];
-	int int_type[MTK_VDEC_HW_MAX];
-	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
-	unsigned int irq_status;
-
-	struct v4l2_ctrl_handler ctrl_hdl;
-	struct work_struct decode_work;
-	struct work_struct encode_work;
-	struct vdec_pic_info last_decoded_picinfo;
-	struct v4l2_m2m_buffer empty_flush_buf;
-	bool is_flushing;
-
-	u32 current_codec;
-	u32 capture_fourcc;
-
-	enum v4l2_colorspace colorspace;
-	enum v4l2_ycbcr_encoding ycbcr_enc;
-	enum v4l2_quantization quantization;
-	enum v4l2_xfer_func xfer_func;
-
-	int decoded_frame_cnt;
-	struct mutex lock;
-	int hw_id;
-
-	struct vdec_msg_queue msg_queue;
-
-	struct mutex q_mutex;
-};
-
 /*
  * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
  */
@@ -375,12 +145,12 @@ enum mtk_vdec_format_types {
  */
 
 struct mtk_vcodec_dec_pdata {
-	void (*init_vdec_params)(struct mtk_vcodec_ctx *ctx);
-	int (*ctrls_setup)(struct mtk_vcodec_ctx *ctx);
+	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
+	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
 	void (*worker)(struct work_struct *work);
-	int (*flush_decoder)(struct mtk_vcodec_ctx *ctx);
-	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_ctx *ctx);
-	void (*cap_to_disp)(struct mtk_vcodec_ctx *ctx, int error,
+	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
+	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
+	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
 			    struct media_request *src_buf_req);
 
 	struct vb2_ops *vdec_vb2_ops;
@@ -434,9 +204,10 @@ struct mtk_vcodec_enc_pdata {
  * @m2m_dev_dec: m2m device for decoder
  * @m2m_dev_enc: m2m device for encoder.
  * @plat_dev: platform device
- * @ctx_list: list of struct mtk_vcodec_ctx
+ * @ctx_list: list of struct mtk_vcodec_dec_ctx
  * @irqlock: protect data access by irq handler and work thread
  * @curr_ctx: The context that is waiting for codec hardware
+ * @curr_enc_ctx: The encoder context that is waiting for codec hardware
  *
  * @reg_base: Mapped address of MTK Vcodec registers.
  * @vdec_pdata: decoder IC-specific data
@@ -483,7 +254,8 @@ struct mtk_vcodec_dev {
 	struct platform_device *plat_dev;
 	struct list_head ctx_list;
 	spinlock_t irqlock;
-	struct mtk_vcodec_ctx *curr_ctx;
+	struct mtk_vcodec_dec_ctx *curr_ctx;
+	struct mtk_vcodec_enc_ctx *curr_enc_ctx;
 	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
 	const struct mtk_vcodec_dec_pdata *vdec_pdata;
 	const struct mtk_vcodec_enc_pdata *venc_pdata;
@@ -522,23 +294,4 @@ struct mtk_vcodec_dev {
 	struct mtk_vcodec_dbgfs dbgfs;
 };
 
-static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
-{
-	return container_of(fh, struct mtk_vcodec_ctx, fh);
-}
-
-static inline struct mtk_vcodec_ctx *ctrl_to_ctx(struct v4l2_ctrl *ctrl)
-{
-	return container_of(ctrl->handler, struct mtk_vcodec_ctx, ctrl_hdl);
-}
-
-/* Wake up context wait_queue */
-static inline void
-wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason, unsigned int hw_id)
-{
-	ctx->int_cond[hw_id] = 1;
-	ctx->int_type[hw_id] = reason;
-	wake_up_interruptible(&ctx->queue[hw_id]);
-}
-
 #endif /* _MTK_VCODEC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 276da79d98e7..deabf012848e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -45,7 +45,7 @@ static const struct v4l2_frmsize_stepwise mtk_venc_4k_framesizes = {
 
 static int vidioc_venc_s_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct mtk_vcodec_ctx *ctx = ctrl_to_ctx(ctrl);
+	struct mtk_vcodec_enc_ctx *ctx = ctrl_to_enc_ctx(ctrl);
 	struct mtk_enc_params *p = &ctx->enc_params;
 	int ret = 0;
 
@@ -162,7 +162,7 @@ static int vidioc_enum_framesizes(struct file *file, void *fh,
 				  struct v4l2_frmsizeenum *fsize)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(fh);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(fh);
 
 	if (fsize->index != 0)
 		return -EINVAL;
@@ -186,7 +186,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
 	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(priv)->dev->venc_pdata;
+		fh_to_enc_ctx(priv)->dev->venc_pdata;
 
 	return vidioc_enum_fmt(f, pdata->capture_formats,
 			       pdata->num_capture_formats);
@@ -196,7 +196,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
 	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(priv)->dev->venc_pdata;
+		fh_to_enc_ctx(priv)->dev->venc_pdata;
 
 	return vidioc_enum_fmt(f, pdata->output_formats,
 			       pdata->num_output_formats);
@@ -204,7 +204,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 
 static int mtk_vcodec_enc_get_chip_name(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-enc"))
@@ -224,7 +224,7 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
 static int vidioc_venc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
 
@@ -237,7 +237,7 @@ static int vidioc_venc_querycap(struct file *file, void *priv,
 static int vidioc_venc_s_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct v4l2_fract *timeperframe = &a->parm.output.timeperframe;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
@@ -260,7 +260,7 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
 static int vidioc_venc_g_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
@@ -274,7 +274,7 @@ static int vidioc_venc_g_parm(struct file *file, void *priv,
 	return 0;
 }
 
-static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
+static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_enc_ctx *ctx,
 					      enum v4l2_buf_type type)
 {
 	if (V4L2_TYPE_IS_OUTPUT(type))
@@ -294,7 +294,7 @@ static void vidioc_try_fmt_cap(struct v4l2_format *f)
 /* V4L2 specification suggests the driver corrects the format struct if any of
  * the dimensions is unsupported
  */
-static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
+static int vidioc_try_fmt_out(struct mtk_vcodec_enc_ctx *ctx, struct v4l2_format *f,
 			      const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
@@ -367,8 +367,8 @@ static int vidioc_try_fmt_out(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 	return 0;
 }
 
-static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
-				struct venc_enc_param *param)
+static void mtk_venc_set_param(struct mtk_vcodec_enc_ctx *ctx,
+			       struct venc_enc_param *param)
 {
 	struct mtk_q_data *q_data_src = &ctx->q_data[MTK_Q_DATA_SRC];
 	struct mtk_enc_params *enc_params = &ctx->enc_params;
@@ -417,7 +417,7 @@ static void mtk_venc_set_param(struct mtk_vcodec_ctx *ctx,
 static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
@@ -472,7 +472,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
@@ -527,7 +527,7 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
 			     struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct vb2_queue *vq;
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
 	int i;
@@ -560,7 +560,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
 	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
@@ -582,7 +582,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 					 struct v4l2_format *f)
 {
 	const struct mtk_video_fmt *fmt;
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
 	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
@@ -603,7 +603,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 static int vidioc_venc_g_selection(struct file *file, void *priv,
 				     struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -633,7 +633,7 @@ static int vidioc_venc_g_selection(struct file *file, void *priv,
 static int vidioc_venc_s_selection(struct file *file, void *priv,
 				     struct v4l2_selection *s)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
@@ -658,7 +658,7 @@ static int vidioc_venc_s_selection(struct file *file, void *priv,
 static int vidioc_venc_qbuf(struct file *file, void *priv,
 			    struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 
 	if (ctx->state == MTK_STATE_ABORT) {
 		mtk_v4l2_venc_err(ctx, "[%d] Call on QBUF after unrecoverable error",
@@ -672,7 +672,7 @@ static int vidioc_venc_qbuf(struct file *file, void *priv,
 static int vidioc_venc_dqbuf(struct file *file, void *priv,
 			     struct v4l2_buffer *buf)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	int ret;
 
 	if (ctx->state == MTK_STATE_ABORT) {
@@ -710,7 +710,7 @@ static int vidioc_venc_dqbuf(struct file *file, void *priv,
 static int vidioc_encoder_cmd(struct file *file, void *priv,
 			      struct v4l2_encoder_cmd *cmd)
 {
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(priv);
 	struct vb2_queue *src_vq, *dst_vq;
 	int ret;
 
@@ -804,7 +804,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 				   unsigned int sizes[],
 				   struct device *alloc_devs[])
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vq);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vq->type);
 	unsigned int i;
 
@@ -826,7 +826,7 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 
 static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vb->vb2_queue->type);
 	int i;
 
@@ -843,7 +843,7 @@ static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
 
 static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vb2_v4l2 =
 			container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
 
@@ -865,7 +865,7 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 
 static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
 	struct venc_enc_param param;
 	int ret, pm_ret;
 	int i;
@@ -944,7 +944,7 @@ static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 {
-	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(q);
+	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	int ret;
 
@@ -1033,7 +1033,7 @@ static const struct vb2_ops mtk_venc_vb2_ops = {
 
 static int mtk_venc_encode_header(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 	int ret;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem bs_buf;
@@ -1080,7 +1080,7 @@ static int mtk_venc_encode_header(void *priv)
 	return 0;
 }
 
-static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
+static int mtk_venc_param_change(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct venc_enc_param enc_prm;
 	struct vb2_v4l2_buffer *vb2_v4l2 = v4l2_m2m_next_src_buf(ctx->m2m_ctx);
@@ -1153,7 +1153,7 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
  */
 static void mtk_venc_worker(struct work_struct *work)
 {
-	struct mtk_vcodec_ctx *ctx = container_of(work, struct mtk_vcodec_ctx,
+	struct mtk_vcodec_enc_ctx *ctx = container_of(work, struct mtk_vcodec_enc_ctx,
 				    encode_work);
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct venc_frm_buf frm_buf;
@@ -1233,7 +1233,7 @@ static void mtk_venc_worker(struct work_struct *work)
 
 static void m2mops_venc_device_run(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 
 	if ((ctx->q_data[MTK_Q_DATA_DST].fmt->fourcc == V4L2_PIX_FMT_H264) &&
 	    (ctx->state != MTK_STATE_HEADER)) {
@@ -1249,7 +1249,7 @@ static void m2mops_venc_device_run(void *priv)
 
 static int m2mops_venc_job_ready(void *m2m_priv)
 {
-	struct mtk_vcodec_ctx *ctx = m2m_priv;
+	struct mtk_vcodec_enc_ctx *ctx = m2m_priv;
 
 	if (ctx->state == MTK_STATE_ABORT || ctx->state == MTK_STATE_FREE) {
 		mtk_v4l2_venc_dbg(3, ctx, "[%d]Not ready: state=0x%x.", ctx->id, ctx->state);
@@ -1261,7 +1261,7 @@ static int m2mops_venc_job_ready(void *m2m_priv)
 
 static void m2mops_venc_job_abort(void *priv)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 
 	ctx->state = MTK_STATE_ABORT;
 }
@@ -1272,7 +1272,7 @@ const struct v4l2_m2m_ops mtk_venc_m2m_ops = {
 	.job_abort	= m2mops_venc_job_abort,
 };
 
-void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
@@ -1333,7 +1333,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 	ctx->enc_params.framerate_denom = MTK_DEFAULT_FRAMERATE_DENOM;
 }
 
-int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
+int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx)
 {
 	const struct v4l2_ctrl_ops *ops = &mtk_vcodec_enc_ctrl_ops;
 	struct v4l2_ctrl_handler *handler = &ctx->ctrl_hdl;
@@ -1399,7 +1399,7 @@ int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
 	int ret;
 
 	/* Note: VB2_USERPTR works with dma-contig because mt8173
@@ -1434,7 +1434,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
@@ -1442,7 +1442,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
@@ -1450,7 +1450,7 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
 	return 0;
 }
 
-void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
+void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = venc_if_deinit(ctx);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
index 513ee7993e34..82246401ed4a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
@@ -11,6 +11,8 @@
 #include <media/videobuf2-core.h>
 #include <media/v4l2-mem2mem.h>
 
+#include "mtk_vcodec_enc_drv.h"
+
 #define MTK_VENC_IRQ_STATUS_SPS	0x1
 #define MTK_VENC_IRQ_STATUS_PPS	0x2
 #define MTK_VENC_IRQ_STATUS_FRM	0x4
@@ -39,12 +41,12 @@ struct mtk_video_enc_buf {
 extern const struct v4l2_ioctl_ops mtk_venc_ioctl_ops;
 extern const struct v4l2_m2m_ops mtk_venc_m2m_ops;
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx);
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx);
+int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx);
+int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx);
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq);
-void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
-int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
-void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
+void mtk_vcodec_enc_release(struct mtk_vcodec_enc_ctx *ctx);
+int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_enc_ctx *ctx);
+void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_enc_ctx *ctx);
 
 #endif /* _MTK_VCODEC_ENC_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index cb222d9d5c17..a557fc5aebef 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -86,13 +86,13 @@ static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
 static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
 	int core_id;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
-	ctx = dev->curr_ctx;
+	ctx = dev->curr_enc_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
 	core_id = dev->venc_pdata->core_id;
@@ -110,14 +110,14 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 
 	clean_irq_status(ctx->irq_status, addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	wake_up_enc_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 	return IRQ_HANDLED;
 }
 
 static int fops_vcodec_open(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_enc_ctx *ctx = NULL;
 	int ret = 0;
 	struct vb2_queue *src_vq;
 
@@ -204,7 +204,7 @@ static int fops_vcodec_open(struct file *file)
 static int fops_vcodec_release(struct file *file)
 {
 	struct mtk_vcodec_dev *dev = video_drvdata(file);
-	struct mtk_vcodec_ctx *ctx = fh_to_ctx(file->private_data);
+	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(file->private_data);
 
 	mtk_v4l2_venc_dbg(1, ctx, "[%d] encoder", ctx->id);
 	mutex_lock(&dev->dev_mutex);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
new file mode 100644
index 000000000000..4b0dfa119f27
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Yunfei Dong <yunfei.dong@mediatek.com>
+ */
+
+#ifndef _MTK_VCODEC_ENC_DRV_H_
+#define _MTK_VCODEC_ENC_DRV_H_
+
+#include "mtk_vcodec_cmn_drv.h"
+#include "mtk_vcodec_fw_priv.h"
+
+/*
+ * enum mtk_encode_param - General encoding parameters type
+ */
+enum mtk_encode_param {
+	MTK_ENCODE_PARAM_NONE = 0,
+	MTK_ENCODE_PARAM_BITRATE = (1 << 0),
+	MTK_ENCODE_PARAM_FRAMERATE = (1 << 1),
+	MTK_ENCODE_PARAM_INTRA_PERIOD = (1 << 2),
+	MTK_ENCODE_PARAM_FORCE_INTRA = (1 << 3),
+	MTK_ENCODE_PARAM_GOP_SIZE = (1 << 4),
+};
+
+/**
+ * struct mtk_enc_params - General encoding parameters
+ * @bitrate: target bitrate in bits per second
+ * @num_b_frame: number of b frames between p-frame
+ * @rc_frame: frame based rate control
+ * @rc_mb: macroblock based rate control
+ * @seq_hdr_mode: H.264 sequence header is encoded separately or joined
+ *		  with the first frame
+ * @intra_period: I frame period
+ * @gop_size: group of picture size, it's used as the intra frame period
+ * @framerate_num: frame rate numerator. ex: framerate_num=30 and
+ *		   framerate_denom=1 means FPS is 30
+ * @framerate_denom: frame rate denominator. ex: framerate_num=30 and
+ *		     framerate_denom=1 means FPS is 30
+ * @h264_max_qp: Max value for H.264 quantization parameter
+ * @h264_profile: V4L2 defined H.264 profile
+ * @h264_level: V4L2 defined H.264 level
+ * @force_intra: force/insert intra frame
+ */
+struct mtk_enc_params {
+	unsigned int	bitrate;
+	unsigned int	num_b_frame;
+	unsigned int	rc_frame;
+	unsigned int	rc_mb;
+	unsigned int	seq_hdr_mode;
+	unsigned int	intra_period;
+	unsigned int	gop_size;
+	unsigned int	framerate_num;
+	unsigned int	framerate_denom;
+	unsigned int	h264_max_qp;
+	unsigned int	h264_profile;
+	unsigned int	h264_level;
+	unsigned int	force_intra;
+};
+
+/**
+ * struct mtk_vcodec_enc_ctx - Context (instance) private data.
+ *
+ * @type: type of encoder instance
+ * @dev: pointer to the mtk_vcodec_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_dev
+ *
+ * @fh: struct v4l2_fh
+ * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
+ * @q_data: store information of input and output queue of the context
+ * @id: index of the context that this structure describes
+ * @state: state of the context
+ * @param_change: indicate encode parameter type
+ * @enc_params: encoding parameters
+ *
+ * @enc_if: hooked encoder driver interface
+ * @drv_handle: driver handle for specific decode/encode instance
+ *
+ * @int_cond: variable used by the waitqueue
+ * @int_type: type of the last interrupt
+ * @queue: waitqueue that can be used to wait for this context to finish
+ * @irq_status: irq status
+ *
+ * @ctrl_hdl: handler for v4l2 framework
+ * @encode_work: worker for the encoding
+ * @empty_flush_buf: a fake size-0 capture buffer that indicates flush. Used for encoder.
+ * @is_flushing: set to true if flushing is in progress.
+ *
+ * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
+ * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @quantization: enum v4l2_quantization, colorspace quantization
+ * @xfer_func: enum v4l2_xfer_func, colorspace transfer function
+ *
+ * @q_mutex: vb2_queue mutex.
+ */
+struct mtk_vcodec_enc_ctx {
+	enum mtk_instance_type type;
+	struct mtk_vcodec_dev *dev;
+	struct list_head list;
+
+	struct v4l2_fh fh;
+	struct v4l2_m2m_ctx *m2m_ctx;
+	struct mtk_q_data q_data[2];
+	int id;
+	enum mtk_instance_state state;
+	enum mtk_encode_param param_change;
+	struct mtk_enc_params enc_params;
+
+	const struct venc_common_if *enc_if;
+	void *drv_handle;
+
+	int int_cond[MTK_VDEC_HW_MAX];
+	int int_type[MTK_VDEC_HW_MAX];
+	wait_queue_head_t queue[MTK_VDEC_HW_MAX];
+	unsigned int irq_status;
+
+	struct v4l2_ctrl_handler ctrl_hdl;
+	struct work_struct encode_work;
+	struct v4l2_m2m_buffer empty_flush_buf;
+	bool is_flushing;
+
+	enum v4l2_colorspace colorspace;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_xfer_func xfer_func;
+
+	struct mutex q_mutex;
+};
+
+static inline struct mtk_vcodec_enc_ctx *fh_to_enc_ctx(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct mtk_vcodec_enc_ctx, fh);
+}
+
+static inline struct mtk_vcodec_enc_ctx *ctrl_to_enc_ctx(struct v4l2_ctrl *ctrl)
+{
+	return container_of(ctrl->handler, struct mtk_vcodec_enc_ctx, ctrl_hdl);
+}
+
+/* Wake up context wait_queue */
+static inline void
+wake_up_enc_ctx(struct mtk_vcodec_enc_ctx *ctx, unsigned int reason, unsigned int hw_id)
+{
+	ctx->int_cond[hw_id] = 1;
+	ctx->int_type[hw_id] = reason;
+	wake_up_interruptible(&ctx->queue[hw_id]);
+}
+
+#endif /* _MTK_VCODEC_ENC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index ee6846886dd6..571072dffbfa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
@@ -51,10 +51,25 @@ static void mtk_vcodec_vpu_release(struct mtk_vcodec_fw *fw)
 	put_device(&fw->pdev->dev);
 }
 
-static void mtk_vcodec_vpu_reset_handler(void *priv)
+static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
+
+	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
+
+	mutex_lock(&dev->dev_mutex);
+	list_for_each_entry(ctx, &dev->ctx_list, list) {
+		ctx->state = MTK_STATE_ABORT;
+		mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE_ABORT", ctx->id);
+	}
+	mutex_unlock(&dev->dev_mutex);
+}
+
+static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
+{
+	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_enc_ctx *ctx;
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
 
@@ -84,14 +99,13 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 	struct mtk_vcodec_fw *fw;
 	enum rst_id rst_id;
 
-	switch (fw_use) {
-	case ENCODER:
+	if (fw_use == ENCODER) {
 		rst_id = VPU_RST_ENC;
-		break;
-	case DECODER:
-	default:
+	} else if (fw_use == DECODER) {
 		rst_id = VPU_RST_DEC;
-		break;
+	} else {
+		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
+		return ERR_PTR(-EINVAL);
 	}
 
 	plat_dev = dev->plat_dev;
@@ -101,7 +115,10 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use
 		return ERR_PTR(-EINVAL);
 	}
 
-	vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_handler, dev, rst_id);
+	if (fw_use == DECODER)
+		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_dec_handler, priv, rst_id);
+	else
+		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_vpu_reset_enc_handler, priv, rst_id);
 
 	fw = devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
 	if (!fw)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
index 2cec6b39a884..59970aa51ab2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
@@ -14,17 +14,34 @@
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
 				 unsigned int hw_id)
 {
-	struct mtk_vcodec_ctx *ctx = priv;
+	int instance_type = *((int *)priv);
 	long timeout_jiff, ret;
 	int ctx_id, ctx_type, status = 0;
 	int *ctx_int_cond, *ctx_int_type;
 	wait_queue_head_t *ctx_queue;
+	struct platform_device *pdev;
 
-	ctx_id = ctx->id;
-	ctx_type = ctx->type;
-	ctx_int_cond = ctx->int_cond;
-	ctx_int_type = ctx->int_type;
-	ctx_queue = ctx->queue;
+	if (instance_type == DECODER) {
+		struct mtk_vcodec_dec_ctx *ctx;
+
+		ctx = priv;
+		ctx_id = ctx->id;
+		ctx_type = ctx->type;
+		ctx_int_cond = ctx->int_cond;
+		ctx_int_type = ctx->int_type;
+		ctx_queue = ctx->queue;
+		pdev = ctx->dev->plat_dev;
+	} else {
+		struct mtk_vcodec_enc_ctx *ctx;
+
+		ctx = priv;
+		ctx_id = ctx->id;
+		ctx_type = ctx->type;
+		ctx_int_cond = ctx->int_cond;
+		ctx_int_type = ctx->int_type;
+		ctx_queue = ctx->queue;
+		pdev = ctx->dev->plat_dev;
+	}
 
 	timeout_jiff = msecs_to_jiffies(timeout_ms);
 	ret = wait_event_interruptible_timeout(ctx_queue[hw_id],
@@ -33,12 +50,12 @@ int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_m
 
 	if (!ret) {
 		status = -1;	/* timeout */
-		dev_err(&ctx->dev->plat_dev->dev, "[%d] cmd=%d, type=%d, dec timeout=%ums (%d %d)",
+		dev_err(&pdev->dev, "[%d] cmd=%d, type=%d, dec timeout=%ums (%d %d)",
 			ctx_id, command, ctx_type, timeout_ms,
 			ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	} else if (-ERESTARTSYS == ret) {
 		status = -1;
-		dev_err(&ctx->dev->plat_dev->dev, "[%d] cmd=%d, type=%d, dec inter fail (%d %d)",
+		dev_err(&pdev->dev, "[%d] cmd=%d, type=%d, dec inter fail (%d %d)",
 			ctx_id, command, ctx_type,
 			ctx_int_cond[hw_id], ctx_int_type[hw_id]);
 	}
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
index 11bf0ef94d5d..3e3cc71ee572 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
@@ -9,7 +9,8 @@
 
 #define MTK_INST_IRQ_RECEIVED		0x1
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
+struct mtk_vcodec_enc_ctx;
 
 /* timeout is ms */
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index f4db3f9f135d..05e04050ac89 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -31,7 +31,7 @@ void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
-int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg,
+int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg,
 			     unsigned int val)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
@@ -48,7 +48,7 @@ EXPORT_SYMBOL(mtk_vcodec_write_vdecsys);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
@@ -69,7 +69,7 @@ EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
-	struct mtk_vcodec_ctx *ctx = priv;
+	struct mtk_vcodec_dec_ctx *ctx = priv;
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
 	if (!mem->va) {
@@ -101,7 +101,7 @@ void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
 EXPORT_SYMBOL(mtk_vcodec_get_hw_dev);
 
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-			     struct mtk_vcodec_ctx *ctx, int hw_idx)
+			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	unsigned long flags;
 	struct mtk_vdec_hw_dev *subdev_dev;
@@ -122,11 +122,11 @@ void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 }
 EXPORT_SYMBOL(mtk_vcodec_set_curr_ctx);
 
-struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-					       unsigned int hw_idx)
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+						   unsigned int hw_idx)
 {
 	unsigned long flags;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vdec_hw_dev *subdev_dev;
 
 	spin_lock_irqsave(&vdec_dev->irqlock, flags);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 35014cb447e7..a0d7b7784cf7 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -25,7 +25,7 @@ struct mtk_vcodec_fb {
 	dma_addr_t dma_addr;
 };
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 struct mtk_vcodec_dev;
 
 #undef pr_fmt
@@ -85,13 +85,13 @@ extern int mtk_vcodec_dbg;
 	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
 
 void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx);
-int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg, unsigned int val);
+int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg, unsigned int val);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-			     struct mtk_vcodec_ctx *ctx, int hw_idx);
-struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
-					       unsigned int hw_idx);
+			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+						   unsigned int hw_idx);
 void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx);
 
 #endif /* _MTK_VCODEC_UTIL_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
index 40dd43a4a2d8..10f5b58c7302 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
@@ -706,7 +706,7 @@ struct vdec_av1_slice_pfc {
  * @seq:                global picture sequence
  */
 struct vdec_av1_slice_instance {
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 
 	struct mtk_vcodec_mem iq_table;
@@ -756,7 +756,7 @@ static inline bool vdec_av1_slice_need_scale(u32 ref_width, u32 ref_height,
 		(this_height <= (ref_height << 4));
 }
 
-static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -769,7 +769,7 @@ static void *vdec_av1_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance *instance)
 {
 	u8 *remote_cdf_table;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_av1_slice_init_vsi *vsi;
 	int ret;
 
@@ -800,7 +800,7 @@ static int vdec_av1_slice_init_cdf_table(struct vdec_av1_slice_instance *instanc
 static int vdec_av1_slice_init_iq_table(struct vdec_av1_slice_instance *instance)
 {
 	u8 *remote_iq_table;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_av1_slice_init_vsi *vsi;
 	int ret;
 
@@ -937,7 +937,7 @@ static void vdec_av1_slice_setup_slot(struct vdec_av1_slice_instance *instance,
 static int vdec_av1_slice_alloc_working_buffer(struct vdec_av1_slice_instance *instance,
 					       struct vdec_av1_slice_vsi *vsi)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	enum vdec_av1_slice_resolution_level level;
 	u32 max_sb_w, max_sb_h, max_w, max_h, w, h;
 	int i, ret;
@@ -1020,7 +1020,7 @@ static int vdec_av1_slice_alloc_working_buffer(struct vdec_av1_slice_instance *i
 
 static void vdec_av1_slice_free_working_buffer(struct vdec_av1_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(instance->mv); i++)
@@ -1868,7 +1868,7 @@ static int vdec_av1_slice_update_core(struct vdec_av1_slice_instance *instance,
 	return 0;
 }
 
-static int vdec_av1_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_av1_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_av1_slice_instance *instance;
 	struct vdec_av1_slice_init_vsi *vsi;
@@ -1966,7 +1966,7 @@ static int vdec_av1_slice_flush(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 static void vdec_av1_slice_get_pic_info(struct vdec_av1_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	u32 data[3];
 
 	mtk_vdec_debug(ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->picinfo.pic_h);
@@ -1992,7 +1992,7 @@ static inline void vdec_av1_slice_get_dpb_size(struct vdec_av1_slice_instance *i
 static void vdec_av1_slice_get_crop_info(struct vdec_av1_slice_instance *instance,
 					 struct v4l2_rect *cr)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 
 	cr->left = 0;
 	cr->top = 0;
@@ -2032,7 +2032,7 @@ static int vdec_av1_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_lat_buf *lat_buf;
 	struct vdec_av1_slice_pfc *pfc;
 	struct vdec_av1_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2132,7 +2132,7 @@ static int vdec_av1_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	struct vdec_av1_slice_instance *instance;
 	struct vdec_av1_slice_pfc *pfc;
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	struct vdec_fb *fb = NULL;
 	int ret = -EINVAL;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
index ca5437ae37f6..69914e26cd20 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
@@ -117,7 +117,7 @@ struct vdec_h264_vsi {
 /**
  * struct vdec_h264_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
- * @ctx      : point to mtk_vcodec_ctx
+ * @ctx      : point to mtk_vcodec_dec_ctx
  * @pred_buf : HW working predication buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
@@ -125,7 +125,7 @@ struct vdec_h264_vsi {
  */
 struct vdec_h264_inst {
 	unsigned int num_nalu;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_FB_NUM];
 	struct vdec_vpu_inst vpu;
@@ -266,7 +266,7 @@ static void get_dpb_size(struct vdec_h264_inst *inst, unsigned int *dpb_sz)
 	mtk_vdec_debug(inst->ctx, "sz=%d", *dpb_sz);
 }
 
-static int vdec_h264_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_inst *inst = NULL;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
index 580ce979e2a3..5ca20d75dc8e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
@@ -33,7 +33,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
 	memset(&ref_list[num_valid], 0x20, 32 - num_valid);
 }
 
-void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -43,7 +43,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 	return ctrl->p_cur.p;
 }
 
-void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				 struct slice_api_h264_decode_param *decode_params,
 				 struct mtk_h264_dpb_info *h264_dpb_info)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
index 53d0a7c962a9..0dda9e2315c0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
@@ -182,7 +182,7 @@ void mtk_vdec_h264_get_ref_list(u8 *ref_list,
  *
  * Return: returns CID ctrl address.
  */
-void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id);
+void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id);
 
 /**
  * mtk_vdec_h264_fill_dpb_info - get each CID contrl address.
@@ -191,7 +191,7 @@ void *mtk_vdec_h264_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id);
  * @decode_params:	slice decode params
  * @h264_dpb_info:	dpb buffer information
  */
-void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				 struct slice_api_h264_decode_param *decode_params,
 				 struct mtk_h264_dpb_info *h264_dpb_info);
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index bdff1d2feb1c..4eb98a705be4 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -74,7 +74,7 @@ struct vdec_h264_vsi {
 /**
  * struct vdec_h264_slice_inst - h264 decoder instance
  * @num_nalu : how many nalus be decoded
- * @ctx      : point to mtk_vcodec_ctx
+ * @ctx      : point to mtk_vcodec_dec_ctx
  * @pred_buf : HW working predication buffer
  * @mv_buf   : HW working motion vector buffer
  * @vpu      : VPU instance
@@ -84,7 +84,7 @@ struct vdec_h264_vsi {
  */
 struct vdec_h264_slice_inst {
 	unsigned int num_nalu;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
@@ -220,7 +220,7 @@ static void free_mv_buf(struct vdec_h264_slice_inst *inst)
 static void get_pic_info(struct vdec_h264_slice_inst *inst,
 			 struct vdec_pic_info *pic)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 
 	ctx->picinfo.buf_w = ALIGN(ctx->picinfo.pic_w, VCODEC_DEC_ALIGNED_64);
 	ctx->picinfo.buf_h = ALIGN(ctx->picinfo.pic_h, VCODEC_DEC_ALIGNED_64);
@@ -269,7 +269,7 @@ static void get_dpb_size(struct vdec_h264_slice_inst *inst, unsigned int *dpb_sz
 	mtk_vdec_debug(inst->ctx, "sz=%d", *dpb_sz);
 }
 
-static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_slice_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 1c2389e63e4c..846cc39c0168 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -133,7 +133,7 @@ struct vdec_h264_slice_share_info {
  * struct vdec_h264_slice_inst - h264 decoder instance
  *
  * @slice_dec_num:	how many picture be decoded
- * @ctx:		point to mtk_vcodec_ctx
+ * @ctx:		point to mtk_vcodec_dec_ctx
  * @pred_buf:		HW working predication buffer
  * @mv_buf:		HW working motion vector buffer
  * @vpu:		VPU instance
@@ -153,7 +153,7 @@ struct vdec_h264_slice_share_info {
  */
 struct vdec_h264_slice_inst {
 	unsigned int slice_dec_num;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem pred_buf;
 	struct mtk_vcodec_mem mv_buf[H264_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
@@ -344,7 +344,7 @@ static void vdec_h264_slice_free_mv_buf(struct vdec_h264_slice_inst *inst)
 
 static void vdec_h264_slice_get_pic_info(struct vdec_h264_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	u32 data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -393,7 +393,7 @@ static void vdec_h264_slice_get_crop_info(struct vdec_h264_slice_inst *inst,
 		       cr->left, cr->top, cr->width, cr->height);
 }
 
-static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_h264_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_h264_slice_inst *inst;
 	int err, vsi_size;
@@ -457,7 +457,7 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	u64 vdec_fb_va;
 	u64 y_fb_dma, c_fb_dma;
 	int err, timeout, i;
-	struct mtk_vcodec_ctx *ctx = lat_buf->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = lat_buf->ctx;
 	struct vdec_h264_slice_inst *inst = ctx->drv_handle;
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct vdec_h264_slice_share_info *share_info = lat_buf->private_data;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index aa32b7cbf6f1..67a5f8b82eb8 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -344,7 +344,7 @@ struct vdec_hevc_slice_share_info {
  * struct vdec_hevc_slice_inst - hevc decoder instance
  *
  * @slice_dec_num:      how many picture be decoded
- * @ctx:                point to mtk_vcodec_ctx
+ * @ctx:                point to mtk_vcodec_dec_ctx
  * @mv_buf:             HW working motion vector buffer
  * @vpu:                VPU instance
  * @vsi:                vsi used for lat
@@ -359,7 +359,7 @@ struct vdec_hevc_slice_share_info {
  */
 struct vdec_hevc_slice_inst {
 	unsigned int slice_dec_num;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct mtk_vcodec_mem mv_buf[HEVC_MAX_MV_NUM];
 	struct vdec_vpu_inst vpu;
 	struct vdec_hevc_slice_vsi *vsi;
@@ -380,7 +380,7 @@ static unsigned int vdec_hevc_get_mv_buf_size(unsigned int width, unsigned int h
 	return 64 * unit_size;
 }
 
-static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -390,7 +390,7 @@ static void *vdec_hevc_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 	return ctrl->p_cur.p;
 }
 
-static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
+static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_dec_ctx *ctx,
 				    struct slice_api_hevc_decode_param *decode_params,
 				    struct mtk_hevc_dpb_info *hevc_dpb_info)
 {
@@ -679,7 +679,7 @@ static void vdec_hevc_slice_free_mv_buf(struct vdec_hevc_slice_inst *inst)
 
 static void vdec_hevc_slice_get_pic_info(struct vdec_hevc_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	u32 data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -798,7 +798,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 					     struct vdec_lat_buf *lat_buf)
 {
 	struct mtk_vcodec_mem *mem;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	struct vb2_v4l2_buffer *vb2_v4l2;
 	struct vdec_fb *fb;
 	u64 y_fb_dma, c_fb_dma;
@@ -853,7 +853,7 @@ static int vdec_hevc_slice_setup_core_buffer(struct vdec_hevc_slice_inst *inst,
 	return 0;
 }
 
-static int vdec_hevc_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_hevc_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_hevc_slice_inst *inst;
 	int err, vsi_size;
@@ -924,7 +924,7 @@ static void vdec_hevc_slice_deinit(void *h_vdec)
 static int vdec_hevc_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	int err, timeout;
-	struct mtk_vcodec_ctx *ctx = lat_buf->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = lat_buf->ctx;
 	struct vdec_hevc_slice_inst *inst = ctx->drv_handle;
 	struct vdec_hevc_slice_share_info *share_info = lat_buf->private_data;
 	struct vdec_vpu_inst *vpu = &inst->vpu;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 1d4597f28a42..16007b659664 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -158,7 +158,7 @@ struct vdec_vp8_inst {
 	struct mtk_vcodec_mem working_buf;
 	struct vdec_vp8_hw_reg_base reg_base;
 	unsigned int frm_cnt;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp8_vsi *vsi;
 };
@@ -386,7 +386,7 @@ static void free_working_buf(struct vdec_vp8_inst *inst)
 	inst->vsi->dec.working_buf_dma = 0;
 }
 
-static int vdec_vp8_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp8_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp8_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index 4193fe20bb92..d3103b877b61 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -101,12 +101,12 @@ struct vdec_vp8_slice_inst {
 	struct mtk_vcodec_mem wrap_y_buf;
 	struct mtk_vcodec_mem wrap_c_buf;
 	struct mtk_vcodec_mem vld_wrapper_buf;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp8_slice_vsi *vsi;
 };
 
-static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
+static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_dec_ctx *ctx, int id)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl, id);
 
@@ -118,7 +118,7 @@ static void *vdec_vp8_slice_get_ctrl_ptr(struct mtk_vcodec_ctx *ctx, int id)
 
 static void vdec_vp8_slice_get_pic_info(struct vdec_vp8_slice_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	unsigned int data[3];
 
 	data[0] = ctx->picinfo.pic_w;
@@ -233,7 +233,7 @@ static u64 vdec_vp8_slice_get_ref_by_ts(const struct v4l2_ctrl_vp8_frame *frame_
 static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst)
 {
 	const struct v4l2_ctrl_vp8_frame *frame_header;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 	struct vb2_queue *vq;
 	struct vb2_buffer *vb;
 	u64 referenct_ts;
@@ -272,7 +272,7 @@ static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst
 	return 0;
 }
 
-static int vdec_vp8_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp8_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp8_slice_inst *inst;
 	int err;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
index b418db1b3e89..a8b3d1a06d78 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
@@ -196,7 +196,7 @@ struct vdec_vp9_inst {
 	struct list_head fb_free_list;
 	struct list_head fb_disp_list;
 	struct vdec_fb *cur_fb;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 	struct vdec_vp9_vsi *vsi;
 	unsigned int total_frm_cnt;
@@ -532,7 +532,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
 
 static bool vp9_wait_dec_end(struct vdec_vp9_inst *inst)
 {
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_wait_for_done_ctx(inst->ctx,
 			MTK_INST_IRQ_RECEIVED,
@@ -544,7 +544,7 @@ static bool vp9_wait_dec_end(struct vdec_vp9_inst *inst)
 		return false;
 }
 
-static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_ctx *ctx)
+static struct vdec_vp9_inst *vp9_alloc_inst(struct mtk_vcodec_dec_ctx *ctx)
 {
 	int result;
 	struct mtk_vcodec_mem mem;
@@ -772,7 +772,7 @@ static void vdec_vp9_deinit(void *h_vdec)
 	vp9_free_inst(inst);
 }
 
-static int vdec_vp9_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp9_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp9_inst *inst;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 913077d6e701..106ee4daf00b 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -445,7 +445,7 @@ struct vdec_vp9_slice_ref {
  * @counts_helper:	counts table according to newest kernel spec
  */
 struct vdec_vp9_slice_instance {
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vpu_inst vpu;
 
 	int seq;
@@ -506,7 +506,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(struct vdec_vp9_slice_instance
 {
 	struct vdec_vp9_slice_frame_ctx *remote_frame_ctx;
 	struct vdec_vp9_slice_frame_ctx *frame_ctx;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	struct vdec_vp9_slice_init_vsi *vsi;
 	int ret = 0;
 
@@ -543,7 +543,7 @@ static int vdec_vp9_slice_init_default_frame_ctx(struct vdec_vp9_slice_instance
 static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *instance,
 					       struct vdec_vp9_slice_vsi *vsi)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	enum vdec_vp9_slice_resolution_level level;
 	/* super blocks */
 	unsigned int max_sb_w;
@@ -635,7 +635,7 @@ static int vdec_vp9_slice_alloc_working_buffer(struct vdec_vp9_slice_instance *i
 
 static void vdec_vp9_slice_free_working_buffer(struct vdec_vp9_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(instance->mv); i++) {
@@ -1850,7 +1850,7 @@ static int vdec_vp9_slice_update_core(struct vdec_vp9_slice_instance *instance,
 	return 0;
 }
 
-static int vdec_vp9_slice_init(struct mtk_vcodec_ctx *ctx)
+static int vdec_vp9_slice_init(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_vp9_slice_instance *instance;
 	struct vdec_vp9_slice_init_vsi *vsi;
@@ -1933,7 +1933,7 @@ static int vdec_vp9_slice_flush(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 static void vdec_vp9_slice_get_pic_info(struct vdec_vp9_slice_instance *instance)
 {
-	struct mtk_vcodec_ctx *ctx = instance->ctx;
+	struct mtk_vcodec_dec_ctx *ctx = instance->ctx;
 	unsigned int data[3];
 
 	mtk_vdec_debug(instance->ctx, "w %u h %u\n", ctx->picinfo.pic_w, ctx->picinfo.pic_h);
@@ -1984,7 +1984,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_vp9_slice_instance *instance = h_vdec;
 	struct vdec_vp9_slice_pfc *pfc = &instance->sc_pfc;
 	struct vdec_vp9_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2042,7 +2042,7 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	struct vdec_lat_buf *lat_buf;
 	struct vdec_vp9_slice_pfc *pfc;
 	struct vdec_vp9_slice_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	int ret;
 
 	if (!instance || !instance->ctx)
@@ -2137,7 +2137,7 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
 {
 	struct vdec_vp9_slice_instance *instance;
 	struct vdec_vp9_slice_pfc *pfc;
-	struct mtk_vcodec_ctx *ctx = NULL;
+	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	struct vdec_fb *fb = NULL;
 	int ret = -EINVAL;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
index e913f963b7db..f6abb9365234 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
@@ -15,7 +15,7 @@ struct vdec_common_if {
 	 * @ctx     : [in] mtk v4l2 context
 	 * @h_vdec  : [out] driver handle
 	 */
-	int (*init)(struct mtk_vcodec_ctx *ctx);
+	int (*init)(struct mtk_vcodec_dec_ctx *ctx);
 
 	/**
 	 * (*decode)() - trigger decode
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
index e66faf50892b..d0b459b1603f 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
@@ -14,7 +14,7 @@
 #include "vdec_drv_base.h"
 #include "mtk_vcodec_dec_pm.h"
 
-int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
+int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc)
 {
 	enum mtk_vdec_hw_arch hw_arch = ctx->dev->vdec_pdata->hw_arch;
 	int ret = 0;
@@ -68,7 +68,7 @@ int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 	return ret;
 }
 
-int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
+int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem *bs,
 		   struct vdec_fb *fb, bool *res_chg)
 {
 	int ret = 0;
@@ -100,7 +100,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
 	return ret;
 }
 
-int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
+int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_param_type type,
 		      void *out)
 {
 	int ret = 0;
@@ -115,7 +115,7 @@ int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
 	return ret;
 }
 
-void vdec_if_deinit(struct mtk_vcodec_ctx *ctx)
+void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx)
 {
 	if (!ctx->drv_handle)
 		return;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
index a8da6a59a6a5..816ed6ab1ed0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
@@ -69,14 +69,14 @@ extern const struct vdec_common_if vdec_av1_slice_lat_if;
  * @ctx	: [in] v4l2 context
  * @fourcc	: [in] video format fourcc, V4L2_PIX_FMT_H264/VP8/VP9..
  */
-int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
+int vdec_if_init(struct mtk_vcodec_dec_ctx *ctx, unsigned int fourcc);
 
 /**
  * vdec_if_deinit() - deinitialize decode driver
  * @ctx	: [in] v4l2 context
  *
  */
-void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
+void vdec_if_deinit(struct mtk_vcodec_dec_ctx *ctx);
 
 /**
  * vdec_if_decode() - trigger decode
@@ -90,7 +90,7 @@ void vdec_if_deinit(struct mtk_vcodec_ctx *ctx);
  *
  * Return: 0 on success. -EIO on unrecoverable error.
  */
-int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
+int vdec_if_decode(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_mem *bs,
 		   struct vdec_fb *fb, bool *res_chg);
 
 /**
@@ -99,7 +99,7 @@ int vdec_if_decode(struct mtk_vcodec_ctx *ctx, struct mtk_vcodec_mem *bs,
  * @type	: [in] input parameter type
  * @out	: [out] buffer to store query result
  */
-int vdec_if_get_param(struct mtk_vcodec_ctx *ctx, enum vdec_get_param_type type,
+int vdec_if_get_param(struct mtk_vcodec_dec_ctx *ctx, enum vdec_get_param_type type,
 		      void *out);
 
 #endif
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index bb2573e859eb..4e18ebf58248 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -199,7 +199,7 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue)
 }
 
 void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
-			   struct mtk_vcodec_ctx *ctx)
+			   struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct vdec_lat_buf *lat_buf;
 	struct mtk_vcodec_mem *mem;
@@ -239,8 +239,8 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 {
 	struct vdec_msg_queue *msg_queue =
 		container_of(work, struct vdec_msg_queue, core_work);
-	struct mtk_vcodec_ctx *ctx =
-		container_of(msg_queue, struct mtk_vcodec_ctx, msg_queue);
+	struct mtk_vcodec_dec_ctx *ctx =
+		container_of(msg_queue, struct mtk_vcodec_dec_ctx, msg_queue);
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
 
@@ -280,7 +280,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 }
 
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
-			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
+			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
 			int private_size)
 {
 	struct vdec_lat_buf *lat_buf;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index 2f82cc08caa3..1fb3f57c2384 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -17,7 +17,7 @@
 #define NUM_BUFFER_COUNT 3
 
 struct vdec_lat_buf;
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 struct mtk_vcodec_dev;
 typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
 
@@ -76,7 +76,7 @@ struct vdec_lat_buf {
 	struct media_request *src_buf_req;
 
 	void *private_data;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	core_decode_cb_t core_decode;
 	struct list_head lat_list;
 	struct list_head core_list;
@@ -119,7 +119,7 @@ struct vdec_msg_queue {
 	struct vdec_lat_buf empty_lat_buf;
 	wait_queue_head_t core_dec_done;
 	int status;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 };
 
 /**
@@ -132,7 +132,7 @@ struct vdec_msg_queue {
  * Return: returns 0 if init successfully, or fail.
  */
 int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
-			struct mtk_vcodec_ctx *ctx, core_decode_cb_t core_decode,
+			struct mtk_vcodec_dec_ctx *ctx, core_decode_cb_t core_decode,
 			int private_size);
 
 /**
@@ -188,6 +188,6 @@ bool vdec_msg_queue_wait_lat_buf_full(struct vdec_msg_queue *msg_queue);
  * @ctx: v4l2 ctx
  */
 void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
-			   struct mtk_vcodec_ctx *ctx);
+			   struct mtk_vcodec_dec_ctx *ctx);
 
 #endif
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
index 0436bba91457..c9766c108209 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
@@ -9,7 +9,7 @@
 
 #include "mtk_vcodec_fw.h"
 
-struct mtk_vcodec_ctx;
+struct mtk_vcodec_dec_ctx;
 
 /**
  * struct vdec_vpu_inst - VPU instance for video codec
@@ -40,7 +40,7 @@ struct vdec_vpu_inst {
 	uint32_t fw_abi_version;
 	uint32_t inst_id;
 	unsigned int signaled;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_dec_ctx *ctx;
 	wait_queue_head_t wq;
 	mtk_vcodec_ipi_handler handler;
 	unsigned int codec_type;
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 5abc9c4e6d4f..c5f9fc24a692 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -221,7 +221,7 @@ struct venc_h264_inst {
 	struct venc_vpu_inst vpu_inst;
 	struct venc_h264_vsi *vsi;
 	struct venc_h264_vsi_34 *vsi_34;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
@@ -409,7 +409,7 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 static unsigned int h264_enc_wait_venc_done(struct venc_h264_inst *inst)
 {
 	unsigned int irq_status = 0;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = (struct mtk_vcodec_enc_ctx *)inst->ctx;
 
 	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
 					  WAIT_INTR_TIMEOUT_MS, 0)) {
@@ -513,7 +513,7 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	unsigned int intra_period;
 	unsigned int irq_status;
 	struct venc_frame_info frame_info;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	mtk_venc_debug(ctx, "frm_cnt = %d\n ", inst->frm_cnt);
 
@@ -582,7 +582,7 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
 	memset(p, 0xff, size);
 }
 
-static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
+static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
 	int ret = 0;
@@ -620,7 +620,7 @@ static int h264_enc_encode(void *handle,
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	mtk_venc_debug(ctx, "opt %d ->", opt);
 
@@ -750,7 +750,7 @@ static int h264_enc_set_param(void *handle,
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 	const bool is_34bit = MTK_ENC_IOVA_IS_34BIT(ctx);
 
 	mtk_venc_debug(ctx, "->type=%d", type);
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index ff54064497f1..e8e4474eacc7 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -129,7 +129,7 @@ struct venc_vp8_inst {
 	unsigned int ts_mode;
 	struct venc_vpu_inst vpu_inst;
 	struct venc_vp8_vsi *vsi;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 static inline u32 vp8_enc_read_reg(struct venc_vp8_inst *inst, u32 addr)
@@ -209,7 +209,7 @@ static int vp8_enc_alloc_work_buf(struct venc_vp8_inst *inst)
 static unsigned int vp8_enc_wait_venc_done(struct venc_vp8_inst *inst)
 {
 	unsigned int irq_status = 0;
-	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = (struct mtk_vcodec_enc_ctx *)inst->ctx;
 
 	if (!mtk_vcodec_wait_for_done_ctx(ctx, MTK_INST_IRQ_RECEIVED,
 					  WAIT_INTR_TIMEOUT_MS, 0)) {
@@ -312,7 +312,7 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst *inst,
 	return ret;
 }
 
-static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
+static int vp8_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = 0;
 	struct venc_vp8_inst *inst;
@@ -346,7 +346,7 @@ static int vp8_enc_encode(void *handle,
 {
 	int ret = 0;
 	struct venc_vp8_inst *inst = (struct venc_vp8_inst *)handle;
-	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct mtk_vcodec_enc_ctx *ctx = inst->ctx;
 
 	enable_irq(ctx->dev->enc_irq);
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
index 3d718411dc73..17f8183461b5 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
@@ -19,7 +19,7 @@ struct venc_common_if {
 	 * @ctx:	[in] mtk v4l2 context
 	 * @handle: [out] driver handle
 	 */
-	int (*init)(struct mtk_vcodec_ctx *ctx);
+	int (*init)(struct mtk_vcodec_enc_ctx *ctx);
 
 	/**
 	 * (*encode)() - trigger encode
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index ce0bce811615..08083030516e 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -16,7 +16,7 @@
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 
-int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
+int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc)
 {
 	int ret = 0;
 
@@ -40,8 +40,8 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 	return ret;
 }
 
-int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
-		enum venc_set_param_type type, struct venc_enc_param *in)
+int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
+		      enum venc_set_param_type type, struct venc_enc_param *in)
 {
 	int ret = 0;
 
@@ -54,7 +54,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
 	return ret;
 }
 
-int venc_if_encode(struct mtk_vcodec_ctx *ctx,
+int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 		   enum venc_start_opt opt, struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
 		   struct venc_done_result *result)
@@ -65,7 +65,7 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 	mtk_venc_lock(ctx);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = ctx;
+	ctx->dev->curr_enc_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
@@ -74,14 +74,14 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = NULL;
+	ctx->dev->curr_enc_ctx = NULL;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_venc_unlock(ctx);
 	return ret;
 }
 
-int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
+int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx)
 {
 	int ret = 0;
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index 0b04a1020873..90d714e86ede 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -132,14 +132,14 @@ extern const struct venc_common_if venc_vp8_if;
  * @fourcc: encoder input format
  * Return: 0 if creating handle successfully, otherwise it is failed.
  */
-int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc);
+int venc_if_init(struct mtk_vcodec_enc_ctx *ctx, unsigned int fourcc);
 
 /*
  * venc_if_deinit - Release the driver handle
  * @ctx: device context
  * Return: 0 if releasing handle successfully, otherwise it is failed.
  */
-int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
+int venc_if_deinit(struct mtk_vcodec_enc_ctx *ctx);
 
 /*
  * venc_if_set_param - Set parameter to driver
@@ -148,7 +148,7 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx);
  * @in: input parameter
  * Return: 0 if setting param successfully, otherwise it is failed.
  */
-int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
+int venc_if_set_param(struct mtk_vcodec_enc_ctx *ctx,
 		      enum venc_set_param_type type,
 		      struct venc_enc_param *in);
 
@@ -161,7 +161,7 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
  * @result: encode result
  * Return: 0 if encoding frame successfully, otherwise it is failed.
  */
-int venc_if_encode(struct mtk_vcodec_ctx *ctx,
+int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 		   enum venc_start_opt opt,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
index f83bc1b3f2bf..71370ab98809 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
@@ -35,7 +35,7 @@ struct venc_vpu_inst {
 	unsigned int inst_addr;
 	void *vsi;
 	int id;
-	struct mtk_vcodec_ctx *ctx;
+	struct mtk_vcodec_enc_ctx *ctx;
 };
 
 int vpu_enc_init(struct venc_vpu_inst *vpu);
-- 
2.18.0

