Return-Path: <linux-kernel+bounces-152845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF928AC530
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1669A282255
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188135028F;
	Mon, 22 Apr 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2hshxji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A84AEE5;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770131; cv=none; b=W+MHfwZC69SiZfaREkRmTGQHzLLOwXl2beTXBGCpPu5O8LIG+toqt+I8WAirv5Ra5GF/cIdx2jzVoyjhFmK5fkwwTHm5+BFEOLDu2MJ3l/dN+KsC8OTcYAEkXn3kqVTsz7AJ8CzZfF0NmfQwM+RdryYAnXYKEBQoCJvhF0z5qAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770131; c=relaxed/simple;
	bh=DrChZcFmzE0/BqrbPpCtlwi4iActHT7vq+cQDwv9Mng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdoPHSMPOkIe3gP571zpTItd6T5Ri+XfwU8kI/8cu5byj7ZsES1hhqWnKx6uHL02mzrebMSoYOKagGZaSomHRnbywjaa5C46U8BbDLdQ3bTNyJfNOusQ3SGoL2LJHpIk25oT/kAMYwORVSIHE2AsV0VpkOFN2GkGoKdYKFaBuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2hshxji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A04A7C3277B;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713770130;
	bh=DrChZcFmzE0/BqrbPpCtlwi4iActHT7vq+cQDwv9Mng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t2hshxjivJvD8DSALox6DicKQbXHKas58jfzDkmtxYAWo2XoIUI4XauysCU9XdD97
	 CQG0WbrgaJ+NLXFFYzylhYtzBxppYdgeFeQYMrQOd1av/bKrQnslismZ1z9cnivaI3
	 iKZTbzRI/1Z0vQRnghRtuJc/d3RcgogBR33hPeADC4zZyfoe06mWnoNVaJoPbkhf0f
	 UZKRBbqof7taI9VxkzCa96DwEzZcu9Fp0fiGtdvOIFVN/lxGYr8QRzppitW3KWwNTs
	 nytfwMyGrEW82GZjy4vipR4NnP0xgjEZ11Dq42SHoRh9EpoLNKVuVXj5IsuZdArXtT
	 eAjb8oZP2SxeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93002C10F15;
	Mon, 22 Apr 2024 07:15:30 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Apr 2024 10:15:10 +0300
Subject: [PATCH net-next v2 03/15] net: dsa: mt7530: rename p5_intf_sel and
 use only for MT7530 switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240422-for-netnext-mt7530-improvements-4-v2-3-a75157ba76ad@arinc9.com>
References: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
In-Reply-To: <20240422-for-netnext-mt7530-improvements-4-v2-0-a75157ba76ad@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713770127; l=5777;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=uZA3tC7GsV/vAXhUQJDQl3EKCDn/sB64E6udt6p1H0w=;
 b=xbMLfS0ZQre2ccG2N0HkT6GV7m/5XpOfZ08fulP53BqLEVRidjNQKpsoVhBXGu5sYFqEqd7ZZ
 NVuyWj+x8l4A4thpjHPew/94itgPvInDXUtz5U4ZWp6K0DZRK3s4dCq
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The p5_intf_sel pointer is used to store the information of whether PHY
muxing is used or not. PHY muxing is a feature specific to port 5 of the
MT7530 switch. Do not use it for other switch models.

Rename the pointer to p5_mode to store the mode the port is being used in.
Rename the p5_interface_select enum to mt7530_p5_mode, the string
representation to mt7530_p5_mode_str, and the enum elements.

If PHY muxing is not detected, the default mode, GMAC5, will be used.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 62 ++++++++++++++++++++----------------------------
 drivers/net/dsa/mt7530.h | 15 ++++++------
 2 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8dee9cee1104..5b6aeeddb5d9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -857,19 +857,15 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	return 0;
 }
 
