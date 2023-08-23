Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF0785BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjHWPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjHWPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E57CC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:14:01 -0700 (PDT)
X-UUID: aceabfaa41c711eeb20a276fd37b9834-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uHrkZ/XQC+sbArt0Sl5RH/82zRMPUVzswRiB228gF4U=;
        b=Hv8LvjWt43LfCmIBTAJa8MnSNZjRNV2upISgRitiM1RqDJ9prtEPAAyzst/dhIzWQ5SYaXIEpKwMW2cZPnoqzge705zGMSY6HaeJG4TY3Yo/HZuAbOWrH9Yt+6d5y7VWPes/avQqIj0Ahe3J0PQCdXmAQC4I2n+HfDT/AJSjcDE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fb3bcdc0-5d44-472f-9bad-a33a17f11203,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:79271b13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aceabfaa41c711eeb20a276fd37b9834-20230823
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1292642117; Wed, 23 Aug 2023 23:13:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 23:13:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 23:13:53 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 08/15] drm/mediatek: Move struct mtk_drm_crtc to the header file
Date:   Wed, 23 Aug 2023 23:13:25 +0800
Message-ID: <20230823151332.28811-9-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230823151332.28811-1-shawn.sung@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the struct from mtk_drm_crtc.c to mtk_drm_crtc.h
so it can be referenced in other files.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 44 -------------------------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h | 44 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index d40142842f85..e8313739b54d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -24,50 +24,6 @@
 #include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
 
-/*
- * struct mtk_drm_crtc - MediaTek specific crtc structure.
- * @base: crtc object.
- * @enabled: records whether crtc_enable succeeded
- * @planes: array of 4 drm_plane structures, one for each overlay plane
- * @pending_planes: whether any plane has pending changes to be applied
- * @mmsys_dev: pointer to the mmsys device for configuration registers
- * @mutex: handle to one of the ten disp_mutex streams
- * @ddp_comp_nr: number of components in ddp_comp
- * @ddp_comp: array of pointers the mtk_ddp_comp structures used by this crtc
- *
- * TODO: Needs update: this header is missing a bunch of member descriptions.
- */
-struct mtk_drm_crtc {
-	struct drm_crtc			base;
-	bool				enabled;
-
-	bool				pending_needs_vblank;
-	struct drm_pending_vblank_event	*event;
-
-	struct drm_plane		*planes;
-	unsigned int			layer_nr;
-	bool				pending_planes;
-	bool				pending_async_planes;
-
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	struct cmdq_client		cmdq_client;
-	struct cmdq_pkt			cmdq_handle;
-	u32				cmdq_event;
-	u32				cmdq_vblank_cnt;
-	wait_queue_head_t		cb_blocking_queue;
-#endif
-
-	struct device			*mmsys_dev;
-	struct device			*dma_dev;
-	struct mtk_mutex		*mutex;
-	unsigned int			ddp_comp_nr;
-	struct mtk_ddp_comp		**ddp_comp;
-
-	/* lock for display hardware access */
-	struct mutex			hw_lock;
-	bool				config_updating;
-};
-
 struct mtk_crtc_state {
 	struct drm_crtc_state		base;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index 3e9046993d09..34cd1bfed8b3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -14,6 +14,50 @@
 #define MTK_MAX_BPC	10
 #define MTK_MIN_BPC	3
 
+/*
+ * struct mtk_drm_crtc - MediaTek specific crtc structure.
+ * @base: crtc object.
+ * @enabled: records whether crtc_enable succeeded
+ * @planes: array of 4 drm_plane structures, one for each overlay plane
+ * @pending_planes: whether any plane has pending changes to be applied
+ * @mmsys_dev: pointer to the mmsys device for configuration registers
+ * @mutex: handle to one of the ten disp_mutex streams
+ * @ddp_comp_nr: number of components in ddp_comp
+ * @ddp_comp: array of pointers the mtk_ddp_comp structures used by this crtc
+ *
+ * TODO: Needs update: this header is missing a bunch of member descriptions.
+ */
+struct mtk_drm_crtc {
+	struct drm_crtc			base;
+	bool				enabled;
+
+	bool				pending_needs_vblank;
+	struct drm_pending_vblank_event	*event;
+
+	struct drm_plane		*planes;
+	unsigned int			layer_nr;
+	bool				pending_planes;
+	bool				pending_async_planes;
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	struct cmdq_client		cmdq_client;
+	struct cmdq_pkt			cmdq_handle;
+	u32				cmdq_event;
+	u32				cmdq_vblank_cnt;
+	wait_queue_head_t		cb_blocking_queue;
+#endif
+
+	struct device			*mmsys_dev;
+	struct device			*dma_dev;
+	struct mtk_mutex		*mutex;
+	unsigned int			ddp_comp_nr;
+	struct mtk_ddp_comp		**ddp_comp;
+
+	/* lock for display hardware access */
+	struct mutex			hw_lock;
+	bool				config_updating;
+};
+
 void mtk_drm_crtc_commit(struct drm_crtc *crtc);
 int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			const unsigned int *path,
-- 
2.18.0

