Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EE799AAC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbjIITyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIITyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 15:54:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633B1AC;
        Sat,  9 Sep 2023 12:54:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7615240004;
        Sat,  9 Sep 2023 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694289238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99TF+vOwckQTt89fEYfiNSFkiXPmHqPMDu9g5QZJPvg=;
        b=nlTtXJl6ExikEslIoJ4Vn1I8BudB/egKEU9IA6LdEFYvmYp1LZWf44H0OR9xSoa5fVjADa
        MdNZ6NuBebSoydqDSGXjjp6mFP0SMCSwWq69rcs8ubz+WVuZZlo9ws6MuhQQ/pFCUfkCwJ
        u7zmZ8cpOAlUkXZFutzcqNTA2DVofSY6hYOAAnkIbG+b/wa8d1jNnYtR35BAc+hAHet7Nz
        LULSQZZp90bfp7S/Yc9aaK+mJeUbnL8OlpjqptYyx3ctnW9Tv3in5zHS7wV0QTCIyWv93f
        CR9E2NHjw8mwJsoVsiE/BfG5AHGnFOHqNjjAihmGU4q4134fgb+7v7BDGiIUlQ==
Message-ID: <ec457f3d-8f28-4eb9-971e-0079e085cf0d@arinc9.com>
Date:   Sat, 9 Sep 2023 22:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
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
References: <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
In-Reply-To: <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
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

