Return-Path: <linux-kernel+bounces-38199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2683BC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC955B26338
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116D81B969;
	Thu, 25 Jan 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e325S8Q8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E31B954
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173074; cv=none; b=d35X5kM3gTPvJoiK4AtWELQlxK4b3e1ZUs6HXRyksqhs+fuWPWG3Q8NJahf4PcZ2LiGnleoAKk4dzsrsy4ketzV0qmQF/HeF2q1DcKuH+kutnVv2r55NFu835ap7SW+EvGjijsc+htCZUy5L9FwUzudzV3v4GcRTuMnlnigvEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173074; c=relaxed/simple;
	bh=ASSAcrZC686QXcaT0VDsrrNCHgxrvYn7vN/gCgNrBk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsSOWeYqnVL/qBgb/ATr0Q4v/IxTbWMIA4UFPgS+8gTpfLHXxaMeL3wsLtXGs5Qv7xRXEN85qPvBjMynT2yb+qo1SzQLlvvTRWoHlPUyuOvrR8o2KZ3iJ+rG5fsvCU68mRzUn26Ro9jvfM+h+rgdgDIhFvEynaydyzksvBaSPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e325S8Q8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so80785405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706173071; x=1706777871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Fjy061af3WQwkrtjqs4ezbtKnwx+BKx0P5XcCzsUU=;
        b=e325S8Q89BIDNrGXMUbTD+9zHwDroS1DIqV/Beb7+6mdUilUEfTd2GS8MUzm3m0ejo
         WpswdzFhX/w5jNb7HdNgFwXzMw78CvwJcjY7pvoZqSsNM8/NtGotH1xYy9p2EqcRFn1Q
         7Hq09aWlaV/ZgHd24JDVlpzVwU8rAqI5D1sqwdKwKYn+TitdqpTkZ1+L5/ZyUN4ESTkI
         V9t8cdjc+uhOocXFfGdgdC5ENP4RRFsqmmATVVeY97kCIQWVImzK7kkNJY49kKtcHavF
         APJAdK4TnxSsvrSs+errp+71+MFkJu+fD3RvKMmAfHt9qKQe9ghTxVBIEUjWfrN5Rc2b
         JWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173071; x=1706777871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7Fjy061af3WQwkrtjqs4ezbtKnwx+BKx0P5XcCzsUU=;
        b=OzsaWQSIGqEdgkAJVQEvA2HZRQhd04baQ4O4rWYZZ+jfUJu1rPJ/sbHVeftYvQMwxC
         2UO0HAFu/arCeKRDAuGBFrSD/H2PbWuB68a5QBrJi2gdqu+IlWJxG7sH91Co3Hn3ccDP
         iO7MbF1az/cW5S4+awG/vt+9PyH6f08Y/Qg4eef+v7/+rWvkl1mWKy9juonyMoh3003f
         QEsG3UIm/HK85qO8Oc3kT5HcqxQkUJzIeWo+ej8DgYSLF93vw3vRJD40gPcRFkDRxqUV
         wvuCVZJo6jJKmr4Pbq+x/T6CrXQPtq89O4CNOiaDcZC3rjtruus13ssct7RTIlP2VitY
         gR1g==
X-Gm-Message-State: AOJu0YyK1Dw0Tvuk/7/3bU3qH0b5cRAaTGuNz75goocBaFcuaPPkCX5h
	yfD5fMBhETWKgfSCxMLygfwfPaRuD+ayAeyHJjo9c8LwExaOTBqYQRQ4zh4gkf4=
X-Google-Smtp-Source: AGHT+IG92mHalxw+oDjOcxLes1wcOSJEjV0q4XNAGx+NRSjZz3FTyKXHHopr6lgobIiqar2MGSEslQ==
X-Received: by 2002:a05:600c:384e:b0:40e:c1a9:6829 with SMTP id s14-20020a05600c384e00b0040ec1a96829mr280733wmr.120.1706173070864;
        Thu, 25 Jan 2024 00:57:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gv21-20020a170906f11500b00a28a66028bcsm794592ejb.91.2024.01.25.00.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:57:50 -0800 (PST)
Message-ID: <42a3038f-33b0-404d-b311-65426961c0c1@linaro.org>
Date: Thu, 25 Jan 2024 09:57:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml file
 for pcm6240 codec driver
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
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
 "soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
 "tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
 "McPherson, Jeff" <j-mcpherson@ti.com>,
 "Navada Kanyana, Mukund" <navada@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
 <20240123111411.850-4-shenghao-ding@ti.com>
 <92c1a3f3-6b3b-47cb-a4bf-0d20e4af95e5@linaro.org>
 <a6c6cad6efc647ba8f0c828ffdb3a54f@ti.com>
 <d8f00ea9-3bb2-4b17-bbc7-48800516e408@linaro.org>
 <c107a70e42eb4327802748cda89d292f@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c107a70e42eb4327802748cda89d292f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 09:46, Ding, Shenghao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, January 25, 2024 3:50 PM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; broonie@kernel.org;
>> conor+dt@kernel.org
>> Cc: robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; Lu, Kevin
>> <kevin-lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>;
>> devicetree@vger.kernel.org; lgirdwood@gmail.com; perex@perex.cz;
>> pierre-louis.bossart@linux.intel.com; 13916275206@139.com; linux-
>> sound@vger.kernel.org; linux-kernel@vger.kernel.org;
>> liam.r.girdwood@intel.com; soyer@irl.hu; Huang, Jonathan
>> <jkhuang3@ti.com>; tiwai@suse.de; Djuandi, Peter <pdjuandi@ti.com>;
>> McPherson, Jeff <j-mcpherson@ti.com>; Navada Kanyana, Mukund
>> <navada@ti.com>
>> Subject: Re: [EXTERNAL] Re: [PATCH v1 4/4] ASoc: dt-bindings: Create yaml
>> file for pcm6240 codec driver
>>
>> On 25/01/2024 08: 39, Ding, Shenghao wrote: >> >> Why do you repeat the
>> reg constraints? This does not seem needed. >> >>> + interrupts: false >>>
>> + >>> + - if: >>> + properties: >>> ZjQcmQRYFpfptBannerStart This message
>> was sent from outside of Texas Instruments.
>> Do not click links or open attachments unless you recognize the source of
>> this email and know the content is safe.
>>
>> ZjQcmQRYFpfptBannerEnd
>> On 25/01/2024 08:39, Ding, Shenghao wrote:
>>>>
>>>> Why do you repeat the reg constraints? This does not seem needed.
>>>>
>>>>> +        interrupts: false
>>>>> +
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - ti,pcm3140
>>>>> +              - ti,pcm5140
>>>>> +              - ti,pcm6140
>>>>> +              - ti,pcmd3180
>>>>> +    then:
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          description:
>>>>> +            I2C address, in multiple pcmdevices case, all the i2c address
>>>>> +            aggregate as one Audio Device to support multiple audio slots.
>>>>> +          maxItems: 4
>>>>> +          minItems: 1
>>>>
>>
>> You did not respond to any of other comments, therefore I assume you
>> agree with them 100% and you will implement them fully.
>>
>>
>>>> Drop entire if
>>> How to convey ti,pcm1690 does not support interrupt, and others
>>> support if I remove this if
>>
>> How? There is no pcm1690 here.
> How can others know that pcm3140, pcm5140, pcm6140 and pcmd3180
> Support i2c address from 0x4c to 0x4f, if this if branch was removed.

They do not need anything to support any specific I2C address... If ever
wondering, open some recent bindings and take a look how it is done there.


Best regards,
Krzysztof


