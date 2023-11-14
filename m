Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307947EAD82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjKNKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKNKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:04:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F917194;
        Tue, 14 Nov 2023 02:04:11 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0857C6602F36;
        Tue, 14 Nov 2023 10:04:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699956249;
        bh=Hq37ChMubvCTToerJNuW/7oUKCovgAWrPkN6HAPLVK4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EBigAJCQehoclU7qZ0/2lQ7YlVgYBgTVD6/UEKierYm1ZkUcMUYl/lyzqcPNuCNUc
         Y5bEabo1xrw5dsBZSM0zNEWPIif5OTnezmoI5YX8iFu1UZ+pT+U+H2GfemrH39XEI1
         dh3ceuh5VILgCsmQLs4LSv2yvFB9sNt74dmABb/GRocl1eDTRQQ0ugT52kP0YWvkDY
         qu2hj3DnRfuxHnfjWUS0rBdQS8b2D0lqXNY88XEAxD5mWG87r5nTCnFOV0N0VOrz7q
         MjTDCUlrbpyQ+GFgz41Dz1gJx4NFV60mXoh+Zvme8NWAh5f/jCm4GVzGiGrvkQClMl
         3BB0dFYaU1SaA==
Message-ID: <bfbd68fb-82c5-4357-8679-f1ad1c53426b@collabora.com>
Date:   Tue, 14 Nov 2023 11:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
 <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAGXv+5G+J__Z_YBySxrkthhwa71shq7aCeKZ_DEZCK=PLgYwUg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5G+J__Z_YBySxrkthhwa71shq7aCeKZ_DEZCK=PLgYwUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/11/23 09:57, Chen-Yu Tsai ha scritto:
