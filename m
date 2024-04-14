Return-Path: <linux-kernel+bounces-144371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250668A451D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5788281541
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D7136E0C;
	Sun, 14 Apr 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmU8vl0K"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410024B28;
	Sun, 14 Apr 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126699; cv=none; b=WqM1r8pprEXG+c5FkmBxkCQpmyp2HqYC+2WQ/9Tw1tjMkGqjpyBMezb9IYxBPbe2vzJFiqggAzIf8VP177PqaopKOl35MbbHoJKlX5VOlpT/VGFY5s3KPaGFFzMK+fCV8q5ItbZ3sv5XgZV+hUxwXJ5k3mo8sf6gTG+Vgo2G/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126699; c=relaxed/simple;
	bh=KiZI1eDYSppAbrCtjM8QTFZgOeAOOCTkojlRKCffmoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV8BaANlg/6QeNPkg97LDX+Y/RMwnC/VDvAfptov7TBVVH09kQOCfMIWolo6tVeZFo4z45OTN8Zw7cPsNFKkQkyT8OGg6tt2Ff9WkiU82SKiPbZ8LFMIflYoON9yGWEuCk5fbKIueeFyVf4iK/i7shhEb5oPBbozjnlmbgeBqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmU8vl0K; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a526698f228so51333966b.1;
        Sun, 14 Apr 2024 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713126696; x=1713731496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nREPFOOYGgHIZaRHKi35j5pPCOGBubEsYEeqw+j/IwU=;
        b=gmU8vl0KF03Vsl9QosVWISPBdIo44QO+wh16tZaLJ+KoNwDpORH4zN8XTZJr9204zc
         yTAQPlKfESBuXgMym0BCU6JbJLtQpT2LznjUKGxjbpUAUpmBse8G8ha+Pz+ANp7ZBZ2y
         0U/J4hrxJS4SjOv1ZSLVpMsl4w85igKgoCWFGxfobzzyPabKVY9j7ZwH2k3mL4VVU03b
         rSnii4iRyTQPuAjyZqmwaDYS+3RhRrK0WVZaUc4tpxgm5oWPmAQlWwu1q/yiy9Mr59Sm
         gobm6TM6SPvC0bLwb9xFzrDsdgBbOIt79zn0QN2RXfJthq5mjALAeqItP7rwmOKcrX5F
         xFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713126696; x=1713731496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nREPFOOYGgHIZaRHKi35j5pPCOGBubEsYEeqw+j/IwU=;
        b=WUVr9aud2pVgqeIAqFNHK6L6GAV27CtrzhB2j4vh3JsRDQ+IeXzhIaoOpWQePoOcBs
         2bXSD4xkI35MumpYUsylOM5ywdWe6/MSmEVxuJgGmxQSZZ1oEmszHhuXxDDbK9t4xV+5
         MV/axexZvolaMGMmy0/edOVr+iHxUNIkVxf+H5vihv/RAnyKfoErqZTtqXWvTU/BO4Zz
         8z6sweaY/slbaFLO+RRR9aG5qrzCWkswzxdQlwArXhlZyRg0ZBbRhfNSyd/fqGBGknKr
         gp0UysCREeZgIDMu0j/xWpKwWCWjRI8q1hKHg/9o2W11Qwbb9hQZZV5s9FCtaND6e/Tg
         KMTw==
X-Forwarded-Encrypted: i=1; AJvYcCWwZ2Z6IxIAZYB12Yezlk5D30on+nFeYYwSLtGr2GkYpVJb2i4xQcHxclniyt7OOMhKIA5YAYO75iE/SAejeNJZ4UE0zHlBuc1CrOlhgB8tGtgR+SxoSB17ElYXTz1564FZjgUf9VM17T602tIvaG9AML6k4iASpwo2qvOQwdx5BuKymw==
X-Gm-Message-State: AOJu0YwRhAmFPbV51z0jfs7EyqIwQJs3iL5NTNMa3kd0c0cSb7RvnqcH
	y8WcXzzhZTQwAiFSD4JhNnzy8H5WezS2xW2gqFYP1vonKGIgEUtM
X-Google-Smtp-Source: AGHT+IGUD/oYKuhmyY9fKyM8jgrVJ/LDpQDRupyPukzlQUDYrG8HXHzCHsXQITnhFuy1xolGzQAJ7w==
X-Received: by 2002:a17:907:3f9e:b0:a52:1a7b:2ef8 with SMTP id hr30-20020a1709073f9e00b00a521a7b2ef8mr6243899ejc.27.1713126696004;
        Sun, 14 Apr 2024 13:31:36 -0700 (PDT)
Received: from [172.27.138.193] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id jg25-20020a170907971900b00a4e5ab88803sm4572628ejc.183.2024.04.14.13.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:31:35 -0700 (PDT)
Message-ID: <1834b3fe-b345-4d93-97bb-82d0ffd75fa8@gmail.com>
Date: Sun, 14 Apr 2024 23:31:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-5-alisa.roman@analog.com>
 <CAMknhBHJpOxRmJbiprVNfYB4JbLzjR2a9S8=5iVz_9O+013u1Q@mail.gmail.com>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <CAMknhBHJpOxRmJbiprVNfYB4JbLzjR2a9S8=5iVz_9O+013u1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.04.2024 22:29, David Lechner wrote:
> On Sat, Apr 13, 2024 at 10:13 AM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
>>
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The user can dynamically configure them in the devicetree.
>>
>> Also add an example for AD7194 devicetree.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> index ba506af3b73e..855f0a2d7d75 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> @@ -21,8 +21,15 @@ properties:
>>         - adi,ad7190
>>         - adi,ad7192
>>         - adi,ad7193
>> +      - adi,ad7194
>>         - adi,ad7195
>>
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>>     reg:
>>       maxItems: 1
>>
>> @@ -104,8 +111,43 @@ required:
>>     - spi-cpol
>>     - spi-cpha
>>
>> +patternProperties:
>> +  "^channel@[0-9]+$":
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel index.
>> +        minimum: 1
>> +        maximum: 256
>> +
>> +      diff-channels:
>> +        description: |
>> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
>> +          appropriate value from 1 to 16.
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
> 
> Don't we also need to allow 0 for AINCOM here? Or is this property
> only for fully differential pairs and not pseudo-differential pairs?

I thought it would be a good idea to have the pseudo-differential pairs 
set in the driver (all from AIN1 to AIN16 referenced to AINCOM). Only 
differential ones are fully configurable in the devicetree.

Kind regards,
Alisa-Dariana Roman


