Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936BD789C25
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjH0IeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjH0Id7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:33:59 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AE131;
        Sun, 27 Aug 2023 01:33:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F01840002;
        Sun, 27 Aug 2023 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1693125228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wEH/mfiXVjesB+Lotc8eGLmThbfxIt/f1O+5bayZ04=;
        b=caHR7KJZ5XijTFOdP7pDg9qNHRPs8Uw+/5chuwpI1ZD/QbIRbfu6ITvsC4z9oP6HSo5Lz8
        DgDN7aqsN8R2qGd+5yrlhqZjK2/8mKWnZIFYT1k2DDOnEoOPIcv6SkL+4/SH7+vCj+SiPD
        DEq1Bzij0WilchTFoBm65BzaY0ue51VrbFObxd5PEHQzf/t+PvyhxOL4vfBRXW+dBlDn4Z
        IM9kxlpncN4BML4NIlseUASSjakfkF+WHxCLg5Lzq/A1PTCmoOXMCovTcUhmVnJqdwKGk+
        YpVLzWn6F6lTQNIw2j+4mSDc1fcONj7v23tQhcv8EwmYH7PY1PuThI8PXteqYA==
Message-ID: <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
Date:   Sun, 27 Aug 2023 11:33:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
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
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230814143601.mnpxtcm2zybnbvoh@skbuf>
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

On 14.08.2023 17:36, Vladimir Oltean wrote:
> Arınç,
> 
> On Mon, Aug 14, 2023 at 01:06:29PM +0300, Arınç ÜNAL wrote:
>> On 13.08.2023 22:01, Vladimir Oltean wrote:
>>> SJA1105 has zero internal MDIO buses and zero internal PHYs.
>>
>> Ah okay. I didn't consider the switch architecture where the data interface
>> of the PHY is connected to the switch, and the PHY management interface is
>> connected to the mdio bus that the switch is connected to.
>>
>> The schemas of the switches which already utilise the mdio property:
>> - /schemas/net/dsa/microchip,lan937x.yaml
>> - /schemas/net/dsa/qca8k.yaml
>> - /schemas/net/dsa/realtek.yaml
>> - /schemas/net/dsa/renesas,rzn1-a5psw.yaml
>>
>> The schemas of the switches which don't have an internal MDIO bus, meaning
>> the mdio property must be invalid:
>> - /schemas/net/mscc,vsc7514-switch.yaml
>> - /schemas/net/dsa/nxp,sja1105.yaml
>>
>> The schemas of the switches which I don't know if the switch has got an
>> internal MDIO bus:
>> - /schemas/net/dsa/arrow,xrs700x.yaml
>>    - I believe, because there's phy-handle defined on every port without the
>>      mdio node on the example, the PHYs are not connected to the internal
>>      MDIO bus. Therefore, we can invalidate the mdio property for this
>>      schema.
>> - /schemas/net/dsa/brcm,b53.yaml
>>    - Seems ok to keep it valid.
>> - /schemas/net/dsa/brcm,sf2.yaml
>>    - Seems ok to keep it valid.
>> - /schemas/net/dsa/hirschmann,hellcreek.yaml
>>    - Same as /schemas/net/dsa/arrow,xrs700x.yaml.
>> - /schemas/net/dsa/microchip,ksz.yaml
>>    - Seems ok to keep it valid.
>> - /schemas/net/dsa/mscc,ocelot.yaml
>>    - Same as /schemas/net/dsa/arrow,xrs700x.yaml.
>>
>> Not json-schema documentation, don't care about:
>> - ar9331.txt
>> - lan9303.txt
>> - lantiq-gswip.txt
>> - marvell.txt
>> - vitesse,vsc73xx.txt
>>
>> Arınç
> 
> We have to keep in sight why we're here, and stick to that.
> 
> You had issues with a device tree that didn't work, but it passed
> validation, and you're trying to enforce extra rules through the
> json-schema so that next time, it fails. Verbally, that rule would be:
> "if the switch has a ds->slave_mii_bus which does not have an OF
> presence, then phylink compatible bindings may be omitted, and that has
> a special and valid meaning (the port is connected to an internal PHY on
> that ds->slave_mii_bus). If ds->slave_mii_bus has an OF presence, or if
> ds->slave_mii_bus is NULL, then phylink-compatible bindings (phy-handle
> or fixed-link or managed) are required on all user ports".
> 
> So it becomes a question of tracking ds->slave_mii_bus for all drivers.
> In essence, it's fundamentally about the ds->slave_mii_bus, not about
> the "mdio" child node. See more below.

