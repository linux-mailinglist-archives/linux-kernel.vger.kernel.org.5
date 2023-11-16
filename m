Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D77EDFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKPLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKPLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:40:24 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B574B182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:40:20 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7d9d357faso7449417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700134820; x=1700739620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPmwDyDnTt2mfJDFk4M04sRvgIpCqOiaXwSPPRNnyQQ=;
        b=jYqKi6+wu2zNIPFDkIPFrSionXcyHO+OtJTUWTkWCEPSzn67e52UDkQZ6Y4JMVPdfH
         9WQJQoXH1Kdm6ddt0AP8ykyqd8gNz/wJHh5gDLJAbj6UKB0pucukIEiBCfq1MWG2mNoF
         kaZ5X0B/YQwk3WA5DVxje3sG//8yjV3VQBNrkqbMv7NIdYhqchbQeTSv81EmfR3jt1zz
         GEtZvZ8hfIbgglsx4qowb7O4kYcGeIzPNs7erZg8CbtymEyH8mB88X46TKChAUHeOKe0
         zn0dfo236zzwUxMGaZSr2fUpdXY2qloS+c029D8Q6kzF37dIChGgaBW7p6jSUp/fRjs3
         YC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134820; x=1700739620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPmwDyDnTt2mfJDFk4M04sRvgIpCqOiaXwSPPRNnyQQ=;
        b=tbXgZO/Zgn0R7/5gEhOCbZP5gz4lbPqVKKVdrYpt2VP6qq1sarnXuFKJdBxYB606fD
         305DEMqGWFBCElyZJ7RYOspyA/Jer/mN088kovAIFPQ6oDEad5NJg2m8m3yOgF6KnOV3
         5mpuYGCvkQBiZGQST3dpu8QjZVPNYgonlNEhgIj48OkgUqyeUup/9yWoOm7AOhO/mW7f
         PSRVoZ08nxoY0YM403pz0wD/paw0Vf6wrrEe5IGMZSAGtnbquHVma8KzLszYwsxvAIFH
         jkImDfF5mdKsbqs4Dg6EefLl0eBxHr66Xxu5gy7dIryKjLKWIvjt2yI5xgGLLXNKhsLg
         6P2g==
X-Gm-Message-State: AOJu0YzXtLxH8cg8mcawrWGf/U0TA8YC49ZlsRkpVviltaJ4gjBVep3s
        1gM5eXH5NTSaBEtUMu3PwzKBsA==
X-Google-Smtp-Source: AGHT+IFtwwpoOvZJIXX3Pr0GCvaufNrPMRU/FlgQ2Ejulw6x5wIeRakrK9kpyWpo2e7qWqZEcPKxYA==
X-Received: by 2002:a0d:ca8f:0:b0:5a7:ba54:af02 with SMTP id m137-20020a0dca8f000000b005a7ba54af02mr17174955ywd.38.1700134819885;
        Thu, 16 Nov 2023 03:40:19 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cc591000000b0065b21f1b687sm1298370qvj.80.2023.11.16.03.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:40:19 -0800 (PST)
Message-ID: <a4d5293f-43ee-487c-a540-5a1f65e3c7d6@linaro.org>
Date:   Thu, 16 Nov 2023 12:40:13 +0100
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

You responded like you disagree with me, so just in case:  my comment
stays. If you resend the same, I will NAK it.

> 
> 
>>>>>    
>>>>>      '#address-cells':
>>>>>        const: 1
>>>>> @@ -38,6 +39,12 @@ properties:
>>>>>      '#size-cells':
>>>>>        const: 0
>>>>>    
>>>>>    
>>>>> +      qcom,adc-tm-type:
>>>>> +        description: |
>>>>> +            Indicates if ADC_TM monitoring is done on this channel.
>>>> Description does not match property name.
>>> You mean it sounds more like an enum which can take several values
>>> rather than just a boolean? I can update it to "qcom,adc-tm" if that
>>> looks better.
>> The property name suggests this is type of monitoring. Property
>> description says this will enable ADC_TM monitoring. These two do not match.
>>
>> Except that I wonder now whether this is a property of hardware at
>> all... What is this monitoring? By the driver?
> 
> 
> The property description is right, this property is used to indicate 
> that one of the configurable channels on the ADC SDAMs will be used for 
> ADC_TM functionality, for periodically monitoring this particular ADC 
> channel . This is the exact same functionality as in the existing QCOM 
> ADC_TM device, documented at 
> devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml. I'll mention this 
> too in the description.
> 
> It can be considered a property of the hardware as the monitoring is 
> done by a sequence under PBS (Programmable Boot Sequence, can be 
> considered firmware), which periodically gets the channel reading and 
> checks it against upper/lower thresholds set by clients of this driver, 
> for threshold violations.
> 
> 
>> ...
>>
>>>>>        then:
>>>>>          patternProperties:
>>>>> @@ -299,7 +315,7 @@ examples:
>>>>>                    label = "xo_therm";
>>>>>                };
>>>>>    
> 
>>>>> diff --git a/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>>>> new file mode 100644
>>>>> index 000000000000..74e6e2f6f9ed
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/iio/qcom,spmi-adc5-gen3-pm8550.h
>>>>> @@ -0,0 +1,48 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> Dual license.
>>> I think we do have an internal rule by which we do have to add these two
>>> licenses....I'll check again and update them if required.
>> Just to be clear: your internal rules are your internal affair. We
>> expect here dual license.
> 
> 
> I misunderstood what you meant earlier, I understand now that 
> "GPL-2.0-only" is wrong, I'll update it.

If only you run checkpatch before sending patches...

Best regards,
Krzysztof

