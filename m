Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8E7AD638
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjIYKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIYKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:40:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED863E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:40:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso58757145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695638436; x=1696243236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcG6dKqnPh6NDWonuBzt7zJSnIN1u16MKiy+tQ6e/Pc=;
        b=o4E8g2jUEaCZPwg9cw2P2CiOyLLoy+Ezi3en1lwSls2m4LewTguu3GTiDBCjhn6ouQ
         69y08H01XB9eVit8/vWLXpXH38HM/EoPv9Uh6FCIDvLihqd42u/gRpPKRiPnXyvlLIbp
         QImwGp7rRTql/GRZnXgbxPnPT382KE6Gw8zylpBPWLFFF08qwas0Zl4eFgDmsXE+Ku1p
         OJNa/PsYBHoQLS6mWJEWOicBhjNfQ82gaNfMs5tBY0OTecdwSbygIacBawDxqbAYESGb
         xt9YzzTNElJGWD+ddooxutDGcSPsccoSN+ewsrwpAiCOqEcji8EuUwHFNTgLaB4k+/yp
         beKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638436; x=1696243236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcG6dKqnPh6NDWonuBzt7zJSnIN1u16MKiy+tQ6e/Pc=;
        b=mreSlze7g68A5Oo6n0KMMlI+0ea0Ab9NUOysdZaF2JN7KC4aAnBPhTVy14ZXsrBOfn
         vNVols1sjtXpknjd7JpfS9FGaFQLzDbnBL/8TTLlrk3P5YoJTXpogDbRvVIOfaNnX4Sx
         A/WOpU8ScOs6GX5rc7w7484z72NZkcYwLSpc+dZIKAW1DzPgMeyHJ53Aa9g+BYxVTtRp
         5itA5raf/9csWXuE1aY5RMGIXcU42hedbUXeV+9F2DcgLpWLlLGA1CVA206E2UVwM0fl
         PWBbE8et5EBU7OLNnn/59HCQWLVb4VsfN7xSAH4Xulosguf3buMAHQ4ZE3Luf1O3uOEP
         lWyA==
X-Gm-Message-State: AOJu0YzBZWWh3OuquCJrQds8abaWxYNBnwlJMqRrAtAKrGwpjWmYcRtB
        5GFo4DmYR2zACDOaa8Z6wwYikQ==
X-Google-Smtp-Source: AGHT+IF8RCL56K/TNhChvR9Sd1sg5Sx9S2AOrq1y9gBazy2tDjoJGXyUNiPgazwA7mFfRddMbd8H/Q==
X-Received: by 2002:a5d:4006:0:b0:31f:4173:2ac8 with SMTP id n6-20020a5d4006000000b0031f41732ac8mr5457073wrp.18.1695638436415;
        Mon, 25 Sep 2023 03:40:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm11486283wru.41.2023.09.25.03.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:40:35 -0700 (PDT)
Message-ID: <fbb3adde-3c2b-4748-aaa9-8b63fdbf6082@linaro.org>
Date:   Mon, 25 Sep 2023 12:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-2-srichara@win-platform-upstream01.qualcomm.com>
 <f4fa94ab-78fb-d01b-7188-c498ec3053ff@linaro.org>
 <21caae64-b8db-ed1f-2275-a7279227cf92@quicinc.com>
 <a225833f-e645-48cc-a0e9-103999064548@linaro.org>
 <8922b2f1-7869-409c-8974-d2560d72f454@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8922b2f1-7869-409c-8974-d2560d72f454@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 12:31, Sricharan Ramabadhran wrote:
> 
> 
> On 9/25/2023 12:16 PM, Krzysztof Kozlowski wrote:
>> On 25/09/2023 04:06, Sricharan Ramabadhran wrote:
>>>
>>>
>>> On 9/23/2023 5:14 PM, Krzysztof Kozlowski wrote:
>>>> On 22/09/2023 13:51, Sricharan R wrote:
>>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>>
>>>>> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
>>>>
>>>> Then why do you allow two interrupts?
>>>>
>>>    infact there is only one interrupt. Will fix in the binding
>>>    description.
>>
>> Description? So you still allow two interrupts? No, this must be
>> constrained in allOf:if:then.
>>
> 
>   ok, it should be fine to add this new compatible to the existing
>   allof:if:then block of v1 targets ? (Because they also have same
>   single interrupt (uplow) constraint)

Yes.

Best regards,
Krzysztof

