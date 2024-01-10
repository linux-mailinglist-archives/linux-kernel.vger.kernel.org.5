Return-Path: <linux-kernel+bounces-22785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF282A2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7121C26364
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D751038;
	Wed, 10 Jan 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQptysEg"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082D51013
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e4d64a431so24495035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704919717; x=1705524517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1M7ps4WkHmNkGZ5ie9/GgPQiwPprEwmBMC0OtQiSIE=;
        b=KQptysEg6FRvwy4NrwrXC0EqaMoyt5t3dLV3+40MyOrqzJ6g3w535Ym8ucPUsrFmL8
         ho5kuBORycW/+Gkk5Y/+alc1xZeo5l27qtK6xPeFIaptfegPoYr5JwED900DANs0qHCg
         V4Qo13bNxKYf7IsTq/0FEHHx3HxtucrFAyaeroO8YcaCOZpCCpBgYGEhvXKbWgmYdsWW
         qsGmLm5ZG00hVyFuwe+XxGeYB9OhXAzEY9MgwzA4icFNaBBe33/85vq0+GqcIjs3V5Di
         zSFrsVW55oq3B9QuClzZws2d9IneAxF1vZb5bUsdu4qRo74eYDF+9sAD0xAsO35w4LP6
         gUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919717; x=1705524517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1M7ps4WkHmNkGZ5ie9/GgPQiwPprEwmBMC0OtQiSIE=;
        b=vDtFXhbN09sJqdwO0bmgK2p/pWcxPpxD8DtIMej2pJdvNYZCjiPemnbYUhOjcTi1lR
         z+7v8/oDGe+rsM/y7fOxxozHYXT3wnuYPq45uqHaDjf1so+9/Yh7whvFRHgK5xav/8V9
         9S2IzgpRM0QDVZL9nO3mP4azLVulXI7SOZYKEkizVLosEg5hS3exkeSPIEtGVXcgLvWG
         dJCrZnIru97bNFLUU60iyXqV4CM0cIG7FVYHoB+OeDfRBrivXnTiDC4VOAC703mRafpX
         Q00RNbMZaq6apWLEFtah/5Duzlo/CyJthFg6z/p83cIJq5VSThw6eyJqRaWVQ04QYwnI
         mXgQ==
X-Gm-Message-State: AOJu0Yx5TSpnrU2yPjDi9xhONexrg5MaewDiPQ7OjSVWf/fSO5QXhCP7
	rnnr+CGfiGyPpyYENjBzvDuAgG7f92rq1g==
X-Google-Smtp-Source: AGHT+IFFBFLsGgbs9TNQvPPt+398YFKa222APcbfnqPfNgMc1s2czccJJiiPIanyznR2wN82QXE/eQ==
X-Received: by 2002:a05:6000:885:b0:337:3f72:3dd5 with SMTP id cs5-20020a056000088500b003373f723dd5mr41314wrb.32.1704919717656;
        Wed, 10 Jan 2024 12:48:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d6e8e000000b003366c058509sm5659636wrz.23.2024.01.10.12.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:48:36 -0800 (PST)
Message-ID: <bc37f7d8-c43f-4751-9216-fc95f439b2f6@linaro.org>
Date: Wed, 10 Jan 2024 21:48:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml
 add sleep-mode
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
 <20240110172306.31273-3-petre.rodan@subdimension.ro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110172306.31273-3-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 18:22, Petre Rodan wrote:
> Add sleep-mode property present in some custom chips.
> 
> This flag activates a special wakeup sequence prior to conversion.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> index 89977b9f01cf..350da1d6991b 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> @@ -86,6 +86,15 @@ properties:
>        Maximum pressure value the sensor can measure in pascal.
>        To be specified only if honeywell,pressure-triplet is set to "NA".
> 
> +  honeywell,sleep-mode:

"Sleep mode" naming suggests there are choices, like mode foo and mode
bar. Probably you want something like "sleep-between-measurements" or
something matching how does it work.


> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      'Sleep Mode' is a special factory set mode of the chip that allows the
> +      sensor to power down between measurements. It is implemented only on
> +      special request, and it is an attribute not present in the HSC/SSC series
> +      nomenclature.
> +      Set in order to enable the special wakeup sequence prior to conversion.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>    vdd-supply:
>      description:
>        Provide VDD power to the sensor (either 3.3V or 5V depending on the chip)
> @@ -140,6 +149,7 @@ examples:
>              honeywell,pressure-triplet = "NA";
>              honeywell,pmin-pascal = <0>;
>              honeywell,pmax-pascal = <200000>;
> +            //honeywell,sleep-mode;

Drop comment.

> 2.41.0
> 

Best regards,
Krzysztof


