Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7C767BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjG2Cz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjG2CzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:55:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E549E8;
        Fri, 28 Jul 2023 19:55:24 -0700 (PDT)
X-UUID: 5a1de33a2dbb11ee9cb5633481061a41-20230729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iP74sutZm188n+DtFZsgQM1Jw5cQ6z7zVZi7SJyRwIk=;
        b=oAKR8fLlltb6ujAvpM1YDPupGv8sn9ZRX8idH7uDKZwKtB/YmRbwfqr+H4mHMH5wm4Kgt7fNT5uafes7exrXevaDGNAPpgO9katBBtfQDcWrF7BVhfcj0wER1mRv2lGZJ8b8c3StkWK2hZcWiTE7fVcwICJUgduC9sUzVgVGJKo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:9d9da2dd-fc1e-4e87-a55d-2d9ed86b9d28,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.30,REQID:9d9da2dd-fc1e-4e87-a55d-2d9ed86b9d28,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:1fcc6f8,CLOUDID:7e84a7a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:2307291055200GXUM0VC,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 5a1de33a2dbb11ee9cb5633481061a41-20230729
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1835674092; Sat, 29 Jul 2023 10:55:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 29 Jul 2023 10:55:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 29 Jul 2023 10:55:16 +0800
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
Subject: [PATCH v8,01/11] media: mediatek: vcodec: remove unused parameter
Date:   Sat, 29 Jul 2023 10:55:04 +0800
Message-ID: <20230729025515.16029-2-yunfei.dong@mediatek.com>
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

remove unused parameter in struct mtk_vcodec_dev.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h     | 6 ------
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c | 2 --
 3 files changed, 10 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 6cf5f88a3a8e..1a293331ba2d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -392,8 +392,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_core_workq;
 	}
 
-	init_waitqueue_head(&dev->queue);
-
 	vfd_dec = video_device_alloc();
 	if (!vfd_dec) {
 		mtk_v4l2_err("Failed to allocate video device");
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index c38eb62bc72a..6b056bafaf94 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -449,10 +449,7 @@ struct mtk_vcodec_enc_pdata {
  * @decode_workqueue: decode work queue
  * @encode_workqueue: encode work queue
  *
- * @int_cond: used to identify interrupt condition happen
- * @int_type: used to identify what kind of interrupt condition happen
  * @dev_mutex: video_device lock
- * @queue: waitqueue for waiting for completion of device commands
  *
  * @dec_irq: decoder irq resource
  * @enc_irq: h264 encoder irq resource
@@ -498,10 +495,7 @@ struct mtk_vcodec_dev {
 
 	struct workqueue_struct *decode_workqueue;
 	struct workqueue_struct *encode_workqueue;
-	int int_cond;
-	int int_type;
 	struct mutex dev_mutex;
-	wait_queue_head_t queue;
 
 	int dec_irq;
 	int enc_irq;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index ead3d0dd289d..8a75d28e9692 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -311,8 +311,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	init_waitqueue_head(&dev->queue);
-
 	/* allocate video device for encoder and register it */
 	vfd_enc = video_device_alloc();
 	if (!vfd_enc) {
-- 
2.18.0

