Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EDE80A64D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574191AbjLHOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574151AbjLHOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:54:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74A3871;
        Fri,  8 Dec 2023 06:52:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c19467a63so24584715e9.3;
        Fri, 08 Dec 2023 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047139; x=1702651939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxuFbcbCxLZZxQ+emdGZsDK+ZXhQqCPZYukVIrO9V20=;
        b=OvNqJ3Y/qp79ELQCaAtHV7bLPx1MDlPgXYqz+jDY5NP3Mi95fXBQSLU0T9Ue3U9nTP
         k0S2YV/XPPu7HOeawn+PzkHvUQWYl/hvcogIomo+Ur0tcbLTnhpybiWqNu9pYhsMjp4Z
         507ZmxV2+lQe/k447osPzY8nB1ZZANzQsIItcMIZxJCaCSqiXb4iO8UMFqbbWpnFWQo3
         7elvGYFpz6x1rE0aGdZUtLDx1UmIfyfbLjAR/bJs56Up08zCLro4NaYABuUyv8en+WpI
         FlMxj7uvFAjj7E9h/pS3JKdIFBtW4JYpa0uiXTUo3ftYG9nYP+vMxfZ5yfH+nPAyxpu7
         YoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047139; x=1702651939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxuFbcbCxLZZxQ+emdGZsDK+ZXhQqCPZYukVIrO9V20=;
        b=NiUEyKDDqIk2nH/bK8v2lw72S2w44aRBH37dNU6zpAS+BXA9+SSkr0jUHmeVG2aOcV
         3kvZjgp0skeMQCp3+HG11Cuv0N1fbwKZNm9+xltMV30JdnpdveSzkfJhfBqZr4m4pBOc
         uBzCtC1eb7i6QGtyAVXZz9ia3969Efg2jyKJERd8jnL6fth4/DXZvDL60iM6glOyKh1N
         Q/pRJ1vevAYLccYxBjjHEueAjRgYlWQRdTbj4/SymUqXVhseyeS6MvmmWN52qBUwgaUp
         A+q9rO0gRt7M10+qylvMMsgErp4Dc4+6P1kvRUrTAOR/SVdA0VI9E+dkLcAfbcJUgHZK
         hJYA==
X-Gm-Message-State: AOJu0YxSfUGIzVOZE/yYGdj5PeZE/M6gML7BiU6ajZWT/DwKSZU+NG54
        z1PonxgiELh9hzWXmCYWnYOY3BJ+OJs=
X-Google-Smtp-Source: AGHT+IG67jle1Z2+zoxP4oxAg5HtbCK0/2vEfR21l/LEJ7SMw/5MK6qxCmYyT46wCLW/IK0TyZIn7Q==
X-Received: by 2002:a05:600c:518a:b0:405:4776:735a with SMTP id fa10-20020a05600c518a00b004054776735amr61561wmb.2.1702047139231;
        Fri, 08 Dec 2023 06:52:19 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:18 -0800 (PST)
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
Subject: [net-next PATCH v4 11/13] net: phy: at803x: move at8031 functions in dedicated section
Date:   Fri,  8 Dec 2023 15:51:58 +0100
Message-Id: <20231208145200.25162-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
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

Move at8031 functions in dedicated section with dedicated at8031
parse_dt and probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 266 +++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 133 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 7443bc8fe17c..c08d3c4f097f 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -583,139 +583,6 @@ static int at803x_resume(struct phy_device *phydev)
 	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
 }
 
