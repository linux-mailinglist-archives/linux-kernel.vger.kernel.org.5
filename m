Return-Path: <linux-kernel+bounces-166379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B268B99D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833CD286777
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201A71747;
	Thu,  2 May 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Lv6Dd1me";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z6yB1jkl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736460EC3;
	Thu,  2 May 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648419; cv=none; b=pJ6eUgBmIlBdaQjuWUkqLnPZqKjYp42DM8X7VKIPmakifJMdTTntqyDuhBs5Kc2BIGlhZng0i/awKJcDh7ucnZGY99ZUjRSNX8lHVxhBxGzh6LB8rjWfa+VPW3FuOYZp4VLoe+8VveOLaz7REA8XVXvP5VnNs9UPCKW9GuwWvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648419; c=relaxed/simple;
	bh=OuTZQ+/7rHsfObb2tcsr6PhBaUTl/GxqVfAea4AyiKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz55d7FN6vxTDSAkYKCkd5d0jAMh9mHyOl051BTbPKRo021pIhDi44RHfPcfjT8oeBy3pG6iKrEfDT4XEfI1MI/LyUCrVvDE0JC5LdNIA+jvNeRC6G30DYCZK6UxBkVvb4YwNS5iIWp/qh0BTNUbN7Hi9CNKiL4kqg9tygPxsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Lv6Dd1me; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Z6yB1jkl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714648417; x=1746184417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYtuRdh8pSDk+rK8KTdLUhNcAPcSyIqHES/cKzkJCnk=;
  b=Lv6Dd1mew4kZbbt2KhjoYldQ+yh9LPH+bDhh87afF+itTKaA3UyPRQub
   5mLkjjTR13jFVArrlSp7peHp36nEzsAnvMg0wtCpeooYBJDnN0OqQAbkf
   KKLbWFdBa7qW8i+kAX/o4XpUYWx1UQOZaGeWdovV2ihdsjZHohqrx/aiE
   SgkSxEYIrKwpn03zpC4ZKc12XO8RvqLADR4TKZeDVBQ3vcu/kYRL3W6Tj
   gctl1154evv2gml6YL3EnncmA0b4T4t9ZgI0W53ciG7S2KqO1kPi63uai
   Sy2neiuqjLeH5Z0R0poQPrKSdZLVSsVlDmFZ1KlpHjfNq/RPCeqe1GEA+
   A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="36716026"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 02 May 2024 13:13:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67BF816FBF2;
	Thu,  2 May 2024 13:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714648403;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EYtuRdh8pSDk+rK8KTdLUhNcAPcSyIqHES/cKzkJCnk=;
	b=Z6yB1jkl/iBJ/L7Att+STUaQ+znAcm6NG3YMu4F4dv07wLKNE1tfpttE9q2ShwISx/TQ9K
	ydEhiy7h3O1EGlyhK0R45OcNULQawSuk3H23Zc1mPqaf0GlPDIxBcg6sww8ukjMEibN6FS
	gKf3e8XthMDuVB1x+6pjwdBqSqYbCPwolCmMgUX/5OrUU0hAfHlbYrtZfGkho+U8UXAV77
	tNrPMTKSTa+wb4/8/2MUUnnlsGgQBkAzkTuwrbRa1Ldjr5e7HebsH5AIAyWiYRxoa0MeKl
	T18C1jYppvGe8bwHkJyv9Qjr+A2xlrUwRenmJp00qJ6oC1WNbYzPIXjIP5bBhQ==
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
Subject: [PATCH net-next v2 2/2] net: phy: marvell: add support for MV88E6250 family internal PHYs
Date: Thu,  2 May 2024 13:13:01 +0200
Message-ID: <0695f699cd942e6e06da9d30daeedfd47785bc01.1714643285.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
References: <24d7a2f39e0c4c94466e8ad43228fdd798053f3a.1714643285.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The embedded PHYs of the 88E6250 family switches are very basic - they
do not even have an Extended Address / Page register.

This adds support for the PHYs to the driver to set up PHY interrupts
and retrieve error stats. To deal with PHYs without a page register,
"simple" variants of all stat handling functions are introduced.

The code should work with all 88E6250 family switches (6250/6220/6071/
6070/6020). The PHY ID 0x01410db0 was read from a 88E6020, under the
assumption that all switches of this family use the same ID. The spec
only lists the prefix 0x01410c00 and leaves the last 10 bits as reserved,
but that seems too unspecific to be useful, as it would cover several
existing PHY IDs already supported by the driver; therefore, the ID read
from the actual hardware is used.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:

- Change the PHY ID define name to MARVELL_PHY_ID_88E6250_FAMILY
- Introduce a full separate set of stat functions for PHYs without a page
  register. The functions are renamed to "simple", as they are likely
  usable for other integrated PHYs without pages in the future.

 drivers/net/phy/marvell.c   | 81 ++++++++++++++++++++++++++++++++++++-
 include/linux/marvell_phy.h |  2 +
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index a57ad53cd09cb..9964bf3dea2fb 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -301,6 +301,7 @@
 #define LPA_PAUSE_ASYM_FIBER	0x100
 
 #define NB_FIBER_STATS	1
+#define NB_STAT_MAX	3
 
 MODULE_DESCRIPTION("Marvell PHY driver");
 MODULE_AUTHOR("Andy Fleming");
