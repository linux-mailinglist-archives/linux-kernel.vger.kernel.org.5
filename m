Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07151767BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjG2C4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjG2Czl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:55:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24D49E8;
        Fri, 28 Jul 2023 19:55:33 -0700 (PDT)
X-UUID: 5e7f27b82dbb11ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qxqvovo1u8HuRgRYu8Az45IxSDM7oH8Y7nATgTHkngo=;
        b=ODCJN+lSQ6lfcrDDWiQH+8cIi2Sy4saAUYxr1y4IibX6KAvO6ZW66QcKSK7w211krB/S8VNZhXrNv4sJHV0i9oThew6PvabZ6L4M1EPAx56chcpq8xxxsd73VAe3zz8glgm+8Aaa2rcZpHBqdwYfWjPbHGB11rg1RJZIdZdglho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:6f2f0486-5b59-4332-8b56-4c2bb98f7259,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:311273d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5e7f27b82dbb11ee9cb5633481061a41-20230729
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1917232019; Sat, 29 Jul 2023 10:55:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:55:24 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:55:24 +0800
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
Subject: [PATCH v8,08/11] media: mediatek: vcodec: separate struct mtk_vcodec_dev
Date:   Sat, 29 Jul 2023 10:55:11 +0800
Message-ID: <20230729025515.16029-9-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230729025515.16029-1-yunfei.dong@mediatek.com>
References: <20230729025515.16029-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding different dev struct for encoder and decoder, remove
'struct mtk_vcodec_dev'.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/vcodec/mtk_vcodec_cmn_drv.h      |  71 +++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        |  49 ++-
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  14 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  21 +-
 .../mediatek/vcodec/mtk_vcodec_dec_drv.h      | 174 +++++++++-
 .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   5 +-
 .../mediatek/vcodec/mtk_vcodec_dec_hw.h       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |  10 +-
 .../mediatek/vcodec/mtk_vcodec_dec_pm.h       |   2 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c |   3 +-
 .../vcodec/mtk_vcodec_dec_stateless.c         |   5 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 297 ------------------
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c |   5 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  15 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.h      |  93 +++++-
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |   4 +-
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |   4 +-
 .../platform/mediatek/vcodec/mtk_vcodec_fw.c  |  12 +-
 .../platform/mediatek/vcodec/mtk_vcodec_fw.h  |   3 +-
 .../mediatek/vcodec/mtk_vcodec_fw_priv.h      |   3 +-
 .../mediatek/vcodec/mtk_vcodec_fw_scp.c       |  21 +-
 .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |  18 +-
 .../mediatek/vcodec/mtk_vcodec_intr.c         |   4 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  12 +-
 .../mediatek/vcodec/mtk_vcodec_util.h         |   8 +-
 .../vcodec/vdec/vdec_h264_req_common.h        |   2 +-
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |   2 +-
 .../platform/mediatek/vcodec/vdec_drv_if.h    |   1 -
 .../platform/mediatek/vcodec/vdec_msg_queue.c |   4 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h |   2 +-
 .../platform/mediatek/vcodec/vdec_vpu_if.c    |   3 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       |   2 +-
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   2 +-
 .../platform/mediatek/vcodec/venc_drv_base.h  |   2 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |   4 +-
 .../platform/mediatek/vcodec/venc_drv_if.h    |   3 +-
 .../platform/mediatek/vcodec/venc_vpu_if.c    |   2 +-
 38 files changed, 468 insertions(+), 422 deletions(-)
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
index 3b6e1faf60ce..6087e27bd604 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_cmn_drv.h
@@ -17,6 +17,77 @@
 
 #define MTK_VCODEC_MAX_PLANES	3
 
