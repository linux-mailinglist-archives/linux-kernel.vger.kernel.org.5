Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D67F4145
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjKVJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjKVJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:10:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CD3592
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:09:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c41e95efcbso895047266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700644157; x=1701248957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDFjP3+fhsNw2akKUYyFDvgsffeDkDBRgEKMO0HpZCE=;
        b=tRkcgQZvk4r3sZ43QvVIfizcm3DuRF7HkDVKfBUKzXwl/B3Qw+DdOBtJin+zCO0sTs
         HvPNDyReX4Acrl35ufgk4ofX/C1lYp0AkRTtg+SWSTrD/kUqrNRPAT9HXBhiUCB4USHF
         WAlhEcQme492Zmj0FxIfY6frjHrAOgCKW14MCl89wxlP4l7k+kZkN5TYOs0BMEBpAdjb
         +jMNdU8yFf2ZCiaqBAW0VHSte/ohceNQyPSuP2RAC8qqmMBZ7XlxbL719SHxfrrjE26/
         3pD9n0ZfGvs73ZrIqXLyEGKBCSqsC35SFVDBQLJEvxlxKWp7Sjb0+yu7k8NULi5rqYO9
         9+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644157; x=1701248957;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDFjP3+fhsNw2akKUYyFDvgsffeDkDBRgEKMO0HpZCE=;
        b=ZthYtNcq6VwU/iBb8hlbsifLU4epaSrE3lWwQuEnXgUfjO0L/mu27lbusK+k+cBSjs
         PrVA8xOEzaPxofM9+0HZ/i4SNW8leTjdHik3sFTZNvNesf+cuiv9qWOHEG/nw1NrhkFS
         UGnHFpNqQgNajvqFDuJWewnkvNfQYBQPptBidbQMA7E284twsZu38YEdhUcFDFZymx5a
         s6mrLpl4YkkolFzBxpkXwZcb2MNoRpVh/IDwf9oINufK8EOk8LYrumA4diNriR3r3HtO
         IkmF/mikVjNQ6GswcgAcPCfpzW64kUmZakPd1VQz3zh3eGkAsKv2N/5y+HJWuxfqMRVB
         KVGg==
X-Gm-Message-State: AOJu0YzRxLR6xHeyQ2Z0YrcmjIkRiYnPWKuAXMxWZgM5GCe2ZEvZ0VdO
        2xC5bLHb6YXq1Lx+5nu8EnFKMA==
X-Google-Smtp-Source: AGHT+IFZl7wEgdnoEFdZt9B2cqKnVzkpgrZ9sNjK/LyuMgkAxnpNZnVfrON3J8adQtDbtSUeNatAmw==
X-Received: by 2002:a17:906:f0c2:b0:9fc:1236:beff with SMTP id dk2-20020a170906f0c200b009fc1236beffmr1098949ejb.65.1700644157026;
        Wed, 22 Nov 2023 01:09:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090637cf00b009fee12d0dcdsm3392502ejc.15.2023.11.22.01.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:09:16 -0800 (PST)
Message-ID: <2ced2e38-e81d-4f9b-a6c0-6ac2d1a0fff9@linaro.org>
Date:   Wed, 22 Nov 2023 10:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dragan Simic <dsimic@manjaro.org>, wens@kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <6b288a2e-d147-4bd3-b1d4-daf56295d939@gmail.com>
 <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
 <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
 <7232a48b-b9ad-44b5-ae6a-d12dad70b3c4@linaro.org>
 <58a9caacc1226c7c3a2bdfe73ef1791f@manjaro.org>
 <cc4c789c-b595-41eb-b543-9e03549c6e61@amd.com>
 <CAMuHMdWm-gRPHeHyuX3_eR+9chJEw3iiZwCNBnoiRPHzoMAs6w@mail.gmail.com>
 <808270d3-2274-4fb7-a397-38538503b67c@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <808270d3-2274-4fb7-a397-38538503b67c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 09:57, Michal Simek wrote:
