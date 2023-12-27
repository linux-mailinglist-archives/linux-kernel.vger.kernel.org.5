Return-Path: <linux-kernel+bounces-11978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93C81EE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350FA2838B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B04438F;
	Wed, 27 Dec 2023 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMAkY61M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8C4437F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5ab2f9f1so12117185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703674973; x=1704279773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJIrbNTFz6S/Q36AOT40voK6wVA75vC4IEUr/tVF8lw=;
        b=DMAkY61Maa4oNGqZRDiU+3i9tjVlN472vixsqkIYUSI/PqJrDz2AatrfvJPM3ClJOR
         WrZjUIUv2WKMFl9UmK3n4yWhSEj/K84KujjEkjLgXTMLa99J8IrY5+/oXdchV++cU8F8
         XMS1Y/dS1EO/6y+vtc2VWqLBJMaIapoJsUEn8XmUkM+iHmH4Y8catNwMWXsUij6eBlzg
         DdFLpwEnxGZ4/ilzxshncr8VYSedVNKM4NCaYGXSWi0xZhx9uI/vOJV/0qeH3yBMih6i
         kq11SWrWTyV3gnexkHFxSrIvaE7W9630Lk3gCJWigyugcQCQyMnXXGlYDe5WydHhx0F7
         uiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674973; x=1704279773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJIrbNTFz6S/Q36AOT40voK6wVA75vC4IEUr/tVF8lw=;
        b=JQs0lzH8ORIjl1xgOy7akkeVbIs443aU/eFJRbGJhTsb9hs40lQCH4YcPfwiDVekgC
         lcpX8oTOC5EzBI8IY8Vg5SIH5NNQd3XJHmFSj5FzE8o3dmF4buIcRpwT/wSwAUO6atTY
         xvlZr4vg7XY1eRIflz/NLVjCoFdYkHRLa5ti392+kH66pnBA0eWDzlcrbkRd8VZxZz0y
         gf0EGA/SXDRo90gmHQArR9pemYQEjcxM1+MMRynKLNdr7NAH0MlmBTSxydlEQr+kF0l9
         sDKa4RdeyJ82Eed3Tn5JYRVckCuA/c7QEbaZWbsRZGTDpe1S5+zXPxZGWbtnEl6sI/0/
         fnrA==
X-Gm-Message-State: AOJu0YyjlpnjCPltxWGNGQEYxv7A8n/j/y8nbu4uHuzdTGSSzDeh8iFy
	KLml6BdXo1QLknDmvWw3853wWoVQFCE2dA==
X-Google-Smtp-Source: AGHT+IHECwD/OaL8m9NFsQrKYWOZel0XQxVa6HvaiLEs29HrzC1c7faF587Xbgfj9Vx62z/XQZJ/jg==
X-Received: by 2002:a05:600c:5014:b0:40d:5ec8:31b4 with SMTP id n20-20020a05600c501400b0040d5ec831b4mr233577wmr.217.1703674972900;
        Wed, 27 Dec 2023 03:02:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id q28-20020adfab1c000000b0033690139ea5sm12213468wrc.44.2023.12.27.03.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 03:02:51 -0800 (PST)
Message-ID: <2ea6a62a-ff0b-4cd9-9121-18cc063c3774@linaro.org>
Date: Wed, 27 Dec 2023 12:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 5/5] ASoC: dt-bindings: Add tas2563 into
 ti,ta2781.yaml to enable DSP mode
Content-Language: en-US
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz"
 <perex@perex.cz>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de" <tiwai@suse.de>,
 "Gupta, Peeyush" <peeyush@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
 <20231225053932.1138-5-shenghao-ding@ti.com>
 <954a2ab8-3931-4022-a004-6a560c1a6a25@linaro.org>
 <2a84eb1157a4421ba19900eeb2bfc7db@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2a84eb1157a4421ba19900eeb2bfc7db@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2023 07:58, Ding, Shenghao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, December 25, 2023 9:18 PM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; broonie@kernel.org;
