Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F27DCA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjJaKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjJaKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:06:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54AFD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:06:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507c1936fd5so7327592e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698746807; x=1699351607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSMdT3bgIwz4v1Mx9wkamTkECO9XGv8qtfa6U2f2xS4=;
        b=oh9TIwDCR9EcjGFT8bTTcrgh42egGpipwBq2+pADqlqu1x6H1D0+Dz0Gw2I31YChF4
         lciZ/p82eouqet/cc47TrBapQ0OrJK+4oSq3WVJfwFjCRTQtySRf08mUJc/z2/1la/Dz
         74gQgaZ39q2rQwIH1g9f0KoooqHDznp/kvLMytPWMu+5W8Nf5FqIX3AD5Xw3V011gdql
         p2vZ+kMpLQMnRQQn4pH60repNQU/ATaPlDbul2bvCmB88AwiY1C63I+tZCPS4A842wdk
         VFAiehLS4a1nJjYqNTdQ4k7P+s5a5oB0cFHIgC8ILoi+SP0p7VST4fJl27NcqmeT4v0c
         mMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746807; x=1699351607;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSMdT3bgIwz4v1Mx9wkamTkECO9XGv8qtfa6U2f2xS4=;
        b=TpluXIqHGUpjAS8JzJoZ2RJfBoMFOQEU+CV7bQse2UlJiRrTWtqKIxrqGoH8TOzSSm
         mZRkOvf5iPCpx4qrxDPKzPc1UqEqxCXYOqUOLuBigtXesRIo7ukthouZatijhbH1flyD
         L67mMj3doxKgVWEliAYWZfMgKpGXKIGN4YJ7Yx9OGd1+VIZp7N13LlwUR8PIJFeLPaZy
         NYtfj2djAtGzYXumWJ/dxLH9XoDS/s42YVJ928DH3673r63E7pwNjzyR6+63pcxrCFCr
         uxyIRPjBaFf4l2ZxVGxVPWbY8dsZWmaNTfRkdiXJmHG8h7zpIGriwX9Yhl0JWUbyiXG3
         VHjw==
X-Gm-Message-State: AOJu0YzxLMMxdUkoMmKgA9I0n4bl77job+buDm9uRJBobDucM7cgGxIW
        1NfnGbMC8Kh836RC4mO/sNOOeg==
X-Google-Smtp-Source: AGHT+IFjtOa7kZn7L0qpsXnsTCc9IAB5Kfl8q9+JEvUP0t2bkIxxZzFFlR25mBlrP5/0f8RQV6SzJA==
X-Received: by 2002:a05:6512:3ca9:b0:505:7163:c132 with SMTP id h41-20020a0565123ca900b005057163c132mr845191lfv.7.1698746807170;
        Tue, 31 Oct 2023 03:06:47 -0700 (PDT)
Received: from [192.168.143.96] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id i21-20020a056512341500b00507a0098421sm165357lfr.181.2023.10.31.03.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:06:46 -0700 (PDT)
Message-ID: <7d4140bb-9cc6-4686-8794-9388c7ab0792@linaro.org>
Date:   Tue, 31 Oct 2023 11:06:44 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <eda1c91bd2dce76e633dd82ad3105355@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.2023 08:20, Nikita Travkin wrote:
> Konrad Dybcio писал(а) 31.10.2023 02:48:
>> On 27.10.2023 16:42, Nikita Travkin wrote:
>>> When initially added, a mistake was made in the definition of the codec.
>>>
>>> Despite the fact that the DMIC line is connected on the side of the
>>> codec chip, and relevant passive components, including 0-ohm resistors
>>> connecting the dmics, are present, the dmic line is still cut in
>>> another place on the board, which was overlooked.
>>>
>>> Correct this by replacing the dmic configuration with a comment
>>> describing this hardware detail.
>>>
>>> While at it, also add missing regulators definitions. This is not a
>>> functional change as all the relevant regulators were already added via
>>> the other rail supplies.
>>>
>>> Fixes: 4a9f8f8f2ada ("arm64: dts: qcom: Add Acer Aspire 1")
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>> index cfde8cd47107..00b442696618 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>> @@ -209,9 +209,22 @@ alc5682: codec@1a {
>>>  		AVDD-supply = <&vreg_l15a_1p8>;
>>>  		MICVDD-supply = <&reg_codec_3p3>;
>>>  		VBAT-supply = <&reg_codec_3p3>;
>>> +		DBVDD-supply = <&vreg_l15a_1p8>;
>>> +		LDO1-IN-supply = <&vreg_l15a_1p8>;
>>> +
>>> +		/*
>>> +		 * NOTE: The board has a path from this codec to the
>>> +		 * DMIC microphones in the lid, however some of the option
>>> +		 * resistors are absent and the microphones are connected
>>> +		 * to the SoC instead.
>> Would that not also require more DT changes and maybe UCM?
> 
> I don't think I had any other descriptions to support the dmic in
> the initial set (first audio support for this board is 3/3 here)
> and there is no upstream UCM yet - I will probably hold it off until
> I get vamacro and dmic on it working.
I was told that VAMACRO is "the easiest thing possible to get going"
(paraphrasing), did you go through something like this sequence [1]?

https://git.linaro.org/people/srinivas.kandagatla/alsa-ucm-conf.git/tree/ucm2/codecs/qcom-lpass/va-macro/DMIC0EnableSeq.conf?h=x13s&id=244979b03f5b9284e6a68eae6f9995f6ac735be8

Konrad
