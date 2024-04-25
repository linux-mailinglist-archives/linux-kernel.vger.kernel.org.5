Return-Path: <linux-kernel+bounces-157939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CD8B18F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3921F24F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94A92557F;
	Thu, 25 Apr 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SJ3jIUIZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD418046;
	Thu, 25 Apr 2024 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012441; cv=none; b=bJ19OOGCcq1HzKBG1qBQ5MuUCRzqynmFjFMFABNOv9VGpjq5+lGd5mlN1ZDyJNEX9emI3RKO55WBljkfhfZ0NKuqxOwAcEJvJaBHFvY3fR2JLeW68j5Pkel9MghnqrT5LR39KHTKNItmy5dlNYc02K0zhxlg+LU4c3GPaE9nh5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012441; c=relaxed/simple;
	bh=oV2u7C2clulg40aCow2gvPTdjyJAui+StErQVpAOZII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0UCYhptNTGeEhS2GjR1lEi1bXuDKCyFwp2y9E5jvCxn5mFmR+ueILzgmagFF5RbfX+4AznLF6waHxgg8iR+rqZYT+imRm+EADIR15op42Xu0rDIOc5oVrAtgs8rNJGZLOSCAdtL+miP8vox9XqWo9Wbv0VcW+633QL2cb4CRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SJ3jIUIZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 408b74f202ac11ef935d6952f98a51a9-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5jltLh8iSzrYN1EJAl7FVMDdj61NB0MZqta7aiVRDiI=;
	b=SJ3jIUIZRygc6M1f96TrNWIkK9/YPl8oT3eONYioP/oC8uD9dcyAIsWz2NpQ3fMOVEE0/hfK2HEZ7kaayQCY1EKhFVrJExPwp53kJmUZx8JkJqW4Lcnj83HPlrV1I//A/7v/aTYhx30erNdwfkC74vdelALmEITJADXpBOTzpgg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c1edecc8-af49-443f-92ad-bb8fd74e11b8,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:1a7dfc91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 408b74f202ac11ef935d6952f98a51a9-20240425
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2113217131; Thu, 25 Apr 2024 10:33:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 10:33:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 10:33:49 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH 2/3] net: phy: mediatek: Add mtk phy lib for token ring access & LED/other manipulations
Date: Thu, 25 Apr 2024 10:33:24 +0800
Message-ID: <20240425023325.15586-3-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Integrate some common phy manipulations in mtk-phy-lib:
1. Token ring access: This is proprietary register access on page 52b5.
Use these APIs so we can see which fields we're going to modify/set/clear.
2. LED: External/internal giga & internal 2.5g phy share almost the same
LED control registers/logic.
3. Extend 1G TX/RX link pulse time: We observe that some devices' 1G
training time violates specification, which may last 2230ms and affect
later TX/RX link pulse time. So we try to extend our 1G TX/RX link pulse
time so that we can still detect such devices.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                            |   2 +
 drivers/net/phy/mediatek/Kconfig       |   5 +
 drivers/net/phy/mediatek/Makefile      |   1 +
 drivers/net/phy/mediatek/mtk-ge-soc.c  | 522 ++++++++++---------------
 drivers/net/phy/mediatek/mtk-ge.c      | 148 +++++--
 drivers/net/phy/mediatek/mtk-phy-lib.c | 330 ++++++++++++++++
 drivers/net/phy/mediatek/mtk.h         |  97 +++++
 7 files changed, 764 insertions(+), 341 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
 create mode 100644 drivers/net/phy/mediatek/mtk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b59edadfb8fe..1dbecd14572e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13909,7 +13909,9 @@ M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
+F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
+F:	drivers/net/phy/mediatek/mtk.h
 F:	drivers/phy/mediatek/phy-mtk-xfi-tphy.c
 
 MEDIATEK I2C CONTROLLER DRIVER
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 5f97e27af600..c2aabed185a2 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config MTK_NET_PHYLIB
+	tristate
+
 config MEDIATEK_GE_PHY
 	tristate "MediaTek Gigabit Ethernet PHYs"
+	select MTK_NET_PHYLIB
 	help
 	  Supports the MediaTek Gigabit Ethernet PHYs.
 
@@ -8,6 +12,7 @@ config MEDIATEK_GE_SOC_PHY
 	bool "MediaTek SoC Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
 	select NVMEM_MTK_EFUSE
+	select MTK_NET_PHYLIB
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
 
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 005bde26c1d7..814879d0abe5 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 0f3a1538a8b8..991c5b608db4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -8,6 +8,8 @@
 #include <linux/phy.h>
 #include <linux/regmap.h>
 
+#include "mtk.h"
+
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
 
@@ -22,7 +24,78 @@
 #define MTK_PHY_SMI_DET_ON_THRESH_MASK		GENMASK(13, 8)
 
 #define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
