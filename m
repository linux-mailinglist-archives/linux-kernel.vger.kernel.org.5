Return-Path: <linux-kernel+bounces-156621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C648B05DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0D6B268E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD36158D79;
	Wed, 24 Apr 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hmXhE+35"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E9158D74
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950208; cv=none; b=UZQqojCFNCEnRKqkpz7rjRzjE4UKrpCQns8zTwTMsAO0tZTyNBu1mEzviT7NYN3GfziB9oQ3pTV2OyAlk/JJZxBat4OYGcTpxp6OdALw8EiMaTRtlN7kx6R4UUb4P0HAEO9/70V8UD4AghJzDg73XJVgRQl7jEse2rvrXOq5IOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950208; c=relaxed/simple;
	bh=lI37cHZKL3eEnYbge05PV95USR53D0IQLEJhIDAuO1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKPUHxF8vfv23RUKwAmyVdkD3eOh683+grlloKp5BljK/FU09/04mB4FzycPRJd9g23kDp0Wt75zY+i6Z3Jc4I9Cbc7rMIXx0kElHWQX6axHzplCQF7lNjdR/AFyr4TJ5oaRKWwPcuuvZvRbemtupaHRCnHXwW2cMpmagLLR6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hmXhE+35; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5d5390f6021b11efb8927bc1f75efef4-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=br837wlQ7MLwVsU8y/eaMf0azwp0oj4BOUqIIRSwQs0=;
	b=hmXhE+35pdB5PHc3J7u8FdjXROf4s6H/DnVtJ/rUjbtzQLQVIYd4N0dHy8A+L/gozr2jCGtTnQ24VA77wJQ9cZYii79uGJ8iLOj5OE3hkjiDOYdiHLyCsCIhx5+l8xVqr7WcAs5kgjqQAljCwxtJRPwENR1QHkBARpAVcYyaCLk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6f98eff2-196c-4688-b678-cce507acc249,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:e6ef8e86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5d5390f6021b11efb8927bc1f75efef4-20240424
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shuijing.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 263302759; Wed, 24 Apr 2024 17:16:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 17:16:41 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 17:16:40 +0800
From: Shuijing Li <shuijing.li@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Shuijing Li
	<shuijing.li@mediatek.com>
Subject: [PATCH v2] drm/mediatek: dsi: Add dsi per-frame lp code for mt8188
Date: Wed, 24 Apr 2024 17:16:27 +0800
Message-ID: <20240424091639.22759-1-shuijing.li@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Adding the per-frame lp function of mt8188, which can keep HFP in HS and
reduce the time required for each line to enter and exit low power.
Per Frame LP:
  |<----------One Active Frame-------->|
--______________________________________----___________________
  ^HSA+HBP^^RGB^^HFP^^HSA+HBP^^RGB^^HFP^    ^HSA+HBP^^RGB^^HFP^

Per Line LP:
  |<---------------One Active Frame----------->|
--______________--______________--______________----______________
  ^HSA+HBP^^RGB^  ^HSA+HBP^^RGB^  ^HSA+HBP^^RGB^    ^HSA+HBP^^RGB^

Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
---
Changes in v2:
Use bitfield macros and add new function for per prame lp and improve
the format, per suggestion frome previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240314094238.3315-1-shuijing.li@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 143 +++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 9501f4019199..75719b0535f7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -68,6 +68,8 @@
 #define EXT_TE_EDGE			BIT(10)
 #define MAX_RTN_SIZE			GENMASK(15, 12)
 #define HSTX_CKLP_EN			BIT(16)
+#define HSTX_BLLP_EN_SHIFT 7
+#define HSTX_BLLP_EN_MASK  0x1
 
 #define DSI_PSCTRL		0x1c
 #define DSI_PS_WC			GENMASK(13, 0)
@@ -76,6 +78,8 @@
 #define PACKED_PS_18BIT_RGB666		1
 #define LOOSELY_PS_24BIT_RGB666		2
 #define PACKED_PS_24BIT_RGB888		3
+#define PS_WC_SHIFT 0
+#define PS_WC_MASK  0x7fff
 
 #define DSI_VSA_NL		0x20
 #define DSI_VBP_NL		0x24
@@ -88,12 +92,20 @@
 #define DSI_HSA_WC		0x50
 #define DSI_HBP_WC		0x54
 #define DSI_HFP_WC		0x58
+#define HFP_HS_EN		31
+#define HFP_HS_VB_PS_WC_SHIFT 16
+
+#define DSI_BLLP_WC		0x5C
+#define BLLP_WC_SHIFT 0
+#define BLLP_WC_MASK  0xfff
 
 #define DSI_CMDQ_SIZE		0x60
 #define CMDQ_SIZE			0x3f
 #define CMDQ_SIZE_SEL		BIT(15)
 
 #define DSI_HSTX_CKL_WC		0x64
