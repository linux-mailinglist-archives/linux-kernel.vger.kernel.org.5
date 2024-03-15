Return-Path: <linux-kernel+bounces-104870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A90B87D4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8037FB21DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAB54794;
	Fri, 15 Mar 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csC7Ok7/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E553393
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533361; cv=none; b=CKBg6DDPC/DEgXVxM9uLW29iVmsksKPof59Lu+vleH0kDarmENFQynEgpvCWPBoRlOzQq68LCtx5K+xNOVwCdSWR6SxHZr0ScgseBXJIAlAj6BsVxcEaNM+w33556qqCETTWFkECHLneRPlkh2cEGUYUR4PGxdcVcSVrQiIxeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533361; c=relaxed/simple;
	bh=jxzupQBcicL+hUlKgTkEqRcEgtyGe1JHystKUVcXmHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D37+1UgEInQZ9GRSpvvBeG+3qRuYx8M9PfPOhXk/Q8My8Qwew5jvPq/juvuBoOnIxZKR3bzreu+0LZL47aNMS3+xfL59aBoqt2KCx6t6KmH7GNwCebLaJzasvwxum7mEWG//O9P0Rsz4HvQmsE0XVo55cL4Rwh7Qsx8QmD4xR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=csC7Ok7/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413e93b0f54so16782825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710533355; x=1711138155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p2tW+rY8sSK0emp7CuqgUfSaOYzKGKVj9pNbDTza020=;
        b=csC7Ok7/birJ1yIZwy2ggYDNdxcZPtAuvImnFoebdUxPiO0lC6a7sOLcBjOs+UyggD
         SaYHf1H77rqdTH8Flc79ug7fOurEKbu5GKiGTUhc3WsBHnEth14uJlTz9wES0nzSdciN
         siqI271lkYngQdaYwS4OLnhYKFKjwH1E5sr+sUD5H93TZuywyNrZGqS6sqpAJHXyHe9L
         zHhbwyBocN39araSfGHvSQjEyO/KGed0SdBCUxi9hpQD8Jy2IE6h1Qf0JrtTkbDOY6RK
         6BvKuXqRqMNYjvr/DetasTIOWuRgzhGlAcg2PGRRU5zFv5MD0+ylfQUOBbs38TVSmVY/
         ftVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533355; x=1711138155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2tW+rY8sSK0emp7CuqgUfSaOYzKGKVj9pNbDTza020=;
        b=tpEI7gL+VkR1E9AZqD0A6Xcx108w1pp+KuH54X2s9UCoUyW0mCz1ZoDq/jun9tuSJv
         kQMvlNrWxTGM76EmxoQLKgZafZurev/HlE5r/Q2h1pp8cA/hAqtq579JSb1HyfscDunQ
         aY0PUXKcIrTRwgfstQcr2Tnjj7p0VU5xbU2RlaNEG7srTJkI2ILBz4BAQxqtji8+EWcH
         2eksymQ+E+bw6haVdeCPDD+NhO2Pje1fUrf0yzRczKv8GKdidJ3kAff36Pipavlsl9L7
         SROJwn/jZ2QTuY9R61MiFe5rE6U45ya26w9XWsmpHHWAsCWu9EAUJS34kHzo6YU5GuTH
         7lng==
X-Forwarded-Encrypted: i=1; AJvYcCW0kqMSybsr6WI5+LIwR9IpCC9VBdX3NqY1FWDp9CQrDyTVXwBEbt9Q6YYo677OKO5t5HXj2j0WAd2dwGDBQmvx80BVYUkYoa0KDlGF
X-Gm-Message-State: AOJu0YytetK/Ab1OU8kR97yNYiVd2p8jF5kyxxpYqIpzq5cEFUMjdBG9
	kaHdD1m1gsuByrWE18JEp9h04Plnxmp54JLV18eK6lVVJkpO9s3N7LiXEkg3ko8=
