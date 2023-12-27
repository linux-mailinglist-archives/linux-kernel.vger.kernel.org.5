Return-Path: <linux-kernel+bounces-11824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA481EC23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAC11C215F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782D63CD;
	Wed, 27 Dec 2023 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="NFJbNk5h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729863D6;
	Wed, 27 Dec 2023 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 515561C0002;
	Wed, 27 Dec 2023 04:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703652258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+ex37yFdAPrDz0ymYAcjESW8NARVuInLRjbup1ig0M=;
	b=NFJbNk5hnjCKEh/ud3uNd4am+vy94EZtX0f5LdkhfxGL5aZrcG3WGWfN/RupHmaK0SNxsS
	xtbXItQrV8V8KYlsve4fh/3HG+gscJiHS22seVViA+vjhnLiTtGcsoRBBE5ohbDap53fSC
	hMpXv2v4WFScCOJmVxUuzzh3LiOCIDfhx3hfQaMZrgN7Uxb5aF28rgwBXeFqPyKN3KJsQr
	5Cjugmp2lV2p/jUoH8yqTR14dBzvCxUyhjqOqBPq0YOr1MW2jiw1KGtuScWnvWMJ9Pug/8
	jRa8iqDp0+O8G5B32YHrzYEEN3C+IMl/P7Mj9GvKH6L9NgTDXuxSXxpGE8LLxA==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 3/7] net: dsa: mt7530: store port 5 SGMII capability of MT7531
Date: Wed, 27 Dec 2023 07:43:43 +0300
Message-Id: <20231227044347.107291-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231227044347.107291-1-arinc.unal@arinc9.com>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

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
 drivers/net/dsa/mt7530-mdio.c |  7 ++---
 drivers/net/dsa/mt7530.c      | 48 ++++++++++++-----------------------
 drivers/net/dsa/mt7530.h      |  6 +++--
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
index 436d5c311be0..ab9b291c7a5f 100644
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


