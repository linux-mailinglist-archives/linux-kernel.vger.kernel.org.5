Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC27E8D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjKKWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:54:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA8258C;
        Sat, 11 Nov 2023 14:54:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso4913810a12.1;
        Sat, 11 Nov 2023 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699743284; x=1700348084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42zBE/Ews+FAaAGK7D70zEYzsvFsshw1/gpKJ5UmkkM=;
        b=VYevlaMDnmtUEaAc7bVHwhyE3gfeavJTovI/lnNuva+/icD/yE3ixxchaNmmfpF4ul
         YDF2Mez3xJjYtTJYL3ZaIsKs1Xx9ldiuN1+4K/fQSPmUkvjsbxDpu5NJQQC+nOqyY7d3
         sGI0/PjlTCLcs5vhBN60dobzyEvcd0HYKmraDcTUhSW1NmLpUpE5XB32rpE8sGQ5gQSV
         EkV7vT8FL6sdpKYORhrv91s4mknfm+fPttbYYB4M9dGO9Kur/Fzs4XKS40HGi3APS+Gh
         6InRkdjma9KlyxfLzQmLVTeX8cornqPWYlfyF9mjSfRSITFOBwCalRCUK5LyHUQngs4N
         bd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699743284; x=1700348084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42zBE/Ews+FAaAGK7D70zEYzsvFsshw1/gpKJ5UmkkM=;
        b=R7uf9u9fouv80gPRmn2mNK9uCs6ptAhMzgswsfE8vmhhPR+um/ucIvAyn1LpL3yf5z
         HYNWdmcOZIQoxgmWHJZaBFkjuHllRScE/NiBMtevHT4HvBp29GUe/NgAuSRe1m+YVrew
         6zmGQte/zSJbJN2Hn+0N4jZBAyTZdo503GSwf0UC1tuS+BOEDLvxo3vM5rcufWzGcZSD
         4fD7MI7aDgaRg5IIObB5HwUGoPIIKTr7zmiTIf12VlZycI/8XN5Le12QuWQGYF8o8PoT
         7t5MIzXI/xJD3nrisqyF75uLGde2B3wuaNtklxb4BLfwNvnmD5l9FOnKA/3SKeST0xIo
         DliQ==
X-Gm-Message-State: AOJu0Ywr+iZF6EWQjt42OGg+66ZFkJOcQWmN2sc+n4wv3mUZZGaM58wm
        MN4DRKL50X98LlHwxhmqmiA2+qr9uPs=
X-Google-Smtp-Source: AGHT+IGtmkA0jsJCJyIRyRvD41TvApuISdz9nqAk9Gkyd4EWUHy6RLCVF0NFETP/4xwjw9PunVXO3Q==
X-Received: by 2002:a05:6402:1806:b0:53e:1721:146b with SMTP id g6-20020a056402180600b0053e1721146bmr2152653edy.28.1699743283815;
        Sat, 11 Nov 2023 14:54:43 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k21-20020aa7c395000000b0053f10da1105sm1488717edq.87.2023.11.11.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 14:54:43 -0800 (PST)
Date:   Sun, 12 Nov 2023 00:54:41 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <20231111225441.vpcosrowzcudb5jg@skbuf>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 05:56:09PM +0800, Jie Luo wrote:
> > > > > > > What I understand from this is that this PHY can be used either as a
> > > > > > > switch, in which case port 4 would be connected to the host interface
> > > > > > > at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> > > > > > > speed would be limited to 1G per-port, is that correct ?
> > > > > > 
> > > > > > When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> > > > > > PHYs can support to the max link speed 2.5G, actually the PHY can
> > > > > > support to max link speed 2.5G for all supported interface modes
> > > > > > including qusgmii and sgmii.
> > > > > 
> > > > > I'm a bit confused then, as the USGMII spec says that Quad USGMII really
> > > > > is for quad 10/100/1000 speeds, using 10b/8b encoding.
> > > > > 
> > > > > Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> > > > >    with 66b/64b encoding ?
> > > > 
> > > > Hi Maxime,
> > > > Yes, for quad PHY mode, it is using 66b/64 encoding.
> > > > 
> > > > it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> > > > so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> > > > quad PHYs here.
> > > > 
> > > > can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> > > > case(qca8084 quad PHY mode)?
> > > > 
> > > > Thanks,
> > > > Jie.
> > > 
> > > one more thing, if we use the PHY_INTERFACE_MODE_USXGMII for
> > > the quad PHY here, the MAC serdes can't distinguish the actual
> > > mode PHY_INTERFACE_MODE_USXGMII and 10G-QXGMII(qca8084 quad phy mode),
> > > the MAC serdes has the different configurations for usxgmii(10g single
> > > port) and qxsgmii(quad PHY).
> > 
> > Yes you do need a way to know which mode to use, what I'm wondering is
> > that the usxgmii spec actually defines something like 9 different modes
> > ( 1/2/4/8 ports, with a total bandwidth ranging from 2.5Gbps to 20 Gbps
> > ), should we define a phy mode for all of these variants, or should we
> > have another way of getting the mode variant (like, saying I want to
> > use usxgmii, in 4 ports mode, with the serdes at 10.3125Gbps).
> > 
> > That being said, QUSGMII already exists to define a specific variant of
> > USGMII, so maybe adding 10G-QXGMII is fine...
> 
> Yes, Maxime, I agree with this solution, the name 10G-QXGMII is exactly
> the working mode of qca8084 quad phy mode.

