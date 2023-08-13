Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387677A670
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHMM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHMM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:59:21 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479AB171D;
        Sun, 13 Aug 2023 05:59:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DAD5240003;
        Sun, 13 Aug 2023 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691931560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXBlVWCkPDBZb7LA3AdMdiD9h+mhCPgNA1unI6nJtLM=;
        b=pBfUkrZhWI+v11F6yqNnsY8RRNKRk+aj/Q71+YVdrXkyEEtRGN5OCZn75OKVCqZndvbyNK
        JOu4Acx+FGGtbjALpxeqobSM/V5NFPMNRnff0+BQxtLhQ9tTNHpWuAnupEuy1jqqDfLW9p
        +TwfnYwSpE0GPDb5TP9oHcPsasr+1IU3zI0GgucGV8F18iNVt4n4G5eW7Ye2+Ne6XgYGR/
        Hw7B+1AWuP5B/WsFDA3tY/zUv8rXbrAp+RNeoW7AaIpy1QIoFJoJjRqBDLdwsQLi7pc3TF
        h7PsPUrye/lcjRZY+wTRVNkmPBd19nEiBqrar9bsfaYiLfotSsZ1pNMywWYGlw==
Message-ID: <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
Date:   Sun, 13 Aug 2023 15:59:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
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
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230813112026.ohsx6srbt2staxma@skbuf>
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

On 13.08.2023 14:53, Vladimir Oltean wrote:
> On Sat, Aug 12, 2023 at 10:20:43PM +0300, Arınç ÜNAL wrote:
>> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> index 4d5f5cc6d031e2..82dda8fae8b16e 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> @@ -72,6 +72,10 @@ properties:
>>             - compatible
>>             - reg
>> +  mdio:
>> +    $ref: dsa.yaml#/properties/mdio
>> +    unevaluatedProperties: false
> 
> sja1105 does not support an "mdio" child property. I haven't checked the
> others. Don't add properties that aren't supported.

Adding the mdio property to the dsa.yaml schema will allow it on all of the
schemas that refer to dsa.yaml such as this one. This addition here is only
to disallow additional properties under the mdio property for this specific
schema.

That said, my understanding is that the internal MDIO bus exists on all of
the switches controlled by DSA. Whether each individual DSA subdriver
supports registering it does not matter in terms of documenting the
internal MDIO bus for all DSA switches.

SJA1110 uses the mdios property instead because it's got two internal mdio
buses, which is why I invalidate the mdio property for it. If SJA1105 has
also got two internal mdio buses, let me know.

> 
>> +
>>   patternProperties:
>>     "^(ethernet-)?ports$":
>>       patternProperties:
>>
>> The nxp,sja1105.yaml schema also needed some changes.
>>
>> dt-bindings: net: dsa: nxp,sja1105: improve internal MDIO bus bindings
>>
>> SJA1110 Ethernet Switch uses the mdios property for its internal MDIO bus.
>> Therefore, disallow the mdios property for SJA1105, and the mdio property
>> for SJA1110.
>>
>> Require the phy-handle property on the non-CPU ports if the mdios property
>> is being used.
>>
>> Refer to dsa.yaml#/properties/mdio to point the human readers to the
>> description on the dsa.yaml schema.
>>
>> ---
>>   .../bindings/net/dsa/nxp,sja1105.yaml         | 20 ++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> index 82dda8fae8b16e..7d92350f1065b2 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
>> @@ -52,7 +52,7 @@ properties:
>>       patternProperties:
>>         "^mdio@[0-1]$":
>> -        $ref: /schemas/net/mdio.yaml#
>> +        $ref: dsa.yaml#/properties/mdio
>>           unevaluatedProperties: false
>>           properties:
>> @@ -128,14 +128,32 @@ allOf:
>>       then:
>>         properties:
>>           spi-cpol: false
>> +        mdios: false
>> +
>>         required:
>>           - spi-cpha
>>       else:
>>         properties:
>>           spi-cpha: false
>> +        mdio: false
>> +
>>         required:
>>           - spi-cpol
>> +  - if:
>> +      required: [ mdios ]
>> +    then:
>> +      patternProperties:
>> +        "^(ethernet-)?ports$":
>> +          patternProperties:
>> +            "^(ethernet-)?port@[0-9]+$":
>> +              if:
>> +                not:
>> +                  required: [ ethernet ]
>> +              then:
>> +                required:
>> +                  - phy-handle
> 
> For sja1105, phylink-compatible bindings (phy-handle, fixed-link or managed)
> are required for all ports (user, dsa or cpu).
> 
> Also, sja1105 does not populate the slave_mii_bus, so it never uses the
> fallback where ports implicitly connect to an internal PHY if no phylink
> bindings are present.

I'll handle these accordingly with your answer to my question above.

Arınç
