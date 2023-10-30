Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAFE7DB7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjJ3KSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJ3KR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:17:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68948A49;
        Mon, 30 Oct 2023 03:06:37 -0700 (PDT)
X-UUID: fe97c00e770b11ee8051498923ad61e6-20231030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=V//2igGYyhPN/Zf+1xzCViEyUZjAItOCgKH+HJwan9o=;
        b=k/zQc4XzfRrY7sNoNumktd3sW/P4oV1ntnWoDE8MtYho06ne+eb36SXmF5CBHE/Tj/KNL0WQLri1Srj0BZ0FmMY8XpPk0UAB5/AvX11tnKRv7x/N9W4tYzkWEhLv6mMe6eJpRT+iOxhUdg+p7RoKHB3n+veuKzm/rRpyVOVhoe8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:40928f23-a4d5-4e88-ad70-0422b2e47e62,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:96257bd7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe97c00e770b11ee8051498923ad61e6-20231030
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1921493740; Mon, 30 Oct 2023 18:06:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Oct 2023 18:06:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Oct 2023 18:06:28 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v8 04/12] media: platform: mtk-mdp3: introduce more MDP3 components
Date:   Mon, 30 Oct 2023 18:06:18 +0800
Message-ID: <20231030100626.12564-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration of more components in MT8195 MDP3.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mdp_reg_aal.h      | 25 ++++++
 .../platform/mediatek/mdp3/mdp_reg_color.h    | 31 +++++++
 .../media/platform/mediatek/mdp3/mdp_reg_fg.h | 23 +++++
 .../platform/mediatek/mdp3/mdp_reg_hdr.h      | 31 +++++++
 .../platform/mediatek/mdp3/mdp_reg_merge.h    | 25 ++++++
 .../platform/mediatek/mdp3/mdp_reg_ovl.h      | 25 ++++++
 .../platform/mediatek/mdp3/mdp_reg_pad.h      | 21 +++++
 .../platform/mediatek/mdp3/mdp_reg_rdma.h     | 24 ++++++
 .../platform/mediatek/mdp3/mdp_reg_rsz.h      |  2 +
 .../platform/mediatek/mdp3/mdp_reg_tdshp.h    | 34 ++++++++
 .../platform/mediatek/mdp3/mdp_reg_wrot.h     |  8 ++
 .../platform/mediatek/mdp3/mtk-mdp3-comp.h    | 85 +++++++++++++++----
 12 files changed, 318 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h

diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
new file mode 100644
index 000000000000..4b9513e54543
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_AAL_H__
+#define __MDP_REG_AAL_H__
+
+#define MDP_AAL_EN			(0x000)
+#define MDP_AAL_CFG			(0x020)
+#define MDP_AAL_SIZE			(0x030)
+#define MDP_AAL_OUTPUT_SIZE		(0x034)
+#define MDP_AAL_OUTPUT_OFFSET		(0x038)
+#define MDP_AAL_CFG_MAIN		(0x200)
+
+/* MASK */
+#define MDP_AAL_EN_MASK			(0x01)
+#define MDP_AAL_CFG_MASK		(0x70FF00B3)
+#define MDP_AAL_SIZE_MASK		(0x1FFF1FFF)
+#define MDP_AAL_OUTPUT_SIZE_MASK	(0x1FFF1FFF)
+#define MDP_AAL_OUTPUT_OFFSET_MASK	(0x0FF00FF)
+#define MDP_AAL_CFG_MAIN_MASK		(0x0FE)
+
+#endif  // __MDP_REG_AAL_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_color.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
new file mode 100644
index 000000000000..f72503975b24
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_COLOR_H__
+#define __MDP_REG_COLOR_H__
+
+#define MDP_COLOR_WIN_X_MAIN			(0x40C)
+#define MDP_COLOR_WIN_Y_MAIN			(0x410)
+#define MDP_COLOR_START				(0xC00)
+#define MDP_COLOR_INTEN				(0xC04)
+#define MDP_COLOR_OUT_SEL			(0xC0C)
+#define MDP_COLOR_INTERNAL_IP_WIDTH		(0xC50)
+#define MDP_COLOR_INTERNAL_IP_HEIGHT		(0xC54)
+#define MDP_COLOR_CM1_EN			(0xC60)
+#define MDP_COLOR_CM2_EN			(0xCA0)
+
+/* MASK */
+#define MDP_COLOR_WIN_X_MAIN_MASK		(0xFFFFFFFF)
+#define MDP_COLOR_WIN_Y_MAIN_MASK		(0xFFFFFFFF)
+#define MDP_COLOR_START_MASK			(0x0FF013F)
+#define MDP_COLOR_INTEN_MASK			(0x07)
+#define MDP_COLOR_OUT_SEL_MASK			(0x0777)
+#define MDP_COLOR_INTERNAL_IP_WIDTH_MASK	(0x03FFF)
+#define MDP_COLOR_INTERNAL_IP_HEIGHT_MASK	(0x03FFF)
+#define MDP_COLOR_CM1_EN_MASK			(0x03)
+#define MDP_COLOR_CM2_EN_MASK			(0x017)
+
+#endif  // __MDP_REG_COLOR_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
new file mode 100644
index 000000000000..d90bcad33a59
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_FG_H__
+#define __MDP_REG_FG_H__
+
+#define MDP_FG_TRIGGER			(0x0)
+#define MDP_FG_FG_CTRL_0		(0x20)
+#define MDP_FG_FG_CK_EN			(0x24)
+#define MDP_FG_TILE_INFO_0		(0x418)
+#define MDP_FG_TILE_INFO_1		(0x41c)
+
+/* MASK */
+#define MDP_FG_TRIGGER_MASK		(0x00000007)
+#define MDP_FG_FG_CTRL_0_MASK		(0x00000033)
+#define MDP_FG_FG_CK_EN_MASK		(0x0000000F)
+#define MDP_FG_TILE_INFO_0_MASK		(0xFFFFFFFF)
+#define MDP_FG_TILE_INFO_1_MASK		(0xFFFFFFFF)
+
+#endif  //__MDP_REG_FG_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
new file mode 100644
index 000000000000..c19fbba39fc0
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_HDR_H__
+#define __MDP_REG_HDR_H__
+
+#define MDP_HDR_TOP			(0x000)
+#define MDP_HDR_RELAY			(0x004)
+#define MDP_HDR_SIZE_0			(0x014)
+#define MDP_HDR_SIZE_1			(0x018)
+#define MDP_HDR_SIZE_2			(0x01C)
+#define MDP_HDR_HIST_CTRL_0		(0x020)
+#define MDP_HDR_HIST_CTRL_1		(0x024)
+#define MDP_HDR_HIST_ADDR		(0x0DC)
+#define MDP_HDR_TILE_POS		(0x118)
+
+/* MASK */
+#define MDP_HDR_RELAY_MASK		(0x01)
+#define MDP_HDR_TOP_MASK		(0xFF0FEB6D)
+#define MDP_HDR_SIZE_0_MASK		(0x1FFF1FFF)
+#define MDP_HDR_SIZE_1_MASK		(0x1FFF1FFF)
+#define MDP_HDR_SIZE_2_MASK		(0x1FFF1FFF)
+#define MDP_HDR_HIST_CTRL_0_MASK	(0x1FFF1FFF)
+#define MDP_HDR_HIST_CTRL_1_MASK	(0x1FFF1FFF)
+#define MDP_HDR_HIST_ADDR_MASK		(0xBF3F2F3F)
+#define MDP_HDR_TILE_POS_MASK		(0x1FFF1FFF)
+
+#endif // __MDP_REG_HDR_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
new file mode 100644
index 000000000000..46be27e2a656
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_MERGE_H__
+#define __MDP_REG_MERGE_H__
+
+#define MDP_MERGE_ENABLE	(0x000)
+#define MDP_MERGE_CFG_0		(0x010)
+#define MDP_MERGE_CFG_4		(0x020)
+#define MDP_MERGE_CFG_12	(0x040)
+#define MDP_MERGE_CFG_24	(0x070)
+#define MDP_MERGE_CFG_25	(0x074)
+
+/* MASK */
+#define MDP_MERGE_ENABLE_MASK	(0xFFFFFFFF)
+#define MDP_MERGE_CFG_0_MASK	(0xFFFFFFFF)
+#define MDP_MERGE_CFG_4_MASK	(0xFFFFFFFF)
+#define MDP_MERGE_CFG_12_MASK	(0xFFFFFFFF)
+#define MDP_MERGE_CFG_24_MASK	(0xFFFFFFFF)
+#define MDP_MERGE_CFG_25_MASK	(0xFFFFFFFF)
+
+#endif //__MDP_REG_MERGE_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
new file mode 100644
index 000000000000..21d2d0323293
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_OVL_H__
+#define __MDP_REG_OVL_H__
+
+#define MDP_OVL_EN			(0x00c)
+#define MDP_OVL_ROI_SIZE		(0x020)
+#define MDP_OVL_DP_CON			(0x024)
+#define MDP_OVL_SRC_CON			(0x02c)
+#define MDP_OVL_L0_CON			(0x030)
+#define MDP_OVL_L0_SRC_SIZE		(0x038)
+
+/* MASK */
+#define MDP_OVL_DP_CON_MASK		(0x0FFFFFFF)
+#define MDP_OVL_EN_MASK			(0xB07D07B1)
+#define MDP_OVL_L0_CON_MASK		(0xFFFFFFFF)
+#define MDP_OVL_L0_SRC_SIZE_MASK	(0x1FFF1FFF)
+#define MDP_OVL_ROI_SIZE_MASK		(0x1FFF1FFF)
+#define MDP_OVL_SRC_CON_MASK		(0x0000031F)
+
+#endif  //__MDP_REG_OVL_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
new file mode 100644
index 000000000000..0e89f1db19ed
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_PAD_H__
+#define __MDP_REG_PAD_H__
+
+#define MDP_PAD_CON			(0x000)
+#define MDP_PAD_PIC_SIZE		(0x004)
+#define MDP_PAD_W_SIZE			(0x008)
+#define MDP_PAD_H_SIZE			(0x00c)
+
+/* MASK */
+#define MDP_PAD_CON_MASK		(0x00000007)
+#define MDP_PAD_PIC_SIZE_MASK		(0xFFFFFFFF)
+#define MDP_PAD_W_SIZE_MASK		(0x1FFF1FFF)
+#define MDP_PAD_H_SIZE_MASK		(0x1FFF1FFF)
+
+#endif  // __MDP_REG_PAD_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
index be4065e252d3..0affb2a3b958 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
@@ -26,6 +26,18 @@
 #define MDP_RDMA_SRC_OFFSET_2           0x128
 #define MDP_RDMA_SRC_OFFSET_0_P         0x148
 #define MDP_RDMA_TRANSFORM_0            0x200