X-Google-Smtp-Source: AGHT+IHNU6xsuhBnJ0s1fL63Xc5fU3svS7s3WxpF6m/TPO0LRH3pZToY1ZFsQdLIl3X4NwKYXWSfWw==
X-Received: by 2002:a05:600c:1c08:b0:413:fe9d:eaa5 with SMTP id j8-20020a05600c1c0800b00413fe9deaa5mr2654001wms.26.1710533354623;
        Fri, 15 Mar 2024 13:09:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b00413ef6826desm6785579wmq.4.2024.03.15.13.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:09:14 -0700 (PDT)
Message-ID: <314a88e0-19cd-4b95-9cf3-aef1c7579eec@linaro.org>
Date: Fri, 15 Mar 2024 21:09:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-2-ayushdevel1325@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240315184908.500352-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 19:48, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../bindings/misc/mikrobus-connector.yaml     | 110 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> new file mode 100644
> index 000000000000..6eace2c0dddc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml

Please put it in connector directory.

> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/mikrobus-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board socket
> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector

Hm, why do you create binding for the connector, not for some sort of
controller? Please provide some rationale for this in commit msg.

> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +  pinctrl-2: true
> +  pinctrl-3: true
> +  pinctrl-4: true
> +  pinctrl-5: true
> +  pinctrl-6: true
> +  pinctrl-7: true
> +  pinctrl-8: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: pwm_default
> +      - const: pwm_gpio
> +      - const: uart_default
> +      - const: uart_gpio
> +      - const: i2c_default
> +      - const: i2c_gpio
> +      - const: spi_default
> +      - const: spi_gpio

I fail to see why such choice is related to the connector itself.
Connector could have just SPI attached, so why all other entries needs
to be provided? Or is it fully plugable? But then really please explain
the hardware in the binding description.

> +
> +  mikrobus-gpios:
> +    minItems: 11
> +    maxItems: 12
> +
> +  i2c-adapter:
> +    description: i2c adapter attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  spi-controller:
> +    description: spi bus number of the spi-master attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  uart:
> +    description: uart port attached to the mikrobus socket
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pwms:
> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
> +    maxItems: 1
> +
> +  spi-cs:
> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: chip select corresponding to CS pin
> +      - description: chip select corresponding to RST pin

I don't understand why do you need all these properties. First, if this
is connector then I would rather see some sort of graph, not phandles.
Why would connector need to do anything with SPI controller?

All this looks like made for software. For the driver.

> +
> +required:
> +  - compatible
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-2
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - i2c-adapter
> +  - spi-controller
> +  - spi-cs
> +  - uart
> +  - pwms
> +  - mikrobus-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      mikrobus-0 {

mikrobus {

and fix the indentation. Use 4 spaces for example indentation.

> +        compatible = "mikrobus-connector";
> +        status = "okay";

Drop.

> +        pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
> +                        "i2c_gpio", "spi_default", "spi_gpio";
> +        pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
> +        pinctrl-1 = <&P2_01_pwm_pin>;
> +        pinctrl-2 = <&P2_01_gpio_pin>;
> +        pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
> +        pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
> +        pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
> +        pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
> +        pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
> +        pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
> +        i2c-adapter = <&i2c1>;
> +        spi-controller = <&spi1>;
> +        spi-cs = <0 1>;
> +        uart = <&uart1>;
> +        pwms = <&ehrpwm1 0 500000 0>;
> +        mikrobus-gpios = <&gpio1 18 0> , <&gpio0 23 0>, <&gpio0 30 0> , <&gpio0 31 0>, <&gpio0 15 0>,
> +                         <&gpio0 14 0>, <&gpio0 4 0> , <&gpio0 3 0>, <&gpio0 2 0>, <&gpio0 5 0>,
> +                         <&gpio2 25 0>, <&gpio2 3 0>;

Use proper defines for GPIO flags.



Best regards,
Krzysztof


