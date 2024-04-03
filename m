Return-Path: <linux-kernel+bounces-129128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385389656F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19351F21828
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B645C61C;
	Wed,  3 Apr 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="op1QPsi3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172456753;
	Wed,  3 Apr 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128062; cv=none; b=ipUYXbdaAqao1ZVDEcJqfoxkTDil1lWUdDbAnFiFb6L0z/fEMKUac8SW8Rn7jRTPUS81QuzBObVw29AicZQVIFwba7bPZDv4XvfRKwgA0VT2K5plD49V2GL+DB42k813QKt1iXWEMGIZIfMV9z7cVa/4sOnoHbhkymXjWmPz1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128062; c=relaxed/simple;
	bh=AKcxkml52e2id511VWoHzuxKsPzeNJUGVxIE+2F+ZaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJYbF+uuuOIKOEZbXEyqHY1nmpbxxaplEcik3rJsYSoEHFBmKWpmpV5u+LvGY78Id8NGr9TbjnWNG3VJqs4fYdOhBFVPjFlOF5lmYqN+jfrsPb/MyObz1ci7zfP0x1iIVQY4PjKcRTSqb6Eff9mF6yhAJm/xLIOexRTEBKAyMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=op1QPsi3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d9587e26f18811eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b1R7cr/Y69po1CcmKxYFPM6M+QHCkEJfXGlsJ3NaItM=;
	b=op1QPsi3ILuf0m1Hc2/VhFMv5Sq5Y08rlb2sYUW/scFGgiIzEkPpXX7kHPwp52wBDiN8SmRQ6ammj0ZrND4zYcMx/XJLbcdvz+A+LeTCRPLj6Uvz+xH/k4t/BcpIaaMD9v/O/5SB2YAIwvKPJQTTR0JfJ37pY5Y3Wv7haQa8UYg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d4fac5c0-42ae-4eb1-afdd-8afcddf3c442,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:2d10a800-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d9587e26f18811eeb8927bc1f75efef4-20240403
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1459816893; Wed, 03 Apr 2024 15:07:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 15:07:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 15:07:34 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal
	<sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-JH.Lin <jason-jh.lin@mediatek.com>,
	Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH v4 7/9] drm/mediatek: Add secure layer config support for ovl
Date: Wed, 3 Apr 2024 15:07:30 +0800
Message-ID: <20240403070732.22085-8-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403070732.22085-1-shawn.sung@mediatek.com>
References: <20240403070732.22085-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add secure layer config support for ovl.

TODO:
1. Move DISP_REG_OVL_SECURE setting to secure world.
2. Change the parameter register address in mtk_ddp_sec_write()
   from "u32 addr" to "struct cmdq_client_reg *cmdq_reg".

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h |  2 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 30 +++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index cda0da4848029..b2f59e54c3f4b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -382,6 +382,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl = {
 	.bgclr_in_off = mtk_ovl_bgclr_in_off,
 	.get_formats = mtk_ovl_get_formats,
 	.get_num_formats = mtk_ovl_get_num_formats,
+	.get_sec_port = mtk_ovl_get_sec_port,
 };
 
 static const struct mtk_ddp_comp_funcs ddp_postmask = {
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index d2c8fac468798..c4e1b5b8a2e31 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -9,6 +9,7 @@
 #include <linux/soc/mediatek/mtk-cmdq.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/soc/mediatek/mtk-mutex.h>
+#include "mtk_ddp_comp.h"
 #include "mtk_mdp_rdma.h"
 #include "mtk_plane.h"
 
@@ -84,6 +85,7 @@ void mtk_ovl_clk_disable(struct device *dev);
 void mtk_ovl_config(struct device *dev, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+u64 mtk_ovl_get_sec_port(struct mtk_ddp_comp *comp, unsigned int idx);
 int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 			struct mtk_plane_state *mtk_state);
 void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 279e6193e7975..8cee64495cd04 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -74,6 +74,7 @@
 #define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
 #define DISP_REG_OVL_HDR_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n) + 0x04)
 #define DISP_REG_OVL_HDR_PITCH(ovl, n)		((ovl)->data->addr + 0x20 * (n) + 0x08)
+#define DISP_REG_OVL_SECURE			0x0fc0
 
 #define GMC_THRESHOLD_BITS	16
 #define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
@@ -218,6 +219,16 @@ void mtk_ovl_crc_read(struct device *dev)
 	mtk_crtc_read_crc(&ovl->crc, ovl->regs);
 }
 
+u64 mtk_ovl_get_sec_port(struct mtk_ddp_comp *comp, unsigned int idx)
+{
+	if (comp->id == DDP_COMPONENT_OVL0)
+		return BIT_ULL(CMDQ_SEC_DISP_OVL0);
+	else if (comp->id == DDP_COMPONENT_OVL1)
+		return BIT_ULL(CMDQ_SEC_DISP_OVL1);
+
+	return 0;
+}
+
 static irqreturn_t mtk_disp_ovl_irq_handler(int irq, void *dev_id)
 {
 	struct mtk_disp_ovl *priv = dev_id;
@@ -665,8 +676,22 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 			      DISP_REG_OVL_SRC_SIZE(idx));
 	mtk_ddp_write_relaxed(cmdq_pkt, offset, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_OFFSET(idx));
-	mtk_ddp_write_relaxed(cmdq_pkt, addr, &ovl->cmdq_reg, ovl->regs,
-			      DISP_REG_OVL_ADDR(ovl, idx));
+
+	if (state->pending.is_secure) {
+		const struct drm_format_info *fmt_info = drm_format_info(fmt);
+		unsigned int buf_size = (pending->height - 1) * pending->pitch +
+					pending->width * fmt_info->cpp[0];
+
+		mtk_ddp_write_mask(cmdq_pkt, BIT(idx), &ovl->cmdq_reg, ovl->regs,
+				   DISP_REG_OVL_SECURE, BIT(idx));
+		mtk_ddp_sec_write(cmdq_pkt, ovl->regs_pa + DISP_REG_OVL_ADDR(ovl, idx),
+				  pending->addr, CMDQ_IWC_H_2_MVA, 0, buf_size, 0);
+	} else {
+		mtk_ddp_write_mask(cmdq_pkt, 0, &ovl->cmdq_reg, ovl->regs,
+				   DISP_REG_OVL_SECURE, BIT(idx));
+		mtk_ddp_write_relaxed(cmdq_pkt, addr, &ovl->cmdq_reg, ovl->regs,
+				      DISP_REG_OVL_ADDR(ovl, idx));
+	}
 
 	if (is_afbc) {
 		mtk_ddp_write_relaxed(cmdq_pkt, hdr_addr, &ovl->cmdq_reg, ovl->regs,
@@ -745,6 +770,7 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs_pa = res->start;
 	priv->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->regs)) {
 		dev_err(dev, "failed to ioremap ovl\n");
-- 
2.18.0


