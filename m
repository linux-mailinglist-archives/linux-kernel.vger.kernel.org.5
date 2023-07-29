Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C515E767BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjG2Czz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjG2Czf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:55:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68649F7;
        Fri, 28 Jul 2023 19:55:31 -0700 (PDT)
X-UUID: 5fbe6d142dbb11ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Kgo4S+ZN7Sn/LdFqxPMgtQYijQn3s4XKPeVz6RNcyxg=;
        b=lG4e6/fPXitKd3WiFnlUDMLZq9KUSOIwJzEgf8kf2T3O2o9+Bn1144/hWSou84sh/6xKMVSS8xVpWW5puZf+TH0zKTkjfdEDpomlUSRKqJN+DmAz8DfqBimsvUcep/ZhVml2fVjULX1lBlIst6SzDv18jSRbGPl3J/ttKS1JPQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:a8ab037a-f398-41d0-b301-0ba43db13f07,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:a8ab037a-f398-41d0-b301-0ba43db13f07,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:2f019442-d291-4e62-b539-43d7d78362ba,B
        ulkID:2307291055200GXUM0VC,BulkQuantity:5,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 5fbe6d142dbb11ee9cb5633481061a41-20230729
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 131397054; Sat, 29 Jul 2023 10:55:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:55:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:55:26 +0800
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
Subject: [PATCH v8,10/11] media: mediatek: vcodec: remove unused include header
Date:   Sat, 29 Jul 2023 10:55:13 +0800
Message-ID: <20230729025515.16029-11-yunfei.dong@mediatek.com>
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

remove unused include header for .c files

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c         | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c     | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c      | 1 -
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c      | 1 -
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c    | 2 --
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c   | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c         | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c     | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c          | 2 --
 .../media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c   | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c  | 1 -
 .../platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c      | 1 -
 .../platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c       | 1 -
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c   | 1 -
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_drv_if.h            | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h         | 2 --
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c            | 1 -
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h            | 2 --
 drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c      | 1 -
 drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c       | 1 -
 drivers/media/platform/mediatek/vcodec/venc_vpu_if.c            | 1 -
 drivers/media/platform/mediatek/vcodec/venc_vpu_if.h            | 1 -
 25 files changed, 34 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 0363fec572e5..5acb7dff18f2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -11,8 +11,6 @@
 
 #include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "vdec_drv_if.h"
 #include "mtk_vcodec_dec_pm.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 410978cc8031..fab42eb06595 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -25,8 +25,6 @@
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_fw.h"
 
 static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_ctx *ctx, struct mtk_vcodec_dec_dev *dev)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index 1f49a4da27ea..cd48ee830443 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -16,7 +16,6 @@
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 
 static const struct of_device_id mtk_vdec_hw_match[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index 4bc16e1b1c10..aefd3e9e3061 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -11,7 +11,6 @@
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
-#include "mtk_vcodec_util.h"
 
 int mtk_vcodec_init_dec_clk(struct platform_device *pdev, struct mtk_vcodec_pm *pm)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 459e74a46737..11ca2c2fbaad 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -5,8 +5,6 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index c65744d3cd28..99a84c7e1901 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -7,8 +7,6 @@
 #include <linux/module.h>
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "mtk_vcodec_dec_pm.h"
 #include "vdec_drv_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index 85dabb20fb11..8e44a051edda 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -11,8 +11,6 @@
 #include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_enc.h"
-#include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
 #include "venc_drv_if.h"
 
 #define MTK_VENC_MIN_W	160U
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 4ba9e8ca42d0..8f7fd29f9aa8 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -19,8 +19,6 @@
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
-#include "mtk_vcodec_util.h"
-#include "mtk_vcodec_fw.h"
 
 static const struct mtk_video_fmt mtk_video_formats_output[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
index 99e6c8d7ef79..de77c71f7e87 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
@@ -2,9 +2,7 @@
 
 #include "mtk_vcodec_dec_drv.h"
 #include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_fw.h"
 #include "mtk_vcodec_fw_priv.h"
-#include "mtk_vcodec_util.h"
 
 struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
 					   enum mtk_vcodec_fw_use fw_use)
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
index 10f5b58c7302..6e33083d56c1 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
index 69914e26cd20..a8175f977ed2 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 
 #include "../vdec_drv_if.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index 4eb98a705be4..4c5ef35199a1 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -6,7 +6,6 @@
 #include <media/v4l2-h264.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index 79eff921fc97..0f9f7b56882f 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -10,7 +10,6 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
index 67a5f8b82eb8..2682f40d1361 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-dma-contig.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
index 16007b659664..8dab4046a579 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
@@ -7,7 +7,6 @@
 
 #include <linux/slab.h>
 #include "../vdec_drv_if.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index d3103b877b61..c85c849d2548 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -9,7 +9,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <uapi/linux/v4l2-controls.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 106ee4daf00b..3e9458470484 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -9,7 +9,6 @@
 #include <media/videobuf2-dma-contig.h>
 #include <media/v4l2-vp9.h>
 
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_dec.h"
 #include "../mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
index 7b41ce23158b..bfd297c96850 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
@@ -9,7 +9,6 @@
 #define _VDEC_DRV_IF_H_
 
 #include "mtk_vcodec_dec.h"
-#include "mtk_vcodec_util.h"
 
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
index eeb5deb907ed..1d9beb9e4a14 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
@@ -12,8 +12,6 @@
 #include <linux/slab.h>
 #include <media/videobuf2-v4l2.h>
 
-#include "mtk_vcodec_util.h"
-
 #define NUM_BUFFER_COUNT 3
 
 struct vdec_lat_buf;
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index 7fe8e196cb45..82c3dc8c4127 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -8,7 +8,6 @@
 #include "vdec_drv_if.h"
 #include "vdec_ipi_msg.h"
 #include "vdec_vpu_if.h"
-#include "mtk_vcodec_fw.h"
 
 static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
index c9766c108209..fbb3f34a73f0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
@@ -7,8 +7,6 @@
 #ifndef _VDEC_VPU_IF_H_
 #define _VDEC_VPU_IF_H_
 
-#include "mtk_vcodec_fw.h"
-
 struct mtk_vcodec_dec_ctx;
 
 /**
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 41d463d40843..9127bceb0db4 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
index dfd6833576f4..510f3b042670 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_util.h"
 #include "../mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index bfff16da0451..708db1bb32d4 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -5,7 +5,6 @@
  */
 
 #include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_fw.h"
 #include "venc_ipi_msg.h"
 #include "venc_vpu_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
index 71370ab98809..ede55fc3bd07 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
@@ -7,7 +7,6 @@
 #ifndef _VENC_VPU_IF_H_
 #define _VENC_VPU_IF_H_
 
-#include "mtk_vcodec_fw.h"
 #include "venc_drv_if.h"
 
 /*
-- 
2.18.0

