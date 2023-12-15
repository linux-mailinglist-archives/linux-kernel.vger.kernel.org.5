Return-Path: <linux-kernel+bounces-1671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280048151EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABD51F24E04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67060482ED;
	Fri, 15 Dec 2023 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIkzbnsD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE649F60;
	Fri, 15 Dec 2023 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33644eeb305so827763f8f.1;
        Fri, 15 Dec 2023 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702675907; x=1703280707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZjD23MAZYjTaCjw2rro+Uocvj47x9/KGA0GkTcjPyw=;
        b=RIkzbnsDrW+vA8c6RYH9gqZN6ygg1gal2i26TmWJDnyplicKLUQbtdlZA+jkwXhBcN
         pnZyuveCryopN6UnfMjiutrVIcadLfqQpwCD19qosHrPMzO/sQqw3je+FWW7i9eEhoh6
         mBH0vGBREpcBx3m+6iHav8co8bRQNKVLaY8MYsBFs906WQ29iv/s1bEYXfE39GlPqN4C
         sZsypQ62XBw9CE98IaHBnFBbbdlsfpEBsTFGvRdb+5ISps9u2fj0pfDMQRNSVdoqXzwr
         i1r+xRTHcmCp/NtYjNUG4Ah88g7t7m6deIFmQ8kJ6GuX8/8sYbCk30O1AInnzijWmJLL
         nTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675907; x=1703280707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZjD23MAZYjTaCjw2rro+Uocvj47x9/KGA0GkTcjPyw=;
        b=RMGPUfvzdTF90iFCRxUCcLzalh7mBv8DeWjpGpcDtHeEafgqTBAGW236zqOE/cq08L
         KTLYd4gnajACwcjL+TrdSAZZEAiH5ioM6wDA8fqsQmLzB0u5ea8/3shRvRy6ikzYWih8
         vx8AXRaocQsznp0vBj0n3ULRguGmiu3wz2+gjgLHLQDLpR/1epqDn2M/XRKaGVi/7r+f
         N9R8/bPWLKGnEGbgHQKAG8mtxG1C6vyvD68MVqKbyVoithjz5GEtBiIqyoo7+gvTBM89
         slWzPBt9mq9eigSI/Bj7uDZJico2rq7dXHDShDxm53bOVhnyAA8LmW3Vc+GC12k/hfHu
         9Ovw==
X-Gm-Message-State: AOJu0YxsfgtSOdAlPopN0uGUmUnsxiJctevpTgJpXpoxLDuq7ksl4bdm
	qlWEAcBXLYWAXLQzi+lAycY=
X-Google-Smtp-Source: AGHT+IHEtAgvqtvQ2FxypI/PKIlux0BqzMmVDe2auWvkAgSezlIKZuV5ceNvOZCU0i0LXJ+BXlcd3g==
X-Received: by 2002:a5d:53c7:0:b0:32d:87c8:b548 with SMTP id a7-20020a5d53c7000000b0032d87c8b548mr6332348wrw.21.1702675907073;
        Fri, 15 Dec 2023 13:31:47 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id d7-20020adfef87000000b00336598903e9sm1345384wro.58.2023.12.15.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 13:31:46 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Fri, 15 Dec 2023 22:31:00 +0100
Message-Id: <20231215213102.35994-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Marvell 88Q2220. This driver allows to detect the
link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
master and slave mode and autonegotiation.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 258 +++++++++++++++++++++++++++++-
 include/linux/marvell_phy.h       |   1 +
 2 files changed, 258 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..1b79f2ea5ed7 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -166,7 +166,9 @@ static int mv88q2xxx_get_features(struct phy_device *phydev)
 	 * sequence provided by Marvell. Disable it for now until a proper
 	 * workaround is found or a new PHY revision is released.
 	 */
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2110)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->supported);
 
 	return 0;
 }
@@ -192,6 +194,9 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2220)
+		return 0;
+
 	/* Read the current PHY configuration */
 	ret = genphy_c45_read_pma(phydev);
 	if (ret)
@@ -235,6 +240,242 @@ static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
 	return 15;
 }
 