On 9.09.2023 11:53, Arınç ÜNAL wrote:
> On 4.09.2023 14:33, Arınç ÜNAL wrote:
>> Hey Vladimir,
>>
>> On 27.08.2023 15:12, Vladimir Oltean wrote:
>>> Hi Arınç,
>>>
>>> I am on vacation and I will just reply with some clarification aspects,
>>> without having done any further research on the topic since my last reply.
>>>
>>> On Sun, Aug 27, 2023 at 11:33:16AM +0300, Arınç ÜNAL wrote:
>>>> Before I continue commenting, I'd like to state my understanding so we can
>>>> make sure we're on the same page. If a driver doesn't use
>>>> ds->slave_mii_bus, the switch it controls must not have any internal MDIO
>>>> buses. Otherwise the PHYs on these buses couldn't function, and an improper
>>>> driver like this would not be on the official Linux source code.
>>>
>>> A DSA switch port, like any OF-based ethernet-controller which uses
>>> phylink, will use one of the phy-handle, fixed-link or managed properties
>>> to describe the interface connecting the MAC/MAC-side PCS to the PHY.
>>>
>>> At its core, ds->slave_mii_bus is nothing more than a mechanism to make
>>> sense of device trees where the above 3 phylink properties are not present.
>>>
>>> It is completely false to say that if a driver doesn't have ds->slave_mii_bus,
>>> it must not have an internal MDIO bus. Because you could still describe
>>> that internal MDIO bus like below, without making any use of the sole property
>>> that makes ds->slave_mii_bus useful from a dt-bindings perspective.
>>>
>>> ethernet-switch {
>>>     ethernet-ports {
>>>         port@0 {
>>>             reg = <0>;
>>>             phy-handle = <&port0_phy>;
>>>             phy-mode = "internal";
>>>         };
>>>     };
>>>
>>>     mdio {
>>>         port0_phy: ethernet-phy@0 {
>>>             reg = <0>;
>>>         };
>>>     };
>>> };
>>>
>>> This is the more universal way of describing the port setup in an
>>> OF-based way. There is also the DSA-specific (and old-style, before phylink)
>>> way of describing the same thing, which relies on the non-OF-based
>>> ds->slave_mii_bus, with bindings that look like this:
>>>
>>> ethernet-switch {
>>>     ethernet-ports {
>>>         port@0 {
>>>             reg = <0>;
>>>         };
>>>     };
>>> };
>>>
>>> But, I would say that the first variant of the binding is preferable,
>>> since it is more universal.
>>>
>>> Not all switches that have an internal MDIO bus support the second
>>> variant of the dt-binding (the ones that don't have ds->slave_mii_bus don't).
>>> But, they support the same configuration through the first form.
>>
>> Understood.
>>
>>>
>>> Furthermore, on the U-Boot mailing lists, I have been suggesting that
>>> the DM_DSA driver for mv88e6xxx should not bother to support the second
>>> version of the binding, since it is just more code to be added to handle
>>> a case which can already be described with the more universal first binding.
>>
>> That makes sense.
>>
>>>
>>>> I've checked mscc,vsc7514-switch. What I see is, the architecture is an SoC
>>>> with a switch component. Since the switch component is not designed to be a
>>>> standalone IC, the MDIO bus of the SoC could just as well be used without
>>>> the need to design an MDIO controller specific to the switch component, to
>>>> manage the PHYs. So I see this switch as just another case of a switch
>>>> without an internal MDIO bus.
>>>
>>> Well, we need to clarify the semantics of an "internal" MDIO bus.
>>>
>>> I would say most discrete chips with DSA switches have this SoC-style
>>> architecture, with separate address spaces for the switching IP, MDIO
>>> bus, GPIO controller, IRQ controllers, temperature sensors etc (see
>>> "mscc,vsc7512-switch" which is like "mscc,vsc7514-switch", but it is
>>> controlled over SPIO instead of MMIO). The dt-bindings of most DSA
>>> switches may or may not reflect that discrete chip organization. Those
>>> drivers and dt-bindings could be reimagined so that DSA is not the
>>> top-level driver.
>>>
>>> Yet, I would argue that it's wrong to say that because it isn't an OF
>>> child of the switch, the MDIO bus of the VSC7514 is not internal in the
>>> same way that the Realtek MDIO bus is internal. The switch ports are
>>> connected to internal PHYs on this MDIO bus, and there aren't PHYs on
>>> this MDIO bus that go to other MACs than the switch ports. So, the
>>> VSC7514 MDIO bus could legally be called the internal MDIO bus of the
>>> switch, even if there isn't a parent/child relationship between them.
>>
>> Good point, I had believed that the management interface of all of the PHYs
>> being connected to the MDIO bus - which is not part of the switching IP
>> address space - would be enough to classify the MDIO bus as non-internal.
>>
>> However, the architecture of separate address spaces for the switching IP
>> and MDIO bus is used on any type of IC with the switching feature.
>> Therefore, this characteristic cannot be used to distinguish whether an
>> MDIO bus is of a switch.
>>
>> What we can refer to to classify an internal MDIO bus is by confirming the
>> data interface of all PHYs on the MDIO bus is connected to the switch port
>> MACs, as you have pointed out here.
>>
>> Because the architecture of separate address spaces for the switching IP
>> and MDIO bus is used on any type of IC with the switching feature, it can
>> differ by driver how the MDIO bus is defined on the dt-bindings. So we
>> can't make universal bindings of an internal MDIO bus of a switch that
>> apply to every switch.
>>
>> So, the correct approach is to define things under the switch-specific
>> schema which is affine to the driver, as you have already pointed out.
>> Which schemas to define what will of course differ.
>>
>>>
>>> So, what I'm disagreeing with is your insistence to correlate your
>>> problem with internal MDIO buses. The way in which the problem is
>>> formulated dictates what problem gets solved, and the problem is not
>>> correctly formulated here. It is purely about ds->slave_mii_bus and its
>>> driver-defined OF presence/absence. It is a DSA-specific binding aspect
>>> which not even all DSA switches inherit, let alone bindings outside DSA.
>>
>> Got it.
>>
>>>
>>>>> For switches in the second category, it all depends on the way in which
>>>>> the driver finds the node for of_mdiobus_register().
>>>>
>>>> Ok, so some drivers require the mdio child node. Some require it and the
>>>> compatible property with a certain string.
>>>>
>>>> MDIO controlled Realtek switches do not need the compatible property under
>>>> the mdio child node. There're no compatible strings to make a distinction
>>>> between the SMI and MDIO controlled switches so the best we can do is keep
>>>> it the way it currently is. Define realtek,smi-mdio as a compatible string
>>>> but keep the compatible property optional. I did state this on my reply to
>>>> patch 3 but still received reviewed-bys regardless.
>>>
>>> Yes, because.... [1]
>>>
>>>>> Having identified all switches which make some sort of use of
>>>>> ds->slave_mii_bus, the rule would sound like this:
>>>>>
>>>>> 1. If the schema is that of (need to replace this with compatible
>>>>>      strings, I'm too lazy for that):
>>>>>
>>>>>      - ksz_switch_ops
>>>>>      - mv88e6060_switch_ops
>>>>>      - lan9303_switch_ops
>>>>>      - rtl8365mb_switch_ops_mdio
>>>>>      - b53_switch_ops
>>>>>      - vsc73xx_ds_ops
>>>>>      - mv88e6xxx
>>>>>      - qca8k
>>>>>
>>>>>      and we have an "mdio" child, then phylink bindings are mandatory on user ports.
>>>>>
>>>>> 2. If the schema is that of gswip_mdio and we have a child node of "lantiq,xrx200-mdio",
>>>>>      then phylink bindings are mandatory on user ports (I haven't checked,
>>>>>      but it might be that the "lantiq,xrx200-mdio" child is mandatory, and
>>>>>      in that case, this goes to category 4 below).
>>>>>
>>>>> 3. If the schema is that of realtek_smi_setup_mdio and we have a child node of
>>>>>      "realtek,smi-mdio", then phylink bindings are mandatory on user ports
>>>>>      (same comment about the child MDIO note maybe being mandatory).
>>>>>
>>>>> 4. If the switch didn't appear in the above set of rules, then phylink
>>>>>      bindings are unconditionally mandatory on user ports.
>>>>>
>>>>> We don't care at all what the drivers that don't use ds->slave_mii_bus
>>>>> do with the "mdio" child node. It doesn't change the fact that their
>>>>> user ports can't have missing phylink bindings.
>>>>
>>>> I partially agree. I say, for the switches without an internal MDIO bus,
>>>> invalidate the mdio child node, and enforce the phylink bindings on the
>>>> user ports. Such as mscc,vsc7514-switch and nxp,sja1105x. For nxp,sja1110x,
>>>> invalidate the mdio child node, and enforce the phylink bindings on the
>>>> user ports if the mdios property is used.
>>>
>>> Why "if the mdios property is used" and not "always"? :-/
>>>
>>> To say it again: because the sja1105 driver does not use ds->slave_mii_bus,
>>> it can make no sense of dt-bindings on user ports which lack phylink properties.
>>> So they are *always* needed. The "mdios" property changes nothing in that regard.
>>
>> Got it.
>>
>>>
>>>>
>>>> I'd like to add this before I conclude. The way I understand dt-bindings is
>>>> that a binding does not have to translate to an action on the driver.
>>>> Documenting bindings for the sole purpose of describing hardware is a valid
>>>> case.
>>>
>>> [1] ...this. The SMI-controlled and MDIO-controlled Realtek switches are
>>> otherwise the same, right? So why would they have different dt-bindings?
>>
>> Honestly, I'm wondering the answer to this as well. For some reason, when
>> probing the SMI controlled Realtek switches, instead of just letting
>> dsa_switch_setup() populate ds->slave_mii_bus, on realtek_smi_setup_mdio()
>> on realtek-smi.c:
>>
>> - priv->slave_mii_bus is allocated.
>> - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
>> - priv->slave_mii_bus->dev.of_node = mdio_np;
>> - ds->slave_mii_bus = priv->slave_mii_bus;
>>
>>>
>>>> For example, currently, the MT753X DSA subdriver won't, in any way,
>>>> register the bus OF-based. Still, the mdio property for the switches which
>>>> this driver controls can be documented because the internal mdio bus does
>>>> exist on the hardware.
>>>
>>> It can, but the whole point is: if ds->slave_mii_bus gains an OF presence,
>>> then it loses its core functionality (that user ports can lack phylink
>>> bindings). This is the entire essence of what this discussion should capture.
>>
>> Understood.
>>
>>>
>>>>
>>>> So I'd like to keep the mdio property valid for the switches which their
>>>> drivers can only register non-OF-based ds->slave_mii_bus.
>>>>
>>>> In conclusion, what to do:
>>>>
>>>> - Define "the mdio property" and "the enforcement of phylink bindings for
>>>>    user ports if mdio property is used" on ethernet-switch.yaml.
>>>>      - Invalidate the mdio property on the switches without an internal MDIO
>>>>        bus.
>>>> - Define "the enforcement of phylink bindings for user ports" on the
>>>>    switches without an internal MDIO bus.
>>>> - Require "the mdio property" for the switches which their driver requires
>>>>    it to function.
>>>> - Require "the mdio property" and "the compatible string of the mdio
>>>>    property" for the switches which their driver requires them to function.
>>>>
>>>> There's no 1:1 switch to switch compatible string relation, as seen on
>>>> Realtek switches so I'll have to figure that out as I go.
>>>>
>>>> I'm open to your comments to this mail but the gap between discussion and
>>>> end result has widened a lot on this patch series so I'd like to first
>>>> offload this conversation by preparing v2 with what I said here and discuss
>>>> further there.
>>>
>>> Honestly, from my side, a verbal comment in the dt-bindings document
>>> would have been just fine, as long as it is truthful to the reality it
>>> describes.
>>>
>>> You wanted to over-complicate things with an actual schema validation,
>>> and then hooking onto things that are unrelated with the phenomenon that
>>> needs to be captured (like the "mdio" child node, without explicit
>>> regard to whether it is the ds->slave_mii_bus or not).
>>>
>>> It's not about internal MDIO buses in general, it's about whether those
>>> internal MDIO buses are used in ds->slave_mii_bus, and their OF
>>> presence/absence! That is absolutely driver-specific and I would only
>>> expect a driver-specific way of enforcing it. I didn't say it's not
>>> hard, and I didn't ask to enforce it, either.
>>
>> OK, I believe we're on the same page now, I will start working on properly
>> enforcing this.
> 
> I'm writing below as a mix of patch log and discussion.
> 
> Phylink bindings are required for ports that are controlled by OF-based
> buses. DSA, like any other driver utilising the Linux MDIO infrastructure,
> can register a bus. If I understand correctly, non-OF-based registration of
> OpenFirmware MDIO buses is a feature specific to DSA which certain DSA
> subdrivers make use of.
> 
> There's no way to distinguish which port is controlled by which driver's
> MDIO bus on the bindings so we can't enforce phylink bindings for all user
> ports as this would also enforce phylink bindings on user ports controlled
> by a non-OF-based bus.
> 
> But we can know when DSA won't create a non-OF-based bus. That leaves us
> with only OF-based buses in which case we can enforce phylink bindings for
> all user ports. So we need to check each DSA subdriver to see when all
> buses will be OF-based.

We also need to decide the phylink bindings for user ports.

Phylink bindings for CPU and DSA ports:

allOf:
   - required:
       - phy-mode
   - oneOf:
       - required:
           - fixed-link
       - required:
           - phy-handle
       - required:
           - managed

On one of the mscc,ocelot.yaml examples, "phy-handle" and "managed" are
defined on the same user port. Assuming the example is correct, we must
allow more than 1 of these properties to be used at the same time for user
ports.

We need to at least allow "phy-handle" and "managed" to be used at the same
time. Does "managed" also depend on "phy-handle"?

For example:

oneOf:
   - required:
       - fixed-link
   - anyOf:
       - required:
           - phy-handle
       - required:
           - managed

dependencies:
   managed: [ phy-handle ]

Arınç