-#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0x7, data_addr = 0x15 */
+#define NORMAL_MSE_LO_THRESH_MASK		GENMASK(15, 8) /* NormMseLoThresh */
+
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define REMOTE_ACK_COUNT_LIMIT_CTRL_MASK	GENMASK(2, 1) /* RemAckCntLimitCtrl */
+
+/* ch_addr = 0x1, node_addr = 0xd, data_addr = 0x20 */
+#define VCO_SLICER_THRESH_HIGH_MASK		GENMASK(23, 0) /* VcoSlicerThreshBitsHigh */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x0 */
+#define DFE_TAIL_EANBLE_VGA_TRHESH_1000		GENMASK(5, 1) /* DfeTailEnableVgaThresh1000 */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x1 */
+#define MRVL_TR_FIX_100KP_MASK			GENMASK(22, 20) /* MrvlTrFix100Kp */
+#define MRVL_TR_FIX_100KF_MASK			GENMASK(19, 17) /* MrvlTrFix100Kf */
+#define MRVL_TR_FIX_1000KP_MASK			GENMASK(16, 14) /* MrvlTrFix1000Kp */
+#define MRVL_TR_FIX_1000KF_MASK			GENMASK(13, 11) /* MrvlTrFix1000Kf */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x12 */
+#define VGA_DECIMATION_RATE_MASK		GENMASK(8, 5) /* VgaDecRate */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15) /* SlvDSPreadyTime */
+#define MASTER_DSP_READY_TIME_MASK		GENMASK(14, 7) /* MasDSPreadyTime */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x18 */
+#define ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER	BIT(8) /* EnabRandUpdTrig */
+
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x20 */
+#define RESET_SYNC_OFFSET_MASK			GENMASK(11, 8) /* ResetSyncOffset */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x0 */
+#define FFE_UPDATE_GAIN_FORCE_VAL_MASK		GENMASK(9, 7) /* FfeUpdGainForceVal */
+#define FFE_UPDATE_GAIN_FORCE			BIT(6) /* FfeUpdGainForce */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x3 */
+#define TR_FREEZE_MASK				GENMASK(11, 0) /* TrFreeze */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x6 */
+/* SS: Steady-state, KP: Proportional Gain */
+#define SS_TR_KP100_MASK			GENMASK(21, 19) /* SSTrKp100 */
+#define SS_TR_KF100_MASK			GENMASK(18, 16) /* SSTrKf100 */
+#define SS_TR_KP1000_MASTER_MASK		GENMASK(15, 13) /* SSTrKp1000Mas */
+#define SS_TR_KF1000_MASTER_MASK		GENMASK(12, 10) /* SSTrKf1000Mas */
+#define SS_TR_KP1000_SLAVE_MASK			GENMASK(9, 7)   /* SSTrKp1000Slv */
+#define SS_TR_KF1000_SLAVE_MASK			GENMASK(6, 4)   /* SSTrKf1000Slv */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x8 */
+/* clear this bit if wanna select from AFE */
+#define EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE	BIT(4) /* Regsigdet_sel_1000 */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xd */
+#define EEE1000_STAGE2_TR_KF_MASK		GENMASK(13, 11) /* RegEEE_st2TrKf1000 */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0xf */
+#define SLAVE_WAKETR_TIMER_MASK			GENMASK(20, 11) /* RegEEE_slv_waketr_timer_tar */
+#define SLAVE_REMTX_TIMER_MASK			GENMASK(10, 1) /* RegEEE_slv_remtx_timer_tar */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x10 */
+#define SLAVE_WAKEINT_TIMER_MASK		GENMASK(10, 1) /* RegEEE_slv_wake_int_timer_tar */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x14 */
+#define TR_FREEZE_TIMER2_MASK			GENMASK(9, 0) /* RegEEE_trfreeze_timer2 */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x1c */
+#define EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK	GENMASK(8, 0) /* RegEEE100Stg1_tar */
+
+/* ch_addr = 0x2, node_addr = 0xd, data_addr = 0x25 */
+#define WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN	BIT(11) /* REGEEE_wake_slv_tr_wait_dfesigdet_en */
+
 
 #define ANALOG_INTERNAL_OPERATION_MAX_US	20
 #define TXRESERVE_MIN				0
@@ -210,32 +283,6 @@
 #define MTK_PHY_DA_TX_R50_PAIR_D		0x540
 
 /* Registers on MDIO_MMD_VEND2 */
-#define MTK_PHY_LED0_ON_CTRL			0x24
-#define MTK_PHY_LED1_ON_CTRL			0x26
-#define   MTK_PHY_LED_ON_MASK			GENMASK(6, 0)
-#define   MTK_PHY_LED_ON_LINK1000		BIT(0)
-#define   MTK_PHY_LED_ON_LINK100		BIT(1)
-#define   MTK_PHY_LED_ON_LINK10			BIT(2)
-#define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
-#define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
-#define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
-#define   MTK_PHY_LED_ON_FORCE_ON		BIT(6)
-#define   MTK_PHY_LED_ON_POLARITY		BIT(14)
-#define   MTK_PHY_LED_ON_ENABLE			BIT(15)
-
-#define MTK_PHY_LED0_BLINK_CTRL			0x25
-#define MTK_PHY_LED1_BLINK_CTRL			0x27
-#define   MTK_PHY_LED_BLINK_1000TX		BIT(0)
-#define   MTK_PHY_LED_BLINK_1000RX		BIT(1)
-#define   MTK_PHY_LED_BLINK_100TX		BIT(2)
-#define   MTK_PHY_LED_BLINK_100RX		BIT(3)
-#define   MTK_PHY_LED_BLINK_10TX		BIT(4)
-#define   MTK_PHY_LED_BLINK_10RX		BIT(5)
-#define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
-#define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
-#define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
-#define   MTK_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
-
 #define MTK_PHY_LED1_DEFAULT_POLARITIES		BIT(1)
 
 #define MTK_PHY_RG_BG_RASEL			0x115
@@ -290,10 +337,6 @@ enum CAL_MODE {
 	SW_M
 };
 
-#define MTK_PHY_LED_STATE_FORCE_ON	0
-#define MTK_PHY_LED_STATE_FORCE_BLINK	1
-#define MTK_PHY_LED_STATE_NETDEV	2
-
 struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
@@ -705,40 +748,34 @@ static int tx_vcm_cal_sw(struct phy_device *phydev, u8 rg_txreserve_x)
 static void mt798x_phy_common_finetune(struct phy_device *phydev)
 {
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* SlvDSPreadyTime = 24, MasDSPreadyTime = 24 */
-	__phy_write(phydev, 0x11, 0xc71);
-	__phy_write(phydev, 0x12, 0xc);
-	__phy_write(phydev, 0x10, 0x8fae);
-
-	/* EnabRandUpdTrig = 1 */
-	__phy_write(phydev, 0x11, 0x2f00);
-	__phy_write(phydev, 0x12, 0xe);
-	__phy_write(phydev, 0x10, 0x8fb0);
-
-	/* NormMseLoThresh = 85 */
-	__phy_write(phydev, 0x11, 0x55a0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x83aa);
-
-	/* FfeUpdGainForce = 1(Enable), FfeUpdGainForceVal = 4 */
-	__phy_write(phydev, 0x11, 0x240);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9680);
-
-	/* TrFreeze = 0 (mt7988 default) */
-	__phy_write(phydev, 0x11, 0x0);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9686);
-
-	/* SSTrKp100 = 5 */
-	/* SSTrKf100 = 6 */
-	/* SSTrKp1000Mas = 5 */
-	/* SSTrKf1000Mas = 6 */
-	/* SSTrKp1000Slv = 5 */
-	/* SSTrKf1000Slv = 6 */
-	__phy_write(phydev, 0x11, 0xbaef);
-	__phy_write(phydev, 0x12, 0x2e);
-	__phy_write(phydev, 0x10, 0x968c);
+	__tr_modify(phydev, 0x1, 0xf, 0x17,
+		    SLAVE_DSP_READY_TIME_MASK | MASTER_DSP_READY_TIME_MASK,
+		    FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x18) |
+		    FIELD_PREP(MASTER_DSP_READY_TIME_MASK, 0x18));
+
+	__tr_set_bits(phydev, 0x1, 0xf, 0x18, ENABLE_RANDOM_UPDOWN_COUNTER_TRIGGER);
+
+	__tr_modify(phydev, 0x0, 0x7, 0x15,
+		    NORMAL_MSE_LO_THRESH_MASK,
+		    FIELD_PREP(NORMAL_MSE_LO_THRESH_MASK, 0x55));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x0,
+		    FFE_UPDATE_GAIN_FORCE_VAL_MASK,
+		    FIELD_PREP(FFE_UPDATE_GAIN_FORCE_VAL_MASK, 0x4) | FFE_UPDATE_GAIN_FORCE);
+
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x3, TR_FREEZE_MASK);
+
+	__tr_modify(phydev, 0x2, 0xd, 0x6,
+		    SS_TR_KP100_MASK | SS_TR_KF100_MASK |
+		    SS_TR_KP1000_MASTER_MASK | SS_TR_KF1000_MASTER_MASK |
+		    SS_TR_KP1000_SLAVE_MASK | SS_TR_KF1000_SLAVE_MASK,
+		    FIELD_PREP(SS_TR_KP100_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF100_MASK, 0x6) |
+		    FIELD_PREP(SS_TR_KP1000_MASTER_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF1000_MASTER_MASK, 0x6) |
+		    FIELD_PREP(SS_TR_KP1000_SLAVE_MASK, 0x5) |
+		    FIELD_PREP(SS_TR_KF1000_SLAVE_MASK, 0x6));
+
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 }
 
