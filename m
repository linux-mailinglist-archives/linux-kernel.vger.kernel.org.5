Return-Path: <linux-kernel+bounces-129875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624A89717F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0F31F20F41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E33142E78;
	Wed,  3 Apr 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kHykZO6q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lXCWb+qd"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908E4DA0C;
	Wed,  3 Apr 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152082; cv=none; b=kxDhdbzduESAcL306fi5ESehWBKNtrgIOe39lthg90rIVCzzg67go0js3+z6wNjeljIq+3gZJQZkKbvNVNC0xclZVNdj18a/o3RIuQ2I9aouRulQj2cHK0p4/ciuiz6V2bUfh+FmOcNeVq3+a33F9sfuwSHy6PLmmzpxAbY4/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152082; c=relaxed/simple;
	bh=YEVP9YpyH7o2aYsLFiX4m2nl9C+fbyptKQ7J4JphAmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NsGSESbLlFEEMF9heMExtwinqWadcdoCAermwIq7yg+gWpOdHY11p/03c2N9Q/vSiW5KHf4hpLzpHD6dM9KMdR58PBXeY6Wh2VB7Nrc38CFOGU3QlSyaaIbXNloyIBS+BxKG3oU4zyhdn/8wjfGXwDq+B8BHHBJZjfClQTBAPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kHykZO6q; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lXCWb+qd reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712152079; x=1743688079;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=YPy9yfsjAfToG/aF4JhewtXvS/gpl8OBYr5iAdGDwaI=;
  b=kHykZO6qgPHOhkKQd9U0PsThpje2XU657EHfGlbwskbKy1aqwHTtfMJ9
   ybCvO6sCwZvQcNa3m4iFUPWdAUx+QRn9qSqSzwE5n3lH076o/KmExU+zL
   xmfJuJNGkS/7fLmd82Q2rrbqu3k3QNnrKG3g9g8i6nXEqdrllMcIbxxY0
   vUQb8oN5D/9UG7m405tocc/8Mcq/pg4JbnrDH0YFWYnXMQ03Tj/nfH9D8
   yBCEuG0RwNVrmRj3omFsuHo/FQnRIs/lAFUnS32mRFFtGgHfOOYcxTX4a
   mDoWaioaE0wZxvZHDPzEfoQyGnY4gcpvx1SNd6d9u754ij3y5coNJop3P
   w==;
X-IronPort-AV: E=Sophos;i="6.07,177,1708383600"; 
   d="scan'208";a="36230473"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 03 Apr 2024 15:47:50 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B39A7173471;
	Wed,  3 Apr 2024 15:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712152065;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YPy9yfsjAfToG/aF4JhewtXvS/gpl8OBYr5iAdGDwaI=;
	b=lXCWb+qdsokxzO81ajEPy3MAV1EsR0sIe0IDdY6/FMuSRRpOsdF/CIJG7QyzN9pu8smZx3
	MkqzlDTpPRKQQqW9VMd+/aCYEGmPfLSF4vyaZm4FEgLksFRAoWkttJA3cIR6YBfs6OuBMo
	LG8vY3MCUuhD3J+HLYgzC1CSA2H3lg+8nAELrtYPNun63YOA/jT6jshH8JYaKps3ZiV/y+
	GM+d4B75L1xnZGWBnSssysCjRNUVm2bLKUwINWUx0ctC7Rq3+LPRNs6iVFkUV4VRLdjryF
	dMSWm6gWl55434FZRkQSrbJDfMtGw4O8vIMpOn2vNvyT10yNhBQbcPHlrWW7Ow==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 03 Apr 2024 15:45:22 +0200
Subject: [PATCH] net: phy: marvell-88q2xxx: add support for Rev B1 and B2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240403-mv88q222x-revb1-b2-init-v1-1-48b855464c37@ew.tq-group.com>
X-B4-Tracking: v=1; b=H4sIAHFdDWYC/x2MSwqAMAwFryJZG2ij+LuKuPATNQurtlIE8e4GN
 wMD894Dgb1wgCZ5wHOUILtTsWkC49q7hVEmdSBDuclNhlusqpOIbtR8sDgQipML67qwE42zogR
 dH55nuf/ntnvfDygSoGhpAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712152063; l=5601;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=YEVP9YpyH7o2aYsLFiX4m2nl9C+fbyptKQ7J4JphAmU=;
 b=LMdt2IUGtR9R6t/rywlx2hmuvxgMn+C7OvPHybfe/Kt56s+8RTL7ZhR4tl71flkURyPwHWc04
 ngUTyKpw26tD6HCkAFSqEVPmW6tgLfyW7ma6fATYA4F3AvshyBByw8n
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
 drivers/net/phy/marvell-88q2xxx.c | 86 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 6b4bd9883304..c4c916eb3195 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -12,6 +12,8 @@
 #include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
+#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
+#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
 
 #define MDIO_MMD_AN_MV_STAT			32769
 #define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
@@ -129,6 +131,43 @@ static const struct mmd_val mv88q222x_revb0_init_seq1[] = {
 	{ MDIO_MMD_PCS, 0xfe05, 0x755c },
 };
 
+static const struct mmd_val mv88q222x_revb1_init_seq0[] = {
+	{ MDIO_MMD_PCS, 0xFFE4, 0x0007 },
+	{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
+	{ MDIO_MMD_PCS, 0xFFE3, 0x7000 },
+	{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0840 },
+};
+
+static const struct mmd_val mv88q222x_revb1_init_seq1[] = {
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
@@ -712,6 +751,46 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 	return mv88q2xxx_config_init(phydev);
 }
 
+static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
+{
+	bool is_rev_b2 = phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB2;
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb1_init_seq0); i++) {
+		/* Rev B2 init sequence differs compared to Rev B1. As noted in Marvell API:
+		 * Remove the instruction to enable TXDAC setting overwrite bit for Rev B2.
+		 */
+		if (is_rev_b2 && mv88q222x_revb1_init_seq1[i].regnum == 0xffe3)
+			continue;
+
+		ret = phy_write_mmd(phydev, mv88q222x_revb1_init_seq0[i].devad,
+				    mv88q222x_revb1_init_seq0[i].regnum,
+				    mv88q222x_revb1_init_seq0[i].val);
+		if (ret < 0)
+			return ret;
+	}
+
+	usleep_range(3000, 5000);
+
+	for (i = 0; i < ARRAY_SIZE(mv88q222x_revb1_init_seq1); i++) {
+		ret = phy_write_mmd(phydev, mv88q222x_revb1_init_seq1[i].devad,
+				    mv88q222x_revb1_init_seq1[i].regnum,
+				    mv88q222x_revb1_init_seq1[i].val);
+		if (ret < 0)
+			return ret;
+	}
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
@@ -810,14 +889,15 @@ static struct phy_driver mv88q2xxx_driver[] = {
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
@@ -836,7 +916,7 @@ module_phy_driver(mv88q2xxx_driver);
 
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


