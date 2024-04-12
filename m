Return-Path: <linux-kernel+bounces-141998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8D8A25F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF55B24215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A01C29F;
	Fri, 12 Apr 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IioVJYwU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E671BC53
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901024; cv=none; b=MTt8Kk3Qm43TL7aBW+huVdSOc+gJ446rVjdcdxdsFcPz+mV8JZ7aRaPYNJWtsSKlZ+4lSNe1GFXs2PKybBBImf/LTHe60ck9Z8+fpgMTpFWYHXypzl3h1jekdD+NmkimSoicL804vPcbJ4Q0dXx253HBmU/uYqljqiom/9ag6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901024; c=relaxed/simple;
	bh=u2fBRb2MppOqSy4keS9S2tRusxCbNGSH9M8O8szneiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tio1853I6ufWnDaFm/RfbLddHZY5DnbhfOhpiNGIa4Ks/OIiuhJ9nPsaZ6wY1ImKC6bJMlUacIXTaSDRB8wW6ixLH5hX7a0oEL/+sS1uwMwNWrC0wr3gY9mXjnJSbwL1DbLNEj0jO9bgtrBJewT9YPI1P6rXFmo3JFzCtl7MSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IioVJYwU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e32b439c5so168970a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712901019; x=1713505819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OR54SlsdcNnu/qmb8DNsogrMX6VvD/PSPML5TmmcnNY=;
        b=IioVJYwUmEctAaZbZLM2F1Jy2fms9ltTCoL1eqb2B8ERrFOjCSV9UL5ReF4IK+zgZJ
         vmdefpCJF9TRHERXLYhYsukvN1rwOUnDAS6NaBeIaP+nPF42Yx9el3cK9cZ46h/tLcjI
         bRYWr6xK5X94RTSFGG91BGditnxv8VtnvM5Bi7wT3qMz4Y0UF5qzbdy/cWQLLOIOTr37
         1mY0FcgxowsSCeRahsWet7jTZeAj87Y9t9qSwSbao7AKtpF2BurZgQcg4jPDXkSKIHwG
         4H68zvtfvXWmKAl4QBTPYXKalNYeQODyaw5efAwFEhvs6TuAQS8FJUL1RtrwXcPWs2DZ
         Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901019; x=1713505819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR54SlsdcNnu/qmb8DNsogrMX6VvD/PSPML5TmmcnNY=;
        b=VcgWo8to5DjqFHzumCkcvWwv2m6HJ7wT2pTuqoYpjaPxrce6UomoPKgoJtr8800ngk
         NcmeldKAH0hx+t1m2ZiubmBVAW8w9CjHqTscby0MWnuQFvN5MKJRTqwWHKJg3qmCEr+J
         5t/m/E+GU0l4o/xBTmdgH6FlHWkyoSRG5OilEojQh1z+QNlORNKlCzoNqhuErE1+VH4j
         4wR5WALmzcVeG88/syOFeKIF+u056E5ZqX1Wu9fEhAgj2UXYUi1sZWlp5Bu4BGxn0Oj+
         tf86EB5cKX+uNEl8+MCUXcW5Iy/h1fipGdYiZcd2Je18iiilIKgUY8MANyF/0EOqmvrg
         ZXdg==
X-Forwarded-Encrypted: i=1; AJvYcCWt4B4ljDYFMTt2ud5R0yzN6Touf8ECS4OuLheOgStgaWnXSylzhHrG4sUuuNoN7X0wDGRatpFEZpuwc6kocWNyQXSQvIPp2yXfxdDq
X-Gm-Message-State: AOJu0YxO3yrPxNKjOU/CCbUZiekKMfq4gVKODH70fccHIOmdt3tuhi/C
	tl5xROZ5PvJospT3lvXSsS0EVe+O6Q4k7F/DaxR8wk9Dn0e4DSjIdcO8KHLFPPs=
X-Google-Smtp-Source: AGHT+IExi1jAUfeOXVkPYiwJYVCGENvkywJmwiCyKsAm0POBLtZ9B23nXH8iJT1aVrHInVp4KbRWJg==
X-Received: by 2002:a50:cc94:0:b0:56e:2d93:3f7f with SMTP id q20-20020a50cc94000000b0056e2d933f7fmr1391584edi.39.1712901019445;
        Thu, 11 Apr 2024 22:50:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7c6cb000000b0056e7ba0497dsm1325309eds.28.2024.04.11.22.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 22:50:18 -0700 (PDT)
