Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE227ABEA7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjIWHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIWHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:52:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDED11D;
        Sat, 23 Sep 2023 00:52:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AAA7E0006;
        Sat, 23 Sep 2023 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695455521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzR1Tm71WW1g2sGVPubeL8o1clYwaCbl99rSURcNlMg=;
        b=dYHJFSuZO9hNBOYgJEl3TTcTTG+FObNVnjlqb+2tW/JG0oz12VSmtx9+bnnM1FzrME7MTn
        4FTiNevh8bhild2bQnXJaleFnQJ46R7S8YmC25MvgjlZ56ODzuSPwMCnHXaRFYP1arRpIT
        jcGKbf6RWm1xnxzNYPfPKNGUFIWu7wD+JoOpr9YeYd9ITG1W6xCYkiGCaER1AA3p25xW+3
        1tCTFzOgV8doTsumiW8Geh23guBnl97RC5+ZVzo3BS/hm9A2D7q/DntjBvV4J6F3i0ifFR
        GpaX8gEY4QAbepe0nE2iAq5YEWNiuTSMWjAFfeBTGeT0VrZ5y+oh6lUogOTqzg==
Message-ID: <63649fb5-6dc7-4e63-906d-c3e04aafcc4e@arinc9.com>
Date:   Sat, 23 Sep 2023 10:51:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] define and enforce phylink bindings
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
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
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <ZQ2LMe9aa1ViBcSH@shell.armlinux.org.uk>
 <6c1bb7df-34cd-4db9-95b6-959c87b68588@arinc9.com>
 <ZQ4VPEuXB3+e48Qs@shell.armlinux.org.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZQ4VPEuXB3+e48Qs@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2023 01:29, Russell King (Oracle) wrote:
> On Sat, Sep 23, 2023 at 12:57:52AM +0300, Arınç ÜNAL wrote:
>> I agree. My patch description here failed to explain the actual issue,
>> which is missing hardware descriptions. Here's what I understand. An
>> ethernet-controller is a MAC. For the MAC to work properly with its link
>> partner, at least one of these must be described:
>> - pointer to a PHY to retrieve link information from the PHY
>> - pointer to a PCS to retrieve link information from the PCS
>> - pointer to an SFP to retrieve link information from the SFP
>> - static link information
> 
> What about something like macb? The macb driver:
> - attempts to connect a phy using phylink_of_phy_connect()
> - if that fails, and there is no phy-handle property, then the driver
>    will attempt to find the first PHY to exist on its MII bus, and will
>    connect that using phylink_connect_phy().
> 
> So, in this case, if we define a phylink binding to require one of a
> phy-handle node, pcs node, sfp node or static link information, then
> although macb uses phylink, it then doesn't conform to this phylink
> binding. (This is the only driver that uses phy_find_first() which
> also uses phylink according to my greps, but I haven't checked for
> any other games drivers be using.)
> 
> The same thing more or less happens with non-phylink drivers. Take a
> look at drivers/net/ethernet/microchip/lan743x_main.c, and notice
> that it first attempts to get a PHY from DT. If that fails, it
> uses phy_find_first(). If that fails, and we have a LAN7431, then
> a gigabit full-duplex fixed-link PHY is used instead. So, what macb
> is doing with phylink is no different from what other drivers are
> doing with phylib - and it's the driver's choice.
> 
> The same way that there are multiple drivers that don't do this,
> which want a PHY device to be specified in DT if the driver was
> bound to a device that was described in DT - there are phylink
> and non-phylink drivers that do this.
> 
> This is exactly my point - there is *no* *such* *thing* as a phylink
> binding. There is the ethernet-controller binding, which phylink
> provides the ability for network drivers to optionally use, but
> phylink doesn't require anything from any firmware description, except
> to attach a SFP interface, or to describe a fixed-link. Everything else
> is really up to the ethernet-controller aka MAC driver to decide how it
> wants to deal with things.
> 
> We currently work around this by the ethernet-controller YAML having
> all these properties as optional. Maybe some drivers extend that YAML
> and require certain properties - that is their perogative, but that is
> the driver's choice, and is a completely separate issue to whether
> the driver is using phylink or not.
> 
> The real question is how do we want to describe an ethernet controller
> and what properties should we be requiring for it (if any). Maybe if we
> want to require one of a PHY, PCS, SFP, or fixed-link, maybe we should
> have that as a strictly-checked ethernet controller which drivers can
> opt into using if that's what they require.

I'd like to make this clear. We're only talking about deviating from proper
devicetree bindings so that it won't cause too much work or not at all to
fix the incorrect Linux driver policies.

As long as we don't collectively agree on fixing the drivers to work with
proper devicetree bindings, I'd keep the missing ethernet controller
bindings (requiring at least one of PHY, PCS, SFP, fixed-link) as they
currently are on ethernet-controller.yaml, optional. Or rather, I wouldn't
touch anything regarding this as it's nonsensical to change devicetree
bindings because of driver policies.

As you have pointed out with certain examples, once the driver starts
operating out of what the devicetree says, in other words, once the driver
starts guessing the hardware, there's no guarantee it will always guess it
correctly. As seen with the macb driver, the driver assumes that if there's
no phy-handle property, the PHY on its MDIO bus must be used regardless.
But the MAC may be connected to another MAC, PCS or SFP, meaning it doesn't
use the PHY on that bus.

There is also a case for DSA. If there's an implication that the DSA
controlled switch has an MDIO bus (phy_read() and phy_write()), the DSA
driver will connect the switch MACs to the PHYs on the MDIO bus of the
switch, even if there's no description of that MDIO bus on the devicetree.
As unlikely as it is on a real life scenario, there may be a device that
has its switch MACs wired to the PHYs on another MDIO bus.

This is why I've proposed to make the drivers strictly follow what the
devicetree says.

> 
> However, to dress this up as "phylink requires xyz, so lets create
> a phylink binding description" is just wrong.

Agreed.

Arınç