FWIW, NXP has these 2 patches in its trees. One day I was going to make
an attempt at upstreaming them, but the Aquantia PHY driver is a bit of
a sticky topic since I could find no way to distinguish between the
single-port and multi-port variants of USXGMII in this PHY IP, and the
AQR412 uses a multi-port mode which is now treated as USXGMII by Linux.

Anyway, if you do make progress with this ahead of me, please be aware
that these patches exist, and I would appreciate if you tried to keep
the name as "10g-qxgmii" so that I don't have to modify the (downstream)
device trees again :)

From 8f4c8227362bb7acad09cd756390f1efd3311395 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 6 Oct 2023 23:42:35 +0300
Subject: [PATCH] net: dsa: felix: introduce phy-mode = "10g-qxgmii" to replace
 "usxgmii"

The "USXGMII" mode that the Felix switch ports support on LS1028A is not
quite USXGMII, it is defined by the USXGMII multiport specification
document as 10G-QXGMII. It uses the same signaling as USXGMII, but it
multiplexes 4 ports over the link, resulting in a maximum speed of 2.5G
per port.

This change is needed in preparation for the lynx-10g driver on LS1028A,
which will make a more clear distinction between usxgmii (supported on
lane 0) and 10g-qxgmii (supported on lane 1). These protocols have their
configuration in different PCCR registers (PCCRB vs PCCR9).

We touch the entire kernel side: the phylib core, phylink, the Felix
switch driver, the Lynx PCS and the AQR412 driver. The existing
LS1028A-QDS device trees will continue to work with "usxgmii", and will
be updated to "10g-qxgmii" as a separate patch.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../bindings/net/ethernet-controller.yaml         |  1 +
 Documentation/networking/phy.rst                  |  6 ++++++
 drivers/net/dsa/ocelot/felix.c                    |  1 +
 drivers/net/dsa/ocelot/felix.h                    |  3 ++-
 drivers/net/dsa/ocelot/felix_vsc9959.c            |  3 ++-
 drivers/net/pcs/pcs-lynx.c                        |  8 ++++++--
 drivers/net/phy/aquantia_main.c                   | 15 +++++++++++++++
 drivers/net/phy/phy-core.c                        |  1 +
 drivers/net/phy/phylink.c                         | 12 ++++++++++--
 include/linux/phy.h                               |  4 ++++
 include/linux/phylink.h                           |  1 +
 11 files changed, 49 insertions(+), 6 deletions(-)

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
 
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 9a3e5ec16972..17fa31b58be4 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1232,6 +1232,7 @@ static const u32 felix_phy_match_table[PHY_INTERFACE_MODE_MAX] = {
 	[PHY_INTERFACE_MODE_SGMII] = OCELOT_PORT_MODE_SGMII,
 	[PHY_INTERFACE_MODE_QSGMII] = OCELOT_PORT_MODE_QSGMII,
 	[PHY_INTERFACE_MODE_USXGMII] = OCELOT_PORT_MODE_USXGMII,
+	[PHY_INTERFACE_MODE_10G_QXGMII] = OCELOT_PORT_MODE_10G_QXGMII,
 	[PHY_INTERFACE_MODE_1000BASEX] = OCELOT_PORT_MODE_1000BASEX,
 	[PHY_INTERFACE_MODE_2500BASEX] = OCELOT_PORT_MODE_2500BASEX,
 };
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 1d4befe7cfe8..4cf849e5782f 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -12,8 +12,9 @@
 #define OCELOT_PORT_MODE_SGMII		BIT(1)
 #define OCELOT_PORT_MODE_QSGMII		BIT(2)
 #define OCELOT_PORT_MODE_2500BASEX	BIT(3)
-#define OCELOT_PORT_MODE_USXGMII	BIT(4)
+#define OCELOT_PORT_MODE_USXGMII	BIT(4) /* compatibility */
 #define OCELOT_PORT_MODE_1000BASEX	BIT(5)
+#define OCELOT_PORT_MODE_10G_QXGMII	BIT(6)
 
 struct device_node;
 
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 3c5509e75a54..8ae9c2e340ab 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -34,7 +34,8 @@
 					 OCELOT_PORT_MODE_QSGMII | \
 					 OCELOT_PORT_MODE_1000BASEX | \
 					 OCELOT_PORT_MODE_2500BASEX | \