+#define MDP_RDMA_DMABUF_CON_0           0x240
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_0    0x248
+#define MDP_RDMA_ULTRA_TH_LOW_CON_0     0x250
+#define MDP_RDMA_DMABUF_CON_1           0x258
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_1    0x260
+#define MDP_RDMA_ULTRA_TH_LOW_CON_1     0x268
+#define MDP_RDMA_DMABUF_CON_2           0x270
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_2    0x278
+#define MDP_RDMA_ULTRA_TH_LOW_CON_2     0x280
+#define MDP_RDMA_DMABUF_CON_3           0x288
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_3    0x290
+#define MDP_RDMA_ULTRA_TH_LOW_CON_3     0x298
 #define MDP_RDMA_RESV_DUMMY_0           0x2a0
 #define MDP_RDMA_MON_STA_1              0x408
 #define MDP_RDMA_SRC_BASE_0             0xf00
@@ -54,6 +66,18 @@
 #define MDP_RDMA_SRC_OFFSET_2_MASK          0xffffffff
 #define MDP_RDMA_SRC_OFFSET_0_P_MASK        0xffffffff
 #define MDP_RDMA_TRANSFORM_0_MASK           0xff110777
+#define MDP_RDMA_DMABUF_CON_0_MASK          0x0fff00ff
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_0_MASK   0x3fffffff
+#define MDP_RDMA_ULTRA_TH_LOW_CON_0_MASK    0x3fffffff
+#define MDP_RDMA_DMABUF_CON_1_MASK          0x0f7f007f
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_1_MASK   0x3fffffff
+#define MDP_RDMA_ULTRA_TH_LOW_CON_1_MASK    0x3fffffff
+#define MDP_RDMA_DMABUF_CON_2_MASK          0x0f3f003f
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_2_MASK   0x3fffffff
+#define MDP_RDMA_ULTRA_TH_LOW_CON_2_MASK    0x3fffffff
+#define MDP_RDMA_DMABUF_CON_3_MASK          0x0f3f003f
+#define MDP_RDMA_ULTRA_TH_HIGH_CON_3_MASK   0x3fffffff
+#define MDP_RDMA_ULTRA_TH_LOW_CON_3_MASK    0x3fffffff
 #define MDP_RDMA_RESV_DUMMY_0_MASK          0xffffffff
 #define MDP_RDMA_MON_STA_1_MASK             0xffffffff
 #define MDP_RDMA_SRC_BASE_0_MASK            0xffffffff
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
index 484f6d60641f..187531db8e3b 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
@@ -20,6 +20,7 @@
 #define PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET                 0x02c
 #define PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET              0x030
 #define PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET             0x034
