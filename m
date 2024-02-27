Return-Path: <linux-kernel+bounces-83156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB56868F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D811F2746D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81713A24C;
	Tue, 27 Feb 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQP+/cX7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F213A248
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035432; cv=none; b=nrBYBBsIqB1izEHO9NFVLL2AXts+Jtwce4vGgPtbnmcul0d+jOUwuToGVqmnqn5ucW0N3GrkLsbnLe02uqYM+S/ngNUXGVkdBW4S5/KqVW8S1mwTs9ICPDvvmxEYj11v6LauCwnL7+dLzm5w5BxQKmacO9h9dTaiwRcWw/wwyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035432; c=relaxed/simple;
	bh=Yp+DznaXdlwI6W6RpjWPkz4h3qaiymB8dpf7qdz03hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wb3nZw6fUJpXfD8CYErXo1MYFZdr5FKXeTkwW4i1AzRRHtaF4nFH6W1l7IyUmkiJ+RopvneWXiUXxafx4nhAvjFBS9DJSOlPJpslHC4B7PYAUt7y3ym6GtM40qKrVDuflA8UdtdwfRKU15y1xqYcUwY7XrtHJEaVl5NXPcS4mJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQP+/cX7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso510643266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709035428; x=1709640228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SdmhYqWKJvgYRzDJb5z1/6ZepC6GiDis6EIU13NeeC8=;
        b=NQP+/cX7xO9+0aMz49n6xqeBhOoW5KCWY+feLK95mltZkwNayFPjIJSRssfT8Ni9fm
         pJEReWOfgEhToYFrN7xStzjVOctyb825B8wHkV+o2nncIowesUhgHeDifkJzav/IE2HC
         0Q3Q+lbuINKprGUwilwir2As4l7clsI/wmtqqLTzCZYDop5yK1mBbHI4VM0ZcgvK3N3O
         5pfEDhJihZ3vRJwXY5NqQTv9qmPxDYuZZ+uJx84+mYtSE1HFFhpfgvwZuj8x5zCjrCWE
         vX+OqzxgjMmj9qSX5sgsHPvaDpnD27HEw1c80ljAyYt51DTNgJpk9y91MEX74xFKEsPd
         8DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709035428; x=1709640228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdmhYqWKJvgYRzDJb5z1/6ZepC6GiDis6EIU13NeeC8=;
        b=bpks7neDdWh8KrYYbEmHNRXUagIjaW6E8uR3d/Gr9j7dO4Ib4ERrZPjtDOrku1WVre
         ukBSihv0NWZLJhh0xpUZaRVNqQTVoJsVqh4Hxo3+DNcYv2+7gv6Bdrf7dz2Etf59+0MY
         ENdf5yG0l4p7R9sEAqSGmZ7Wi+OvixSEba5oSFb73+vxZ/7CPPxsyge7W62N02vvREMy
         6mEBywe7RGvKKMKP3IbNGG93tl7pSfUXyHA8ghE97iY14og3NDDOXn61jVDiY2WOOP8/
         QdR8PGkVTdCbPQ7tPjGz9SMAyJLnCwAUEx8CZ185ooXV/KBe9PWigZU6AfBp8QOrrlNy
         ZD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZZYMp0JDPrv2QH78I1r/eINnYE6ZYxxEjVYXHHeP65d3eBMLjT8FN8GwmpnxSi0Oh6acMY6yKiuWdRlstXHOPORzKh1I5RXz8ELdB
X-Gm-Message-State: AOJu0YzcRyZ0y9SZy+3ZGjr9X2ezosK1LEEXiQf7NSm8rIrYnJZHJ7DL
	zuwQRBeCMPtXpvoRyU7K6fLrqVkRL3SERdQ+v+pAmvMPxoy8d2JT0zk73E83hEE=
