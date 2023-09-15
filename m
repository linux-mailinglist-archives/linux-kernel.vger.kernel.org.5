Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74B7A1915
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjIOIoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:44:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3510DF;
        Fri, 15 Sep 2023 01:44:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4BCF660733F;
        Fri, 15 Sep 2023 09:44:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694767454;
        bh=XDj+nUBJW9U4x0BdkKfrpre7eDuSxWV1SWEtCizfusA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZWoEbW7wgTrJDxlWyTorpoCq2hxAbfEQeGGMlbH1yIcAUs13kVcQUl7KDX7aYpMPM
         vHNcqurJr1ov2qp3xicAdMgV/m8H4CdW3ADhKS5NT4Wq3BT2Xi3Wv+LBtTXxUWyHp3
         n9qKiAlq/E/J0+YmgZAr7qEyFBAQyNYTMZKdPTqC7GrDUp6jDmoEf+rUrMz1kRMNcG
         KdQSxp8LrlbfHJCsNXfoukF1+j3iShQ27T6Qriyv8ZvE1T84Kmm35QLJEmL04h1TlH
         VDNGm9ci7byFmMQIZZ8glMkqi8h3mOALW4IwbplRQslo9sW8U42Bmru3kU15lhe8yV
         ZXhxEvYJpF59g==
Message-ID: <72f73a46-2598-7698-a1a9-5f61bfa4f121@collabora.com>
Date:   Fri, 15 Sep 2023 10:44:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 05/11] regulator: dt-bindings: mediatek: Add MT6366
 PMIC
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-6-wenst@chromium.org>
 <337f20d5-4dfe-90ef-16b9-c10b14060b97@linaro.org>
 <60221aab-d8da-9f0b-057b-e8a28840849f@linaro.org>
 <CAGXv+5EiiDT_TWdyhrdq7HrBuMxpzZeKWNuhiVqJpmzcHEhaMA@mail.gmail.com>
 <c0289603-f498-2b6b-c45a-82ba400f2f58@linaro.org>
 <CAGXv+5H60PQpVQ6A06ZuY5V1n5OxEYcH097UiaoQumVRjTc+JA@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H60PQpVQ6A06ZuY5V1n5OxEYcH097UiaoQumVRjTc+JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/08/23 10:07, Chen-Yu Tsai ha scritto:
