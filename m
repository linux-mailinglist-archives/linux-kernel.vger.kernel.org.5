Return-Path: <linux-kernel+bounces-149321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933758A8F86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD641C20E50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297480614;
	Wed, 17 Apr 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdA21XGA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF478481B5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397133; cv=none; b=Aw6zS2o4c97fTznobln1Dvdh3C9m+6OOw8aPuAHBU5udZsG/PgPdXjslF+JrdGwpS/8oYXUjSVi94DuWhl3m45tJo8UgqG/QvVpoAJq6+jVUIPBxf2ssRUMPUmzR3zSF7SDOwgz6VJEaVnZohOqnqMfO5RVDN1q2HmSKYBRw0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397133; c=relaxed/simple;
	bh=6i4Cv0Cu8Wsm01vT2g1r+s/PasfgE5ZGUhhu9OBQ/J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEjko+gMFlbhklP6/MwHsJVkE/i5CjkH+kaVKdEcWmNjKc6LUV/DCxBFFj1h/raoPlCPKxpxeypRtl5rCk4hqRr1QOMPVks4herg7Jm2CIiXC7Mx4Sm1N6GNTs3Hz1DtO4mtU++j0m7qwagAIJ8kgNyAusjHETvTaWMqeorJOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdA21XGA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2c725e234so11101175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713397131; x=1714001931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UkNsHfUgcBvPYcIS4iOrjeSFhyVjx7zW9aQK7jgR0tY=;
        b=bdA21XGArvy8hLzZDmSjLq7bt2MR66SoRmgtQBeJPan5HgLmhKH+GRU01/GOPgDH8D
         fSHQqTUT1cyrqXmN8JZtTXph8V3Cw6f/rZ5qImBn8kgSs66QPgUtX6ORxnd3Mobbk8Vb
         hybi4uhPSgyXQx9JsSD9zSEUbt54qmfgtBM0uPkNpA7yJj/Z9iklqOpQeOe+Z0ozPNQK
         c3U3dt0ZnbzQCDjD44rVWwuN5WEBvysVdZs+hx/k6kp8yhFVhgapcgrpnAcHLi0uPrt2
         YEn+GXGpHPHbQee0H9QihihxTVxpWMBm6i8823zhkeIMiCtgIBi4Hd5k2/i2xvlgPi56
         HPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397131; x=1714001931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkNsHfUgcBvPYcIS4iOrjeSFhyVjx7zW9aQK7jgR0tY=;
        b=iXgV0qRLhZLCq2JTyJU4E6RWzrBIydYVSr6R4zewqvOY6xIZDPzsEq+gOMcdOLB1YF
         XLToDQVijv5ohLJGr/ZVYXFZfSoaVFpGO7i6PkIKoFnoLT17nxF1Lmyrc3ezoG+tFOqS
         oBTNz2dhV8m8cUhiXxMF0s6RLeTkK1sn3VN+hDJGNEpA0xr+MxtddKBbp/i/QTYi+Ofu
         EWrNF8NXwXSl25tSfvaHrHGL4Z6gtI9kSWHv+kKqwLMH/li980YYeRdMYOlOnc6zjXAB
         Bbfvf/f8UUVY2k2LG5MTgZrTGM2poRglNhAf9bW8zlYYNdk2FFqutacxKdafu73NxqLa
         KDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcA4XwvSO58YV7khQb0sK8C2af/26oj+r7HAdU7v6hatsuMpYu5GUcZNfuI/RW5OArM7L5rM0F65PPcZac7wAxqnKx4X5caTHvHdQH
X-Gm-Message-State: AOJu0YyhuDTmgD7Yh8LOmA4Ormw2MZuIavnM0tFPw7M8QnHB+p3V+gTF
	+GkwGEiwMobKkCdgCAPwGjsPeAxvMV6tHTpzX9stVLqaamatwJfaFZAbJJk5V3E=
X-Google-Smtp-Source: AGHT+IGhX2HUjpHerW5fCM0H8JbMHH5aK4RMVYhuxn1Xucz8RMiiAZiR9CboNpd+IfqpR4kI7svghA==
X-Received: by 2002:a17:902:dad2:b0:1e4:6cd7:30b3 with SMTP id q18-20020a170902dad200b001e46cd730b3mr934160plx.23.1713397131023;
        Wed, 17 Apr 2024 16:38:51 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.146])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001e0648dfd68sm191828plb.296.2024.04.17.16.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 16:38:50 -0700 (PDT)
Message-ID: <7578692e-ec77-4045-8759-be89e3af0c3f@linaro.org>
Date: Thu, 18 Apr 2024 01:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-5-alisa.roman@analog.com>
 <2ad06ea8-220f-4d09-bbe7-c4dd12d0d8bd@linaro.org>
 <105bd25b-e5ea-4649-b9b2-2547e94b103e@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <105bd25b-e5ea-4649-b9b2-2547e94b103e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 15:08, Alisa-Dariana Roman wrote:
> On 14.04.2024 00:19, Krzysztof Kozlowski wrote:
>> On 13/04/2024 17:11, Alisa-Dariana Roman wrote:
>>> Unlike the other AD719Xs, AD7194 has configurable differential
>>> channels. The user can dynamically configure them in the devicetree.
>>>
>>> Also add an example for AD7194 devicetree.
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> index ba506af3b73e..855f0a2d7d75 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> 
> ...
> 
>>
>>> +  "^channel@[0-9]+$":
>>
>> Why restricting the pattern? If you have 256 channels, how are you going
>> to encode it?
> 
> Hi Krzysztof,
> 
> Thank you for your feedback! I applied the rest, but as for this one 
> isn't channel@1 -> channel@256 encoding sufficient?

@256, so 0x256 = 589, so a bit too much. The unit addresses are hex.


Best regards,
Krzysztof


