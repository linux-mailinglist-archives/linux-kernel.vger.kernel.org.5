Return-Path: <linux-kernel+bounces-110947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BA886620
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F647283C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6041756B;
	Fri, 22 Mar 2024 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y/xrie+c"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBBC144
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085324; cv=none; b=I1Y5GGWJmy0oyC1r2bpNpyTsQPARyHyrylpp2+nr8qkwkfERV56SjGH6OL1DZyJkLADBYUEEDspwvYg6xhz161/g9JR0DqJdo0TWXnVyGO2lrdzytDgvV/rdMUI8bIP0BCz4hPauHNvVDjtT5vyZtm/v4kumHwyWE3nTS3YyeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085324; c=relaxed/simple;
	bh=V4ZYsqCDVdAn9B0IdxvZwuWWIi7hzHm1Qsv/3ga97fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgSxlsNChfZz2z85f1zBn72ubtNEKtfKASenc1K/oHBEJDrbIvQMluonj6189NtoVZgqm+Iq5IrjcNUQxRkZ7VrkjsnmqBfnr+fjYZZYIqols9iM+J83yX7g6aQyZW6HAYtow3BslUQrB8pj4tlGHWuDQAkF41buOYbxF5FQNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y/xrie+c; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 05a9bac4e80d11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xd9TgTUfVDqX/vC2qmMi/SkYk4lJY4etdGpO3O86nsY=;
	b=Y/xrie+cS4Ht9qGqSagdB/5pP6V/kaa2EupH/39/m8CZlw6i1QC+CC+VisnIIk5LhWli3WmhiIeQ7FbCQgqiV7OfoFcZg1aT4c+4MakxcYXacjiY5zRG4c06zOycie/KVKK3KYmLzBz6KUH8oGSGkg74qsRDQbQc6J1HL78N9go=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c42ad533-80ab-42c1-9bec-759b52de1bb8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:99cb4c85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 05a9bac4e80d11eeb8927bc1f75efef4-20240322
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2031547944; Fri, 22 Mar 2024 13:28:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 13:28:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 13:28:31 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, "Nancy .
 Lin" <nancy.lin@mediatek.com>, Fei Shao <fshao@chromium.org>, Sean Paul
	<sean@poorly.run>, Jason Chen
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Hsiao Chien Sung" <shawn.sung@mediatek.com>
Subject: [PATCH v6 09/14] drm/mediatek: Support "Pre-multiplied" alpha blending in Mixer
Date: Fri, 22 Mar 2024 13:28:24 +0800
Message-ID: <20240322052829.9893-10-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240322052829.9893-1-shawn.sung@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.610000-8.000000
X-TMASE-MatchedRID: zNyJSLgyXoKp2D+ysBQGebxygpRxo4693KXiaLjnK32vloAnGr4qhglh
	29MaPxbmZKE0ERpSKdRmWak1/EAxtADNPxu11HXjhK8o4aoss8rTDXgcUlCNow2Y8xyy93kWQkz
	RZrI7fzZdrC9Pth1iYg2D76bNs2ltQF24kZp9Ww91e7Xbb6Im2greImldQ5BD8cWgFw6wp7MsX2
	NvG8rX7UT88A7P9JJ2gAYZl0IbohgfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCB43xWfKawlupLM
	z1pj71LYuxt2qKukyukpj240SI5SaZKBMoCxDE+
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.610000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 41C2D9E0853424E91D6A6ACE9E27EECBE7CB8B01094EFCBABF26693BDF33E8C62000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "Pre-multiplied" blend mode on MediaTek's chips.
Before this patch, only the "Coverage" mode is supported.

Please refer to the description of the commit
"drm/mediatek: Support alpha blending in display driver"
for more information.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 6bf398850e85f..4b12ca285e84b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_blend.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/of.h>
@@ -35,6 +36,7 @@
 #define MIX_SRC_L0_EN				BIT(0)
 #define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
 #define NON_PREMULTI_SOURCE			(2 << 12)
+#define PREMULTI_SOURCE				(3 << 12)
 #define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
 #define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
 #define MIX_FUNC_DCM0			0x120
@@ -153,7 +155,8 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 	struct mtk_plane_pending_state *pending = &state->pending;
 	unsigned int offset = (pending->x & 1) << 31 | pending->y << 16 | pending->x;
 	unsigned int align_width = ALIGN_DOWN(pending->width, 2);
-	unsigned int alpha_con = 0;
+	unsigned int mix_con = NON_PREMULTI_SOURCE;
+	bool replace_src_a = false;
 
 	dev_dbg(dev, "%s+ idx:%d", __func__, idx);
 
@@ -170,19 +173,27 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		return;
 	}
 
-	if (state->base.fb && state->base.fb->format->has_alpha)
-		alpha_con = MIXER_ALPHA_AEN | MIXER_ALPHA;
+	mix_con |= MIXER_ALPHA_AEN | (state->base.alpha & MIXER_ALPHA);
 
-	mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, alpha_con ? false : true,
-				  DEFAULT_9BIT_ALPHA,
+	if (state->base.pixel_blend_mode != DRM_MODE_BLEND_COVERAGE)
+		mix_con |= PREMULTI_SOURCE;
+
+	if (state->base.fb && !state->base.fb->format->has_alpha) {
+		/*
+		 * Mixer doesn't support CONST_BLD mode,
+		 * use a trick to make the output equivalent
+		 */
+		replace_src_a = true;
+	}
+
+	mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, replace_src_a, MIXER_ALPHA,
 				  pending->x & 1 ? MIXER_INX_MODE_EVEN_EXTEND :
 				  MIXER_INX_MODE_BYPASS, align_width / 2 - 1, cmdq_pkt);
 
 	mtk_ddp_write(cmdq_pkt, pending->height << 16 | align_width, &mixer->cmdq_base,
 		      mixer->regs, MIX_L_SRC_SIZE(idx));
 	mtk_ddp_write(cmdq_pkt, offset, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_OFFSET(idx));
-	mtk_ddp_write_mask(cmdq_pkt, alpha_con, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_CON(idx),
-			   0x1ff);
+	mtk_ddp_write(cmdq_pkt, mix_con, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_CON(idx));
 	mtk_ddp_write_mask(cmdq_pkt, BIT(idx), &mixer->cmdq_base, mixer->regs, MIX_SRC_CON,
 			   BIT(idx));
 }
-- 
2.18.0