-static const char *p5_intf_modes(unsigned int p5_interface)
-{
-	switch (p5_interface) {
-	case P5_DISABLED:
-		return "DISABLED";
-	case P5_INTF_SEL_PHY_P0:
-		return "PHY P0";
-	case P5_INTF_SEL_PHY_P4:
-		return "PHY P4";
-	case P5_INTF_SEL_GMAC5:
-		return "GMAC5";
+static const char *mt7530_p5_mode_str(unsigned int mode)
+{
+	switch (mode) {
+	case MUX_PHY_P0:
+		return "MUX PHY P0";
+	case MUX_PHY_P4:
+		return "MUX PHY P4";
 	default:
-		return "unknown";
+		return "GMAC5";
 	}
 }
 
@@ -886,23 +882,23 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	val |= MHWTRAP_MANUAL | MHWTRAP_P5_MAC_SEL | MHWTRAP_P5_DIS;
 	val &= ~MHWTRAP_P5_RGMII_MODE & ~MHWTRAP_PHY0_SEL;
 
-	switch (priv->p5_intf_sel) {
-	case P5_INTF_SEL_PHY_P0:
-		/* MT7530_P5_MODE_GPHY_P0: 2nd GMAC -> P5 -> P0 */
+	switch (priv->p5_mode) {
+	/* MUX_PHY_P0: P0 -> P5 -> SoC MAC */
+	case MUX_PHY_P0:
 		val |= MHWTRAP_PHY0_SEL;
 		fallthrough;
-	case P5_INTF_SEL_PHY_P4:
-		/* MT7530_P5_MODE_GPHY_P4: 2nd GMAC -> P5 -> P4 */
+
+	/* MUX_PHY_P4: P4 -> P5 -> SoC MAC */
+	case MUX_PHY_P4:
 		val &= ~MHWTRAP_P5_MAC_SEL & ~MHWTRAP_P5_DIS;
 
 		/* Setup the MAC by default for the cpu port */
 		mt7530_write(priv, MT753X_PMCR_P(5), 0x56300);
 		break;
-	case P5_INTF_SEL_GMAC5:
-		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
-		val &= ~MHWTRAP_P5_DIS;
-		break;
+
+	/* GMAC5: P5 -> SoC MAC or external PHY */
 	default:
+		val &= ~MHWTRAP_P5_DIS;
 		break;
 	}
 
@@ -930,8 +926,8 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 
 	mt7530_write(priv, MT7530_MHWTRAP, val);
 
-	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, intf_sel=%s, phy-mode=%s\n",
-		val, p5_intf_modes(priv->p5_intf_sel), phy_modes(interface));
+	dev_dbg(ds->dev, "Setup P5, HWTRAP=0x%x, mode=%s, phy-mode=%s\n", val,
+		mt7530_p5_mode_str(priv->p5_mode), phy_modes(interface));
 
 	mutex_unlock(&priv->reg_mutex);
 }
@@ -2476,13 +2472,11 @@ mt7530_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Setup port 5 */
-	if (!dsa_is_unused_port(ds, 5)) {
-		priv->p5_intf_sel = P5_INTF_SEL_GMAC5;
-	} else {
+	/* Check for PHY muxing on port 5 */
+	if (dsa_is_unused_port(ds, 5)) {
 		/* Scan the ethernet nodes. Look for GMAC1, lookup the used PHY.
-		 * Set priv->p5_intf_sel to the appropriate value if PHY muxing
-		 * is detected.
+		 * Set priv->p5_mode to the appropriate value if PHY muxing is
+		 * detected.
 		 */
 		for_each_child_of_node(dn, mac_np) {
 			if (!of_device_is_compatible(mac_np,
@@ -2506,17 +2500,16 @@ mt7530_setup(struct dsa_switch *ds)
 				}
 				id = of_mdio_parse_addr(ds->dev, phy_node);
 				if (id == 0)
-					priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
+					priv->p5_mode = MUX_PHY_P0;
 				if (id == 4)
-					priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
+					priv->p5_mode = MUX_PHY_P4;
 			}
 			of_node_put(mac_np);
 			of_node_put(phy_node);
 			break;
 		}
 
-		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
-		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
+		if (priv->p5_mode == MUX_PHY_P0 || priv->p5_mode == MUX_PHY_P4)
 			mt7530_setup_port5(ds, interface);
 	}
 
@@ -2654,9 +2647,6 @@ mt7531_setup(struct dsa_switch *ds)
 			   MT7531_EXT_P_MDIO_12);
 	}
 
-	if (!dsa_is_unused_port(ds, 5))
-		priv->p5_intf_sel = P5_INTF_SEL_GMAC5;
-
 	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
 		   MT7531_GPIO0_INTERRUPT);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 7d7abb67202f..c8155e32edbe 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -708,12 +708,11 @@ struct mt7530_port {
 	struct phylink_pcs *sgmii_pcs;
 };
 
-/* Port 5 interface select definitions */
-enum p5_interface_select {
-	P5_DISABLED,
-	P5_INTF_SEL_PHY_P0,
-	P5_INTF_SEL_PHY_P4,
-	P5_INTF_SEL_GMAC5,
+/* Port 5 mode definitions of the MT7530 switch */
+enum mt7530_p5_mode {
+	GMAC5,
+	MUX_PHY_P0,
+	MUX_PHY_P4,
 };
 
 struct mt7530_priv;
@@ -776,7 +775,7 @@ struct mt753x_info {
  * @ports:		Holding the state among ports
  * @reg_mutex:		The lock for protecting among process accessing
  *			registers
- * @p5_intf_sel:	Holding the current port 5 interface select
+ * @p5_mode:		Holding the current mode of port 5 of the MT7530 switch
  * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
  *			has got SGMII
  * @irq:		IRQ number of the switch
@@ -798,7 +797,7 @@ struct mt7530_priv {
 	const struct mt753x_info *info;
 	unsigned int		id;
 	bool			mcm;
-	enum p5_interface_select p5_intf_sel;
+	enum mt7530_p5_mode	p5_mode;
 	bool			p5_sgmii;
 	u8			mirror_rx;
 	u8			mirror_tx;

-- 
2.40.1



