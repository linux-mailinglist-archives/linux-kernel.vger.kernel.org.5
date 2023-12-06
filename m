Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29482807CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjLGABZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441897AbjLGAA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720519E;
        Wed,  6 Dec 2023 16:00:34 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b5155e154so4694545e9.3;
        Wed, 06 Dec 2023 16:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907233; x=1702512033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E05UGHQ4N7O1lFKOAb+MxjheYxLzG4PbQZQyg7KHlkU=;
        b=K17L3WnIMDYg/DJcmukoYgTHmhuUu8zblYO+0DJZ4N3FgYJM2MLb/XRrxFvTvwYnBr
         Z9imFBlJgR2kbsNPjKflcoLZWGtaZHn3IPWHvxl4+kvOnYYz5RuYi9PG6l0buyDHeNO8
         kziJlkZllTji9+6eB4/D8uwzz1UjoOzNzsroh5Wf1IvgEXpRmvjtDXBsQATD2jQxuN7g
         mNKwHtOr2+Z0GawfIHKmPa9Q0FGS/v8awMJDuGbnDtU/jhO/RApglUC30kBehuwDRokM
         TQsp37FgW5pSe6sVz3OXBdyavzUZ+zvK5Ob3Gp8Vz96g+/fK8fhPgQ56owytMa8eWECI
         wPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907233; x=1702512033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E05UGHQ4N7O1lFKOAb+MxjheYxLzG4PbQZQyg7KHlkU=;
        b=DuKTCE2F6JLM5Av1A2vv8xqFAxd/JEpcU58Ha2BwG3iK8qEUr00Y6DX0Tigi3NT0Mk
         kmxyZ2VJylH4/AMbNFy0JDb2fMWFKdqXxZdC0YO92WYtdwG3rM8UCdZgTPkJ6ig0fLu9
         eXY9QRiLHz8PB075JJPW/0Vc3Rh3Sjno7Lln4hmTLormuH7imicMwraw0/bNyQat6Rnm
         JCFg3tEtivS1AVwhNZ8PcsFjpidTWPW9HLQPoIb7CjTVUEdJzjsoTMU7O47oURfbtZuZ
         R9T/mSmhmIvkCzDdaiCkMjd0g9SnukDjAEQT/28FGJOXoaCsvFdHcX5kGydIE//2WMBw
         gklA==
X-Gm-Message-State: AOJu0YydgrL2Ywt/xSOJWcY8d0M4/+TJU+5/CSGueDMqqY14SvLVD8GC
        kGNGvjTjba+ofGMj+Qw8anI8e8afnVU=
X-Google-Smtp-Source: AGHT+IGvRhkPjkzqqHXVwRWA1q7K7c6tz6hNVInnpLjA9DxAE26oV/Piqn0osTB4NFHPW1XUWEMwKg==
X-Received: by 2002:a05:600c:1f86:b0:40b:5e4a:406d with SMTP id je6-20020a05600c1f8600b0040b5e4a406dmr991376wmb.141.1701907233227;
        Wed, 06 Dec 2023 16:00:33 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:32 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 13/13] net: phy: at803x: drop specific PHY ID check from cable test functions
Date:   Thu,  7 Dec 2023 00:57:28 +0100
Message-Id: <20231206235728.6985-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop specific PHY ID check for cable test functions for at803x. This is
done to make functions more generic. While at it better describe what
the functions does by using more symbolic function names.

PHYs that requires to set additional reg are moved to specific function
calling the more generic one.

cdt_start and cdt_wait_for_completion are changed to take an additional
arg to pass specific values specific to the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 95 +++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 27dc0a9ca076..d102f826db73 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1222,31 +1222,16 @@ static int at803x_cdt_fault_length(u16 status)
 	return (dt * 824) / 10;
 }
 
-static int at803x_cdt_start(struct phy_device *phydev, int pair)
+static int at803x_cdt_start(struct phy_device *phydev,
+			    u32 cdt_start)
 {
-	u16 cdt;
-
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
-		cdt = QCA808X_CDT_ENABLE_TEST |
-			QCA808X_CDT_LENGTH_UNIT |
-			QCA808X_CDT_INTER_CHECK_DIS;
-	else
-		cdt = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
-			AT803X_CDT_ENABLE_TEST;
-
-	return phy_write(phydev, AT803X_CDT, cdt);
+	return phy_write(phydev, AT803X_CDT, cdt_start);
 }
 
