Return-Path: <linux-kernel+bounces-32332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A2835A54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAA61F21020
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6783D294;
	Mon, 22 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijN0AhaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2D4C8B;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901758; cv=none; b=XczuMILEWNQ4rbnsJcywAcY/V9yOI01FNx0+1K64fQb7o3qkSO0EllIbTwzcmHTeKt/sd6Y4W6D2FCTGqWrRKiIRGRQP7XB59VrDApbOmCBiWXZ+1gSflsti956UolgFzCuN/KDeImyPnwQwXwTB3RdxOanV3c39LeluRbXzyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901758; c=relaxed/simple;
	bh=djvmZ+NvYLvVLmEXzBWr2c2/PA2/FCp0HOglMI/c3/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VF5u3/13V2r7awnk4f8ayHxmr4JPBt6qKv7RhUTjxmlAP+MnHEeC++XCnfrUYM0Qi8frRLhFrukOUMdIDBqX4K3U1Ov3/y/9wRn+gI/dluJRAhTVfeStCQCUk+wIbAW4VPJnxcwS7gnnf4s44HS/IZk3qJXq5WO+I4SEsJXaFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijN0AhaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51610C43394;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=djvmZ+NvYLvVLmEXzBWr2c2/PA2/FCp0HOglMI/c3/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ijN0AhaFeZUlrBKVZdmrWd7rq+mZ0gHU5/UNcL9VIknGXi0t4fcYpnZ569eRM/kfm
	 a32Zwk7CzQwXUJ/Lwglt7Zd33s6rf42JTDo8VDEGwTgPfTdKJBvlfhbOCEyJDho/Kr
	 nE7Rv6hnLf+EoVJHG/QnDayTx0tx3t33AMWClWpwDjq+VlLIHa9480id0iF2gnMtcY
	 saSYxncmG9yFpwXUxFvYljrwk9tcJcetIdLFrR5y+pTjyumHUWHoUcVXhI3VYaJqK8
	 O+yd5IVuGmMxjDLiKIw0bjDjU5DO82CnVFRcN+2KHUL+RWN7z5TUcthcDAMtsCW5zI
	 PKr4+WH8ilpSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D4C47DDE;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Jan 2024 08:35:54 +0300
Subject: [PATCH net-next v3 3/7] net: dsa: mt7530: store port 5 SGMII
 capability of MT7531
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-3-042401f2b279@arinc9.com>
References:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
In-Reply-To:
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=7562;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=C/3gFb6akRjR0J+yBiqrHudZESsd6yu5lnvCWWASaUM=;
 b=yj9U1DMeFF2xiyJ31vVGJgXq1W0YvTZBX2yHLhc3PNnDOyKmARYxtHmaXc6FQrdz3Gx4xU2mw
 Pb7dveAS0VBAnIwudhYGT+Q+z9o5SEnSpWQr8QnwMn7XxidRwgCP3AH
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Introduce the p5_sgmii field to store the information for whether port 5
has got SGMII or not. Instead of reading the MT7531_TOP_SIG_SR register
multiple times, the register will be read once and the value will be
stored on the p5_sgmii field. This saves unnecessary reads of the
register.

Move the comment about MT7531AE and MT7531BE to mt7531_setup(), where the
switch is identified.

Get rid of mt7531_dual_sgmii_supported() now that priv->p5_sgmii stores the
information. Address the code where mt7531_dual_sgmii_supported() is used.

Get rid of mt7531_is_rgmii_port() which just prints the opposite of
priv->p5_sgmii.

Instead of calling mt7531_pll_setup() then returning, do not call it if
port 5 is SGMII.

Remove P5_INTF_SEL_GMAC5_SGMII. The p5_interface_select enum is supposed to
represent the mode that port 5 is being used in, not the hardware
information of port 5. Set p5_intf_sel to P5_INTF_SEL_GMAC5 instead, if
port 5 is not dsa_is_unused_port().

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530-mdio.c |  7 ++-----
 drivers/net/dsa/mt7530.c      | 48 +++++++++++++++----------------------------
 drivers/net/dsa/mt7530.h      |  6 ++++--
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 088533663b83..fa3ee85a99c1 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -81,17 +81,14 @@ static const struct regmap_bus mt7530_regmap_bus = {
 };
 
 static int
