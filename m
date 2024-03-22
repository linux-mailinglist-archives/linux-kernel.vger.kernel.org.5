Return-Path: <linux-kernel+bounces-111189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49F8868F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC38C28808E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862938FBC;
	Fri, 22 Mar 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ISZtc7Lz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF91CD14;
	Fri, 22 Mar 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098764; cv=none; b=ljLGY37nL8sVEQwON0SAPLHAWMMm7v4NponGDDYW88VY5J+Dpi0k/MtnoOLjfrrsKv9yuHd/JJUP4d1u305+reSjr8xRePcIdERHJvIZh97brmSsrImVhSO0T4ehw9Iw51nr7xbfmmV4H2dQoy9YkS80tKwxcCWU3RZJzyoUdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098764; c=relaxed/simple;
	bh=NKoxrW0NsLfAz+NEqzb5Kb2qHbq8zc6N199ryPRlf5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJK+PCqesCWEH03uRR+U56fSyOwzVlz0uwLshmAh6cud0KgxlTk5PnyzjsOLUCIbH8qDJmM5CMg0qUJ7pwArRArcPLi1py97qAOtleCPRgscm2hsofBcL5BHKniRShf9ROtORQFvc1xbx3iYeEHSdhV8bI5NeckuxVvrJLv93mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ISZtc7Lz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 52295c5ae82c11ee935d6952f98a51a9-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i6qlv/T9mCY/kRP7L6PBaKUMXvMuRth9oyIwujiopfI=;
	b=ISZtc7Lz/Xql2+S4ZKqCwXZypPygohdOFF6CJmqvT8A5e1Ll5FfK3MCVCM+7/GYsK3f/yk8EM5UHiqbjIDPNPfYzOzBfCzSE9N8VbRoqhGQY2ynO+YIzAVHpz9YMRc8oDhc4c9FGInkU8PYWUhQkoFAnBSkNd+nLuG8Su4kUtiA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b55d3605-6cc4-4f59-98b8-543b24d9b733,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:7247b690-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 52295c5ae82c11ee935d6952f98a51a9-20240322
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 706012020; Fri, 22 Mar 2024 17:12:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:12:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:12:33 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: [PATCH v5 02/14] drm/mediatek: Rename "mtk_drm_ddp_comp" to "mtk_ddp_comp"
Date: Fri, 22 Mar 2024 17:12:20 +0800
Message-ID: <20240322091232.26387-3-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240322091232.26387-1-shawn.sung@mediatek.com>
References: <20240322091232.26387-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Rename all "mtk_drm_ddp_comp" to "mtk_ddp_comp":
- To align the naming rule
- To reduce the code size

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 16 +++++++---------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  6 +++---
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 71e20e8fc4ab8..0f2e1be4ee1cb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -278,9 +278,9 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_crtc *mtk_crtc)
 }
 
 static
-struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
-						struct drm_plane *plane,
-						unsigned int *local_layer)
+struct mtk_ddp_comp *mtk_ddp_comp_for_plane(struct drm_crtc *crtc,
+					    struct drm_plane *plane,
+					    unsigned int *local_layer)
 {
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	struct mtk_ddp_comp *comp;
@@ -430,7 +430,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 
 		/* should not enable layer before crtc enabled */
 		plane_state->pending.enable = false;
-		comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
+		comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
 		if (comp)
 			mtk_ddp_comp_layer_config(comp, local_layer,
 						  plane_state, NULL);
@@ -521,8 +521,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 			if (!plane_state->pending.config)
 				continue;
 
-			comp = mtk_drm_ddp_comp_for_plane(crtc, plane,
-							  &local_layer);
+			comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
 
 			if (comp)
 				mtk_ddp_comp_layer_config(comp, local_layer,
@@ -546,8 +545,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 			if (!plane_state->pending.async_config)
 				continue;
 
-			comp = mtk_drm_ddp_comp_for_plane(crtc, plane,
-							  &local_layer);
+			comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
 
 			if (comp)
 				mtk_ddp_comp_layer_config(comp, local_layer,
@@ -711,7 +709,7 @@ int mtk_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
 	unsigned int local_layer;
 	struct mtk_ddp_comp *comp;
 
-	comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
+	comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
 	if (comp)
 		return mtk_ddp_comp_layer_check(comp, local_layer, state);
 	return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 93d79a1366e91..ba985206fdd24 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 MediaTek Inc.
  */
 
-#ifndef MTK_DRM_DDP_COMP_H
-#define MTK_DRM_DDP_COMP_H
+#ifndef MTK_DDP_COMP_H
+#define MTK_DDP_COMP_H
 
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
@@ -340,4 +340,4 @@ void mtk_ddp_write_relaxed(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 void mtk_ddp_write_mask(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 			struct cmdq_client_reg *cmdq_reg, void __iomem *regs,
 			unsigned int offset, unsigned int mask);
-#endif /* MTK_DRM_DDP_COMP_H */
+#endif /* MTK_DDP_COMP_H */
-- 
2.18.0


