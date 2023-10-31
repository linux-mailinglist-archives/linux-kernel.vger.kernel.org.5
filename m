Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A08E7DCB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJaK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:58:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892983
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:58:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c51388ccebso76862431fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698749896; x=1699354696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wskmTZLs/ovy4+9y4GREQnYyb7qMPFdwIaMr9ijmM0=;
        b=zN63c5XdQVAqaphpCEP33pZ3tSgOfKFoIqatdrfy2rjIjKTKkv+z4KX/FHzgwRVLYy
         ozdJtIeXEXvlPtoqsxTkAHSb23nGN+zufZ6JXXrPMS3Ku+fsYIIgo7eGhag9YfJEWFix
         4Tfvdru7Us03tLDi25hlOdOG5z5CSu4PUMudVzqMOLg70+COWHy/FOH9Nxuczr0/dAsi
         rRQTNZLjQOK/eXn4FNxnEM3+HZ3bwcDbUU4bhKiK169TATGreNRz4z2ylwORZSjQdm8l
         i9xWZEcZk9raZHU0+lf8YS0GRpjMWZ/H3vms+KXtIAFy0DaY9C7gbMQB8TdzZmCEs8Vl
         pwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698749896; x=1699354696;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wskmTZLs/ovy4+9y4GREQnYyb7qMPFdwIaMr9ijmM0=;
        b=a/tDeVT6w6OrTMyNByc+lWUBSckoU2Yx22w4NQ82LLhHIuJsqYQ/S/aTAgEVdhQsWl
         P3TUKahEi5X/6a0GILkvC0x2lu4H6CLqYE0RcyQVbkz2Xd9Xgb7gCcEEaeXgfhSTQwuB
         0vUj7bjmhknRo0nnkg2Ih7c1ZUHWWVTrE+ZlydF/VIrK7hvBt3B0k49/s2x/8nEhPZHV
         np51KjG7k0m0c23PPYRxO2aD9QZ01sAZZK3ighOF79rFSvMYz9pg86ZAqZLF+OrZNzMy
         bKSDfdq3UjT5JyOhNkCOT28WYs8/YKrb1rrMJyneb9L5QW9mKTnR+RZzjYDhnt3XA6Jt
         9gwQ==
X-Gm-Message-State: AOJu0YyPGvOivzc/zgNEQFo5+znuWRgD+aQq3nwfhYMzj4lGBdeRIdxI
        Voza3qkHP6sOQyMwaVeX4zTXAQ==
X-Google-Smtp-Source: AGHT+IHIvA8ZGe/Uu8b5tTVmLU0wRZeyrtcYXyj8tzOxI33AZaOIoZp6/tOOEDj4hWSrBZ/q3i8qsg==
X-Received: by 2002:a2e:731a:0:b0:2c5:6d8:8dfc with SMTP id o26-20020a2e731a000000b002c506d88dfcmr9015199ljc.13.1698749896219;
        Tue, 31 Oct 2023 03:58:16 -0700 (PDT)
Received: from [192.168.143.96] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id 25-20020a2e1319000000b002b6e77e87fcsm167127ljt.68.2023.10.31.03.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:58:15 -0700 (PDT)
Message-ID: <2e5517e9-71b5-461c-9576-0f1e52c40fc2@linaro.org>
Date:   Tue, 31 Oct 2023 11:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: acer-aspire1: Correct audio codec
 definition
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-2-5ff3cf8b5701@trvn.ru>
 <3a423cb7-cdf1-433a-a848-8636917640bb@linaro.org>
 <eda1c91bd2dce76e633dd82ad3105355@trvn.ru>
 <7d4140bb-9cc6-4686-8794-9388c7ab0792@linaro.org>
 <66fa9aff9a7c4b3bbd980f90aed5a62e@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <66fa9aff9a7c4b3bbd980f90aed5a62e@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.2023 11:48, Nikita Travkin wrote:
> Konrad Dybcio писал(а) 31.10.2023 15:06:
>> On 31.10.2023 08:20, Nikita Travkin wrote:
>>> Konrad Dybcio писал(а) 31.10.2023 02:48:
>>>> On 27.10.2023 16:42, Nikita Travkin wrote:
>>>>> When initially added, a mistake was made in the definition of the codec.
>>>>>
>>>>> Despite the fact that the DMIC line is connected on the side of the
>>>>> codec chip, and relevant passive components, including 0-ohm resistors
>>>>> connecting the dmics, are present, the dmic line is still cut in
>>>>> another place on the board, which was overlooked.
>>>>>
>>>>> Correct this by replacing the dmic configuration with a comment
>>>>> describing this hardware detail.
>>>>>
>>>>> While at it, also add missing regulators definitions. This is not a
>>>>> functional change as all the relevant regulators were already added via
>>>>> the other rail supplies.
>>>>>
>>>>> Fixes: 4a9f8f8f2ada ("arm64: dts: qcom: Add Acer Aspire 1")
>>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 17 +++++++++++++++--
>>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>>> index cfde8cd47107..00b442696618 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>>> @@ -209,9 +209,22 @@ alc5682: codec@1a {
>>>>>  		AVDD-supply = <&vreg_l15a_1p8>;
>>>>>  		MICVDD-supply = <&reg_codec_3p3>;
>>>>>  		VBAT-supply = <&reg_codec_3p3>;
>>>>> +		DBVDD-supply = <&vreg_l15a_1p8>;
>>>>> +		LDO1-IN-supply = <&vreg_l15a_1p8>;
>>>>> +
>>>>> +		/*
>>>>> +		 * NOTE: The board has a path from this codec to the
>>>>> +		 * DMIC microphones in the lid, however some of the option
>>>>> +		 * resistors are absent and the microphones are connected
>>>>> +		 * to the SoC instead.
>>>> Would that not also require more DT changes and maybe UCM?
>>>
>>> I don't think I had any other descriptions to support the dmic in
>>> the initial set (first audio support for this board is 3/3 here)
>>> and there is no upstream UCM yet - I will probably hold it off until
>>> I get vamacro and dmic on it working.
>> I was told that VAMACRO is "the easiest thing possible to get going"
>> (paraphrasing), did you go through something like this sequence [1]?
>>
> 
> The problem is that no one introduced it for sc7180 - it's not
> in the dtsi. And so isn't the lpass-tlmm I'd need...
> 
> So the set of due changes per my understanding is like:
> 
>  - Add va-macro to sc7180 (need new compatible/fallback)
>  - Add relevant clocks for it (seems to be firmware backed, so easy?)
yes

>  - Add lpass-tlmm (it seems like we add a new driver for each soc
>    even if they are same? Are they same?)
there are rare cases when it's identical

>  - Add va macro dma dais to the asoc boardfile (trivial)
y

>  - Finally, add the dmic to the board dts and enable in the UCM
>    (also trivial)
y

> So I decided to follow the "release early, release often" and
> only introduce partial sound for now, following it up with
> all above later.
Sure that makes sense, just wanted to make sure you know about this

Konrad

> 
>> https://git.linaro.org/people/srinivas.kandagatla/alsa-ucm-conf.git/tree/ucm2/codecs/qcom-lpass/va-macro/DMIC0EnableSeq.conf?h=x13s&id=244979b03f5b9284e6a68eae6f9995f6ac735be8
> 
> Thanks, this is useful to have, I was indeed looking at
> x13s for dmic/vamacro example after I realized my board
> tricked me and it's not how trogdor does it...
> 
> Nikita
