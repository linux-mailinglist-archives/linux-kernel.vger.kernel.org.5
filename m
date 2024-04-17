Return-Path: <linux-kernel+bounces-148651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E20D8A858E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3EB227AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0C1411E4;
	Wed, 17 Apr 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Pkx2beny";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="S01buFNi"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6592B140362;
	Wed, 17 Apr 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362817; cv=none; b=PLIWNlLP5z8TQ2BMKnqWnrPFSlhPt9ezWfx4d7pEgHglI13sfOHd9SJJLnA9mqPXinuPhiB9oMxi2TsnVLSh0kCTgHUTPUuJQMNaj2ULjUxC72yZMZxMf2qIrgFIQjISG/ZIk0Q5n0PZT8YOc4dQACMd0WsdFVaAJ5ex4tg0UXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362817; c=relaxed/simple;
	bh=SFiNG4cY/dX3dvcrmilR8fsoZpFknWqY7qi+e6nh3Ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FkiTUih/YkrSzabCDIszIi2QLTl3V5kbO83MQZTS+N1FaLbDgYuyfBWiiN0tSdPiKcV8dAeVY3o87sgVEPGUwv5BlQo1OVOlAq5i6l9e4Wpygtp8mjDKPw166BIXvojk5vnHGYImM9bvAInqe1IVID7bXSPqydfUig7GmwkRfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Pkx2beny; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=S01buFNi reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713362811; x=1744898811;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yWkcpTp88wg5m1XT41bvu3n1XmNWSmjEm97YjCMfVIM=;
  b=Pkx2benyyuN42V9oGEQ7VPBhNiuIMTEflnkXFh1C3B327bpCwBs2rjvE
   zkg4u9FYjzxlJriRMZm8vpvmewCtzf/q020j/SSPNxzgVzExkScl8IXrE
   V5Q1xLE8t9c2G3hIOto9Zxjm+U2AkAv7MoNJiW79laZjMsWzsmF1xSzjM
   Co3ZVIL/yL2tK2NgefMqworsYIK/YDtRV6L+Md5Y4cKvhLfHb8cjmS+R2
   p254Nnt8E4/kJr7+NHR3e29hHA+LkULJgVDoql4vUtq5k1E+7w4xbiVZ4
   IKmykFiu846DQeYamUKcw4ZkUtDPtGwNgsprsLRhBL8kQLH7Cfg1+Htep
   g==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36470638"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 16:06:47 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08F711724AC;
	Wed, 17 Apr 2024 16:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713362803;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yWkcpTp88wg5m1XT41bvu3n1XmNWSmjEm97YjCMfVIM=;
	b=S01buFNiIrsL6oC4B3pSvh0gK8OrKfO2xbP/jamMe6OBQ0EQb8XErCqMFlEDCp7aMCjuNe
	tTVzFVwhyxHzYeEr379ORKuLBnXFBZbxGDa044c7Y/d0risPbslH9vegGWzvp2crHjbJ9+
	RVKo5czidet3E1UyDpY1+1K81yQJ+uzwhexy9o4hhb5HShX8r9oIeE/EZ+0N3Z+BNH/O3K
	WiC5Wc0exLX33tum9EAhSCS2V4n0gGApG6NEDw4nEgDhd/EZP3p35ze3cmTwbqUZojHKQB
	smiSmX6+/+7yXdIz/DI03Hx0Kz4ppMOnorKNGNWl2TNZiU7KpvPsip78eopUAA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 17 Apr 2024 16:06:36 +0200
Subject: [PATCH v2] net: phy: marvell-88q2xxx: add support for Rev B1 and
 B2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mv88q222x-revb1-b2-init-v2-1-7ef41f87722a@ew.tq-group.com>
