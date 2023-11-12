Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD617E936A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 01:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKLX7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 18:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKLX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 18:59:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9C1FD7;
        Sun, 12 Nov 2023 15:58:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso5898113a12.1;
        Sun, 12 Nov 2023 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699833535; x=1700438335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cumRikW8hW15lDtzGcPxoQjOSylMc60UFOUuk8uNaqc=;
        b=UG5p+IQVBj+pSLXh9sfynlpsmEDfZQzAWDcK53LrN+1DZi+lFg5ddsxWPywojhPyEB
         kgAzbCOqLZQWsEMRbAc2ZSbm//Y9KHFrGxwVtCNaEMLfwpsmyodZRFKAP8fdx7bRyY1S
         zQG0Saad5Z/hrWZGmcQ82BhW+JvpkFlJdEZaa10fhlshErrawo9fsl1FLQtdyrkaYRRh
         czjYwvCCChBirRDZWYAswKBSS7/qkC7/pgWibi7YNyhKppXwM9h/OjINomvF88+kjhvV
         50KO+tUuaJZabwI60Q/aOFWaUZaB3Fm3KSMVttNJAIAbR+e3c2SyoiELvk36r87uLKOr
         UnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699833535; x=1700438335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cumRikW8hW15lDtzGcPxoQjOSylMc60UFOUuk8uNaqc=;
        b=GrGY3sQEhDJX3vCgQU4T5MRhf2e4pVam73jjo8UM3fMF0/vIuRvbUDSBsEf47gbB68
         rQyAVqsqtJdJKTLgz8nhIwwq1hNIBtdqsaSp/P7J72Q6JsWjgsORKvUo9dUNANklxMRo
         3jGj4otZ2V6QzW83EIEfqM5wEFil0gI98F3I6H4MH0oCbhZ0peov4e2Cn7h2BhiZDFin
         7SIPoNlCe/GZaNCyP4Ceu0qFGRiVRvhbDnL0UI1/bBQwWX/Qr6cYTMKVKEVfS+eHZvyG
         lNAqxeROVQVUzVr21ZSpI9CktIvdMJxHEI7GIpN0VMjMBuewyfxUxQsocX4UTJYyEDSP
         ZUQQ==
X-Gm-Message-State: AOJu0Yw4azJDLniXWoVjRp+Yre0oTi33WSR2JYlm1qR3jI8NvSmQpiuB
        Y1lMB7awEAL16vmAWgeiqe4=
X-Google-Smtp-Source: AGHT+IE8TLl5iinYikCRYSRTjC0ZZqwK2HVTaCAOVdYAn7dB7Ll25yrcfg7OWWFoImHCu6wI5GdRQQ==
X-Received: by 2002:aa7:d98c:0:b0:544:fc51:cd9f with SMTP id u12-20020aa7d98c000000b00544fc51cd9fmr3124480eds.42.1699833535348;
        Sun, 12 Nov 2023 15:58:55 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id c70-20020a509fcc000000b00536ad96f867sm2916120edf.11.2023.11.12.15.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 15:58:54 -0800 (PST)
Date:   Mon, 13 Nov 2023 01:58:52 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <20231112235852.k36lpxw66nt7wh2e@skbuf>
References: <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sleubuo33guzfvp5"
Content-Disposition: inline
In-Reply-To: <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sleubuo33guzfvp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 12, 2023 at 07:27:50PM +0800, Jie Luo wrote:
> Sure Vladimir, Thanks for sharing this patch.
> 
> BTW, When do you upstream this patch? or Maybe you can upstream the
> separate patch for introducing the new interface mode 10g-qxgmii firstly? if
> that, i can also update qca8084 phy driver based on
> your patch.

I've removed the driver changes from the patch and formatted it on
net-next. There's also one more dependency patch. Both are attached to
this email.

I don't think I will find the time to upstream them by the time you
need them. I think it would be best if you could take these patches,
add your Signed-off-by: tag below mine, and submit them as the first 2
patches of your own series.

--sleubuo33guzfvp5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phylink-move-phylink_pcs_neg_mode-to-phylink.c.patch"

From 17fd68123d78f39a971f800de6da66522f71dc71 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 3 Oct 2023 22:16:25 +0300
Subject: [PATCH 1/2] net: phylink: move phylink_pcs_neg_mode() to phylink.c

