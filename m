Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA475C065
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGUHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:50:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2A273C;
        Fri, 21 Jul 2023 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HOiv+39EOXGpElZBXI8YgqXUZyvnMCEbsPfiee135uY=; b=RBp85clNByjxwHzfoqKSuFnxxx
        7cxPu1xhm0BdOZm8YD1Z+MUoviUoZT4Qym4uRVqJvi2Th71naE1H/gpTHyLaGfY91BSIfAERjaNiu
        OziGSWUhFZcD1fpskYH62YljGekFoFaeUscjcCxlLqz1tWEQtCBcXtB3lawXamH3fFuoc6/BVs26P
        vz6KhNNi07+HtgNqqBonivL1YqyHAHNtq1jtbYWspdPgk7vlgVHdial79r1zDhDLvUCOJfR/cV1iI
        P31qHdNniS+mzXAau9K28EjUvzMdM7vSiryJZCHTWgDtROuJrsJuyNjlsPPvb7R7NewrN24uU1ZpU
        lK8mMaeA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41390)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qMku7-0003Nh-1J;
        Fri, 21 Jul 2023 08:50:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qMku6-0005wi-B5; Fri, 21 Jul 2023 08:50:22 +0100
Date:   Fri, 21 Jul 2023 08:50:22 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 2/2] net: sfp: add quirk for FS's DAC10G SFP
 (SFPP-PC01)
Message-ID: <ZLo4vvAPXNy51ZRi@shell.armlinux.org.uk>
References: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
 <20230721060057.2998-3-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721060057.2998-3-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:30:57AM +0530, Raju Lakkaraju wrote:
> Add a quirk for a DAC10G SFP that identifies itself as "FS" "SFPP-PC01".
> Add a quirk to enable the SGMII interface, modes 2500base-T, 1000base-T,
> 100base-T/Full and 100base-T/Half support.
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/phy/sfp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index ee049efdf71b..80d2680f08ab 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -421,6 +421,18 @@ static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
>  	sfp_quirk_disable_autoneg(id, modes, interfaces);
>  }
>  
> +static void sfp_quirk_fs_dac(const struct sfp_eeprom_id *id,
> +			     unsigned long *modes,
> +			     unsigned long *interfaces)
> +{
> +	/* Fiberstore(FS)'s DAC SFP (SFPP-PC01) */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, modes);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, modes);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, modes);

No. A DAC cable does _not_ give you twisted-pair ethernet which is what
baseT linkmodes are.

The description on fs.com states:

"The 10G SFP+ Passive Direct Attach Copper Twinax Cable is designed for
use in 10GBASE Ethernet."

That means it supports 10GBASE-CR, which is the link mode for 10 Gigabit
ethernet over a direct attach cable.

If it does work at 2.5G speeds, then the protocol that will be used for
that will be 2500base-X.

If it does work at 1G speeds, then the protocol that will be used for
that will be 1000base-X (which is the "standard" protocol for the host
connection for 1G SFPs.)

Going below that isn't technically possible, but can be done with SGMII
by forcing the link settings, but is there really any need to support
slower speeds? What possible valid reason could there be? A host not
supporting 1G speeds with a SFP cage would be utterly insane.

> +	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);

I also disagree with this. Unless there is a PHY present, you can _not_
connect two hosts together that are using the SGMII protocol. The SGMII
"negotiation" protocol is _asymetric_, and it relies upon a PHY telling
the host what the link speed and duplex settings are. A host never
sends that information, so this will not "negotiate".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
