Return-Path: <linux-kernel+bounces-32334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA930835A53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA01C213C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A925ACA7D;
	Mon, 22 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKE25fjz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A464C90;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901758; cv=none; b=g9zpgTK76lQ+k9ZfhnAUhQEK1b9/+B3vMeo0hPJhtOBwvQyOtEyy78NXpTrZtaHivio0JdE+RnLvcljEPQLZHJhpy6G/Hy4ZqpgICyT+B8oKJ9D/gPFkmkAB88NxM9N9FIGbmmvtcw57WUpDnlR3Bcw/T236MHb8EEJcxx8Qb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901758; c=relaxed/simple;
	bh=Bgfx+EXSTylXwbNtkkMqzd6UQvp2lUWMn2C6vtoawQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U50AbJiJTt7KUIlY8nVn+nRwiMf++KzVgS8QQAJ99rCX+ncjmxoR2qk2mT5NvnRJIeXmAg/5+2mQXLbivtT5D+Izf8SJwSCcqh1GCw4sRihzhNI9KxRDDGRLzn8puq/wFU/4T9KqBY54zxHO+w1rPDqBWaD7tzpcDAx7e5CMLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKE25fjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581CCC433A6;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705901758;
	bh=Bgfx+EXSTylXwbNtkkMqzd6UQvp2lUWMn2C6vtoawQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XKE25fjzDV/7nvKO1u8VP9DMhM4FhykMky9I7YxP8Ezrkm9QY7pv+FO95Z043mrav
	 eEJCD5NR0gWNVOBdMvdGMF/64rVCHR8VdszdOzqujUgwA1AYRLikEVEe2Xuuz6QU4w
	 wU6E00CpxkfFXKjP1MVUCbYuSoDUR0VA9UMEV7M0XIXLiFyULO51ccUN+lAb4Ho5/y
	 G7VkyEmEvUeeXrwq7IZYU0FWwAn28snmS8EBGNtqvOSpRucBB09FX0fbnKNk6qnBoQ
	 HbHAjTaPSFUFOZqfVFkiAUY+Umpkpxfhn/QgTa14ASLcn2FnykpOblx5rxujemZSy/
	 +G+zKzzDpSJ7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C5C47DDF;
	Mon, 22 Jan 2024 05:35:58 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Mon, 22 Jan 2024 08:35:55 +0300
Subject: [PATCH net-next v3 4/7] net: dsa: mt7530: improve comments
 regarding switch ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240122-for-netnext-mt7530-improvements-1-v3-4-042401f2b279@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705901755; l=4567;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=rLcHCbYDzkt28v28nq9XIDczR9kM3jpJ8YmzJ0uoUlo=;
 b=P9VOv8+icSWtarQqBoOfyPHXdJUQtTer/Hw1RKxWe3HptZ6UWnYL15uVjd13g8sHELrl5aVez
 DZ0Bb8gDDuYBbL8SBFGTOYBY/b98Q7SFPz4h42o7MxTgYsK7IPd7/fB
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There's no logic to numerically order the CPU ports. Just state the port
number instead.

Remove the irrelevant PHY muxing information from
mt7530_mac_port_get_caps(). Explain the supported MII modes instead.

Remove the out of place PHY muxing information from
mt753x_phylink_mac_config(). The function is for MT7530, MT7531, and the
switch on the MT7988 SoC but there's no PHY muxing on MT7531 or the switch
on the MT7988 SoC.

These comments were gradually introduced with the commits below.
commit ca366d6c889b ("net: dsa: mt7530: Convert to PHYLINK API")
commit 38f790a80560 ("net: dsa: mt7530: Add support for port 5")
commit 88bdef8be9f6 ("net: dsa: mt7530: Extend device data ready for adding
a new hardware")
commit c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/mt7530.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c77092506c3f..93d8498ce274 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2520,12 +2520,14 @@ static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 		break;
 
-	case 5: /* 2nd cpu port with phy of port 0 or 4 / external phy */
+	/* Port 5 supports rgmii with delays, mii, and gmii. */
+	case 5:
 		phy_interface_set_rgmii(config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  config->supported_interfaces);
@@ -2533,7 +2535,8 @@ static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 6: /* 1st cpu port */
+	/* Port 6 supports rgmii and trgmii. */
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_RGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_TRGMII,
@@ -2548,19 +2551,24 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 	struct mt7530_priv *priv = ds->priv;
 
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 		break;
 
-	case 5: /* 2nd cpu port supports either rgmii or sgmii/8023z */
+	/* Port 5 supports rgmii with delays on MT7531BE, sgmii/802.3z on
+	 * MT7531AE.
+	 */
+	case 5:
 		if (!priv->p5_sgmii) {
 			phy_interface_set_rgmii(config->supported_interfaces);
 			break;
 		}
 		fallthrough;
 
-	case 6: /* 1st cpu port supports sgmii/8023z only */
+	/* Port 6 supports sgmii/802.3z. */
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -2579,11 +2587,13 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	phy_interface_zero(config->supported_interfaces);
 
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
 
+	/* Port 6 is connected to SoC's XGMII MAC. There is no MII pinout. */
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
@@ -2747,12 +2757,12 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	u32 mcr_cur, mcr_new;
 
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	case 0 ... 4:
 		if (state->interface != PHY_INTERFACE_MODE_GMII &&
 		    state->interface != PHY_INTERFACE_MODE_INTERNAL)
 			goto unsupported;
 		break;
-	case 5: /* 2nd cpu port with phy of port 0 or 4 / external phy */
+	case 5:
 		if (priv->p5_interface == state->interface)
 			break;
 
@@ -2762,7 +2772,7 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		if (priv->p5_intf_sel != P5_DISABLED)
 			priv->p5_interface = state->interface;
 		break;
-	case 6: /* 1st cpu port */
+	case 6:
 		if (priv->p6_interface == state->interface)
 			break;
 

-- 
2.40.1


