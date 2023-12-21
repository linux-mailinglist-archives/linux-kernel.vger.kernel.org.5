Return-Path: <linux-kernel+bounces-7937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DBE81AF74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D67D1F2741F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB7182BF;
	Thu, 21 Dec 2023 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI0noVOE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BA18043;
	Thu, 21 Dec 2023 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc6eecd319so4945691fa.1;
        Wed, 20 Dec 2023 23:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143767; x=1703748567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPdCSrZU/ppC+mMBGRL49lqPFHzTuO4Z9sjETscMlk4=;
        b=eI0noVOEJ4PjwkWzqxGTCrsSWCVgRMcA8Lm4LLDsQfV/Ot6rgvUmum0PquGr/QMtF8
         e18ltNEWngNzYLo7PCTz/McmW5R6sk/3Xfd6VyJu3GeACDSbvvUQ2HEG4M4bQe5jR+Xf
         EhP4F6mXzaCDQEaB1hiV8AYPDh8Wcs1sCDaexljbzMhr07yYIT8IX0r5ca61AdHIYcVO
         onZpX1GuiyCqxDCNUiC7KVsZwmxTFZeo2/ZgQExn1I728B/1ZNrpf1qEnqlKdP1EOOJK
         29FVOUKvnAOoCBhh6G58O8eN6vN/9WhkLKqQdyRzTxeUbesgWvY2qc2wqFVA/Dq0Mbvu
         0LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143767; x=1703748567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPdCSrZU/ppC+mMBGRL49lqPFHzTuO4Z9sjETscMlk4=;
        b=EC2D55oty3phnNKr784fGo4FH5fF23okYoum5eqWCuotwI3M43l314B0yM0js4XV7R
         eqhdyc8X9JuEQRG+kikInWtg7RHd4eVKp1MSftEcU1f1hDuoKTdf0EvrHSTphPKme24r
         CAcZG9twXfci85o/J+5mhSQz2l1+B1E0DTKfOjxbVST+dEv2baAlAckPfpCH8iUKLkcX
         Q/l3qNApNCmkldXCSIuq+tf8rj6PJBUMsM5UPddgDvlaP9x93rjMMUwXEXMk6GPEuU4E
         LGYlJPNZLo6F0LaofQksmKlQLlxeJngLTP1dA3z51XHhrRXRbiOKz80OzfZlsMkEYQCd
         Wwcw==
X-Gm-Message-State: AOJu0Yw36jAch+Yr1VfY7uMcZCW1NG45a2iV1k4HRCyk3dhrj4A4l3tA
	h73Glk12aj7Zxacuq7lt6UwYzjPSn3G82w==
X-Google-Smtp-Source: AGHT+IFMkCBhbH+bePn8Fz68KcxB5T/NMaWm2H8YzNHOFOoAZ7yDiyQzcVMePnpNAqLyT8dTNjkkKQ==
X-Received: by 2002:a2e:9c8e:0:b0:2cc:5cf4:c394 with SMTP id x14-20020a2e9c8e000000b002cc5cf4c394mr4828585lji.15.1703143766822;
        Wed, 20 Dec 2023 23:29:26 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm787819edb.64.2023.12.20.23.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:29:26 -0800 (PST)
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
Subject: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Thu, 21 Dec 2023 08:28:51 +0100
Message-Id: <20231221072853.107678-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221072853.107678-1-dima.fedrau@gmail.com>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
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
 drivers/net/phy/marvell-88q2xxx.c | 310 ++++++++++++++++++++++++++++--
 include/linux/marvell_phy.h       |   1 +
 2 files changed, 300 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..4e930b5ffaef 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -27,6 +27,13 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_RX_STAT			33328
+
+#define MDIO_MMD_AN_MV_STAT2			32794
+#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED	0x0800
+#define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
+#define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -120,24 +127,87 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 
 static int mv88q2xxx_read_link(struct phy_device *phydev)
 {
-	int ret;
-
 	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
 	 * therefore we need to read the link status from the vendor specific
 	 * registers depending on the speed.
 	 */
+
 	if (phydev->speed == SPEED_1000)
-		ret = mv88q2xxx_read_link_gbit(phydev);
+		return mv88q2xxx_read_link_gbit(phydev);
+	else if (phydev->speed == SPEED_100)
+		return mv88q2xxx_read_link_100m(phydev);
+
+	phydev->link = false;
+	return 0;
+}
+
+static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
+{
+	int ret;
+
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
+	if (ret < 0)
+		return ret;
+
+	if (ret & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
+		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
 	else
-		ret = mv88q2xxx_read_link_100m(phydev);
+		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+
+	return 0;
+}
+
+static int mv88q2xxx_read_aneg_speed(struct phy_device *phydev)
+{
+	int ret;
 
-	return ret;
+	phydev->speed = SPEED_UNKNOWN;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT2);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & MDIO_MMD_AN_MV_STAT2_AN_RESOLVED))
+		return 0;
+
+	if (ret & MDIO_MMD_AN_MV_STAT2_100BT1)
+		phydev->speed = SPEED_100;
+	else if (ret & MDIO_MMD_AN_MV_STAT2_1000BT1)
+		phydev->speed = SPEED_1000;
+
+	return 0;
 }
 
 static int mv88q2xxx_read_status(struct phy_device *phydev)
 {
 	int ret;
 
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		phydev->duplex = DUPLEX_FULL;
+
+		/* We have to get the negotiated speed first, otherwise we are
+		 * not able to read the link.
+		 */
+		ret = mv88q2xxx_read_aneg_speed(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = mv88q2xxx_read_link(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = genphy_c45_baset1_read_status(phydev);
+		if (ret < 0)
+			return ret;
+
+		return mv88q2xxx_read_master_slave_state(phydev);
+	}
+
 	ret = mv88q2xxx_read_link(phydev);
 	if (ret < 0)
 		return ret;
@@ -166,7 +236,9 @@ static int mv88q2xxx_get_features(struct phy_device *phydev)
 	 * sequence provided by Marvell. Disable it for now until a proper
 	 * workaround is found or a new PHY revision is released.
 	 */
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2110)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->supported);
 
 	return 0;
 }
@@ -192,6 +264,9 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2220)
+		return 0;
+
 	/* Read the current PHY configuration */
 	ret = genphy_c45_read_pma(phydev);
 	if (ret)
@@ -200,7 +275,7 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	return mv88q2xxx_config_aneg(phydev);
 }
 
-static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
 
@@ -208,7 +283,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 		/* Read the SQI from the vendor specific receiver status
 		 * register
 		 */
-		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_RX_STAT);
 		if (ret < 0)
 			return ret;
 
@@ -230,11 +306,208 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
 	return ret & 0x0F;
 }
 
-static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
+static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 {
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
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			    MDIO_CTRL1_LPOWER | MDIO_PMA_CTRL1_SPEED1000);
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
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -246,8 +519,22 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q2xxx_soft_reset,
 		.set_loopback		= genphy_c45_loopback,
-		.get_sqi		= mv88q2xxxx_get_sqi,
-		.get_sqi_max		= mv88q2xxxx_get_sqi_max,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
+	},
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
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 };
 
@@ -255,6 +542,7 @@ module_phy_driver(mv88q2xxx_driver);
 
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


