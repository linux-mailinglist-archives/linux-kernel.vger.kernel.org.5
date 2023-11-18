Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534787EFF8F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjKRMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjKRMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:33:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E610D5;
        Sat, 18 Nov 2023 04:33:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28A98E0009;
        Sat, 18 Nov 2023 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1700310793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIhFn78LcUCgsrVrNcFAERW+GWx7gO9OZl4IQGexLgo=;
        b=N/JVrIRDeCvEFtu/gWZJRnePW+fMp0pDdOQCeSKAzCmxXiRW09IGAYZ+9ykKbvn5CUybnZ
        hKUZxAJ5otc6OQpOa5kfH9AmxtsYh82vnWOvXVN6nelPu/LThotwP0D0f1NxPsZ1HjB65L
        DGuaY+vfYiVc11cKR+d3Xwu8XvE4UsU3Dum3K9vxsbRuQIrMY8h+OcJBkdIgbY1eeKYny7
        Mfr6YkKmXIzkT3riiKZWVAdU6BB22iXNS2nT79q/jg6jxaVdgT7AofTYAiPvvpS10xwTIf
        4uHRlplfymB2E9jtLmFxwsx0j8N39IItm73ZjyQ88YktiKaYL04awQ+AXMsDRA==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: [PATCH net-next 04/15] net: dsa: mt7530: improve comments regarding port 5 and 6
Date:   Sat, 18 Nov 2023 15:31:54 +0300
Message-Id: <20231118123205.266819-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no logic to numerically order the CPU ports. State the port number
and its capability of being used as a CPU port instead.

Remove the irrelevant PHY muxing information from
mt7530_mac_port_get_caps(). Explain the supported MII modes instead.

Remove the out of place PHY muxing information from
mt753x_phylink_mac_config(). The function is for MT7530, MT7531, and the
switch on the MT7988 SoC but there's no PHY muxing on MT7531 or the switch
on the MT7988 SoC.

These comments were gradually introduced with the commits below.
ca366d6c889b ("net: dsa: mt7530: Convert to PHYLINK API")
38f790a80560 ("net: dsa: mt7530: Add support for port 5")
88bdef8be9f6 ("net: dsa: mt7530: Extend device data ready for adding a new
hardware")
c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mt7530.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 45c9698ad9dd..8623742b35ee 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2520,12 +2520,16 @@ static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Internal PHY */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 		break;
 
-	case 5: /* 2nd cpu port with phy of port 0 or 4 / external phy */
+	/* Port 5 which can be used as a CPU port supports rgmii with delays,
+	 * mii, and gmii.
+	 */
+	case 5:
 		phy_interface_set_rgmii(config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_MII,
 			  config->supported_interfaces);
@@ -2533,7 +2537,8 @@ static void mt7530_mac_port_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 		break;
 
-	case 6: /* 1st cpu port */
+	/* Port 6 which can be used as a CPU port supports rgmii and trgmii. */
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_RGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_TRGMII,
@@ -2548,19 +2553,24 @@ static void mt7531_mac_port_get_caps(struct dsa_switch *ds, int port,
 	struct mt7530_priv *priv = ds->priv;
 
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Internal PHY */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
 		break;
 
-	case 5: /* 2nd cpu port supports either rgmii or sgmii/8023z */
+	/* Port 5 which can be used as a CPU port supports rgmii with delays on
+	 * MT7531BE, sgmii/802.3z on MT7531AE.
+	 */
+	case 5:
 		if (!priv->p5_sgmii) {
 			phy_interface_set_rgmii(config->supported_interfaces);
 			break;
 		}
 		fallthrough;
 
-	case 6: /* 1st cpu port supports sgmii/8023z only */
+	/* Port 6 which can be used as a CPU port supports sgmii/802.3z. */
+	case 6:
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -2579,11 +2589,13 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 	phy_interface_zero(config->supported_interfaces);
 
 	switch (port) {
-	case 0 ... 4: /* Internal phy */
+	/* Internal PHY */
+	case 0 ... 4:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
 
+	/* Port 6 which can be used as a CPU port is an internal 10G port. */
 	case 6:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
@@ -2747,12 +2759,12 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
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
 
@@ -2762,7 +2774,7 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		if (priv->p5_intf_sel != P5_DISABLED)
 			priv->p5_interface = state->interface;
 		break;
-	case 6: /* 1st cpu port */
+	case 6:
 		if (priv->p6_interface == state->interface)
 			break;
 
-- 
2.40.1

