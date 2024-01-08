Return-Path: <linux-kernel+bounces-19288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2261826AE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375BF1F221BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F32209B;
	Mon,  8 Jan 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3nYco1P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8104125A6;
	Mon,  8 Jan 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55770379ed4so1346973a12.3;
        Mon, 08 Jan 2024 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704706735; x=1705311535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f922AAAvTUPPGAMjuD/HGIUip6YX4Zxif4jpCQOF54Q=;
        b=Z3nYco1PB8wrEretwoNbX5rl//Q5CNMuJqNYHNYyVKccZTq7DiCcfLcjL37pRmtHFg
         gsPsFmWUmzxMtYo/O+ej7Xsgjev8mPxt7p/P25CxriWgW2J+mwdRDbTGW5GVZZmONga5
         1XkD4j2haXVc8J8bxcMArVC2Na369noZpacCqZEgQYp36qEkxw0B/rfKqMnTg8RUvXui
         yi3pQE3c09t8jSb3vrmna6XniVhqDYmfMfsMwYBQPmcKoavhA+jYUbcea3WTeQUa/3Dz
         LWUQtv6AL8VUW+jS1TmLtFcCY6JqzxNmHILeqSSt/ki9/Zn0AaXN3kS2+Cms5hPFUlIu
         GgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706735; x=1705311535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f922AAAvTUPPGAMjuD/HGIUip6YX4Zxif4jpCQOF54Q=;
        b=eYa/6mMRWjwBKFEYz5IkoRLAKATUPmMlXvl/lpPWkDVWkmKyTU+XazNkHi/GVJ1OqU
         kxzUXISymfGFkZr7djDj6G/FUQ+NotvyA/VkX9sXRzhtBk5TeZAORtfBYVR7kWCusm14
         ny1OPttTnuolxteHazV0jBqX0K5FeXRich1NCLd4bSi0hM+KSnI2Cmvl1bccgj3WMNQh
         JbTxxU554OTYNaBJJHLC4VIv+hgpgIQEQCV5FHjGKKTfyXM5d54Es+qKkw6MhXMVDx2K
         NJ3Q6QxDxJesvki4Yng0Dz1C+2u2l5ukwtpxI2LNW/e7KY4bf2ERNK3MDlM0PPnQD0r8
         1kjQ==
X-Gm-Message-State: AOJu0Yyzuz8vFXctWTWYXP76WIIx5mVCfoSBIm8T0m4RIi1owvPPAtoq
	rzKwlMU7uOCG+yQ42kRSAnSmBFIhB90+EQ==
X-Google-Smtp-Source: AGHT+IH2J5bvyAlahRK3WFWSh7+fk+vNfS5rTlvUTI+eJr2X8J7ADz3qdASb7PiB6YGRPg2y62Yfyw==
X-Received: by 2002:a17:906:2685:b0:a28:b92e:c22a with SMTP id t5-20020a170906268500b00a28b92ec22amr1602842ejc.22.1704706735142;
        Mon, 08 Jan 2024 01:38:55 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b00a2ae71cee2asm326851eja.177.2024.01.08.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:38:54 -0800 (PST)
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
Subject: [PATCH v4 net-next 5/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
Date: Mon,  8 Jan 2024 10:37:00 +0100
Message-Id: <20240108093702.13476-6-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the Marvell 88Q2220. This driver allows to detect the
link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
master and slave mode. Autonegoation is supported.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 206 +++++++++++++++++++++++++++++-
 include/linux/marvell_phy.h       |   1 +
 2 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index dcebb4643aff..8a0dae82ab2d 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -6,6 +6,8 @@
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
 
+#define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
+
 #define MDIO_MMD_AN_MV_STAT			32769
 #define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
 #define MDIO_MMD_AN_MV_STAT_LOCAL_RX		0x1000
@@ -13,6 +15,11 @@
 #define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER	0x4000
 #define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
 
+#define MDIO_MMD_AN_MV_STAT2			32794
+#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED	0x0800
+#define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
+#define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
+
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
@@ -29,6 +36,42 @@
 
 #define MDIO_MMD_PCS_MV_RX_STAT			33328
 
+struct mmd_val {
+	int devad;
+	u32 regnum;
+	u16 val;
+};
+
+const struct mmd_val mv88q222x_revb0_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0x8033, 0x6801 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1,
+	  MDIO_CTRL1_LPOWER | MDIO_PMA_CTRL1_SPEED1000 },
+	{ MDIO_MMD_PCS, 0xfe1b, 0x48 },
+	{ MDIO_MMD_PCS, 0xffe4, 0x6b6 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0 },
+	{ MDIO_MMD_PCS, MDIO_CTRL1, 0x0 },
+};
+
+const struct mmd_val mv88q222x_revb0_init_seq1[] = {
+	{ MDIO_MMD_PCS, 0xfe79, 0x0 },
+	{ MDIO_MMD_PCS, 0xfe07, 0x125a },
+	{ MDIO_MMD_PCS, 0xfe09, 0x1288 },
+	{ MDIO_MMD_PCS, 0xfe08, 0x2588 },
+	{ MDIO_MMD_PCS, 0xfe11, 0x1105 },
+	{ MDIO_MMD_PCS, 0xfe72, 0x042c },
+	{ MDIO_MMD_PCS, 0xfbba, 0xcb2 },
+	{ MDIO_MMD_PCS, 0xfbbb, 0xc4a },
+	{ MDIO_MMD_AN, 0x8032, 0x2020 },
+	{ MDIO_MMD_AN, 0x8031, 0xa28 },
+	{ MDIO_MMD_AN, 0x8031, 0xc28 },
+	{ MDIO_MMD_PCS, 0xffdb, 0xfc10 },
+	{ MDIO_MMD_PCS, 0xfe1b, 0x58 },
+	{ MDIO_MMD_PCS, 0xfe79, 0x4 },
+	{ MDIO_MMD_PCS, 0xfe5f, 0xe8 },
+	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
+};
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -125,24 +168,90 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 
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
 
