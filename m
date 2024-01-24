Return-Path: <linux-kernel+bounces-36523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0883A254
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE26C284B91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309D14293;
	Wed, 24 Jan 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYD0KPFi"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F710795
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079130; cv=none; b=V14VKxAZYvhjFcVlfTZR+8t6NttGpZvUGoPFMUepkwJyIhQOIOAT/fEpK3vXJ2pC/jQjaxPltF2ObEFxwhZTxbkbgSDZZPsT915wQYcZ+pGcSNqxneqyiYn8I68mxFnhygXTwKrMX7rGK+BKKrYSPx/9eWkDv1P/MKf+CTgU9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079130; c=relaxed/simple;
	bh=fbcNgoaW5AtsCKiIRocGR0JJrdRpBvKO6oa2/KimtJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkafFfjDEUQ1SSgaXulLmLXdQ3a2jeBn54L/tSNPPgJxk9SN8+3UQvvUMYqYtu6mwr4k5k/Tw0+zfdvkJobVPkC7B4jX6F1SK8OrVme/y7gTR7WiplduhebzVtNqmas/3SE8lwdmv7QVnkNtXgZ9HKpvHnBmqOQqu5LlAy1eWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYD0KPFi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so31469295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706079126; x=1706683926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m74+99Y8P5Itfjfvbm1uPEhPEBJZOphBOYmIxYIstNg=;
        b=nYD0KPFiNsDWD7KXKuDtfBAus/MQdthkEEi8r8P2nKQp9n/cwdUpuC2F5ST3EoX46j
         +w8q1dC31tFUdEPl+P9cD1hsHPAOgsJi30olTYsNWWEJwjlXT3EA1tq36GH+d798CGxL
         7qVS4uvsFimjuZUPGQZPIsYeSBquiIik4vHXeye5KNLW8BjHIe1PVAzx7IWe08HZXmEy
         uQ4ccVVDDFMhc/9Qq3xIH+ETSaFK54a/EW0lgJwFhVrdCZMtLOIZPN6vOGa/g2met16+
         +N/YCy4msfHSY/eMbkqEcOLw7bzWbAh0G0StNLg9+F6VzFVn+Aa9Pbut4L1aem1L6BBP
         MoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079126; x=1706683926;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m74+99Y8P5Itfjfvbm1uPEhPEBJZOphBOYmIxYIstNg=;
        b=auhEe67p07myaVigiwwCfUXar9iviYTk3Uid2a7Ep0VtAw7yHRX/H73WCb1K0VDjDo
         bAoUkZ0/J8VCrD8fHn+n2OC73Li+3vyLL6Dk3U/CKyYryBdblnmi2msR1w40jpI70B5I
         hpCfQVThoYYXZvhM0N2LskbxlC2Ruc4T+u+5V2TO1DUgs6fbeJ/tnkC8mU098aluPLnF
         jRPdplejVvw2XuNM/hg/IJHTcvOmTktYPqqCpGzsLt7yM0CJ0crFvjqpjVSv73IS75Ao
         /uuGQIqQfEOBJV0NJJPYxyX2WpPo5EJRTHRcETyBUpAPYEbdqwUxKOaWe8VU/zc3do1P
         qmoQ==
X-Gm-Message-State: AOJu0Yx6sDYQ31M9uWbchi3iaYtEzGRPmG/PySKNiHLgZbJjiG4mnBPt
	EgXEBrvXJOsQfOpSQUKWvwplasMw05iRZB8jc+cv4A461B9xwi2nPC1/uS3fABw=
X-Google-Smtp-Source: AGHT+IGgxSNx8FSG6/K3KYYLM71szF15TB/tkGYteydN82qLiwRLAlf9mMXtbn5QmUYnnTfWgIRGkQ==
X-Received: by 2002:a05:600c:2d92:b0:40e:8cc2:7492 with SMTP id i18-20020a05600c2d9200b0040e8cc27492mr755365wmg.80.1706079126604;
        Tue, 23 Jan 2024 22:52:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm48113330wmb.41.2024.01.23.22.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 22:52:06 -0800 (PST)
Message-ID: <2ba5d4ec-1019-4919-9137-c1c52e20e638@linaro.org>
Date: Wed, 24 Jan 2024 07:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-7-392b010b8281@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240123-mbly-clk-v3-7-392b010b8281@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 19:46, Théo Lebrun wrote:
> Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 78 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
> new file mode 100644
> index 000000000000..db62919053b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobileye EyeQ5 pin controller
> +
> +description:
> +  The EyeQ5 pin controller handles a pin bank. It is custom to this platform,
> +  its registers live in a shared region called OLB.
> +  There are two pin banks on the platform, each having a specific compatible.
> +  Pins and groups are bijective.

I don't see much improvements here.

> +
> +maintainers:
> +  - Grégory Clement <gregory.clement@bootlin.com>
> +  - Théo Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mobileye,eyeq5-a-pinctrl
> +      - mobileye,eyeq5-b-pinctrl> +
> +  "#pinctrl-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#pinctrl-cells"

required: block goes after all properties and patternproperties.

> +
> +patternProperties:
> +  "-pins?$":
> +    type: object
> +    description: Pin muxing configuration.
> +    $ref: pinmux-node.yaml#
> +    additionalProperties: false
> +    properties:
> +      pins: true
> +      function: true
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +    required:
> +      - pins
> +      - function
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mobileye,eyeq5-a-pinctrl
> +    then:
> +      patternProperties:
> +        "-pins?$":
> +          properties:
> +            function:
> +              enum: [gpio, timer0, timer1, timer2, timer5, uart0, uart1, can0,
> +                     can1, spi0, spi1, refclk0]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mobileye,eyeq5-b-pinctrl
> +    then:
> +      patternProperties:
> +        "-pins?$":
> +          properties:
> +            function:
> +              enum: [gpio, timer3, timer4, timer6, uart2, can2, spi2, spi3,
> +                     mclk0]
> +


Best regards,
Krzysztof


