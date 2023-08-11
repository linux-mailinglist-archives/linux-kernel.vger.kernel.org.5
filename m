Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DC779ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjHKWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHKWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:45:39 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7C2130;
        Fri, 11 Aug 2023 15:45:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE388FF802;
        Fri, 11 Aug 2023 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691793936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbtUUoJutGSdy50RvaJ3kKz0WaAIY7fJ4VKyrVHb2W8=;
        b=G3vzjQWDz1PJOJkqVLNt8besnssHlQHj72Mj+EsY2ZKzP12pEziBSaD/RyQ6McCE1hbMzN
        JFLjDkjioBJKafMfizcAO+iC66Xnd8VLwIo59dhaDMK9zQEyMsX5F3btfZC6b8in4BAUFy
        uogFdKKn6C0+UcyInpJ9Nc1bYL5hN7GO4bRetEs/0lnWarSUkDkS7ZFbTBHWgGU6QvLbWn
        BfHHdcdN9GuGHZTY3fX7I3LLlotEakVf7Ggf7hOqfG5vLywQNMDX3OH81NOrPWJl7S2e3b
        hBsOuUneKGzVQJDc6xZDWRmOxK1yO2yylwja+4g9h7ftQlCmv8oGLkoYgDHWog==
Message-ID: <3f262579-eec1-4b21-9b18-1d1d612e715b@arinc9.com>
Date:   Sat, 12 Aug 2023 01:45:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH RESEND net-next 2/2] dt-bindings: net: dsa:
 mediatek,mt7530: document MDIO-bus
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6eb1b7b8dbc3a4b14becad15f0707d4f624ee18b.1691246461.git.daniel@makrotopia.org>
 <9aec0fe0cb676b76132c388bb3ead46f596a6e6e.1691246461.git.daniel@makrotopia.org>
 <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com>
 <20230808121707.chona7hakapp6whe@skbuf>
 <44fde617-1159-4961-84c4-372fe265fbd8@arinc9.com>
 <20230809220102.t3dqw7iojez5xsq3@skbuf>
Content-Language: en-US
In-Reply-To: <20230809220102.t3dqw7iojez5xsq3@skbuf>
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

On 10.08.2023 01:01, Vladimir Oltean wrote:
> On Wed, Aug 09, 2023 at 12:03:19PM +0300, Arınç ÜNAL wrote:
>> On 8.08.2023 15:17, Vladimir Oltean wrote:
>>> On Sat, Aug 05, 2023 at 11:15:15PM +0300, Arınç ÜNAL wrote:
>>>> I don't see a reason to resubmit this without addressing the requested
>>>> change.
>>>>
>>>>>> Wouldn't we just skip the whole issue by documenting the need for defining all PHYs
>>>>>> used on the switch when defining the MDIO bus?
>>>>>
>>>>> Good idea, please do that.
>>>>
>>>> https://lore.kernel.org/netdev/0f501bb6-18a0-1713-b08c-6ad244c022ec@arinc9.com/
>>>>
>>>> Arınç
>>>
>>> Arınç, where do you see that comment being added? AFAIU, it is a
>>> characteristic of the generic __of_mdiobus_register() code to set
>>> mdio->phy_mask = ~0, and nothing specific to the mt7530.
>>
>> What I believe is specific to DSA is, 1:1 mapping of the port reg to the
>> PHY reg on the mdio bus is disabled if the mdio bus is defined. Therefore,
>> I believe a notice like below fits mediatek,mt7530.yaml.
>>
>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> index e532c6b795f4..c59d58252cd5 100644
>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>> @@ -128,6 +128,15 @@ properties:
>>         See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
>>         details for the regulator setup on these boards.
>> +  mdio:
>> +    $ref: /schemas/net/mdio.yaml#
>> +    unevaluatedProperties: false
>> +    description:
>> +      Node for the internal MDIO bus connected to the embedded ethernet-PHYs.
>> +      For every port defined under the "^(ethernet-)?ports$" node, a PHY must be
>> +      defined under here and a phy-handle property must be defined under the
>> +      port node to point to the PHY node.
>> +
>>     mediatek,mcm:
>>       type: boolean
>>       description:
>>
>> Arınç
> 
> In that case, putting the comment here would make more sense, no?
> (and maybe enforcing an actual schema, but I've no idea how to do that)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> index 480120469953..5a415f12f162 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> @@ -59,7 +59,14 @@ properties:
>         - rtl8_4t
>         - seville
> 
> -# CPU and DSA ports must have phylink-compatible link descriptions
> +# CPU and DSA ports must have phylink-compatible link descriptions.
> +# On user ports, these are also supported, but are optional and may be omitted,
> +# meaning that these ports are implicitly connected to a PHY on an internal
> +# MDIO bus of the switch that isn't described in the device tree. If the switch
> +# does have a child node for the internal MDIO bus, the phylink-compatible
> +# bindings are also required (even if this is not enforced here). The detection
> +# of an internal MDIO bus is model-specific and may involve matching on the
> +# "mdio" node name or compatible string.
>   if:
>     oneOf:
>       - required: [ ethernet ]
> 
> Since commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus"), DSA as a
> framework also supports auto-creating an internal MDIO bus based on the
> presence of the "mdio" node name, so I guess it makes sense for the
> "mdio" to appear in the generic dsa.yaml if there's nothing else that's
> special about it.

I agree with this. I've done this which works. It's even found a port
node with the ethernet property missing, as it should've.

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index ec74a660beda..03ccedbc49dc 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -31,6 +31,24 @@ properties:
        (single device hanging off a CPU port) must not specify this property
      $ref: /schemas/types.yaml#/definitions/uint32-array
  
+  mdio:
+    description: The internal MDIO bus of the switch
+    $ref: /schemas/net/mdio.yaml#
+
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-9]+$":
+          if:
+            not:
+              required: [ ethernet ]
+          then:
+            required:
+              - phy-handle
+
  additionalProperties: true
  
  $defs:
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
index 8d7e878b84dc..fe1e2008995d 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
@@ -78,6 +78,16 @@ examples:
              };
      };
  
