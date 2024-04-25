Return-Path: <linux-kernel+bounces-157938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3B8B18EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619381C22D21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738F200DE;
	Thu, 25 Apr 2024 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B12mTrh8"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A71803D;
	Thu, 25 Apr 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012439; cv=none; b=pKIQMLwNx1qxHL+NBNq6R2yWlYwT7B+tZJmY05DCEbROnSTC157v4vRHeJS5j7gNJUt964m2Bhi7ugbRtgnf6p7AUCoxU7KEKWDvXaOrLyae1Aqv1nTpbhkMPE8wYH6gYR4XOZ45Y9po+RJQ04I26FU5NI0gB6EvRaYGBvGhkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012439; c=relaxed/simple;
	bh=aXgyWuY2bT8vzuWu2Jrmfii9ZrI40QDQiQCB6biJSXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADJpT0O8ejJWBvS+5p7qpVJqnNcbFelYxYs5pTcIODke6D3i0aY55kHBLS71i6t5gHCPrjURuo440YBKBuSzyGa9Ba+p/GuloR57GhE0vAR5pvf4SZgtSK5Huyvy7lAoJWuTGSIh/mgkw2Cd/f1mzOihmIrob8TwgSdVTMRS1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B12mTrh8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41ddb73e02ac11ef935d6952f98a51a9-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TBuNGBLJHHZF5JvmWltPINK654rP7UJw46u6iCJ6I8Q=;
	b=B12mTrh8l9kE04UgShcnPLlRcGJifxcy+sHPZVXZIIgAHA6LJPSF4FwzYQANR0NmI7GtfkBcVomKFf3yOC9UTyj9aw6d1ma5ZKRl4cG4xGZuulKvl5zcU8gYNJZM3b34UFR40EqKbpEOjJlEobWmKMbMRr0r8lUWQA5KAbw5nSE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fbf4d65b-20c8-4812-9a53-7da77da7e589,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-55
X-CID-META: VersionHash:82c5f88,CLOUDID:167dfc91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 41ddb73e02ac11ef935d6952f98a51a9-20240425
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 536200466; Thu, 25 Apr 2024 10:33:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 10:33:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 10:33:51 +0800
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
Subject: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G ethernet PHY on MT7988
Date: Thu, 25 Apr 2024 10:33:25 +0800
Message-ID: <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.136200-8.000000
X-TMASE-MatchedRID: 7uXyUrmVpJmGeTbGWdRz1m3NvezwBrVmvtVce6w5+K81LB46LFAAkpkC
	erFMaabiBRj5e39v/eEaFVw7sdMufxnu1nyuwPwz9UVHiwLx0/LnibXdwxr2R1c/CedjlcvkBpN
	qUzwLvvfC9TF0oEZxDPwSlgkyMvou28kC8Kr7AsmHZXNSWjgdU3UgtpyRoqmlaHYTYK/ridpLes
	J8gzIescF9H9ZT7pg4LqiiqnVG3ch81j9Wf8dpYlZ4U3MrW+XSpfVcx39Kq+4UtdRZTmEaITyO6
	MgDLhRAJ2SrnmtCCpTrQZMuglrXkaC1lU3nQJyvDko+EYiDQxETbU1KYGoQp7Owptim+So0Q5eG
	XYBbrxsyTl4QkezE+o8+OzhPfZwwYWmIaSiXIWjRfDQgu+j+5UvE+2pLwGbnDiRbsdWpbPZ51Gx
	Wl6MpnqjdDLMoi54b3/0OX7sbFJoBIYMQTz4EaWwbuvhCHs3ckclKpZaEedqbKItl61J/yZ+inT
	K0bC9eKrauXd3MZDWuikCL8VXXTPFHsE5XM3yM+Y8NxM1UNc8BFBdZPgT22pC512+fefwZSUt3T
	068WM8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.136200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: AF9BCCD08E26B8D2A13F230306A1827D2E536BC4EDBD294332BA9FB182D4EDC32000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Add support for internal 2.5Gphy on MT7988. This driver will load
