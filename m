Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1E79E83C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjIMMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIMMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:44:22 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2D19B1;
        Wed, 13 Sep 2023 05:44:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7668420008;
        Wed, 13 Sep 2023 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694609055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOWHnup71AUlA2pdfGiWMAnf7L7N7R7hXAeXu+YYNpk=;
        b=LoVXclUT4ag/ho/8wurTwZ89GnA2gA+DpO1lpnb6s8GY4d5cD124trIxlVkUZ0egL/1LET
        sXeP8RWQPMYk/chORC/sv4Wo/pTkSwLQUV7+yC2nVNfv07CDYikZ6HIYPVjf8s35jtl3zn
        c4OeEWb0mOT9DVwFgbTo/TYSTiivS9zgKA0tinbGJ506oJ1h3h+HIpKN/VpWExKOv0t1De
        tzcfmiKZmJ3+a8IxyEtWNStEeyu9mNjCqWhZNVCMnU3gv8MrjqqcWgcr1i0azI/R7ecWH6
        lHOIK0FYfDcTMHMPamOLZRJmJ+lR7xLMRcOJcpw/QH/hAKpcxgy+nxSgiqc66g==
Message-ID: <f891b3b6-0cab-4aa3-beee-b20f45a3ce57@arinc9.com>
Date:   Wed, 13 Sep 2023 15:44:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
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
References: <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <617c51cf-2c09-4865-ac60-96599db597e7@lunn.ch>
 <563ac27a-22f2-463e-b5c1-9df721842976@arinc9.com>
 <c7eddf45-c259-47de-ac59-2569c09ed5f7@lunn.ch>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <c7eddf45-c259-47de-ac59-2569c09ed5f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2023 04:21, Andrew Lunn wrote:
>>> The marvell switch can have up to 2 MDIO busses. If i remember
>>> correctly, there is also one switch which has one MDIO bus per port.
>>
>> I'm writing the json-schema for Marvell switches. I've checked a few
>> devicetree source files on Linus's Linux tree, I only see two buses used at
>> the most.
> 
> Sorry, i was ambiguous. Its not a Marvell switch which can have one
> MDIO bus per port. I don't remember which switch it is, and it might
> be a pure switchdev switch, not a DSA switch.
> 
>> The internal bus and another bus with
>> marvell,mv88e6xxx-mdio-external. I've never seen a devicetree with
>> marvell,mv88e6250 though. Could the switch that has one MDIO bus per port
>> be this one? Also, is every bus of this switch a
>> marvell,mv88e6xxx-mdio-external bus or, one internal bus and the remaining
>> are marvell mv88e6xxx-mdio-external buses?
> 
> Only the 6390 family has two busses. It has an internal MDIO bus with
> the same register API as all the other switches. However, unlike the
> other families, it is not exposed on pins. And the 6390 has a second
> MDIO bus using a slight variant of the registers, which is connected
> to the outside world via pins. This second bus then has a compatible
> to separate it from the normal MDIO bus.

OK, I will disallow the external mdio bus for the compatible strings other
than marvell,mv88e6190.

Arınç
