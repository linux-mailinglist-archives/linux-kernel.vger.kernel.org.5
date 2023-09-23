Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE47ABE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 08:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjIWG3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 02:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWG3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 02:29:16 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E11199;
        Fri, 22 Sep 2023 23:29:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D48A8240004;
        Sat, 23 Sep 2023 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695450547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYKxMWs4IYSp4v8IwL8Rv6AvQEg0lLABlatXJHEpLUE=;
        b=aFfH3nQq2NP8++kx2BHAMmWTJVGRmwOLd8eQEVFh4bo3x6zMqkJBR+rvQb9auvHG2hx7LH
        C9GKmy1wTvjXAkNJJXwqZdV+lPSPGozVw9GmSrjIurMYsZy0jt3gzr7HpQ/b3zSJK7jIaA
        CzpQ9ZpB5Uotg+gPpJsJ1j+rgfcfoj44j1kljvN9C+WB86VkWXAZojL3wZX8HSDkB/qxCH
        l+Jg332ArRtYyN6UsOitSEqNFpqFLQUIpFl5TJtqk1c0meGqSgHfYYwR+rAK5M0qVu/iT2
        wcMm32fRhzGEeeCXQ+7QgNfKSeAk/u3VTs/0eTm5TGyTrMFIktjfIzVLTeFvrw==
Message-ID: <5650a2a3-a36f-441e-b4c2-aa7c751b5af5@arinc9.com>
Date:   Sat, 23 Sep 2023 09:28:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] define and enforce phylink bindings
Content-Language: en-US
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <4856b212-5bc5-4783-a184-b34a4a915878@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2023 01:36, Andrew Lunn wrote:
>> I agree. My patch description here failed to explain the actual issue,
>> which is missing hardware descriptions. Here's what I understand. An
>> ethernet-controller is a MAC. For the MAC to work properly with its link
>> partner, at least one of these must be described:
>> - pointer to a PHY to retrieve link information from the PHY
>> - pointer to a PCS to retrieve link information from the PCS
>> - pointer to an SFP to retrieve link information from the SFP
>> - static link information
> 
> You are missing:
> 
> - The MAC has firmware driving the PHY, nothing for linux to do.
> 
> There are properties in ethernet-controller.yaml the MAC driver would
> however like to use such as local-mac-address, max-frame-size,
> nvmem-cell-names etc.

This is interesting. This is clearly a hardware difference of the ethernet
controller.

I believe this fits case 1. There's still an MDIO bus the ethernet
controller uses, there's still a PHY on the MDIO bus which the ethernet
controller uses. The only difference is the firmware of the ethernet
controller controls... What exactly does the firmware control that a Linux
driver would have controlled instead? Just configuring the link settings of
the MAC?

If it's just MAC link settings, I believe it would make sense to add a
property on the ethernet controller dt-bindings to state that the hardware
controls the MAC link settings on its own. This way, we would still
describe the MDIO bus and PHY of the ethernet controller while also
pointing out that the MAC link settings are not up to a driver to control.

Arınç
