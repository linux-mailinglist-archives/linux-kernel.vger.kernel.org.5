Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A471F7F401A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjKVI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjKVI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:29:56 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A09A;
        Wed, 22 Nov 2023 00:29:51 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1700641789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niGgf0XKP2t2Zirpm3py6uN4TsslbCqBZV8swChcUGg=;
        b=luqkiFNbDd6RWusGME8U43GdpWQmVFH6uGh/SeA8mjPpqqWUZjiYyAvcSlh9sV5lce7/vO
        IG7+5LekhVo61e4jR+mBvUp3MnXnsfUTKhsCcRxKG5DNecDwP4vMPtna+pTlfDgoXh6GqZ
        KK4twF/6W9Y41udae9CkgIastHp8o5IeFZxhSkVqr8StItMw0G6CXgxd5HcXuGCCaxFhw+
        K677kgapgPbS0Xm9zEfvJE0UxGKnth8RbWPlO1rCaMoqPP+/0+58Dyf2rVg9Ds6bTl3eQX
        wR8zSKh//XY965zoutJqNqDYel2x3Zt5H0gDg3exzshfTMc1ZsMCJq6l7MBjIg==
Date:   Wed, 22 Nov 2023 09:29:49 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wens@kernel.org,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
In-Reply-To: <7232a48b-b9ad-44b5-ae6a-d12dad70b3c4@linaro.org>
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <6b288a2e-d147-4bd3-b1d4-daf56295d939@gmail.com>
 <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
 <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
 <7232a48b-b9ad-44b5-ae6a-d12dad70b3c4@linaro.org>
Message-ID: <58a9caacc1226c7c3a2bdfe73ef1791f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-22 09:21, Krzysztof Kozlowski wrote:
> On 22/11/2023 09:09, Chen-Yu Tsai wrote:
>> On Wed, Nov 22, 2023 at 4:05 PM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> 
>>> On 21/11/2023 14:50, Rafał Miłecki wrote:
>>>>> +Order of Properties in Device Node
>>>>> +----------------------------------
>>>>> +
>>>>> +Following order of properties in device nodes is preferred:
>>>>> +
>>>>> +1. compatible
>>>>> +2. reg
>>>>> +3. ranges
>>>>> +4. Standard/common properties (defined by common bindings, e.g. 
>>>>> without
>>>>> +   vendor-prefixes)
>>>>> +5. Vendor-specific properties
>>>>> +6. status (if applicable)
>>>>> +7. Child nodes, where each node is preceded with a blank line
>>>>> +
>>>>> +The "status" property is by default "okay", thus it can be 
>>>>> omitted.
>>>> 
>>>> I think it would really help to include position of #address-cells 
>>>> and
>>>> #size-cells here. In some files I saw them above "compatible" that 
>>>> seems
>>>> unintuitive. Some prefer putting them at end which I think makes 
>>>> sense
>>>> as they affect children nodes.
>>>> 
>>>> Whatever you choose it'd be just nice to have things consistent.
>>> 
>>> This is a standard/common property, thus it goes to (4) above.
>> 
>> It's probably a mix, but AFAIK a lot of the device trees in tree have
>> #*-cells after "status". In some cases they are added in the board
>> .dts files, not the chip/module .dtsi files.
> 
> Existing DTS is not a good example :)
> 
>> 
>> +1 that it makes sense at the end as they affect child nodes.
> 
> I still insist that status must be the last, because:
> 1. Many SoC nodes have address/size cells but do not have any children
> (I2C, SPI), so we put useless information at the end.
> 2. Status should be the final information to say whether the node is
> ready or is not. I read the node, check properties and then look at the 
> end:
> a. Lack of status means it is ready.
> b. status=disabled means device still needs board 
> resources/customization

I agree with the "status" belonging to the very end, because it's both 
logical and much more readable.  Also, "status" is expected to be 
modified in the dependent DT files, which makes it kind of volatile and 
even more deserving to be placed last.
