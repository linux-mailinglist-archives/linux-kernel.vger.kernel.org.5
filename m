Return-Path: <linux-kernel+bounces-156841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16308B08FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E911C22899
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C264B15ADB9;
	Wed, 24 Apr 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Q0xPz3vM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rw9mkMp6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA15A4B0;
	Wed, 24 Apr 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960672; cv=none; b=Ti3m0ybw/5+WR/B82/HgHxPkO+sGvbYVBdEfcTxLRBdC9uU31jFjLP0nfvxe39XxfJTmiOJCmVZYoHiHNt/s0xuTqAsUqWMyy1o0QBVlC1/5V05uhFGd7KdxBUuL5KRO3Bsn2oOlXDmFlcYheKo3CZirUCG7suVeyoDpUvaQ074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960672; c=relaxed/simple;
	bh=eimlWq8kVflh/c+fEiS0lXFPUO/HCWaH2dzbWoTfkv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H3wAGlGLxNyx/40gXaDb9yVICkUU1hEKOyaBWEXETeFqN8sH8jt21ecPeEkjyZGOUepQ+hkjv4CUFPf/lScaqM6DsOIe1Z7TYGQjcgj2JgJ4ALsuEDhgrQ7ItrMK898MXndErJuaCPC2R9GBFxl49LEuZgHJpaHs7U/tiHyzNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Q0xPz3vM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rw9mkMp6 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713960669; x=1745496669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4/jd3iPXDEyepeGoRTco76E2ElMRtPA3zVUCepTPAg=;
  b=Q0xPz3vM9W9OzKj8KP1hqLjg+pXGuVJ19AU/nSCxRXnvcUuJ/1QyDnar
   RlnrXgkgOVKMPsSi9JnVQrypucHClz4uR30c1vFFbb2mNbWTF+uEZScVC
   PGBbnTly8DA8Kp3yoKyWasOTXRfwQXKdhgabHGxJmNpYZBzGb/C7rJJDw
   tm1tTbHV0e+XNbGktN0m+1GqToCUwlJB2BIyHMb6iOfaVFQjvuiPHPKOD
   u8qC/mD06s+WpRGLqUI+g8G82/sBzWSPUI+VPBUWfg4y+3yrJ5Jpyf24M
   HI4pwchKvtzUZEl6ASY9+cNUS90WjgNhdcu+nK/8Wv4NnLFZBb+q+dY8q
   g==;
X-IronPort-AV: E=Sophos;i="6.07,226,1708383600"; 
   d="scan'208";a="36590444"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Apr 2024 14:10:58 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A0B316FDDD;
	Wed, 24 Apr 2024 14:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713960653;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=B4/jd3iPXDEyepeGoRTco76E2ElMRtPA3zVUCepTPAg=;
	b=rw9mkMp6+qlFNIbNVHtJ+ouGSEFooC3yj+QWmFY+hXLJk1UIqv4Pvb5Ycml67HqWqwDNrx
	WRbVJ9q4uCMai1Tw1kklUpI/hEY2FfIg5aNlfVZWwM86EB9NqLBVjt7hZmcxqXlLPr2GYw
	NKflyHixaPAfB3grNocq57QJCn6zDlpkESFzELUjDxidcscAgVMesRnIYuUKE+H1XWa9j6
	7rGln9ST3f0PJrKRvw6PIwTVo6+lapt9tzobplImrZ3+FYWMD0F74h5NnVYOKKyCJ6jhgh
	/KlPGOxJmeZ4WvADMM9+coSobsyiivWFmaLNUNMsX06uVXsI+DsvfrFjnXPo2w==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next] net: phy: marvell: add support for MV88E6020 internal PHYs
Date: Wed, 24 Apr 2024 14:10:22 +0200
Message-ID: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The embedded PHYs of the MV88E6020 (88E6250 family) switch are very
basic - they do not even have an Extended Address / Page register.

This adds support for the PHYs to the driver to set up PHY interrupts
and retrieve error stats. The ethtool stat functions are slightly
refactored to allow dealing with different marvell_hw_stat definitions.

The same code should also work with other 88E6250 family switches
(6250/6220/6071/6070), but it is unclear whether these use the same PHY
ID - the spec only lists the prefix 0x01410c00 and describes the lower
10 bits as reserved, but that seems too unspecific to be useful, as it
would cover several existing PHY IDs already supported by the driver.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

I guess one option regarding the PHY IDs would be to use 0x01410c00 with
mask 0xfffffc00 (lower 10 bits unspecified to match the docs) as a
fallback that would cover various PHYs without more specific support,
instead of making it specific to the MV88E6020 - the receive error stat
and interrupt handling seem to be common amongst all models supported by
the driver. Opinions?


 drivers/net/phy/marvell.c   | 79 +++++++++++++++++++++++++++++++++----
 include/linux/marvell_phy.h |  3 ++
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 860dc4001d415..7debaeca2620b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -301,6 +301,7 @@
 #define LPA_PAUSE_ASYM_FIBER	0x100
 
 #define NB_FIBER_STATS	1
+#define NB_STAT_MAX	3
 
 MODULE_DESCRIPTION("Marvell PHY driver");
 MODULE_AUTHOR("Andy Fleming");
@@ -319,6 +320,14 @@ static struct marvell_hw_stat marvell_hw_stats[] = {
 	{ "phy_receive_errors_fiber", 1, 21, 16},
 };
 
