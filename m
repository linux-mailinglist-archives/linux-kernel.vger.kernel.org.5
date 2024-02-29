Return-Path: <linux-kernel+bounces-87049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B297986CEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6994828BAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035413C9E3;
	Thu, 29 Feb 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWWExN1E"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75489134430
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222415; cv=none; b=Qhy56+5/6lMzOC6SMSuyZjLJjXQhvbDvKzHey6QHA8z4E/2WWUQ2CKl5r1bTgynCZEHSNbK3F/TCFUw1kU3D2BRn1u+cyYuHUDx8aIc075m/XCy7Z2Qc7FpK8GBz9qj57EuirdKScE+WJsamBBcA4MFwd5OieI+6JKhUqAi+wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222415; c=relaxed/simple;
	bh=w5iq71vwmmte3zGqYTwhcH6cdU2SzgfqS6g3WsC9OSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeAruy89cBzptNr8ekbntXJ0XTLvpSoaX2fSKH5gwKkDXyRzgRUj9ZV0Da+pPFHrTSNEpoYbLdR+r7jAE//MrVxU/QJt77lfogeKzOplIZPz2FcfR73SRIiyVIGXh6EmHZpQTvGkQH9Wmh/bHYqSJ58oTu0W3ntKLusX24kMIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWWExN1E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a293f2280c7so219757666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709222412; x=1709827212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRbG9hsJP0WYlORDRCfofHJYUP4yWUvt2xzj/adPvC8=;
        b=wWWExN1EWO37c4h8INOvgVYd8wc8ZVBcKaPWprJacHeu7kzbSsFldPyOoXj3uSCQaJ
         8lWeQcM0smNmFUIF0rDVhlcMqglw98GRA7AvDEqFSDQrzqqFnVsrWCp8jPx++gGVlPEI
         1XCMFYveQuFXTGNYqRndh8xYkdq+EYT1tOaEGBHGJopBPFkTRK/p8sm2mKxx2/qMp8ln
         S76b/SvRIQqNoRiZ+KYMwQu4NVHz7EEQMRlCAYyG42V+XO3n85/iZClYFsffL00ZCnrN
         +6gsnHt9/Ym6oB9Ejun/RuibFHXEDpAJ40Dbj1XjLYirs1qxfVXIJ7oXy+CzqkZxbnn9
         R+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222412; x=1709827212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRbG9hsJP0WYlORDRCfofHJYUP4yWUvt2xzj/adPvC8=;
        b=PtOt7jSeWLWe6Ig4RNe/hlsIpkwnirtNzuq9GxGxjQnyJwd+9xtcLwDrc/3fdHTt2t
         xem9DteWHgGX+Oj+8ByY5s/MIMAjXLqR8CUqJb5ljl1qr/rClSeiC6NNCyOkUM8bl6GR
         My3anBINEo5Atvb/5DIUT/2re4j8y5MqgXMs7uS9SbxajGe076bvmOOjoPtbZLiSuWAG
         1YV7SPXN01+MS9r3Uj06bEj4S5wAG9wnd4sOwoSgiPlLLE6Q4xDFuKU8ghlqiAYXE61b
         ZAXN8x27Jcrrv5+wHX+HOSuPqd8FRK4uXWRBjgopoGS4FC5ZXs7N6rdFA1b/pD9cdt9n
         uUxA==
X-Forwarded-Encrypted: i=1; AJvYcCV9gZQ+xx6EjvHUEShLiAtwkB/5PuMshLIgIkDmbH6Pk9Wgp7IUc3+i2WLbA2mDKalw1kWshg+ZYBbPh4yTNlaxngYKQV1EQa5RxZIo
X-Gm-Message-State: AOJu0YwINU1c2OvZmuFKy8hdyAHeifPP9Bz1RuhrE4URj3kOJuwOnrNE
	X+NmzPUdqwnCp1N09XzMT8Y8gVeVKIHpBf0MTpp9d4i0L2NsVKaBGhBifHvt+eY=
X-Google-Smtp-Source: AGHT+IFRZVGTl1pd/dm10q3vG7TFk5XUl+XxXPCC7r1ReUdSZxmCcQ6kK5z1+dzrKwSe+pl2I5TzSA==
X-Received: by 2002:a17:906:aad5:b0:a3f:33c5:ffb5 with SMTP id kt21-20020a170906aad500b00a3f33c5ffb5mr1771991ejb.76.1709222411854;
        Thu, 29 Feb 2024 08:00:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709067f1900b00a440e2ada28sm802457ejr.201.2024.02.29.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:00:11 -0800 (PST)
Message-ID: <8ad18b06-7ff1-4463-8ba0-d7a7d54e5b65@linaro.org>
Date: Thu, 29 Feb 2024 17:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for
 additional models
Content-Language: en-US
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
 <20240228135532.30761-2-mitrutzceclan@gmail.com>
 <9f3e461a-0b79-470f-b599-bba45cda006a@linaro.org>
 <43840914-cb4a-4758-9691-0ebd8fb97681@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <43840914-cb4a-4758-9691-0ebd8fb97681@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 16:08, Ceclan, Dumitru wrote:
> On 29/02/2024 16:49, Krzysztof Kozlowski wrote:
>> On 28/02/2024 14:54, Dumitru Ceclan wrote:
>>> Add support for: AD7172-2, AD7175-8, AD7177-2.
>>> AD7172-4 does not feature an internal reference, check for external
>>>  reference presence.
> 
> ...
> 
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>
>> There is no such file in next-20240229.
>>
> 
> It's not yet accepted
> https://lore.kernel.org/all/20240228110622.25114-1-mitrutzceclan@gmail.com/

And how can we know this? You must clearly document dependencies.

This also means the patch cannot be directly applied and cannot be
tested by toolset.

Did you test this particular patch?

> 
> ...
> 
>>> +  # Model ad7172-4 does not support internal reference
>>> +  #  mandatory to have an external reference
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: adi,ad7172-4
>>> +    then:
>>> +      patternProperties:
>>> +        "^channel@[0-9a-f]$":
>>> +          properties:
>>> +            adi,reference-select:
>>> +              enum:
>>> +                - vref
>>> +                - vref2
>>> +                - avdd
>>> +          required:
>>> +            - adi,reference-select
>>
>> Are you defining properties here? I cannot verify because this file does
>> not exist in next.
>>
> 
> No, just constraining reference-select to be required and exclude
> "refout-avss".
> 

ok

Best regards,
Krzysztof


