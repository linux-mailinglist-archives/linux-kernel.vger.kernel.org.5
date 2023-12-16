Return-Path: <linux-kernel+bounces-2392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61491815C29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970CE284F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0236AFA;
	Sat, 16 Dec 2023 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akA/NKCC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FC1EB25;
	Sat, 16 Dec 2023 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c2718a768so18295805e9.0;
        Sat, 16 Dec 2023 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702766523; x=1703371323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8BYK0tdvp03rqvpYwHyne8418HR8ltTJ5G+4CRuTg4=;
        b=akA/NKCCePjeQeYNYK3Aanlc+/mY97KDRpG+Rjg+Au2ljLR3T1UGKgyJYYyGs5MfEa
         xGeK+bncADVCtl2HBbPTDtk1Xfux42L/GMzVrwn6LhGoRsyF9V7sPlAnkySk58UwGVPN
         P2yXykGFvy1RgKAW7DSZUkruzFUrZutbSvDtKo3t+HA2I7mIzxDFCTvHCWSvIeb0ai+T
         A9Cl1N6OsmqBtxS4qLk6wRHj2ap/8UB9CU7EHbvfKee7mAeWWw0GWAd0VjrYw3Y+eYQk
         LJKyL6PJvTdOQYuXSfnmGPGXBTFMd3RC82m+h4mf/cDhLW58xoFK3lqYj7s1+B7bJQAK
         TTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702766523; x=1703371323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8BYK0tdvp03rqvpYwHyne8418HR8ltTJ5G+4CRuTg4=;
        b=PBpIKy83mCQQKAS0T1vGqECM0xCBdZzQc66n3XqozsiKcb0R9f4ENV8vvbhCOumfYJ
         qSkUiaOXftkr1oHBoYEbarav5aEzss67/9FgZuIVwnRv6y8zNXfh4Z18nZ/xGYnAqyPA
         pLIkBIA1uXIVp12+UxOeIQhhNlI2rrduzCXqcLQAAM3MK+c/1ILGr3ZPnLdTp5o/ant3
         tyEl6dlRZSAvP6LUxE5RX4Xe9BrlhjF4XK9mA+E7nIL4ouewAmceuZKMJ4ccsVQyF4TD
         rL8w7GHIr2dI426qgJPbzVb2cAupUrJAcqjdGzc7rJnw929m2Ll4yYlCSrTZWxiL5mz0
         mwtg==
X-Gm-Message-State: AOJu0YwM9IhdJx8sYcViUDOXhc1/fSmodJs808taCvc4oseVE5vDMLZt
	C0c5FEHH8STfDfrwFs4ITHg=
X-Google-Smtp-Source: AGHT+IFKp9vTdEC5gT2k7yksy7Cz7reRwdIg0Wkj9+v+gwu81tExmbydouwrQ8iJZLQnwxCZH1PjXA==
X-Received: by 2002:a7b:ca4e:0:b0:40b:442a:f589 with SMTP id m14-20020a7bca4e000000b0040b442af589mr7946653wml.18.1702766522554;
        Sat, 16 Dec 2023 14:42:02 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm37478137wms.33.2023.12.16.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 14:42:02 -0800 (PST)
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
Subject: [PATCH v2] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Sat, 16 Dec 2023 23:41:31 +0100
Message-Id: <20231216224133.157658-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
References: <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
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
Changes in v2:
	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
	  in mv88q222x_config_aneg_preinit
	- use genphy_c45_loopback
	- mv88q2xxx_read_status reads speed, master or slave state when
	  autonegotiation is enabled
	- added defines for magic values in mv88q222x_get_sqi

 drivers/net/phy/marvell-88q2xxx.c | 290 +++++++++++++++++++++++++++++-
 include/linux/marvell_phy.h       |   1 +
 2 files changed, 289 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 1c3ff77de56b..722a62509247 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -27,6 +27,10 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_RX_STAT			33328
+
+#define MDIO_MMD_PCS_MV_SQI			64728
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -134,6 +138,22 @@ static int mv88q2xxx_read_link(struct phy_device *phydev)
 	return ret;
 }
 
+static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
+	if (ret < 0)
+		return ret;
+
+	if (ret & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
+		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+	else
+		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+
+	return 0;
+}
+
 static int mv88q2xxx_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -142,7 +162,25 @@ static int mv88q2xxx_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return genphy_c45_read_pma(phydev);
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = genphy_c45_baset1_read_status(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = mv88q2xxx_read_master_slave_state(phydev);
+		if (ret < 0)
+			return ret;
+
+		phy_resolve_aneg_linkmode(phydev);
+
+		return 0;
+	} else {
+		return genphy_c45_read_pma(phydev);
+	}
 }
 
 static int mv88q2xxx_get_features(struct phy_device *phydev)
@@ -166,7 +204,9 @@ static int mv88q2xxx_get_features(struct phy_device *phydev)
 	 * sequence provided by Marvell. Disable it for now until a proper
 	 * workaround is found or a new PHY revision is released.
 	 */
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2110)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->supported);
 
 	return 0;
 }
@@ -192,6 +232,9 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2220)
+		return 0;
+
 	/* Read the current PHY configuration */
 	ret = genphy_c45_read_pma(phydev);
 	if (ret)
@@ -235,6 +278,234 @@ static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
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
+static int mv88q222x_get_sqi(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->speed == SPEED_100) {
+		/* Read the SQI from the vendor specific receiver status
+		 * register
+		 */
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_RX_STAT);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & 0xe0000) >> 13;
+	} else {
+		/* Read the SQI from the vendor specific signal quality index
+		 * register
+		 */
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_SQI);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret & 0x0f;
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
@@ -249,12 +520,27 @@ static struct phy_driver mv88q2xxx_driver[] = {
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
+		.set_loopback		= genphy_c45_loopback,
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


