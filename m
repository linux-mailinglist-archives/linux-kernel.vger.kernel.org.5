Return-Path: <linux-kernel+bounces-4811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62A818253
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D3A1F25CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214D8F4D;
	Tue, 19 Dec 2023 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5SWEtxd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109218C0A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-552ff8d681aso5687043a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702971294; x=1703576094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3hlpIDBqsqrYWXFJYqKY1bnRljFNGMm8+LBasOqKbg=;
        b=W5SWEtxdWMUQPe9OmS6myUTaOMPC2SWdp6lI7xRgiZPw2WxxeZCpz7A31e+10P0DmX
         IEbp5VYLCxVEceRmxlxpORUM0O+9lav//Uc6cuxOm2OinBKQ1tTg/jItRwXI6Gnc07Ck
         26YzwVgFlKjV0HIiHUPGAcLTeWFHHimBiD7ynKgavWupDt4KYBFpLM4fFFBebuNZJ+G8
         Ewcumwoea298HFcjUtqL7locA7V53+s94cxGm5eQqypVWaIllKbU4Hrc6nLeDRDXVskV
         +E9BrdDfZ5ZYIbIr5BnBG68NHwT/mdFHtFuHpLAmcJR8+BdqlGw+7NxS969yVKpPpB7R
         /wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702971294; x=1703576094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3hlpIDBqsqrYWXFJYqKY1bnRljFNGMm8+LBasOqKbg=;
        b=TovX8rRfwZX4YwHiKmtCkqEY3yfFGekmRh/yAhxMXEChGu7gFxc8mkhd23ZKLcPhi1
         /rk2vhIhgHsT2OZGngrToLznLSjGgaHkHy1DP1m0TBvuYOKTPLlxYmVGet3GYxBfH9vw
         93ku8MOgui+iuwnBN1cRVHCmX+T1cyxgMoEqLg8PMOVAl7KBCrrg8T+6XVO0abY+ds+Y
         ABaK9aP0GavaRv+KIgHSFJQkotxGL6ib+Iug851zc2G1N4ztIIfkh7cF7XwXHo5hWW3H
         Xk1qKkCIgA4jhJvarKzOoXGL9CmcLUNECKJ4LLQPoLUW3RuW9yJDPjW0ZLxAWf5FWUyu
         NAUw==
X-Gm-Message-State: AOJu0YxDyR4gV5etLf0DhZnSsfSoe3MGDxk/Y6SNCeu+CcbnSJMm81tS
	wrL+D2Q0qhX0BTmT3iyXNmPnmg==
X-Google-Smtp-Source: AGHT+IH0jo8MfBwop9wF/BGlQ9DF/Zbd2J7Agm46C3ofKqT0qPmQf59oD0h+bxKSHrppRs3T9DxsBQ==
X-Received: by 2002:a50:9f4f:0:b0:553:5abb:457 with SMTP id b73-20020a509f4f000000b005535abb0457mr635030edf.8.1702971294228;
        Mon, 18 Dec 2023 23:34:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7cd89000000b0055289f60e3bsm4644445edv.79.2023.12.18.23.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:34:53 -0800 (PST)
Message-ID: <0f0c0d16-f736-419e-9ffc-c3dc507b815c@linaro.org>
Date: Tue, 19 Dec 2023 08:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
 <20231218-mbly-pinctrl-v1-1-2f7d366c2051@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231218-mbly-pinctrl-v1-1-2f7d366c2051@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 18:19, Théo Lebrun wrote:
> Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 125 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 126 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
> new file mode 100644
> index 000000000000..5faddebe2413
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mobileye EyeQ5 pinctrl (pinmux & pinconf) controller

pinctrl means pin controller, so you basically wrote:
pin controller pinmux and pin configuration controller

Just "pin controller"


> +
> +description:
> +  The EyeQ5 pin controller handles a pin bank. It is custom to this platform,

Can part of SoC be not custom to given platform? I mean... describe the
hardware, not write essay.

> +  its registers live in a shared region called OLB.
> +  There are two pin banks on the platform, each having a specific compatible.

Instead of repeating something obvious - visible from the binding -
explain why. Say something different than the binding is saying.


> +  Pins and groups are bijective.
> +
> +maintainers:
> +  - Grégory Clement <gregory.clement@bootlin.com>
> +  - Théo Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^pinctrl([0-9]+)?$"
> +    description:
> +      We have no unique address, we rely on OLB; we therefore can't keep the
> +      standard pattern and cannot inherit from pinctrl.yaml.

No, instead fix pinctrl.yaml

> +
> +  compatible:
> +    enum:
> +      - mobileye,eyeq5-a-pinctrl
> +      - mobileye,eyeq5-b-pinctrl

Why two compatibles? Description provided no rationale for this.

> +
> +  "#pinctrl-cells":
> +    const: 1
> +
> +  mobileye,olb:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the OLB syscon. This is a fallback to using the parent as
> +      syscon node.

So here is the explanation for missing unit address. If all registers,
as you claim in description, belong to OLB, then this should be part of
OLB. Drop the phandle.

> +
> +required:
> +  - compatible
> +  - "#pinctrl-cells"

So now please test your code without olb phandle...

> +
> +patternProperties:

patternProperties go after properties

> +  "-pins?$":
> +    type: object
> +    description: Pin muxing configuration.
> +    $ref: pinmux-node.yaml#
> +    additionalProperties: false

Why not unevaluatedProperties?

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
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    olb@e00000 {
> +      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";

Drop, not erlated.

> +      reg = <0xe00000 0x400>;
> +      reg-io-width = <4>;
> +
> +      pinctrl0 {

Suffixes are always after -

> +        compatible = "mobileye,eyeq5-a-pinctrl";
> +        #pinctrl-cells = <1>;

Where is the phandle?

> +      };
> +
> +      pinctrl1 {
> +        compatible = "mobileye,eyeq5-b-pinctrl";
> +        #pinctrl-cells = <1>;
> +      };
> +    };
> +  - |
> +    olb: olb@e00000 {
> +      compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> +      reg = <0xe00000 0x400>;
> +      reg-io-width = <4>;
> +    };
> +
> +    pinctrl0 {
> +      compatible = "mobileye,eyeq5-a-pinctrl";
> +      #pinctrl-cells = <1>;
> +      mobileye,olb = <&olb>;

Really, why? This is just confusing. There is no explanation for
supporting both. Hardware is either this or that, not both!


Best regards,
Krzysztof


