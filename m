Return-Path: <linux-kernel+bounces-28840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC483039D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7803A1F21ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCCC1DFFD;
	Wed, 17 Jan 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OCWP0WZ7"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E91DFF5;
	Wed, 17 Jan 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487357; cv=none; b=caoycUYQEYeIbRTtmdATyP5oG+dV1+QTYNqbhgg6XOPWQpTtzUIG20INXfGM30JUgQoSUpDoDDsZlmntRkEEcyyu0HDqQhdBa5Dmf2sVctmDTY/ll94f3nZMX3lcl39iPKU0F6532XRxpwV2dkpHYK6CaSC5+E7dpAj3dlcQAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487357; c=relaxed/simple;
	bh=BU1PejNBS0a/bBfPMIJAZPtfyJyv/gguozdDnW7Xk3k=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=Bcw1OUdEt56gxje/8AI35JTeWFuhirha2v15fFbRXu0eErrqMnsef/eBNx8a5VK5X6vh422qeWF1FZ82COm0hWsErfYPQ/3T1cOmbcbVq1jTsvCrtIYslkT2121awZnEyq7zoaHlUr9l2K5df5UY7REYyATp2FjKk62OU84bs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OCWP0WZ7; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03B0A40013;
	Wed, 17 Jan 2024 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705487353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvE0m3OmI9QbGOc2rDZ1+csIvCDwHy1JZu00G19tkXU=;
	b=OCWP0WZ7kx21iuhGECAdyRwrqNJ/szCQJb0wjEdv8w0aY4uMYhgZh1WlntJyqPbM6WPH4Y
	L2GUzowt7AaaBGs3fUqXQSfvO5XY1rIN3d4Lj5sQ0V2qwB8Y9E356wexljBGNY3NHNkr3S
	HFkWEobujBRI6c/6Oe6nHbhT85L/oAqr+9Oaa0pRESFGEGxDgiBm86UDrykjvpto/vpdcc
	QJZI1nKRMtxIzoAOtE5XaQzxtl1PYSgnVb9mWB5KuGqFRSg8wF1bm3pmAVKb7MwBCLXI5z
	UJ9iLi7szpLKQTOpXFd9sUgyDq6lk49xDrNYAIV72jxjI5YtjHGnxIneT47Afw==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>,
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
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH net-next 5/8] net: dsa: mt7530: get rid of priv->info->cpu_port_config()
Date: Wed, 17 Jan 2024 13:28:35 +0300
Message-Id: <20240117102838.57445-6-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117102838.57445-1-arinc.unal@arinc9.com>
References: <20240117102838.57445-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

priv->info->cpu_port_config() is used for MT7531 and the switch on the
MT7988 SoC. It sets up the ports described as a CPU port earlier than the
phylink code path would do.

This function is useless as:
- Configuring the MACs can be done from the phylink_mac_config code path
  instead.
- All the link configuration it does on the CPU ports are later undone with
  the port_enable, phylink_mac_config, and then phylink_mac_link_up code
  path [1].

priv->p5_interface and priv->p6_interface were being used to prevent
configuring the MACs from the phylink_mac_config code path. Remove them now
that they hold no purpose.

Remove priv->info->cpu_port_config(). On mt753x_phylink_mac_config, switch
to if statements to simplify the code.

Remove the definition of PMCR_CPU_PORT_SETTING() now that it holds no
purpose.

Change mt753x_cpu_port_enable() to void now that there're no error cases
left.

Link: https://lore.kernel.org/netdev/ZHy2jQLesdYFMQtO@shell.armlinux.org.uk/ [1]
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 102 ++-------------------------------------
 drivers/net/dsa/mt7530.h |  11 -----
 2 files changed, 4 insertions(+), 109 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 32db5e14a606..76b304f8fb87 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -965,18 +965,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
 }
 
-static int
+static void
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
 	struct mt7530_priv *priv = ds->priv;
-	int ret;
-
-	/* Setup max capability of CPU port at first */
-	if (priv->info->cpu_port_config) {
-		ret = priv->info->cpu_port_config(ds, port);
-		if (ret)
-			return ret;
-	}
 
 	/* Enable Mediatek header mode on the cpu port */
 	mt7530_write(priv, MT7530_PVC_P(port),
@@ -1002,8 +994,6 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	/* Set to fallback mode for independent VLAN learning */
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
 		   MT7530_PORT_FALLBACK_MODE);
-
-	return 0;
 }
 
 static int
@@ -2244,8 +2234,6 @@ mt7530_setup(struct dsa_switch *ds)
 	val |= MHWTRAP_MANUAL;
 	mt7530_write(priv, MT7530_MHWTRAP, val);
 
-	priv->p6_interface = PHY_INTERFACE_MODE_NA;
-
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2260,9 +2248,7 @@ mt7530_setup(struct dsa_switch *ds)
 		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
 
 		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
+			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
 
@@ -2366,9 +2352,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
 
 		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
+			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
 
@@ -2457,10 +2441,6 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
 		   MT7531_GPIO0_INTERRUPT);
 
