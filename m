Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090C677A66D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHMM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHMM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:59:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE390E6F;
        Sun, 13 Aug 2023 05:59:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78A6B240002;
        Sun, 13 Aug 2023 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691931546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Das/Iq62AV66sLwCAUWNuFrHn8CiB8KngbQOudN7xQ=;
        b=VJSxRm1D9aLplYld0WQ+k0Ue066GLcVMyoyYyKc9sTR+FKcKFxo0k2O3qKaAp28gkmbQY+
        YEJ7JxPysfSYWbX3axnJLN4pVrH8Ej7/z+7LKfu+lWQYpoMM4w1XZPp/YE7l3dp9GxgSsD
        HKPVzzRbxUiGNjmwZuDaOcRcTKs4IJFFucp2qUZHumVRg+vW7sISaJ9WGaoktqfzSgKXRH
        /IlDEYl4+ye2oQoVkXIHHJaMqiUgdGLGkEGdaxntMB9t0imwMYb0NuSmwechDHMmjpQbi6
        v0TAdYXeU5WY0hK5tryE0im1ns6nN5w7rVrIAUG3giEnOc7tIwKzwxazd+MxAg==
Message-ID: <2598d0f8-8d87-4712-ada1-fc76efb61d61@arinc9.com>
Date:   Sun, 13 Aug 2023 15:58:55 +0300
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
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <20230813111536.xzmxytghjzxhzmq7@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230813111536.xzmxytghjzxhzmq7@skbuf>
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

On 13.08.2023 14:15, Vladimir Oltean wrote:
> On Sat, Aug 12, 2023 at 12:17:06PM +0300, Arınç ÜNAL wrote:
>> Add the schema to document the internal MDIO bus. Adjust realtek.yaml
>> accordingly.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../devicetree/bindings/net/dsa/dsa.yaml      | 18 +++++
>>   .../devicetree/bindings/net/dsa/realtek.yaml  | 66 +++++++++----------
>>   2 files changed, 50 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
>> index ec74a660beda..03ccedbc49dc 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
>> @@ -31,6 +31,24 @@ properties:
>>         (single device hanging off a CPU port) must not specify this property
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>   
>> +  mdio:
>> +    description: The internal MDIO bus of the switch
>> +    $ref: /schemas/net/mdio.yaml#
>> +
>> +if:
>> +  required: [ mdio ]
>> +then:
>> +  patternProperties:
>> +    "^(ethernet-)?ports$":
>> +      patternProperties:
>> +        "^(ethernet-)?port@[0-9]+$":
>> +          if:
>> +            not:
>> +              required: [ ethernet ]
> 
> To match only on user ports, this must also exclude DSA ports ("required: [ link ]").
> 
>> +          then:
>> +            required:
>> +              - phy-handle
> 
> No. The only thing permitted by the slave_mii_bus is to do something meaningful
> when phylink bindings ("phy-handle", "fixed-link" or "managed") are absent. But
> the presence of slave_mii_bus does not imply that user ports have a required
> phy-handle. They might be SerDes ports or xMII ports. So they might use "managed"
> or "fixed-link". The only thing that you can enforce is that, if the slave_mii_bus
> has an OF presence, then user ports must have phylink bindings.

Got it. This should be the correct schema then. I don't check for ethernet
or link as when the mdio property is used, these bindings apply to all
ports. DSA and CPU ports are then further restricted with the dsa-port.yaml
schema.

if:
   required: [ mdio ]
then:
   patternProperties:
     "^(ethernet-)?ports$":
       patternProperties:
         "^(ethernet-)?port@[0-9]+$":
           oneOf:
             - required:
                 - fixed-link
             - required:
                 - phy-handle
             - required:
                 - managed

Arınç