+    macb1 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+            };
+    };
+
      spi {
              #address-cells = <1>;
              #size-cells = <0>;
@@ -138,6 +148,7 @@ examples:
                                      phy-mode = "rgmii";
                                      tx-internal-delay-ps = <2000>;
                                      rx-internal-delay-ps = <2000>;
+                                    ethernet = <&macb0>;
  
                                      fixed-link {
                                              speed = <1000>;
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea..f600e65fc990 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
  
  title: Realtek switches for unmanaged switches
  
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
-
  maintainers:
    - Linus Walleij <linus.walleij@linaro.org>
  
@@ -95,37 +92,41 @@ properties:
        - '#address-cells'
        - '#interrupt-cells'
  
-  mdio:
-    $ref: /schemas/net/mdio.yaml#
-    unevaluatedProperties: false
-
-    properties:
-      compatible:
-        const: realtek,smi-mdio
-
-if:
-  required:
-    - reg
-
-then:
-  $ref: /schemas/spi/spi-peripheral-props.yaml#
-  not:
-    required:
-      - mdc-gpios
-      - mdio-gpios
-      - mdio
-
-  properties:
-    mdc-gpios: false
-    mdio-gpios: false
-    mdio: false
-
-else:
-  required:
-    - mdc-gpios
-    - mdio-gpios
-    - mdio
-    - reset-gpios
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+  - if:
+      required: [ mdio ]
+    then:
+      properties:
+        mdio:
+          properties:
+            compatible:
+              const: realtek,smi-mdio
+
+          required:
+            - compatible
+
+  - if:
+      required:
+        - reg
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      not:
+        required:
+          - mdc-gpios
+          - mdio-gpios
+          - mdio
+
+      properties:
+        mdc-gpios: false
+        mdio-gpios: false
+        mdio: false
+    else:
+      required:
+        - mdc-gpios
+        - mdio-gpios
+        - mdio
+        - reset-gpios
  
  required:
    - compatible


> 
> Also, in the earlier patch version you had replied to David Bauer:
> 
> | > While i was not aware of this side effect, I don't see how this breaks the ABI.
> |
> | Your patch doesn't break it, my then-intention of doing PHY muxing by
> | utilising this would. Your first patch is perfectly fine as is.
> 
> Could you please clarify what is your valid use case for not having a
> phy-handle to a PHY on an MDIO bus that is otherwise present in OF?

I had one possible use case, PHY muxing, but it has nothing to do with
the PHY registers of the PHYs on the internal MDIO bus so it's not a
valid use case.

> It doesn't _have_ to be broken. Since DSA knows the addresses of the
> internal PHYs, it can circumvent the lack of auto-scanning by manually
> calling get_phy_device() at the right (port-based) MDIO addresses.
> But any patch would need to have a clear reason before being considered
> for merging.

I think circumventing the mdio node for ports without a phy-handle will
bring unnecessary complexity and confusion as I may define a port with
reg = <1> with phy-handle to a phy with reg = <4>. In that case, a port
with reg = <4> without a phy-handle would try the phy with reg <4> and fail.

This is of course if I understood correctly that "(port-based) MDIO
addresses" means reading the MDIO address of a phy from the reg of a
port defined under the ports node.

Arınç
