Return-Path: <linux-kernel+bounces-48171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA5845838
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD07B1C299DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B139AF0;
	Thu,  1 Feb 2024 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yI0OXJ0T"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D786658
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791997; cv=none; b=b2lM87FjZxQNSfEW3C8hTVo7mud/gvWBj2tkPJIRUkZceFZvYGtKqqJgl85QzxZMC5Xc+atbwAx7r21UqmbOkbWuOHNatnAyyyqWjQZ69YYZ+FpmRinZNLp0rvquAAzxL3shOOFE2Vmvavi1yXm3jkZTFV3diTfp4agoAd6OpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791997; c=relaxed/simple;
	bh=MYH+i/BtT+AMUARp16Q2uQJXlZ3LL8lZ/S/2XJY1/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kThB1wdr6Q3q0mwRlvSejCJaae6ChP+CvYQ5O0KYXDGGpXqhCwSXmmWLAtmmhdC570UPwvX2gmxoIE9Oxp1nRjsTpDOOA8z2yeUh8/QuMpl/o8EAR3ZXFLnAs03vUa/ROYx0nxTRAUcTQ5XarJwlcVVIG+L2o6kbmignwkhvW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yI0OXJ0T; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706791994;
	bh=MYH+i/BtT+AMUARp16Q2uQJXlZ3LL8lZ/S/2XJY1/hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yI0OXJ0ThXQiHmKqKqrs85H1Pyh52sjE5BWediXGJgifnLTkgWwH9HOEUs9ahG3D6
	 NJRhY9/awMkEDcptGzmnhtpVlGPgUru7Ot/2eg8qonpxgRlzlnXKCKM/KABHWXT/i8
	 AM8td7pEJYZC23KvT0ER9gJyS5hDghc9CGdzVcolSOgCZIE3d0lG4o+mvng/br1P32
	 4mmzRaQlZKyYKb5Ss4PxbElMbQoQb2t7ak673q8HB6PQMLmQ1DDT+7jzDadtadDsGa
	 lXZYx3nVeXfsukdWIljxAhU8r/mFh4+fc1ojUGiL9qW0izyPlWgsqY/2YQNFeHt1cj
	 GGQRNzSC4TIJw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 20AEA378208D;
	Thu,  1 Feb 2024 12:53:13 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	nancy.lin@mediatek.com,
	nathan.lu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH 2/3] drm/mediatek: Perform iounmap on simple DDP component destruction
Date: Thu,  1 Feb 2024 13:53:03 +0100
Message-ID: <20240201125304.218467-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
References: <20240201125304.218467-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mtk_ddp_comp_destroy() function and call it in the teardown
path of mtk_drm_drv to make sure that we unmap the iospace of the
simple DDP components.

While at it, also fix iounmapping on mtk_ddp_comp_init() error path.

Fixes: ff1395609e20 ("drm/mediatek: Move mtk_ddp_comp_init() from sub driver to DRM driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 38 ++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  4 ++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index c13359eeb3cd..539b526a6b0a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -626,8 +626,11 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 
 	priv->regs = of_iomap(node, 0);
 	priv->clk = of_clk_get(node, 0);
-	if (IS_ERR(priv->clk))
+	if (IS_ERR(priv->clk)) {
+		iounmap(priv->regs);
+		priv->regs = NULL;
 		return PTR_ERR(priv->clk);
+	}
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(comp->dev, &priv->cmdq_reg, 0);
@@ -639,3 +642,36 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 
 	return 0;
 }
+
+void mtk_ddp_comp_destroy(struct mtk_ddp_comp *comp)
+{
+	struct mtk_ddp_comp_dev *priv;
+
+	if (!comp || !comp->dev)
+		return;
+
+	/* Complex components are destroyed with their own remove callback */
+	if (type == MTK_DISP_AAL ||
+	    type == MTK_DISP_BLS ||
+	    type == MTK_DISP_CCORR ||
+	    type == MTK_DISP_COLOR ||
+	    type == MTK_DISP_GAMMA ||
+	    type == MTK_DISP_MERGE ||
+	    type == MTK_DISP_OVL ||
+	    type == MTK_DISP_OVL_2L ||
+	    type == MTK_DISP_PWM ||
+	    type == MTK_DISP_RDMA ||
+	    type == MTK_DPI ||
+	    type == MTK_DP_INTF ||
+	    type == MTK_DSI)
+		return;
+
+	priv = dev_get_drvdata(comp->dev);
+	if (!priv)
+		return;
+
+	if (priv->regs) {
+		iounmap(priv->regs);
+		priv->regs = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 15b2eafff438..43372b416a3f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -318,6 +318,7 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 						struct device *dev);
 int mtk_ddp_comp_init(struct device_node *comp_node, struct mtk_ddp_comp *comp,
 		      unsigned int comp_id);
+void mtk_ddp_comp_destroy(struct mtk_ddp_comp *comp);
 enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
 void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 		   struct cmdq_client_reg *cmdq_reg, void __iomem *regs,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 14a1e0157cc4..89b6c31a1511 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -944,8 +944,10 @@ static void mtk_drm_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &mtk_drm_ops);
 	pm_runtime_disable(&pdev->dev);
 	of_node_put(private->mutex_node);
-	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++)
+	for (i = 0; i < DDP_COMPONENT_DRM_ID_MAX; i++) {
+		mtk_ddp_comp_destroy(&private->ddp_comp[i]);
 		of_node_put(private->comp_node[i]);
+	}
 }
 
 static int mtk_drm_sys_prepare(struct device *dev)
-- 
2.43.0


