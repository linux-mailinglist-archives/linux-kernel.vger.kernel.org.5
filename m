Return-Path: <linux-kernel+bounces-88590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E0386E3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E491282DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95733A8EF;
	Fri,  1 Mar 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnZIIJic"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9E3987C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304991; cv=none; b=ST11aBILaeAGSFnV3fz81M1qzqCPO//JHJRT64gYGpcJl7wR95PeQ45smU5qtLr1N6dsqzreCZECsGpZHeOAQUVlrQu5SoPwDBXMin+dnsGZnc1VYoAyp2PhawxmYo0bF2RVfWjWFnmrMxMujMQXnSfkYvjceLyRbX76ujN7x0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304991; c=relaxed/simple;
	bh=SrGvlgfbt6XMAt2G6CMldGsswMNVi3x6R/Udm6duIVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcc3N9SCt+f0cXuiGMjOtGuC9cXhHs8dYzI+YL4itwE2/ak6bPzj+CNxwHTeAx5wWQbICV2Zw2OJ4bPvjoTUhtL++Nj6t0ADPgGxCXVqKUSI+d0kW+F3g2oNxk3kNHzvStEs6FryfDLtsfZ98BUbLixzWGPiYq5xCXJoWufjwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VnZIIJic; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a444205f764so287955766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709304988; x=1709909788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJ2N/OiuMCctFBWtfzvxsL/0apDKewkpQb9Icgwpht4=;
        b=VnZIIJicDfasdbOM/27RRj1fgoUrwTnQgWyj6WmDdzxfoDKpz3O5SmCm4OByLA9Abe
         KGc6wtsOAOI3cSZ88zwWhcN05kEuTwlWS5minWlzCMLkABAjPTXffvir0embzZrBrxrc
         t7VNTWxzY52ekXMh7EY51b9SDw5IXhthp8Eg8i9pJVtsuyu20yUAXuePK9w9AQwD2RR2
         ATMYTGsFZFJS6ZZaiT8ciOtf5XG6UUpxnKTzyzMmQFVgO3f/N2q/VSJ9gIMqTOflWVmL
         JPlFp1BZpAfAPTy/8fw/4O9dNZQuKt0kX9aJCOSTFcM6BHhc/+mBjTUccG4FhnTsmKHU
         tNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709304988; x=1709909788;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ2N/OiuMCctFBWtfzvxsL/0apDKewkpQb9Icgwpht4=;
        b=wUeSqAZ9mJVq4hOhsa/mGYprHctijWt+qXOGE9WEWtK5p5SMGrqimfluzlliHrrTbo
         HmpF1dWaNSoamwf+FeR7upredRl1B2rTLqMczg9q4WS5LAHdCC03ly2VUwAWu0eCx7Z2
         IPu8JB/LhXbxPF6y7+WJDBuYN5qYLOHEk2avQoJfWNVF7tT1KNfSGpDF+5qPNxFzHD4z
         3gZOd6knv/hTuW1o+4jDf6RYydKNoS7EFsv3FN24lQzpnA3PvQv4R6R1d6kRVA1C1WAb
         j0GFTEYc3r/v/khOXqgGgWodsV/2BFzWEvNHJ59PMip2OrL7ms3vbcSsDrV/uyhKTdww
         LZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXaiDjMpjvPR9TdVzJUdaaN/ngOdeRsj38jJ0yoeS5ClpPhrXKc+DyDtaYX9BJW7saMHahzMJYCmNJXzJNmmbXJvyN/5AWMzH2pCTlZ
X-Gm-Message-State: AOJu0YzMj8n40taS0KANmPDNLQrSu8tuILniSqKX8QXWBh5eQk0OreJD
	3ptqYYzoEoqzKJ2/YVQSKJYGbUw54dB5Gc4KAZg259Ciqmd06K6LuPU6jOeA2w8=
X-Google-Smtp-Source: AGHT+IHUQRH5oQpAgO2KsTYVChm3+FZfed4slE4Swu8lfsyjrU+M0j6mxzF+XaPCukzOQVzMYkgxUw==
X-Received: by 2002:a17:906:fb14:b0:a44:24c6:abe8 with SMTP id lz20-20020a170906fb1400b00a4424c6abe8mr1399825ejb.12.1709304987802;
        Fri, 01 Mar 2024 06:56:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id mp7-20020a1709071b0700b00a440ceb4110sm1783948ejc.183.2024.03.01.06.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 06:56:27 -0800 (PST)
Message-ID: <7198ce13-bccf-4835-aa14-ca45eed1f066@linaro.org>
Date: Fri, 1 Mar 2024 15:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/21] dt-bindings: crypto: meson: support new SoC's
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>, neil.armstrong@linaro.org,
 clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240301132936.621238-1-avromanov@salutedevices.com>
 <20240301132936.621238-18-avromanov@salutedevices.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240301132936.621238-18-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 14:29, Alexey Romanov wrote:
> Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
> 
> @@ -11,8 +11,16 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: amlogic,gxl-crypto
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,s4-crypto
> +          - const: amlogic,a1-crypto
> +      - enum:
> +          - amlogic,gxl-crypto
> +          - amlogic,axg-crypto
> +          - amlogic,g12a-crypto
> +          - amlogic,a1-crypto
>  
>    reg:
>      maxItems: 1
> @@ -21,10 +29,14 @@ properties:
>      items:
>        - description: Interrupt for flow 0
>        - description: Interrupt for flow 1
> +    minItems: 1
>  
>    clocks:
>      maxItems: 1
>  
> +  power-domains:
> +    maxItems: 1
> +

Don't break the order. names always follow given entry.


>    clock-names:
>      const: blkmv
>  
> @@ -32,8 +44,24 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
> -  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,gxl-crypto
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +      properties:

First properties, then required.

> +        interrupts:
> +          maxItems: 2
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1

clocks: false
clock-names: false


>  

Best regards,
Krzysztof


