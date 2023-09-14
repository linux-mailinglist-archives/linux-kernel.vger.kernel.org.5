Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E267A0A81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjINQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjINQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:12:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3801FD6;
        Thu, 14 Sep 2023 09:12:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad8a822508so151937366b.0;
        Thu, 14 Sep 2023 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694707950; x=1695312750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SThObeQlIaemVPSCk4ah7fqYpyLQMYXbP7Z15PryLj0=;
        b=O2AWI2dIB+ylQ5iAEdz8Y0teCrDLileC+hoBn9/pTf9DYCFEERJrSxIGa+MV6FfCil
         4eMvk+oDFKAeLkKgESN2YJJC93tDwRbDH0sdqc/aVgun+HREcqc4YyEFSF44JZr7fJX5
         xoUQHF9P8JejgF82Q5BMCMi0JMe6jL2j96yjuN3eS7QivgtoKrrTjN4qioaDeseVP02F
         msizHTMu/fnsE3WDfw5SFkhTGvYYZx02d2IHb4xioX+CQQIk4Hwngx9eBhvX29T/6x+9
         maZU9w9sT7CpAxgHNuask6xrr6G//WxERiHstIgOiyh2EzZtJx76UFqVF8wVwUYB6gOV
         TKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707950; x=1695312750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SThObeQlIaemVPSCk4ah7fqYpyLQMYXbP7Z15PryLj0=;
        b=R0iXEK0JoFKYMSz/uFIcqDF/0Z9l0/oWkSKDgwK5mHUbQ4N2DZv5UxPtaWMAo7fhFb
         Frt8LSoU5KE0xeCzFe1EWTPBD2H7Cci5i2u+HADlb7kJ3DcTqrJj5FHvcD8U31TB80YH
         Wa9LpWAo0ORcF7+dDIaEYY9uY589LLP/yugz4QXGVDvn1pHB7aaJje+YPKM6DejhY0In
         0khE0g69aI5GOS++zC2Uw59gVbJcUqu2zjQ4282tPMsRNpGJ6HFvMSq+Mw5xNDtdGORu
         rQMQcRDSORoIM+jrqQ1wRzQ/Z28ckKfFLz/x7FuiyuUQWhw6QYGSUZZt36SBQNLN3SsT
         SMQw==
X-Gm-Message-State: AOJu0YzwyZoF/Errt9oDuPq0B66loAwXNg8QRouRG96Gma1axEPTnIP6
        9bF2f09aT2RJV+Dg1wmtybY=
X-Google-Smtp-Source: AGHT+IELqO4SvOWFV2/pKbLA0g4UVTZ7AbMewT+KnbWAN1uC7xCJlW08XIvsVg3T7S+uvgq7bq1bMA==
X-Received: by 2002:a17:906:7692:b0:9a2:739:3aa1 with SMTP id o18-20020a170906769200b009a207393aa1mr5162206ejm.61.1694707949815;
        Thu, 14 Sep 2023 09:12:29 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b009a193a5acffsm1179235ejc.121.2023.09.14.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:12:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 19:12:26 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230914161226.563423jjeuywfe57@skbuf>
References: <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
 <ZQHcV5DUfcCYkkTi@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQHcV5DUfcCYkkTi@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:59:19PM +0100, Russell King (Oracle) wrote:
> However, phylink pretty much requires phy-mode to be specified to be
> something sane for shared ports, so I wouldn't be in favour of relaxing
> the checkinng in dsa_shared_port_validate_of()... not unless you're
> now going to accept the approach I originally proposed to have DSA
> drivers tell the core (and thus phylink) what phy-mode and other link
> parameters should be used when they are missing from DT.

Ok, so with a missing phy-mode on the CPU port, phylink_parse_fixedlink() ->
phy_lookup_setting() will return NULL and that will print a phylink_warn(),
but other than that, phylink_mac_link_up() does get called at the right
speed and duplex.

I agree that for sane behavior it should be specified, but it appears
that even with PHY_INTERFACE_MODE_NA something can be hacked up...