> On Thu, Nov 9, 2023 at 6:54 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 09/11/23 11:05, Chen-Yu Tsai ha scritto:
>>> Hi everyone,
>>>
>>> This v2 series continues Doug's "of: device: Support 2nd sources of
>>> probeable but undiscoverable devices" [1] series, but follows the scheme
>>> suggested by Rob, marking all second source component device nodes
>>> as "fail-needs-probe-XXX", and having a hardware prober driver enable
>>> the one of them. I tried to include everyone from the original Cc: list.
>>> Please let me know if you would like to be dropped from future
>>> submissions.
>>>
>>>
>>> For the I2C component (touchscreens and trackpads) case from the
>>> original series, the hardware prober driver finds the particular
>>> class of device in the device tree, gets its parent I2C adapter,
>>> and tries to initiate a simple I2C read for each device under that
>>> I2C bus. When it finds one that responds, it considers that one
>>> present, marks it as "okay", and returns, letting the driver core
>>> actually probe the device.
>>>
>>> This works fine in most cases since these components are connected
>>> via ribbon cable and always have the same resources. The driver as
>>> implemented currently doesn't deal with regulators or GPIO pins,
>>> since in the existing device trees they are either always on for
>>> regulators, or have GPIO hogs or pinmux and pinconfig directly
>>> tied to the pin controller.
>>>
>>>
>>> Another case this driver could handle is selecting components based
>>> on some identifier passed in by the firmware. On Chromebooks we have
>>> a SKU ID which is inserted by the bootloader at
>>> /firmware/coreboot/sku-id. When a new combination of components is
>>> introduced, a new SKU ID is allocated to it. To have SKU ID based
>>> device trees, we would need to have one per SKU ID. This ends up
>>> increasing the number of device trees we have a lot. The recent
>>> MT8186 devices already have 10+10 SKUs [2], with possibly more to come.
>>>
>>> Instead, we could have just one device tree for each device, with
>>> component options listed and marked as "fail-needs-probe-XXX", and
>>> let the hardware prober enable one of them based on the given SKU ID.
>>> The driver will also fix up OF graph remote endpoints to point to the
>>> enabled component.
>>>
>>> The MT8186 Corsola series [2] can also benefit from this, though I
>>> haven't implemented anything yet.
>>>
>>>
>>> Patch 1 adds of_device_is_fail() for the new driver to use.
>>>
>>> Patch 2 implements the first case, probing the I2C bus for presence
>>> of components. This initial version targets the Hana Chromebooks.
>>>
>>> Patch 3 modifies the Hana device tree and marks the touchscreens
>>> and trackpads as "fail-needs-probe-XXX", ready for the driver to
>>> probe.
>>>
>>> Patch 4 adds a missing touchscreen variant to Hana.
>>>
>>> Patch 5 implements the second case, selectively enabling components
>>> based on the SKU ID. This initial version targets the Krane ChromeOS
>>> tablet, which has two possible MIPI DSI display panel options.
>>>
>>> Patch 6 drops Krane's SKU-specific compatible strings from the bindings.
>>>
>>> Patch 7 merges Krane's SKU-specific device trees into one, with the
>>> device tree now containing two possible panels. This unfortunately
>>> introduces a dtc warning:
>>>
>>>       arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dts:81.13-83.6:
>>>           Warning (graph_endpoint): /soc/dsi@14014000/panel2@0/port/endpoint:
>>>        graph connection to node '/soc/dsi@14014000/ports/port/endpoint'
>>>            is not bidirectional
>>>
>>>
>>> Please take a look.
>>>
>>> Johan, I'm not sure if this works as is for the Lenovo Thinkpad 13S
>>> case, since it looks like the trackpad shares the I2C bus with the
>>> keyboard.
>>>
>>>
>>> Thanks
>>> ChenYu
>>>
>>>
>>> Background as given in Doug's cover letter:
>>>
>>> Support for multiple "equivalent" sources for components (also known
>>> as second sourcing components) is a standard practice that helps keep
>>> cost down and also makes sure that if one component is unavailable due
>>> to a shortage that we don't need to stop production for the whole
>>> product.
>>>
>>> Some components are very easy to second source. eMMC, for instance, is
>>> fully discoverable and probable so you can stuff a wide variety of
>>> similar eMMC chips on your board and things will work without a hitch.
>>>
>>> Some components are more difficult to second source, specifically
>>> because it's difficult for software to probe what component is present
>>> on any given board. In cases like this software is provided
>>> supplementary information to help it, like a GPIO strap or a SKU ID
>>> programmed into an EEPROM. This helpful information can allow the
>>> bootloader to select a different device tree. The various different
>>> "SKUs" of different Chromebooks are examples of this.
>>>
>>> Some components are somewhere in between. These in-between components
>>> are the subject of this patch. Specifically, these components are
>>> easily "probeable" but not easily "discoverable".
>>>
>>> A good example of a probeable but undiscoverable device is an
>>> i2c-connected touchscreen or trackpad. Two separate components may be
>>> electrically compatible with each other and may have compatible power
>>> sequencing requirements but may require different software. If
>>> software is told about the different possible components (because it
>>> can't discover them), it can safely probe them to figure out which
>>> ones are present.
>>>
>>> On systems using device tree, if we want to tell the OS about all of
>>> the different components we need to list them all in the device
>>> tree. This leads to a problem. The multiple sources for components
>>> likely use the same resources (GPIOs, interrupts, regulators). If the
>>> OS tries to probe all of these components at the same time then it
>>> will detect a resource conflict and that's a fatal error.
>>>
>>> The fact that Linux can't handle these probeable but undiscoverable
>>> devices well has had a few consequences:
>>> 1. In some cases, we've abandoned the idea of second sourcing
>>>      components for a given board, which increases cost / generates
>>>      manufacturing headaches.
>>> 2. In some cases, we've been forced to add some sort of strapping /
>>>      EEPROM to indicate which component is present. This adds difficulty
>>>      to manufacturing / refurb processes.
>>> 3. In some cases, we've managed to make things work by the skin of our
>>>      teeth through slightly hacky solutions. Specifically, if we remove
>>>      the "pinctrl" entry from the various options then it won't
>>>      conflict. Regulators inherently can have more than one consumer, so
>>>      as long as there are no GPIOs involved in power sequencing and
>>>      probing devices then things can work. This is how
>>>      "sc8280xp-lenovo-thinkpad-x13s" works and also how
>>>      "mt8173-elm-hana" works.
>>>
>>> End of background from Doug's cover letter.
>>
>> I think that using "status" is not a good idea, I find that confusing.
> 
> It isn't a hard requirement. The current I2C prober actually just looks
> at the node name, which already should be a generic class type. It then
> assumes that all the components of the same class that it is supposed
> to probe for are on the same bus. I think this is a fair assumption for
> replaceable parts connected via ribbon cable or co-layout parts?
> 

Assuming that the parts are on the exact same bus is ok, there has to be a
flexibility limit, or this framework will definitely get abused in the wrong
ways.

>> Perhaps we could have a node like
>>
>> something {
>>          device-class-one = <&device1>, <&device2>, <&device3>;
>>          device-class-two = <&device4>, <&device5>, <&device6>;
>> }
>>
>> so that'd be more or less
>>
>> hw-prober {
>>          trackpads = <&tp1>, <&tp2>;
>>          keyboards = <&kb1>, <&kb2>;
>>          touchscreens = <&ts1>, <&ts2>;
>> }
> 
> This was already nacked by Rob.

Oh. Oops. :-)