Message-ID: <34de2d9b-c62e-4f18-806c-560ba4474237@linaro.org>
Date: Fri, 12 Apr 2024 07:50:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: Add adi,ltc2664.yaml
To: Kim Seer Paller <kimseer.paller@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
 <20240412032102.136071-2-kimseer.paller@analog.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240412032102.136071-2-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/04/2024 05:20, Kim Seer Paller wrote:
> Add documentation for ltc2664 and ltc2672.
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2664.yaml         | 230 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> new file mode 100644
> index 000000000..2f581a9e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> @@ -0,0 +1,230 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2664 and LTC2672 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2664.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> +
> +$defs:
> +  toggle-operation:
> +    type: object
> +    description: Toggle mode channel setting.
> +
> +    properties:
> +      reg:
> +        description: Channel number.
> +        minimum: 0
> +        maximum: 4
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation enables
> +          fast switching of a DAC output between two different DAC codes without
> +          any SPI transaction.
> +        type: boolean
> +
> +patternProperties:
> +  "^channel@[0-4]$":
> +    type: object

patternProps go after properties.  You miss additionalProperties: false
and actual properties defined in top-level part of the binding.

I wouldn't call your schema easiest to read. You have two quite
different devices.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2664
> +      - adi,ltc2672
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000

Missing definition of this property, so ref to spi-peripheral-props.
Look at other bindings having this property.

> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +
> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  vref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-scale
> +      range of all channels. If not provided the internal reference is used and
> +      also provided on the VREF pin.
> +
> +  clr-gpios:
> +    description:
> +      If specified, it will be asserted during driver probe. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.

First sentence tells nothing about hardware. Do not describe driver
behavior, but hardware.

Second sentence is 90% redundant - just say, when describing the
hardware, that the line for foo bar is active low.


> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ltc2664
> +    then:
> +      properties:
> +        adi,manual-span-operation-config:
> +          description:
> +            This property must mimic the MSPAN pin configurations.
> +            By tying the MSPAN pins (MSP2, MSP1 and MSP0) to GND
> +            and/or VCC, any output range can be hardware-configured
> +            with different mid-scale or zero-scale reset options.
> +            The hardware configuration is latched during power on reset
> +            for proper operation.
> +              0 - MPS2=GND, MPS1=GND, MSP0=GND
> +              1 - MPS2=GND, MPS1=GND, MSP0=VCC
> +              2 - MPS2=GND, MPS1=VCC, MSP0=GND
> +              3 - MPS2=GND, MPS1=VCC, MSP0=VCC
> +              4 - MPS2=VCC, MPS1=GND, MSP0=GND
> +              5 - MPS2=VCC, MPS1=GND, MSP0=VCC
> +              6 - MPS2=VCC, MPS1=VCC, MSP0=GND
> +              7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (enables SoftSpan feature)
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +          default: 7
> +
> +      patternProperties:
> +        "^channel@([0-3])$":

and the channel@4 is? You allow anything.

> +          $ref: '#/$defs/toggle-operation'
> +          unevaluatedProperties: false
> +
> +          description: Channel in toggle functionality.
> +
> +          properties:
> +            adi,output-range-microvolt:
> +              description: Specify the channel output full scale range.
> +              oneOf:
> +                - items:
> +                    - const: 0
> +                    - enum: [5000000, 10000000]
> +                - items:
> +                    - const: -5000000
> +                    - const: 5000000
> +                - items:
> +                    - const: -10000000
> +                    - const: 10000000
> +                - items:
> +                    - const: -2500000
> +                    - const: 2500000
> +
> +          required:
> +            - adi,output-range-microvolt
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ltc2672
> +    then:
> +      properties:
> +        adi,rfsadj-ohms:
> +          description: If FSADJ is tied to VCC, an internal RFSADJ (20 kΩ) is
> +            selected, which results in nominal output ranges. When an external
> +            resistor of 19 kΩ to 41 kΩ can be used instead by connecting the
> +            resistor between FSADJ and GND it controls the scaling of the
> +            ranges, and the internal resistor is automatically disconnected.
> +          minimum: 19000
> +          maximum: 41000
> +          default: 20000
> +
> +      patternProperties:
> +        "^channel@([0-4])$":
> +          $ref: '#/$defs/toggle-operation'
> +          unevaluatedProperties: false
> +
> +          description: Configuration properties for a channel in toggle mode
> +
> +          properties:
> +            adi,output-range-microamp:
> +              description: Specify the channel output full scale range.
> +              $ref: /schemas/types.yaml#/definitions/uint32
> +              enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
> +                     200000000, 300000000]
> +
> +          required:
> +            - adi,output-range-microamp
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - vcc-supply
> +  - iovcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +          #address-cells = <1>;

Use 4 spaces for example indentation.



Best regards,
Krzysztof


