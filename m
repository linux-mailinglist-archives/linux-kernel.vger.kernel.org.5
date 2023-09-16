Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D38A7A311C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjIPPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjIPPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:31:02 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C74CE8;
        Sat, 16 Sep 2023 08:30:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC3C8C0003;
        Sat, 16 Sep 2023 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694878253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNzjBvEdjVLIfZXjhwvUmOo9cBIhI+ah064hJXymrS0=;
        b=XelGTaolNJmnpe83jTCntCcgiRnplsFx18gQ0m1m920W/83H3auR3EqLSI29RuovlUfm/V
        VwKTF44wM+z8mX1yxBPlUy14aUVq5oF9z+FGwpth5iH2NG8/DfzKlic+7vllRWI5Zg+ero
        kGwOXqeK+ESrcQZrc4ONd+vpmap76/mCBOAbGgRN0ErUa5phiJwZfxOMi/dN+JpZITb9ek
        66cPtW8p4GO5AEIRc9S4XJbtKZJOL86pCEOa8y3LTZ3a3FxgK1JJ85CLvmFy0AQ5KBpM9M
        vP9EUgcK9IdByP5RO2vJ3Y8XWnnQ7yKZcD/Rtytzt7vSoY5yKkhmTLZuL1BEaQ==
Message-ID: <abc22fea-893f-4f5b-822c-e69cd32788a1@arinc9.com>
Date:   Sat, 16 Sep 2023 18:30:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/10] dt-bindings: net: dsa: define MDIO bus
 child node
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <20230916110902.234273-6-arinc.unal@arinc9.com>
 <445beba8-2499-44a3-9c36-b9ec761121fb@lunn.ch>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <445beba8-2499-44a3-9c36-b9ec761121fb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2023 17:11, Andrew Lunn wrote:
> On Sat, Sep 16, 2023 at 02:08:57PM +0300, Arınç ÜNAL wrote:
>> Some DSA subdrivers register the MDIO bus of the switch they control. Or
>> let the DSA driver register the MDIO bus. The node for these buses are
>> either required or optional, depending on the subdriver. Document this on
>> all of the affected DSA switch schemas.
>>
>> The attributes of a DSA subdriver that lets the DSA driver register the
>> bus:
>> - ds->ops->phy_read() and ds->ops->phy_write() are present.
>> - ds->slave_mii_bus is not populated by the DSA subdriver.
>> - The bus is registered non-OF-based or OF-based. Registered OF-based if
>>    "mdio" child node is defined.
>>
>> The affected DSA switch schemas are documented below.
>>
>> - brcm,b53.yaml
>>
>> drivers/net/dsa/b53/b53_common.c:
>> - The DSA subdriver lets the DSA driver register the bus.
>>
>> ---
> 
> git uses --- to separate the commit message from additional comments
> for the reviewers. Anything after the --- will not be merged. Is that
> your intention?

No, they're vital information. I'll find something better to separate them,
thanks.

Arınç
