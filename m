Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C2772E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHGSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHGSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:45:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003321736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:45:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so75238041fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691433932; x=1692038732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38HrjyT6i/aVsxFHr+VbXIpwsezPIh0E2/80JReEaOQ=;
        b=FV/xjsJlU2e1sSDD4mDGS/tWpf61bWICtkZTcByRo+NyPFnLiZ5BnJtPrzTk5/V9Lc
         KqAi6Ajk8+LW6wTfC3RlBljBSEpWsJY9OuWmYtJe5KvaaxaSre6rqSAP8KKhBymvMpAJ
         Nr6Or2Hn/3l/KEcbWxDRFugTD7uFIEvglLAEVPVX8jtI0ofq1veofYL32iQjWmmFPJBj
         +XcEEBpZpVeWsTSrxIoO5Ib2os75LR4Lb0TkoIxwk0i8WC3z85B79ZYiRMTTHK1vdhT3
         BayP67zH7DoJn4iynV5vUhJwK2xOHHR5/VcHvp6inm1cFITq9lI/10v5fvmSlDf+HB0b
         1B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433932; x=1692038732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38HrjyT6i/aVsxFHr+VbXIpwsezPIh0E2/80JReEaOQ=;
        b=Urax1zg6Ask+qnlrmn3/WHgPrmxIrwbXbepZxDWUeNuvelV/O08z0YBKQiuB2OSsCo
         jx3REAsqfFILdzJAAC+Yx0f5Fgin+8YcF5wP374SwHIrjmK2Xu9qLlIwReA+eqjWSBbE
         y/sBf+92FlWiSJ8kXyeh5k8OXYhM76/xAu3auYR4ALsx+k4ym7Ohr2BUlC0B+/a+xaiw
         h5z824PvW/A8Ff27Rrs/GHEalKjjXrNzX7gJog3bWAdESIY1Wqs3KJBGUcWcsYHGxCLs
         SGEMtxeHIkP+LbpCGqzEm5Q8fcccd3lonZre7QO2GHhqstuiC4jbjIxxqN207tWZuFUE
         4Xcg==
X-Gm-Message-State: AOJu0YxbHXxz+u0fL0WweTwztdrs9GtjLBNTnxSUkkLyOildyCGo0iVt
        cfg2DGAyQMNQz1j6eYG1SH258A==
X-Google-Smtp-Source: AGHT+IHp8WGmQIARr8qeyndhlX98WtA953iinp7GeZpwvtnvucKA7Qr2bYTwUubrDOEUzuNCh4FIBA==
X-Received: by 2002:a2e:6a11:0:b0:2b5:7f93:b3b0 with SMTP id f17-20020a2e6a11000000b002b57f93b3b0mr7173204ljc.17.1691433931956;
        Mon, 07 Aug 2023 11:45:31 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e9b13000000b002b9f4841913sm1936258lji.1.2023.08.07.11.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 11:45:30 -0700 (PDT)
Message-ID: <0feda32e-5430-4f35-b18a-7afce63a970c@linaro.org>
Date:   Mon, 7 Aug 2023 20:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org>
 <84ab9380-2fb2-76f9-2eb9-71d9202718cc@linaro.org>
 <659e30a7-80f7-4fd8-af58-45505213a2ef@linaro.org>
 <ba40de82-b308-67b1-5751-bb2d95f2b8a5@linaro.org>
 <fa5dc696-6c67-49d0-b158-f1e3398813e2@linaro.org>
 <816359f7-ad4d-659f-db39-c971e1b1cd9a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <816359f7-ad4d-659f-db39-c971e1b1cd9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 20:44, Bryan O'Donoghue wrote:
> On 07/08/2023 16:02, Konrad Dybcio wrote:
>> On 7.08.2023 16:04, Krzysztof Kozlowski wrote:
>>> On 07/08/2023 14:41, Konrad Dybcio wrote:
>>>> On 5.08.2023 21:29, Krzysztof Kozlowski wrote:
>>>>> On 04/08/2023 22:09, Konrad Dybcio wrote:
>>>>>> Both of these SoCs implement an IRIS2 block, with SC8280XP being able
>>>>>> to clock it a bit higher.
>>>>>>
>>>>>
>>>>> ...
>>>>>
>>>>>> +
>>>>>> +  iommus:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  video-decoder:
>>>>>> +    type: object
>>>>>> +
>>>>>> +    properties:
>>>>>> +      compatible:
>>>>>> +        const: venus-decoder
>>>>>
>>>>> That's not how compatibles are constructed... missing vendor prefix, SoC
>>>>> or IP block name.
>>>>>
>>>>>> +
>>>>>> +    required:
>>>>>> +      - compatible
>>>>>> +
>>>>>> +    additionalProperties: false
>>>>>
>>>>> Why do you need this child node? Child nodes without properties are
>>>>> usually useless.
>>>> For both comments: I aligned with what was there..
>>>>
>>>> The driver abuses these compats to probe enc/dec submodules, even though
>>>> every Venus implementation (to my knowledge) is implicitly enc/dec capable..
>>>
>>> Holy crap, I see...
>>>
>>>>
>>>> Perhaps a bigger clean-up is due. I guess I could just create the venc/vdec
>>>> devices from the venus core probe and get rid of this fake stuff?
>>>
>>> Few devices (qcom,msm8996-venus.yaml, sdm660, sdm845) have clocks there,
>>> so we actually could stay with these subnodes, just correct the
>>> compatibles to a list with correct prefixes:
>>>
>>> qcom,sc8280xp-venus-decoder + qcom,venus-decoder
>> Hm.. looks like pre-845-v2 (with the v2 being "v2 binding" and not
>> "v2 chip" or "v2 hardware") these were used to look up clocks but
>> then they were moved to the root node.
>>
>> I am not quite sure if it makes sense to distinguish e.g.
>> sc8280xp-venus-decoder within sc8280xp-venus..
>>
>> Perhaps deprecating the "8916 way" (clocks under subnodes), adding
>> some boilerplate to look up clocks/pds in both places and converting
>> everybody to the "7180 way" way of doing things (clocks under venus),
>> and then getting rid of venus encoder/decoder completely (by calling
>> device creation from venus probe) would be better. WDYT?
>>
>> Konrad
> 
> As I understand it though, for some classes of venus hardware - earlier, it was possible to have two encoders or two decoders and it really didn't - perhaps still doesn't matter which order they are declared in.
> 
> That's the logic behind having a compat string that assigns either encoder or decoder to one of the logical blocks.
> 
> You can have any mixture of
> - encoder
> - decoder
> 
> - encoder
> - encoder
> 
> - decoder
> - decoder
> 
> - decoder
> - encoder
> 
> - encoder
> 
> - decoder
> 
> I think it should *still* be the case - whether it is a practical reality or not, that any of those mapping can be selected and supported.
That can be taken care of with match data.

Konrad