> On Wed, Aug 23, 2023 at 1:45 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 23/08/2023 06:20, Chen-Yu Tsai wrote:
>>> On Wed, Aug 23, 2023 at 3:40 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 22/08/2023 21:39, Krzysztof Kozlowski wrote:
>>>>> On 22/08/2023 10:45, Chen-Yu Tsai wrote:
>>>>>> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>>>>>
>>>>>> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
>>>>>> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
>>>>>> 29 LDO regulators, not counting ones that feed internally and basically
>>>>>> have no controls. The regulators are named after their intended usage
>>>>>> for the SoC and system design, thus not named generically as ldoX or
>>>>>> dcdcX, but as vcn33 or vgpu.
>>>>>>
>>>>>> Add a binding document describing all the regulators and their supplies.
>>>>>>
>>>>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>>>>> [wens@chromium.org: major rework and added commit message]
>>>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>> - Replaced underscores in supply names to hyphens
>>>>>> - Merged with MT6358 regulator binding
>>>>>> - Added MT6358 fallback compatible to MT6366 regulator
>>>>>>
>>>>>> Changes since Zhiyong's last version (v4) [1]:
>>>>>> - simplified regulator names
>>>>>> - added descriptions to regulators
>>>>>> - removed bogus regulators (*_sshub)
>>>>>> - merged vcn33-wifi and vcn33-bt as vcn33
>>>>>> - added missing regulators (vm18, vmddr, vsram-core)
>>>>>> - cut down examples to a handful of cases and made them complete
>>>>>> - expanded commit message a lot
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
>>>>>>   .../regulator/mediatek,mt6358-regulator.yaml  | 227 +++++++++++++-----
>>>>>>   1 file changed, 168 insertions(+), 59 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>>>>>> index 82328fe17680..b350181f33ff 100644
>>>>>> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>>>>>> @@ -16,14 +16,18 @@ description: |
>>>>>>
>>>>>>   properties:
>>>>>>     compatible:
>>>>>> -    const: mediatek,mt6358-regulator
>>>>>> +    oneOf:
>>>>>> +      - const: mediatek,mt6358-regulator
>>>>>> +      - items:
>>>>>> +          - const: mediatek,mt6366-regulator
>>>>>> +          - const: mediatek,mt6358-regulator
>>>>>>
>>>>>>     vsys-ldo1-supply:
>>>>>>       description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
>>>>>>     vsys-ldo2-supply:
>>>>>> -    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
>>>>>> +    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, vmch, vsim2
>>>>>>     vsys-ldo3-supply:
>>>>>> -    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
>>>>>> +    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), vemc, vibr
>>>>>>     vsys-vcore-supply:
>>>>>>       description: Supply for buck regulator vcore
>>>>>>     vsys-vdram1-supply:
>>>>>> @@ -43,75 +47,138 @@ properties:
>>>>>>     vsys-vs2-supply:
>>>>>>       description: Supply for buck regulator vs2
>>>>>>     vs1-ldo1-supply:
>>>>>> -    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
>>>>>> +    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358 only), vio18
>>>>>>     vs2-ldo1-supply:
>>>>>> -    description: Supply for LDOs vdram2
>>>>>> +    description: Supply for LDOs vdram2, vmddr (MT6366 only)
>>>>>>     vs2-ldo2-supply:
>>>>>>       description: Supply for LDOs vrf12, va12
>>>>>>     vs2-ldo3-supply:
>>>>>> -    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
>>>>>> -  vs2-ldo4-supply:
>>>>>> -    description: Supply for LDO vcamd
>>>>>> -
>>>>>> -patternProperties:
>>>>>> -  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
>>>>>> -    description: Buck regulators
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_v(a|rf)12":
>>>>>> -    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_v((aux|cn|io|rf)18|camio)":
>>>>>> -    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_vxo22":
>>>>>> -    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_v(aud|bif|cn|fe|io)28":
>>>>>> -    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_vusb":
>>>>>> -    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_vsram_(gpu|others|proc1[12])$":
>>>>>> -    description: LDOs with variable output
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>> -
>>>>>> -  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
>>>>>> -    description: LDOs with variable output and 0~100/10mV tuning
>>>>>> -    type: object
>>>>>> -    $ref: regulator.yaml#
>>>>>> -    unevaluatedProperties: false
>>>>>
>>>>> I don't understand. You just added it and it is already wrong? Please,
>>>>> do not add code which is clearly incorrect.
>>>>
>>>> Sent too early - anyway properties cannot be defined in allOf:. That's
>>>> not the place for them and there is no single reason for it. From which
>>>> regulator binding you got this example?
>>>
>>> None. It was simply a way I figured out when I was reading up on JSON
>>> schema syntax. I wanted to split the definitions cleanly, since they
>>> are very different. And with "unevaluatedProperties: false" in the base
>>> schema it did seem to work, successfully evaluating existing device trees
>>> and producing errors when extra properties were added, or if types didn't
>>> match up.
>>
>> If they are very different, this should not have been one binding. There
>> is little benefit of that.
> 
> But how would one handle sharing a common fallback compatible if it were
> split? In v1 they were separate bindings, but then Angelo argued that they
> were in fact very similar and the variants can be detected through hardware
> registers.
> 
> Note that the vastly different regulator names here are done for aesthetic
> reasons. The MT6358 had names with underscores and IMHO unneeded prefixes.
> These can't be changed due to existing device trees using them. (Or we
> could break the ABI.) With the MT6366 I chose to simplify them to match
> the exact names from the datasheet, except for the underscores.
> 
> ChenYu
> 
>>> Now that you mention it, I suppose the preferred way to write it is to
>>> have all the properties in the base schema, then negate the ones that
>>> don't belong in the allOf: section? It just seems really repetitive given
>>> the child node names for the chip variants are completely different. OOTH
>>> I guess it would produce better error messages.
>>
>>
>> For regular cases yes, but not if devices differ so much.
>>

Summarizing the important info:
- Chips are not "very different"
- Main changes in schema are just cosmetic

Blurb below... :-)

MT6358 and MT6366 have minimal differences from a driver perspective but then
bindings describe hardware, not drivers, that's a fact and there's nothing to
argue about that (and infact I won't argue about that).

I've been arguing about using the same driver and about that one not needing
any special compatible for MT6366 because (as ChenYu said) the only difference
- again, from a software perspective - is that the big list of regulators "swaps"
(permit me the term...) 3 regulators and drops one: everything is handled the
very same way anyway.

This brings us to this point, where ChenYu *rightfully* wants to rename the actual
regulator names, because we shouldn't see underscores in devicetrees for multiple
reasons (which I surely don't have to explain of course) - even though the "right"
name as stated in datasheets contain underscores instead of dashes.

And there we go: all those changes in bindings are just because cosmetic stuff.

That said.....
I think that the real issue here can be solved with one easy question to Krzysztof:

in this case, where we want to use a different name (s/_/-/g) for regulators,
should we create a new yaml file, or should we update mt6358-regulator.yaml (but
obviously keeping the old cosmetics for the existing devicetrees and new for new)?

And - In case the best option would be to create a new mt6366-regulator.yaml,
would it be advisable to use a new compatible, or can we reuse the
"mediatek,mt6358-regulator" compatible?

Clearly, in the latter case, our target would be to have a devicetree declaring

regulator {
	compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
	... everything else ...
}

Cheers,
Angelo
