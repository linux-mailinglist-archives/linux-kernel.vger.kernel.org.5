Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1677A629
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHMLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:23:21 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47DC5;
        Sun, 13 Aug 2023 04:23:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DF9D40003;
        Sun, 13 Aug 2023 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691925800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GXovUO/PFAmMSu4eDPxz+1S111/9HB7f0QHyjq9J88=;
        b=MEO8bynVSnOxZ01sRklkbXmoBw+J8LaQRA7TI6gDLKiq2Z6rv8LcwgSJvOH7uqbev8KURt
        TrWsWTvx0cisOxLJl9Jsd5U6AhKfM8Vawwnc3F950pKoeWuqUVD51RTYzzYEOTZGiNUBp9
        KkY0o3sTyTIohpr0KOqb/mvrRH7UFYd930PofaMrhXqmNgotEgVyUcnaa5GXO/nAhxykge
        lp0fDU4JHgJr7Yg7aMPrdA8aAFGkzFmh4HgAbBXexTcb5EWJtjG+9cyu0Q5bDnOd0j11eR
        uDeHxATwJwJaNo2csLR6FU73vH3DWRxrla/o1kkz3jWXdeS/PSi5SkIfzdTD6Q==
Message-ID: <49acfbe1-a310-441d-99a5-16955b4cf41e@arinc9.com>
Date:   Sun, 13 Aug 2023 14:23:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: microchip,lan937x: add missing
 ethernet on example
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
 <20230813110747.rvvsvte2t6pbe5j4@skbuf>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230813110747.rvvsvte2t6pbe5j4@skbuf>
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

On 13.08.2023 14:07, Vladimir Oltean wrote:
> On Sat, Aug 12, 2023 at 12:17:05PM +0300, Arınç ÜNAL wrote:
>> The port@5 node on the example is missing the ethernet property. Add it.
>> Remove the MAC bindings on the example as they cannot be validated.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../bindings/net/dsa/microchip,lan937x.yaml           | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
>> index 8d7e878b84dc..49af4b0d5916 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
>> @@ -68,16 +68,6 @@ examples:
>>     - |
>>       #include <dt-bindings/gpio/gpio.h>
>>   
>> -    macb0 {
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>> -
>> -            fixed-link {
>> -                    speed = <1000>;
>> -                    full-duplex;
>> -            };
>> -    };
>> -
>>       spi {
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> @@ -138,6 +128,7 @@ examples:
>>                                       phy-mode = "rgmii";
>>                                       tx-internal-delay-ps = <2000>;
>>                                       rx-internal-delay-ps = <2000>;
>> +                                    ethernet = <&macb1>;
> 
> macb1 instead of macb0: was it intentional?

Yes, port@4 defines macb0. I used macb1 for port@5 here.

Arınç
