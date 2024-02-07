Return-Path: <linux-kernel+bounces-56260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92484C806
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D51F22DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951272374A;
	Wed,  7 Feb 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsM44Qc9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA42560F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299616; cv=none; b=sGeOW7FWm0/nITaWo6ocZahRy8b/WBRGGBSLL8co6vHtkaZ5sSYKrHA4MzBXxheIuUxC+WVKRDXuCseDrCg+I0jLESd8+C26ewIxPfHO82twwwVaEYO9Mcwytuek6JCtneWvi8MlzS9q6578lalWrjbUdbJCfQi3VPFtopx/zzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299616; c=relaxed/simple;
	bh=f6UJyEw9i5rteqhbf8vMuiqLur1lK6pyVLjptQL1iDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJip9pb3BS91pcoKc+jFki3BkrNHkmtiEamyuFqoWe/IYF9ZmCUN9LTP2cYLWMPV/t3wNpl8WIzxnriI2a57CJQvc1I7vIPHoX6EXkSLA0PNI3tLx3/FC/eS9ZzpVoNhomwQIbXcUAFDjEO604TEJPiwZbiz9250Z14VQug6r0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IsM44Qc9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso3200725e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707299613; x=1707904413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48P2qL1gH0dQ6fHTQ76ksb1Xd1qjgcR6h7LjpWAx3E8=;
        b=IsM44Qc9R7A/UTWt6jxFoqxH7cG02NPGq0PVtrHCuR0pUskRz6tIyr55tPn9avvyfu
         I6aZWbDWspkVnYDaKhs+YvzCQJ7Rt6eL6k4DtY8yaT9sFJJaRBj0YJoduiCO7lzmK/6L
         NrS0mrz1ZF9/M5idx02kW63TnKVeylVmB0pESIMspjG9I8f19bW5efF94xoPjbhwvZGO
         7XW0S/b5emXT6Kqh8XXZFbGthZhaoq1NQGg46OciXT0CF0jRm3nQ2cqQlVrNrEaMWxmE
         Qgim2KAIdLJsuyb+wa9JO6ixC3uWTaPNNFhpTVcbb8jnrOaUQOPzX73B70fhDFY/jjbx
         bKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299613; x=1707904413;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48P2qL1gH0dQ6fHTQ76ksb1Xd1qjgcR6h7LjpWAx3E8=;
        b=aZeFlFgDC1t0DiCjmZN4c5DBzn02/KDQXhg3CSJa5PG6neNeicaErOM1rdIfwQJmNh
         lBzVraQVINF4DMbFHayNO0PLTqfl1RIWq3TW4Ql6qzdYotmwxrZ0ZuUWUWdohkaCmole
         NlFeMQGKLsQUci1yp2UgZaym4Q7g9xYLX22Zdpp9mTuFFXot2WOBZ8fjQSin8PicKZcq
         tT0rtMu3tUJzIFB8GXjGkiSf38888prR0u25tBRlmBHAVxZIK+JlL6VM1cLjr9p7B4Bp
         inEiQvobKl96wCa68mWLYQUS413XeKrK61AKf8nx3Snw5OXP+PFnj6Rmayp2RVfJ8s7X
         kMNA==
X-Gm-Message-State: AOJu0Yzdkz4u3/HoRMTO4MMSUbYbFp0v58Px9X9NIrPKkJGgR3f2F0sc
	ycv9jLlUpHOQ87CZeJLPPXUt4ccohYbq3tPl7DMHi6GOlgexbdiie1IM3I9Dclo=