X-Google-Smtp-Source: AGHT+IHsAtRJ6+bGsc1WsZ/Dus5JfQO95zUKK+7AjiXj2FSedFW0f49lj8ER4VKxV0UAWiU2YRL71A==
X-Received: by 2002:a17:906:3c05:b0:a3f:db30:8999 with SMTP id h5-20020a1709063c0500b00a3fdb308999mr7352750ejg.4.1709035428441;
        Tue, 27 Feb 2024 04:03:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709063b0a00b00a412d3d509fsm697669ejf.181.2024.02.27.04.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:03:47 -0800 (PST)
Message-ID: <796652d5-af57-4aca-87c2-10a7b0b55959@linaro.org>
Date: Tue, 27 Feb 2024 13:03:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: atmel,lcdc: convert to dtschema
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2024 10:14, Dharma Balasubiramani wrote:
> Convert the atmel,lcdc bindings to DT schema.
> Changes during conversion: add missing clocks and clock-names properties.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../devicetree/bindings/display/atmel,lcdc.txt     |  87 --------------
>  .../devicetree/bindings/display/atmel,lcdc.yaml    | 133 +++++++++++++++++++++
>  2 files changed, 133 insertions(+), 87 deletions(-)

You have several patch errors... check your git repo (git show). You
will easily spot them. Or just use decent text editor to clean it up.
Run checkpatch...

..

> diff --git a/Documentation/devicetree/bindings/display/atmel,lcdc.yaml b/Documentation/devicetree/bindings/display/atmel,lcdc.yaml
> new file mode 100644
> index 000000000000..4a1de5a8d64b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/atmel,lcdc.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/atmel,lcdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip's LCDC Framebuffer
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Dharma Balasubiramani <dharma.b@microchip.com>
> +
> +description:
> +  The LCDC works with a framebuffer, which is a section of memory that contains
> +  a complete frame of data representing pixel values for the display. The LCDC
> +  reads the pixel data from the framebuffer and sends it to the LCD panel to
> +  render the image.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9261-lcdc 
> +      - atmel,at91sam9263-lcdc
> +      - atmel,at91sam9g10-lcdc
> +      - atmel,at91sam9g45-lcdc
> +      - atmel,at91sam9g45es-lcdc
> +      - atmel,at91sam9rl-lcdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks: 
> +    maxItems: 2
> + 
> +  clock-names:
> +    items:
> +      - const: hclk
> +      - const: lcdc_clk
> +
> +  display:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle pointing to the display node.

Phandle does not have properties. Didn't you want object?

This cannot work - just test it. Change the properties in the example,
remove or add something. Do you see errors? No, because it does not work
at all.

I don't know what's this exactly, but if embedded display then maybe
could be part of this device node. If some other display, then maybe you
need another schema, with compatible? But first I would check how others
are doing this.


> +
> +    properties:
> +      atmel,dmacon:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: dma controller configuration
> +
> +      atmel,lcdcon2:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: lcd controller configuration
> +
> +      atmel,guard-time:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: lcd guard time (Delay in frame periods)
> +
> +      bits-per-pixel:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: lcd panel bit-depth.
> +
> +      atmel,lcdcon-backlight: 
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: enable backlight
> +
> +      atmel,lcdcon-backlight-inverted:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: invert backlight PWM polarity
> +
> +      atmel,lcd-wiring-mode:
> +        $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +        description: lcd wiring mode "RGB" or "BRG"
> +
> +      atmel,power-control-gpio:
> +        description: gpio to power on or off the LCD (as many as needed)
> +
> +    required:
> +      - atmel,dmacon
> +      - atmel,lcdcon2
> +      - atmel,guard-time
> +      - bits-per-pixel 
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - display
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    fb@500000 {
> +      compatible = "atmel,at91sam9g45-lcdc";
> +      reg = <0x00500000 0x1000>;
> +      interrupts = <23 3 0>;

Aren't here some standard interrupt flags?

> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_fb>;
> +      clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_PERIPHERAL 23>;
> +      clock-names = "hclk", "lcdc_clk";
> +      display = <&display0>;
> +    };
> +


Best regards,
Krzysztof