@@ -319,6 +320,23 @@ static const struct marvell_hw_stat marvell_hw_stats[] = {
 	{ "phy_receive_errors_fiber", 1, 21, 16},
 };
 
+static_assert(ARRAY_SIZE(marvell_hw_stats) <= NB_STAT_MAX);
+
+/* "simple" stat list + corresponding marvell_get_*_simple functions are used
+ * on PHYs without a page register
+ */
+struct marvell_hw_stat_simple {
+	const char *string;
+	u8 reg;
+	u8 bits;
+};
+
+static const struct marvell_hw_stat_simple marvell_hw_stats_simple[] = {
+	{ "phy_receive_errors", 21, 16},
+};
+
+static_assert(ARRAY_SIZE(marvell_hw_stats_simple) <= NB_STAT_MAX);
+
 enum {
 	M88E3082_VCT_OFF,
 	M88E3082_VCT_PHASE1,
@@ -326,7 +344,7 @@ enum {
 };
 
 struct marvell_priv {
-	u64 stats[ARRAY_SIZE(marvell_hw_stats)];
+	u64 stats[NB_STAT_MAX];
 	char *hwmon_name;
 	struct device *hwmon_dev;
 	bool cable_test_tdr;
@@ -1978,6 +1996,11 @@ static int marvell_get_sset_count(struct phy_device *phydev)
 		return ARRAY_SIZE(marvell_hw_stats) - NB_FIBER_STATS;
 }
 
+static int marvell_get_sset_count_simple(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(marvell_hw_stats_simple);
+}
+
 static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int count = marvell_get_sset_count(phydev);
@@ -1989,6 +2012,17 @@ static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 	}
 }
 
+static void marvell_get_strings_simple(struct phy_device *phydev, u8 *data)
+{
+	int count = marvell_get_sset_count_simple(phydev);
+	int i;
+
+	for (i = 0; i < count; i++) {
+		strscpy(data + i * ETH_GSTRING_LEN,
+			marvell_hw_stats_simple[i].string, ETH_GSTRING_LEN);
+	}
+}
+
 static u64 marvell_get_stat(struct phy_device *phydev, int i)
 {
 	struct marvell_hw_stat stat = marvell_hw_stats[i];
@@ -2008,6 +2042,25 @@ static u64 marvell_get_stat(struct phy_device *phydev, int i)
 	return ret;
 }
 
+static u64 marvell_get_stat_simple(struct phy_device *phydev, int i)
+{
+	struct marvell_hw_stat_simple stat = marvell_hw_stats_simple[i];
+	struct marvell_priv *priv = phydev->priv;
+	int val;
+	u64 ret;
+
+	val = phy_read(phydev, stat.reg);
+	if (val < 0) {
+		ret = U64_MAX;
+	} else {
+		val = val & ((1 << stat.bits) - 1);
+		priv->stats[i] += val;
+		ret = priv->stats[i];
+	}
+
+	return ret;
+}
+
 static void marvell_get_stats(struct phy_device *phydev,
 			      struct ethtool_stats *stats, u64 *data)
 {
@@ -2018,6 +2071,16 @@ static void marvell_get_stats(struct phy_device *phydev,
 		data[i] = marvell_get_stat(phydev, i);
 }
 
+static void marvell_get_stats_simple(struct phy_device *phydev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	int count = marvell_get_sset_count_simple(phydev);
+	int i;
+
+	for (i = 0; i < count; i++)
+		data[i] = marvell_get_stat_simple(phydev, i);
+}
+
 static int m88e1510_loopback(struct phy_device *phydev, bool enable)
 {
 	int err;
@@ -3924,6 +3987,21 @@ static struct phy_driver marvell_drivers[] = {
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
 	},
+	{
+		.phy_id = MARVELL_PHY_ID_88E6250_FAMILY,
+		.phy_id_mask = MARVELL_PHY_ID_MASK,
+		.name = "Marvell 88E6250 Family",
+		/* PHY_BASIC_FEATURES */
+		.probe = marvell_probe,
+		.aneg_done = marvell_aneg_done,
+		.config_intr = marvell_config_intr,
+		.handle_interrupt = marvell_handle_interrupt,
+		.resume = genphy_resume,
+		.suspend = genphy_suspend,
+		.get_sset_count = marvell_get_sset_count_simple,
+		.get_strings = marvell_get_strings_simple,
+		.get_stats = marvell_get_stats_simple,
+	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E6341_FAMILY,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
@@ -4072,6 +4150,7 @@ static struct mdio_device_id __maybe_unused marvell_tbl[] = {
 	{ MARVELL_PHY_ID_88E1540, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1545, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E3016, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E6250_FAMILY, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6341_FAMILY, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6390_FAMILY, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E6393_FAMILY, MARVELL_PHY_ID_MASK },
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 88254f9aec2b2..b1fbe4118414a 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -32,6 +32,8 @@
 /* Marvel 88E1111 in Finisar SFP module with modified PHY ID */
 #define MARVELL_PHY_ID_88E1111_FINISAR	0x01ff0cc0
 
+/* ID from 88E6020, assumed to be the same for the whole 6250 family */
+#define MARVELL_PHY_ID_88E6250_FAMILY	0x01410db0
 /* These Ethernet switch families contain embedded PHYs, but they do
  * not have a model ID. So the switch driver traps reads to the ID2
  * register and returns the switch family ID
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


