Return-Path: <linux-kernel+bounces-65014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537358546B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D721C2290F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09E1168CE;
	Wed, 14 Feb 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeh9wA4j"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6312B69
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904660; cv=none; b=GmIqwmNlv+1Q+zaEVkldtTDgwNV+WBJt71zNj+qf8Y+E1s8ApFzt29lohRifXo75CzW83GYxx274Q7f5c33f8/2uvopon8NM/cQKgXATohJmVwl/I1qg6F4C+WybRIeD3E0LnIsETzPAJeJB4RPDfGFQK9ZwLc3N+Web3yuV2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904660; c=relaxed/simple;
	bh=ky5UXp/TObAHd8utYZilpxedN2wyos7oikTRRvpeHpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERTa5y0/XTfVaXmFTApqqLJTJi0+EwtWIgwFZdQ1ImHSpFgfUWT2bXEkzcx34vizfltFcD3Bx+1cAZZvhZ/vUR2T+WU8iF4bY4+yeh/VEyjnv0REJe7bqqXnwEvKUFsOvTI8qVm8bzBDuxSPi4mF1WsTmc8NcfoCS3a8SA75hN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xeh9wA4j; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so7074302a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707904656; x=1708509456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qwgZ3XzOO4ec8IpoYOv1G1tB0JePdDeZHn75OblYmk=;
        b=xeh9wA4j77qqo82rWvtsJ/GGJtmSS9eEYEAtqSbME2iOnd53Jh+wRxhTFS9V5NoDM2
         HL6fPDljhdNza52CFgt0Ss6WqJBKdxRA/2ZCe9MX1cfeWvkb2iNoDnZIkRLgatL8kz3A
         uNZZKk8KEp5CtIFxoIYo3fRW9DWypMqyy8J2agnCVgHV+FZlc1DjHtYrSHMusCAfBYMG
         ZArmARuoqtfnIXbzwiSdF/QGnk7LgutT9i7bLxLqOjP3SYwIBK0KJMbIfkWyNLdvX05T
         Wfmcebbu+5Lpo7tsqHj1FP5o9z8zXbxUh7j3NphtY4Yc0bbroQBIBxcArUu71v6+xcCt
         trtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904656; x=1708509456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qwgZ3XzOO4ec8IpoYOv1G1tB0JePdDeZHn75OblYmk=;
        b=ZA6og1gC4NefQl1XXS5u1EOylVKJq+tDnOdq/KMGDxjAquVq/OvzH/Lws1XjNj41fR
         8FI3x8cgxnSsocuqUYUAg3iq78CduGedZGP0/k6sxwFD1TC1n4UKXa4pK/A5nQY751EL
         AFOxnDVuhe2etTEiRORzQz3QXhlKe1yzAXSt7eswXdWGZWCnMUR6c0VJlj5hQHoHrn0r
         4CoI5JA0peJFsJgqpz0UdVB5n7ZfuKmuNMEmwOTHD09ZXtuTqogfqSFLb6CtTwDbSapt
         VwGT/CoC80wuSoOS4xF4Q4b8JzuSPyZRa72l67jNMC9T1GccVIGnQBIg0qhMcg99VTsU
         cQkg==
X-Forwarded-Encrypted: i=1; AJvYcCWU7b/RlPDTsLjeM5ksnAdMPucBJQpoYvOXZ7Nt3EYOADQrbIhR7xQsjM/qYbcoJ98geGELrzAtOTRMs/btX7qcKdtXfvrts8k1uliq
X-Gm-Message-State: AOJu0YxQHmKtW8iD7stJu70t97wN+7DNN+Q+hYXadx9Ycta5zgIDHR6q
	80B9eRA/7Fcu1Y5wXUcMKxKJUi1Om+nfsCEZkcdOk9HXq0YCOEz/FbgazJ5t7K4=
X-Google-Smtp-Source: AGHT+IE4Y+RGG3vUwTlBl/vvycYbLMdrrBS5nL5y8MegcfRNFh1Nw+FKrBSEvA8sKq8V0Qy7TQx8xw==
X-Received: by 2002:a50:c181:0:b0:562:7705:57c6 with SMTP id m1-20020a50c181000000b00562770557c6mr1000458edf.14.1707904656703;
        Wed, 14 Feb 2024 01:57:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoBcuB1kBua1jwtu8FsBNnbU+6Q1BaU0+K1fVZtxPzwgsOu7qbUgLx+laB7tD583F37Kv8AZndus2Mqdxk4cOy0S7+rzeoAJuhMdNGsYhTF5B48qd39wLM98XWF/OnsIQNdFs7UN/siXR4yGvp30t9t1s4uQRoD4g932S0gRbYqQdBZojw/FfDpa+mszqmNJtjUc8EhV8ZMFVGZxQzX36aSdWEuklcyF39zUJRVE6K68elzVEVJlC1K9jiz+PvAkKOIfNOXUoT+BtcsYMJ4CkFwmnkPLKjFrV79cSrqUt/EddgZKqC07B7rEYHr6o6abaq5N3/XVgKOZUsrsoCdwgG0QFJ+f0sARYGVwW4FVninYRjshrXEDnAj/PkG2ANCLTkzzaKjkFyG7nmJVMm2rAAO4rGZm7QSRA9wvFbrjPDwAvFnA==
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id g22-20020a056402091600b00561623dff71sm4516924edz.59.2024.02.14.01.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:57:36 -0800 (PST)
Message-ID: <d4337a53-8f4b-4782-8ce1-b0e4d7893e28@linaro.org>
Date: Wed, 14 Feb 2024 10:57:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop redundant
 GPIO node
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>
Cc: Ralf Schlatterbeck <rsc@runtux.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
 <Zcogl6tqbMdQldKA@smile.fi.intel.com>
 <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>
 <20240213161905.GA1459669-robh@kernel.org>
 <ZcucO8R8ZOtR38jl@smile.fi.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcucO8R8ZOtR38jl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 17:43, Andy Shevchenko wrote:
> On Tue, Feb 13, 2024 at 10:19:05AM -0600, Rob Herring wrote:
>> On Mon, Feb 12, 2024 at 02:59:02PM +0100, Krzysztof Kozlowski wrote:
>>> On 12/02/2024 14:43, Andy Shevchenko wrote:
>>>> On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:
> 
> ...
> 
>>>>> Anyway, binding examples should not be collection of unrelated
>>>>> solutions, because then we should accept for each device schema several
>>>>> other variations and combinations.
>>>>
>>>> Is this documented?
>>>
>>> Yes, writing schema says what the example is. We repeated it multiple
>>> times on multiple reviews, we made multiple commits multiple times and I
>>> briefly mentioned it also in my talks.
>>
>> While yes, this is the guidance, I think this case has provided enough
>> justification to keep it. Let's move on please.
> 
> Thank you, Rob.
> 
> Krzysztof, can you send v2, I'll apply it to the tree?

Sure.

Best regards,
Krzysztof