+#define WAIT_INTR_TIMEOUT_MS	1000
+
+/*
+ * enum mtk_q_type - Type of queue
+ */
+enum mtk_q_type {
+	MTK_Q_DATA_SRC = 0,
+	MTK_Q_DATA_DST = 1,
+};
+
+/*
+ * enum mtk_hw_reg_idx - MTK hw register base index
+ */
+enum mtk_hw_reg_idx {
+	VDEC_SYS,
+	VDEC_MISC,
+	VDEC_LD,
+	VDEC_TOP,
+	VDEC_CM,
+	VDEC_AD,
+	VDEC_AV,
+	VDEC_PP,
+	VDEC_HWD,
+	VDEC_HWQ,
+	VDEC_HWB,
+	VDEC_HWG,
+	NUM_MAX_VDEC_REG_BASE,
+	/* h264 encoder */
+	VENC_SYS = NUM_MAX_VDEC_REG_BASE,
+	/* vp8 encoder */
+	VENC_LT_SYS,
+	NUM_MAX_VCODEC_REG_BASE
+};
+
+/*
+ * struct mtk_vcodec_clk_info - Structure used to store clock name
+ */
+struct mtk_vcodec_clk_info {
+	const char	*clk_name;
+	struct clk	*vcodec_clk;
+};
+
+/*
+ * struct mtk_vcodec_clk - Structure used to store vcodec clock information
+ */
+struct mtk_vcodec_clk {
+	struct mtk_vcodec_clk_info	*clk_info;
+	int	clk_num;
+};
+
+/*
+ * struct mtk_vcodec_pm - Power management data structure
+ */
+struct mtk_vcodec_pm {
+	struct mtk_vcodec_clk	vdec_clk;
+	struct mtk_vcodec_clk	venc_clk;
+	struct device	*dev;
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
 /**
  * enum mtk_instance_state - The state of an MTK Vcodec instance.
  * @MTK_STATE_FREE: default state when instance is created
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
index 95fd51817b8e..0f7419ee297b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
@@ -7,7 +7,8 @@
 #include <linux/debugfs.h>
 
 #include "mtk_vcodec_dbgfs.h"
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_util.h"
 
 static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ctx, char *buf,
@@ -72,7 +73,7 @@ static void mtk_vdec_dbgfs_get_help(char *buf, int *used, int total)
 static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 				    size_t count, loff_t *ppos)
 {
-	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dec_dev *vcodec_dev = filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 
 	mutex_lock(&dbgfs->dbgfs_lock);
@@ -88,7 +89,7 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 				   size_t count, loff_t *ppos)
 {
-	struct mtk_vcodec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dec_dev *vcodec_dev = filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
 	struct mtk_vcodec_dec_ctx *ctx;
@@ -146,7 +147,7 @@ static const struct file_operations vdec_fops = {
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
-	struct mtk_vcodec_dev *vcodec_dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *vcodec_dev = ctx->dev;
 
 	dbgfs_inst = kzalloc(sizeof(*dbgfs_inst), GFP_KERNEL);
 	if (!dbgfs_inst)
@@ -161,7 +162,7 @@ void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_create);
 
-void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
+void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dec_dev *vcodec_dev, int ctx_id)
 {
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
 
@@ -176,14 +177,11 @@ void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_remove);
 
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode)
+static void mtk_vcodec_dbgfs_vdec_init(struct mtk_vcodec_dec_dev *vcodec_dev)
 {
 	struct dentry *vcodec_root;
 
-	if (is_encode)
-		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-enc", NULL);
-	else
-		vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
+	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-dec", NULL);
 	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
 		dev_err(&vcodec_dev->plat_dev->dev, "create vcodec dir err:%ld\n",
 			PTR_ERR(vcodec_dev->dbgfs.vcodec_root));
@@ -193,18 +191,39 @@ void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode)
 	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
 
 	vcodec_dev->dbgfs.inst_count = 0;
-	if (is_encode)
-		return;
-
 	INIT_LIST_HEAD(&vcodec_dev->dbgfs.dbgfs_head);
 	debugfs_create_file("vdec", 0200, vcodec_root, vcodec_dev, &vdec_fops);
 	mutex_init(&vcodec_dev->dbgfs.dbgfs_lock);
 }
+
+static void mtk_vcodec_dbgfs_venc_init(struct mtk_vcodec_enc_dev *vcodec_dev)
+{
+	struct dentry *vcodec_root;
+
+	vcodec_dev->dbgfs.vcodec_root = debugfs_create_dir("vcodec-enc", NULL);
+	if (IS_ERR(vcodec_dev->dbgfs.vcodec_root))
+		dev_err(&vcodec_dev->plat_dev->dev, "create venc dir err:%d\n",
+			IS_ERR(vcodec_dev->dbgfs.vcodec_root));
+
+	vcodec_root = vcodec_dev->dbgfs.vcodec_root;
+	debugfs_create_x32("mtk_v4l2_dbg_level", 0644, vcodec_root, &mtk_v4l2_dbg_level);
+	debugfs_create_x32("mtk_vcodec_dbg", 0644, vcodec_root, &mtk_vcodec_dbg);
+
+	vcodec_dev->dbgfs.inst_count = 0;
+}
+
+void mtk_vcodec_dbgfs_init(void *vcodec_dev, bool is_encode)
+{
+	if (is_encode)
+		mtk_vcodec_dbgfs_venc_init(vcodec_dev);
+	else
+		mtk_vcodec_dbgfs_vdec_init(vcodec_dev);
+}
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_init);
 
-void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev)
+void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dbgfs *dbgfs)
 {
-	debugfs_remove_recursive(vcodec_dev->dbgfs.vcodec_root);
+	debugfs_remove_recursive(dbgfs->vcodec_root);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dbgfs_deinit);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
index 372413d590c5..073d2fedb54a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
@@ -7,7 +7,7 @@
 #ifndef __MTK_VCODEC_DBGFS_H__
 #define __MTK_VCODEC_DBGFS_H__
 
-struct mtk_vcodec_dev;
+struct mtk_vcodec_dec_dev;
 struct mtk_vcodec_dec_ctx;
 
 /*
@@ -51,23 +51,23 @@ struct mtk_vcodec_dbgfs {
 
 #if defined(CONFIG_DEBUG_FS)
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx);
-void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id);
-void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode);
-void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev);
+void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dec_dev *vcodec_dev, int ctx_id);
+void mtk_vcodec_dbgfs_init(void *vcodec_dev, bool is_encode);
+void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dbgfs *dbgfs);
 #else
 static inline void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
 {
 }
 
-static inline void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dev *vcodec_dev, int ctx_id)
+static inline void mtk_vcodec_dbgfs_remove(struct mtk_vcodec_dec_dev *vcodec_dev, int ctx_id)
 {
 }
 
-static inline void mtk_vcodec_dbgfs_init(struct mtk_vcodec_dev *vcodec_dev, bool is_encode)
+static inline void mtk_vcodec_dbgfs_init(void *vcodec_dev, bool is_encode)
 {
 }
 
-static inline void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dev *vcodec_dev)
+static inline void mtk_vcodec_dbgfs_deinit(struct mtk_vcodec_dbgfs *dbgfs)
 {
 }
 #endif
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 619ff3dd8d50..0363fec572e5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -9,7 +9,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
@@ -890,7 +890,7 @@ void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 static void m2mops_vdec_device_run(void *priv)
 {
 	struct mtk_vcodec_dec_ctx *ctx = priv;
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 
 	queue_work(dev->decode_workqueue, &ctx->decode_work);
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index d36a05275f11..410978cc8031 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -21,7 +21,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <media/v4l2-device.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
@@ -29,7 +28,7 @@
 #include "mtk_vcodec_util.h"
 #include "mtk_vcodec_fw.h"
 
-static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_dev *dev)
+static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_dec_dev *dev)
 {
 	switch (dev->vdec_pdata->hw_arch) {
 	case MTK_VDEC_PURE_SINGLE_CORE:
@@ -42,7 +41,7 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vc
 	}
 }
 
-static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
+static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dec_dev *dev)
 {
 	u32 cg_status;
 
@@ -56,7 +55,7 @@ static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
 
 static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 {
-	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_dec_dev *dev = priv;
 	struct mtk_vcodec_dec_ctx *ctx;
 	unsigned int dec_done_status = 0;
 	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
@@ -88,7 +87,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
-static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
+static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dec_dev *dev)
 {
 	struct platform_device *pdev = dev->plat_dev;
 	int reg_num, i;
@@ -156,7 +155,7 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
 	return 0;
 }
 
-static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
+static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dec_dev *dev)
 {
 	struct platform_device *pdev = dev->plat_dev;
 	int ret;
@@ -193,7 +192,7 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
 
 static int fops_vcodec_open(struct file *file)
 {
-	struct mtk_vcodec_dev *dev = video_drvdata(file);
+	struct mtk_vcodec_dec_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_dec_ctx *ctx = NULL;
 	int ret = 0, i, hw_count;
 	struct vb2_queue *src_vq;
@@ -290,7 +289,7 @@ static int fops_vcodec_open(struct file *file)
 
 static int fops_vcodec_release(struct file *file)
 {
-	struct mtk_vcodec_dev *dev = video_drvdata(file);
+	struct mtk_vcodec_dec_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(file->private_data);
 
 	mtk_v4l2_vdec_dbg(0, ctx, "[%d] decoder", ctx->id);
@@ -327,7 +326,7 @@ static const struct v4l2_file_operations mtk_vcodec_fops = {
 
 static int mtk_vcodec_probe(struct platform_device *pdev)
 {
-	struct mtk_vcodec_dev *dev;
+	struct mtk_vcodec_dec_dev *dev;
 	struct video_device *vfd_dec;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
@@ -534,7 +533,7 @@ MODULE_DEVICE_TABLE(of, mtk_vcodec_match);
 
 static void mtk_vcodec_dec_remove(struct platform_device *pdev)
 {
-	struct mtk_vcodec_dev *dev = platform_get_drvdata(pdev);
+	struct mtk_vcodec_dec_dev *dev = platform_get_drvdata(pdev);
 
 	destroy_workqueue(dev->decode_workqueue);
 
@@ -550,7 +549,7 @@ static void mtk_vcodec_dec_remove(struct platform_device *pdev)
 	if (dev->vfd_dec)
 		video_unregister_device(dev->vfd_dec);
 
-	mtk_vcodec_dbgfs_deinit(dev);
+	mtk_vcodec_dbgfs_deinit(&dev->dbgfs);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	if (!dev->vdec_pdata->is_subdev_supported)
 		pm_runtime_disable(dev->pm.dev);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
index 468583a43b7e..533d8d97f704 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
@@ -8,9 +8,49 @@
 #define _MTK_VCODEC_DEC_DRV_H_
 
 #include "mtk_vcodec_cmn_drv.h"
+#include "mtk_vcodec_dbgfs.h"
 #include "mtk_vcodec_fw_priv.h"
+#include "mtk_vcodec_util.h"
 #include "vdec_msg_queue.h"
 
+#define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
+
+#define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
+#define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
+
+/*
+ * struct mtk_vdec_format_types - Structure used to get supported
+ *		  format types according to decoder capability
+ */
+enum mtk_vdec_format_types {
+	MTK_VDEC_FORMAT_MM21 = 0x20,
+	MTK_VDEC_FORMAT_MT21C = 0x40,
+	MTK_VDEC_FORMAT_H264_SLICE = 0x100,
+	MTK_VDEC_FORMAT_VP8_FRAME = 0x200,
+	MTK_VDEC_FORMAT_VP9_FRAME = 0x400,
+	MTK_VDEC_FORMAT_AV1_FRAME = 0x800,
+	MTK_VDEC_FORMAT_HEVC_FRAME = 0x1000,
+	MTK_VCODEC_INNER_RACING = 0x20000,
+};
+
+/*
+ * enum mtk_vdec_hw_count - Supported hardware count
+ */
+enum mtk_vdec_hw_count {
+	MTK_VDEC_NO_HW = 0,
+	MTK_VDEC_ONE_CORE,
+	MTK_VDEC_ONE_LAT_ONE_CORE,
+	MTK_VDEC_MAX_HW_COUNT,
+};
+
+/*
+ * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
+ */
+enum mtk_vdec_hw_arch {
+	MTK_VDEC_PURE_SINGLE_CORE,
+	MTK_VDEC_LAT_SINGLE_CORE,
+};
+
 /**
  * struct vdec_pic_info  - picture size information
  * @pic_w: picture width
@@ -33,24 +73,54 @@ struct vdec_pic_info {
 	unsigned int reserved;
 };
 
-/*
- * enum mtk_vdec_hw_id - Hardware index used to separate
- *                         different hardware
+/**
+ * struct mtk_vcodec_dec_pdata - compatible data for each IC
+ * @init_vdec_params: init vdec params
+ * @ctrls_setup: init vcodec dec ctrls
+ * @worker: worker to start a decode job
+ * @flush_decoder: function that flushes the decoder
+ * @get_cap_buffer: get capture buffer from capture queue
+ * @cap_to_disp: put capture buffer to disp list for lat and core arch
+ * @vdec_vb2_ops: struct vb2_ops
+ *
+ * @vdec_formats: supported video decoder formats
+ * @num_formats: count of video decoder formats
+ * @default_out_fmt: default output buffer format
+ * @default_cap_fmt: default capture buffer format
+ *
+ * @hw_arch: hardware arch is used to separate pure_sin_core and lat_sin_core
+ *
+ * @is_subdev_supported: whether support parent-node architecture(subdev)
+ * @uses_stateless_api: whether the decoder uses the stateless API with requests
  */
-enum mtk_vdec_hw_id {
-	MTK_VDEC_CORE,
-	MTK_VDEC_LAT0,
-	MTK_VDEC_LAT1,
-	MTK_VDEC_LAT_SOC,
-	MTK_VDEC_HW_MAX,
+struct mtk_vcodec_dec_pdata {
+	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
+	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
+	void (*worker)(struct work_struct *work);
+	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
+	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
+	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
+			    struct media_request *src_buf_req);
+
+	const struct vb2_ops *vdec_vb2_ops;
+
+	const struct mtk_video_fmt *vdec_formats;
+	const int *num_formats;
+	const struct mtk_video_fmt *default_out_fmt;
+	const struct mtk_video_fmt *default_cap_fmt;
+
+	enum mtk_vdec_hw_arch hw_arch;
+
+	bool is_subdev_supported;
+	bool uses_stateless_api;
 };
 
 /**
  * struct mtk_vcodec_dec_ctx - Context (instance) private data.
  *
  * @type: type of decoder instance
- * @dev: pointer to the mtk_vcodec_dev of the device
- * @list: link to ctx_list of mtk_vcodec_dev
+ * @dev: pointer to the mtk_vcodec_dec_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_dec_dev
  *
  * @fh: struct v4l2_fh
  * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
@@ -93,7 +163,7 @@ enum mtk_vdec_hw_id {
  */
 struct mtk_vcodec_dec_ctx {
 	enum mtk_instance_type type;
-	struct mtk_vcodec_dev *dev;
+	struct mtk_vcodec_dec_dev *dev;
 	struct list_head list;
 
 	struct v4l2_fh fh;
@@ -134,6 +204,86 @@ struct mtk_vcodec_dec_ctx {
 	struct vdec_msg_queue msg_queue;
 };
 
+/**
+ * struct mtk_vcodec_dec_dev - driver data
+ * @v4l2_dev: V4L2 device to register video devices for.
+ * @vfd_dec: Video device for decoder
+ * @mdev_dec: Media device for decoder
+ *
+ * @m2m_dev_dec: m2m device for decoder
+ * @plat_dev: platform device
+ * @ctx_list: list of struct mtk_vcodec_ctx
+ * @curr_ctx: The context that is waiting for codec hardware
+ *
+ * @reg_base: Mapped address of MTK Vcodec registers.
+ * @vdec_pdata: decoder IC-specific data
+ * @vdecsys_regmap: VDEC_SYS register space passed through syscon
+ *
+ * @fw_handler: used to communicate with the firmware.
+ * @id_counter: used to identify current opened instance
+ *
+ * @dec_mutex: decoder hardware lock
+ * @dev_mutex: video_device lock
+ * @decode_workqueue: decode work queue
+ *
+ * @irqlock: protect data access by irq handler and work thread
+ * @dec_irq: decoder irq resource
+ *
+ * @pm: power management control
+ * @dec_capability: used to identify decode capability, ex: 4k
+ *
+ * @core_workqueue: queue used for core hardware decode
+ *
+ * @subdev_dev: subdev hardware device
+ * @subdev_prob_done: check whether all used hw device is prob done
+ * @subdev_bitmap: used to record hardware is ready or not
+ *
+ * @dec_active_cnt: used to mark whether need to record register value
+ * @vdec_racing_info: record register value
+ * @dec_racing_info_mutex: mutex lock used for inner racing mode
+ * @dbgfs: debug log related information
+ */
+struct mtk_vcodec_dec_dev {
+	struct v4l2_device v4l2_dev;
+	struct video_device *vfd_dec;
+	struct media_device mdev_dec;
+
+	struct v4l2_m2m_dev *m2m_dev_dec;
+	struct platform_device *plat_dev;
+	struct list_head ctx_list;
+	struct mtk_vcodec_dec_ctx *curr_ctx;
+
+	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
+	const struct mtk_vcodec_dec_pdata *vdec_pdata;
+	struct regmap *vdecsys_regmap;
+
+	struct mtk_vcodec_fw *fw_handler;
+	unsigned long id_counter;
+
+	/* decoder hardware mutex lock */
+	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
+	struct mutex dev_mutex;
+	struct workqueue_struct *decode_workqueue;
+
+	spinlock_t irqlock;
+	int dec_irq;
+
+	struct mtk_vcodec_pm pm;
+	unsigned int dec_capability;
+
+	struct workqueue_struct *core_workqueue;
+
+	void *subdev_dev[MTK_VDEC_HW_MAX];
+	int (*subdev_prob_done)(struct mtk_vcodec_dec_dev *vdec_dev);
+	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
+
+	atomic_t dec_active_cnt;
+	u32 vdec_racing_info[132];
+	/* Protects access to vdec_racing_info data */
+	struct mutex dec_racing_info_mutex;
+	struct mtk_vcodec_dbgfs dbgfs;
+};
+
 static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)
 {
 	return container_of(fh, struct mtk_vcodec_dec_ctx, fh);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index 73c25b0c7678..1f49a4da27ea 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -12,7 +12,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
@@ -36,7 +35,7 @@ static const struct of_device_id mtk_vdec_hw_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_vdec_hw_match);
 
-static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dev *vdec_dev)
+static int mtk_vdec_hw_prob_done(struct mtk_vcodec_dec_dev *vdec_dev)
 {
 	struct platform_device *pdev = vdec_dev->plat_dev;
 	struct device_node *subdev_node;
@@ -123,7 +122,7 @@ static int mtk_vdec_hw_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_vdec_hw_dev *subdev_dev;
-	struct mtk_vcodec_dev *main_dev;
+	struct mtk_vcodec_dec_dev *main_dev;
 	const struct of_device_id *of_id;
 	int hw_idx;
 	int ret;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
index 696e9eeb03a2..83fe8b9428e6 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_dec_drv.h"
 
 #define VDEC_HW_ACTIVE_ADDR 0x0
 #define VDEC_HW_ACTIVE_MASK BIT(4)
@@ -46,7 +46,7 @@ enum mtk_vdec_hw_reg_idx {
  */
 struct mtk_vdec_hw_dev {
 	struct platform_device *plat_dev;
-	struct mtk_vcodec_dev *main_dev;
+	struct mtk_vcodec_dec_dev *main_dev;
 	void __iomem *reg_base[VDEC_HW_MAX];
 
 	struct mtk_vcodec_dec_ctx *curr_ctx;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index fe1813d72336..4bc16e1b1c10 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -106,7 +106,7 @@ static void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
 
-static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dec_dev *vdec_dev, int hw_idx)
 {
 	struct mtk_vdec_hw_dev *subdev_dev;
 
@@ -124,7 +124,7 @@ static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_id
 	}
 }
 
-static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_idx)
+static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dec_dev *vdec_dev, int hw_idx)
 {
 	struct mtk_vdec_hw_dev *subdev_dev;
 
@@ -170,7 +170,7 @@ static void mtk_vcodec_record_racing_info(struct mtk_vcodec_dec_ctx *ctx)
 	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
 }
 
