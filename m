Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A307AA886
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjIVFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVFrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:47:37 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5782194;
        Thu, 21 Sep 2023 22:47:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50BE6FF806;
        Fri, 22 Sep 2023 05:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695361647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAps/X6vpxbgYNTDEh93GQiH1oj1Rsmu0/cgFBFZydk=;
        b=JCAnRGUxGP6RiaYQwdoP7kdNAst4L9X+DS9e3HJevQ2KWGPibSLAFiq8CzdWAtkGc4GcM8
        wmwEKyIECYyXH5JGqrZoE3u8VLuKAQ2rcXvuhAg7KNcXFoB+PyIMHXZHGSnHrzQrj+qPAB
        g8Z01S+FtsJLBXBDjHCW9SKJl5/joZ4NwO6EvQunGtrAv4dQJKmsxo56X8VKkRdWzZCaEU
        g7C8gTafjHaVzzrUu7ukYJZtVQf5kCytGKSWRhek6jLZMPqMycJTsw+aB7nXpRKgsxanTr
        0PctrJ6IOEEz64qxjLygVXUDzmWoK7zZC0aP8Pr5TZ1xSs4nkdDoI714+e5T6g==
Message-ID: <a87032fc-3ad5-4286-828e-77735475c2c5@arinc9.com>
Date:   Fri, 22 Sep 2023 08:47:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/10] dt-bindings: net: enforce phylink
 bindings on certain ethernet controllers
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
 <20230916110902.234273-8-arinc.unal@arinc9.com>
 <20230918181319.GA1445647-robh@kernel.org>
 <16710cf9-8911-4fed-8e2d-b19b581446c1@arinc9.com>
 <a8d49992-4fa8-4a9f-b954-79011a3040a8@lunn.ch>
 <85cc3b27-417e-4cf4-9f77-347a338c9d67@arinc9.com>
 <8935d431-be0c-43e0-a908-f7dff2048f7c@lunn.ch>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <8935d431-be0c-43e0-a908-f7dff2048f7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2023 02:29, Andrew Lunn wrote:
> On Thu, Sep 21, 2023 at 09:21:40PM +0300, Arınç ÜNAL wrote:
>> On 21.09.2023 16:00, Andrew Lunn wrote:
>>>> - Link descriptions must be required on ethernet controllers. We don't care
>>>>     whether some Linux driver can or cannot find the PHY or set up a fixed
>>>>     link without looking at the devicetree.
>>>
>>> That can lead to future surprises, and breakage.
>>>
>>> Something which is not used is not tested, and so sometimes wrong, and
>>> nobody knows. Say the driver is extended to a new device and actually
>>> does need to use this never before used information. You then find it
>>> is wrong, and you get a regression.
>>>
>>> We have had issues like this before. There are four rgmii phy-link
>>> modes. We have had PHY drivers which ignored one of those modes, it
>>> silently accepted it, but did not change the hardware to actually use
>>> that mode. The PHY continues to use its reset defaults or strapping,
>>> and it worked. A lot of device trees ended up using this mode. And it
>>> was not the same as reset defaults/strapping.
>>>
>>> And then somebody needed that fourth mode, and made it actually
>>> work. And all those boards wrongly using that mode broke.
>>>
>>> The lesson i learned from that episode is that anything in device tree
>>> must actually be used and tested.
>>
>> It looks like the root cause here was the lack of dt-bindings to
>> only allow the phy-mode values the hardware supports.
> 
> That would not help. The hardware supported all 4 RGMII modes. So
> listing all four in the dt-binding would be correct. But the driver
> for the hardware had a bug, and so silently ignored one of the
> modes. That then masked the bugs in board DT files.
> 
>> What I see here is the driver change should've been tested on all
>> different hardware the driver controls then the improper describing
>> of hardware on the devicetree source file addressed.
> 
> Which is what did happen. But it took a while to find all those broken
> boards.  For a period of time, we had regressions.
> 
> Bugs happen. It is a fact of life. But we want those bugs to be easy
> to find as possible. If we force DT writers to add properties which
> the driver never uses, they are going to be bugs in those
> properties. And those bugs are not going to be easy to find, and quite
> likely, they will only be found a long time after they are added. We
> should not be adding unused properties and bugs just to keep a yaml
> checker happy.

Understood. Then I will refrain from enforcing link descriptions altogether
as I can't justify enforcing them on ethernet controllers selectively
because certain Linux drivers don't make use of the link properties and may
expose bugs if used.

The link properties are still allowed for all ethernet controllers though,
just not enforced. But I suppose it's better to optionally find the bug
instead of causing a regression then finding the bug.

Arınç
