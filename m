Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED0772881
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHGPCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjHGPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:02:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8410CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:02:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1344b707so7218205e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691420546; x=1692025346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7Lgg7kjrbEt45qFR8K/nxw0x7tFUualnc3Ld3Cm0jg=;
        b=BT4SIJJV6GJIPCL23DUMJMBHHtMnQznH+vfM05AG7WxxWsN/Ht/OQr7Fvi933rw+rK
         SA/zJ8kzhiCxmTMkw+VOx0E5+/kTIsUvCACkPgVGcL8YQT1DAtlgcBKv7mb/hRFDHlOy
         sKJwqAUb9PUHDYw6AI0J2mO84tD+glmY5OdvcKm2YtNf8+07iqdg4e6Tuhl0xrCh/QKN
         vIjCjeU39tM+EsxSHakayFoNbfGdAphhdE5zWovrXUMv/oLh5Hdki1f4BYRuZ/8XV6sy
         7jWTlqV6sQ3m3Ikwlq3jH7C+l0AbL0mf2rfUgh6d695CKy+tjTXE5c0PMTPJOB8bwU+/
         Qdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420546; x=1692025346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7Lgg7kjrbEt45qFR8K/nxw0x7tFUualnc3Ld3Cm0jg=;
        b=A7l6vB4zayLqo0VkcaF8aVRZxuyXO2D6GCgTkYT8mHLXT7scdikCV+a1ttaztk6VHe
         lvoMyibkKAJ20eKK69i5JK+0t37b9JBK+jvxuGAWwChbGJLhCfWvxUPBsHVWGVuSkPDK
         mhb1gFkD764I+BU1EvV6Aay0xFmZ86J2CFbkK36ctJHh5nrrvKAQMwezmxhpHlhWAZnB
         plhkis0v2ZQYr54SSBFdWvfLvo8kvxEfLnw1CJm+fqoMFwMYOSSTboFfboumGIPhxMjV
         nCTKJIeaOFeLPkgqYyPqkLQkNJ3zKZPa/CM62TtR1IiGPv2Kc2BFUzOLwMWAGo7jwQJ1
         LFkg==
X-Gm-Message-State: AOJu0Yz68nVG1v+zR04pSnWREuWECgKQ3TE79JycBw2/4ReYCwqYGpes
        WXIqkDXmCu5TLdvgPX44ZEyG/g==
X-Google-Smtp-Source: AGHT+IHrsH4P+p4KSysynUg8ELybOz5I9LSJST5r4WGlQ2Y72bIN8g0aTOqpn5P1jaSGRD1FAQEPlQ==
X-Received: by 2002:a05:6512:2348:b0:4fb:73ce:8e7d with SMTP id p8-20020a056512234800b004fb73ce8e7dmr7154064lfu.15.1691420545659;
        Mon, 07 Aug 2023 08:02:25 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id f23-20020ac25337000000b004fbb1f7352csm1514948lfh.72.2023.08.07.08.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:02:25 -0700 (PDT)
Message-ID: <fa5dc696-6c67-49d0-b158-f1e3398813e2@linaro.org>
Date:   Mon, 7 Aug 2023 17:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ba40de82-b308-67b1-5751-bb2d95f2b8a5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 16:04, Krzysztof Kozlowski wrote:
> On 07/08/2023 14:41, Konrad Dybcio wrote:
>> On 5.08.2023 21:29, Krzysztof Kozlowski wrote:
>>> On 04/08/2023 22:09, Konrad Dybcio wrote:
>>>> Both of these SoCs implement an IRIS2 block, with SC8280XP being able
>>>> to clock it a bit higher.
>>>>
>>>
>>> ...
>>>
>>>> +
>>>> +  iommus:
>>>> +    maxItems: 1
>>>> +
>>>> +  video-decoder:
>>>> +    type: object
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        const: venus-decoder
>>>
>>> That's not how compatibles are constructed... missing vendor prefix, SoC
>>> or IP block name.
>>>
>>>> +
>>>> +    required:
>>>> +      - compatible
>>>> +
>>>> +    additionalProperties: false
>>>
>>> Why do you need this child node? Child nodes without properties are
>>> usually useless.
>> For both comments: I aligned with what was there..
>>
>> The driver abuses these compats to probe enc/dec submodules, even though
>> every Venus implementation (to my knowledge) is implicitly enc/dec capable..
> 
> Holy crap, I see...
> 
>>
>> Perhaps a bigger clean-up is due. I guess I could just create the venc/vdec
>> devices from the venus core probe and get rid of this fake stuff?
> 
> Few devices (qcom,msm8996-venus.yaml, sdm660, sdm845) have clocks there,
> so we actually could stay with these subnodes, just correct the
> compatibles to a list with correct prefixes:
> 
> qcom,sc8280xp-venus-decoder + qcom,venus-decoder
Hm.. looks like pre-845-v2 (with the v2 being "v2 binding" and not
"v2 chip" or "v2 hardware") these were used to look up clocks but
then they were moved to the root node.

I am not quite sure if it makes sense to distinguish e.g.
sc8280xp-venus-decoder within sc8280xp-venus..

Perhaps deprecating the "8916 way" (clocks under subnodes), adding
some boilerplate to look up clocks/pds in both places and converting
everybody to the "7180 way" way of doing things (clocks under venus),
and then getting rid of venus encoder/decoder completely (by calling
device creation from venus probe) would be better. WDYT?

Konrad