-					 OCELOT_PORT_MODE_USXGMII)
+					 OCELOT_PORT_MODE_USXGMII | \
+					 OCELOT_PORT_MODE_10G_QXGMII)
 
 static const u32 vsc9959_port_modes[VSC9959_NUM_PORTS] = {
 	VSC9959_PORT_MODE_SERDES,
diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 7e1e8f61f043..f3ab17ef4e31 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -95,6 +95,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs,
 		lynx_pcs_get_state_2500basex(lynx->mdio, state);
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
@@ -151,6 +152,7 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 }
 
 static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
+				   phy_interface_t interface,
 				   const unsigned long *advertising,
 				   unsigned int neg_mode)
 {
@@ -158,7 +160,8 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 	int addr = pcs->addr;
 
 	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
-		dev_err(&pcs->dev, "USXGMII only supports in-band AN for now\n");
+		dev_err(&pcs->dev, "%s only supports in-band AN for now\n",
+			phy_modes(interface));
 		return -EOPNOTSUPP;
 	}
 
@@ -189,7 +192,8 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		}
 		break;
 	case PHY_INTERFACE_MODE_USXGMII:
-		return lynx_pcs_config_usxgmii(lynx->mdio, advertising,
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
 					       neg_mode);
 	case PHY_INTERFACE_MODE_10GBASER:
 	case PHY_INTERFACE_MODE_25GBASER:
diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 5fc93bbfbe49..4f5e6575be7b 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -512,6 +512,20 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
 		return 0;
 
+	/* Quad port PHYs like AQR412 have 4 system interfaces, but they can
+	 * also be used with a single system interface over which all 4 ports
+	 * are multiplexed (10G-QXGMII). To the MDIO registers, this mode is
+	 * indistinguishable from USXGMII (which implies a single 10G port),
+	 * which is problematic because the detection logic below would
+	 * overwrite phydev->interface with a wrong value. If the device tree
+	 * is configured for "10g-qxgmii", always trust that value, since it is
+	 * very unlikely that the PHY firmware was configured for protocol
+	 * switching depending on link speed (all USXGMII variants are capable
+	 * of symbol replication).
+	 */
+	if (phydev->interface == PHY_INTERFACE_MODE_10G_QXGMII)
+		goto skip_iface_detection;
+
 	val = phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS);
 	if (val < 0)
 		return val;
@@ -546,6 +560,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 		break;
 	}
 
+skip_iface_detection:
 	/* Read possibly downshifted rate from vendor register */
 	return aqr107_read_rate(phydev);
 }
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index cfa6f08d8ca3..95222680a82d 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -142,6 +142,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 1;
 	case PHY_INTERFACE_MODE_QSGMII:
 	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return 4;
 	case PHY_INTERFACE_MODE_PSGMII:
 		return 5;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3bf923f88494..dd0ac7139aa4 100644
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
@@ -284,6 +285,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 
 	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_2500SGMII:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return SPEED_2500;
 
 	case PHY_INTERFACE_MODE_5GBASER:
@@ -553,7 +555,11 @@ unsigned long phylink_get_capabilities(phy_interface_t interface,
 
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
@@ -969,6 +975,7 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_5GBASER:
 		case PHY_INTERFACE_MODE_25GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
+		case PHY_INTERFACE_MODE_10G_QXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_XLGMII:
@@ -1804,7 +1811,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
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
index 184b04422877..0eeeea50d9a2 100644
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
@@ -166,6 +167,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
 	PHY_INTERFACE_MODE_2500SGMII,
+	PHY_INTERFACE_MODE_10G_QXGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -289,6 +291,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "qusgmii";
 	case PHY_INTERFACE_MODE_2500SGMII:
 		return "sgmii-2500";
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


From a5dc53f7155bf7e7ced2fb520ccfa1b7d8875fbd Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 25 Oct 2023 14:34:49 +0300
Subject: [PATCH] arm64: dts: ls1028a-qds: replace "usxgmii" with "10g-qxgmii"
 for 13bb

The Felix switch actually supports the quad-port 10g-qxgmii variant of
usxgmii, so use that as the phy-mode in this device tree overlay.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
index f826392c23fa..509cf95026df 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
@@ -60,28 +60,28 @@
 	port@0 {
 		status = "okay";
 		phy-handle = <&slot2_qxgmii0>;
-		phy-mode = "usxgmii";
+		phy-mode = "10g-qxgmii";
 		managed = "in-band-status";
 	};
 
 	port@1 {
 		status = "okay";
 		phy-handle = <&slot2_qxgmii1>;
-		phy-mode = "usxgmii";
+		phy-mode = "10g-qxgmii";
 		managed = "in-band-status";
 	};
 
 	port@2 {
 		status = "okay";
 		phy-handle = <&slot2_qxgmii2>;
-		phy-mode = "usxgmii";
+		phy-mode = "10g-qxgmii";
 		managed = "in-band-status";
 	};
 
 	port@3 {
 		status = "okay";
 		phy-handle = <&slot2_qxgmii3>;
-		phy-mode = "usxgmii";
+		phy-mode = "10g-qxgmii";
 		managed = "in-band-status";
 	};
 };
-- 
2.34.1