@@ -761,27 +798,27 @@ static void mt7981_phy_finetune(struct phy_device *phydev)
 	}
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 6 */
-	__phy_write(phydev, 0x11, 0x600);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__tr_modify(phydev, 0x1, 0xf, 0x20,
+		    RESET_SYNC_OFFSET_MASK, FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x6));
 
-	/* VgaDecRate = 1 */
-	__phy_write(phydev, 0x11, 0x4c2a);
-	__phy_write(phydev, 0x12, 0x3e);
-	__phy_write(phydev, 0x10, 0x8fa4);
+	__tr_modify(phydev, 0x1, 0xf, 0x12,
+		    VGA_DECIMATION_RATE_MASK, FIELD_PREP(VGA_DECIMATION_RATE_MASK, 0x1));
 
 	/* MrvlTrFix100Kp = 3, MrvlTrFix100Kf = 2,
 	 * MrvlTrFix1000Kp = 3, MrvlTrFix1000Kf = 2
 	 */
-	__phy_write(phydev, 0x11, 0xd10a);
-	__phy_write(phydev, 0x12, 0x34);
-	__phy_write(phydev, 0x10, 0x8f82);
+	__tr_modify(phydev, 0x1, 0xf, 0x1,
+		    MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+		    MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+		    FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x3) |
+		    FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x2) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x3) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x2));
 
 	/* VcoSlicerThreshBitsHigh */
-	__phy_write(phydev, 0x11, 0x5555);
-	__phy_write(phydev, 0x12, 0x55);
-	__phy_write(phydev, 0x10, 0x8ec0);
+	__tr_modify(phydev, 0x1, 0xd, 0x20,
+		    VCO_SLICER_THRESH_HIGH_MASK,
+		    FIELD_PREP(VCO_SLICER_THRESH_HIGH_MASK, 0x555555));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 9 */
@@ -832,25 +869,22 @@ static void mt7988_phy_finetune(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_TX_FILTER, 0x5);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* ResetSyncOffset = 5 */
-	__phy_write(phydev, 0x11, 0x500);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8fc0);
+	__tr_modify(phydev, 0x1, 0xf, 0x20,
+		    RESET_SYNC_OFFSET_MASK, FIELD_PREP(RESET_SYNC_OFFSET_MASK, 0x5));
 
 	/* VgaDecRate is 1 at default on mt7988 */
 
-	/* MrvlTrFix100Kp = 6, MrvlTrFix100Kf = 7,
-	 * MrvlTrFix1000Kp = 6, MrvlTrFix1000Kf = 7
-	 */
-	__phy_write(phydev, 0x11, 0xb90a);
-	__phy_write(phydev, 0x12, 0x6f);
-	__phy_write(phydev, 0x10, 0x8f82);
-
-	/* RemAckCntLimitCtrl = 1 */
-	__phy_write(phydev, 0x11, 0xfbba);
-	__phy_write(phydev, 0x12, 0xc3);
-	__phy_write(phydev, 0x10, 0x87f8);
-
+	__tr_modify(phydev, 0x1, 0xf, 0x1,
+		    MRVL_TR_FIX_100KP_MASK | MRVL_TR_FIX_100KF_MASK |
+		    MRVL_TR_FIX_1000KP_MASK | MRVL_TR_FIX_1000KF_MASK,
+		    FIELD_PREP(MRVL_TR_FIX_100KP_MASK, 0x6) |
+		    FIELD_PREP(MRVL_TR_FIX_100KF_MASK, 0x7) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KP_MASK, 0x6) |
+		    FIELD_PREP(MRVL_TR_FIX_1000KF_MASK, 0x7));
+
+	__tr_modify(phydev, 0x0, 0xf, 0x3c,
+		    REMOTE_ACK_COUNT_LIMIT_CTRL_MASK,
+		    FIELD_PREP(REMOTE_ACK_COUNT_LIMIT_CTRL_MASK, 0x1));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	/* TR_OPEN_LOOP_EN = 1, lpf_x_average = 10 */
@@ -925,45 +959,34 @@ static void mt798x_phy_eee(struct phy_device *phydev)
 			 MTK_PHY_TR_READY_SKIP_AFE_WAKEUP);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	/* Regsigdet_sel_1000 = 0 */