>> conor+dt@kernel.org
>> Cc: robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; Lu, Kevin
>> <kevin-lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>;
>> devicetree@vger.kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-
>> louis.bossart@linux.intel.com; 13916275206@139.com; linux-
>> sound@vger.kernel.org; linux-kernel@vger.kernel.org;
>> liam.r.girdwood@intel.com; soyer@irl.hu; tiwai@suse.de; Gupta, Peeyush
>> <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v3 5/5] ASoC: dt-bindings: Add tas2563 into
>> ti,ta2781.yaml to enable DSP mode
>>
>> On 25/12/2023 06:39, Shenghao Ding wrote:
>>> Move tas2563 from tas2562.yaml to tas2781.yaml, because tas2563 only
>>> work in bypass-DSP mode with tas2562 driver. In oder to enable DSP
>>> mode for tas2563, it has been moved to tas2781 driver. As to the
>>> hardware part, such as register setting and DSP firmware, all these
>>> are stored in the binary firmware. What tas2781 drivder dooes is to
>>> parse the firmware and download them to the tas2781 or tas2563, then
>> power on tas2781 or tas2563.
>>> So, tas2781 driver can be resued as tas2563 driver. Only attention
>>> will be paid to downloading corresponding firmware.
>>>
>>> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>>>
>>> ---
>>> Change in v3:
>>>  - Add devicetree list and other list of necessary people and lists to
>>> CC
>>>  - Express Compatibility in the bindings
>>
>> Where?
>>
>>>  - Add more comments on why move tas2563 to tas2781 driver
>>>  - Provide rationale in terms of bindings and hardware, not in terms of
>> driver.
>>>    Or at least not only.
>>> ---
>>>  .../devicetree/bindings/sound/ti,tas2781.yaml | 66
>>> ++++++++++++++-----
>>>  1 file changed, 51 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> index a69e6c223308..bbe8e5f2c013 100644
>>> --- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>> @@ -5,36 +5,72 @@
>>>  $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>
>>> -title: Texas Instruments TAS2781 SmartAMP
>>> +title: Texas Instruments TAS2781/TAS2563 SmartAMP
>>>
>>>  maintainers:
>>>    - Shenghao Ding <shenghao-ding@ti.com>
>>>
>>>  description:
>>> -  The TAS2781 is a mono, digital input Class-D audio amplifier
>>> -  optimized for efficiently driving high peak power into small
>>> -  loudspeakers. An integrated on-chip DSP supports Texas Instruments
>>> -  Smart Amp speaker protection algorithm. The integrated speaker
>>> -  voltage and current sense provides for real time
>>> +  The TAS2781/TAS2563 is a mono, digital input Class-D audio
>>> + amplifier optimized for efficiently driving high peak power into
>>> + small loudspeakers. An integrated on-chip DSP supports Texas
>>> + Instruments Smart Amp speaker protection algorithm. The  integrated
>>> + speaker voltage and current sense provides for real time
>>>    monitoring of loudspeaker behavior.
>>>
>>>  allOf:
>>>    - $ref: dai-common.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,tas2781
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          description:
>>> +            I2C address, in multiple AMP case, all the i2c address
>>> +            aggregate as one Audio Device to support multiple audio slots.
>>> +          maxItems: 8
>>> +          minItems: 1
>>> +          items:
>>> +            minimum: 0x38
>>> +            maximum: 0x3f
>>> +    else:
>>
>> How this else is possible? Please show me any DTS which triggers this else
>> case.
> Do you mean add two if and remove else branch. Like following

Apologies, maybe my comment was not right, because the context tricked
me. The if:else usually goes with allOf: to the end of the file, after
required: block. I think I assumed there is no compatible change, since
you this is expected to be the last diff hunk in the patch.

>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - ti,tas2781
>     then:
>       properties:
>         reg:
>           description:
>             I2C address, in multiple-AMP case, all the i2c address
>             aggregate as one Audio Device to support multiple audio slots.
>           maxItems: 8
>           minItems: 1
>           items:
>             minimum: 0x38
>             maximum: 0x3f
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - ti,tas2563
>     then:
>       properties:
>         reg:
>           description:
>             I2C address, in multiple-AMP case, all the i2c address
>             aggregate as one Audio Device to support multiple audio slots.
>           maxItems: 4
>           minItems: 1
>           items:
>             minimum: 0x4c
>             maximum: 0x4f
>>
>>
>>> +      properties:
>>> +        reg:
>>> +          description:
>>> +            I2C address, in multiple AMP case, all the i2c address
>>> +            aggregate as one Audio Device to support multiple audio slots.
>>> +          maxItems: 4
>>> +          minItems: 1
>>> +          items:
>>> +            minimum: 0x4c
>>> +            maximum: 0x4f
>>>
>>>  properties:
>>>    compatible:
>>> +    description: |
>>> +      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
>>> +      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
>>> +      multichannel TDM.
>>> +
>>> +      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
>>> +      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
>>>      enum:
>>>        - ti,tas2781
>>> +      - ti,tas2563
>>
>> Still nothing improved. Where is the fallback?
> Do you mean to add following as fallback?
>     oneOf:
>       - items:
>           - enum:
>               - ti,tas2781
>       - items:
>           - enum:
>               - ti,tas2563

These are two separate list of items. What I meant is something like
example schema:
oneOf:
 - enum
 - items
     - const
     - const

>>
>>> +      # Tas781 driver can support both tas2563 and tas2781, because the
>>> +      # hardware part in the driver code, such as register setting and DSP
>>> +      # firmware, all these are stored in the binary firmware. What drivder
>>> +      # dooes is to parse the firmware and download it to the tas2781 or
>>> +      # tas2563, then control tas2781 or tas2563 to power on/off or switch
>>> +      # different dsp params. So, tas2781 driver can be resued as tas2563
>>> +      # driver. Only attention will be paid to downloading corresponding
>>> +      # firmware.
>>
>> Don't write useless driver description and implement proper list of two
>> compatibles using one as fallback for another. I already pointed you to
>> example-schema which gives you nice example for this.
>>
>> It is third try not doing what I asked you. Probably we misunderstand each
>> other, then please answer:
>>
>> 1. Please find example-schema.yaml and share whether this succeeded or not.
>> 2. Open the example-schema.yaml in your editor.
>> 3. Read the section about compatibles. You need oneOf and items, just like it
>> is there.
>>
>> Now, please confirm that you did all these steps before you send v4 with
>> more test.
>>
>>>
>>> -  reg:
>>> -    description:
>>> -      I2C address, in multiple tas2781s case, all the i2c address
>>> -      aggregate as one Audio Device to support multiple audio slots.
>>> -    maxItems: 8
>>> -    minItems: 1
>>> -    items:
>>> -      minimum: 0x38
>>> -      maximum: 0x3f
>>> +  reg: true
>>
>> OK, you clearly just keep ignoring my comments.
>>
>> This is a friendly reminder during the review process.

Just to remind this - my previous comments about not removing widest
constraints is still valid.

Best regards,
Krzysztof


