Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BAD79840D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjIHI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIHI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:28:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B901BE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:28:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500c37d479aso2869017e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694161712; x=1694766512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTQvX0l1l8YjMN32TFjMcal8vJX1jxa9/xk94KVFs0k=;
        b=zxkGRqeu2ogQemmBa1NcwC8LzmDKDbOsjX5FiHy5EBiEMOwNdfWXtIQmLOBtsPkDib
         k9+VQylhdth4LZi2dP7gCRoOMW7teTl8v9ofCRTgGN4vDP4NR8kKLfxxCGcVQVwKb7jo
         S6FbcPYRd/xtui9dNwJmO71YtilqiZFMkYGwZFdn4uGyDbl43v6moj0WMnOAtzKTpt52
         pRTE7w6g/2rkpc7owPqbN/uvpwBRtnR/niBk5v21mjm0Aig4Nf3cmjNf+vWoa1PhsRxI
         yFwUg3iiHAC6oRBbvcdVvfmyG9aNDjG0I0//0ThMSQU8cWrC1YGKWxBja5DyCsPHUx9l
         +BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694161712; x=1694766512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTQvX0l1l8YjMN32TFjMcal8vJX1jxa9/xk94KVFs0k=;
        b=NEE44vn1srZ3uFNVdDJKcWGAFNcOrvBYqwREVqdseSvExQ13eTAa9ESEHpE3To2ZUd
         6BPeL9pByNXn/g94GaFIXPzHUs8FUNjpmHMrosehqPqZG8SWhEWwQO9+oDKRL0grw6il
         C08n43+ZTj+7c21Mpld+IRV0PjRFaOic9+AZoG/JUqjeR9TLaYALcw54+92WdjE8Odna
         6o6mxaA7t3W7qhtTN/+nFBnV90Ln6rXCq2A72u/6rIFBR7V9cFlFUrHXEaQBu+he7K7J
         8fAwiFY9RmGwd3vNgtcQR74IIY4OOugsVSUwbEALzSUROsysPVrObc6tlssEx/9b+mbl
         XrAw==
X-Gm-Message-State: AOJu0YxNIUfJteqABe8G5qTV2RYUHwCSIHdAVNWl3LjQ40YEwqGWrWS1
        RDMxNskUUqKZOtMYz6hUDBxSbw==
X-Google-Smtp-Source: AGHT+IHRiwhrH9Jh2MiuihFGwsr2A6/gozx5vuf7KVVzfh0ftGP/iAbRwvSBTx9qHwCylO/9S8VTjQ==
X-Received: by 2002:a05:6512:3447:b0:500:a694:46f with SMTP id j7-20020a056512344700b00500a694046fmr1148636lfr.19.1694161711960;
        Fri, 08 Sep 2023 01:28:31 -0700 (PDT)
Received: from [192.168.37.45] (178235177197.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.197])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b005255f5735adsm717340eds.24.2023.09.08.01.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:28:31 -0700 (PDT)
Message-ID: <cdf51ad9-d342-4a9c-a55d-384e04bd8754@linaro.org>
Date:   Fri, 8 Sep 2023 10:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data
 to support PPG
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-8-quic_amelende@quicinc.com>
 <951a2f24-931a-4a25-a3b7-c3009e135d7d@linaro.org>
 <ca451c20-57c1-6fb4-8c8e-b3446944a0f6@quicinc.com>
 <ab237850-4724-48a8-bea8-f1287445358f@linaro.org>
 <83f88e88-5624-4ffd-b2df-f58c6988c649@linaro.org>
 <2321f4e9-5db2-126a-c5ab-fc18cc507822@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <2321f4e9-5db2-126a-c5ab-fc18cc507822@quicinc.com>
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

On 8.09.2023 02:30, Anjelique Melendez wrote:
> 
> 
> On 9/7/2023 1:31 PM, Konrad Dybcio wrote:
>> On 7.09.2023 22:26, Konrad Dybcio wrote:
>>> On 7.09.2023 21:54, Anjelique Melendez wrote:
>>>>
>>>>
>>>> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>>>>> On 30.08.2023 20:06, Anjelique Melendez wrote:
>>>>>> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
>>>>>> for LUT pattern.
>>>>>>
>>>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>>>> ---
>>>>>>  drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
>>>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>> index 90dc27d5eb7c..0b37d3b539f8 100644
>>>>>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>> @@ -1672,11 +1672,14 @@ static const struct lpg_data pm8994_lpg_data = {
>>>>>>  static const struct lpg_data pmi632_lpg_data = {
>>>>>>  	.triled_base = 0xd000,
>>>>>>  
>>>>>> +	.lut_size = 64,
>>>>>> +	.lut_sdam_base = 0x80,
>>>>> Is that a predefined space for use with LPG?
>>>>>
>>>>> Or can it be reclaimed for something else?
>>>>>
>>>>> Konrad
>>>> Yes, this is a predefined space for use with LPG
>>> We represent the SDAM as a NVMEM device, generally it would
>>> be nice to add all regions within it as subnodes in the devicetree.
>> Wait hmm.. we already get it as a nvmem cell.. Or at least that's
>> how I understand it (lut_sdam_base == lpg_chan_nvmem->start, pseudocode)
>>
>> Why don't we access it through the nvmem r/w ops then?
>>
>> Konrad
> I think I might be a little confused on what you are asking so please let
> me know if this does not answer your question.
> 
> lut_sdam_base is the offset where lut pattern begins in the SDAM. So when we are writing back
> our LED pattern we end up calling nvmem_device_write(lpg_chan_nvmem, lut_sdam_base + offset, 1, brightness).
> So far for every single SDAM PPG devices we have seen the lpg_sdam_base be 0x80 and every
> LUT SDAM PPG devices (pm8350c) we have seen lpg_sdam_base be 0x45, which is why we 
> included this value in the lpg_data rather than as a devicetree property since it has
> been consistent across a few pmics.
> 
> I am ok if you would like the lut_sdam_base to be moved to a devicetree property.
So.. we have a slice of SDAM represented as an NVMEM cell (and that
part of SDAM is reserved solely for LPG), and then within that cell,
we need to add an additional offset to get to what we want. Correct?

What's in LPG_NVMEM_CELL[0:offset-1] then?

Konrad
