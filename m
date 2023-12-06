Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF0806FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378245AbjLFMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378058AbjLFMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:31:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95491D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:31:09 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1a496a73ceso96024966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865868; x=1702470668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yi4zOH5EgQ6KZ7fi+yXGQ0dznNFg3ENppTL/x2upyeQ=;
        b=uvlailFVAhFVKw8+TZ1bqtbhtoWykUD7iN4z03PkE6x4Z5p9MMghPbeF+aYbrmnHjz
         t4TIanJE5heC8oTTarUP9Gf9Sz34vsLGwKueOTyUKMbRiX4cgChz0AmrQBtXiJ0MmBW+
         cAHoP7R6aH5ct3ygpTGQ1BkCFn+NDRwUeGMSGOsC8LzDOIa7LH+mm0o1rkO0eAlvPg1/
         JCtDafZuYj49SFZKOQ5d/J5v5Rcms8cT1m8/VfrmEHd/zcgeCjonnrmLYwBdC6T4yvGs
         LSQPVCjqsyFiF2HT1iPbihzj61Af5gsdfWTF9Y/2AhtIgWmIDMgRf5Z58IrAmCthTGeT
         AEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865868; x=1702470668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yi4zOH5EgQ6KZ7fi+yXGQ0dznNFg3ENppTL/x2upyeQ=;
        b=uggu5qX0+oGTeXgrv8kt7KgSj2XtCZq3DE8L1FYLtTzl9zVqhSd79ZmpgTdZZGnBmu
         pUl5PgUn+WwUtktMbuWOMjSE4s2RG+mJftlQCAfrJiF1mqdLwS6MgXEkaJgQ32Bat1wT
         Lwty9dHNBpHJYI5o4wlTRYZB1jRbAe2uHTwo7CNKN3Gl0eu30ExCv8Gq5YXmyesbDq31
         Mg80Ido9fA7iAKCwlIstBOUdaGDZ8oe30PU9UlQWYgb+wbXQO0WrcoA89UjTHFkLwLPI
         U+0fD9zHKPsTfRZIuvjgo6VNl+J5cyRTc2836dQ/GL0g+onUolB9UBwmhRYsHU/aIB3I
         nI7g==
X-Gm-Message-State: AOJu0YyirTqBOVhuJ9VdHYA8V2ssnZHICUIqM3pxfiudJDMM0XtRoKqy
        KklC6PUD1O6rQSSUr3rPU0re6w==
X-Google-Smtp-Source: AGHT+IHaBw6MjX2oi33Xl9n5xImePCY+aIpkG3Iu6AvHiQ23BQY7VFb/VWXrWuwj2kD215YHS9NnUQ==
X-Received: by 2002:a17:907:9150:b0:a19:a19b:78c8 with SMTP id l16-20020a170907915000b00a19a19b78c8mr466712ejs.139.1701865868123;
        Wed, 06 Dec 2023 04:31:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bh15-20020a170906a0cf00b00a1d754b30a9sm1084975ejb.86.2023.12.06.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:31:07 -0800 (PST)
Message-ID: <a1cfc6af-080c-4aa1-8200-e230640f7ca3@linaro.org>
Date:   Wed, 6 Dec 2023 13:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: ipq9574: Fix USB
 'vdda-pll-supply'
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <f98bbf0a515236709d999010f08c8f2470a31209.1701160842.git.varada@hu-varada-blr.qualcomm.com>
 <832a6d4f-f561-4cf5-b1cb-7e4b2d4d50b4@linaro.org>
 <ZWW9oF24YUGfev+2@hu-varada-blr.qualcomm.com>
 <0acdc122-b7fa-4bb4-b838-6420cd43d0e0@linaro.org>
 <ZXBdHQpJYBmZbd76@hu-varada-blr.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZXBdHQpJYBmZbd76@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 12:38, Varadarajan Narayanan wrote:
> On Tue, Nov 28, 2023 at 03:01:12PM +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2023 11:14, Varadarajan Narayanan wrote:
>>> On Tue, Nov 28, 2023 at 09:51:50AM +0100, Krzysztof Kozlowski wrote:
>>>> On 28/11/2023 09:46, Varadarajan Narayanan wrote:
>>>>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>
>>>>> The earlier patch ec4f047679d5, incorrectly used 'l2'
>>>>> as the vdda-pll-supply. However, 'l5' is the correct
>>>>> ldo that supplies power to the USB PHY.
>>>>>
>>>>> Fixes: ec4f047679d5 ("arm64: dts: qcom: ipq9574: Enable USB")
>>>>
>>>> Doesn't this depend on the driver change?
>>>
>>> Yes, will mention in the cover letter.
>>
>> This commit should have it in its changelog ---
>>
>>>
>>>> It affects both existing
>>>> kernel and backports which you claim here should happen.
>>>
>>> Ok. Will include stable@vger.kernel.org in the next revision.
>>
>> I wasn't speaking about Cc. You indicated this should be backported.
>> Then please backport it, without previous commit, and check the result.
>> Is stable tree working correctly or not?
> 
> Without the previous commit, it would fail in both the latest
> and stable tree. (Please see below for the error messages and
> stack dump)
> 
> The previous commit is necessary for this commit to work.

Yep, exactly. It's visible from the patches. I don't know how to solve
this exactly. The Fixes tag here is logically correct, but then any
backporting must include previous commit. Dependency can be provided in
cc-stable tag, but you did not cc-stable, I suppose on purpose.

If this is chosen by AUTOSEL, are you going to check if backport
includes previous patch and object/review such backport?

Best regards,
Krzysztof