[    4.818368] sja1105 spi0.1: Failed to read phy-mode or phy-interface-type property for port 4
[    4.864667] sja1105 spi0.1: OF node /soc/spi@2100000/ethernet-switch@1/ports/port@4 of CPU port 4 lacks the required "phy-mode" property
[    4.882957] sja1105 spi0.1: pl->link_config.speed 1000 pl->link_config.duplex 1 pl->supported 00,00000000,00000000,00000240
[    4.894189] sja1105 spi0.1: phy_setting speed -1 duplex -1 bit -1
[    4.900283] sja1105 spi0.1: fixed link full duplex 1000Mbps not recognised
[    4.907798] sja1105 spi0.1: configuring for fixed/ link mode
[    4.916183] sja1105 spi0.1 swp5 (uninitialized): PHY [mdio@2d24000:06] driver [Broadcom BCM5464] (irq=POLL)
[    4.934770] sja1105 spi0.1 swp2 (uninitialized): PHY [mdio@2d24000:03] driver [Broadcom BCM5464] (irq=POLL)
[    4.951619] sja1105 spi0.1 swp3 (uninitialized): PHY [mdio@2d24000:04] driver [Broadcom BCM5464] (irq=POLL)
[    4.968349] sja1105 spi0.1 swp4 (uninitialized): PHY [mdio@2d24000:05] driver [Broadcom BCM5464] (irq=POLL)
[    4.984017] fsl-gianfar soc:ethernet@2d90000 eth2: entered promiscuous mode
[    4.991327] DSA: tree 0 setup
[    4.995129] sja1105 spi0.1: sja1105_mac_link_up: port 4 interface  speed 1000 duplex 1
[    5.005004] sja1105 spi0.1: Link is Up - 1Gbps/Full - flow control off

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
index 1ea32fff4120..0bfffcb51af9 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts
@@ -90,7 +90,7 @@ port@3 {
 			port@4 {
 				/* Internal port connected to eth2 */
 				ethernet = <&enet2>;
-				phy-mode = "rgmii";
+//				phy-mode = "rgmii";
 				rx-internal-delay-ps = <0>;
 				tx-internal-delay-ps = <0>;
 				reg = <4>;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index a23d980d28f5..dba1fa545a9c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -327,6 +327,8 @@ static int sja1105_init_mii_settings(struct sja1105_private *priv)
 			mii->xmii_mode[i] = XMII_MODE_SGMII;
 			mii->special[i] = true;
 			break;
+		case PHY_INTERFACE_MODE_NA:
+			break;
 unsupported:
 		default:
 			dev_err(dev, "Unsupported PHY mode %s on port %d!\n",
@@ -1205,11 +1207,10 @@ static int sja1105_parse_ports_node(struct sja1105_private *priv,
 		/* Get PHY mode from DT */
 		err = of_get_phy_mode(child, &phy_mode);
 		if (err) {
-			dev_err(dev, "Failed to read phy-mode or "
+			dev_warn(dev, "Failed to read phy-mode or "
 				"phy-interface-type property for port %d\n",
 				index);
-			of_node_put(child);
-			return -ENODEV;
+			phy_mode = PHY_INTERFACE_MODE_NA;
 		}
 
 		phy_node = of_parse_phandle(child, "phy-handle", 0);
@@ -1383,6 +1384,8 @@ static void sja1105_mac_link_up(struct dsa_switch *ds, int port,
 {
 	struct sja1105_private *priv = ds->priv;
 
+	dev_err(ds->dev, "%s: port %d interface %s speed %d duplex %d\n", __func__, port, phy_modes(interface), speed, duplex);
+
 	sja1105_adjust_port_config(priv, port, speed);
 
 	sja1105_inhibit_tx(priv, BIT(port), false);
@@ -1414,7 +1417,10 @@ static void sja1105_phylink_get_caps(struct dsa_switch *ds, int port,
 		 * config (the xMII Mode table cannot be dynamically
 		 * reconfigured), and we have to program that early.
 		 */
-		__set_bit(phy_mode, config->supported_interfaces);
+		if (phy_mode == PHY_INTERFACE_MODE_NA)
+			phy_interface_set_rgmii(config->supported_interfaces);
+		else
+			__set_bit(phy_mode, config->supported_interfaces);
 	}
 
 	/* The MAC does not support pause frames, and also doesn't
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..674689011059 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -841,6 +841,15 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 	if (autoneg)
 		phylink_set(pl->supported, Autoneg);
 
+	phylink_err(pl, "pl->link_config.speed %d pl->link_config.duplex %d pl->supported %*pb\n",
+		    pl->link_config.speed, pl->link_config.duplex, __ETHTOOL_LINK_MODE_MASK_NBITS,
+		    pl->supported);
+
+	phylink_err(pl, "phy_setting speed %d duplex %d bit %d\n",
+		    s ? s->speed : -1,
+		    s ? s->duplex : -1,
+		    s ? s->bit : -1);
+
 	if (s) {
 		__set_bit(s->bit, pl->supported);
 		__set_bit(s->bit, pl->link_config.lp_advertising);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5f01bd4f9dec..34e5dc48f0ff 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1927,6 +1927,16 @@ static const char * const dsa_switches_apply_workarounds[] = {
 #if IS_ENABLED(CONFIG_NET_DSA_SMSC_LAN9303_I2C)
 	"smsc,lan9303-i2c",
 #endif
+	"nxp,sja1105e",
+	"nxp,sja1105t",
+	"nxp,sja1105p",
+	"nxp,sja1105q",
+	"nxp,sja1105r",
+	"nxp,sja1105s",
+	"nxp,sja1110a",
+	"nxp,sja1110b",
+	"nxp,sja1110c",
+	"nxp,sja1110d",
 	NULL,
 };
 