+static_assert(ARRAY_SIZE(marvell_hw_stats) <= NB_STAT_MAX);
+
+static struct marvell_hw_stat marvell_hw_stats_88e6020[] = {
+	{ "phy_receive_errors", 0, 21, 16},
+};
+
+static_assert(ARRAY_SIZE(marvell_hw_stats_88e6020) <= NB_STAT_MAX);
+
 enum {
 	M88E3082_VCT_OFF,
 	M88E3082_VCT_PHASE1,
@@ -326,7 +335,7 @@ enum {
 };
 
 struct marvell_priv {
-	u64 stats[ARRAY_SIZE(marvell_hw_stats)];
+	u64 stats[NB_STAT_MAX];
 	char *hwmon_name;
 	struct device *hwmon_dev;
 	bool cable_test_tdr;
@@ -1978,25 +1987,53 @@ static int marvell_get_sset_count(struct phy_device *phydev)
 		return ARRAY_SIZE(marvell_hw_stats) - NB_FIBER_STATS;
 }
 
-static void marvell_get_strings(struct phy_device *phydev, u8 *data)
+static int marvell_get_sset_count_88e6020(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(marvell_hw_stats_88e6020);
+}
+
+static void marvell_copy_strings(struct phy_device *phydev, u8 *data,
+				 const struct marvell_hw_stat *stats,
+				 int count)
 {
-	int count = marvell_get_sset_count(phydev);
 	int i;
 
 	for (i = 0; i < count; i++) {
 		strscpy(data + i * ETH_GSTRING_LEN,
-			marvell_hw_stats[i].string, ETH_GSTRING_LEN);
+			stats[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-static u64 marvell_get_stat(struct phy_device *phydev, int i)
+static void marvell_get_strings(struct phy_device *phydev, u8 *data)
+{
+	int count = marvell_get_sset_count(phydev);
+
+	marvell_copy_strings(phydev, data, marvell_hw_stats, count);
+}
+
+static void marvell_get_strings_88e6020(struct phy_device *phydev, u8 *data)
+{
+	int count = marvell_get_sset_count_88e6020(phydev);
+
+	marvell_copy_strings(phydev, data, marvell_hw_stats_88e6020, count);
+}
+
+static u64 marvell_get_stat(struct phy_device *phydev,
+			    const struct marvell_hw_stat *stats,
+			    int i)
 {
-	struct marvell_hw_stat stat = marvell_hw_stats[i];
+	struct marvell_hw_stat stat = stats[i];
 	struct marvell_priv *priv = phydev->priv;
 	int val;
 	u64 ret;
 
-	val = phy_read_paged(phydev, stat.page, stat.reg);
+	if (phydev->drv->write_page)
+		val = phy_read_paged(phydev, stat.page, stat.reg);
+	else if (stat.page == 0)
+		val = phy_read(phydev, stat.reg);
+	else
+		val = -1;
+
 	if (val < 0) {
 		ret = U64_MAX;
 	} else {
@@ -2015,7 +2052,17 @@ static void marvell_get_stats(struct phy_device *phydev,
 	int i;
 
 	for (i = 0; i < count; i++)
-		data[i] = marvell_get_stat(phydev, i);
+		data[i] = marvell_get_stat(phydev, marvell_hw_stats, i);
+}
+
+static void marvell_get_stats_88e6020(struct phy_device *phydev,
+				      struct ethtool_stats *stats, u64 *data)
+{
+	int count = marvell_get_sset_count_88e6020(phydev);
+	int i;
+
+	for (i = 0; i < count; i++)
+		data[i] = marvell_get_stat(phydev, marvell_hw_stats_88e6020, i);
 }
 
 static int m88e1510_loopback(struct phy_device *phydev, bool enable)
@@ -3924,6 +3971,21 @@ static struct phy_driver marvell_drivers[] = {
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
 	},
+	{
+		.phy_id = MARVELL_PHY_ID_88E6020,
+		.phy_id_mask = MARVELL_PHY_ID_MASK,
+		.name = "Marvell 88E6020",
+		/* PHY_BASIC_FEATURES */
+		.probe = marvell_probe,
+		.aneg_done = marvell_aneg_done,
+		.config_intr = marvell_config_intr,
+		.handle_interrupt = marvell_handle_interrupt,
+		.resume = genphy_resume,
+		.suspend = genphy_suspend,
+		.get_sset_count = marvell_get_sset_count_88e6020,
+		.get_strings = marvell_get_strings_88e6020,
+		.get_stats = marvell_get_stats_88e6020,
+	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E6341_FAMILY,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
@@ -4072,6 +4134,7 @@ static struct mdio_device_id __maybe_unused marvell_tbl[] = {
 	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6020, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6390_FAMILY, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6393_FAMILY, MARVELL_PHY_ID_MASK },
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 88254f9aec2b2..44e31bd3e08be 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -32,6 +32,9 @@
 /* Marvel 88E1111 in Finisar SFP module with modified PHY ID */
 #define MARVELL_PHY_ID_88E1111_FINISAR	0x01ff0cc0
 
+/* Embedded switch PHY IDs */
+#define MARVELL_PHY_ID_88E6020		0x01410db0
+
 /* These Ethernet switch families contain embedded PHYs, but they do
  * not have a model ID. So the switch driver traps reads to the ID2
  * register and returns the switch family ID
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