+#define HSTX_CKL_WC_SHIFT 2
+#define HSTX_CKL_WC_MASK  0x3fff
 
 #define DSI_RX_DATA0		0x74
 #define DSI_RX_DATA1		0x78
@@ -118,12 +130,22 @@
 #define HS_PREP				GENMASK(15, 8)
 #define HS_ZERO				GENMASK(23, 16)
 #define HS_TRAIL			GENMASK(31, 24)
+#define LPX_SHIFT 0
+#define LPX_MASK  0xff
+#define DA_HS_PREP_SHIFT 8
+#define DA_HS_PREP_MASK  0xff
+#define DA_HS_ZERO_SHIFT 16
+#define DA_HS_ZERO_MASK  0xff
+#define DA_HS_TRAIL_SHIFT 24
+#define DA_HS_TRAIL_MASK  0xff
 
 #define DSI_PHY_TIMECON1	0x114
 #define TA_GO				GENMASK(7, 0)
 #define TA_SURE				GENMASK(15, 8)
 #define TA_GET				GENMASK(23, 16)
 #define DA_HS_EXIT			GENMASK(31, 24)
+#define DA_HS_EXIT_SHIFT 24
+#define DA_HS_EXIT_MASK  0xff
 
 #define DSI_PHY_TIMECON2	0x118
 #define CONT_DET			GENMASK(7, 0)
