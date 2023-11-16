Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50C7EE01A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjKPLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:47:14 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9E181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:47:11 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5af6c445e9eso7847037b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700135231; x=1700740031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IZjcqGv42rVv0ipCzhYT3Hq96pkj962enz82vWbOD8=;
        b=pKJjhiMw6qe5hxSpsuAv0AexpFThwXd/mbcu6fxBH/S/BesmocaCOMBhqkCAdUt+Q/
         gMADdlaJ89slxm0Sf1Z7dvesvHkE200G7EzCJPO6xU7hSAgoFE49+lZTAHghVJ2bSbAj
         +BuRVKvkMvOQ6Vu0NkMJp0s0xm5gCFZTBPI1g7OQXbf0BnDVjFm4sfBmGmbg9vDcHuMs
         Lb9hUUjZcx2GFK6dmnQHIppoGc+EmueIBd8cZqXOauA5U/T6EiI9M0iXgiIA51nbFeKx
         SJJPzvZLZDNwZ6wQQNUBs8qeP3HYj0sk/ZytPo5x3dQthg7Qb35UyoPbLTGi25ZJYSbe
         iLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135231; x=1700740031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IZjcqGv42rVv0ipCzhYT3Hq96pkj962enz82vWbOD8=;
        b=NK8D3aoMZYjDZyIq0DkCgyijPWUrxdz/BFO4gewfDrLasoqaudZ45OnrwesVVHIRgQ
         T93bEBOQZK8G2QtY/jJZhpW/DkVTPYGfsmi6sCkvL3EmbK1ynAD3Ve11P5t66WeaO+Xn
         Y7v4XSskRWNHHDETsZoE6ponbOwkYBZAyr4eLAx+S3JSQ21wbPb/cCWRKogSIOiC+aZB
         2XPHMLAKDN7+ONODaSDWVHuXhixkx21GrCqWGMv+UwVd+j7sHJ0KKTNn8Hnk7N6ofV6Q
         1YeyRjenwG172RtAzQlRiHJRbW+YyKsOA5X+RuDclNwhIX62ILsAo/47Qf3OP5hr5nwJ
         Adrw==
X-Gm-Message-State: AOJu0YxBW6tLkCXC6Gq22X0BkV6LRrgHMQuKQux9PHH1uyLe7oU4jzJb
        GaouRTIu1cDGv57Wu2zbsv7qKg==
X-Google-Smtp-Source: AGHT+IGWA89zidPswf2TQAp+TqRFhSxa7Oyp6znP0Eb8YbE0oq3Ta/SGAHTPqcGO96abkl4ixVfjAA==
X-Received: by 2002:a0d:c8c7:0:b0:5a7:bbca:8c9e with SMTP id k190-20020a0dc8c7000000b005a7bbca8c9emr14741014ywd.7.1700135230773;
        Thu, 16 Nov 2023 03:47:10 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id qd6-20020a05620a658600b007758b25ac3bsm4229474qkn.82.2023.11.16.03.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:47:10 -0800 (PST)
Message-ID: <e469039c-9370-4718-9081-98a203c62e77@linaro.org>
Date:   Thu, 16 Nov 2023 12:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, marijn.suijten@somainline.org,
        andriy.shevchenko@linux.intel.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
 <bb225c12-f017-fac3-45f1-c828a10553e2@linaro.org>
 <99070bce-6188-82eb-c92c-cf7a323394e2@quicinc.com>
 <c4ef9cac-15ac-4c2c-9f9a-cb9e740e2900@linaro.org>
 <06d0f06a-7a5a-44d1-0bad-27f56bfc1421@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <06d0f06a-7a5a-44d1-0bad-27f56bfc1421@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 04:23, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 10/23/2023 12:06 PM, Krzysztof Kozlowski wrote:
>> On 23/10/2023 08:14, Jishnu Prakash wrote:
>>> Hi Krzysztof,
>>>
>>> On 7/9/2023 10:53 PM, Krzysztof Kozlowski wrote:
>>>
>>>>>      reg:
>>>>>        description: VADC base address in the SPMI PMIC register map
>>>>> -    maxItems: 1
>>>>> +    minItems: 1
>>>> Why? This does not make any sense. With previous patches it looks like
>>>> random set of changes.
>>> The idea here is to convey that reg can have multiple values for ADC5
>>> Gen3 as there can be more than one peripheral used for ADC, so there can
>>> be multiple base addresses. I'll try to make this more clear in the next
>>> patchset.
>> You cannot remove constraints from an entry.
> 
> 
> In this case, minItems: 1 will remain true for all other ADC devices 
> documented here, but it will not be true for ADC5 Gen3, as this one can 
> have multiple base addresses if more than one SDAM is used for ADC. I'll 
> update this separately for each compatible, keeping it the same for the 
> older ones, hope that should work.

BTW, you disagree with me and send new version 2 minutes later.
Basically you did not leave me any time to respond to you.

That's not how the process works.

Best regards,
Krzysztof