-static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
-					    unsigned int selector)
-{
-	struct phy_device *phydev = rdev_get_drvdata(rdev);
-
-	if (selector)
-		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
-					     0, AT803X_DEBUG_RGMII_1V8);
-	else
-		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
-					     AT803X_DEBUG_RGMII_1V8, 0);
-}
-
-static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct phy_device *phydev = rdev_get_drvdata(rdev);
-	int val;
-
-	val = at803x_debug_reg_read(phydev, AT803X_DEBUG_REG_1F);
-	if (val < 0)
-		return val;
-
-	return (val & AT803X_DEBUG_RGMII_1V8) ? 1 : 0;
-}
-
-static const struct regulator_ops vddio_regulator_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
-	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
-};
-
-static const unsigned int vddio_voltage_table[] = {
-	1500000,
-	1800000,
-};
-
-static const struct regulator_desc vddio_desc = {
-	.name = "vddio",
-	.of_match = of_match_ptr("vddio-regulator"),
-	.n_voltages = ARRAY_SIZE(vddio_voltage_table),
-	.volt_table = vddio_voltage_table,
-	.ops = &vddio_regulator_ops,
-	.type = REGULATOR_VOLTAGE,
-	.owner = THIS_MODULE,
-};
-
-static const struct regulator_ops vddh_regulator_ops = {
-};
-
-static const struct regulator_desc vddh_desc = {
-	.name = "vddh",
-	.of_match = of_match_ptr("vddh-regulator"),
-	.n_voltages = 1,
-	.fixed_uV = 2500000,
-	.ops = &vddh_regulator_ops,
-	.type = REGULATOR_VOLTAGE,
-	.owner = THIS_MODULE,
-};
-
-static int at8031_register_regulators(struct phy_device *phydev)
-{
-	struct at803x_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	struct regulator_config config = { };
-
-	config.dev = dev;
-	config.driver_data = phydev;
-
-	priv->vddio_rdev = devm_regulator_register(dev, &vddio_desc, &config);
-	if (IS_ERR(priv->vddio_rdev)) {
-		phydev_err(phydev, "failed to register VDDIO regulator\n");
-		return PTR_ERR(priv->vddio_rdev);
-	}
-
-	priv->vddh_rdev = devm_regulator_register(dev, &vddh_desc, &config);
-	if (IS_ERR(priv->vddh_rdev)) {
-		phydev_err(phydev, "failed to register VDDH regulator\n");
-		return PTR_ERR(priv->vddh_rdev);
-	}
-
-	return 0;
-}
-
-static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
-{
-	struct phy_device *phydev = upstream;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
-	phy_interface_t iface;
-
-	linkmode_zero(phy_support);
-	phylink_set(phy_support, 1000baseX_Full);
-	phylink_set(phy_support, 1000baseT_Full);
-	phylink_set(phy_support, Autoneg);
-	phylink_set(phy_support, Pause);
-	phylink_set(phy_support, Asym_Pause);
-
-	linkmode_zero(sfp_support);
-	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
-	/* Some modules support 10G modes as well as others we support.
-	 * Mask out non-supported modes so the correct interface is picked.
-	 */
-	linkmode_and(sfp_support, phy_support, sfp_support);
-
-	if (linkmode_empty(sfp_support)) {
-		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
-		return -EINVAL;
-	}
-
-	iface = sfp_select_interface(phydev->sfp_bus, sfp_support);
-
-	/* Only 1000Base-X is supported by AR8031/8033 as the downstream SerDes
-	 * interface for use with SFP modules.
-	 * However, some copper modules detected as having a preferred SGMII
-	 * interface do default to and function in 1000Base-X mode, so just
-	 * print a warning and allow such modules, as they may have some chance
-	 * of working.
-	 */
-	if (iface == PHY_INTERFACE_MODE_SGMII)
-		dev_warn(&phydev->mdio.dev, "module may not function if 1000Base-X not supported\n");
-	else if (iface != PHY_INTERFACE_MODE_1000BASEX)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct sfp_upstream_ops at8031_sfp_ops = {
-	.attach = phy_sfp_attach,
-	.detach = phy_sfp_detach,
-	.module_insert = at8031_sfp_insert,
-};
-
 static int at803x_parse_dt(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -1498,6 +1365,139 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
+					    unsigned int selector)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+
+	if (selector)
+		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
+					     0, AT803X_DEBUG_RGMII_1V8);
+	else
+		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
+					     AT803X_DEBUG_RGMII_1V8, 0);
+}
+
+static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+	int val;
+
+	val = at803x_debug_reg_read(phydev, AT803X_DEBUG_REG_1F);
+	if (val < 0)
+		return val;
+
+	return (val & AT803X_DEBUG_RGMII_1V8) ? 1 : 0;
+}
+
+static const struct regulator_ops vddio_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
+	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
+};
+
+static const unsigned int vddio_voltage_table[] = {
+	1500000,
+	1800000,
+};
+
+static const struct regulator_desc vddio_desc = {
+	.name = "vddio",
+	.of_match = of_match_ptr("vddio-regulator"),
+	.n_voltages = ARRAY_SIZE(vddio_voltage_table),
+	.volt_table = vddio_voltage_table,
+	.ops = &vddio_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_ops vddh_regulator_ops = {
+};
+
+static const struct regulator_desc vddh_desc = {
+	.name = "vddh",
+	.of_match = of_match_ptr("vddh-regulator"),
+	.n_voltages = 1,
+	.fixed_uV = 2500000,
+	.ops = &vddh_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int at8031_register_regulators(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	struct regulator_config config = { };
+
+	config.dev = dev;
+	config.driver_data = phydev;
+
+	priv->vddio_rdev = devm_regulator_register(dev, &vddio_desc, &config);
+	if (IS_ERR(priv->vddio_rdev)) {
+		phydev_err(phydev, "failed to register VDDIO regulator\n");
+		return PTR_ERR(priv->vddio_rdev);
+	}
+
+	priv->vddh_rdev = devm_regulator_register(dev, &vddh_desc, &config);
+	if (IS_ERR(priv->vddh_rdev)) {
+		phydev_err(phydev, "failed to register VDDH regulator\n");
+		return PTR_ERR(priv->vddh_rdev);
+	}
+
+	return 0;
+}
+
+static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	struct phy_device *phydev = upstream;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	phy_interface_t iface;
+
+	linkmode_zero(phy_support);
+	phylink_set(phy_support, 1000baseX_Full);
+	phylink_set(phy_support, 1000baseT_Full);
+	phylink_set(phy_support, Autoneg);
+	phylink_set(phy_support, Pause);
+	phylink_set(phy_support, Asym_Pause);
+
+	linkmode_zero(sfp_support);
+	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
+	/* Some modules support 10G modes as well as others we support.
+	 * Mask out non-supported modes so the correct interface is picked.
+	 */
+	linkmode_and(sfp_support, phy_support, sfp_support);
+
+	if (linkmode_empty(sfp_support)) {
+		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	iface = sfp_select_interface(phydev->sfp_bus, sfp_support);
+
+	/* Only 1000Base-X is supported by AR8031/8033 as the downstream SerDes
+	 * interface for use with SFP modules.
+	 * However, some copper modules detected as having a preferred SGMII
+	 * interface do default to and function in 1000Base-X mode, so just
+	 * print a warning and allow such modules, as they may have some chance
+	 * of working.
+	 */
+	if (iface == PHY_INTERFACE_MODE_SGMII)
+		dev_warn(&phydev->mdio.dev, "module may not function if 1000Base-X not supported\n");
+	else if (iface != PHY_INTERFACE_MODE_1000BASEX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct sfp_upstream_ops at8031_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = at8031_sfp_insert,
+};
+
 static int at8031_parse_dt(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
-- 
2.40.1