+static int mv88q222x_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Enable RESET of DCL */
+	if (phydev->autoneg == AUTONEG_ENABLE || phydev->speed == SPEED_1000) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe1b, 0x48);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Soft reset */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_CTRL,
+			    MDIO_PCS_1000BT1_CTRL_RESET);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffe4, 0xc);
+	if (ret < 0)
+		return ret;
+
+	/* Disable RESET of DCL */
+	if (phydev->autoneg == AUTONEG_ENABLE || phydev->speed == SPEED_1000)
+		return phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe1b, 0x58);
+	else
+		return ret;
+}
+
+static int mv88q222x_config_aneg_gbit(struct phy_device *phydev)
+{
+	int ret;
+
+	/* send_s detection threshold, slave and master */
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
+	if (ret < 0)
+		return ret;
+
+	/* Disable DCL calibratin during tear down */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffdb, 0xfc10);
+	if (ret < 0)
+		return ret;
+
+	/* Disable RESET of DCL*/
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe1b, 0x58);
+	if (ret < 0)
+		return ret;
+
+	/* Turn CM Clamp ON */
+	return phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe79, 0x4);
+}
+
+static int mv88q222x_config_aneg_100m(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Update Initial FFE Coefficients */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfbba, 0xcb2);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfbbb, 0xc4a);
+	if (ret < 0)
+		return ret;
+
+	/* Turn CM Clamp ON */
+	return phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe79, 0x4);
+}
+
+static int mv88q222x_config_aneg_preinit(struct phy_device *phydev)
+{
+	int ret, val, i;
+
+	/* Enable txdac */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8033, 0x6801);
+	if (ret < 0)
+		return ret;
+
+	/* Disable ANEG */
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* Set IEEE power down */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);
+	if (ret < 0)
+		return ret;
+
+	/* Exit standby state(internal state) */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe1b, 0x48);
+	if (ret < 0)
+		return ret;
+
+	/* Set power management state breakpoint (internal state) */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffe4, 0x6b6);
+	if (ret < 0)
+		return ret;
+
+	/* Exit IEEE power down */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1, 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* Wait up to 5ms to enter to power management state, if we do not meet
+	 * the target value, it is still ok to proceed
+	 */
+	for (i = 0; i < 5; i++) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xffe4);
+		if (val == 0x6ba)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+
+	/* Turn CM Clamp OFF */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe79, 0x0);
+	if (ret < 0)
+		return ret;
+
+	/* mdi vcm */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe07, 0x125a);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe09, 0x1288);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe08, 0x2588);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe11, 0x1105);
+	if (ret < 0)
+		return ret;
+
+	/* aux_boost */
+	return phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe72, 0x042c);
+}
+
+static int mv88q222x_config_aneg_init_b0(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mv88q222x_config_aneg_preinit(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->speed == SPEED_100)
+			return mv88q222x_config_aneg_100m(phydev);
+		else
+			return mv88q222x_config_aneg_gbit(phydev);
+	}
+
+	ret = mv88q222x_config_aneg_100m(phydev);
+	if (ret)
+		return ret;
+
+	ret = mv88q222x_config_aneg_gbit(phydev);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe5f, 0xe8);
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_PCS, 0xfe05, 0x755c);
+}
+
+static int mv88q222x_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mv88q222x_config_aneg_init_b0(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	return mv88q222x_soft_reset(phydev);
+}
+
+static int mv88q222x_set_loopback(struct phy_device *phydev, bool enable)
+{
+	return phy_modify_mmd(phydev,
+			      MDIO_MMD_PCS,
+			      MDIO_PCS_1000BT1_CTRL,
+			      MDIO_PCS_CTRL1_LOOPBACK,
+			      enable ? MDIO_PCS_CTRL1_LOOPBACK : 0);
+}
+
+static int mv88q222x_get_sqi(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->speed == SPEED_100) {
+		/* Read the SQI from the vendor specific receiver status
+		 * register
+		 */
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & 0xe0000) >> 13;
+	} else {
+		/* Read the SQI from the vendor specific signal quality index
+		 * register
+		 */
+
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0xfcd8);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret & 0x0F;
+}
+
+static int mv88q222x_get_sqi_max(struct phy_device *phydev)
+{
+	return 7;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -249,12 +490,27 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi		= mv88q2xxxx_get_sqi,
 		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
 	},
+	{
+		.phy_id			= MARVELL_PHY_ID_88Q2220,
+		.phy_id_mask		= MARVELL_PHY_ID_MASK,
+		.name			= "mv88q2220",
+		.get_features		= mv88q2xxx_get_features,
+		.config_aneg		= mv88q222x_config_aneg,
+		.aneg_done		= genphy_c45_aneg_done,
+		.config_init		= mv88q2xxx_config_init,
+		.read_status		= mv88q2xxx_read_status,
+		.soft_reset		= mv88q222x_soft_reset,
+		.set_loopback		= mv88q222x_set_loopback,
+		.get_sqi		= mv88q222x_get_sqi,
+		.get_sqi_max		= mv88q222x_get_sqi_max,
+	},
 };
 
 module_phy_driver(mv88q2xxx_driver);
 
 static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
 	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88Q2220, MARVELL_PHY_ID_MASK },
 	{ /*sentinel*/ }
 };
 MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 9b54c4f0677f..693eba9869e4 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -26,6 +26,7 @@
 #define MARVELL_PHY_ID_88E2110		0x002b09b0
 #define MARVELL_PHY_ID_88X2222		0x01410f10
 #define MARVELL_PHY_ID_88Q2110		0x002b0980
+#define MARVELL_PHY_ID_88Q2220		0x002b0b20
 
 /* Marvel 88E1111 in Finisar SFP module with modified PHY ID */
 #define MARVELL_PHY_ID_88E1111_FINISAR	0x01ff0cc0
-- 
2.39.2