X-Google-Smtp-Source: AGHT+IFRJY/crKfhr+4TJQ3MY6snvhsHCaf0dsjBr+P8mHGFvkHhupWDao5D9UxxcPXdlTwvPgN6IA==
X-Received: by 2002:adf:ec92:0:b0:33a:f84b:22ee with SMTP id z18-20020adfec92000000b0033af84b22eemr3345895wrn.12.1707299612912;
        Wed, 07 Feb 2024 01:53:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlQ+57aIaTVy+XtVNf6j1JEM6Jch3bsxVdjPxf14dabGbQcFhE7cn6CWDbaIWXakSKRkNUG604IKh3kWJWzewfazl628QtiO/+ft4w5MAK00Ik8dJ2+gmCP312XBSgdKWw0ROXtxKHzhE385jPpVcjaJwWVZafMNEr3dsfVoidG54NQgLYblLEdsSSpJKl3WJ95UimV9ZmbCRf/Ty05sb4l1IQpY1TK4HfV658z+MAxCFrvt4saX57y8AemskGRjqcR2mF72rY39Z6vUzpWb7glXXnLqYfcix/fSNW0Okbkxi8RbFB3TVQPeKIyk3jaBrpqf4LPkOEN1we8QNKavL5UmwpKlivcjQ7Nd7i91pjU2mu6WKKTJvb9wXVgt/p4gmUf0p7CkoiOkE+HqCGKuJ6QhK5AAVOeYCdUOUFKalySJjuhghRFpa2E5sdtMmcsgT528lm58XdOxfArFpTkhd45+zLlSaKi+3k4tPd6xjx7eRz8NYKZLA85WoefJUjV9pFWblFM8vc+axHjBMbx0nX60IrBbrhWAz204SX2L6Pc1JSZ6DROxwdKcdyMKiJ9OLClqRfySXYggr5qYD2Rw+uVzGJs/PrmBIvA96nvLTfln7Qph+RB3OW0qsW0xPnV+utJOOl5JFUkHcyndMii95nZFfbvOxI7oBLdSlmETwtHlP4LzOC2ayA0sNadRdUfjYrKzlKp1fVEQr3szMQHjtG1gNfaFkJlD3GAl9NTBEKk38RHj5B4jTNDR3cYh+0YXQ9TQ5oDAfsQlX1CIwg
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600010cf00b0033b4e58746asm1020055wrx.69.2024.02.07.01.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:53:32 -0800 (PST)
Message-ID: <e61999e6-8c82-40a2-a2b9-e19d636364f5@linaro.org>
Date: Wed, 7 Feb 2024 10:53:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
 "P O, Vijeth" <v-po@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
 "perex@perex.cz" <perex@perex.cz>, "McPherson, Jeff" <j-mcpherson@ti.com>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
 "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "Djuandi, Peter" <pdjuandi@ti.com>, "Agrawal, Manisha"
 <manisha.agrawal@ti.com>, "Hari, Raj" <s-hari@ti.com>,
 "Yashar, Avi" <aviel@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
 <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
 <8fe0b2d1990346efa056d6c2245412c3@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8fe0b2d1990346efa056d6c2245412c3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2024 10:47, Ding, Shenghao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, February 6, 2024 9:53 PM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; broonie@kernel.org;
>> conor+dt@kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
>> andriy.shevchenko@linux.intel.com; linux-sound@vger.kernel.org;
>> liam.r.girdwood@intel.com; lgirdwood@gmail.com; linux-
>> kernel@vger.kernel.org
>> Cc: Lu, Kevin <kevin-lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>; P O, Vijeth
>> <v-po@ti.com>; Navada Kanyana, Mukund <navada@ti.com>;
>> perex@perex.cz; McPherson, Jeff <j-mcpherson@ti.com>; pierre-
>> louis.bossart@linux.intel.com; 13916275206@139.com; Chawla, Mohit
>> <mohit.chawla@ti.com>; soyer@irl.hu; Huang, Jonathan
>> <jkhuang3@ti.com>; tiwai@suse.de; Djuandi, Peter <pdjuandi@ti.com>;
>> Agrawal, Manisha <manisha.agrawal@ti.com>; Hari, Raj <s-hari@ti.com>;
>> Yashar, Avi <aviel@ti.com>; Nagalla, Hari <hnagalla@ti.com>; Bajjuri,
>> Praneeth <praneeth@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
>> initial DT binding
>>
>> On 03/02/2024 04: 05, Shenghao Ding wrote: > + > + ti,tad5212: Low-power
>> stereo audio DAC with 120-dB dynamic range. > + oneOf: > + - items: > + -
>> enum: > + - ti,adc3120 > + - ti,adc5120 > + - ti,pcm3120 > + - ti,pcm5120
>> ZjQcmQRYFpfptBannerStart This message was sent from outside of Texas
>> Instruments.
>> Do not click links or open attachments unless you recognize the source of
>> this email and know the content is safe.
>>
>> ZjQcmQRYFpfptBannerEnd
>> On 03/02/2024 04:05, Shenghao Ding wrote:
>>> +
>>> +      ti,tad5212: Low-power stereo audio DAC with 120-dB dynamic range.
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - ti,adc3120
>>> +              - ti,adc5120
>>> +              - ti,pcm3120
>>> +              - ti,pcm5120
>>> +              - ti,pcm6120
>>> +          - const: ti,adc6120
>>> +      - items:
>>> +          - enum:
>>> +              - ti,pcm6260
>>> +              - ti,pcm6140
>>> +              - ti,pcm3140
>>> +              - ti,pcm5140
>>> +          - const: ti,pcm6240
>>> +      - items:
>>> +          - const: ti,dix4192
>>> +          - const: ti,pcm6240
>>
>> Why dix4192 is not part of previous enum?
> 
> dix4192 is not traditional ADC or DAC, but an Integrated Digital Audio Interface 
> Receiver and Transmitter, like an audio bridge to connect different digital audio 
> protocol, compatible with the AES3, S/PDIF, IEC 60958, and EIAJ CP-1201 
> interface standards, Left-Justified, Right-Justified, and Philips I2S™ Data Formats. 
> So keep it alone for professional purpose. 

Hm, it is a bit surprising to see some PCM6240-compatible devices 100%
different from other PCM6240-compatible. PCM6240 is ADC. DIX4192 is not
ADC, not even DAC. How can it be compatible with PCM6240 in such case?

Best regards,
Krzysztof


