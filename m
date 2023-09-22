Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF937ABB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjIVV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIVV61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:58:27 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F8197;
        Fri, 22 Sep 2023 14:58:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E790240002;
        Fri, 22 Sep 2023 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695419898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YVTZcfReib7t/7pkUyxikgIMHTHiQw2lUN/ib+i8mE=;
        b=Ja/5fpeT5o5akQ0s5PhqFJUDY6DQ7QeszgvhChp7+woMQdUgGJW0GPwQA0aCTTG1OGy9Hb
        +1p6OYpCKg7g/jxXASbU6FMY0XJsjosnVSVh1i+y1bWLDL2msdeQe7ZdQcxP++36sYwLcn
        tu11yHNRFvgPiyIdH14mXaKjcyzntmp0K2kg7QiHYToaPwIcWvVSqBH3jFdn8CdJyFjfpj
        tdeVDShAPsGMOZmtAe0mhghv1EuT8kYzBSy2d6Hhvwx7EMpIaemtl9DdmnIBVGTTnTagzY
        P+X0gsJTPfggsQk9zBywEZD5TRUEFOcRSr2PWM1Vn94oEDspzq6M+iHqMcF9Xw==
Message-ID: <6c1bb7df-34cd-4db9-95b6-959c87b68588@arinc9.com>
Date:   Sat, 23 Sep 2023 00:57:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] define and enforce phylink bindings
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZQ2LMe9aa1ViBcSH@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 15:40, Russell King (Oracle) wrote:
> On Sat, Sep 16, 2023 at 02:08:52PM +0300, Arınç ÜNAL wrote:
>> Hello there.
>>
>> This patch series defines phylink bindings and enforces them for the
>> ethernet controllers that need them.
>>
>> Some schemas had to be changed to properly enforce phylink bindings for all
>> of the affected ethernet controllers. Some of the documents of these
>> ethernet controllers were non json-schema, which had to be converted.
>>
>> I will convert the remaining documents to json-schema while this patch
>> series receives reviews.
> 
> I can't say that I'm comfortable with this. We appear to be defining
> bindings based on software implementation, and a desire for the DT
> tooling to enforce what the software implementation wants. Isn't this
> against the aims of device tree and device tree binding documentation?
> Seems to me like feature-creep.
> 
> The bindings that phylink parses are already documented in the
> ethernet controller yaml document. Specifically:
> 
> - phylink does not parse the phy-mode property, that is left to the
>    implementation to pass to phylink, which can implement it any
>    which way they choose (and even default to something.)
> 
> - phylink does not require a phy property - phylink does expect a PHY
>    to be attached, but how that PHY is attached is up to the ethernet
>    controller driver. It may call one of the phylink functions that
>    parses the phy property, or it may manually supply the phy device to
>    phylink. Either way, phylink does not itself require a PHY property.
> 
> - phylink does not require a sfp property - this obviously is optional.
> 
> So, all in all, ethernet-controller already describes it, and to create
> a DT binding document that pretends that phylink requires any of this
> stuff is, in my mind, wrong.
> 
> DSA requires certain properties by dint of the parsing and setup of
> phylink being in generic code - this is not because phylink requires
> certain properties, but phylink does require certain information in
> order to function correctly.
> 
> The issue here is _how_ phylink gets that information, and as I state
> above, it _can_ come from DT, but it can also be given that information
> manually.
> 
> As an example, there are plenty of drivers in the tree which try to
> parse a phy node, and if that's not present, they try to see if a PHY
> exists at a default# bus address.
> 
> We seem to be digging outselves a hole here, where "phylink must have
> these properties". No, that is wrong.

I agree. My patch description here failed to explain the actual issue,
which is missing hardware descriptions. Here's what I understand. An
ethernet-controller is a MAC. For the MAC to work properly with its link
partner, at least one of these must be described:
- pointer to a PHY to retrieve link information from the PHY
- pointer to a PCS to retrieve link information from the PCS
- pointer to an SFP to retrieve link information from the SFP
- static link information

Andrew under the discussion of patch 7 said that enforcing this may expose
bugs on MAC drivers that never looked at the devicetree to control the
MAC's link which would cause regressions, implying we should hold back on
enforcing it. I've agreed not to enforce it, not because it is incorrect
description of ethernet controller hardware - I think it is correct - but
because I won't be the one to deal with the regressions when this
dt-bindings change goes through.

I won't also enforce it selectively, as saying "these drivers use
phylink_fwnode_phy_connect() therefore there won't be any bad surprises on
the hardware they control so let's enforce it only for them" is nonsense in
the context of describing hardware.

I will focus on documenting the missing MDIO bus descriptions on certain
ethernet switches and converting ethernet switch documents (maybe ethernet
controllers too) to json-schema. There's the incorrect link descriptions on
dsa-port.yaml as confirmed by Vladimir on the discussion of v1 series so
I'll fix that.

I've also got some ethernet controller rules that I think won't break any
driver so I will submit them as well.

Arınç
