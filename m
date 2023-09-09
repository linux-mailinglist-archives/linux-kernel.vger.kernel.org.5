Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E657996F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbjIIIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:54:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6510F6;
        Sat,  9 Sep 2023 01:54:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0410FF807;
        Sat,  9 Sep 2023 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694249642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPyUYQLyx47PeNlqKxT+aTtsZJ3iYspjlYlykygyiuc=;
        b=UQfz2ahW9ABaRafSgjFTQI5Zlk0Z/seB/LuZdIQ0ulfjMzR2l7vbbcP6CgW/T6vYMJ+jWs
        mWVlMkW/SHw+10Hepe2cHMko76AAq2HF9qUGyn32ctuG4cr6XXXvqhDFRWGEIXA2B1436g
        DRqgzi3Ymk9wnsTUH8gwNvYw27Y4Xv8JnOc44nrjDDQaYgKuxM2N7RbnvQdTw+mgRtXpon
        cXWPfzS9U11E9MOHRlgyGFUFtwWlo5t1HaMySrr5ip6feXYsrMY+wM+eFL52Ki36NqC55z
        n+3zcOcPQtPcvvYu5eaE918MLnvC6KaGC4np/lkeaC7SQb5dYyZ4oaTiiw6mXA==
Message-ID: <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
Date:   Sat, 9 Sep 2023 11:53:50 +0300
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
In-Reply-To: <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.09.2023 14:33, Arınç ÜNAL wrote:
> Hey Vladimir,
> 
> On 27.08.2023 15:12, Vladimir Oltean wrote:
>> Hi Arınç,
>>
>> I am on vacation and I will just reply with some clarification aspects,
>> without having done any further research on the topic since my last reply.
>>
>> On Sun, Aug 27, 2023 at 11:33:16AM +0300, Arınç ÜNAL wrote:
>>> Before I continue commenting, I'd like to state my understanding so we can
>>> make sure we're on the same page. If a driver doesn't use
>>> ds->slave_mii_bus, the switch it controls must not have any internal MDIO
>>> buses. Otherwise the PHYs on these buses couldn't function, and an improper
>>> driver like this would not be on the official Linux source code.
>>
>> A DSA switch port, like any OF-based ethernet-controller which uses
>> phylink, will use one of the phy-handle, fixed-link or managed properties
>> to describe the interface connecting the MAC/MAC-side PCS to the PHY.
>>
>> At its core, ds->slave_mii_bus is nothing more than a mechanism to make
>> sense of device trees where the above 3 phylink properties are not present.
>>
>> It is completely false to say that if a driver doesn't have ds->slave_mii_bus,
>> it must not have an internal MDIO bus. Because you could still describe
>> that internal MDIO bus like below, without making any use of the sole property
>> that makes ds->slave_mii_bus useful from a dt-bindings perspective.
>>
>> ethernet-switch {
>>     ethernet-ports {
>>         port@0 {
>>             reg = <0>;
>>             phy-handle = <&port0_phy>;
>>             phy-mode = "internal";
>>         };
>>     };
>>
>>     mdio {
>>         port0_phy: ethernet-phy@0 {
>>             reg = <0>;
>>         };
>>     };
>> };
>>
>> This is the more universal way of describing the port setup in an
>> OF-based way. There is also the DSA-specific (and old-style, before phylink)
>> way of describing the same thing, which relies on the non-OF-based
>> ds->slave_mii_bus, with bindings that look like this:
>>
>> ethernet-switch {
>>     ethernet-ports {
>>         port@0 {
>>             reg = <0>;
>>         };
>>     };
>> };
>>
>> But, I would say that the first variant of the binding is preferable,
>> since it is more universal.
>>
>> Not all switches that have an internal MDIO bus support the second
>> variant of the dt-binding (the ones that don't have ds->slave_mii_bus don't).
>> But, they support the same configuration through the first form.
> 
> Understood.
> 
>>
>> Furthermore, on the U-Boot mailing lists, I have been suggesting that
>> the DM_DSA driver for mv88e6xxx should not bother to support the second
>> version of the binding, since it is just more code to be added to handle
>> a case which can already be described with the more universal first binding.
> 
> That makes sense.
> 
>>
>>> I've checked mscc,vsc7514-switch. What I see is, the architecture is an SoC
>>> with a switch component. Since the switch component is not designed to be a
>>> standalone IC, the MDIO bus of the SoC could just as well be used without
>>> the need to design an MDIO controller specific to the switch component, to
>>> manage the PHYs. So I see this switch as just another case of a switch
>>> without an internal MDIO bus.
>>
>> Well, we need to clarify the semantics of an "internal" MDIO bus.
>>
>> I would say most discrete chips with DSA switches have this SoC-style
>> architecture, with separate address spaces for the switching IP, MDIO
>> bus, GPIO controller, IRQ controllers, temperature sensors etc (see
>> "mscc,vsc7512-switch" which is like "mscc,vsc7514-switch", but it is
>> controlled over SPIO instead of MMIO). The dt-bindings of most DSA
>> switches may or may not reflect that discrete chip organization. Those
>> drivers and dt-bindings could be reimagined so that DSA is not the
>> top-level driver.
>>
>> Yet, I would argue that it's wrong to say that because it isn't an OF
>> child of the switch, the MDIO bus of the VSC7514 is not internal in the
>> same way that the Realtek MDIO bus is internal. The switch ports are
>> connected to internal PHYs on this MDIO bus, and there aren't PHYs on
>> this MDIO bus that go to other MACs than the switch ports. So, the
>> VSC7514 MDIO bus could legally be called the internal MDIO bus of the
>> switch, even if there isn't a parent/child relationship between them.
> 
> Good point, I had believed that the management interface of all of the PHYs
> being connected to the MDIO bus - which is not part of the switching IP
> address space - would be enough to classify the MDIO bus as non-internal.
> 
> However, the architecture of separate address spaces for the switching IP
> and MDIO bus is used on any type of IC with the switching feature.
> Therefore, this characteristic cannot be used to distinguish whether an
> MDIO bus is of a switch.
> 
> What we can refer to to classify an internal MDIO bus is by confirming the
> data interface of all PHYs on the MDIO bus is connected to the switch port
> MACs, as you have pointed out here.
> 
> Because the architecture of separate address spaces for the switching IP
> and MDIO bus is used on any type of IC with the switching feature, it can
> differ by driver how the MDIO bus is defined on the dt-bindings. So we
> can't make universal bindings of an internal MDIO bus of a switch that
> apply to every switch.
> 
> So, the correct approach is to define things under the switch-specific
> schema which is affine to the driver, as you have already pointed out.
> Which schemas to define what will of course differ.
> 
>>
>> So, what I'm disagreeing with is your insistence to correlate your
>> problem with internal MDIO buses. The way in which the problem is
>> formulated dictates what problem gets solved, and the problem is not
>> correctly formulated here. It is purely about ds->slave_mii_bus and its
>> driver-defined OF presence/absence. It is a DSA-specific binding aspect
>> which not even all DSA switches inherit, let alone bindings outside DSA.
> 
> Got it.
> 
>>
>>>> For switches in the second category, it all depends on the way in which
>>>> the driver finds the node for of_mdiobus_register().
>>>
>>> Ok, so some drivers require the mdio child node. Some require it and the
>>> compatible property with a certain string.
>>>
>>> MDIO controlled Realtek switches do not need the compatible property under
>>> the mdio child node. There're no compatible strings to make a distinction
>>> between the SMI and MDIO controlled switches so the best we can do is keep
>>> it the way it currently is. Define realtek,smi-mdio as a compatible string
>>> but keep the compatible property optional. I did state this on my reply to
>>> patch 3 but still received reviewed-bys regardless.
>>
>> Yes, because.... [1]
>>
>>>> Having identified all switches which make some sort of use of
>>>> ds->slave_mii_bus, the rule would sound like this:
>>>>
>>>> 1. If the schema is that of (need to replace this with compatible
>>>>      strings, I'm too lazy for that):
>>>>
>>>>      - ksz_switch_ops
>>>>      - mv88e6060_switch_ops
>>>>      - lan9303_switch_ops
>>>>      - rtl8365mb_switch_ops_mdio
>>>>      - b53_switch_ops
>>>>      - vsc73xx_ds_ops
>>>>      - mv88e6xxx
>>>>      - qca8k
>>>>
>>>>      and we have an "mdio" child, then phylink bindings are mandatory on user ports.
>>>>
>>>> 2. If the schema is that of gswip_mdio and we have a child node of "lantiq,xrx200-mdio",
>>>>      then phylink bindings are mandatory on user ports (I haven't checked,
>>>>      but it might be that the "lantiq,xrx200-mdio" child is mandatory, and
>>>>      in that case, this goes to category 4 below).
>>>>
>>>> 3. If the schema is that of realtek_smi_setup_mdio and we have a child node of
>>>>      "realtek,smi-mdio", then phylink bindings are mandatory on user ports
>>>>      (same comment about the child MDIO note maybe being mandatory).
>>>>
>>>> 4. If the switch didn't appear in the above set of rules, then phylink
>>>>      bindings are unconditionally mandatory on user ports.
>>>>
>>>> We don't care at all what the drivers that don't use ds->slave_mii_bus
>>>> do with the "mdio" child node. It doesn't change the fact that their
>>>> user ports can't have missing phylink bindings.
>>>
>>> I partially agree. I say, for the switches without an internal MDIO bus,
>>> invalidate the mdio child node, and enforce the phylink bindings on the
>>> user ports. Such as mscc,vsc7514-switch and nxp,sja1105x. For nxp,sja1110x,
>>> invalidate the mdio child node, and enforce the phylink bindings on the
>>> user ports if the mdios property is used.
>>
>> Why "if the mdios property is used" and not "always"? :-/
>>
>> To say it again: because the sja1105 driver does not use ds->slave_mii_bus,
>> it can make no sense of dt-bindings on user ports which lack phylink properties.
>> So they are *always* needed. The "mdios" property changes nothing in that regard.
> 
> Got it.
> 
>>
>>>
>>> I'd like to add this before I conclude. The way I understand dt-bindings is
>>> that a binding does not have to translate to an action on the driver.
>>> Documenting bindings for the sole purpose of describing hardware is a valid
>>> case.
>>
>> [1] ...this. The SMI-controlled and MDIO-controlled Realtek switches are
>> otherwise the same, right? So why would they have different dt-bindings?
> 
> Honestly, I'm wondering the answer to this as well. For some reason, when
> probing the SMI controlled Realtek switches, instead of just letting
> dsa_switch_setup() populate ds->slave_mii_bus, on realtek_smi_setup_mdio()
> on realtek-smi.c:
> 
> - priv->slave_mii_bus is allocated.
> - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
> - priv->slave_mii_bus->dev.of_node = mdio_np;
> - ds->slave_mii_bus = priv->slave_mii_bus;
> 
>>
>>> For example, currently, the MT753X DSA subdriver won't, in any way,
>>> register the bus OF-based. Still, the mdio property for the switches which
>>> this driver controls can be documented because the internal mdio bus does
>>> exist on the hardware.
>>
>> It can, but the whole point is: if ds->slave_mii_bus gains an OF presence,
>> then it loses its core functionality (that user ports can lack phylink
>> bindings). This is the entire essence of what this discussion should capture.
> 
> Understood.
> 
>>
>>>
>>> So I'd like to keep the mdio property valid for the switches which their
>>> drivers can only register non-OF-based ds->slave_mii_bus.
>>>
>>> In conclusion, what to do:
>>>
>>> - Define "the mdio property" and "the enforcement of phylink bindings for
>>>    user ports if mdio property is used" on ethernet-switch.yaml.
>>>      - Invalidate the mdio property on the switches without an internal MDIO
>>>        bus.
>>> - Define "the enforcement of phylink bindings for user ports" on the
>>>    switches without an internal MDIO bus.
>>> - Require "the mdio property" for the switches which their driver requires
>>>    it to function.
>>> - Require "the mdio property" and "the compatible string of the mdio
>>>    property" for the switches which their driver requires them to function.
>>>
>>> There's no 1:1 switch to switch compatible string relation, as seen on
>>> Realtek switches so I'll have to figure that out as I go.
>>>
>>> I'm open to your comments to this mail but the gap between discussion and
>>> end result has widened a lot on this patch series so I'd like to first
>>> offload this conversation by preparing v2 with what I said here and discuss
>>> further there.
>>
>> Honestly, from my side, a verbal comment in the dt-bindings document
>> would have been just fine, as long as it is truthful to the reality it
>> describes.
>>
>> You wanted to over-complicate things with an actual schema validation,
>> and then hooking onto things that are unrelated with the phenomenon that
>> needs to be captured (like the "mdio" child node, without explicit
>> regard to whether it is the ds->slave_mii_bus or not).
>>
>> It's not about internal MDIO buses in general, it's about whether those
>> internal MDIO buses are used in ds->slave_mii_bus, and their OF
>> presence/absence! That is absolutely driver-specific and I would only
>> expect a driver-specific way of enforcing it. I didn't say it's not
>> hard, and I didn't ask to enforce it, either.
> 
> OK, I believe we're on the same page now, I will start working on properly
> enforcing this.

I'm writing below as a mix of patch log and discussion.

Phylink bindings are required for ports that are controlled by OF-based
buses. DSA, like any other driver utilising the Linux MDIO infrastructure,
can register a bus. If I understand correctly, non-OF-based registration of
OpenFirmware MDIO buses is a feature specific to DSA which certain DSA
subdrivers make use of.

There's no way to distinguish which port is controlled by which driver's
MDIO bus on the bindings so we can't enforce phylink bindings for all user
ports as this would also enforce phylink bindings on user ports controlled
by a non-OF-based bus.

But we can know when DSA won't create a non-OF-based bus. That leaves us
with only OF-based buses in which case we can enforce phylink bindings for
all user ports. So we need to check each DSA subdriver to see when all
buses will be OF-based.

A DSA subdriver can either let the main DSA driver register the bus or it
can register a bus or buses itself.

The attributes of a DSA subdriver that lets the DSA driver register the
bus:
- ds->ops->phy_read() and ds->ops->phy_write() are present.
- ds->slave_mii_bus is not populated by the DSA subdriver.
- The bus is registered non-OF-based or OF-based. Registered OF-based if
   "mdio" child node is defined.

How each DSA subdriver behaves is documented below.

---

- mscc,vsc7514-switch.yaml
   - mscc,vsc7514-switch
   - mscc,vsc7512-switch

drivers/net/ethernet/mscc/ocelot_vsc7514.c:
- Not a DSA subdriver.
- MDIO_MSCC_MIIM, a driver utilising the Linux MDIO infrastructure is used
   to register a bus.

drivers/net/dsa/ocelot/ocelot_ext.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- MDIO_MSCC_MIIM, a driver utilising the Linux MDIO infrastructure is used
   to register a bus.

What to do:
- For mscc,vsc7514-switch, enforce phylink bindings for ports.
- For mscc,vsc7512-switch, enforce phylink bindings for user ports.

---

- renesas,rzn1-a5psw.yaml
   - renesas,r9a06g032-a5psw, renesas,rzn1-a5psw

drivers/net/dsa/rzn1_a5psw.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers the bus OF-based only. Registers the bus when "mdio" child node
   is defined.
   -	mdio = of_get_child_by_name(dev->of_node, "mdio");
     if (of_device_is_available(mdio))
       ret = a5psw_probe_mdio(a5psw, mdio);

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports.

---

- realtek.yaml
   - realtek,rtl8365mb
   - realtek,rtl8366rb

drivers/net/dsa/realtek/realtek-smi.c:
- The DSA subdriver won't let the DSA driver register the bus. Registers
   the bus OF-based only. Registering the bus is mandatory. Registers the
   bus when compatible string "realtek,smi-mdio" on a child node is defined.
   - mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
     if (!mdio_np)
       return -ENODEV;
     ds->slave_mii_bus = priv->slave_mii_bus;

drivers/net/dsa/realtek/realtek-mdio.c:
- The DSA subdriver lets the DSA driver register the bus.

What to do:
- Document "mdio".
   - Require "mdio". (Can't do because it's not required for MDIO controlled
     switches that share the compatible string with SMI controlled switches.
     This is why I would like Luiz to unify the bus registeration process.)
- Document compatible string "realtek,smi-mdio" on "mdio" child node.
   - Require compatible. (Can't do because the same as above.)
- Enforce phylink bindings for user ports. (Can't do because the same as
   above.)
   - Enforce phylink bindings for user ports if "mdio" is defined.

---

- qca8k.yaml
   - qca,qca8327
   - qca,qca8328
   - qca,qca8334
   - qca,qca8337

drivers/net/dsa/qca/qca8k-8xxx.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
   child node is defined.
   - mdio = of_get_child_by_name(priv->dev->of_node, "mdio");

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- nxp,sja1105.yaml
   - nxp,sja1105e
   - nxp,sja1105t
   - nxp,sja1105p
   - nxp,sja1105q
   - nxp,sja1105r
   - nxp,sja1105s
   - nxp,sja1110a
   - nxp,sja1110b
   - nxp,sja1110c
   - nxp,sja1110d

drivers/net/dsa/sja1105/sja1105_mdio.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers multiple buses OF-based only. Registers the buses when "mdios"
   child node and "nxp,sja1110-base-tx-mdio" and "nxp,sja1110-base-t1-mdio"
   compatible strings per child node under "mdios" is defined.
   - mdio_node = of_get_child_by_name(switch_node, "mdios");
     if (!mdio_node)
       return 0;
   - np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
     if (!np)
       return 0;
   - np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
     if (!np)
       return 0;

What to do:
- Document "mdios".
   - Document child node pattern property under "mdios".
     - Document "nxp,sja1110-base-tx-mdio" and "nxp,sja1110-base-t1-mdio"
       compatible strings.
- Enforce phylink bindings for user ports.

---

- mscc,ocelot.yaml
   - mscc,vsc9953-switch
   - pci1957,eef0

drivers/net/dsa/ocelot/seville_vsc9953.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- MDIO_MSCC_MIIM, a driver utilising the Linux MDIO infrastructure is used
   to register a bus.

drivers/net/dsa/ocelot/felix_vsc9959.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- FSL_ENETC_MDIO, a driver utilising the Linux MDIO infrastructure is used
   to register a bus.

What to do:
- Enforce phylink bindings for user ports.

---

- microchip,lan937x.yaml
   - microchip,lan9370
   - microchip,lan9371
   - microchip,lan9372
   - microchip,lan9373
   - microchip,lan9374
- microchip,ksz.yaml
   - microchip,ksz8765
   - microchip,ksz8794
   - microchip,ksz8795
   - microchip,ksz8863
   - microchip,ksz8873
   - microchip,ksz9477
   - microchip,ksz9897
   - microchip,ksz9896
   - microchip,ksz9567
   - microchip,ksz8565
   - microchip,ksz9893
   - microchip,ksz9563
   - microchip,ksz8563

drivers/net/dsa/microchip/ksz_common.c:
- The DSA subdriver won't let the DSA driver register the bus when "mdio"
   child node is defined. Registers the bus OF-based only. Registers the bus
   when "mdio" child node is defined.
   - mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
     if (!mdio_np)
       return 0;
     ds->slave_mii_bus = bus;

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- hirschmann,hellcreek.yaml
   - hirschmann,hellcreek-de1soc-r1

drivers/net/dsa/hirschmann/hellcreek.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().

What to do:
- Enforce phylink bindings for user ports.

---

- mediatek,mt7530.yaml
   - mediatek,mt7530
   - mediatek,mt7531
   - mediatek,mt7621
   - mediatek,mt7988-switch

drivers/net/dsa/mt7530.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
   child node is defined. (This is after the patch for the MT7530 DSA
   subdriver is applied.)

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- brcm,sf2.yaml
   - brcm,bcm4908-switch
   - brcm,bcm7278-switch-v4.0
   - brcm,bcm7278-switch-v4.8
   - brcm,bcm7445-switch-v4.0

drivers/net/dsa/bcm_sf2.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Requires MDIO_BCM_UNIMAC, a driver utilising the Linux MDIO
   infrastructure to register a bus.
   - dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
     priv->master_mii_bus = of_mdio_find_bus(dn);
     if (!priv->master_mii_bus) {
       of_node_put(dn);
       return -EPROBE_DEFER;
     }

What to do:
- Enforce phylink bindings for user ports.

---

- brcm,b53.yaml
   - brcm,bcm5325
   - brcm,bcm53115
   - brcm,bcm53125
   - brcm,bcm53128
   - brcm,bcm53134
   - brcm,bcm5365
   - brcm,bcm5395
   - brcm,bcm5389
   - brcm,bcm5397
   - brcm,bcm5398
   - brcm,bcm11360-srab, brcm,cygnus-srab
   - brcm,bcm53010-srab, brcm,bcm5301x-srab
   - brcm,bcm53011-srab, brcm,bcm5301x-srab
   - brcm,bcm53012-srab, brcm,bcm5301x-srab
   - brcm,bcm53018-srab, brcm,bcm5301x-srab
   - brcm,bcm53019-srab, brcm,bcm5301x-srab
   - brcm,bcm11404-srab, brcm,omega-srab
   - brcm,bcm11407-srab, brcm,omega-srab
   - brcm,bcm11409-srab, brcm,omega-srab
   - brcm,bcm58310-srab, brcm,omega-srab
   - brcm,bcm58311-srab, brcm,omega-srab
   - brcm,bcm58313-srab, brcm,omega-srab
   - brcm,bcm58522-srab, brcm,nsp-srab
   - brcm,bcm58523-srab, brcm,nsp-srab
   - brcm,bcm58525-srab, brcm,nsp-srab
   - brcm,bcm58622-srab, brcm,nsp-srab
   - brcm,bcm58623-srab, brcm,nsp-srab
   - brcm,bcm58625-srab, brcm,nsp-srab
   - brcm,bcm88312-srab, brcm,nsp-srab
   - brcm,bcm3384-switch, brcm,bcm63xx-switch
   - brcm,bcm6318-switch, brcm,bcm63xx-switch
   - brcm,bcm6328-switch, brcm,bcm63xx-switch
   - brcm,bcm6362-switch, brcm,bcm63xx-switch
   - brcm,bcm6368-switch, brcm,bcm63xx-switch
   - brcm,bcm63268-switch, brcm,bcm63xx-switch

drivers/net/dsa/b53/b53_common.c:
- The DSA subdriver lets the DSA driver register the bus.

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- arrow,xrs700x.yaml
   - arrow,xrs7003e
   - arrow,xrs7003f
   - arrow,xrs7004e
   - arrow,xrs7004f

drivers/net/dsa/xrs700x/xrs700x.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().

What to do:
- Enforce phylink bindings for user ports.

---

Text documents. I will handle these when I replace them with json-schema
documents.

- ar9331.txt
   - qca,ar9331-switch

drivers/net/dsa/qca/ar9331.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers the bus OF-based only. Registering the bus is mandatory.
   Registers the bus when "mdio" child node is defined.
   - mnp = of_get_child_by_name(np, "mdio");
     if (!mnp)
       return -ENODEV;

What to do:
- Document "mdio".
   - Require "mdio".
- Enforce phylink bindings for user ports.

---

- lan9303.txt
   - smsc,lan9303-i2c
   - smsc,lan9303-mdio

drivers/net/dsa/lan9303-core.c:
- The DSA subdriver lets the DSA driver register the bus.

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- lantiq-gswip.txt
   - lantiq,xrx200-gswip
   - lantiq,xrx300-gswip
   - lantiq,xrx330-gswip

drivers/net/dsa/lantiq_gswip.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - No ds->ops->phy_read() or ds->ops->phy_write().
- Registers the bus OF-based only. Registers the bus when compatible string
   "lantiq,xrx200-mdio" on a child node is defined.
   - mdio_np = of_get_compatible_child(dev->of_node, "lantiq,xrx200-mdio");
     if (mdio_np)
       err = gswip_mdio(priv, mdio_np);

What to do:
- Document "mdio".
- Document compatible string "realtek,smi-mdio" on "mdio" child node.
   - Require compatible.
- Enforce phylink bindings for user ports.

---

- marvell.txt
   - marvell,mv88e6085
   - marvell,mv88e6190
   - marvell,mv88e6250

drivers/net/dsa/mv88e6xxx/chip.c:
- The DSA subdriver won't let the DSA driver register the bus.
   - ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
- Registers the bus non-OF-based or OF-based. Registers OF-based if "mdio"
   child node is defined.

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

---

- vitesse,vsc73xx.txt
   - vitesse,vsc7385
   - vitesse,vsc7388
   - vitesse,vsc7395
   - vitesse,vsc7398

drivers/net/dsa/vitesse-vsc73xx-core.c:
- The DSA subdriver lets the DSA driver register the bus.

What to do:
- Document "mdio".
- Enforce phylink bindings for user ports if "mdio" is defined.

Arınç