X-B4-Tracking: v=1; b=H4sIAGvXH2YC/4WNTQ6CMBCFr0Jm7RA6FKiuvIdhIaXALKDQYsUQ7
 m7lAm5e8r28nx28cWw83JIdnAns2U4R6JKAHp5Tb5DbyEAZyUxmOY5BqYWINozxRmBDyBOveL2
 WoiXdRakgtmdnOt7O5UcdeWC/Wvc5j4L4uf83g0CBUjWqKGQpdV7dzTtdF+ydfc2ptiPUx3F8A
 d5Ept3EAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713362801; l=6996;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=SFiNG4cY/dX3dvcrmilR8fsoZpFknWqY7qi+e6nh3Ds=;
 b=1XelDP0QTrHPIwQT35p4QmgjTlqfLyl+fpJP4cD/Z9ZlexnNrzpJTmb6+1u0/tXHaEXOJ4vi6
 y8mbK7S9fYiBNeCGEDIEoTMBevZxd45PfxDlaGJ1fnancA94qdqnCGg
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

Different revisions of the Marvell 88q2xxx phy needs different init
sequences.

Add init sequence for Rev B1 and Rev B2. Rev B2 init sequence skips one
register write.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
Hi,

as discussed when adding support for Marvell 88Q2220 Revision B0 [1],
newer revisions need different init sequences. So add support for Rev B1
and B2 with this patch.

[1] https://lore.kernel.org/netdev/20240216205302.GC3873@debian/

Best regards
Gregor
---
Changes in v2:
- Add helper function to write phy mmd sequences
- Link to v1: https://lore.kernel.org/r/20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com
---
 drivers/net/phy/marvell-88q2xxx.c | 119 +++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 6b4bd9883304..bbbb3efb7877 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -12,6 +12,8 @@
 #include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
+#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
+#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
 
 #define MDIO_MMD_AN_MV_STAT			32769
 #define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
@@ -129,6 +131,49 @@ static const struct mmd_val mv88q222x_revb0_init_seq1[] = {
 	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
 };
 
+static const struct mmd_val mv88q222x_revb1_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0xFFE4, 0x0007 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PCS, 0xFFE3, 0x7000 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
+};
+
+static const struct mmd_val mv88q222x_revb2_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0xFFE4, 0x0007 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
+};
+
+static const struct mmd_val mv88q222x_revb1_revb2_init_seq1[] = {
+	{ MDIO_MMD_PCS, 0xFE07, 0x125A },
+	{ MDIO_MMD_PCS, 0xFE09, 0x1288 },
+	{ MDIO_MMD_PCS, 0xFE08, 0x2588 },
+	{ MDIO_MMD_PCS, 0xFE72, 0x042C },
+	{ MDIO_MMD_PCS, 0xFFE4, 0x0071 },
+	{ MDIO_MMD_PCS, 0xFFE4, 0x0001 },
+	{ MDIO_MMD_PCS, 0xFE1B, 0x0048 },
+	{ MDIO_MMD_PMAPMD, 0x0000, 0x0000 },
+	{ MDIO_MMD_PCS, 0x0000, 0x0000 },
+	{ MDIO_MMD_PCS, 0xFFDB, 0xFC10 },
+	{ MDIO_MMD_PCS, 0xFE1B, 0x58 },
+	{ MDIO_MMD_PCS, 0xFCAD, 0x030C },
+	{ MDIO_MMD_PCS, 0x8032, 0x6001 },
+	{ MDIO_MMD_PCS, 0xFDFF, 0x05A5 },
+	{ MDIO_MMD_PCS, 0xFDEC, 0xDBAF },
+	{ MDIO_MMD_PCS, 0xFCAB, 0x1054 },
+	{ MDIO_MMD_PCS, 0xFCAC, 0x1483 },
+	{ MDIO_MMD_PCS, 0x8033, 0xC801 },
+	{ MDIO_MMD_AN, 0x8032, 0x2020 },
+	{ MDIO_MMD_AN, 0x8031, 0xA28 },
+	{ MDIO_MMD_AN, 0x8031, 0xC28 },
+	{ MDIO_MMD_PCS, 0xFBBA, 0x0CB2 },
+	{ MDIO_MMD_PCS, 0xFBBB, 0x0C4A },
+	{ MDIO_MMD_PCS, 0xFE5F, 0xE8 },
+	{ MDIO_MMD_PCS, 0xFE05, 0x755C },
+	{ MDIO_MMD_PCS, 0xFA20, 0x002A },
+	{ MDIO_MMD_PCS, 0xFE11, 0x1105 },
+};
+
 static int mv88q2xxx_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -687,31 +732,72 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
 	return 0;
 }
 