necessary firmware, add appropriate time delay and figure out LED.
Also, certain control registers will be set to fix link-up issues.

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                          |   1 +
 drivers/net/phy/mediatek/Kconfig     |  11 +
 drivers/net/phy/mediatek/Makefile    |   1 +
 drivers/net/phy/mediatek/mtk-2p5ge.c | 399 +++++++++++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dbecd14572e..1232af36ee68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13908,6 +13908,7 @@ M:	Qingfang Deng <dqfext@gmail.com>
 M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	drivers/net/phy/mediatek/mtk-2p5ge.c
 F:	drivers/net/phy/mediatek/mtk-ge-soc.c
 F:	drivers/net/phy/mediatek/mtk-phy-lib.c
 F:	drivers/net/phy/mediatek/mtk-ge.c
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index c2aabed185a2..bd643a91e911 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -20,3 +20,14 @@ config MEDIATEK_GE_SOC_PHY
 	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
 	  present in the SoCs efuse and will dynamically calibrate VCM
 	  (common-mode voltage) during startup.
+
+config MEDIATEK_2P5GE_PHY
+	tristate "MediaTek 2.5Gb Ethernet PHYs"
+	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
+	select MTK_NET_PHYLIB
+	help
+	  Supports MediaTek SoC built-in 2.5Gb Ethernet PHYs.
+
+	  This will load necessary firmware and add appropriate time delay.
+	  Accelerate this procedure through internal pbus instead of MDIO
+	  bus. Certain link-up issues will also be fixed here.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 814879d0abe5..c6db8abd2c9c 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
+obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
new file mode 100644
index 000000000000..3826d0a1241c
--- /dev/null
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/phy.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "mtk.h"
+
+#define MT7988_2P5GE_PMB "mediatek/mt7988/i2p5ge-phy-pmb.bin"
+
+#define MD32_EN			BIT(0)
+#define PMEM_PRIORITY		BIT(8)
+#define DMEM_PRIORITY		BIT(16)
+
+#define BASE100T_STATUS_EXTEND		(0x10)
+#define BASE1000T_STATUS_EXTEND		(0x11)
+#define EXTEND_CTRL_AND_STATUS		(0x16)
+
+#define PHY_AUX_CTRL_STATUS		(0x1d)
+#define   PHY_AUX_DPX_MASK		GENMASK(5, 5)
+#define   PHY_AUX_SPEED_MASK		GENMASK(4, 2)
+
+/* MTK_PHY_LINK_STATUS_MISC's fields */
+#define   MTK_PHY_FDX_ENABLE		BIT(5)
+
+#define MTK_PHY_LPI_PCS_DSP_CTRL		(0x121)
+#define   MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK	GENMASK(12, 8)
+
+/* Registers on MTK phy page 1*/
+#define MTK_PHY_PAGE_EXTENDED_1			0x0001
+#define MTK_PHY_AUX_CTRL_AND_STATUS		(0x14)
+#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
+
+/* Registers on Token Ring debug nodes */
+/* ch_addr = 0x0, node_addr = 0xf, data_addr = 0x3c */
+#define AUTO_NP_10XEN				BIT(6)
+
+struct mtk_i2p5ge_phy_priv {
+	bool fw_loaded;
+	unsigned long led_state;
+};
+
+enum {
+	PHY_AUX_SPD_10 = 0,
+	PHY_AUX_SPD_100,
+	PHY_AUX_SPD_1000,
+	PHY_AUX_SPD_2500,
+};
+
+static int mt7988_2p5ge_phy_config_init(struct phy_device *phydev)
+{
+	int ret, i;
+	const struct firmware *fw;
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *np;
+	void __iomem *pmb_addr;
+	void __iomem *md32_en_cfg_base;
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+	u16 reg;
+	struct pinctrl *pinctrl;
+
+	if (!priv->fw_loaded) {
+		np = of_find_compatible_node(NULL, NULL, "mediatek,2p5gphy-fw");
+		if (!np)
+			return -ENOENT;
+		pmb_addr = of_iomap(np, 0);
+		if (!pmb_addr)
+			return -ENOMEM;
+		md32_en_cfg_base = of_iomap(np, 1);
+		if (!md32_en_cfg_base)
+			return -ENOMEM;
+
+		ret = request_firmware(&fw, MT7988_2P5GE_PMB, dev);
+		if (ret) {
+			dev_err(dev, "failed to load firmware: %s, ret: %d\n",
+				MT7988_2P5GE_PMB, ret);
+			return ret;
+		}
+
+		reg = readw(md32_en_cfg_base);
+		if (reg & MD32_EN) {
+			phy_set_bits(phydev, 0, BIT(15));
+			usleep_range(10000, 11000);
+		}
+		phy_set_bits(phydev, 0, BIT(11));
+
+		/* Write magic number to safely stall MCU */
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800e, 0x1100);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x800f, 0x00df);
+
+		for (i = 0; i < fw->size - 1; i += 4)
+			writel(*((uint32_t *)(fw->data + i)), pmb_addr + i);
+		release_firmware(fw);
+
+		writew(reg & ~MD32_EN, md32_en_cfg_base);
+		writew(reg | MD32_EN, md32_en_cfg_base);
+		phy_set_bits(phydev, 0, BIT(15));
+		/* We need a delay here to stabilize initialization of MCU */
+		usleep_range(7000, 8000);
+		dev_info(dev, "Firmware loading/trigger ok.\n");
+
+		priv->fw_loaded = true;
+	}
+
+	/* Setup LED */
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED0_ON_CTRL,
+			 MTK_PHY_LED_ON_POLARITY | MTK_PHY_LED_ON_LINK10 |
+			 MTK_PHY_LED_ON_LINK100 | MTK_PHY_LED_ON_LINK1000 |
+			 MTK_PHY_LED_ON_LINK2500);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED1_ON_CTRL,
+			 MTK_PHY_LED_ON_FDX | MTK_PHY_LED_ON_HDX);
+
+	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "i2p5gbe-led");
+	if (IS_ERR(pinctrl)) {
+		dev_err(&phydev->mdio.dev, "Fail to set LED pins!\n");
+		return PTR_ERR(pinctrl);
+	}
+
+	phy_modify_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LPI_PCS_DSP_CTRL,
+		       MTK_PHY_LPI_SIG_EN_LO_THRESH100_MASK, 0);
+
+	/* Enable 16-bit next page exchange bit if 1000-BT isn't advertizing */
+	tr_modify(phydev, 0x0, 0xf, 0x3c, AUTO_NP_10XEN,
+		  FIELD_PREP(AUTO_NP_10XEN, 0x1));
+
+	/* Enable HW auto downshift */
+	phy_modify_paged(phydev, MTK_PHY_PAGE_EXTENDED_1, MTK_PHY_AUX_CTRL_AND_STATUS,
+			 0, MTK_PHY_ENABLE_DOWNSHIFT);
+
+	return 0;
+}
+
+static int mt7988_2p5ge_phy_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	u32 adv;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		/* Configure half duplex with genphy_setup_forced,
+		 * because genphy_c45_pma_setup_forced does not support.
+		 */
+		return phydev->duplex != DUPLEX_FULL
+			? genphy_setup_forced(phydev)
+			: genphy_c45_pma_setup_forced(phydev);
+	}
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	ret = phy_modify_changed(phydev, MII_CTRL1000,
+				 ADVERTISE_1000FULL | ADVERTISE_1000HALF,
+				 adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+static int mt7988_2p5ge_phy_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* We don't support HDX at MAC layer on mt7988.
+	 * So mask phy's HDX capabilities, too.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int mt7988_2p5ge_phy_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		if (phydev->autoneg_complete) {
+			ret = genphy_c45_read_lpa(phydev);
+			if (ret < 0)
+				return ret;
+
+			/* Read the link partner's 1G advertisement */
+			ret = phy_read(phydev, MII_STAT1000);
+			if (ret < 0)
+				return ret;
+			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, ret);
+		} else if (!linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+					      phydev->advertising) &&
+			   linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					     phydev->advertising)) {
+			extend_an_new_lp_cnt_limit(phydev);
+		}
+	} else if (phydev->autoneg == AUTONEG_DISABLE) {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	ret = phy_read(phydev, PHY_AUX_CTRL_STATUS);
+	if (ret < 0)
+		return ret;
+
+	switch (FIELD_GET(PHY_AUX_SPEED_MASK, ret)) {
+	case PHY_AUX_SPD_10:
+		phydev->speed = SPEED_10;
+		break;
+	case PHY_AUX_SPD_100:
+		phydev->speed = SPEED_100;
+		break;
+	case PHY_AUX_SPD_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case PHY_AUX_SPD_2500:
+		phydev->speed = SPEED_2500;
+		break;
+	}
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
+	if (ret < 0)
+		return ret;
+	phydev->duplex = (ret & MTK_PHY_FDX_ENABLE) ? DUPLEX_FULL : DUPLEX_HALF;
+	/* FIXME: The current firmware always enables rate adaptation mode. */
+	phydev->rate_matching = RATE_MATCH_PAUSE;
+
+	return 0;
+}
+
+static int mt7988_2p5ge_phy_get_rate_matching(struct phy_device *phydev,
+					      phy_interface_t iface)
+{
+	if (iface == PHY_INTERFACE_MODE_XGMII)
+		return RATE_MATCH_PAUSE;
+	return RATE_MATCH_NONE;
+}
+
+static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+						 BIT(TRIGGER_NETDEV_LINK)        |
+						 BIT(TRIGGER_NETDEV_LINK_10)     |
+						 BIT(TRIGGER_NETDEV_LINK_100)    |
+						 BIT(TRIGGER_NETDEV_LINK_1000)   |
+						 BIT(TRIGGER_NETDEV_LINK_2500)   |
+						 BIT(TRIGGER_NETDEV_RX)          |
+						 BIT(TRIGGER_NETDEV_TX));
+
+static int mt798x_2p5ge_phy_led_blink_set(struct phy_device *phydev, u8 index,
+					  unsigned long *delay_on,
+					  unsigned long *delay_off)
+{
+	bool blinking = false;
+	int err = 0;
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	if (index > 1)
+		return -EINVAL;
+
+	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
+		blinking = true;
+		*delay_on = 50;
+		*delay_off = 50;
+	}
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, blinking);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, false);
+}
+
+static int mt798x_2p5ge_phy_led_brightness_set(struct phy_device *phydev,
+					       u8 index, enum led_brightness value)
+{
+	int err;
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, &priv->led_state, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, &priv->led_state, (value != LED_OFF));
+}
+
+static int mt798x_2p5ge_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+						unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules, supported_triggers);
+}
+
+static int mt798x_2p5ge_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+					       unsigned long *rules)
+{
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules, &priv->led_state,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
+static int mt798x_2p5ge_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+					       unsigned long rules)
+{
+	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
+
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules, &priv->led_state,
+				       MTK_2P5GPHY_LED_ON_SET,
+				       MTK_2P5GPHY_LED_RX_BLINK_SET,
+				       MTK_2P5GPHY_LED_TX_BLINK_SET);
+};
+
+static void mt798x_phy_leds_state_init(struct phy_device *phydev)
+{
+	int i;
+
+	for (i = 0; i < 2; ++i)
+		mt798x_2p5ge_phy_led_hw_control_get(phydev, i, NULL);
+}
+
+static int mt7988_2p5ge_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_i2p5ge_phy_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev,
+			    sizeof(struct mtk_i2p5ge_phy_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->fw_loaded = false;
+	phydev->priv = priv;
+
+	mt798x_phy_leds_state_init(phydev);
+
+	return 0;
+}
+
+static struct phy_driver mtk_gephy_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(0x00339c11),
+		.name		= "MediaTek MT798x 2.5GbE PHY",
+		.probe		= mt7988_2p5ge_phy_probe,
+		.config_init	= mt7988_2p5ge_phy_config_init,
+		.config_aneg    = mt7988_2p5ge_phy_config_aneg,
+		.get_features	= mt7988_2p5ge_phy_get_features,
+		.read_status	= mt7988_2p5ge_phy_read_status,
+		.get_rate_matching	= mt7988_2p5ge_phy_get_rate_matching,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+		.led_blink_set	= mt798x_2p5ge_phy_led_blink_set,
+		.led_brightness_set = mt798x_2p5ge_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_2p5ge_phy_led_hw_is_supported,
+		.led_hw_control_get = mt798x_2p5ge_phy_led_hw_control_get,
+		.led_hw_control_set = mt798x_2p5ge_phy_led_hw_control_set,
+	},
+};
+
+module_phy_driver(mtk_gephy_driver);
+
+static struct mdio_device_id __maybe_unused mtk_2p5ge_phy_tbl[] = {
+	{ PHY_ID_MATCH_VENDOR(0x00339c00) },
+	{ }
+};
+
+MODULE_DESCRIPTION("MediaTek 2.5Gb Ethernet PHY driver");
+MODULE_AUTHOR("SkyLake Huang <SkyLake.Huang@mediatek.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, mtk_2p5ge_phy_tbl);
-- 
2.18.0