+#define RSZ_ETC_CONTROL                                   0x22c
 
 /* MASK */
 #define PRZ_ENABLE_MASK                                   0x00010001
@@ -35,5 +36,6 @@
 #define PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET_MASK            0x001fffff
 #define PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET_MASK         0x0000ffff
 #define PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET_MASK        0x001fffff
+#define RSZ_ETC_CONTROL_MASK                              0xff770000
 
 #endif // __MDP_REG_RSZ_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
new file mode 100644
index 000000000000..83b5f9b432d8
--- /dev/null
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
+ */
+
+#ifndef __MDP_REG_TDSHP_H__
+#define __MDP_REG_TDSHP_H__
+
+#define MDP_HIST_CFG_00				(0x064)
+#define MDP_HIST_CFG_01				(0x068)
+#define MDP_TDSHP_CTRL				(0x100)
+#define MDP_TDSHP_CFG				(0x110)
+#define MDP_TDSHP_INPUT_SIZE			(0x120)
+#define MDP_TDSHP_OUTPUT_OFFSET			(0x124)
+#define MDP_TDSHP_OUTPUT_SIZE			(0x128)
+#define MDP_LUMA_HIST_INIT			(0x200)
+#define MDP_DC_TWO_D_W1_RESULT_INIT		(0x260)
+#define MDP_CONTOUR_HIST_INIT			(0x398)
+
+/* MASK */
+#define MDP_HIST_CFG_00_MASK			(0xFFFFFFFF)
+#define MDP_HIST_CFG_01_MASK			(0xFFFFFFFF)
+#define MDP_LUMA_HIST_MASK			(0xFFFFFFFF)
+#define MDP_TDSHP_CTRL_MASK			(0x07)
+#define MDP_TDSHP_CFG_MASK			(0x03F7)
+#define MDP_TDSHP_INPUT_SIZE_MASK		(0x1FFF1FFF)
+#define MDP_TDSHP_OUTPUT_OFFSET_MASK		(0x0FF00FF)
+#define MDP_TDSHP_OUTPUT_SIZE_MASK		(0x1FFF1FFF)
+#define MDP_LUMA_HIST_INIT_MASK			(0xFFFFFFFF)
+#define MDP_DC_TWO_D_W1_RESULT_INIT_MASK	(0x007FFFFF)
+#define MDP_CONTOUR_HIST_INIT_MASK		(0xFFFFFFFF)
+
+#endif  // __MDP_REG_TDSHP_H__
diff --git a/drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h b/drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
index 6d3ff0e2b672..b6f016d2c29d 100644
--- a/drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
+++ b/drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
@@ -17,14 +17,18 @@
 #define VIDO_STRIDE                 0x030
 #define VIDO_OFST_ADDR_C            0x038
 #define VIDO_STRIDE_C               0x03c