-	return ret;
+	return 0;
+}
+
+static int mv88q2xxx_read_aneg_speed(struct phy_device *phydev)
+{
+	int ret;
+
+	phydev->speed = SPEED_UNKNOWN;
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
+		ret = mv88q2xxx_read_master_slave_state(phydev);
+		if (ret < 0)
+			return ret;
+
+		phy_resolve_aneg_linkmode(phydev);
+
+		return 0;
+	}
+
 	ret = mv88q2xxx_read_link(phydev);
 	if (ret < 0)
 		return ret;
@@ -171,7 +280,9 @@ static int mv88q2xxx_get_features(struct phy_device *phydev)
 	 * sequence provided by Marvell. Disable it for now until a proper
 	 * workaround is found or a new PHY revision is released.
 	 */
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+	if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2110)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->supported);
 
 	return 0;
 }
@@ -241,6 +352,75 @@ static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
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
+
+	return 0;
+}
+
+static int mv88q222x_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	return mv88q222x_soft_reset(phydev);
+}
+
+static int mv88q222x_revb0_config_init(struct phy_device *phydev)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq0); i++) {
+		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq0[i].devad,
+				    mv88q222x_revb0_init_seq0[i].regnum,
+				    mv88q222x_revb0_init_seq0[i].val);
+		if (ret < 0)
+			return ret;
+	}
+
+	usleep_range(5000, 10000);
+
+	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq1); i++) {
+		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq1[i].devad,
+				    mv88q222x_revb0_init_seq1[i].regnum,
+				    mv88q222x_revb0_init_seq1[i].val);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* The 88Q2XXX PHYs do have the extended ability register available, but
+	 * register MDIO_PMA_EXTABLE where they should signalize it does not
+	 * work according to specification. Therefore, we force it here.
+	 */
+	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
+
+	return 0;
+}
+
 static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		.phy_id			= MARVELL_PHY_ID_88Q2110,
@@ -255,12 +435,26 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
+		.name			= "mv88q2220",
+		.get_features		= mv88q2xxx_get_features,
+		.config_aneg		= mv88q222x_config_aneg,
+		.aneg_done		= genphy_c45_aneg_done,
+		.config_init		= mv88q222x_revb0_config_init,
+		.read_status		= mv88q2xxx_read_status,
+		.soft_reset		= mv88q222x_soft_reset,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= mv88q2xxx_get_sqi,
+		.get_sqi_max		= mv88q2xxx_get_sqi_max,
+	},
 };
 
 module_phy_driver(mv88q2xxx_driver);
 
 static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
 	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0), },
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


