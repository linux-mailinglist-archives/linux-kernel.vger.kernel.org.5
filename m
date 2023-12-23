Return-Path: <linux-kernel+bounces-10536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853581D5DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA631C21008
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D819BD3;
	Sat, 23 Dec 2023 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G7ByBuka"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745412E62;
	Sat, 23 Dec 2023 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 39f58318a1c111eeba30773df0976c77-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y1ae+3Zm9kPdHs21B3z0K0CoRyY6x1ruZTyvmPVFPNw=;
	b=G7ByBukaVOc72YX72mwoa/+t2AJB8LicgeZb2f5rs3lrS3Q5k0gIcX9TPwScOlAJEVhyEiCX81KLyt2j6wFq9nTbVKAuaBAWUpekxIuw1lUmE6Q6JhbO0JwqOj9ZrHCMTsn0Bo6f9hY0lxEO2vNhIbF8E4qynWhGe83WOe1iQVc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5ed943ae-7a08-46f6-90f4-c2d48b6143b6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:6257987e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 39f58318a1c111eeba30773df0976c77-20231224
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1494139867; Sun, 24 Dec 2023 02:29:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 02:29:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 02:29:35 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>
Subject: [PATCH v3 08/11] drm/mediatek: Add secure layer config support for ovl_adaptor
Date: Sun, 24 Dec 2023 02:29:29 +0800
Message-ID: <20231223182932.27683-9-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add secure layer config support for ovl_adaptor and sub driver mdp_rdma.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h         |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 15 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c     |  1 +
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 11 ++++++++---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.h         |  2 ++
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 77054adcd9cf..ec9746767468 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -117,6 +117,7 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev);
 void mtk_ovl_adaptor_config(struct device *dev, unsigned int w,
 			    unsigned int h, unsigned int vrefresh,
 			    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+u64 mtk_ovl_adaptor_get_sec_port(struct mtk_ddp_comp *comp, unsigned int idx);
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 				  struct mtk_plane_state *state,
 				  struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 6bf6367853fb..f419c2e70ba3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -83,6 +83,18 @@ static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_MAX] = {
 	[OVL_ADAPTOR_ETHDR0]	= { OVL_ADAPTOR_TYPE_ETHDR, 0 },
 };
 
+static const u64 ovl_adaptor_sec_port[] = {
+	BIT_ULL(CMDQ_SEC_VDO1_DISP_RDMA_L0),
+	BIT_ULL(CMDQ_SEC_VDO1_DISP_RDMA_L1),
+	BIT_ULL(CMDQ_SEC_VDO1_DISP_RDMA_L2),
+	BIT_ULL(CMDQ_SEC_VDO1_DISP_RDMA_L3),
+};
+
+u64 mtk_ovl_adaptor_get_sec_port(struct mtk_ddp_comp *comp, unsigned int idx)
+{
+	return ovl_adaptor_sec_port[idx];
+}
+
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 				  struct mtk_plane_state *state,
 				  struct cmdq_pkt *cmdq_pkt)
@@ -141,6 +153,9 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	rdma_config.pitch = pending->pitch;
 	rdma_config.fmt = pending->format;
 	rdma_config.color_encoding = pending->color_encoding;
+	rdma_config.source_size = (pending->height - 1) * pending->pitch +
+				  pending->width * fmt_info->cpp[0];
+	rdma_config.is_secure = state->pending.is_secure;
 	mtk_mdp_rdma_config(rdma_l, &rdma_config, cmdq_pkt);
 
 	if (use_dual_pipe) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 6aed7647dfc0..9b7fe34df9a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -445,6 +445,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
 	.remove = mtk_ovl_adaptor_remove_comp,
 	.get_formats = mtk_ovl_adaptor_get_formats,
 	.get_num_formats = mtk_ovl_adaptor_get_num_formats,
+	.get_sec_port = mtk_ovl_adaptor_get_sec_port,
 };
 
 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index c3adaeefd551..a164ba82d022 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -94,6 +94,7 @@ struct mtk_mdp_rdma {
 	void __iomem		*regs;
 	struct clk		*clk;
 	struct cmdq_client_reg	cmdq_reg;
+	resource_size_t		regs_pa;
 };
 
 static unsigned int rdma_fmt_convert(unsigned int fmt)
@@ -198,9 +199,12 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
 	else
 		mtk_ddp_write_mask(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
 				   MDP_RDMA_SRC_CON, FLD_OUTPUT_ARGB);
-
-	mtk_ddp_write_mask(cmdq_pkt, cfg->addr0, &priv->cmdq_reg, priv->regs,
-			   MDP_RDMA_SRC_BASE_0, FLD_SRC_BASE_0);
+	if (cfg->is_secure)
+		mtk_ddp_sec_write(cmdq_pkt, priv->regs_pa + MDP_RDMA_SRC_BASE_0,
+				  cfg->addr0, CMDQ_IWC_H_2_MVA, 0, cfg->source_size, 0);
+	else
+		mtk_ddp_write_mask(cmdq_pkt, cfg->addr0, &priv->cmdq_reg, priv->regs,
+				   MDP_RDMA_SRC_BASE_0, FLD_SRC_BASE_0);
 
 	mtk_ddp_write_mask(cmdq_pkt, src_pitch_y, &priv->cmdq_reg, priv->regs,
 			   MDP_RDMA_MF_BKGD_SIZE_IN_BYTE, FLD_MF_BKGD_WB);
@@ -285,6 +289,7 @@ static int mtk_mdp_rdma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs_pa = res->start;
 	priv->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->regs)) {
 		dev_err(dev, "failed to ioremap rdma\n");
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.h b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.h
index 9943ee3aac31..cd4840411411 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.h
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.h
@@ -15,6 +15,8 @@ struct mtk_mdp_rdma_cfg {
 	unsigned int	y_top;
 	int		fmt;
 	int		color_encoding;
+	unsigned int	source_size;
+	unsigned int	is_secure;
 };
 
 #endif // __MTK_MDP_RDMA_H__
-- 
2.18.0


