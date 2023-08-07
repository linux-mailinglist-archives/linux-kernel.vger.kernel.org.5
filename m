Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD816772700
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjHGOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHGOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:05:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39C32727
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:04:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so70771121fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691417079; x=1692021879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKSrhcE5Bln8vQQGTHtL4QDZJ+tT1+92+NGnlfVJ2k0=;
        b=O0bP2X7Yu58QOiyOA57b5a+g7b72bAfdkW0yXkeQQdZZQiVjurj73+CUZMsll5txeS
         Uac1l9skbh9f7pHv9667e5ZIwgY9Tg4r9edtmpPfv9Z7rXTsj3IrAgS0keiC/Jjg63vd
         1BRYd79hMAYZBgQa5JUWPmS6/0A2jIMbv0zfcD/dzq5NkjgEU4RtH6GnHS4IZtwE86zH
         lECRrM3vB/iZgJ1+MwbnsVx1mVPeEyaDs2JPgxMG7D9UT7RAngjviNL7nfEljZbvWVrI
         REdj6p99L0cxiiE19jDuQ4BwXZwi7XILkIs6LOtl9BfbJ7mkCoNJ/XyT4hq0RyaBiNbj
         hF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417079; x=1692021879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKSrhcE5Bln8vQQGTHtL4QDZJ+tT1+92+NGnlfVJ2k0=;
        b=Wo6du6RWuv1Ei1wBHrQ3KDvBiOexjAKjJtx55fuiMvL/CiW7oD9aLRAwMFXErhS52y
         I8w5u7spiYhajkxUQweGTfEFA4uRDNY4V3kTA7rF3JP5mjUkz9ikwliWM+N+32Aw8TTV
         ak0RjQSUtnEWKb3Id18AxUb3YcTKUCfyi3q2GtV80IrZ4ytWKmMdQoU//bci2oAq//cm
         diPW11w1PvHoUdoa7vAXyoH/r5XyEA+BwGebZiyGSnqZzY66T9Y9h6ypMcLMVTe5hNZN
         W9jDjudwqP9Zg0RkSspOLRuATjiN5fiAekTvqh4dUUZeaCu57pVR8YrQ3riE16V8Nhwv
         HA1w==
X-Gm-Message-State: AOJu0YxtXIPgTBH9hLqYY1/X4IKUubq32u9g6V4PoEBG3W3OhDNv4/jY
        Ffn3RWxfsB9FqS9gRzeRN7CSgQ==
X-Google-Smtp-Source: AGHT+IHCrcRfDWUcueQ6OuYJVjkC4Z602JSHTqP1DbVPjQLQkoBsDryvz98IyZzcKGS29BVtwEritA==
X-Received: by 2002:a2e:a0cb:0:b0:2b9:cce3:a126 with SMTP id f11-20020a2ea0cb000000b002b9cce3a126mr6405556ljm.21.1691417079270;
        Mon, 07 Aug 2023 07:04:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709063a8800b0099316c56db9sm5158207ejd.127.2023.08.07.07.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 07:04:38 -0700 (PDT)
Message-ID: <ba40de82-b308-67b1-5751-bb2d95f2b8a5@linaro.org>
Date:   Mon, 7 Aug 2023 16:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <659e30a7-80f7-4fd8-af58-45505213a2ef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 14:41, Konrad Dybcio wrote:
> On 5.08.2023 21:29, Krzysztof Kozlowski wrote:
>> On 04/08/2023 22:09, Konrad Dybcio wrote:
>>> Both of these SoCs implement an IRIS2 block, with SC8280XP being able
>>> to clock it a bit higher.
>>>
>>
>> ...
>>
>>> +
>>> +  iommus:
>>> +    maxItems: 1
>>> +
>>> +  video-decoder:
>>> +    type: object
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        const: venus-decoder
>>
>> That's not how compatibles are constructed... missing vendor prefix, SoC
>> or IP block name.
>>
>>> +
>>> +    required:
>>> +      - compatible
>>> +
>>> +    additionalProperties: false
>>
>> Why do you need this child node? Child nodes without properties are
>> usually useless.
> For both comments: I aligned with what was there..
> 
> The driver abuses these compats to probe enc/dec submodules, even though
> every Venus implementation (to my knowledge) is implicitly enc/dec capable..

Holy crap, I see...

> 
> Perhaps a bigger clean-up is due. I guess I could just create the venc/vdec
> devices from the venus core probe and get rid of this fake stuff?

Few devices (qcom,msm8996-venus.yaml, sdm660, sdm845) have clocks there,
so we actually could stay with these subnodes, just correct the
compatibles to a list with correct prefixes:

qcom,sc8280xp-venus-decoder + qcom,venus-decoder

Best regards,
Krzysztof

