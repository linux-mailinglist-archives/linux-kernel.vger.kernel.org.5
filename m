Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DC7ABBC5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjIVWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:30:35 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B66CC1;
        Fri, 22 Sep 2023 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wZYS4SIazlL4yLt67u+h7u5cYygycIleSezsKF9ckU4=; b=U6wAd9Qv6IJQCRssJZ0iA7xgca
        neSADVDKHHfi1qscUU0PrKeVpqldeYIKdy7771wNytMogKp5rdRCsuVCmlrJSjKUCsDesH1rMJOgL
        I6tJLTiBXU/1dyNLuCHIQsvgQoqYgYqXktDLoX1ZY2NGJAts9iHTkEc82zXYfaidK4jXEs61BJ7rM
        nQWo15ctgaajczl4EHj1ypfGOq6qEtkOgjIe8MQDoGg4aO0hlmG2fjsniyZOBheTkb0cNH7+6uhW9
        FMg01z+TECGCiOVfrMfg87qdcwGs9waEnSQlaemuVaq93ug3DknWtfCXWjmuMVjyHM9jkkQv/boPo
        gQjaXTjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60764)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qjoeM-00075C-0T;
        Fri, 22 Sep 2023 23:29:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qjoeC-0004wu-Nh; Fri, 22 Sep 2023 23:29:16 +0100
Date:   Fri, 22 Sep 2023 23:29:16 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Crispin <john@phrozen.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/10] define and enforce phylink bindings
Message-ID: <ZQ4VPEuXB3+e48Qs@shell.armlinux.org.uk>
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <ZQ2LMe9aa1ViBcSH@shell.armlinux.org.uk>
 <6c1bb7df-34cd-4db9-95b6-959c87b68588@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c1bb7df-34cd-4db9-95b6-959c87b68588@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 12:57:52AM +0300, Arınç ÜNAL wrote:
> On 22/09/2023 15:40, Russell King (Oracle) wrote:
> > On Sat, Sep 16, 2023 at 02:08:52PM +0300, Arınç ÜNAL wrote:
> > > Hello there.
> > > 
> > > This patch series defines phylink bindings and enforces them for the
> > > ethernet controllers that need them.
> > > 
> > > Some schemas had to be changed to properly enforce phylink bindings for all
> > > of the affected ethernet controllers. Some of the documents of these
> > > ethernet controllers were non json-schema, which had to be converted.
> > > 
> > > I will convert the remaining documents to json-schema while this patch
> > > series receives reviews.
> > 
> > I can't say that I'm comfortable with this. We appear to be defining
> > bindings based on software implementation, and a desire for the DT
> > tooling to enforce what the software implementation wants. Isn't this
> > against the aims of device tree and device tree binding documentation?
> > Seems to me like feature-creep.
> > 
> > The bindings that phylink parses are already documented in the
> > ethernet controller yaml document. Specifically:
> > 
> > - phylink does not parse the phy-mode property, that is left to the
> >    implementation to pass to phylink, which can implement it any
> >    which way they choose (and even default to something.)
> > 
> > - phylink does not require a phy property - phylink does expect a PHY
> >    to be attached, but how that PHY is attached is up to the ethernet
> >    controller driver. It may call one of the phylink functions that
> >    parses the phy property, or it may manually supply the phy device to
> >    phylink. Either way, phylink does not itself require a PHY property.
> > 
> > - phylink does not require a sfp property - this obviously is optional.
> > 
> > So, all in all, ethernet-controller already describes it, and to create
> > a DT binding document that pretends that phylink requires any of this
> > stuff is, in my mind, wrong.
> > 
> > DSA requires certain properties by dint of the parsing and setup of
> > phylink being in generic code - this is not because phylink requires
> > certain properties, but phylink does require certain information in
> > order to function correctly.
> > 
> > The issue here is _how_ phylink gets that information, and as I state
> > above, it _can_ come from DT, but it can also be given that information
> > manually.
> > 
> > As an example, there are plenty of drivers in the tree which try to
> > parse a phy node, and if that's not present, they try to see if a PHY
> > exists at a default# bus address.
> > 
> > We seem to be digging outselves a hole here, where "phylink must have
> > these properties". No, that is wrong.
> 
> I agree. My patch description here failed to explain the actual issue,
> which is missing hardware descriptions. Here's what I understand. An
> ethernet-controller is a MAC. For the MAC to work properly with its link
> partner, at least one of these must be described:
> - pointer to a PHY to retrieve link information from the PHY
> - pointer to a PCS to retrieve link information from the PCS
> - pointer to an SFP to retrieve link information from the SFP
> - static link information

What about something like macb? The macb driver:
- attempts to connect a phy using phylink_of_phy_connect()
- if that fails, and there is no phy-handle property, then the driver
  will attempt to find the first PHY to exist on its MII bus, and will
  connect that using phylink_connect_phy().

So, in this case, if we define a phylink binding to require one of a
phy-handle node, pcs node, sfp node or static link information, then
although macb uses phylink, it then doesn't conform to this phylink
binding. (This is the only driver that uses phy_find_first() which
also uses phylink according to my greps, but I haven't checked for
any other games drivers be using.)

The same thing more or less happens with non-phylink drivers. Take a
look at drivers/net/ethernet/microchip/lan743x_main.c, and notice
that it first attempts to get a PHY from DT. If that fails, it
uses phy_find_first(). If that fails, and we have a LAN7431, then
a gigabit full-duplex fixed-link PHY is used instead. So, what macb
is doing with phylink is no different from what other drivers are
doing with phylib - and it's the driver's choice.

The same way that there are multiple drivers that don't do this,
which want a PHY device to be specified in DT if the driver was
bound to a device that was described in DT - there are phylink
and non-phylink drivers that do this.

This is exactly my point - there is *no* *such* *thing* as a phylink
binding. There is the ethernet-controller binding, which phylink
provides the ability for network drivers to optionally use, but
phylink doesn't require anything from any firmware description, except
to attach a SFP interface, or to describe a fixed-link. Everything else
is really up to the ethernet-controller aka MAC driver to decide how it
wants to deal with things.

We currently work around this by the ethernet-controller YAML having
all these properties as optional. Maybe some drivers extend that YAML
and require certain properties - that is their perogative, but that is
the driver's choice, and is a completely separate issue to whether
the driver is using phylink or not.

The real question is how do we want to describe an ethernet controller
and what properties should we be requiring for it (if any). Maybe if we
want to require one of a PHY, PCS, SFP, or fixed-link, maybe we should
have that as a strictly-checked ethernet controller which drivers can
opt into using if that's what they require.

However, to dress this up as "phylink requires xyz, so lets create
a phylink binding description" is just wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