+#define VIDO_CTRL_2                 0x048
 #define VIDO_DITHER                 0x054
 #define VIDO_STRIDE_V               0x06c
 #define VIDO_OFST_ADDR_V            0x068
 #define VIDO_RSV_1                  0x070
+#define VIDO_DMA_PREULTRA           0x074
 #define VIDO_IN_SIZE                0x078
 #define VIDO_ROT_EN                 0x07c
 #define VIDO_FIFO_TEST              0x080
 #define VIDO_MAT_CTRL               0x084
+#define VIDO_SCAN_10BIT             0x0dc
+#define VIDO_PENDING_ZERO           0x0e0
 #define VIDO_BASE_ADDR              0xf00
 #define VIDO_BASE_ADDR_C            0xf04
 #define VIDO_BASE_ADDR_V            0xf08
@@ -40,14 +44,18 @@
 #define VIDO_STRIDE_MASK                0x0000ffff
 #define VIDO_OFST_ADDR_C_MASK           0x0fffffff
 #define VIDO_STRIDE_C_MASK              0x0000ffff
+#define VIDO_CTRL_2_MASK                0x0000000f
 #define VIDO_DITHER_MASK                0xff000001
 #define VIDO_STRIDE_V_MASK              0x0000ffff
 #define VIDO_OFST_ADDR_V_MASK           0x0fffffff
 #define VIDO_RSV_1_MASK                 0xffffffff
+#define VIDO_DMA_PREULTRA_MASK		0x00ffffff
 #define VIDO_IN_SIZE_MASK               0x1fff1fff
 #define VIDO_ROT_EN_MASK                0x00000001
 #define VIDO_FIFO_TEST_MASK             0x00000fff
 #define VIDO_MAT_CTRL_MASK              0x000000f3
