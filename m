Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CD7B6731
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbjJCLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:06:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41A9B;
        Tue,  3 Oct 2023 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GaXzZoipvnxCVI1GArmacT2FQhMefy+jlKRcH6UZtd8=; b=NwufeYsdaY1OhMFMKdSIwMXStP
        n2c4RGkyfcmfXF4VJ8D9D5QmNz6zjcxuSdw5XI/C/jOEfhBUkxBP6DURGl16lGlMdQPR/SOflie3I
        V19ehP9j52oEBwzjTCSxl6g53y/Sci01Kn7IhAGbhvA7GLP9lmZNFE9T7sPjoKfe7bbLy7I8/W4AP
        HqgoJMkFSSTsUbBCNhUcBt2+Cv82LmQMgWtyz0LBQc0oMcaGBXWuxlgyjsobVzMIrLGVwgkUGR1Aq
        /m3SQKiRmw9j5XJw0JA9tI3jL1ZUx0Sx4gqrE2HER5BhU7K3W8lO9PhX3hTXz1OUb9j8Q9+enuoVS
        H23iiI6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33198)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qndEI-0001Xy-32;
        Tue, 03 Oct 2023 12:06:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qndEI-0007oo-Vj; Tue, 03 Oct 2023 12:06:18 +0100
Date:   Tue, 3 Oct 2023 12:06:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 08/15] net: phylink: allow PCS to handle
 C73 autoneg for phy-mode = "internal"
Message-ID: <ZRv1qt7+WbQd457L@shell.armlinux.org.uk>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-9-vladimir.oltean@nxp.com>
 <20231002141743.lbmb66q22dmuyi6f@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002141743.lbmb66q22dmuyi6f@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Mon, Oct 02, 2023 at 05:17:43PM +0300, Vladimir Oltean wrote:
> Hi Russell,
> 
> On Sat, Sep 23, 2023 at 04:48:57PM +0300, Vladimir Oltean wrote:
> > Some phylink and phylib based systems might want to operate on backplane
> > media types ("K" in the name), and thus, picking a phy_interface_t for
> > them becomes a challenge.
> > 
> > phy_interface_t is a description of the connection between the MAC and
> > the PHY, or if a MAC-side PCS is present, the connection between that
> > and the next link segment (which can be remote).
> > 
> > A MAC-side PCS is so far considered to be a PCS handling link modes with
> > optional C37 autoneg. But C73 autoneg (for backplanes and SFP28 modules)
> > is not at the same level in the OSI layering, so that existing model may
> > or may not apply.
> > 
> > (a) If we say that the PCS is MAC-side for C73 modes as well, the
> >     implication seems to be that the phy-mode should be one of
> >     PHY_INTERFACE_MODE_10GBASEKR, PHY_INTERFACE_MODE_1000BASEKX, etc.
> >     Similar to PHY_INTERFACE_MODE_1000BASEX which imitates the link mode
> >     ETHTOOL_LINK_MODE_1000baseX_Full_BIT.
> > 
> > (b) If we say that the PCS is not MAC-side, but rather that the
> >     phylink_pcs represents an entire non-phylib backplane PHY which may
> >     negotiate one of many link modes (like a copper phylib PHY), then
> >     the phy-mode should probably be one of PHY_INTERFACE_MODE_XGMII,
> >     XLGMII etc. Or rather, because there is no MII pinout per se and the
> >     backplane PHY / phylink_pcs is internal, we can also use
> >     PHY_INTERFACE_MODE_INTERNAL.
> > 
> > The trouble with (a), in my opinion, is that if we let the phy_interface_t
> > follow the link mode like in the case of Base-X fiber modes, we have to
> > consider the fact that C73 PHYs can advertise multiple link modes, so
> > the phy_interface_t selection will be arbitrary, and any phy_interface_t
> > selection will have to leave in the "supported" and "advertised" masks
> > of link modes all the other backplane modes. This may be hard to justify.
> > 
> > That is the reasoning based on which I selected this phy-mode to
> > describe the setup in Layerscape SoCs which have integrated backplane
> > autoneg support. The changes in phylink permit the managed =
> > "in-band-status" fwnode property to be extended for C73 autoneg, which
> > is then controllable through ethtool. With phy-mode = "internal" in an
> > in-band autoneg mode, we advertise all backplane link modes. The list is
> > not exhaustive and may be extended in the future.
> > 
> > Link: https://lore.kernel.org/netdev/ZOXlpkbcAZ4okric@shell.armlinux.org.uk/
> > Link: https://lore.kernel.org/netdev/ZGIkGmyL8yL1q1zp@shell.armlinux.org.uk/
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v1->v2: patch is new
> > 
> >  drivers/net/phy/phylink.c | 19 ++++++++++++++++++-
> >  include/linux/phylink.h   |  1 +
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 548130d77302..88ace7e203c3 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -972,6 +972,21 @@ static int phylink_parse_mode(struct phylink *pl,
> >  			phylink_set(pl->supported, 100000baseDR2_Full);
> >  			break;
> >  
> > +		case PHY_INTERFACE_MODE_INTERNAL:
> > +			phylink_set(pl->supported, 1000baseKX_Full);
> > +			phylink_set(pl->supported, 10000baseKX4_Full);
> > +			phylink_set(pl->supported, 10000baseKR_Full);
> > +			phylink_set(pl->supported, 25000baseCR_Full);
> > +			phylink_set(pl->supported, 25000baseKR_Full);
> > +			phylink_set(pl->supported, 25000baseCR_S_Full);
> > +			phylink_set(pl->supported, 25000baseKR_S_Full);
> > +			phylink_set(pl->supported, 40000baseKR4_Full);
> > +			phylink_set(pl->supported, 50000baseKR2_Full);
> > +			phylink_set(pl->supported, 50000baseKR_Full);
> > +			phylink_set(pl->supported, 100000baseKR4_Full);
> > +			phylink_set(pl->supported, 100000baseKR2_Full);
> > +			break;

I wonder whether this should just set all link modes, much like
phylink_get_capabilities() allows.

I'm also wondering whether the contents of this switch() statement
should now just do:

		case PHY_INTERFACE_... (for each supported mode):
			cals = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
			caps = phylink_get_capabilities(interface, caps,
							RATE_MATCH_NONE);
			phylink_caps_to_linkmodes(pl->supported, caps);
			break;

rather than duplicating the logic.

That said, 10GBASER and 10GKR are treated slightly differently because
of the problem with PHYs like 88x3310, and I think it's now difficult
to undo that bit of history.

> > +
> >  		default:
> >  			phylink_err(pl,
> >  				    "incorrect link mode %s for in-band status\n",
> > @@ -1109,7 +1124,9 @@ static void phylink_mac_config(struct phylink *pl,
> >  
> >  static bool phylink_pcs_handles_an(phy_interface_t iface, unsigned int mode)
> >  {
> > -	return phy_interface_mode_is_8023z(iface) && phylink_autoneg_inband(mode);
> > +	return (phy_interface_mode_is_8023z(iface) ||
> > +		iface == PHY_INTERFACE_MODE_INTERNAL) &&
> > +	       phylink_autoneg_inband(mode);

Is this true also for DSA devices that use "internal" mode? I'm
wondering whether this will cause the PHY to be ignored/remain
unattached in DSA switches because of the changes in patch 7.

> >  }
> >  
> >  static void phylink_pcs_an_restart(struct phylink *pl)
> > diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> > index 2b886ea654bb..7e8e26001587 100644
> > --- a/include/linux/phylink.h
> > +++ b/include/linux/phylink.h
> > @@ -141,6 +141,7 @@ static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
> >  
> >  	case PHY_INTERFACE_MODE_1000BASEX:
> >  	case PHY_INTERFACE_MODE_2500BASEX:
> > +	case PHY_INTERFACE_MODE_INTERNAL:
> >  		/* 1000base-X is designed for use media-side for Fibre
> >  		 * connections, and thus the Autoneg bit needs to be
> >  		 * taken into account. We also do this for 2500base-X

Thinking about DSA cases, I don't think this change would be an issue
because where DSA uses "internal" there isn't a PCS, so this won't
matter.

Note that as there is now no need for anything outside phylink.c to
reference this function, I have plans at some point to move it into
the .c file rather than keeping it as an inline in the header file.
It was temporarily necessary while introducing it to be in the
header.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
