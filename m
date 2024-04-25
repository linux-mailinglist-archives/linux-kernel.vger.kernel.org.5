Return-Path: <linux-kernel+bounces-158652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE78B2377
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02471F24CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72C149E05;
	Thu, 25 Apr 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moNxw8Nf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DB1494B4;
	Thu, 25 Apr 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053937; cv=none; b=bxVfPXKVBtUOlq2rYXAdh8dioHDj6L4JIe08evO9w98+fOrbTsUyY0wT+drhuRXyJu4ve10uwK4vKIMU4a1flyCELjLEBt7zNFhi/JV0/ckKU8VdJZ/C0pIBHustMHBXaJBJykiEE+rIoqg+mXZPtZY0gstIsc9ZuNf9v0dr5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053937; c=relaxed/simple;
	bh=0vqbBfgQWOvB9SnNZ1mor6HTYreVHgeMs3CGoKbk32k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRVkANKQemrkCIXNS15dFBURlX+tNznWGV9mQPzRjtNQmz82YL4r6LJE1lQ8+b9FbU6DvGg6MzcJUN5MXm/EDNVECR8GB582q8hQ+Mk0+Cr+hWc0hZa3C4b9NsDimt/dCD50Fv6+PCbzOTpdfmmHiDktK1afIUHEgWConsEfKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moNxw8Nf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so1022717b3a.0;
        Thu, 25 Apr 2024 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714053935; x=1714658735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S3XUJ4ZkZdcpoZK51QtoI2+/sb3WV/5m1K1ccq4PQ4Y=;
        b=moNxw8NfnkdbWdnO2iAbB9u4YHlLwza1lul/1nfmL04wCmkdcW6Hmu1ACQpB6YN7cJ
         yuhd2mj+cRktq0GzByHVaMHwjiGVMmI0e3oYVDEgXSrbMri+P3hDSNLMvCIOu9ERDeQ+
         kKn6HxjCTTfdO/l4AEw3whd8Wnuz2i+2BKpK2swPFQInGRz9nX8BUUl+/YFfJ8Ai88xB
         YaqMBgN6hmMqwHNjbFRUb89IcDcXC2AptRzuv/aNCq3xTjuGTzmddPhAPri0HwjZyCmZ
         VdYpwUqCuVIDtXtuB1EEqpWAnQfAUp//YeLTQzauTlZokOT3xUjfubL26I9jldmp7G4O
         QmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053935; x=1714658735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3XUJ4ZkZdcpoZK51QtoI2+/sb3WV/5m1K1ccq4PQ4Y=;
        b=ElHLYFLMOhL16UuyOshNql224MEZleHNFO2dW1PcsR7msrLDlpb//PKRJR2NRK24CP
         szMilW+3b5ggHXpwUFfVIBLXhaYfW17u+Nh+bplYj3FveFamEgYpsYSMsp+6NJcMES+O
         9nNBksTioVYIG7oCFLjSlHHLJzt4mpA5cUFWRG6Kw6JxsRDMfuHPi2TTpYaS/ACJehfw
         nvhELqNUyuOfqTMxjQ5hIG+GBXF/Nk5WlpXyhe431y6WKsFwrI5YjqcahlU9l2rSMvgv
         LyzJx2tTGvWASJcjsvtiY1LRxjjk2oqiD/Va/vmFFNKroKsSX8w2NKHJCvXSqvy+K28s
         fVUg==
X-Forwarded-Encrypted: i=1; AJvYcCUoJMA7zEjkNWJhcT/ePm5J5lDlFA1lVLRSU8fvD3UnGAma94DSQTKT2h/kvuA3Hd/flN3omF1e6Lb3de03eEHCdpmGh0+dQR1t7qm5bXfi4TEDxSEs+BHwVUy41pyKQayh/bztcMvn/DAzP68MX1Zb6JQ7oioPObFYRWVOKM/u/J8Az6mS
X-Gm-Message-State: AOJu0YxUa6B6PVouhNhxlqx0/T51+U9/meJH4DvbBiL5VMywqLzmR3gY
	xieHNQnfgtdOy1ORlhg+WNtukgQri1FXQRAma0SYs5wzqcZMj8AF+jZQmA==
X-Google-Smtp-Source: AGHT+IE4RCWjv9M5BaI+OBlowRa6R/nT2SWuFZptzbIad0Jvy9Ml4EA6aIBgCoSeWh+3H1bO86q8Ew==
X-Received: by 2002:a05:6a21:626:b0:1ad:94d6:3c38 with SMTP id ll38-20020a056a21062600b001ad94d63c38mr1971702pzb.53.1714053934719;
        Thu, 25 Apr 2024 07:05:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005f750c31cf4sm12999810pgg.32.2024.04.25.07.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 07:05:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <396b47f5-9604-44ab-881f-94d0664bcab8@roeck-us.net>
Date: Thu, 25 Apr 2024 07:05:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
 <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 03:33, Chanh Nguyen wrote:
> 
> 
> On 24/04/2024 00:02, Conor Dooley wrote:
>> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>>
> 

The quote doesn't make much sense.

> Sorry Conor, there may be confusion here. I mean the mapping of the PWM output to the TACH input, which is on the MAX31790, and it is not sure a common feature on all fan controllers.
> 

I think the term "mapping" is a bit confusing here.

tach-ch, as I understand it, is supposed to associate a tachometer input
with a pwm output, meaning the fan speed measured with the tachometer input
is expected to change if the pwm output changes.

On MAX31790, it is possible to configure a pwm output pin as tachometer input pin.
That is something completely different. Also, the association is fixed.
If the first pwm channel is used as tachometer channel, it would show up as 7th
tachometer channel. If the 6th pwm channel is configured to be used as tachometer
input, it would show up as 12th tachometer channel.

Overall, the total number of channels on MAX31790 is always 12. 6 of them
are always tachometer inputs, the others can be configured to either be a
pwm output or a tachometer input.

pwm outputs on MAX31790 are always tied to the matching tachometer inputs
(pwm1 <--> tach1 etc) and can not be reconfigured, meaning tach-ch for
channel X would always be X.

> I would like to open a discussion about whether we should use the tach-ch property on the fan-common.yaml
> 
> I'm looking forward to hearing comments from everyone. For me, both tach-ch and vendor property are good.
> 

I am not even sure how to define tach-ch to mean "use the pwm output pin
associated with this tachometer input channel not as pwm output
but as tachometer input". That would be a boolean, not a number.

Guenter


