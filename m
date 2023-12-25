Return-Path: <linux-kernel+bounces-11040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88481E083
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BAE1C219A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DD51C4C;
	Mon, 25 Dec 2023 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arNMY6Vq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1550253
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a233bf14cafso446997766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703509062; x=1704113862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2836GHVSMxD4pEMsvcSkpc9zsaMTJx5V60Hbz6IE2rg=;
        b=arNMY6VqQKbyw3/Pn8j3DMRnPjH8PDZpirBWyqzqBMsrPIRhqiNNuLH/x6LN5C3es+
         B1Llyx8TBYqJzJTua1vloYE1ObVGAjswWINP9L2mhxj08RDH8GCRS6IgRTgDKA8MbWXL
         tTYrDI/CscfUeDm+wSrgWGQWackf44OZvFjbJKcFjugROaKp+cRPSaOkZW1EVjED5MNv
         iFPxOx4xpdETK7zVuIZiacPjSEOadWHaGJJ0D/N6lldcLQj8In8wbEAn9wfBU2Ews2Az
         O4nR+Lric38hY7TH0EeM2Y+8mmkw+mzqPBh0EznyfOdBYlz4FiJJ0k1UEG+wb2mTuxyL
         ckoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703509062; x=1704113862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2836GHVSMxD4pEMsvcSkpc9zsaMTJx5V60Hbz6IE2rg=;
        b=hAkdfsqYjGBED0xlmoTDalnsQBgRVkx2Tk+3Y3bTAHpxajQd2vtM05tCEmPV32mIVZ
         l+D9VGNNUEsz0kS74BQUtZlV5Y4//szlYMNtjHcTwmgqXfechfCeaEXu7DqcMaCXZNsC
         KWVeNu2RLF2RZRpA9Tjj7q+E+r7qM6m1h8qeH37FnQgF/MHO+SWNrUMnu/5+I3ENQPgQ
         RtXmkMLvWjsX/l72E/2Wg2SY3iL11G86dmqiJt6nRbz1WRvHomp0bQVxdejK+WsON6Jz
         Hl7553SdDJiLHFhuomc9XYga0cfNnjqDqMJtzEqb2BP/M8BDAvjKVxUGvGnlXhNDyRhK
         UK9w==
X-Gm-Message-State: AOJu0YzrDcusdU2SQ9cB3ATpP9fKYdqfqm+LgwnvtiS74EqQZipJdOGw
	9tpN+nEEVbva1IZsHG8QaB4JDSAuina80Q==
X-Google-Smtp-Source: AGHT+IF3g630AIr81g9cNDvz+AQCLGz/tKDwXjpQ2ROuD4l4fkq1lJln5pzdYNbmrAaSn/LXm9rvfw==
X-Received: by 2002:a17:906:3406:b0:a23:55c6:8f23 with SMTP id c6-20020a170906340600b00a2355c68f23mr2401184ejb.129.1703509061911;
        Mon, 25 Dec 2023 04:57:41 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge24-20020a170907909800b00a1c7b20e9e6sm4808930ejb.32.2023.12.25.04.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 04:57:41 -0800 (PST)
Message-ID: <49525adf-1540-4801-8cdf-be1c0fe640f6@linaro.org>
Date: Mon, 25 Dec 2023 13:57:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add pressure-triplet
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-3-petre.rodan@subdimension.ro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231224143500.10940-3-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/12/2023 15:34, Petre Rodan wrote:
> Change order of properties in order for the end user to de-prioritize
> pmin-pascal and pmax-pascal which are superseded by pressure-triplet.
> 
> Add pressure-triplet property which automatically initializes
> pmin-pascal and pmax-pascal inside the driver
> 
> Rework honeywell,pmXX-pascal requirements based on feedback from
> Jonathan and Conor.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 64 ++++++++++++++-----
>  1 file changed, 47 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> index 84ced4e5a7da..e4021306d187 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> @@ -19,14 +19,17 @@ description: |
>    calls them "mpr series". All of them have the identical programming model and
>    differ in the pressure range, unit and transfer function.
> 
> -  To support different models one need to specify the pressure range as well as
> -  the transfer function. Pressure range needs to be converted from its unit to
> +  To support different models one need to specify its pressure triplet as well
> +  as the transfer function.
> +
> +  For custom models the pressure values can alternatively be specified manually.
> +  The minimal range value stands for the minimum pressure and the maximum value
> +  also for the maximum pressure with linear relation inside the range.
> +  Pressure range needs to be converted from the datasheet specified unit to
>    pascal.
> 
>    The transfer function defines the ranges of numerical values delivered by the
> -  sensor. The minimal range value stands for the minimum pressure and the
> -  maximum value also for the maximum pressure with linear relation inside the
> -  range.
> +  sensor.
> 
>    Specifications about the devices can be found at:
>      https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
> @@ -54,14 +57,6 @@ properties:
>        If not present the device is not reset during the probe.
>      maxItems: 1
> 
> -  honeywell,pmin-pascal:
> -    description:
> -      Minimum pressure value the sensor can measure in pascal.
> -
> -  honeywell,pmax-pascal:
> -    description:
> -      Maximum pressure value the sensor can measure in pascal.
> -
>    honeywell,transfer-function:
>      description: |
>        Transfer function which defines the range of valid values delivered by the
> @@ -72,17 +67,52 @@ properties:
>      enum: [1, 2, 3]
>      $ref: /schemas/types.yaml#/definitions/uint32
> 
> +  honeywell,pressure-triplet:

Why not putting it just before existing properties?

> +    description: |
> +      Case-sensitive five character string that defines pressure range, unit
> +      and type as part of the device nomenclature. In the unlikely case of a
> +      custom chip, unset and provide pmin-pascal and pmax-pascal instead.
> +    enum: [0001BA, 01.6BA, 02.5BA, 0060MG, 0100MG, 0160MG, 0250MG, 0400MG,
> +           0600MG, 0001BG, 01.6BG, 02.5BG, 0100KA, 0160KA, 0250KA, 0006KG,
> +           0010KG, 0016KG, 0025KG, 0040KG, 0060KG, 0100KG, 0160KG, 0250KG,
> +           0015PA, 0025PA, 0030PA, 0001PG, 0005PG, 0015PG, 0030PG, 0300YG]
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  honeywell,pmin-pascal:
> +    description:
> +      Minimum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is not set.

The last sentence is redundant - schema should enforce that.

> +
> +  honeywell,pmax-pascal:
> +    description:
> +      Maximum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,pressure-triplet is not set.
> +
>    vdd-supply:
>      description: provide VDD power to the sensor.
> 
>  required:
>    - compatible
>    - reg
> -  - honeywell,pmin-pascal
> -  - honeywell,pmax-pascal
>    - honeywell,transfer-function
>    - vdd-supply
> 
> +oneOf:
> +  - required:
> +      - honeywell,pmin-pascal
> +      - honeywell,pmax-pascal
> +  - required:
> +      - honeywell,pressure-triplet
> +
> +allOf:
> +  - if:
> +      required:
> +        - honeywell,pressure-triplet
> +    then:
> +      properties:
> +        honeywell,pmin-pascal: false
> +        honeywell,pmax-pascal: false

This allOf is not needed.

Best regards,
Krzysztof