> Hi Geert,
> 
> On 11/22/23 09:53, Geert Uytterhoeven wrote:
>> Hi Michal,
>>
>> On Wed, Nov 22, 2023 at 9:50 AM Michal Simek <michal.simek@amd.com> wrote:
>>> On 11/22/23 09:29, Dragan Simic wrote:
>>>> On 2023-11-22 09:21, Krzysztof Kozlowski wrote:
>>>>> On 22/11/2023 09:09, Chen-Yu Tsai wrote:
>>>>>> On Wed, Nov 22, 2023 at 4:05 PM Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> On 21/11/2023 14:50, Rafał Miłecki wrote:
>>>>>>>>> +Order of Properties in Device Node
>>>>>>>>> +----------------------------------
>>>>>>>>> +
>>>>>>>>> +Following order of properties in device nodes is preferred:
>>>>>>>>> +
>>>>>>>>> +1. compatible
>>>>>>>>> +2. reg
>>>>>>>>> +3. ranges
>>>>>>>>> +4. Standard/common properties (defined by common bindings, e.g. without
>>>>>>>>> +   vendor-prefixes)
>>>>>>>>> +5. Vendor-specific properties
>>>>>>>>> +6. status (if applicable)
>>>>>>>>> +7. Child nodes, where each node is preceded with a blank line
>>>>>>>>> +
>>>>>>>>> +The "status" property is by default "okay", thus it can be omitted.
>>>>>>>>
>>>>>>>> I think it would really help to include position of #address-cells and
>>>>>>>> #size-cells here. In some files I saw them above "compatible" that seems
>>>>>>>> unintuitive. Some prefer putting them at end which I think makes sense
>>>>>>>> as they affect children nodes.
>>>>>>>>
>>>>>>>> Whatever you choose it'd be just nice to have things consistent.
>>>>>>>
>>>>>>> This is a standard/common property, thus it goes to (4) above.
>>>>>>
>>>>>> It's probably a mix, but AFAIK a lot of the device trees in tree have
>>>>>> #*-cells after "status". In some cases they are added in the board
>>>>>> .dts files, not the chip/module .dtsi files.
>>>>>
>>>>> Existing DTS is not a good example :)
>>>>>
>>>>>>
>>>>>> +1 that it makes sense at the end as they affect child nodes.
>>>>>
>>>>> I still insist that status must be the last, because:
>>>>> 1. Many SoC nodes have address/size cells but do not have any children
>>>>> (I2C, SPI), so we put useless information at the end.
>>>>> 2. Status should be the final information to say whether the node is
>>>>> ready or is not. I read the node, check properties and then look at the end:
>>>>> a. Lack of status means it is ready.
>>>>> b. status=disabled means device still needs board resources/customization
>>>>
>>>> I agree with the "status" belonging to the very end, because it's both logical
>>>> and much more readable.  Also, "status" is expected to be modified in the
>>>> dependent DT files, which makes it kind of volatile and even more deserving to
>>>> be placed last.
>>>
>>> I am just curious if having status property at the end won't affect
>>> execution/boot up time. Not sure how it is done in Linux but in U-Boot at least
>>> (we want to have DTs in sync between Linux and U-Boot) of_find_property is
>>> pretty much big loop over all properties. And status property defined at the end
>>> means going over all of them to find it out to if device is present.
>>> Not sure if Linux works in the same way but at least of_get_property is done in
>>> the same way.
>>
>> As the default is "okay", you have to loop over all properties anyway.
> 
> No doubt if you don't define status property that you need to loop over all of 
> them. We normally describe the whole SOC with pretty much all IPs status = 
> disabled and then in board file we are changing it to okay based on what it is 
> actually wired out.
> It means on our systems all nodes have status properties. If you have it at 
> first you don't need to go over all.

We never sacrificed code readability in favor of code execution speed,
so neither should we do it here.

If the speed is a problem, project can still add a flag to dtc to
re-shuffle properties in FDT depending on its needs.

Best regards,
Krzysztof