-	__phy_write(phydev, 0x11, 0xb);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x9690);
-
-	/* REG_EEE_st2TrKf1000 = 2 */
-	__phy_write(phydev, 0x11, 0x114f);
-	__phy_write(phydev, 0x12, 0x2);
-	__phy_write(phydev, 0x10, 0x969a);
-
-	/* RegEEE_slv_wake_tr_timer_tar = 6, RegEEE_slv_remtx_timer_tar = 20 */
-	__phy_write(phydev, 0x11, 0x3028);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x969e);
-
-	/* RegEEE_slv_wake_int_timer_tar = 8 */
-	__phy_write(phydev, 0x11, 0x5010);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a0);
-
-	/* RegEEE_trfreeze_timer2 = 586 */
-	__phy_write(phydev, 0x11, 0x24a);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96a8);
-
-	/* RegEEE100Stg1_tar = 16 */
-	__phy_write(phydev, 0x11, 0x3210);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96b8);
-
-	/* REGEEE_wake_slv_tr_wait_dfesigdet_en = 0 */
-	__phy_write(phydev, 0x11, 0x1463);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x96ca);
-
-	/* DfeTailEnableVgaThresh1000 = 27 */
-	__phy_write(phydev, 0x11, 0x36);
-	__phy_write(phydev, 0x12, 0x0);
-	__phy_write(phydev, 0x10, 0x8f80);
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x8, EEE1000_SELECT_SIGNEL_DETECTION_FROM_DFE);
+
+	__tr_modify(phydev, 0x2, 0xd, 0xd,
+		    EEE1000_STAGE2_TR_KF_MASK,
+		    FIELD_PREP(EEE1000_STAGE2_TR_KF_MASK, 0x2));
+
+	__tr_modify(phydev, 0x2, 0xd, 0xf,
+		    SLAVE_WAKETR_TIMER_MASK | SLAVE_REMTX_TIMER_MASK,
+		    FIELD_PREP(SLAVE_WAKETR_TIMER_MASK, 0x6) |
+		    FIELD_PREP(SLAVE_REMTX_TIMER_MASK, 0x14));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x10,
+		    SLAVE_WAKEINT_TIMER_MASK,
+		    FIELD_PREP(SLAVE_WAKEINT_TIMER_MASK, 0x8));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x14,
+		    TR_FREEZE_TIMER2_MASK,
+		    FIELD_PREP(TR_FREEZE_TIMER2_MASK, 0x24a));
+
+	__tr_modify(phydev, 0x2, 0xd, 0x1c,
+		    EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK,
+		    FIELD_PREP(EEE100_LPSYNC_STAGE1_UPDATE_TIMER_MASK, 0x10));
+
+	__tr_clr_bits(phydev, 0x2, 0xd, 0x25, WAKE_SLAVE_TR_WAIT_DFE_DETECTION_EN);
+
+	__tr_modify(phydev, 0x1, 0xf, 0x0,
+		    DFE_TAIL_EANBLE_VGA_TRHESH_1000,
+		    FIELD_PREP(DFE_TAIL_EANBLE_VGA_TRHESH_1000, 0x1b));
 	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
 
 	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_3);
@@ -1121,49 +1144,52 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
 	return mt798x_phy_calibration(phydev);
 }
 
-static int mt798x_phy_hw_led_on_set(struct phy_device *phydev, u8 index,
-				    bool on)
+static int mtk_phy_cl22_read_status(struct phy_device *phydev)
 {
-	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
-	bool changed;
+	int err, old_link = phydev->link;
 
-	if (on)
-		changed = !test_and_set_bit(bit_on, &priv->led_state);
-	else
-		changed = !!test_and_clear_bit(bit_on, &priv->led_state);
-
-	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
-					(index ? 16 : 0), &priv->led_state);
-	if (changed)
-		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
-				      MTK_PHY_LED_ON_MASK,
-				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
-	else
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
 		return 0;
-}
 
-static int mt798x_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
-				       bool blinking)
-{
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
-	struct mtk_socphy_priv *priv = phydev->priv;
-	bool changed;
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
 
-	if (blinking)
-		changed = !test_and_set_bit(bit_blink, &priv->led_state);
-	else
-		changed = !!test_and_clear_bit(bit_blink, &priv->led_state);
-
-	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV +
-			      (index ? 16 : 0), &priv->led_state);
-	if (changed)
-		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
-				     MTK_PHY_LED1_BLINK_CTRL : MTK_PHY_LED0_BLINK_CTRL,
-				     blinking ? MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
-	else
-		return 0;
+	if (phydev->is_gigabit_capable) {
+		err = genphy_read_master_slave(phydev);
+		if (err < 0)
+			return err;
+		}
+
+	err = genphy_read_lpa(phydev);
+	if (err < 0)
+		return err;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		if (phydev->autoneg_complete) {
+			phy_resolve_aneg_linkmode(phydev);
+		} else if (!linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					      phydev->advertising) &&
+			   linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					     phydev->advertising)) {
+			extend_an_new_lp_cnt_limit(phydev);
+		}
+	} else if (phydev->autoneg == AUTONEG_DISABLE) {
+		err = genphy_read_status_fixed(phydev);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
 }
 
 static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
@@ -1172,6 +1198,7 @@ static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 {
 	bool blinking = false;
 	int err = 0;
+	struct mtk_socphy_priv *priv = phydev->priv;
 
 	if (index > 1)
 		return -EINVAL;
@@ -1182,23 +1209,24 @@ static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
 		*delay_off = 50;
 	}
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, blinking);
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, blinking);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, false);
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, false);
 }
 
 static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
 					 u8 index, enum led_brightness value)
 {
 	int err;
+	struct mtk_socphy_priv *priv = phydev->priv;
 
-	err = mt798x_phy_hw_led_blink_set(phydev, index, false);
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
 	if (err)
 		return err;
 
-	return mt798x_phy_hw_led_on_set(phydev, index, (value != LED_OFF));
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, (value != LED_OFF));
 }
 
 static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
@@ -1210,151 +1238,29 @@ static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX)
 						 BIT(TRIGGER_NETDEV_RX)          |
 						 BIT(TRIGGER_NETDEV_TX));
 
-static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
-					  unsigned long rules)
+static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules)
 {
-	if (index > 1)
-		return -EINVAL;
-
-	/* All combinations of the supported triggers are allowed */
-	if (rules & ~supported_triggers)
-		return -EOPNOTSUPP;
-
-	return 0;
-};
+	return mtk_phy_led_hw_is_supported(phydev, index, rules, supported_triggers);
+}
 
 static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
 					 unsigned long *rules)
 {
-	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
-	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
 	struct mtk_socphy_priv *priv = phydev->priv;
-	int on, blink;
-
-	if (index > 1)
-		return -EINVAL;
-
-	on = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-			  index ? MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL);
-
-	if (on < 0)
-		return -EIO;
-
-	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-			     index ? MTK_PHY_LED1_BLINK_CTRL :
-				     MTK_PHY_LED0_BLINK_CTRL);
-	if (blink < 0)
-		return -EIO;
-
-	if ((on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 |
-		   MTK_PHY_LED_ON_LINK10)) ||
-	    (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX |
-		      MTK_PHY_LED_BLINK_10RX | MTK_PHY_LED_BLINK_1000TX |
-		      MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX)))
-		set_bit(bit_netdev, &priv->led_state);
-	else
-		clear_bit(bit_netdev, &priv->led_state);
-
-	if (on & MTK_PHY_LED_ON_FORCE_ON)
-		set_bit(bit_on, &priv->led_state);
-	else
-		clear_bit(bit_on, &priv->led_state);
-
-	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
-		set_bit(bit_blink, &priv->led_state);
-	else
-		clear_bit(bit_blink, &priv->led_state);
-
-	if (!rules)
-		return 0;
 
