Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB877FCCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376793AbjK2CNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjK2CMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CAF1BC8;
        Tue, 28 Nov 2023 18:12:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b34563987so2222865e9.1;
        Tue, 28 Nov 2023 18:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223958; x=1701828758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qRqs6v8lxOTVA+x1bbD/Lx0mTC/Dnzw05WwqzyQgc4=;
        b=B0CdoN8NSeIa7WCPwPPd3RDfXLFNmXeAL7On/XMQgnwNLHIb/VLND/5t4cPQ4z9xGZ
         yXBWApkouvxT7nSf7Q4wsXSRL6lgb6+YzrUpijsZ9KsbWFk6DpucW2NO9JFYGgn4iRlC
         CVBdZv2SVvbahPTTvWkVlG0QBKyUmAYQPq7pwO/XtFNOm61G0sTglxmGwJ/ANkH42c+4
         QnULhY5AfQitqnLBAzPZShM8+qFtbmSlPonRC92GHuniPVvPmxkLpVE3ehlVEQsEhcVf
         46prRbapGquJZPbM144+9xiytFs3KE1+woW+lLbP7xTH5jVKa40c3UpPR1e2Qs965rYe
         FL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223958; x=1701828758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qRqs6v8lxOTVA+x1bbD/Lx0mTC/Dnzw05WwqzyQgc4=;
        b=ulF+6rA7HBJr7b5vnvIcf2impfo3+oYt4y/FkXlASxCYW1k2FwfGACGuCiBEBeQ+PN
         OM83HVrWQHUDfvnKwVfS37Z9IXWtGk/mvOPp/vMrykSK6FXGbkdsXcMnJMVXfwbJxcro
         8i8y//oRdd/1zmVdGG7hKCpvZTAakB9UdGqsYp32qxZtycbFVKpvujcyHdteMESPZBew
         ZPw/EL/HJnMpObfPi2liotF+lfnmD6KWVIV3kcEZwubYM6LZdcB2Uurd3Ihd39mIrid2
         6ySMuN/E/O8+K4sHq0u+7wnUDY+pnpR8edhkFzD4drzif/fbRU/BzO90XaNPl6OqKm8m
         LSHw==
X-Gm-Message-State: AOJu0YykueOeGXuDx7iNiWDhEUyZKQdJASkqBpmPx9XLG+PLwS+F1Icx
        sqH9f+1NtEmgvKloy866W+I=
X-Google-Smtp-Source: AGHT+IF38knjFY+TWrHzQYAnxxuP3tDhATAU2Z1bE6nJuErphlXLxFX8sRlzaYbM+kZiatd5Vxr4HA==
X-Received: by 2002:a05:600c:45c8:b0:40b:45e2:1f4b with SMTP id s8-20020a05600c45c800b0040b45e21f4bmr7411183wmo.6.1701223958024;
        Tue, 28 Nov 2023 18:12:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:37 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 09/14] net: phy: at803x: remove specific qca808x check from at803x functions
Date:   Wed, 29 Nov 2023 03:12:14 +0100
Message-Id: <20231129021219.20914-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
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

Remove specific qca808x check from at803x generic functions.

While this cause a bit of code duplication, this is needed in
preparation for splitting the driver per PHY family and detaching
qca808x specific bits from the at803x driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 107 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 8f5878ccb1a8..475b96165f45 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1043,24 +1043,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	 */
 	ret = 0;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
-		int phy_ctrl = 0;
-
-		/* The reg MII_BMCR also needs to be configured for force mode, the
-		 * genphy_config_aneg is also needed.
-		 */
-		if (phydev->autoneg == AUTONEG_DISABLE)
-			genphy_c45_pma_setup_forced(phydev);
-
-		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
-			phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
-
-		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-				MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
-		if (ret < 0)
-			return ret;
-	}
-
 	return __genphy_config_aneg(phydev, ret);
 }
 
@@ -1197,14 +1179,8 @@ static int at803x_cdt_start(struct phy_device *phydev, int pair)
 {
 	u16 cdt;
 
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
-		cdt = QCA808X_CDT_ENABLE_TEST |
-			QCA808X_CDT_LENGTH_UNIT |
-			QCA808X_CDT_INTER_CHECK_DIS;
-	else
-		cdt = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
-			AT803X_CDT_ENABLE_TEST;
+	cdt = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
+	      AT803X_CDT_ENABLE_TEST;
 
 	return phy_write(phydev, AT803X_CDT, cdt);
 }
@@ -1212,16 +1188,10 @@ static int at803x_cdt_start(struct phy_device *phydev, int pair)
 static int at803x_cdt_wait_for_completion(struct phy_device *phydev)
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
-				    !(val & cdt_en),
+				    !(val & AT803X_CDT_ENABLE_TEST),
 				    30000, 100000, true);
 
 	return ret < 0 ? ret : 0;
@@ -1845,6 +1815,47 @@ static int qca8327_suspend(struct phy_device *phydev)
 	return qca83xx_suspend(phydev);
 }
 
+static int qca808x_config_aneg(struct phy_device *phydev)
+{
+	int phy_ctrl = 0;
+	int ret;
+
+	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+
+	/* Changes of the midx bits are disruptive to the normal operation;
+	 * therefore any changes to these registers must be followed by a
+	 * software reset to take effect.
+	 */
+	if (ret == 1) {
+		ret = genphy_soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Do not restart auto-negotiation by setting ret to 0 defautly,
+	 * when calling __genphy_config_aneg later.
+	 */
+	ret = 0;
+
+	/* The reg MII_BMCR also needs to be configured for force mode, the
+	 * genphy_config_aneg is also needed.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		genphy_c45_pma_setup_forced(phydev);
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
+	if (ret < 0)
+		return ret;
+
+	return __genphy_config_aneg(phydev, ret);
+}
+
 static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
 {
 	int ret;
@@ -2104,6 +2115,30 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca808x_cdt_start(struct phy_device *phydev)
+{
+	u16 cdt;
+
+	/* qca8081 takes the different bit 15 to enable CDT test */
+	cdt = QCA808X_CDT_ENABLE_TEST |
+	      QCA808X_CDT_LENGTH_UNIT |
+	      QCA808X_CDT_INTER_CHECK_DIS;
+
+	return phy_write(phydev, AT803X_CDT, cdt);
+}
+
+static int qca808x_cdt_wait_for_completition(struct phy_device *phydev)
+{
+	int val, ret;
+
+	/* One test run takes about 25ms */
+	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
+				    !(val & QCA808X_CDT_ENABLE_TEST),
+				    30000, 100000, true);
+
+	return ret < 0 ? ret : 0;
+}
+
 static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 {
 	int ret, val;
@@ -2111,11 +2146,11 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 
 	*finished = false;
 
-	ret = at803x_cdt_start(phydev, 0);
+	ret = qca808x_cdt_start(phydev);
 	if (ret)
 		return ret;
 
-	ret = at803x_cdt_wait_for_completion(phydev);
+	ret = qca808x_cdt_wait_for_completition(phydev);
 	if (ret)
 		return ret;
 
@@ -2360,7 +2395,7 @@ static struct phy_driver at803x_driver[] = {
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,
 	.get_features		= qca808x_get_features,
-	.config_aneg		= at803x_config_aneg,
+	.config_aneg		= qca808x_config_aneg,
 	.suspend		= genphy_suspend,
 	.resume			= genphy_resume,
 	.read_status		= qca808x_read_status,
-- 
2.40.1