Before I continue commenting, I'd like to state my understanding so we can
make sure we're on the same page. If a driver doesn't use
ds->slave_mii_bus, the switch it controls must not have any internal MDIO
buses. Otherwise the PHYs on these buses couldn't function, and an improper
driver like this would not be on the official Linux source code.

I've checked mscc,vsc7514-switch. What I see is, the architecture is an SoC
with a switch component. Since the switch component is not designed to be a
standalone IC, the MDIO bus of the SoC could just as well be used without
the need to design an MDIO controller specific to the switch component, to
manage the PHYs. So I see this switch as just another case of a switch
without an internal MDIO bus.

> 
> There are 2 code paths that lead to its creation:
> 
> 1. DSA registers the bus in dsa_slave_mii_bus_init(), based on the
>     presence of ds->ops->phy_read() and ds->ops->phy_write(). Traditionally,
>     a slave_mii_bus created this way was always non-OF-based, but Luiz,
>     in commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus"), thought
>     it would be a good idea for them to be optionally OF-based (and thus,
>     useless at their primary purpose of being able to have internal PHYs
>     without a phy-handle). But, it was thought that the framework
>     registering an MDIO bus automatically would be a plus. So, ds->slave_mii_bus
>     created in this way may or may not have an OF presence, with no way
>     to know except to look at device trees (and to presume that they do).
> 
>     The drivers that populate ds->ops->phy_read() and ds->ops->phy_write() are:
>      |
>      +--- dsa_loop_driver: not OF-based
>      |
>      +--- ksz_switch_ops: OF-based or non-OF-based
>      |
>      +--- mv88e6060_switch_ops: OF-based or non-OF-based
>      |
>      +--- lan9303_switch_ops: OF-based or non-OF-based
>      |
>      +--- rtl8365mb_switch_ops_mdio: OF-based or non-OF-based
>      |
>      +--- b53_switch_ops: OF-based or non-OF-based
>      |
>      +--- vsc73xx_ds_ops: OF-based or non-OF-based
> 
> 2. The switch driver registers the bus, and populates ds->slave_mii_bus with
>     a pointer to it.
>      |
>      +--- Bus is not OF-based (it was registered with mdiobus_register()).
>      |    This is the normal case:
>      |      * mv88e6xxx_default_mdio_bus() in some cases
>      |      * qca8k_mdio_register() in the "qca8k-legacy slave mii" case
>      |      * bcm_sf2_mdio_register()
>      |      * mt7530_setup_mdio()
>      |
>      +--- Bus is OF-based (it was registered with of_mdiobus_register()).
>           I've no idea why you'd do this, because you have neither the
>           benefit of using a non-OF-based phy_connect(), nor the benefit
>           of having DSA register the bus for you:
>             * mv88e6xxx_default_mdio_bus() when of_get_child_by_name(np, "mdio")
>               is non-NULL
>             * qca8k_mdio_register() when of_get_child_by_name(priv->dev->of_node, "mdio")
>               is non-NULL
>             * ksz_mdio_register() - it always wants an "mdio" child node
>             * gswip_mdio() - it always wants a child node compatible with
>               "lantiq,xrx200-mdio"
>             * realtek_smi_setup_mdio() - it always wants a child node
>               compatible with "realtek,smi-mdio"
> 
> For switches in the first category, the presence of the "mdio" child
> node is what makes the ds->slave_mii_bus be OF-based or not, since it is
> all the same binding, imposed by Luiz in dsa_switch_setup().

