Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4316B79968C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbjIIGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjIIGYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:24:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C81BD3;
        Fri,  8 Sep 2023 23:23:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFC7D1BF204;
        Sat,  9 Sep 2023 06:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694240636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1J79G2gHB19xem1WbfDmsg7JRZlNKmKwN1OuiBpPFQ=;
        b=gUTVg15eSAIqTlyoV6GvQ5Xfsm0JTJC7ByLx0Qp2Ip+Q4+72vDYnmx483BODHX9+AIu0Yx
        tSwaInjnfjqM0OhV1C4by8j8wP+8AcBuL6j4B4p4LMUPVdKCTVjCw399KOI3x6XeO9OaEf
        TOJqE1rmERhO1rp8c/lC9mQ7yPalrAmaaVIC6cWVM3Ow0mqDxiBY89vWNUnMZTR7F+bSvL
        wh/DQ4XiaIgnFRY6h/AVC6EqJVtCANTuWKQ7vpEr7QJrhgoR2s36HhNZGbho+dhvbB/3Ju
        pieHhES/P5tNXoWbPO4fXBsi8kB57DhUB2A7qLtuzBMdqeXRH/+E+qY6wxzdyw==
Message-ID: <563ac27a-22f2-463e-b5c1-9df721842976@arinc9.com>
Date:   Sat, 9 Sep 2023 09:23:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 14.08.2023 16:09, Andrew Lunn wrote:
>> Ah okay. I didn't consider the switch architecture where the data interface
>> of the PHY is connected to the switch, and the PHY management interface is
>> connected to the mdio bus that the switch is connected to.
> 
> The generic Linux architecture for PHYs and binding them to a MAC via
> a phandle allows the PHY to be on any MDIO bus anywhere. DSA has some
> additional shortcuts to support 1:1 mapping if the switch has its own
> MDIO bus, without describing it in DT, but this is just in addition to
> the generic code.
> 
>> Not json-schema documentation, don't care about:
>> - ar9331.txt
>> - lan9303.txt
>> - lantiq-gswip.txt
>> - marvell.txt
> 
> The marvell switch can have up to 2 MDIO busses. If i remember
> correctly, there is also one switch which has one MDIO bus per port.

I'm writing the json-schema for Marvell switches. I've checked a few
devicetree source files on Linus's Linux tree, I only see two buses used at
the most. The internal bus and another bus with
marvell,mv88e6xxx-mdio-external. I've never seen a devicetree with
marvell,mv88e6250 though. Could the switch that has one MDIO bus per port
be this one? Also, is every bus of this switch a
marvell,mv88e6xxx-mdio-external bus or, one internal bus and the remaining
are marvell mv88e6xxx-mdio-external buses?

Arınç