-static int mv88q222x_revb0_config_init(struct phy_device *phydev)
+static int mv88q222x_write_mmd_vals(struct phy_device *phydev,
+				    const struct mmd_val *vals, size_t len)
 {
-	int ret, i;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq0); i++) {
-		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq0[i].devad,
-				    mv88q222x_revb0_init_seq0[i].regnum,
-				    mv88q222x_revb0_init_seq0[i].val);
+	for (; len; vals++, len--) {
+		ret = phy_write_mmd(phydev, vals->devad, vals->regnum,
+				    vals->val);
 		if (ret < 0)
 			return ret;
 	}
 
+	return 0;
+}
+
+static int mv88q222x_revb0_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq0,
+				       ARRAY_SIZE(mv88q222x_revb0_init_seq0));
+	if (ret < 0)
+		return ret;
+
 	usleep_range(5000, 10000);
 
-	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb0_init_seq1); i++) {
-		ret = phy_write_mmd(phydev, mv88q222x_revb0_init_seq1[i].devad,
-				    mv88q222x_revb0_init_seq1[i].regnum,
-				    mv88q222x_revb0_init_seq1[i].val);
-		if (ret < 0)
-			return ret;
-	}
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb0_init_seq1,
+				       ARRAY_SIZE(mv88q222x_revb0_init_seq1));
+	if (ret < 0)
+		return ret;
 
 	return mv88q2xxx_config_init(phydev);
 }
 
+static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
+{
+	bool is_rev_b1 = phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB1;
+	int ret;
+
+	if (is_rev_b1)
+		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_init_seq0,
+					       ARRAY_SIZE(mv88q222x_revb1_init_seq0));
+	else
+		ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb2_init_seq0,
+					       ARRAY_SIZE(mv88q222x_revb2_init_seq0));
+	if (ret < 0)
+		return ret;
+
+	usleep_range(3000, 5000);
+
+	ret = mv88q222x_write_mmd_vals(phydev, mv88q222x_revb1_revb2_init_seq1,
+				       ARRAY_SIZE(mv88q222x_revb1_revb2_init_seq1));
+	if (ret < 0)
+		return ret;
+
+	return mv88q2xxx_config_init(phydev);
+}
+
+static int mv88q222x_config_init(struct phy_device *phydev)
+{
+	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
+		return mv88q222x_revb0_config_init(phydev);
+	else
+		return mv88q222x_revb1_revb2_config_init(phydev);
+}
+
 static int mv88q222x_cable_test_start(struct phy_device *phydev)
 {
 	int ret;
@@ -810,14 +896,15 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
 	},
 	{
-		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
+		.phy_id			= MARVELL_PHY_ID_88Q2220,
+		.phy_id_mask		= MARVELL_PHY_ID_MASK,
 		.name			= "mv88q2220",
 		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q2xxx_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
-		.config_init		= mv88q222x_revb0_config_init,
+		.config_init		= mv88q222x_config_init,
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q222x_soft_reset,
 		.config_intr		= mv88q2xxx_config_intr,
@@ -836,7 +923,7 @@ module_phy_driver(mv88q2xxx_driver);
 
 static struct mdio_device_id __maybe_unused mv88q2xxx_tbl[] = {
 	{ MARVELL_PHY_ID_88Q2110, MARVELL_PHY_ID_MASK },
-	{ PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0), },
+	{ MARVELL_PHY_ID_88Q2220, MARVELL_PHY_ID_MASK },
 	{ /*sentinel*/ }
 };
 MODULE_DEVICE_TABLE(mdio, mv88q2xxx_tbl);

---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240403-mv88q222x-revb1-b2-init-9961d2cf1d27

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