-mt7531_create_sgmii(struct mt7530_priv *priv, bool dual_sgmii)
+mt7531_create_sgmii(struct mt7530_priv *priv)
 {
 	struct regmap_config *mt7531_pcs_config[2] = {};
 	struct phylink_pcs *pcs;
 	struct regmap *regmap;
 	int i, ret = 0;
 
-	/* MT7531AE has two SGMII units for port 5 and port 6
-	 * MT7531BE has only one SGMII unit for port 6
-	 */
-	for (i = dual_sgmii ? 0 : 1; i < 2; i++) {
+	for (i = priv->p5_sgmii ? 0 : 1; i < 2; i++) {
 		mt7531_pcs_config[i] = devm_kzalloc(priv->dev,
 						    sizeof(struct regmap_config),
 						    GFP_KERNEL);
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 761c4804449a..c77092506c3f 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -487,15 +487,6 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 	return 0;
 }
 
-static bool mt7531_dual_sgmii_supported(struct mt7530_priv *priv)
-{
-	u32 val;
-
-	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
-
-	return (val & PAD_DUAL_SGMII_EN) != 0;
-}
-
 static int
 mt7531_pad_setup(struct dsa_switch *ds, phy_interface_t interface)
 {
@@ -510,9 +501,6 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	u32 xtal;
 	u32 val;
 
-	if (mt7531_dual_sgmii_supported(priv))
-		return;
-
 	val = mt7530_read(priv, MT7531_CREV);
 	top_sig = mt7530_read(priv, MT7531_TOP_SIG_SR);
 	hwstrap = mt7530_read(priv, MT7531_HWTRAP);
@@ -920,8 +908,6 @@ static const char *p5_intf_modes(unsigned int p5_interface)
 		return "PHY P4";
 	case P5_INTF_SEL_GMAC5:
 		return "GMAC5";
-	case P5_INTF_SEL_GMAC5_SGMII:
-		return "GMAC5_SGMII";
 	default:
 		return "unknown";
 	}
@@ -2470,6 +2456,12 @@ mt7531_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	/* MT7531AE has got two SGMII units. One for port 5, one for port 6.
+	 * MT7531BE has got only one SGMII unit which is for port 6.
+	 */
+	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
+	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
+
 	/* all MACs must be forced link-down before sw reset */
 	for (i = 0; i < MT7530_NUM_PORTS; i++)
 		mt7530_write(priv, MT7530_PMCR_P(i), MT7531_FORCE_LNK);
@@ -2479,21 +2471,18 @@ mt7531_setup(struct dsa_switch *ds)
 		     SYS_CTRL_PHY_RST | SYS_CTRL_SW_RST |
 		     SYS_CTRL_REG_RST);
 
-	mt7531_pll_setup(priv);
-
-	if (mt7531_dual_sgmii_supported(priv)) {
-		priv->p5_intf_sel = P5_INTF_SEL_GMAC5_SGMII;
-
+	if (!priv->p5_sgmii) {
+		mt7531_pll_setup(priv);
+	} else {
 		/* Let ds->user_mii_bus be able to access external phy. */
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO11_RG_RXD2_MASK,
 			   MT7531_EXT_P_MDC_11);
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO12_RG_RXD3_MASK,
 			   MT7531_EXT_P_MDIO_12);
-	} else {
-		priv->p5_intf_sel = P5_INTF_SEL_GMAC5;
 	}
-	dev_dbg(ds->dev, "P5 support %s interface\n",
-		p5_intf_modes(priv->p5_intf_sel));
+
+	if (!dsa_is_unused_port(ds, 5))
+		priv->p5_intf_sel = P5_INTF_SEL_GMAC5;
 
 	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
 		   MT7531_GPIO0_INTERRUPT);
@@ -2553,11 +2542,6 @@ static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static bool mt7531_is_rgmii_port(struct mt7530_priv *priv, u32 port)
-{
-	return (port == 5) && (priv->p5_intf_sel != P5_INTF_SEL_GMAC5_SGMII);
-}
-
 static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
@@ -2570,7 +2554,7 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 		break;
 
 	case 5: /* 2nd cpu port supports either rgmii or sgmii/8023z */
-		if (mt7531_is_rgmii_port(priv, port)) {
+		if (!priv->p5_sgmii) {
 			phy_interface_set_rgmii(config->supported_interfaces);
 			break;
 		}
@@ -2637,7 +2621,7 @@ static int mt7531_rgmii_setup(struct mt7530_priv *priv, u32 port,
 {
 	u32 val;
 
-	if (!mt7531_is_rgmii_port(priv, port)) {
+	if (priv->p5_sgmii) {
 		dev_err(priv->dev, "RGMII mode is not available for port %d\n",
 			port);
 		return -EINVAL;
@@ -2881,7 +2865,7 @@ mt7531_cpu_port_config(struct dsa_switch *ds, int port)
 
 	switch (port) {
 	case 5:
-		if (mt7531_is_rgmii_port(priv, port))
+		if (!priv->p5_sgmii)
 			interface = PHY_INTERFACE_MODE_RGMII;
 		else
 			interface = PHY_INTERFACE_MODE_2500BASEX;
@@ -3033,7 +3017,7 @@ mt753x_setup(struct dsa_switch *ds)
 		mt7530_free_irq_common(priv);
 
 	if (priv->create_sgmii) {
-		ret = priv->create_sgmii(priv, mt7531_dual_sgmii_supported(priv));
+		ret = priv->create_sgmii(priv);
 		if (ret && priv->irq)
 			mt7530_free_irq(priv);
 	}
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 9cbf18efa416..80060cc740d2 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -687,7 +687,6 @@ enum p5_interface_select {
 	P5_INTF_SEL_PHY_P0,
 	P5_INTF_SEL_PHY_P4,
 	P5_INTF_SEL_GMAC5,
-	P5_INTF_SEL_GMAC5_SGMII,
 };
 
 struct mt7530_priv;
@@ -756,6 +755,8 @@ struct mt753x_info {
  *			registers
  * @p6_interface	Holding the current port 6 interface
  * @p5_intf_sel:	Holding the current port 5 interface select
+ * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
+ *			has got SGMII
  * @irq:		IRQ number of the switch
  * @irq_domain:		IRQ domain of the switch irq_chip
  * @irq_enable:		IRQ enable bits, synced to SYS_INT_EN
@@ -777,6 +778,7 @@ struct mt7530_priv {
 	phy_interface_t		p6_interface;
 	phy_interface_t		p5_interface;
 	enum p5_interface_select p5_intf_sel;
+	bool			p5_sgmii;
 	u8			mirror_rx;
 	u8			mirror_tx;
 	struct mt7530_port	ports[MT7530_NUM_PORTS];
@@ -786,7 +788,7 @@ struct mt7530_priv {
 	int irq;
 	struct irq_domain *irq_domain;
 	u32 irq_enable;
-	int (*create_sgmii)(struct mt7530_priv *priv, bool dual_sgmii);
+	int (*create_sgmii)(struct mt7530_priv *priv);
 	u8 active_cpu_ports;
 };
 

-- 
2.40.1


