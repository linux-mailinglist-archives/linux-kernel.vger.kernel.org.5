Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2922A7AC437
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIWRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjIWRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:52:19 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC5136;
        Sat, 23 Sep 2023 10:52:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B91560002;
        Sat, 23 Sep 2023 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695491529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MHhj+mHJkpQWkiuvF+5NLMuTrzWJfhOnzIw/bOrX/g=;
        b=jDirt66ui1jeO6Hlu8+DPSb5+zHMG0NAm5TnbL3SXUkqMd2JwQi4ai1vnq5/X8Szk8Ne7z
        ENjPyW42YCD/CE9rQbsIG4H1UFUqoq3MajYpNOiPaA9PQhsRenN33jhzGldytorXAkGazx
        pzK3RAGNISijyoFuVO5djM8uZZu7umw/KSQ2/O0gZIVK3GA3yVHscBA3fn/TO70W3K9HdC
        4uOJXfqjDMG1UPOWg8w2m8UEfTzRUCy9deNdDY72BMM+TrepZ6NuVQoeSr/9HrWlkXdWAV
        h4H7TvpRvRpYoNxai0idxf4Frq+AljXkzEjzrY3S0xQefYMZ7Y3szYBj1IrTUA==
Message-ID: <228f24db-0a26-4d38-8f73-a9691262cc5f@arinc9.com>
Date:   Sat, 23 Sep 2023 20:51:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] define and enforce phylink bindings
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
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
 <4856b212-5bc5-4783-a184-b34a4a915878@lunn.ch>
 <5650a2a3-a36f-441e-b4c2-aa7c751b5af5@arinc9.com>
 <410dfe3c-6f99-4054-88f8-0acbd134cfce@lunn.ch>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <410dfe3c-6f99-4054-88f8-0acbd134cfce@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2023 18:12, Andrew Lunn wrote:
> On Sat, Sep 23, 2023 at 09:28:41AM +0300, Arınç ÜNAL wrote:
>> On 23.09.2023 01:36, Andrew Lunn wrote:
>>> You are missing:
>>>
>>> - The MAC has firmware driving the PHY, nothing for linux to do.
>>>
>>> There are properties in ethernet-controller.yaml the MAC driver would
>>> however like to use such as local-mac-address, max-frame-size,
>>> nvmem-cell-names etc.
>>
>> This is interesting. This is clearly a hardware difference of the ethernet
>> controller.
>>
>> I believe this fits case 1. There's still an MDIO bus the ethernet
>> controller uses, there's still a PHY on the MDIO bus which the ethernet
>> controller uses.
> 
> Why must there be an MDIO bus? All the bus provides is a communication
> channel to the PHY. There are PHYs which are memory mapped, or use
> I2C. SFP are a good example of I2C, which Linux maps to MDIO just to
> make things simple, but the hardware is I2C. Why must there be a PHY?
> Maybe it is a Base-K link, i.e. a baseboard link to a switch, or a BMC
> or something.

There's no requirement for an MDIO bus or a PHY. If the MAC is connected to
a PHY, only the PHY node needs to be described. The PHY can be controlled
by any interface, I2C, MDIO, or something else. If there's no PHY, the
fixed-link property would be used to describe the link.

> 
>> The only difference is the firmware of the ethernet
>> controller controls... What exactly does the firmware control that a Linux
>> driver would have controlled instead? Just configuring the link settings of
>> the MAC?
> 
> A MAC driver implements struct ethtool_ops:::get_link_settings and
> set_link_settings. For a MAC driver using phylib or phylink they
> typically then call into phylib or phylink to do the actual work,
> maybe with a bit of pre-processing in the MAC driver.
> 
> A MAC driver using firmware would typically make an RPC into the
> firmware to implement these calls.
> 
> There is a MAC driver currently under review which does not have a PHY
> at all. The MAC is directly connected to a switch, all within one
> IC. The link is always running at 5Gbps, the link is always up. It is
> physically impossible to connect a PHY, so get_link_settings just
> returns hard coded values.

The fixed-link property would be used to describe the link of the MAC here.

Arınç