-	/* Let phylink decide the interface later. */
-	priv->p5_interface = PHY_INTERFACE_MODE_NA;
-	priv->p6_interface = PHY_INTERFACE_MODE_NA;
-
 	/* Enable PHY core PLL, since phy_device has not yet been created
 	 * provided for phy_[read,write]_mmd_indirect is called, we provide
 	 * our own mt7531_ind_mmd_phy_[read,write] to complete this
@@ -2672,26 +2652,9 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	struct mt7530_priv *priv = ds->priv;
 	u32 mcr_cur, mcr_new;
 
-	switch (port) {
-	case 5:
-		if (priv->p5_interface == state->interface)
-			break;
-
+	if (port == 5 || port == 6)
 		mt753x_mac_config(ds, port, mode, state);
 
-		if (priv->p5_intf_sel != P5_DISABLED)
-			priv->p5_interface = state->interface;
-		break;
-	case 6:
-		if (priv->p6_interface == state->interface)
-			break;
-
-		mt753x_mac_config(ds, port, mode, state);
-
-		priv->p6_interface = state->interface;
-		break;
-	}
-
 	mcr_cur = mt7530_read(priv, MT7530_PMCR_P(port));
 	mcr_new = mcr_cur;
 	mcr_new &= ~PMCR_LINK_SETTINGS_MASK;
@@ -2767,61 +2730,6 @@ static void mt753x_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	mt7530_set(priv, MT7530_PMCR_P(port), mcr);
 }
 
-static int
-mt7531_cpu_port_config(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-	phy_interface_t interface;
-	int speed;
-
-	switch (port) {
-	case 5:
-		if (!priv->p5_sgmii)
-			interface = PHY_INTERFACE_MODE_RGMII;
-		else
-			interface = PHY_INTERFACE_MODE_2500BASEX;
-
-		priv->p5_interface = interface;
-		break;
-	case 6:
-		interface = PHY_INTERFACE_MODE_2500BASEX;
-
-		priv->p6_interface = interface;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (interface == PHY_INTERFACE_MODE_2500BASEX)
-		speed = SPEED_2500;
-	else
-		speed = SPEED_1000;
-
-	mt7531_mac_config(ds, port, MLO_AN_FIXED, interface);
-
-	mt7530_write(priv, MT7530_PMCR_P(port),
-		     PMCR_CPU_PORT_SETTING(priv->id));
-	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED, interface, NULL,
-				   speed, DUPLEX_FULL, true, true);
-
-	return 0;
-}
-
-static int
-mt7988_cpu_port_config(struct dsa_switch *ds, int port)
-{
-	struct mt7530_priv *priv = ds->priv;
-
-	mt7530_write(priv, MT7530_PMCR_P(port),
-		     PMCR_CPU_PORT_SETTING(priv->id));
-
-	mt753x_phylink_mac_link_up(ds, port, MLO_AN_FIXED,
-				   PHY_INTERFACE_MODE_INTERNAL, NULL,
-				   SPEED_10000, DUPLEX_FULL, true, true);
-
-	return 0;
-}
-
 static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
@@ -3080,7 +2988,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.cpu_port_config = mt7531_cpu_port_config,
 		.mac_port_get_caps = mt7531_mac_port_get_caps,
 		.mac_port_config = mt7531_mac_config,
 	},
@@ -3092,7 +2999,6 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c22 = mt7531_ind_c22_phy_write,
 		.phy_read_c45 = mt7531_ind_c45_phy_read,
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
-		.cpu_port_config = mt7988_cpu_port_config,
 		.mac_port_get_caps = mt7988_mac_port_get_caps,
 	},
 };
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 4b47a5cac848..caae48703547 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -311,13 +311,6 @@ enum mt7530_vlan_port_acc_frm {
 					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
 					 PMCR_FORCE_FDX | PMCR_FORCE_LNK | \
 					 PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100)
-#define  PMCR_CPU_PORT_SETTING(id)	(PMCR_FORCE_MODE_ID((id)) | \
-					 PMCR_IFG_XMIT(1) | PMCR_MAC_MODE | \
-					 PMCR_BACKOFF_EN | PMCR_BACKPR_EN | \
-					 PMCR_TX_EN | PMCR_RX_EN | \
-					 PMCR_TX_FC_EN | PMCR_RX_FC_EN | \
-					 PMCR_FORCE_SPEED_1000 | \
-					 PMCR_FORCE_FDX | PMCR_FORCE_LNK)
 
 #define MT7530_PMEEECR_P(x)		(0x3004 + (x) * 0x100)
 #define  WAKEUP_TIME_1000(x)		(((x) & 0xFF) << 24)
@@ -724,7 +717,6 @@ struct mt753x_info {
 			    int regnum);
 	int (*phy_write_c45)(struct mt7530_priv *priv, int port, int devad,
 			     int regnum, u16 val);
-	int (*cpu_port_config)(struct dsa_switch *ds, int port);
 	void (*mac_port_get_caps)(struct dsa_switch *ds, int port,
 				  struct phylink_config *config);
 	void (*mac_port_validate)(struct dsa_switch *ds, int port,
@@ -750,7 +742,6 @@ struct mt753x_info {
  * @ports:		Holding the state among ports
  * @reg_mutex:		The lock for protecting among process accessing
  *			registers
- * @p6_interface	Holding the current port 6 interface
  * @p5_intf_sel:	Holding the current port 5 interface select
  * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
  *			has got SGMII
@@ -772,8 +763,6 @@ struct mt7530_priv {
 	const struct mt753x_info *info;
 	unsigned int		id;
 	bool			mcm;
-	phy_interface_t		p6_interface;
-	phy_interface_t		p5_interface;
 	enum p5_interface_select p5_intf_sel;
 	bool			p5_sgmii;
 	u8			mirror_rx;
-- 
2.40.1


