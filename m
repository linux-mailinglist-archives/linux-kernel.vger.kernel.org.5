Return-Path: <linux-kernel+bounces-143990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877448A4079
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E198AB21463
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468681C2AD;
	Sun, 14 Apr 2024 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVPr+EYU"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8960171A4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713074622; cv=none; b=pSq0HoIlAdr95soU+e0qzYD2IpD7+q9mxWazAMYGOr2cEgs6Ar7lL0P9lyOone5fOzG3VQpdYWfUDIfFKPS/sS2uhsNeEHVhXpzOXJpmgqGL5DNSyMgzMJQ3e0rnXuO0898V9624UDaTmWrlLfqRJ/KvEekio53uDRp/e45gluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713074622; c=relaxed/simple;
	bh=63FZTmyc1t7y7aVYwheuDBz8DDayrp+mjwiukQLuVv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBuvD9Dg5j6/GHLzzLFp13CSEX942Mh/VtNzD3ZXIh7Wwomuh3ikgZVWUnqhjUkgylC0oyvi8+u2iv6WOfq/u3DBOfxWFyFE8tTBRcc/Rp2dMSoA6oBXGP3XT1uQ7wNBu9xOZctjq5bGMiigb85TirVg5ZfcHh2FGt3z2xJCuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVPr+EYU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso304917666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713074619; x=1713679419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EzRBRhOqf4kIlrFDlNYOpKwdTyggV73pXH8/XozFkxw=;
        b=SVPr+EYUx++2x9QI8Zw3MzGK2h7t+prJ1i9im4TzrSjogi3YldIo4Mno/xKPiFyF/4
         hyw0np1elXYFbOldGyftoAlvM2LCAzu9TfUqPcJLN3flP/IMju1Z0HGCt/R9zLeA6zF2
         f5wmbhDysFjMYseXf3H2naLflsk1K6VzJyhFR7KCKIcfqZojUWBQhk+WEffOT7waFy/K
         ZgUIaokbAwjd3Bvf82aB7uM7qL/jY72xvkiJE8R3e4edcN+XLKxgN6gKkAUITv7+1oX/
         ulPiwZA4PqzB3bn74WtJ705fu7rOcwMG1s+rKi1rGi5norjKuE9nncL9u7ryR783OXiA
         Q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713074619; x=1713679419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzRBRhOqf4kIlrFDlNYOpKwdTyggV73pXH8/XozFkxw=;
        b=rhIjUhsEqAbiPSFhox5OkTTxoYCNp36s778JqFIMEpOTGGXJbUKayhy6cU2XZDastU
         anhTfe+Jh5V/na5EOKJBHBrR9nPqOj+2MfxMloWv9UeKcb9+60gOVji6gqCkIh/XN22I
         xeQMTDYaRwBdCYHOzZC1jNDUX2zQSZwfBmAJPOK/Y/G3SOfVzFe46iuHWJDBTnahyUQt
         Ng04PN2Hq171CevXv7gOvyLWbBZ06ArVa675ABVJfhTiCN5ilUp4PXKHxhat2cNa6zW9
         XAhBCuCmyJPMGDNzxydWqDqTeJNUcKvXenfOwlJRUHs+xnRSmMf3HmAVbCG0UgTPy7Ms
         FY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj2ot2uS91Eg0ZD/k22NNzyls2vRU8bRvrQWdeMUNl1wGUo2EX03uQV5ZLYoUqcqlywbU9uDDzww1fbctiC3zVqa6SrMKyb8ovLUuO
X-Gm-Message-State: AOJu0Yxec3uA+/myNES02lO90ux617veniQyifwy4iFCi0YVncdGeNmT
	IB1yTjv+56v6wDuVigXgw0pJwJWhgvOmWUcwtKBzQ0S74Gm1e53d+C8g3X52e2c=
X-Google-Smtp-Source: AGHT+IE9pJPztO++w43GBK/fGkowBlOVisNlxu05dHH6j2Yu2g++EIl0a7o+lsEukNsO+yxFcE7biw==
X-Received: by 2002:a17:907:720c:b0:a52:5798:971c with SMTP id dr12-20020a170907720c00b00a525798971cmr1039294ejc.8.1713074618228;
        Sat, 13 Apr 2024 23:03:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jw10-20020a170906e94a00b00a523be5897bsm2448748ejb.103.2024.04.13.23.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 23:03:37 -0700 (PDT)
Message-ID: <80effcab-74b8-4e15-a4db-9982b000b6b1@linaro.org>
Date: Sun, 14 Apr 2024 08:03:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: Add maxim max31790 bindings
To: Chanh Nguyen <chanh@os.amperecomputing.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-2-chanh@os.amperecomputing.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240414042246.8681-2-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 06:22, Chanh Nguyen wrote:
> Add a device tree bindings for max31790 device.
> 

Nothing improved in commit msg, where is the rationale of split of bindings?

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Changes in v2:
>  - Update filename of the maxim,max31790.yaml                            [Krzysztof]
>  - Add the common fan schema to $ref                                     [Krzysztof]
>  - Update the node name to "fan-controller" in maxim,max31790.yaml       [Krzysztof]
>  - Drop "driver" in commit title                                         [Krzysztof]
> ---
>  .../bindings/hwmon/maxim,max31790.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> new file mode 100644
> index 000000000000..a561e5a3e9e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The Maxim MAX31790 Fan Controller
> +
> +maintainers:
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: >
> +  The MAX31790 controls the speeds of up to six fans using six
> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
> +  are written through the I2C interface.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max31790
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: fan-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      fan-controller@20 {
> +        compatible = "maxim,max31790";
> +        reg = <0x20>;

Make the example complete - add all properties, like clocks, resets and
any others which are applicable.

Best regards,
Krzysztof