-static int at803x_cdt_wait_for_completion(struct phy_device *phydev)
+static int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+					  u32 cdt_en)
 {
 	int val, ret;
-	u16 cdt_en;
-
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
-		cdt_en = QCA808X_CDT_ENABLE_TEST;
-	else
-		cdt_en = AT803X_CDT_ENABLE_TEST;
 
 	/* One test run takes about 25ms */
 	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
@@ -1266,11 +1251,13 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 	};
 	int ret, val;
 
-	ret = at803x_cdt_start(phydev, pair);
+	val = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
+	      AT803X_CDT_ENABLE_TEST;
+	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
 
-	ret = at803x_cdt_wait_for_completion(phydev);
+	ret = at803x_cdt_wait_for_completion(phydev, AT803X_CDT_ENABLE_TEST);
 	if (ret)
 		return ret;
 
@@ -1292,19 +1279,11 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 }
 
 static int at803x_cable_test_get_status(struct phy_device *phydev,
-					bool *finished)
+					bool *finished, unsigned long pair_mask)
 {
-	unsigned long pair_mask;
 	int retries = 20;
 	int pair, ret;
 
-	if (phydev->phy_id == ATH9331_PHY_ID ||
-	    phydev->phy_id == ATH8032_PHY_ID ||
-	    phydev->phy_id == QCA9561_PHY_ID)
-		pair_mask = 0x3;
-	else
-		pair_mask = 0xf;
-
 	*finished = false;
 
 	/* According to the datasheet the CDT can be performed when
@@ -1331,7 +1310,7 @@ static int at803x_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
-static int at803x_cable_test_start(struct phy_device *phydev)
+static void at803x_cable_test_autoneg(struct phy_device *phydev)
 {
 	/* Enable auto-negotiation, but advertise no capabilities, no link
 	 * will be established. A restart of the auto-negotiation is not
@@ -1339,11 +1318,11 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	 */
 	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
 	phy_write(phydev, MII_ADVERTISE, ADVERTISE_CSMA);
-	if (phydev->phy_id != ATH9331_PHY_ID &&
-	    phydev->phy_id != ATH8032_PHY_ID &&
-	    phydev->phy_id != QCA9561_PHY_ID)
-		phy_write(phydev, MII_CTRL1000, 0);
+}
 
+static int at803x_cable_test_start(struct phy_device *phydev)
+{
+	at803x_cable_test_autoneg(phydev);
 	/* we do all the (time consuming) work later */
 	return 0;
 }
@@ -1620,6 +1599,29 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+/* AR8031 and AR8035 share the same cable test get status reg */
+static int at8031_cable_test_get_status(struct phy_device *phydev,
+					bool *finished)
+{
+	return at803x_cable_test_get_status(phydev, finished, 0xf);
+}
+
+/* AR8031 and AR8035 share the same cable test start logic */
+static int at8031_cable_test_start(struct phy_device *phydev)
+{
+	at803x_cable_test_autoneg(phydev);
+	phy_write(phydev, MII_CTRL1000, 0);
+	/* we do all the (time consuming) work later */
+	return 0;
+}
+
+/* AR8032, AR9331 and QCA9561 share the same cable test get status reg */
+static int at8032_cable_test_get_status(struct phy_device *phydev,
+					bool *finished)
+{
+	return at803x_cable_test_get_status(phydev, finished, 0x3);
+}
+
 static int at8035_parse_dt(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
@@ -2043,11 +2045,14 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 
 	*finished = false;
 
-	ret = at803x_cdt_start(phydev, 0);
+	val = QCA808X_CDT_ENABLE_TEST |
+	      QCA808X_CDT_LENGTH_UNIT |
+	      QCA808X_CDT_INTER_CHECK_DIS;
+	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
 
-	ret = at803x_cdt_wait_for_completion(phydev);
+	ret = at803x_cdt_wait_for_completion(phydev, QCA808X_CDT_ENABLE_TEST);
 	if (ret)
 		return ret;
 
@@ -2145,8 +2150,8 @@ static struct phy_driver at803x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_start	= at8031_cable_test_start,
+	.cable_test_get_status	= at8031_cable_test_get_status,
 }, {
 	/* Qualcomm Atheros AR8030 */
 	.phy_id			= ATH8030_PHY_ID,
@@ -2183,8 +2188,8 @@ static struct phy_driver at803x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_start	= at8031_cable_test_start,
+	.cable_test_get_status	= at8031_cable_test_get_status,
 }, {
 	/* Qualcomm Atheros AR8032 */
 	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
@@ -2199,7 +2204,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 }, {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
@@ -2212,7 +2217,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
@@ -2228,7 +2233,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
-- 
2.40.1

