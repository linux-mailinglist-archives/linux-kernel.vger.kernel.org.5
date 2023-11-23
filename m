Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2042D7F5A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbjKWIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjKWIc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:32:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751511BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:32:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507973f3b65so820382e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700728349; x=1701333149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlYleCUbscKdDdnnMAHQnWsVkkYIN7F0a9Yqa91mdgE=;
        b=JnH/542MmT+brz3oHmgAGIc3FV2Bh94PQZbfABJZ1owtNUusgyMH8Qj8PbPmgxQ71E
         T0tHHv2i0jd4ZQQK6EOjshtVLebps/XqJe4+1sYRa0FPz5hm8SgwlTRI+uhefO/qjz27
         0rfXwi/YlWV3AaNWBoxYfgSRIweGR1c4CJz5FbbrYz4zJxQSaQo4FS+rZqW56bCDlEGA
         uwpNQmokyUFU/uu3eOPaN2ldObL+l9/sTrVAiqwu/G2WAhA/W1yippVsGaeKQH2Ie6ar
         MKJjQmfBSwDO6XutkRis868Ni3/1jiX5HKTOiRWqOv7YFvvC95OYlYwSxGANedkqKyX4
         YtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700728349; x=1701333149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlYleCUbscKdDdnnMAHQnWsVkkYIN7F0a9Yqa91mdgE=;
        b=pOl75VJgyKSgZK7gYgKpVs3UiRunlKU8IIx6oR4kQMk7kfHYsWZiLNNi4H37LdnN0I
         l7nijtGVW9qUHNzFzmzEXKnrErRGpZYGuMvULVmRlDcRvrMGdssOluX8s0Q0Gt86W8xj
         l+TiCYdjc1E8656u7DpzAZwkZQShXWTBQSRNzuI/CCT4RllgY9ljfNUtcFpV3H+4LPRA
         0D/8XzLhIQ2fso1ZJs8tAdsVWLZV5rKyKif+ZxUD+X1WFi3bAO0YZKUesBsWvVgW7p0d
         2K2Ynsc0oYYjfRAZT+JEEVOguRRtVmUYkq7soQPSSF+q9Y0U4wbLLS/2m6VtuEDbvtGO
         +Ysw==
X-Gm-Message-State: AOJu0YyJsGB3jAX+7CQOBUxsXolMDebQ0y016SiXkl5/PtXZ6c7SSIAR
        YegBrk7yZPHl20OSmXk7LMVK6A==
X-Google-Smtp-Source: AGHT+IEMLcSclJXjnmDcDPwnayzHcPPha1SXaYOgEy4h8+M0inonES2xe68uywSRcppy1nnKTtb1eA==
X-Received: by 2002:a05:6512:21c3:b0:509:47ba:3160 with SMTP id d3-20020a05651221c300b0050947ba3160mr2802134lft.56.1700728349492;
        Thu, 23 Nov 2023 00:32:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b0040b2c195523sm1851461wmb.31.2023.11.23.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 00:32:29 -0800 (PST)
Message-ID: <7fb62b63-25d5-42f2-9803-61e813003fd5@linaro.org>
Date:   Thu, 23 Nov 2023 09:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: frequency: add admfm2000
Content-Language: en-US
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20231122105831.182570-1-kimseer.paller@analog.com>
 <f66a3dc3-a0a5-457b-a68a-efd6577aa210@linaro.org>
 <PH0PR03MB7141C58C008920173B3AE998F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
 <676c55c7-1477-4c59-a1fe-2b50e37018a0@linaro.org>
 <PH0PR03MB7141957ABE612DB1275B1309F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <PH0PR03MB7141957ABE612DB1275B1309F9B9A@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 09:24, Paller, Kim Seer wrote:
>>>>> ---
>>>>> V2 -> V3: Adjusted indentation to resolve wrong indentation warning.
>>>>>           Changed node name to converter. Updated the descriptions to clarify
>>>>>           the properties.
>>>>
>>>>
>>>>> +title: ADMFM2000 Dual Microwave Down Converter
>>>>> +
>>>>> +maintainers:
>>>>> +  - Kim Seer Paller <kimseer.paller@analog.com>
>>>>> +
>>>>> +description:
>>>>> +  Dual microwave down converter module with input RF and LO frequency
>>>> ranges
>>>>> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
>>>>> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
>>>>> +  conversion path.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - adi,admfm2000
>>>>> +
>>>>> +  switch1-gpios:
>>>>> +    items:
>>>>> +      - description:
>>>>> +          Setting B15 GPIO to high and B16 GPIO to low will result in channel
>> 1
>>>>> +          being in Direct IF mode.
>>>>> +      - description:
>>>>> +          Setting B15 GPIO to low and B16 GPIO to high will result in channel
>> 1
>>>>> +          being in Mixer mode.
>>>>
>>>> This still does not tell which one is B15 and which is B16. I am asking
>>>> this for third time.
>>>>
>>>> items:
>>>>   - description: B15 GPIO, when high (and B16 low) channel 1 is in
>>>> Direct IF mode
>>>
>>> I understand now, thank you. I was also wondering if this applies to the
>>> attenuation-gpios, or if I should keep it as is?
>>
>> Yes, something like this applies to all your properties with multiple
>> entries. You need to define the order.
> 
> Before I send a new patch/commit, could you please check this one if it is 
> properly defined?
> 
>   attenuation1-gpios:
>     items:
>       - description: C14 GPIO, when low (and C15, C16, D14, D15 high)
>           channel 1 attenuation is 1 dB.
>       - description: C15 GPIO, when low (and C14, C16, D14, D15 high)
>           channel 1 attenuation is 2 dB.
>       - description: C16 GPIO, when low (and C14, C15, D14, D15 high)
>           channel 1 attenuation is 4 dB.
>       - description: D14 GPIO, when low (and C14, C15, C16, D15 high)
>           channel 1 attenuation is 8 dB.
>       - description: D15 GPIO, when low (and C14, C15, C16, D14 high)
>           channel 1 attenuation is 16 dB.

This actually could be written in easier way like:

  attenuation1-gpios:
    description: |
      Choice of attenuation:
      C14 C15   ......
      1    0   0   0   - 1 dB
      0    1   0   0   - 2 dB
      ...
    items:
      - description: C14 GPIO
      - description: C15 GPIO
      - description: C16 GPIO
      - description: D14 GPIO
      - description: D15 GPIO

or whatever is easy to understand. The point is that you must define the
order of GPIOs and explain their meaning.

Best regards,
Krzysztof