Makes sense.

> 
> For switches in the second category, it all depends on the way in which
> the driver finds the node for of_mdiobus_register().

Ok, so some drivers require the mdio child node. Some require it and the
compatible property with a certain string.

MDIO controlled Realtek switches do not need the compatible property under
the mdio child node. There're no compatible strings to make a distinction
between the SMI and MDIO controlled switches so the best we can do is keep
it the way it currently is. Define realtek,smi-mdio as a compatible string
but keep the compatible property optional. I did state this on my reply to
patch 3 but still received reviewed-bys regardless.

> 
> 
> Having identified all switches which make some sort of use of
> ds->slave_mii_bus, the rule would sound like this:
> 
> 1. If the schema is that of (need to replace this with compatible
>     strings, I'm too lazy for that):
> 
>     - ksz_switch_ops
>     - mv88e6060_switch_ops
>     - lan9303_switch_ops
>     - rtl8365mb_switch_ops_mdio
>     - b53_switch_ops
>     - vsc73xx_ds_ops
>     - mv88e6xxx
>     - qca8k
> 
>     and we have an "mdio" child, then phylink bindings are mandatory on user ports.
> 
> 2. If the schema is that of gswip_mdio and we have a child node of "lantiq,xrx200-mdio",
>     then phylink bindings are mandatory on user ports (I haven't checked,
>     but it might be that the "lantiq,xrx200-mdio" child is mandatory, and
>     in that case, this goes to category 4 below).
> 
> 3. If the schema is that of realtek_smi_setup_mdio and we have a child node of
>     "realtek,smi-mdio", then phylink bindings are mandatory on user ports
>     (same comment about the child MDIO note maybe being mandatory).
> 
> 4. If the switch didn't appear in the above set of rules, then phylink
>     bindings are unconditionally mandatory on user ports.
> 
> We don't care at all what the drivers that don't use ds->slave_mii_bus
> do with the "mdio" child node. It doesn't change the fact that their
> user ports can't have missing phylink bindings.

I partially agree. I say, for the switches without an internal MDIO bus,
invalidate the mdio child node, and enforce the phylink bindings on the
user ports. Such as mscc,vsc7514-switch and nxp,sja1105x. For nxp,sja1110x,
invalidate the mdio child node, and enforce the phylink bindings on the
user ports if the mdios property is used.

I'd like to add this before I conclude. The way I understand dt-bindings is
that a binding does not have to translate to an action on the driver.
Documenting bindings for the sole purpose of describing hardware is a valid
case. For example, currently, the MT753X DSA subdriver won't, in any way,
register the bus OF-based. Still, the mdio property for the switches which
this driver controls can be documented because the internal mdio bus does
exist on the hardware.

So I'd like to keep the mdio property valid for the switches which their
drivers can only register non-OF-based ds->slave_mii_bus.

In conclusion, what to do:

- Define "the mdio property" and "the enforcement of phylink bindings for
   user ports if mdio property is used" on ethernet-switch.yaml.
     - Invalidate the mdio property on the switches without an internal MDIO
       bus.
- Define "the enforcement of phylink bindings for user ports" on the
   switches without an internal MDIO bus.
- Require "the mdio property" for the switches which their driver requires
   it to function.
- Require "the mdio property" and "the compatible string of the mdio
   property" for the switches which their driver requires them to function.

There's no 1:1 switch to switch compatible string relation, as seen on
Realtek switches so I'll have to figure that out as I go.

I'm open to your comments to this mail but the gap between discussion and
end result has widened a lot on this patch series so I'd like to first
offload this conversation by preparing v2 with what I said here and discuss
further there.

Arınç