-	if (on & (MTK_PHY_LED_ON_LINK1000 | MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK10))
-		*rules |= BIT(TRIGGER_NETDEV_LINK);
-
-	if (on & MTK_PHY_LED_ON_LINK10)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
-
-	if (on & MTK_PHY_LED_ON_LINK100)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
-
-	if (on & MTK_PHY_LED_ON_LINK1000)
-		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
-
-	if (on & MTK_PHY_LED_ON_FDX)
-		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
-
-	if (on & MTK_PHY_LED_ON_HDX)
-		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
-
-	if (blink & (MTK_PHY_LED_BLINK_1000RX | MTK_PHY_LED_BLINK_100RX | MTK_PHY_LED_BLINK_10RX))
-		*rules |= BIT(TRIGGER_NETDEV_RX);
-
-	if (blink & (MTK_PHY_LED_BLINK_1000TX | MTK_PHY_LED_BLINK_100TX | MTK_PHY_LED_BLINK_10TX))
-		*rules |= BIT(TRIGGER_NETDEV_TX);
-
-	return 0;
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 					 unsigned long rules)
 {
-	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
 	struct mtk_socphy_priv *priv = phydev->priv;
-	u16 on = 0, blink = 0;
-	int ret;
-
-	if (index > 1)
-		return -EINVAL;
-
-	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
-		on |= MTK_PHY_LED_ON_FDX;
-
-	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
-		on |= MTK_PHY_LED_ON_HDX;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK10;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK100;
-
-	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
-		on |= MTK_PHY_LED_ON_LINK1000;
-
-	if (rules & BIT(TRIGGER_NETDEV_RX)) {
-		blink |= MTK_PHY_LED_BLINK_10RX  |
-			 MTK_PHY_LED_BLINK_100RX |
-			 MTK_PHY_LED_BLINK_1000RX;
-	}
-
-	if (rules & BIT(TRIGGER_NETDEV_TX)) {
-		blink |= MTK_PHY_LED_BLINK_10TX  |
-			 MTK_PHY_LED_BLINK_100TX |
-			 MTK_PHY_LED_BLINK_1000TX;
-	}
-
-	if (blink || on)
-		set_bit(bit_netdev, &priv->led_state);
-	else
-		clear_bit(bit_netdev, &priv->led_state);
-
-	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-				MTK_PHY_LED1_ON_CTRL :
-				MTK_PHY_LED0_ON_CTRL,
-			     MTK_PHY_LED_ON_FDX     |
-			     MTK_PHY_LED_ON_HDX     |
-			     MTK_PHY_LED_ON_LINK10  |
-			     MTK_PHY_LED_ON_LINK100 |
-			     MTK_PHY_LED_ON_LINK1000,
-			     on);
-
-	if (ret)
-		return ret;
 
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
-				MTK_PHY_LED1_BLINK_CTRL :
-				MTK_PHY_LED0_BLINK_CTRL, blink);
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+					MTK_GPHY_LED_ON_SET,
+					MTK_GPHY_LED_RX_BLINK_SET, MTK_GPHY_LED_TX_BLINK_SET);
 };
 
 static bool mt7988_phy_led_get_polarity(struct phy_device *phydev, int led_num)
@@ -1498,6 +1404,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
 		.name		= "MediaTek MT7981 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_phy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7981_phy_probe,
@@ -1515,6 +1422,7 @@ static struct phy_driver mtk_socphy_driver[] = {
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988),
 		.name		= "MediaTek MT7988 PHY",
 		.config_init	= mt798x_phy_config_init,
+		.read_status	= mtk_phy_cl22_read_status,
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.probe		= mt7988_phy_probe,
diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 54ea64a37ab3..20b04cb806ad 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -3,41 +3,62 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 
-#define MTK_EXT_PAGE_ACCESS		0x1f
-#define MTK_PHY_PAGE_STANDARD		0x0000
-#define MTK_PHY_PAGE_EXTENDED		0x0001
-#define MTK_PHY_PAGE_EXTENDED_2		0x0002
-#define MTK_PHY_PAGE_EXTENDED_3		0x0003
-#define MTK_PHY_PAGE_EXTENDED_2A30	0x2a30
-#define MTK_PHY_PAGE_EXTENDED_52B5	0x52b5
-
-static int mtk_gephy_read_page(struct phy_device *phydev)
-{
-	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
-}
+#include "mtk.h"
 
-static int mtk_gephy_write_page(struct phy_device *phydev, int page)
-{
-	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
-}
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
+#define MTK_PHY_PAGE_EXTENDED_2			0x0002
+#define MTK_PHY_PAGE_EXTENDED_3			0x0003
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11	0x11
+
+#define MTK_PHY_PAGE_EXTENDED_2A30		0x2a30
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x1, node_addr = 0xf, data_addr = 0x17 */
+#define SLAVE_DSP_READY_TIME_MASK		GENMASK(22, 15)
+
+/* Registers on MDIO_MMD_VEND1 */
+#define MTK_PHY_GBE_MODE_TX_DELAY_SEL		0x13
+#define MTK_PHY_TEST_MODE_TX_DELAY_SEL		0x14
+#define   MTK_TX_DELAY_PAIR_B_MASK		GENMASK(10, 8)
+#define   MTK_TX_DELAY_PAIR_D_MASK		GENMASK(2, 0)
+
+#define MTK_PHY_MCC_CTRL_AND_TX_POWER_CTRL	0xa6
+#define   MTK_MCC_NEARECHO_OFFSET_MASK		GENMASK(15, 8)
+
+#define MTK_PHY_RXADC_CTRL_RG7			0xc6
+#define   MTK_PHY_DA_AD_BUF_BIAS_LP_MASK	GENMASK(9, 8)
+
+#define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG123	0x123
+#define   MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK	GENMASK(15, 8)
+#define   MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK	GENMASK(7, 0)
 
 static void mtk_gephy_config_init(struct phy_device *phydev)
 {
 	/* Enable HW auto downshift */
-	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED, 0x14, 0, BIT(4));
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1, MTK_PHY_AUX_CTRL_AND_STATUS,
+			 0, MTK_PHY_ENABLE_DOWNSHIFT);
 
 	/* Increase SlvDPSready time */
