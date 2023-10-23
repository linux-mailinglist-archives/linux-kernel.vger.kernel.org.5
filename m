Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF317D2A89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjJWGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjJWGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:36:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525A1D67
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:36:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso424211766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698043012; x=1698647812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4fyo6K7OzrkvLsx7JVTpQeOK1B6fLbPRjuPeJMN1uM=;
        b=tZT9zZ0CuvV38PndY+r8D/ZYuqwuLyiKvuZY/iTGd1sJCrltxNEth3b9ONxROZmold
         PXuSeKLt/bDubhb9aEpRA2Fir+GZl3dnWgnnCtvv4fyE/TZpbudUk+VFw/yUmY3VVljR
         67vtGEUaSuu57e0J+LK+7GNPTn7KoQooXE729+64HFHdeIOmsCtfz9q65z7ijzJ/vsxk
         xv6LMSOgDVufK37R/9fLBP3LL6WP96tpZyetoPAOYG+GCeutSEEMd6c7Xd75L0+HVa1w
         Vs5XRnARZ0aVkU/c70uQLQ4K5ItOtsuGD4wcOF8m/smeBcLUonyRYXyGRoQmEQZSaBUq
         SdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043012; x=1698647812;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4fyo6K7OzrkvLsx7JVTpQeOK1B6fLbPRjuPeJMN1uM=;
        b=mbjASbRaKEDAFbW+HKp5GwweBKf1gfgnRvlqGtf4tRkCOeLxNKmrxzP1VZD+RzkPIO
         uJswZwYZgWXM7JTZxEa9tIhBvSo7dtrpRCvHj+7UvXwFoXXY6klfwytROQilff3cWZqy
         wXz8EXGCH5V3JMQxmVpOZcP4nqQnAXqQR/iuWe16m2vRQxJfr51s7PvfOv5wvCxt+Ztg
         ZFDIVgB61cG5W3SGHrMEqgZl/y0whQe4sMb1E/6fxzIXCDDf4K+aEK9FSCdZ5U0ay1d4
         KKcQGlGhMgXk7wszJg8aAXFwO9Y8isUW2jTlyEEbqvikmmreqXcKEum3DcGT0YDNLPiH
         h7ng==
X-Gm-Message-State: AOJu0YwDvbXgIK0V7dYNqVR+aeuE7H00v/sNfBGAb1p69Su0Bul+N5qV
        NxB9eA4bCjfO+noia1dsUnCE0w==
X-Google-Smtp-Source: AGHT+IH3hv75FHOFtN9KpfJZvvb9R2F2oWmDzQHlsuKXhdyfvMoyH6MMbW/kj9pL89WnuEQwY6O8Zw==
X-Received: by 2002:a17:907:7b90:b0:9c7:56ee:b6e5 with SMTP id ne16-20020a1709077b9000b009c756eeb6e5mr7368082ejc.40.1698043011756;
        Sun, 22 Oct 2023 23:36:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906561900b009920e9a3a73sm6154197ejq.115.2023.10.22.23.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 23:36:51 -0700 (PDT)
Message-ID: <c4ef9cac-15ac-4c2c-9f9a-cb9e740e2900@linaro.org>
Date:   Mon, 23 Oct 2023 08:36:48 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <99070bce-6188-82eb-c92c-cf7a323394e2@quicinc.com>
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

On 23/10/2023 08:14, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 7/9/2023 10:53 PM, Krzysztof Kozlowski wrote:
>> On 08/07/2023 09:28, Jishnu Prakash wrote:
>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>> going through PBS firmware through a single register interface. This
>>> interface is implemented on an SDAM peripheral on the master PMIC PMK8550
>>> rather than a dedicated ADC peripheral.
>>>
>>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>>> ---
>>>   properties:
>>>     compatible:
>>> @@ -27,10 +27,11 @@ properties:
>>>             - qcom,spmi-adc5
>>>             - qcom,spmi-adc-rev2
>>>             - qcom,spmi-adc5-gen2
>>> +          - qcom,spmi-adc5-gen3
>>
>> This could be ordered...
> 
> 
> Yes, will do that in the next patchset.
> 
> 
>>>   
>>>     reg:
>>>       description: VADC base address in the SPMI PMIC register map
>>> -    maxItems: 1
>>> +    minItems: 1
>> Why? This does not make any sense. With previous patches it looks like
>> random set of changes.
> 
> 
> The idea here is to convey that reg can have multiple values for ADC5 
> Gen3 as there can be more than one peripheral used for ADC, so there can 
> be multiple base addresses. I'll try to make this more clear in the next 
> patchset.

You cannot remove constraints from an entry.

> 
> 
>>
>>
>>>   
>>>     '#address-cells':
>>>       const: 1
>>> @@ -38,6 +39,12 @@ properties:
>>>     '#size-cells':
>>>       const: 0
>>>   
>>>   
>>> +      qcom,adc-tm-type:
>>> +        description: |
>>> +            Indicates if ADC_TM monitoring is done on this channel.
>> Description does not match property name.
> 
> 
> You mean it sounds more like an enum which can take several values 
> rather than just a boolean? I can update it to "qcom,adc-tm" if that 
> looks better.

The property name suggests this is type of monitoring. Property
description says this will enable ADC_TM monitoring. These two do not match.

Except that I wonder now whether this is a property of hardware at
all... What is this monitoring? By the driver?

...

>>>       then:
>>>         patternProperties:
>>> @@ -299,7 +315,7 @@ examples:
>>>                   label = "xo_therm";
>>>               };
>>>   
>>> -            channel@47 {
>>> +            channel@147 {
>> Why?
> 
> 
> It would be needed if this channel number was supposed to be the virtual 
> channel number made by combining PMIC SID and actual channel 
> number....but I could drop it for now and do it in a separate fix as 
> Jonathan suggested.
> 
> 
>>
>>>                   reg = <PM8350_ADC5_GEN2_AMUX_THM4_100K_PU(1)>;
>>>                   qcom,ratiometric;
>>>                   qcom,hw-settle-time = <200>;
>>> @@ -307,3 +323,80 @@ examples:
>>>               };
>>>           };
>>>       };
>>> +
>>> +  - |
>>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pmk8550.h>
>>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h>
>>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550b.h>
>>> +    #include <dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550vx.h>
>>> +
>>> +    pmic {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      /* VADC node */
>>> +      pmk8550_vadc: vadc@9000 {
>>> +        compatible = "qcom,spmi-adc5-gen3";
>> Don't add new examples which differ only in compatible.
> 
> 
> This example does have differences unique to ADC5 Gen3 such as use of 
> "#thermal-sensor-cells" and "qcom,adc-tm-type" properties....to make it 
> clearer, I'll delete some of the excess nodes which don't highlight 
> these differences.
> 
> 
>>
>>
>>> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>> new file mode 100644
>>> index 000000000000..74e6e2f6f9ed
>>> --- /dev/null
>>> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>> @@ -0,0 +1,48 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> Dual license.
> 
> 
> I think we do have an internal rule by which we do have to add these two 
> licenses....I'll check again and update them if required.

Just to be clear: your internal rules are your internal affair. We
expect here dual license.

Best regards,
Krzysztof

