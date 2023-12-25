Return-Path: <linux-kernel+bounces-11051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2EC81E0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472861F221C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0830D52F6D;
	Mon, 25 Dec 2023 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3T0kla1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAC54BF7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a265d4f78bfso315698366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 04:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703509185; x=1704113985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeUEoBjZhkWglQxeiv+2JgdHv+3Vm0351/gVSMlaOzI=;
        b=E3T0kla1B+iYMOBPzZ1DzD3TyC0B+FueKiIMZaFBoE8luHTNKNd5toebS1HjuREmg9
         tdo7mo8LPQ4AtHnVKbaf7aL8artwO4Qz2//Nf34m10mYUpVcNcKS63XErMCw/TkavQa8
         ULYW5/jLOl4yQHoAjz1bUU8Nbp0lp+EsEGifZW08KtEqRbN3Rwq31Aq149VyvYCQHZL6
         XSOou+TrjprR2NE9uUqs0peqhV+DtLZid4JG70MBaBUI4F8cPLpo8WbEUxHPysqReEZ9
         GeBGue4paKAK6Kg8I0dTXz1UHwgrOjaF1u6GJPozGnsEhwCd2neIVBy2SGWY7L/RXDyi
         g6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703509185; x=1704113985;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeUEoBjZhkWglQxeiv+2JgdHv+3Vm0351/gVSMlaOzI=;
        b=BQou7JmXwxoIWCUnIZA6m1HYbw1yOBzTN6hIcb0pJNczspVlwxm/Chd2GYr8zQUjQ7
         /yD2KlZgqlakCPt3GHUwPm5PdMTS4dFfpP7wQAn0wJZH1l1LJ6Tj12Ip0KaP802A5HRK
         GU5swvJ/LMlPViAlyFnJZEuqBX3AZHSZcX1qtCu46QuGf/k3rrha+bjV3SiXR840RUA3
         78jS+4eiu94d8sm3ZpMzrcJ/pfWFhBKMJths34ubMb3X6sJ7pOiSGspp5zpNwaRp6Z/7
         7r9dty2OJAltA8zRuxVa/9kdwa4peJBmNsRPVg+3XBnqRe4MbEO5Fwad8n9nyDGOya8l
         z42Q==
X-Gm-Message-State: AOJu0Yw7GYRkejBL+OfnVdTcbvPJr5qcnJfn6WlFLVIobU385D+zy0vy
	iYVoZZWL8numornJBjCICF3WhmacmaXKcQ==
X-Google-Smtp-Source: AGHT+IH7VUB2PaYudISie6wl3QAKSHGxDXNG48RtsG2k+lVPmt0XkUD9mySP6AVKS8+YjLYdtzJMWQ==
X-Received: by 2002:a17:906:1009:b0:a23:5a00:326 with SMTP id 9-20020a170906100900b00a235a000326mr3019449ejm.0.1703509184905;
        Mon, 25 Dec 2023 04:59:44 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906305500b00a2699b0fd49sm4803610ejd.86.2023.12.25.04.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 04:59:44 -0800 (PST)
Message-ID: <b23a6b74-a568-4e11-8429-6344e10a9937@linaro.org>
Date: Mon, 25 Dec 2023 13:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add spi bus
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-4-petre.rodan@subdimension.ro>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231224143500.10940-4-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/12/2023 15:34, Petre Rodan wrote:
> Add spi based example.
> 
> Add spi-max-frequency property required by chip specifications.
> 
> Add additional maintainer.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> index e4021306d187..430496b047c7 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
> @@ -8,12 +8,12 @@ title: Honeywell mprls0025pa pressure sensor
> 
>  maintainers:
>    - Andreas Klinger <ak@it-klinger.de>
> +  - Petre Rodan <petre.rodan@subdimension.ro>
> 
>  description: |
>    Honeywell pressure sensor of model mprls0025pa.
> 
> -  This sensor has an I2C and SPI interface. Only the I2C interface is
> -  implemented.
> +  This sensor has an I2C and SPI interface. Both are supported.

Instead drop that sentence. Current driver support should not matter for
the bindings.

> 
>    There are many models with different pressure ranges available. The vendor
>    calls them "mpr series". All of them have the identical programming model and
> @@ -88,6 +88,9 @@ properties:
>        Maximum pressure value the sensor can measure in pascal.
>        To be specified only if honeywell,pressure-triplet is not set.
> 
> +  spi-max-frequency:
> +    maximum: 800000

So you miss allOf: with $ref to spi props.

Best regards,
Krzysztof