-	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
-	__phy_write(phydev, 0x10, 0xafae);
-	__phy_write(phydev, 0x12, 0x2f);
-	__phy_write(phydev, 0x10, 0x8fae);
-	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+	tr_modify(phydev, 0x1, 0xf, 0x17, SLAVE_DSP_READY_TIME_MASK,
+		  FIELD_PREP(SLAVE_DSP_READY_TIME_MASK, 0x5e));
 
 	/* Adjust 100_mse_threshold */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x123, 0xffff);
-
-	/* Disable mcc */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0xa6, 0x300);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+		       MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG123,
+		       MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK |
+		       MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK,
+		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_LO_THRESH100_MASK,
+				  0xff) |
+		       FIELD_PREP(MTK_PHY_LPI_NORM_MSE_HI_THRESH100_MASK,
+				  0xff));
+
+	/* If echo time is narrower than 0x3, it will be regarded as noise */
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_MCC_CTRL_AND_TX_POWER_CTRL,
+		       MTK_MCC_NEARECHO_OFFSET_MASK,
+		       FIELD_PREP(MTK_MCC_NEARECHO_OFFSET_MASK, 0x3));
 }
 
 static int mt7530_phy_config_init(struct phy_device *phydev)
@@ -45,7 +66,8 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
 	mtk_gephy_config_init(phydev);
 
 	/* Increase post_update_timer */
-	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3, 0x11, 0x4b);
+	phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_3,
+			MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11, 0x4b);
 
 	return 0;
 }
@@ -56,11 +78,67 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
 
 	/* PHY link down power saving enable */
 	phy_set_bits(phydev, 0x17, BIT(4));
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, 0xc6, 0x300);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RXADC_CTRL_RG7,
+		       MTK_PHY_DA_AD_BUF_BIAS_LP_MASK,
+		       FIELD_PREP(MTK_PHY_DA_AD_BUF_BIAS_LP_MASK, 0x3));
 
 	/* Set TX Pair delay selection */
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x13, 0x404);
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x14, 0x404);
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_GBE_MODE_TX_DELAY_SEL,
+		       MTK_TX_DELAY_PAIR_B_MASK | MTK_TX_DELAY_PAIR_D_MASK,
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_B_MASK, 0x4) |
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_D_MASK, 0x4));
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_TEST_MODE_TX_DELAY_SEL,
+		       MTK_TX_DELAY_PAIR_B_MASK | MTK_TX_DELAY_PAIR_D_MASK,
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_B_MASK, 0x4) |
+		       FIELD_PREP(MTK_TX_DELAY_PAIR_D_MASK, 0x4));
+
+	return 0;
+}
+
+static int mtk_phy_cl22_read_status(struct phy_device *phydev)
+{
+	int err, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = genphy_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->is_gigabit_capable) {
+		err = genphy_read_master_slave(phydev);
+		if (err < 0)
+			return err;
+		}
+
+	err = genphy_read_lpa(phydev);
+	if (err < 0)
+		return err;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		if (phydev->autoneg_complete) {
+			phy_resolve_aneg_linkmode(phydev);
+		} else if (!linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					      phydev->advertising) &&
+			   linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					     phydev->advertising)) {
+			extend_an_new_lp_cnt_limit(phydev);
+		}
+	} else if (phydev->autoneg == AUTONEG_DISABLE) {
+		err = genphy_read_status_fixed(phydev);
+		if (err < 0)
+			return err;
+	}
 
 	return 0;
 }