-static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dev *vdec_dev,
+static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dec_dev *vdec_dev,
 						   int hw_idx)
 {
 	struct mtk_vdec_hw_dev *subdev_dev;
@@ -190,7 +190,7 @@ static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dev *vdec_d
 	return &vdec_dev->pm;
 }
 
-static void mtk_vcodec_dec_child_dev_on(struct mtk_vcodec_dev *vdec_dev,
+static void mtk_vcodec_dec_child_dev_on(struct mtk_vcodec_dec_dev *vdec_dev,
 					int hw_idx)
 {
 	struct mtk_vcodec_pm *pm;
@@ -210,7 +210,7 @@ static void mtk_vcodec_dec_child_dev_on(struct mtk_vcodec_dev *vdec_dev,
 	}
 }
 
-static void mtk_vcodec_dec_child_dev_off(struct mtk_vcodec_dev *vdec_dev,
+static void mtk_vcodec_dec_child_dev_off(struct mtk_vcodec_dec_dev *vdec_dev,
 					 int hw_idx)
 {
 	struct mtk_vcodec_pm *pm;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
index f6c68e57bcc1..87a50d589d42 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
@@ -7,7 +7,7 @@
 #ifndef _MTK_VCODEC_DEC_PM_H_
 #define _MTK_VCODEC_DEC_PM_H_
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_dec_drv.h"
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm);
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 93230fe7ab97..459e74a46737 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -4,7 +4,6 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
@@ -279,7 +278,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 {
 	struct mtk_vcodec_dec_ctx *ctx =
 		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem buf;
 	struct vdec_fb *pfb;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 9f9d2425a060..c65744d3cd28 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -6,7 +6,6 @@
 #include <media/v4l2-mem2mem.h>
 #include <linux/module.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
@@ -288,7 +287,7 @@ static void mtk_vdec_worker(struct work_struct *work)
 {
 	struct mtk_vcodec_dec_ctx *ctx =
 		container_of(work, struct mtk_vcodec_dec_ctx, decode_work);
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *vb2_v4l2_src;
 	struct vb2_buffer *vb2_src;
 	struct mtk_vcodec_mem *bs_src;
@@ -444,7 +443,7 @@ const struct media_device_ops mtk_vcodec_media_ops = {
 static void mtk_vcodec_add_formats(unsigned int fourcc,
 				   struct mtk_vcodec_dec_ctx *ctx)
 {
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 	const struct mtk_vcodec_dec_pdata *pdata = dev->vdec_pdata;
 	int count_formats = *pdata->num_formats;
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
deleted file mode 100644
index 0b32a7869993..000000000000
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ /dev/null
@@ -1,297 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
-* Copyright (c) 2016 MediaTek Inc.
-* Author: PC Chen <pc.chen@mediatek.com>
-*         Tiffany Lin <tiffany.lin@mediatek.com>
-*/
-
-#ifndef _MTK_VCODEC_DRV_H_
-#define _MTK_VCODEC_DRV_H_
-
-#include <linux/platform_device.h>
-#include <linux/videodev2.h>
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-ioctl.h>
-#include <media/v4l2-mem2mem.h>
-#include <media/videobuf2-core.h>
-
-#include "mtk_vcodec_dbgfs.h"
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_util.h"
-#include "vdec_msg_queue.h"
-
-#define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
-#define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
-
-#define MTK_V4L2_BENCHMARK	0
-#define WAIT_INTR_TIMEOUT_MS	1000
-#define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
-#define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
-
-/*
- * enum mtk_hw_reg_idx - MTK hw register base index
- */
-enum mtk_hw_reg_idx {
-	VDEC_SYS,
-	VDEC_MISC,
-	VDEC_LD,
-	VDEC_TOP,
-	VDEC_CM,
-	VDEC_AD,
-	VDEC_AV,
-	VDEC_PP,
-	VDEC_HWD,
-	VDEC_HWQ,
-	VDEC_HWB,
-	VDEC_HWG,
-	NUM_MAX_VDEC_REG_BASE,
-	/* h264 encoder */
-	VENC_SYS = NUM_MAX_VDEC_REG_BASE,
-	/* vp8 encoder */
-	VENC_LT_SYS,
-	NUM_MAX_VCODEC_REG_BASE
-};
-
-
-
-/*
- * enum mtk_vdec_hw_count - Supported hardware count
- */
-enum mtk_vdec_hw_count {
-	MTK_VDEC_NO_HW = 0,
-	MTK_VDEC_ONE_CORE,
-	MTK_VDEC_ONE_LAT_ONE_CORE,
-	MTK_VDEC_MAX_HW_COUNT,
-};
-
-/*
- * enum mtk_q_type - Type of queue
- */
-enum mtk_q_type {
-	MTK_Q_DATA_SRC = 0,
-	MTK_Q_DATA_DST = 1,
-};
-
-
-/*
- * struct mtk_vcodec_clk_info - Structure used to store clock name
- */
-struct mtk_vcodec_clk_info {
-	const char	*clk_name;
-	struct clk	*vcodec_clk;
-};
-
-/*
- * struct mtk_vcodec_clk - Structure used to store vcodec clock information
- */
-struct mtk_vcodec_clk {
-	struct mtk_vcodec_clk_info	*clk_info;
-	int	clk_num;
-};
-
-/*
- * struct mtk_vcodec_pm - Power management data structure
- */
-struct mtk_vcodec_pm {
-	struct mtk_vcodec_clk	vdec_clk;
-	struct mtk_vcodec_clk	venc_clk;
-	struct device	*dev;
-};
-
-/*
- * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
- */
-enum mtk_vdec_hw_arch {
-	MTK_VDEC_PURE_SINGLE_CORE,
-	MTK_VDEC_LAT_SINGLE_CORE,
-};
-
-/*
- * struct mtk_vdec_format_types - Structure used to get supported
- *		  format types according to decoder capability
- */
-enum mtk_vdec_format_types {
-	MTK_VDEC_FORMAT_MM21 = 0x20,
-	MTK_VDEC_FORMAT_MT21C = 0x40,
-	MTK_VDEC_FORMAT_H264_SLICE = 0x100,
-	MTK_VDEC_FORMAT_VP8_FRAME = 0x200,
-	MTK_VDEC_FORMAT_VP9_FRAME = 0x400,
-	MTK_VDEC_FORMAT_AV1_FRAME = 0x800,
-	MTK_VDEC_FORMAT_HEVC_FRAME = 0x1000,
-	MTK_VCODEC_INNER_RACING = 0x20000,
-};
-
-/**
- * struct mtk_vcodec_dec_pdata - compatible data for each IC
- * @init_vdec_params: init vdec params
- * @ctrls_setup: init vcodec dec ctrls
- * @worker: worker to start a decode job
- * @flush_decoder: function that flushes the decoder
- * @get_cap_buffer: get capture buffer from capture queue
- * @cap_to_disp: put capture buffer to disp list for lat and core arch
- * @vdec_vb2_ops: struct vb2_ops
- *
- * @vdec_formats: supported video decoder formats
- * @num_formats: count of video decoder formats
- * @default_out_fmt: default output buffer format
- * @default_cap_fmt: default capture buffer format
- *
- * @hw_arch: hardware arch is used to separate pure_sin_core and lat_sin_core
- *
- * @is_subdev_supported: whether support parent-node architecture(subdev)
- * @uses_stateless_api: whether the decoder uses the stateless API with requests
- */
-
-struct mtk_vcodec_dec_pdata {
-	void (*init_vdec_params)(struct mtk_vcodec_dec_ctx *ctx);
-	int (*ctrls_setup)(struct mtk_vcodec_dec_ctx *ctx);
-	void (*worker)(struct work_struct *work);
-	int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
-	struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx);
-	void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
-			    struct media_request *src_buf_req);
-
-	struct vb2_ops *vdec_vb2_ops;
-
-	const struct mtk_video_fmt *vdec_formats;
-	const int *num_formats;
-	const struct mtk_video_fmt *default_out_fmt;
-	const struct mtk_video_fmt *default_cap_fmt;
-
-	enum mtk_vdec_hw_arch hw_arch;
-
-	bool is_subdev_supported;
-	bool uses_stateless_api;
-};
-
-/**
- * struct mtk_vcodec_enc_pdata - compatible data for each IC
- *
- * @uses_ext: whether the encoder uses the extended firmware messaging format
- * @min_bitrate: minimum supported encoding bitrate
- * @max_bitrate: maximum supported encoding bitrate
- * @capture_formats: array of supported capture formats
- * @num_capture_formats: number of entries in capture_formats
- * @output_formats: array of supported output formats
- * @num_output_formats: number of entries in output_formats
- * @core_id: stand for h264 or vp8 encode index
- * @uses_34bit: whether the encoder uses 34-bit iova
- */
-struct mtk_vcodec_enc_pdata {
-	bool uses_ext;
-	unsigned long min_bitrate;
-	unsigned long max_bitrate;
-	const struct mtk_video_fmt *capture_formats;
-	size_t num_capture_formats;
-	const struct mtk_video_fmt *output_formats;
-	size_t num_output_formats;
-	int core_id;
-	bool uses_34bit;
-};
-
-#define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
-#define MTK_ENC_IOVA_IS_34BIT(ctx) ((ctx)->dev->venc_pdata->uses_34bit)
-
-/**
- * struct mtk_vcodec_dev - driver data
- * @v4l2_dev: V4L2 device to register video devices for.
- * @vfd_dec: Video device for decoder
- * @mdev_dec: Media device for decoder
- * @vfd_enc: Video device for encoder.
- *
- * @m2m_dev_dec: m2m device for decoder
- * @m2m_dev_enc: m2m device for encoder.
- * @plat_dev: platform device
- * @ctx_list: list of struct mtk_vcodec_dec_ctx
- * @irqlock: protect data access by irq handler and work thread
- * @curr_ctx: The context that is waiting for codec hardware
- * @curr_enc_ctx: The encoder context that is waiting for codec hardware
- *
- * @reg_base: Mapped address of MTK Vcodec registers.
- * @vdec_pdata: decoder IC-specific data
- * @venc_pdata: encoder IC-specific data
- * @vdecsys_regmap: VDEC_SYS register space passed through syscon
- *
- * @fw_handler: used to communicate with the firmware.
- * @id_counter: used to identify current opened instance
- *
- * @decode_workqueue: decode work queue
- * @encode_workqueue: encode work queue
- *
- * @dev_mutex: video_device lock
- *
- * @dec_irq: decoder irq resource
- * @enc_irq: h264 encoder irq resource
- *
- * @dec_mutex: decoder hardware lock
- * @enc_mutex: encoder hardware lock.
- *
- * @pm: power management control
- * @dec_capability: used to identify decode capability, ex: 4k
- * @enc_capability: used to identify encode capability
- *
- * @core_workqueue: queue used for core hardware decode
- *
- * @subdev_dev: subdev hardware device
- * @subdev_prob_done: check whether all used hw device is prob done
- * @subdev_bitmap: used to record hardware is ready or not
- *
- * @dec_active_cnt: used to mark whether need to record register value
- * @vdec_racing_info: record register value
- * @dec_racing_info_mutex: mutex lock used for inner racing mode
- * @dbgfs: debug log related information
- */
-struct mtk_vcodec_dev {
-	struct v4l2_device v4l2_dev;
-	struct video_device *vfd_dec;
-	struct media_device mdev_dec;
-	struct video_device *vfd_enc;
-
-	struct v4l2_m2m_dev *m2m_dev_dec;
-	struct v4l2_m2m_dev *m2m_dev_enc;
-	struct platform_device *plat_dev;
-	struct list_head ctx_list;
-	spinlock_t irqlock;
-	struct mtk_vcodec_dec_ctx *curr_ctx;
-	struct mtk_vcodec_enc_ctx *curr_enc_ctx;
-	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
-	const struct mtk_vcodec_dec_pdata *vdec_pdata;
-	const struct mtk_vcodec_enc_pdata *venc_pdata;
-	struct regmap *vdecsys_regmap;
-
-	struct mtk_vcodec_fw *fw_handler;
-
-	unsigned long id_counter;
-
-	struct workqueue_struct *decode_workqueue;
-	struct workqueue_struct *encode_workqueue;
-	struct mutex dev_mutex;
-
-	int dec_irq;
-	int enc_irq;
-
-	/* decoder hardware mutex lock */
-	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
-	struct mutex enc_mutex;
-
-	struct mtk_vcodec_pm pm;
-	unsigned int dec_capability;
-	unsigned int enc_capability;
-
-	struct workqueue_struct *core_workqueue;
-
-	void *subdev_dev[MTK_VDEC_HW_MAX];
-	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
-	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
-
-	atomic_t dec_active_cnt;
-	u32 vdec_racing_info[132];
-	/* Protects access to vdec_racing_info data */
-	struct mutex dec_racing_info_mutex;
-
-	struct mtk_vcodec_dbgfs dbgfs;
-};
-
-#endif /* _MTK_VCODEC_DRV_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index deabf012848e..85dabb20fb11 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -10,7 +10,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <linux/pm_runtime.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_intr.h"
 #include "mtk_vcodec_util.h"
@@ -1436,7 +1435,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 
 int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx)
 {
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_enc_dev *dev = ctx->dev;
 
 	mutex_unlock(&dev->enc_mutex);
 	return 0;
@@ -1444,7 +1443,7 @@ int mtk_venc_unlock(struct mtk_vcodec_enc_ctx *ctx)
 
 int mtk_venc_lock(struct mtk_vcodec_enc_ctx *ctx)
 {
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_enc_dev *dev = ctx->dev;
 
 	mutex_lock(&dev->enc_mutex);
 	return 0;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index a557fc5aebef..4ba9e8ca42d0 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -16,7 +16,6 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
@@ -85,14 +84,14 @@ static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
 }
 static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 {
-	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_enc_dev *dev = priv;
 	struct mtk_vcodec_enc_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
 	int core_id;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
-	ctx = dev->curr_enc_ctx;
+	ctx = dev->curr_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
 	core_id = dev->venc_pdata->core_id;
@@ -116,7 +115,7 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 
 static int fops_vcodec_open(struct file *file)
 {
-	struct mtk_vcodec_dev *dev = video_drvdata(file);
+	struct mtk_vcodec_enc_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_enc_ctx *ctx = NULL;
 	int ret = 0;
 	struct vb2_queue *src_vq;
@@ -203,7 +202,7 @@ static int fops_vcodec_open(struct file *file)
 
 static int fops_vcodec_release(struct file *file)
 {
-	struct mtk_vcodec_dev *dev = video_drvdata(file);
+	struct mtk_vcodec_enc_dev *dev = video_drvdata(file);
 	struct mtk_vcodec_enc_ctx *ctx = fh_to_enc_ctx(file->private_data);
 
 	mtk_v4l2_venc_dbg(1, ctx, "[%d] encoder", ctx->id);
@@ -232,7 +231,7 @@ static const struct v4l2_file_operations mtk_vcodec_fops = {
 
 static int mtk_vcodec_probe(struct platform_device *pdev)
 {
-	struct mtk_vcodec_dev *dev;
+	struct mtk_vcodec_enc_dev *dev;
 	struct video_device *vfd_enc;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
@@ -454,7 +453,7 @@ MODULE_DEVICE_TABLE(of, mtk_vcodec_enc_match);
 
 static void mtk_vcodec_enc_remove(struct platform_device *pdev)
 {
-	struct mtk_vcodec_dev *dev = platform_get_drvdata(pdev);
+	struct mtk_vcodec_enc_dev *dev = platform_get_drvdata(pdev);
 
 	destroy_workqueue(dev->encode_workqueue);
 	if (dev->m2m_dev_enc)
@@ -463,7 +462,7 @@ static void mtk_vcodec_enc_remove(struct platform_device *pdev)
 	if (dev->vfd_enc)
 		video_unregister_device(dev->vfd_enc);
 
-	mtk_vcodec_dbgfs_deinit(dev);
+	mtk_vcodec_dbgfs_deinit(&dev->dbgfs);
 	v4l2_device_unregister(&dev->v4l2_dev);
 	pm_runtime_disable(dev->pm.dev);
 	mtk_vcodec_fw_release(dev->fw_handler);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
index 4b0dfa119f27..2f6d0160ff1d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
@@ -8,7 +8,39 @@
 #define _MTK_VCODEC_ENC_DRV_H_
 
 #include "mtk_vcodec_cmn_drv.h"
+#include "mtk_vcodec_dbgfs.h"
 #include "mtk_vcodec_fw_priv.h"
+#include "mtk_vcodec_util.h"
+
+#define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
+
+#define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
+#define MTK_ENC_IOVA_IS_34BIT(ctx) ((ctx)->dev->venc_pdata->uses_34bit)
+
+/**
+ * struct mtk_vcodec_enc_pdata - compatible data for each IC
+ *
+ * @uses_ext: whether the encoder uses the extended firmware messaging format
+ * @min_bitrate: minimum supported encoding bitrate
+ * @max_bitrate: maximum supported encoding bitrate
+ * @capture_formats: array of supported capture formats
+ * @num_capture_formats: number of entries in capture_formats
+ * @output_formats: array of supported output formats
+ * @num_output_formats: number of entries in output_formats
+ * @core_id: stand for h264 or vp8 encode index
+ * @uses_34bit: whether the encoder uses 34-bit iova
+ */
+struct mtk_vcodec_enc_pdata {
+	bool uses_ext;
+	unsigned long min_bitrate;
+	unsigned long max_bitrate;
+	const struct mtk_video_fmt *capture_formats;
+	size_t num_capture_formats;
+	const struct mtk_video_fmt *output_formats;
+	size_t num_output_formats;
+	int core_id;
+	bool uses_34bit;
+};
 
 /*
  * enum mtk_encode_param - General encoding parameters type
@@ -61,8 +93,8 @@ struct mtk_enc_params {
  * struct mtk_vcodec_enc_ctx - Context (instance) private data.
  *
  * @type: type of encoder instance
- * @dev: pointer to the mtk_vcodec_dev of the device
- * @list: link to ctx_list of mtk_vcodec_dev
+ * @dev: pointer to the mtk_vcodec_enc_dev of the device
+ * @list: link to ctx_list of mtk_vcodec_enc_dev
  *
  * @fh: struct v4l2_fh
  * @m2m_ctx: pointer to the v4l2_m2m_ctx of the context
@@ -94,7 +126,7 @@ struct mtk_enc_params {
  */
 struct mtk_vcodec_enc_ctx {
 	enum mtk_instance_type type;
-	struct mtk_vcodec_dev *dev;
+	struct mtk_vcodec_enc_dev *dev;
 	struct list_head list;
 
 	struct v4l2_fh fh;
@@ -126,6 +158,61 @@ struct mtk_vcodec_enc_ctx {
 	struct mutex q_mutex;
 };
 
+/**
+ * struct mtk_vcodec_enc_dev - driver data
+ * @v4l2_dev: V4L2 device to register video devices for.
+ * @vfd_enc: Video device for encoder.
+ *
+ * @m2m_dev_enc: m2m device for encoder.
+ * @plat_dev: platform device
+ * @ctx_list: list of struct mtk_vcodec_ctx
+ * @curr_ctx: The context that is waiting for codec hardware
+ *
+ * @reg_base: Mapped address of MTK Vcodec registers.
+ * @venc_pdata: encoder IC-specific data
+ *
+ * @fw_handler: used to communicate with the firmware.
+ * @id_counter: used to identify current opened instance
+ *
+ * @enc_mutex: encoder hardware lock.
+ * @dev_mutex: video_device lock
+ * @encode_workqueue: encode work queue
+ *
+ * @enc_irq: h264 encoder irq resource
+ * @irqlock: protect data access by irq handler and work thread
+ *
+ * @pm: power management control
+ * @enc_capability: used to identify encode capability
+ * @dbgfs: debug log related information
+ */
+struct mtk_vcodec_enc_dev {
+	struct v4l2_device v4l2_dev;
+	struct video_device *vfd_enc;
+
+	struct v4l2_m2m_dev *m2m_dev_enc;
+	struct platform_device *plat_dev;
+	struct list_head ctx_list;
+	struct mtk_vcodec_enc_ctx *curr_ctx;
+
+	void __iomem *reg_base[NUM_MAX_VCODEC_REG_BASE];
+	const struct mtk_vcodec_enc_pdata *venc_pdata;
+
+	struct mtk_vcodec_fw *fw_handler;
+	unsigned long id_counter;
+
+	/* encoder hardware mutex lock */
+	struct mutex enc_mutex;
+	struct mutex dev_mutex;
+	struct workqueue_struct *encode_workqueue;
+
+	int enc_irq;
+	spinlock_t irqlock;
+
+	struct mtk_vcodec_pm pm;
+	unsigned int enc_capability;
+	struct mtk_vcodec_dbgfs dbgfs;
+};
+
 static inline struct mtk_vcodec_enc_ctx *fh_to_enc_ctx(struct v4l2_fh *fh)
 {
 	return container_of(fh, struct mtk_vcodec_enc_ctx, fh);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index fe4aa2dede03..3fce936e61b9 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -8,10 +8,10 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_enc_pm.h"
-#include "mtk_vcodec_util.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *mtkdev)
+int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *mtkdev)
 {
 	struct platform_device *pdev;
 	struct mtk_vcodec_pm *pm;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
index bc455cefc0cd..e50be0575190 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
@@ -7,9 +7,9 @@
 #ifndef _MTK_VCODEC_ENC_PM_H_
 #define _MTK_VCODEC_ENC_PM_H_
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 
-int mtk_vcodec_init_enc_clk(struct mtk_vcodec_dev *dev);
+int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *dev);
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
index 6e6986fb28bb..99e6c8d7ef79 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
@@ -1,20 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw.h"
 #include "mtk_vcodec_fw_priv.h"
 #include "mtk_vcodec_util.h"
-#include "mtk_vcodec_drv.h"
 
 struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
 					   enum mtk_vcodec_fw_use fw_use)
 {
+	struct platform_device *plat_dev;
+
+	if (fw_use == ENCODER)
+		plat_dev = ((struct mtk_vcodec_enc_dev *)priv)->plat_dev;
+	else
+		plat_dev = ((struct mtk_vcodec_dec_dev *)priv)->plat_dev;
+
 	switch (type) {
 	case VPU:
 		return mtk_vcodec_fw_vpu_init(priv, fw_use);
 	case SCP:
 		return mtk_vcodec_fw_scp_init(priv, fw_use);
 	default:
-		pr_err(MTK_DBG_VCODEC_STR "Invalid vcodec fw type");
+		dev_err(&plat_dev->dev, "Invalid vcodec fw type");
 		return ERR_PTR(-EINVAL);
 	}
 }
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
index d8cfbec323d5..83479ab70385 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
@@ -8,7 +8,8 @@
 
 #include "../vpu/mtk_vpu.h"
 
-struct mtk_vcodec_dev;
+struct mtk_vcodec_dec_dev;
+struct mtk_vcodec_enc_dev;
 
 enum mtk_vcodec_fw_type {
 	VPU,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
index 3438a4917344..99603accd82e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
@@ -5,7 +5,8 @@
 
 #include "mtk_vcodec_fw.h"
 
-struct mtk_vcodec_dev;
+struct mtk_vcodec_dec_dev;
+struct mtk_vcodec_enc_dev;
 
 struct mtk_vcodec_fw {
 	enum mtk_vcodec_fw_type type;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
index 71ff1a6ae872..3cb5a5befd24 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw_priv.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_drv.h"
 
 static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
 {
@@ -56,14 +56,25 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_rproc_msg = {
 struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	struct mtk_vcodec_fw *fw;
-	struct mtk_vcodec_dev *dev = priv;
 	struct platform_device *plat_dev;
 	struct mtk_scp *scp;
 
-	plat_dev = dev->plat_dev;
+	if (fw_use == ENCODER) {
+		struct mtk_vcodec_enc_dev *enc_dev = priv;
+
+		plat_dev = enc_dev->plat_dev;
+	} else if (fw_use == DECODER) {
+		struct mtk_vcodec_dec_dev *dec_dev = priv;
+
+		plat_dev = dec_dev->plat_dev;
+	} else {
+		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
+		return ERR_PTR(-EINVAL);
+	}
+
 	scp = scp_get(plat_dev);
 	if (!scp) {
-		dev_err(&dev->plat_dev->dev, "could not get vdec scp handle");
+		dev_err(&plat_dev->dev, "could not get vdec scp handle");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
index 571072dffbfa..18274a51a8f8 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw_priv.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_drv.h"
 
 static int mtk_vcodec_vpu_load_firmware(struct mtk_vcodec_fw *fw)
 {
@@ -53,7 +53,7 @@ static void mtk_vcodec_vpu_release(struct mtk_vcodec_fw *fw)
 
 static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 {
-	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_dec_dev *dev = priv;
 	struct mtk_vcodec_dec_ctx *ctx;
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
@@ -68,7 +68,7 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *priv)
 
 static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
 {
-	struct mtk_vcodec_dev *dev = priv;
+	struct mtk_vcodec_enc_dev *dev = priv;
 	struct mtk_vcodec_enc_ctx *ctx;
 
 	dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
@@ -94,24 +94,28 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
 struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *priv, enum mtk_vcodec_fw_use fw_use)
 {
 	struct platform_device *fw_pdev;
-	struct mtk_vcodec_dev *dev = priv;
 	struct platform_device *plat_dev;
 	struct mtk_vcodec_fw *fw;
 	enum rst_id rst_id;
 
 	if (fw_use == ENCODER) {
+		struct mtk_vcodec_enc_dev *enc_dev = priv;
+
+		plat_dev = enc_dev->plat_dev;
 		rst_id = VPU_RST_ENC;
 	} else if (fw_use == DECODER) {
+		struct mtk_vcodec_dec_dev *dec_dev = priv;
+
+		plat_dev = dec_dev->plat_dev;
 		rst_id = VPU_RST_DEC;
 	} else {
 		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
 		return ERR_PTR(-EINVAL);
 	}
 
-	plat_dev = dev->plat_dev;
 	fw_pdev = vpu_get_plat_device(plat_dev);
 	if (!fw_pdev) {
-		dev_err(&dev->plat_dev->dev, "firmware device is not ready");
+		dev_err(&plat_dev->dev, "firmware device is not ready");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
index 59970aa51ab2..dc8dd19ff6db 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
@@ -7,9 +7,9 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
 				 unsigned int hw_id)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index 05e04050ac89..20e2b8cbcc18 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -9,9 +9,9 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 
+#include "mtk_vcodec_dec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_dec_hw.h"
-#include "mtk_vcodec_drv.h"
-#include "mtk_vcodec_util.h"
 
 #if defined(CONFIG_DEBUG_FS)
 int mtk_vcodec_dbg;
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg,
 			     unsigned int val)
 {
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 
 	if (dev->vdecsys_regmap)
 		return regmap_write(dev->vdecsys_regmap, reg, val);
@@ -89,7 +89,7 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 }
 EXPORT_SYMBOL(mtk_vcodec_mem_free);
 
-void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
+void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dec_dev *dev, int hw_idx)
 {
 	if (hw_idx >= MTK_VDEC_HW_MAX || hw_idx < 0 || !dev->subdev_dev[hw_idx]) {
 		dev_err(&dev->plat_dev->dev, "hw idx is out of range:%d", hw_idx);
@@ -100,7 +100,7 @@ void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx)
 }
 EXPORT_SYMBOL(mtk_vcodec_get_hw_dev);
 
-void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dec_dev *vdec_dev,
 			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx)
 {
 	unsigned long flags;
@@ -122,7 +122,7 @@ void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
 }
 EXPORT_SYMBOL(mtk_vcodec_set_curr_ctx);
 
-struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dec_dev *vdec_dev,
 						   unsigned int hw_idx)
 {
 	unsigned long flags;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index a0d7b7784cf7..da879835fa9c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -26,7 +26,7 @@ struct mtk_vcodec_fb {
 };
 
 struct mtk_vcodec_dec_ctx;
-struct mtk_vcodec_dev;
+struct mtk_vcodec_dec_dev;
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s(),%d: " fmt, __func__, __LINE__
@@ -88,10 +88,10 @@ void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_
 int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg, unsigned int val);
 int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
-void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dec_dev *vdec_dev,
 			     struct mtk_vcodec_dec_ctx *ctx, int hw_idx);
-struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
+struct mtk_vcodec_dec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dec_dev *vdec_dev,
 						   unsigned int hw_idx);
-void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dev *dev, int hw_idx);
+void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dec_dev *dev, int hw_idx);
 
 #endif /* _MTK_VCODEC_UTIL_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
index 0dda9e2315c0..ac82be336055 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
@@ -13,7 +13,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_drv.h"
+#include "../mtk_vcodec_dec_drv.h"
 
 #define NAL_NON_IDR_SLICE			0x01
 #define NAL_IDR_SLICE				0x05
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 846cc39c0168..79eff921fc97 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -540,7 +540,7 @@ static int vdec_h264_slice_core_decode(struct vdec_lat_buf *lat_buf)
 	return 0;
 }
 
-static void vdec_h264_insert_startcode(struct mtk_vcodec_dev *vcodec_dev, unsigned char *buf,
+static void vdec_h264_insert_startcode(struct mtk_vcodec_dec_dev *vcodec_dev, unsigned char *buf,
 				       size_t *bs_size, struct mtk_h264_pps_param *pps)
 {
 	struct device *dev = &vcodec_dev->plat_dev->dev;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
index 816ed6ab1ed0..7b41ce23158b 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
@@ -8,7 +8,6 @@
 #ifndef _VDEC_DRV_IF_H_
 #define _VDEC_DRV_IF_H_
 
-#include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_util.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 4e18ebf58248..f283c4703dc6 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -8,8 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/kthread.h>
 
+#include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_dec_pm.h"
-#include "mtk_vcodec_drv.h"
 #include "vdec_msg_queue.h"
 
 #define VDEC_MSG_QUEUE_TIMEOUT_MS 1500
@@ -241,7 +241,7 @@ static void vdec_msg_queue_core_work(struct work_struct *work)
 		container_of(work, struct vdec_msg_queue, core_work);
 	struct mtk_vcodec_dec_ctx *ctx =
 		container_of(msg_queue, struct mtk_vcodec_dec_ctx, msg_queue);
-	struct mtk_vcodec_dev *dev = ctx->dev;
+	struct mtk_vcodec_dec_dev *dev = ctx->dev;
 	struct vdec_lat_buf *lat_buf;
 
 	spin_lock(&msg_queue->core_ctx.ready_lock);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index 1fb3f57c2384..eeb5deb907ed 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -18,7 +18,7 @@
 
 struct vdec_lat_buf;
 struct mtk_vcodec_dec_ctx;
-struct mtk_vcodec_dev;
+struct mtk_vcodec_dec_dev;
 typedef int (*core_decode_cb_t)(struct vdec_lat_buf *lat_buf);
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index d82391411ba1..7fe8e196cb45 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -4,8 +4,7 @@
  * Author: PC Chen <pc.chen@mediatek.com>
  */
 
-#include "mtk_vcodec_drv.h"
-#include "mtk_vcodec_util.h"
+#include "mtk_vcodec_dec_drv.h"
 #include "vdec_drv_if.h"
 #include "vdec_ipi_msg.h"
 #include "vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index c5f9fc24a692..41d463d40843 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include "../mtk_vcodec_drv.h"
+#include "../mtk_vcodec_enc_drv.h"
 #include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index e8e4474eacc7..dfd6833576f4 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include "../mtk_vcodec_drv.h"
+#include "../mtk_vcodec_enc_drv.h"
 #include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
index 17f8183461b5..856d50151bf6 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_base.h
@@ -9,7 +9,7 @@
 #ifndef _VENC_DRV_BASE_
 #define _VENC_DRV_BASE_
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 
 #include "venc_drv_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
index 08083030516e..1bdaecdd64a7 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.c
@@ -65,7 +65,7 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	mtk_venc_lock(ctx);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_enc_ctx = ctx;
+	ctx->dev->curr_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
@@ -74,7 +74,7 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	mtk_vcodec_enc_clock_off(&ctx->dev->pm);
 
 	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_enc_ctx = NULL;
+	ctx->dev->curr_ctx = NULL;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
 	mtk_venc_unlock(ctx);
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index 90d714e86ede..d00fb68b8235 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -9,8 +9,7 @@
 #ifndef _VENC_DRV_IF_H_
 #define _VENC_DRV_IF_H_
 
-#include "mtk_vcodec_drv.h"
-#include "mtk_vcodec_util.h"
+#include "mtk_vcodec_enc_drv.h"
 
 /*
  * enum venc_yuv_fmt - The type of input yuv format
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index c69f66b6d341..bfff16da0451 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -4,7 +4,7 @@
  * Author: PoChun Lin <pochun.lin@mediatek.com>
  */
 
-#include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw.h"
 #include "venc_ipi_msg.h"
 #include "venc_vpu_if.h"
-- 
2.18.0