+#define VIDO_SCAN_10BIT_MASK            0x0000000f
+#define VIDO_PENDING_ZERO_MASK          0x07ffffff
 #define VIDO_BASE_ADDR_MASK             0xffffffff
 #define VIDO_BASE_ADDR_C_MASK           0xffffffff
 #define VIDO_BASE_ADDR_V_MASK           0xffffffff
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
index e89c51e1edb7..e6cbc6ab6bae 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
@@ -84,22 +84,66 @@ enum mtk_mdp_comp_id {
 	MDP_COMP_CAMIN,		/* 9 */
 	MDP_COMP_CAMIN2,	/* 10 */
 	MDP_COMP_RDMA0,		/* 11 */
-	MDP_COMP_AAL0,		/* 12 */
-	MDP_COMP_CCORR0,	/* 13 */
-	MDP_COMP_RSZ0,		/* 14 */
-	MDP_COMP_RSZ1,		/* 15 */
-	MDP_COMP_TDSHP0,	/* 16 */
-	MDP_COMP_COLOR0,	/* 17 */
-	MDP_COMP_PATH0_SOUT,	/* 18 */
-	MDP_COMP_PATH1_SOUT,	/* 19 */
-	MDP_COMP_WROT0,		/* 20 */
-	MDP_COMP_WDMA,		/* 21 */
-
-	/* Dummy Engine */
-	MDP_COMP_RDMA1,		/* 22 */
-	MDP_COMP_RSZ2,		/* 23 */
-	MDP_COMP_TDSHP1,	/* 24 */
-	MDP_COMP_WROT1,		/* 25 */
+	MDP_COMP_RDMA1,		/* 12 */
+	MDP_COMP_RDMA2,		/* 13 */
+	MDP_COMP_RDMA3,		/* 14 */
+	MDP_COMP_AAL0,		/* 15 */
+	MDP_COMP_AAL1,		/* 16 */
+	MDP_COMP_AAL2,		/* 17 */
+	MDP_COMP_AAL3,		/* 18 */
+	MDP_COMP_CCORR0,	/* 19 */
+	MDP_COMP_RSZ0,		/* 20 */
+	MDP_COMP_RSZ1,		/* 21 */
+	MDP_COMP_RSZ2,		/* 22 */
+	MDP_COMP_RSZ3,		/* 23 */
+	MDP_COMP_TDSHP0,	/* 24 */
+	MDP_COMP_TDSHP1,	/* 25 */
+	MDP_COMP_TDSHP2,	/* 26 */
+	MDP_COMP_TDSHP3,	/* 27 */
+	MDP_COMP_COLOR0,	/* 28 */
+	MDP_COMP_COLOR1,	/* 29 */
+	MDP_COMP_COLOR2,	/* 30 */
+	MDP_COMP_COLOR3,	/* 31 */
+	MDP_COMP_PATH0_SOUT,	/* 32 */
+	MDP_COMP_PATH1_SOUT,	/* 33 */
+	MDP_COMP_WROT0,		/* 34 */
+	MDP_COMP_WROT1,		/* 35 */
+	MDP_COMP_WROT2,		/* 36 */
+	MDP_COMP_WROT3,		/* 37 */
+	MDP_COMP_WDMA,		/* 38 */
+	MDP_COMP_SPLIT,		/* 39 */
+	MDP_COMP_SPLIT2,	/* 40 */
+	MDP_COMP_STITCH,	/* 41 */
+	MDP_COMP_FG0,		/* 42 */
+	MDP_COMP_FG1,		/* 43 */
+	MDP_COMP_FG2,		/* 44 */
+	MDP_COMP_FG3,		/* 45 */
+	MDP_COMP_TO_SVPP2MOUT,	/* 46 */
+	MDP_COMP_TO_SVPP3MOUT,	/* 47 */
+	MDP_COMP_TO_WARP0MOUT,	/* 48 */
+	MDP_COMP_TO_WARP1MOUT,	/* 49 */
+	MDP_COMP_VPP0_SOUT,	/* 50 */
+	MDP_COMP_VPP1_SOUT,	/* 51 */
+	MDP_COMP_PQ0_SOUT,	/* 52 */
+	MDP_COMP_PQ1_SOUT,	/* 53 */
+	MDP_COMP_HDR0,		/* 54 */
+	MDP_COMP_HDR1,		/* 55 */
+	MDP_COMP_HDR2,		/* 56 */
+	MDP_COMP_HDR3,		/* 57 */
+	MDP_COMP_OVL0,		/* 58 */
+	MDP_COMP_OVL1,		/* 59 */
+	MDP_COMP_PAD0,		/* 60 */
+	MDP_COMP_PAD1,		/* 61 */
+	MDP_COMP_PAD2,		/* 62 */
+	MDP_COMP_PAD3,		/* 63 */
+	MDP_COMP_TCC0,		/* 64 */
+	MDP_COMP_TCC1,		/* 65 */
+	MDP_COMP_MERGE2,	/* 66 */
+	MDP_COMP_MERGE3,	/* 67 */
+	MDP_COMP_VDO0DL0,	/* 68 */
+	MDP_COMP_VDO1DL0,	/* 69 */
+	MDP_COMP_VDO0DL1,	/* 70 */
+	MDP_COMP_VDO1DL1,	/* 71 */
 
 	MDP_MAX_COMP_COUNT	/* ALWAYS keep at the end */
 };
@@ -117,12 +161,21 @@ enum mdp_comp_type {
 	MDP_COMP_TYPE_COLOR,
 	MDP_COMP_TYPE_DRE,
 	MDP_COMP_TYPE_CCORR,
+	MDP_COMP_TYPE_AAL,
+	MDP_COMP_TYPE_TCC,
 	MDP_COMP_TYPE_HDR,
+	MDP_COMP_TYPE_SPLIT,
+	MDP_COMP_TYPE_STITCH,
+	MDP_COMP_TYPE_FG,
+	MDP_COMP_TYPE_OVL,
+	MDP_COMP_TYPE_PAD,
+	MDP_COMP_TYPE_MERGE,
 
 	MDP_COMP_TYPE_IMGI,
 	MDP_COMP_TYPE_WPEI,
 	MDP_COMP_TYPE_EXTO,	/* External path */
 	MDP_COMP_TYPE_DL_PATH,	/* Direct-link path */
+	MDP_COMP_TYPE_DUMMY,
 
 	MDP_COMP_TYPE_COUNT	/* ALWAYS keep at the end */
 };
-- 
2.18.0