@@ -70,6 +148,7 @@ static struct phy_driver mtk_gephy_driver[] = {
 		PHY_ID_MATCH_EXACT(0x03a29412),
 		.name		= "MediaTek MT7530 PHY",
 		.config_init	= mt7530_phy_config_init,
+		.read_status	= mtk_phy_cl22_read_status,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
@@ -77,13 +156,14 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_gephy_read_page,
-		.write_page	= mtk_gephy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
 	},
 	{
 		PHY_ID_MATCH_EXACT(0x03a29441),
 		.name		= "MediaTek MT7531 PHY",
 		.config_init	= mt7531_phy_config_init,
+		.read_status	= mtk_phy_cl22_read_status,
 		/* Interrupts are handled by the switch, not the PHY
 		 * itself.
 		 */
@@ -91,8 +171,8 @@ static struct phy_driver mtk_gephy_driver[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_page	= mtk_gephy_read_page,
-		.write_page	= mtk_gephy_write_page,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
 	},
 };
 
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
new file mode 100644
index 000000000000..d3052b4464d3
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include <linux/netdevice.h>
+
+#include "mtk.h"
+
+static void tr_access(struct phy_device *phydev, bool read, u8 ch_addr, u8 node_addr, u8 data_addr)
+{
+	u16 tr_cmd = BIT(15); /* bit 14 & 0 are reserved */
+
+	if (read)
+		tr_cmd |= BIT(13);
+
+	tr_cmd |= (((ch_addr & 0x3) << 11) |
+		   ((node_addr & 0xf) << 7) |
+		   ((data_addr & 0x3f) << 1));
+	dev_dbg(&phydev->mdio.dev, "tr_cmd: 0x%x\n", tr_cmd);
+	__phy_write(phydev, 0x10, tr_cmd);
+}
+
+static void __tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+		      u16 *tr_high, u16 *tr_low)
+{
+	tr_access(phydev, true, ch_addr, node_addr, data_addr);
+	*tr_low = __phy_read(phydev, 0x11);
+	*tr_high = __phy_read(phydev, 0x12);
+	dev_dbg(&phydev->mdio.dev, "tr_high read: 0x%x, tr_low read: 0x%x\n",
+		*tr_high, *tr_low);
+}
+
+static void tr_read(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+		    u16 *tr_high, u16 *tr_low)
+{
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__tr_read(phydev, ch_addr, node_addr, data_addr, tr_high, tr_low);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+
+static void __tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+		       u32 tr_data)
+{
+	__phy_write(phydev, 0x11, tr_data & 0xffff);
+	__phy_write(phydev, 0x12, tr_data >> 16);
+	dev_dbg(&phydev->mdio.dev, "tr_high write: 0x%x, tr_low write: 0x%x\n",
+		tr_data >> 16, tr_data & 0xffff);
+	tr_access(phydev, false, ch_addr, node_addr, data_addr);
+}
+
+static void tr_write(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 tr_data)
+{
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+
+void __tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+		 u32 mask, u32 set)
+{
+	u32 tr_data;
+	u16 tr_high;
+	u16 tr_low;
+
+	__tr_read(phydev, ch_addr, node_addr, data_addr, &tr_high, &tr_low);
+	tr_data = (tr_high << 16) | tr_low;
+	tr_data = (tr_data & ~mask) | set;
+	__tr_write(phydev, ch_addr, node_addr, data_addr, tr_data);
+}
+EXPORT_SYMBOL_GPL(__tr_modify);
+
+void tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+	       u32 mask, u32 set)
+{
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, mask, set);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+}
+EXPORT_SYMBOL_GPL(tr_modify);
+
+void __tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 set)
+{
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, 0, set);
+}
+EXPORT_SYMBOL_GPL(__tr_set_bits);
+
+void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 clr)
+{
+	__tr_modify(phydev, ch_addr, node_addr, data_addr, clr, 0);
+}
+EXPORT_SYMBOL_GPL(__tr_clr_bits);
+
+int mtk_phy_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MTK_EXT_PAGE_ACCESS);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_read_page);
+
+int mtk_phy_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MTK_EXT_PAGE_ACCESS, page);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_write_page);
+
+void extend_an_new_lp_cnt_limit(struct phy_device *phydev)
+{
+	int mmd_read_ret;
+	int ret;
+	u32 reg_val;
+
+	ret = read_poll_timeout(mmd_read_ret = phy_read_mmd, reg_val,
+				(mmd_read_ret < 0) || reg_val & MTK_PHY_FINAL_SPEED_1000,
+				10000, 1000000, false, phydev,
+				MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
+	if (mmd_read_ret < 0)
+		ret = mmd_read_ret;
+	/* If final_speed_1000 is raised, try to extend timeout period
+	 * of auto downshift.
+	 */
+	if (!ret) {
+		tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
+			  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
+		msleep(2800);
+		tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
+			  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0x8));
+	}
+}
+EXPORT_SYMBOL_GPL(extend_an_new_lp_cnt_limit);
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
+				unsigned long supported_triggers)
+{
+	if (index > 1)
+		return -EINVAL;
+
+	/* All combinations of the supported triggers are allowed */
+	if (rules & ~supported_triggers)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_is_supported);
+
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index, unsigned long *rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	int on, blink;
+
+	if (index > 1)
+		return -EINVAL;
+
+	on = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			  index ? MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL);
+
+	if (on < 0)
+		return -EIO;
+
+	blink = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+			     index ? MTK_PHY_LED1_BLINK_CTRL :
+				     MTK_PHY_LED0_BLINK_CTRL);
+	if (blink < 0)
+		return -EIO;
+
+	if ((on & (on_set | MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX | MTK_PHY_LED_ON_LINKDOWN)) ||
+	    (blink & (rx_blink_set | tx_blink_set)))
+		set_bit(bit_netdev, led_state);
+	else
+		clear_bit(bit_netdev, led_state);
+
+	if (on & MTK_PHY_LED_ON_FORCE_ON)
+		set_bit(bit_on, led_state);
+	else
+		clear_bit(bit_on, led_state);
+
+	if (blink & MTK_PHY_LED_BLINK_FORCE_BLINK)
+		set_bit(bit_blink, led_state);
+	else
+		clear_bit(bit_blink, led_state);
+
+	if (!rules)
+		return 0;
+
+	if (on & on_set)
+		*rules |= BIT(TRIGGER_NETDEV_LINK);
+
+	if (on & MTK_PHY_LED_ON_LINK10)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
+
+	if (on & MTK_PHY_LED_ON_LINK100)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
+
+	if (on & MTK_PHY_LED_ON_LINK1000)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
+
+	if (on & MTK_PHY_LED_ON_LINK2500)
+		*rules |= BIT(TRIGGER_NETDEV_LINK_2500);
+
+	if (on & MTK_PHY_LED_ON_FDX)
+		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
+
+	if (on & MTK_PHY_LED_ON_HDX)
+		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
+
+	if (blink & rx_blink_set)
+		*rules |= BIT(TRIGGER_NETDEV_RX);
+
+	if (blink & tx_blink_set)
+		*rules |= BIT(TRIGGER_NETDEV_TX);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_ctrl_get);
+
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index, unsigned long rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set)
+{
+	unsigned int bit_netdev = MTK_PHY_LED_STATE_NETDEV + (index ? 16 : 0);
+	u16 on = 0, blink = 0;
+	int ret;
+
+	if (index > 1)
+		return -EINVAL;
+
+	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
+		on |= MTK_PHY_LED_ON_FDX;
+
+	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
+		on |= MTK_PHY_LED_ON_HDX;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK10;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK100;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK1000;
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK)))
+		on |= MTK_PHY_LED_ON_LINK2500;
+
+	if (rules & BIT(TRIGGER_NETDEV_RX)) {
+		blink |= (on & on_set) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000RX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ? MTK_PHY_LED_BLINK_2500RX : 0)) :
+			  rx_blink_set;
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_TX)) {
+		blink |= (on & on_set) ?
+			  (((on & MTK_PHY_LED_ON_LINK10) ? MTK_PHY_LED_BLINK_10TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK100) ? MTK_PHY_LED_BLINK_100TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK1000) ? MTK_PHY_LED_BLINK_1000TX : 0) |
+			   ((on & MTK_PHY_LED_ON_LINK2500) ? MTK_PHY_LED_BLINK_2500TX : 0)) :
+			  tx_blink_set;
+	}
+
+	if (blink || on)
+		set_bit(bit_netdev, led_state);
+	else
+		clear_bit(bit_netdev, led_state);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+			     MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			     MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX | on_set, on);
+
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
+			     MTK_PHY_LED1_BLINK_CTRL :
+			     MTK_PHY_LED0_BLINK_CTRL, blink);
+}
+EXPORT_SYMBOL_GPL(mtk_phy_led_hw_ctrl_set);
+
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index, unsigned long *led_state, bool on)
+{
+	unsigned int bit_on = MTK_PHY_LED_STATE_FORCE_ON + (index ? 16 : 0);
+	bool changed;
+
+	if (on)
+		changed = !test_and_set_bit(bit_on, led_state);
+	else
+		changed = !!test_and_clear_bit(bit_on, led_state);
+
+	changed |= !!test_and_clear_bit(MTK_PHY_LED_STATE_NETDEV +
+					(index ? 16 : 0), led_state);
+	if (changed)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+				      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+				      MTK_PHY_LED_ON_MASK,
+				      on ? MTK_PHY_LED_ON_FORCE_ON : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_on_set);
+
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			     bool blinking)
+{
+	unsigned int bit_blink = MTK_PHY_LED_STATE_FORCE_BLINK + (index ? 16 : 0);
+	bool changed;
+
+	if (blinking)
+		changed = !test_and_set_bit(bit_blink, led_state);
+	else
+		changed = !!test_and_clear_bit(bit_blink, led_state);
+
+	changed |= !!test_bit(MTK_PHY_LED_STATE_NETDEV +
+			      (index ? 16 : 0), led_state);
+	if (changed)
+		return phy_write_mmd(phydev, MDIO_MMD_VEND2, index ?
+				     MTK_PHY_LED1_BLINK_CTRL : MTK_PHY_LED0_BLINK_CTRL,
+				     blinking ? MTK_PHY_LED_BLINK_FORCE_BLINK : 0);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_phy_hw_led_blink_set);
+
+MODULE_DESCRIPTION("MediaTek Ethernet PHY driver common");
+MODULE_AUTHOR("Sky Huang <SkyLake.Huang@mediatek.com>");
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
new file mode 100644
index 000000000000..47e12913f644
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common definition for Mediatek Ethernet PHYs
+ * Author: SkyLake Huang <SkyLake.Huang@mediatek.com>
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef _MTK_EPHY_H_
+#define _MTK_EPHY_H_
+
+#define MTK_EXT_PAGE_ACCESS			0x1f
+#define MTK_PHY_PAGE_STANDARD			0x0000
+#define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AN_NEW_LP_CNT_LIMIT_MASK		GENMASK(23, 20)
+
+#define MTK_PHY_LINK_STATUS_MISC	(0xa2)
+#define   MTK_PHY_FINAL_SPEED_1000	BIT(3)
+
+/* Registers on MDIO_MMD_VEND2 */
+#define MTK_PHY_LED0_ON_CTRL			0x24
+#define MTK_PHY_LED1_ON_CTRL			0x26
+#define   MTK_PHY_LED_ON_MASK			GENMASK(6, 0)
+#define   MTK_PHY_LED_ON_LINK1000		BIT(0)
+#define   MTK_PHY_LED_ON_LINK100		BIT(1)
+#define   MTK_PHY_LED_ON_LINK10			BIT(2)
+#define   MTK_PHY_LED_ON_LINKDOWN		BIT(3)
+#define   MTK_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
+#define   MTK_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
+#define   MTK_PHY_LED_ON_FORCE_ON		BIT(6)
+#define   MTK_PHY_LED_ON_LINK2500		BIT(7)
+#define   MTK_PHY_LED_ON_POLARITY		BIT(14)
+#define   MTK_PHY_LED_ON_ENABLE			BIT(15)
+
+#define MTK_PHY_LED0_BLINK_CTRL			0x25
+#define MTK_PHY_LED1_BLINK_CTRL			0x27
+#define   MTK_PHY_LED_BLINK_1000TX		BIT(0)
+#define   MTK_PHY_LED_BLINK_1000RX		BIT(1)
+#define   MTK_PHY_LED_BLINK_100TX		BIT(2)
+#define   MTK_PHY_LED_BLINK_100RX		BIT(3)
+#define   MTK_PHY_LED_BLINK_10TX		BIT(4)
+#define   MTK_PHY_LED_BLINK_10RX		BIT(5)
+#define   MTK_PHY_LED_BLINK_COLLISION		BIT(6)
+#define   MTK_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
+#define   MTK_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
+#define   MTK_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
+#define   MTK_PHY_LED_BLINK_2500TX		BIT(10)
+#define   MTK_PHY_LED_BLINK_2500RX		BIT(11)
+
+#define MTK_GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK1000 | \
+						 MTK_PHY_LED_ON_LINK100 | \
+						 MTK_PHY_LED_ON_LINK10)
+#define MTK_GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+#define MTK_GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_1000RX | \
+						 MTK_PHY_LED_BLINK_100RX | \
+						 MTK_PHY_LED_BLINK_10RX)
+
+#define MTK_2P5GPHY_LED_ON_SET			(MTK_PHY_LED_ON_LINK2500 | \
+						 MTK_GPHY_LED_ON_SET)
+#define MTK_2P5GPHY_LED_RX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_RX_BLINK_SET)
+#define MTK_2P5GPHY_LED_TX_BLINK_SET		(MTK_PHY_LED_BLINK_2500RX | \
+						 MTK_GPHY_LED_TX_BLINK_SET)
+
+#define MTK_PHY_LED_STATE_FORCE_ON	0
+#define MTK_PHY_LED_STATE_FORCE_BLINK	1
+#define MTK_PHY_LED_STATE_NETDEV	2
+
+void tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+	       u32 mask, u32 set);
+void __tr_modify(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr,
+		 u32 mask, u32 set);
+void __tr_set_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 set);
+void __tr_clr_bits(struct phy_device *phydev, u8 ch_addr, u8 node_addr, u8 data_addr, u32 clr);
+
+int mtk_phy_read_page(struct phy_device *phydev);
+int mtk_phy_write_page(struct phy_device *phydev, int page);
+
+void extend_an_new_lp_cnt_limit(struct phy_device *phydev);
+
+int mtk_phy_led_hw_is_supported(struct phy_device *phydev, u8 index, unsigned long rules,
+				unsigned long supported_triggers);
+int mtk_phy_led_hw_ctrl_set(struct phy_device *phydev, u8 index, unsigned long rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_led_hw_ctrl_get(struct phy_device *phydev, u8 index, unsigned long *rules,
+			    unsigned long *led_state, u16 on_set,
+			    u16 rx_blink_set, u16 tx_blink_set);
+int mtk_phy_hw_led_on_set(struct phy_device *phydev, u8 index, unsigned long *led_state, bool on);
+int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index, unsigned long *led_state,
+			     bool blinking);
+
+#endif /* _MTK_EPHY_H_ */
-- 
2.18.0