> 
>> Besides, something else I can suggest here is to make this more generic: actually,
>> this issue is spread across way more devices than you maybe think... for example,
>> I know of some smartphones that may have the same situation with DSI displays and
>> they're sometimes distinguished by an ADC value, sometimes by reading back the
>> manufacturer ID (or panel id) through DSI.
> 
> ADC strapping is common. Though we might need some kind of binding about how
> to describe the ADC strapping scheme, as this is bound to be different across
> boards.
> 
> Reading back from DSI feels problematic to implement. But I don't know much
> about DSI ATM. Doug implied in our offline discussion that DSI panels might
> have power sequencing requirements that are all over the place.
> 

This is exactly why I think that this should allow a certain kind of "modularity",
meaning that subsystems should be able to register their own hook into this: in
both cases of ADC and/or DSI readback we're getting into some fairly (less, or
more) complicated territory - and it's something that people around each subsystem
knows best - and they must have that kind of flexibility and freedom to change the
hooked implementation in their own subsystem instead of somewhere else.

There would be much more to say about this, but I'm avoiding to write a wall of
text because I'm sure that you can read through the lines and can get my point
anyway.

>> Also, if Chromebooks really need something "special", such as that coreboot sku-id
>> parameter, I think that this should be registered externally into the hw prober
>> and not embedded inside of the *generic* hw prober driver.
>>
>> We can even reuse of_device_id instead of inventing a new hw_prober_entry struct...
>>
>> Idea:
>>
>> drivers/platform/chrome/cros_of_hw_prober.c
>>
>> static int cros_sku_hw_prober(struct platform_device *pdev, const void *data)
>> {
>>          ...this is your cros_sku_component_selector() function, anyway...
>> }
>>
>> static const struct of_device_id cros_hw_prober_ids[] = {
>>          { .compatible = "google,hana", .data = something },
>>          { /* sentinel */ }
>> };
>>
>> static int some_kind_of_early_init_function(something)
>> {
>>          int a,b,c,ret,something;
>>
>>          .. some logic if necessary ..
>>
>>          return of_hw_prober_register(cros_sku_hw_prober, cros_hw_prober_ids);
>> }
> 
> This feels a bit too layered, and requires all the board specific code to
> have an early init function. I think exposing common helper functions for
> boards to implement prober drivers would be better. Then the prober could
> also be a module if that made sense. Given that SoC vendors are making
> clock controller drivers modules, this doesn't seem very far fetched.
> 

That would as well work - and would be way better than early init. Reading it back
now, putting that in a early init function would be counter-productive in general.

>> Btw, thanks for starting that. If this will be done the right way, it's going to
>> be useful to many, many people.
> 
> Right. I only have a limited view of applications, so input is always welcome.
> 
> Thanks
> ChenYu
> 
>> Regards,
>> Angelo
>>
>>>
>>> [1] https://lore.kernel.org/all/20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid/
>>> [2] https://lore.kernel.org/linux-mediatek/20231012230237.2676469-1-wenst@chromium.org/
>>>
>>> Chen-Yu Tsai (7):
>>>     of: base: Add of_device_is_fail
>>>     of: Introduce hardware prober driver
>>>     arm64: dts: mediatek: mt8173-elm-hana: Mark touchscreens and trackpads
>>>       as fail
>>>     arm64: dts: mediatek: mt8173-elm-hana: Add G2touch G7500 touchscreen
>>>     of: hw_prober: Support Chromebook SKU ID based component selection
>>>     dt-bindings: arm: mediatek: Remove SKU specific compatibles for Google
>>>       Krane
>>>     arm64: dts: mediatek: mt8183-kukui: Merge Krane device trees
>>>
>>>    .../devicetree/bindings/arm/mediatek.yaml     |   3 -
>>>    arch/arm64/boot/dts/mediatek/Makefile         |   3 +-
>>>    .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |  20 ++
>>>    .../dts/mediatek/mt8183-kukui-krane-sku0.dts  |  24 --
>>>    .../mediatek/mt8183-kukui-krane-sku176.dts    |  24 --
>>>    ...ukui-krane.dtsi => mt8183-kukui-krane.dts} |  47 ++-
>>>    drivers/of/Kconfig                            |  13 +
>>>    drivers/of/Makefile                           |   1 +
>>>    drivers/of/base.c                             |  20 ++
>>>    drivers/of/hw_prober.c                        | 314 ++++++++++++++++++
>>>    include/linux/of.h                            |   6 +
>>>    11 files changed, 418 insertions(+), 57 deletions(-)
>>>    delete mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
>>>    delete mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
>>>    rename arch/arm64/boot/dts/mediatek/{mt8183-kukui-krane.dtsi => mt8183-kukui-krane.dts} (86%)
>>>    create mode 100644 drivers/of/hw_prober.c
>>>
>>



