Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F188775EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHIMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:15:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425221982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:15:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe4762173bso11169164e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691583317; x=1692188117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxw/xaaJV3+Iip8T6jKXtUBlM5YfX4PgIk+tvcp/OHk=;
        b=mszWcv2iLSFJ0r4IjdINd8g0daJ4ysdCRmK04/kRytVSaUX65tI7NDjdr+6v5zIe+T
         xALfbDF2m1ZMGnIMC16uPQVXdbkwUEu05G4Vv8ZVZAe/b8pVeVYZsa8x8OiqpZJdHvzl
         XbX3t4Mv+cUHGxM4ohfT01p6z5IC3PfbBiqM41wNqCr+0tIb/zdjkaODMfcyU3AQEfVz
         HBgzc1mY2qMaO3V8sfQfqvvyU29Wiisf1K8hyqJ4BpMwoyGC8mI64W+xZzMW+AGAWeQI
         Zmkfa+6YS11NaWm3A8zQX8ZfrX3W1sl3nsQvvVi3YRtXf5UhXejkQt1lgxnzGY836ZKS
         7FIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691583317; x=1692188117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxw/xaaJV3+Iip8T6jKXtUBlM5YfX4PgIk+tvcp/OHk=;
        b=IzNU83wltQDpSTcqX8ytQq1Vh7gsFHypAT/Aqz5nO4b/hBaPatTGau4Sdop3gDRee+
         18SICmbK1ngHd5L48gA5cEJnTgnmpJKLaXQnobvFjQE0mrUNus0mDc8TiIhpT6Yv7Ek/
         hdPVQFQclabasSeByZhfL1UJLT3SGF+9QdHvEn0Zg32ORRlNBoKJB9XWEg+52JjotQmh
         s54SQ6WYjnTuWOl0oDldgUamPr0s0uHj1WeM2ENXfiugC+rJRerddKqsIAgYZbQUprqu
         LwzG9hsy+lsyhI+XB6jGS/ZsDXQjQOvDPNgJIv8v7e7vrcwOyg4cEKDGQy7Dq6KY6mnQ
         douw==
X-Gm-Message-State: AOJu0YwswHM7VGeXK4mJN/PHnP64DZQN9ugGZV22xPQCDyOilUMmQDyA
        weAXIYk0pXA7+z2lp5ZYEm1AJA==
X-Google-Smtp-Source: AGHT+IGf4sBYoS7qaPzoTQs2A+62/45io7Ja4q7AitEu8asjTCMlx/qzuiMy0oGQJpzCNjcoywPIYw==
X-Received: by 2002:a19:770a:0:b0:4f8:bfb4:e4c4 with SMTP id s10-20020a19770a000000b004f8bfb4e4c4mr1526108lfc.19.1691583317486;
        Wed, 09 Aug 2023 05:15:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id e6-20020ac25466000000b004f85d247069sm2274348lfn.218.2023.08.09.05.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:15:16 -0700 (PDT)
Message-ID: <15b545a2-14be-47ba-a665-8ae986a7f9cd@linaro.org>
Date:   Wed, 9 Aug 2023 14:15:14 +0200
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
 <0feda32e-5430-4f35-b18a-7afce63a970c@linaro.org>
 <d09df249-cc6d-9708-bfa6-ae5cc7929697@linaro.org>
 <4bd04709-155f-4750-8638-e73b653b1482@linaro.org>
 <0cba0158-8a9f-68b6-6bb3-dab0272a5ce0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0cba0158-8a9f-68b6-6bb3-dab0272a5ce0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 21:05, Bryan O'Donoghue wrote:
> On 07/08/2023 19:55, Konrad Dybcio wrote:
>> On 7.08.2023 20:49, Bryan O'Donoghue wrote:
>>> On 07/08/2023 19:45, Konrad Dybcio wrote:
>>>> That can be taken care of with match data.
>>>>
>>>> Konrad
>>>
>>> Well perhaps.
>>>
>>> I'm just sticking my oar in, to elucidate.
>>>
>>> The compat sub-nodes aren't just a random choice with no logic. They exist to select between what you assign the blocks to be, encoder, decoder or any admixture thereof.
>>>
>>> A functionality we want to maintain.
>> Surely something like a modparam would be more suitable here?
>>
>> Konrad
> 
> Hmm.
> 
> Well from earlier in the thread the question "why do we have these compat strings" is because we can have any combination of encoder/decoder assigned.
> 
> If there's a cogent argument _still_ to be made to transition to some new way of assignment then fine so long as we don't break that basic flexibility.
> 
> Though my own €0.02 is that a module parameter is more of a PITA than a compat string.
> 
> OTOH I could make the argument, that the high probability is most people - probably all, just instantiate a single encoder and decoder and aren't aware of or using the inbuilt flexibility.
> 
> @stan probably has the right idea what to do.
Actually..

Has anybody tested this, ever, with the mainline driver?

Do we have anyone using this?

Is anybody willing to maintain that, test for regressions and
fix them in a reasonable amount of time?


If we don't have at least 2x "yes" here, I don't think it makes sense
to worry about it..

Konrad
