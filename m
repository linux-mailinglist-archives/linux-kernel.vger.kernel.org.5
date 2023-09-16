Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8567A315A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjIPQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIPQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:16:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C4CC0;
        Sat, 16 Sep 2023 09:16:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A761F20004;
        Sat, 16 Sep 2023 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694880962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3gR3DLgOcVXEyCHmeRvHW5kTpbx/Ml5B4FTcTxP2j0o=;
        b=dlTg8bzB+GMfQwAkNn10piDT3xlzayexaJtzerTcgHGpGMs/JAhpZPkaM8RoNcP//TSyqN
        3qqwDwy34P2RQiy3Kz8V9s5uw9bjz86onvrpaijDpXuq/oH81lB+2Yme5oZAxFBj7pTtCX
        oM2LDmFmQum3aFrwsNN4fZtg9PUMRqx6PwUFU7uvrKAlbbFMOzjF3Dqm9MQ+BO6pxYcOMh
        ifohoX73vuoVQ12QX1Ql7G1QHgmUvNpWCS/+P+cwSVNJ19TSSVrCnNe1mXIr/9LntGG2p8
        3yC5m9V4cZIzMAHQGVFJEoeGGAnb+x1HyLflkFe7W4wgbaNMfGzsecHWLd0tfg==
Message-ID: <e0a925bb-d4f1-44a1-8fe3-e1a59c4a7476@arinc9.com>
Date:   Sat, 16 Sep 2023 19:15:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] dt-bindings: net:
 marvell-armada-370-neta: convert to json-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Sean Wang <sean.wang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        John Crispin <john@phrozen.org>,
        linux-mediatek@lists.infradead.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Machon <daniel.machon@microchip.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>, UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Marek Vasut <marex@denx.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Jose Abreu <joabreu@synopsys.com>,
        Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, mithat.guner@xeront.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        George McCollister <george.mccollister@gmail.com>,
        erkin.bozoglu@xeront.com, linux-renesas-soc@vger.kernel.org
References: <20230916110902.234273-1-arinc.unal@arinc9.com>
 <20230916110902.234273-11-arinc.unal@arinc9.com>
 <169487631064.1637966.13545721653989465162.robh@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <169487631064.1637966.13545721653989465162.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.2023 17:58, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell-armada-370-neta.yaml:
> Unresolvable JSON pointer: '$defs/phylink'

Not surprising as this is added with a previous patch in this series.

> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/net/marvell-neta-bm.txt references a file that doesn't exist: Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> Documentation/devicetree/bindings/net/marvell-neta-bm.txt: Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt

Will address.

Arınç