Russell points out that there is no user of phylink_pcs_neg_mode()
outside of phylink.c, nor is there planned to be any, so we can just
move it there.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   | 66 ---------------------------------------
 2 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..ca9739fcb523 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -162,6 +162,71 @@ static const char *phylink_an_mode_str(unsigned int mode)
 	return mode < ARRAY_SIZE(modestr) ? modestr[mode] : "unknown";
 }
 
+/**
+ * phylink_pcs_neg_mode() - helper to determine PCS inband mode
+ * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
+ * @interface: interface mode to be used
+ * @advertising: adertisement ethtool link mode mask
+ *
+ * Determines the negotiation mode to be used by the PCS, and returns
+ * one of:
+ *
+ * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
+ * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
+ *   will be used.
+ * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
+ *   disabled
+ * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
+ *
+ * Note: this is for cases where the PCS itself is involved in negotiation
+ * (e.g. Clause 37, SGMII and similar) not Clause 73.
+ */
+static unsigned int phylink_pcs_neg_mode(unsigned int mode, phy_interface_t interface,
+					 const unsigned long *advertising)
+{
+	unsigned int neg_mode;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* These protocols are designed for use with a PHY which
+		 * communicates its negotiation result back to the MAC via
+		 * inband communication. Note: there exist PHYs that run
+		 * with SGMII but do not send the inband data.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		break;
+
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		/* 1000base-X is designed for use media-side for Fibre
+		 * connections, and thus the Autoneg bit needs to be
+		 * taken into account. We also do this for 2500base-X
+		 * as well, but drivers may not support this, so may
+		 * need to override this.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   advertising))
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+		break;
+
+	default:
+		neg_mode = PHYLINK_PCS_NEG_NONE;
+		break;
+	}
+
+	return neg_mode;
+}
+
 static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
 {
 	switch (interface) {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2b886ea654bb..871db640ceb6 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -98,72 +98,6 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
 	return mode == MLO_AN_INBAND;
 }
 
-/**
- * phylink_pcs_neg_mode() - helper to determine PCS inband mode
- * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
- * @interface: interface mode to be used
- * @advertising: adertisement ethtool link mode mask
- *
- * Determines the negotiation mode to be used by the PCS, and returns
- * one of:
- *
- * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
- * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
- *   will be used.
- * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
- *   disabled
- * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
- *
- * Note: this is for cases where the PCS itself is involved in negotiation
- * (e.g. Clause 37, SGMII and similar) not Clause 73.
- */
-static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
-						phy_interface_t interface,
-						const unsigned long *advertising)
-{
-	unsigned int neg_mode;
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_USXGMII:
-		/* These protocols are designed for use with a PHY which
-		 * communicates its negotiation result back to the MAC via
-		 * inband communication. Note: there exist PHYs that run
-		 * with SGMII but do not send the inband data.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		break;
-
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
-		/* 1000base-X is designed for use media-side for Fibre
-		 * connections, and thus the Autoneg bit needs to be
-		 * taken into account. We also do this for 2500base-X
-		 * as well, but drivers may not support this, so may
-		 * need to override this.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					   advertising))
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
-		break;
-
-	default:
-		neg_mode = PHYLINK_PCS_NEG_NONE;
-		break;
-	}
-
-	return neg_mode;
-}
-
 /**
  * struct phylink_link_state - link state structure
  * @advertising: ethtool bitmask containing advertised link modes
-- 
2.34.1


--sleubuo33guzfvp5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-net-phy-introduce-core-support-for-phy-mode-10g-qxgm.patch"

From a4aa044964c1d64b02eeb3bd5b5287f8179b2ce0 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 6 Oct 2023 23:42:35 +0300
Subject: [PATCH 2/2] net: phy: introduce core support for phy-mode =
 "10g-qxgmii"

10G-QXGMII is a MAC-to-PHY interface defined by the USXGMII multiport
specification. It uses the same signaling as USXGMII, but it multiplexes
4 ports over the link, resulting in a maximum speed of 2.5G per port.

Some in-tree SoCs like the NXP LS1028A use "usxgmii" when they mean
either the single-port USXGMII or the quad-port 10G-QXGMII variant, and
they could get away just fine with that thus far. But there is a need to
distinguish between the 2 as far as SerDes drivers are concerned.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../devicetree/bindings/net/ethernet-controller.yaml |  1 +
 Documentation/networking/phy.rst                     |  6 ++++++
 drivers/net/phy/phy-core.c                           |  1 +
 drivers/net/phy/phylink.c                            | 12 ++++++++++--
 include/linux/phy.h                                  |  4 ++++
 include/linux/phylink.h                              |  1 +
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 9f6a5ccbcefe..044880d804db 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -104,6 +104,7 @@ properties:
       - usxgmii
       - 10gbase-r
       - 25gbase-r
+      - 10g-qxgmii
 
   phy-mode:
     $ref: "#/properties/phy-connection-type"
diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 1283240d7620..f64641417c54 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -327,6 +327,12 @@ Some of the interface modes are described below:
     This is the Penta SGMII mode, it is similar to QSGMII but it combines 5
     SGMII lines into a single link compared to 4 on QSGMII.
 
+``PHY_INTERFACE_MODE_10G_QXGMII``
+    Represents the 10G-QXGMII PHY-MAC interface as defined by the Cisco USXGMII
+    Multiport Copper Interface document. It supports 4 ports over a 10.3125 GHz
+    SerDes lane, each port having speeds of 2.5G / 1G / 100M / 10M achieved
+    through symbol replication. The PCS expects the standard USXGMII code word.
+
 Pause frames / flow control
 ===========================
 
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..1cd58723d6d0 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -141,6 +141,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 1;
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 4;
 	case PHY_INTERFACE_MODE_PSGMII:
 		return 5;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ca9739fcb523..c2c247955747 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -191,6 +191,7 @@ static unsigned int phylink_pcs_neg_mode(unsigned int mode, phy_interface_t inte
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		/* These protocols are designed for use with a PHY which
 		 * communicates its negotiation result back to the MAC via
 		 * inband communication. Note: there exist PHYs that run
@@ -283,6 +284,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 		return SPEED_1000;
 
 	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return SPEED_2500;
 
 	case PHY_INTERFACE_MODE_5GBASER:
@@ -552,7 +554,11 @@ unsigned long phylink_get_capabilities(phy_interface_t interface,
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_USXGMII:
-		caps |= MAC_10000FD | MAC_5000FD | MAC_2500FD;
+		caps |= MAC_10000FD | MAC_5000FD;
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		caps |= MAC_2500FD;
 		fallthrough;
 
 	case PHY_INTERFACE_MODE_RGMII_TXID:
@@ -987,6 +993,7 @@ static int phylink_parse_mode(struct phylink *pl,
 			phylink_set(pl->supported, 25000baseSR_Full);
 			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
+		case PHY_INTERFACE_MODE_10G_QXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
 			phylink_set(pl->supported, 10baseT_Half);
@@ -1858,7 +1865,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
 	    interface != PHY_INTERFACE_MODE_RXAUI &&
 	    interface != PHY_INTERFACE_MODE_XAUI &&
-	    interface != PHY_INTERFACE_MODE_USXGMII)
+	    interface != PHY_INTERFACE_MODE_USXGMII &&
+	    interface != PHY_INTERFACE_MODE_10G_QXGMII)
 		config.interface = PHY_INTERFACE_MODE_NA;
 	else
 		config.interface = interface;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1351b802ffcf..c1636430dfe3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -125,6 +125,7 @@ extern const int phy_10gbit_features_array[1];
  * @PHY_INTERFACE_MODE_10GKR: 10GBASE-KR - with Clause 73 AN
  * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
  * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
+ * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -165,6 +166,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_10GKR,
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
+	PHY_INTERFACE_MODE_10G_QXGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -286,6 +288,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "100base-x";
 	case PHY_INTERFACE_MODE_QUSGMII:
 		return "qusgmii";
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return "10g-qxgmii";
 	default:
 		return "unknown";
 	}
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 871db640ceb6..336780e76e34 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -648,6 +648,7 @@ static inline int phylink_get_link_timer_ns(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 1600000;
 
 	case PHY_INTERFACE_MODE_1000BASEX:
-- 
2.34.1


--sleubuo33guzfvp5--