@@ -154,6 +176,7 @@
 #define DATA_1				GENMASK(31, 24)
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
+#define REG_FIELD_VALUE(reg, field) (((reg) >> (field##_SHIFT)) & (field##_MASK))
 
 #define MTK_DSI_HOST_IS_READ(type) \
 	((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
@@ -187,6 +210,7 @@ struct mtk_dsi_driver_data {
 	bool has_shadow_ctl;
 	bool has_size_ctl;
 	bool cmdq_long_packet_ctl;
+	bool support_per_frame_lp;
 };
 
 struct mtk_dsi {
@@ -425,6 +449,121 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
 	writel(ps_val, dsi->regs + DSI_PSCTRL);
 }
 
+static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)
+{
+	u32 horizontal_sync_active_byte;
+	u32 horizontal_backporch_byte;
+	u32 horizontal_frontporch_byte;
+	u32 dsi_tmp_buf_bpp;
+	unsigned int lpx, da_hs_exit, da_hs_prep, da_hs_trail;
+	unsigned int da_hs_zero, ps_wc, hs_vb_ps_wc;
+	u32 bllp_wc, bllp_en, v_active_roundup, hstx_cklp_wc;
+	u32 hstx_cklp_wc_max, hstx_cklp_wc_min;
+	struct videomode *vm = &dsi->vm;
+
+	if (dsi->format == MIPI_DSI_FMT_RGB565)
+		dsi_tmp_buf_bpp = 2;
+	else
+		dsi_tmp_buf_bpp = 3;
+
+	da_hs_trail = REG_FIELD_VALUE(readl(dsi->regs + DSI_PHY_TIMECON0),
+		DA_HS_TRAIL);
+	bllp_en = REG_FIELD_VALUE(readl(dsi->regs + DSI_TXRX_CTRL),
+		HSTX_BLLP_EN);
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE) {
+		horizontal_sync_active_byte =
+			vm->hsync_len * dsi_tmp_buf_bpp - 10;
+		horizontal_backporch_byte =
+			vm->hback_porch * dsi_tmp_buf_bpp - 10;
+		horizontal_frontporch_byte =
+			vm->hfront_porch * dsi_tmp_buf_bpp - 12;
+
+		ps_wc = REG_FIELD_VALUE(readl(dsi->regs + DSI_PSCTRL), PS_WC);
+		v_active_roundup = (32 + horizontal_sync_active_byte +
+			horizontal_backporch_byte + ps_wc +
+			horizontal_frontporch_byte) % dsi->lanes;
+		if (v_active_roundup)
+			horizontal_backporch_byte = horizontal_backporch_byte +
+				dsi->lanes - v_active_roundup;
+		hstx_cklp_wc_min = (DIV_ROUND_UP((12 + 2 + 4 +
+			horizontal_sync_active_byte), dsi->lanes) + da_hs_trail + 1)
+			* dsi->lanes / 6 - 1;
+		hstx_cklp_wc_max = (DIV_ROUND_UP((20 + 6 + 4 +
+			horizontal_sync_active_byte + horizontal_backporch_byte +
+			ps_wc), dsi->lanes) + da_hs_trail + 1) * dsi->lanes / 6 - 1;
+	} else {
+		horizontal_sync_active_byte = vm->hsync_len * dsi_tmp_buf_bpp - 4;
+
+		horizontal_backporch_byte = (vm->hback_porch + vm->hsync_len) *
+			dsi_tmp_buf_bpp - 10;
+		hstx_cklp_wc_min = (DIV_ROUND_UP(4, dsi->lanes) + da_hs_trail + 1)
+			* dsi->lanes / 6 - 1;
+
+		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+			ps_wc = REG_FIELD_VALUE(readl(dsi->regs + DSI_PSCTRL), PS_WC);
+			bllp_wc = REG_FIELD_VALUE(readl(dsi->regs + DSI_BLLP_WC), BLLP_WC);
+			horizontal_frontporch_byte = (vm->hfront_porch *
+				dsi_tmp_buf_bpp - 18);
+
+			v_active_roundup = (28 + horizontal_backporch_byte + ps_wc +
+				horizontal_frontporch_byte + bllp_wc) % dsi->lanes;
+			if (v_active_roundup)
+				horizontal_backporch_byte = horizontal_backporch_byte +
+				dsi->lanes - v_active_roundup;
+			if (bllp_en) {
+				hstx_cklp_wc_max = (DIV_ROUND_UP((16 + 6 + 4 +
+					horizontal_backporch_byte + bllp_wc + ps_wc),
+					dsi->lanes) + da_hs_trail + 1) * dsi->lanes / 6 - 1;
+			} else {
+				hstx_cklp_wc_max = (DIV_ROUND_UP((12 + 4 + 4 +
+					horizontal_backporch_byte + bllp_wc + ps_wc),
+					dsi->lanes) + da_hs_trail + 1) * dsi->lanes / 6 - 1;
+			}
+		} else {
+			ps_wc = REG_FIELD_VALUE(readl(dsi->regs + DSI_PSCTRL), PS_WC);
+			horizontal_frontporch_byte = (vm->hfront_porch *
+				dsi_tmp_buf_bpp - 12);
+
+			v_active_roundup = (22 + horizontal_backporch_byte + ps_wc +
+				horizontal_frontporch_byte) % dsi->lanes;
+			if (v_active_roundup)
+				horizontal_backporch_byte = horizontal_backporch_byte +
+				dsi->lanes - v_active_roundup;
+
+			hstx_cklp_wc_max = (DIV_ROUND_UP((12 + 4 + 4 +
+				horizontal_backporch_byte + ps_wc),
+				dsi->lanes) + da_hs_trail + 1) * dsi->lanes / 6 - 1;
+		}
+	}
+	hstx_cklp_wc = REG_FIELD_VALUE(ps_wc, HSTX_CKL_WC);
+	if (hstx_cklp_wc <= hstx_cklp_wc_min ||
+		hstx_cklp_wc >= hstx_cklp_wc_max) {
+		hstx_cklp_wc = (hstx_cklp_wc_max / 2) << HSTX_CKL_WC_SHIFT;
+		writel(hstx_cklp_wc, dsi->regs + DSI_HSTX_CKL_WC);
+	}
+	hstx_cklp_wc = hstx_cklp_wc >> HSTX_CKL_WC_SHIFT;
+	if (hstx_cklp_wc <= hstx_cklp_wc_min ||
+		hstx_cklp_wc >= hstx_cklp_wc_max) {
+		DRM_WARN("Wrong setting of hstx_ckl_wc\n");
+	}
+
+	lpx = REG_FIELD_VALUE(readl(dsi->regs + DSI_PHY_TIMECON0), LPX);
+	da_hs_exit = REG_FIELD_VALUE(readl(dsi->regs + DSI_PHY_TIMECON1), DA_HS_EXIT);
+	da_hs_prep = REG_FIELD_VALUE(readl(dsi->regs + DSI_PHY_TIMECON0), DA_HS_PREP);
+	da_hs_zero = REG_FIELD_VALUE(readl(dsi->regs + DSI_PHY_TIMECON0), DA_HS_ZERO);
+	ps_wc = REG_FIELD_VALUE(readl(dsi->regs + DSI_PSCTRL), PS_WC);
+	hs_vb_ps_wc = ps_wc -
+		(lpx + da_hs_exit + da_hs_prep + da_hs_zero + 2)
+		* dsi->lanes;
+	horizontal_frontporch_byte = (1 << HFP_HS_EN)
+		| (hs_vb_ps_wc << HFP_HS_VB_PS_WC_SHIFT)
+		| (horizontal_frontporch_byte);
+
+	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
+	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
+	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
+}
+
 static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 {
 	u32 horizontal_sync_active_byte;
@@ -499,6 +638,9 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
 
+	if (dsi->driver_data->support_per_frame_lp)
+		mtk_dsi_config_vdo_timing_per_frame_lp(dsi);
+
 	mtk_dsi_ps_control(dsi, false);
 }
 
@@ -1193,6 +1335,7 @@ static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
 	.has_shadow_ctl = true,
 	.has_size_ctl = true,
 	.cmdq_long_packet_ctl = true,
+	.support_per_frame_lp = true,
 };
 
 static const struct of_device_id mtk_dsi_of_match[] = {
-- 
2.43.0


