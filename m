Return-Path: <linux-kernel+bounces-22582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33082A004
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86572284031
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177D4D12E;
	Wed, 10 Jan 2024 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJu19aeh"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EE4D100
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e4d515c9aso31678185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704909673; x=1705514473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKl+uvl5ebHrMAACO3BPzytuK014zDcivJlJrIxKaX8=;
        b=AJu19aeh7FQN4v7ZdJVhrWxDbsSjpqe/WctCPdIVVkuxIHqaGNpltejlfrBt1w/MsZ
         t1SWkXP2ZaQN3Uy8mbTBHiaJVpXF2Y06deS1Kbxd9LW8KGHG+M2s3tE9kmzn736f/haz
         uCGPl2nI0lZxdlwCMtbaK08Fis1n9zICpU1Vjx4OjIP5009pkqCkvFznPIPOYCW5XxMb
         SJf11I2qvS7n6VuMU7Gn0ZpmMOb5iR15NwEnjtP1Au8i2vyRyrCEGR5LVADT47bP6yPG
         RdRG9/xln143GFw2K8H85p1otF9UHHB6P2nzCOLbXXnfObTiFoFcF3JVIpH2ZNLu/9wF
         55ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909673; x=1705514473;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKl+uvl5ebHrMAACO3BPzytuK014zDcivJlJrIxKaX8=;
        b=A/RUv7qp1m8jYgEtn2lQRTrRBKC4yRQyZMtQUZ/36ZeN/aF9XgDAZVdt/ym3ndjgYD
         VE2E5d6OGmhNxYalB5P17Rb83sAMyYg1MTLr5XT6wdfyKdrnc3CJRf4iN5BkbK2jsQIG
         NnxhSq5LsIOf5/18JfzM7bbvH4n6I8w3Vr6fln5xOIl1BjAPhXTmYUjGInNzq/Jf+VXQ
         yUE3y6mdhHgETmqr4boNi/ZunF0NErAwZ2Z5XCmF0bL7oEibimCrlzberOI/gPwn7nhr
         UxelcAwsftKMOusINWwqinnbKYHuw4RBfvYQbDe3133OHISB3YWaor+bvtO54tdc8opI
         eRWw==
X-Gm-Message-State: AOJu0Yx6RV6ThoctlzvNAwNOL1C/qzX4zVhyZEzpiI+T2BzSc0PQpLGF
	oM+ohJmuLhW6JOBOS+PcUwwx/2DhSGkkyQ==
X-Google-Smtp-Source: AGHT+IFqpewdPmcUQNc9uP85eIFeyX1h8g4AUvMAcoUwItuN6Q4S6g6gTcWymsEs03vjBrPIHMy+pw==
X-Received: by 2002:a05:600c:a019:b0:40e:3fa2:213 with SMTP id jg25-20020a05600ca01900b0040e3fa20213mr859553wmb.147.1704909673185;
        Wed, 10 Jan 2024 10:01:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm2913526wmn.23.2024.01.10.10.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:01:10 -0800 (PST)
Message-ID: <683b7838-9c19-4a51-8ec4-90ac8a8a94ce@linaro.org>
Date: Wed, 10 Jan 2024 19:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema
 format
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
References: <20240110102535.246177-1-dharma.b@microchip.com>
 <20240110102535.246177-3-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240110102535.246177-3-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 11:25, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 106 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 ---------
>  2 files changed, 106 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> new file mode 100644
> index 000000000000..555d6faa9104
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml

This looks not tested, so limited review follows:

> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCDC (High LCD Controller) MFD driver

Drop "MFD driver" and rather describe/name the hardware. MFD is Linux
term, so I really doubt that's how this was called.

> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |
> +  Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver.

Drop

> +  The HLCDC IP exposes two subdevices:
> +  # a PWM chip: see ../pwm/atmel,hlcdc-pwm.yaml
> +  # a Display Controller: see ../display/atmel/atmel,hlcdc-dc.yaml

Rephrase to describe hardware. Drop redundant paths.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9n12-hlcdc
> +      - atmel,at91sam9x5-hlcdc
> +      - atmel,sama5d2-hlcdc
> +      - atmel,sama5d3-hlcdc
> +      - atmel,sama5d4-hlcdc
> +      - microchip,sam9x60-hlcdc
> +      - microchip,sam9x75-xlcdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    anyOf:
> +      - items:
> +          - enum:
> +              - sys_clk
> +              - lvds_pll_clk

Old binding was not mentioning this and you did not describe differences
against pure conversion. You have entire commit msg for this...

> +      - contains:
> +          const: periph_clk
> +      - contains:
> +          const: slow_clk
> +        maxItems: 3

Why it has to be so complicated? I doubt that same devices have
different inputs.

> +
> +  hlcdc-display-controller:

Does anything depend on the name? If not, then just display-controller

> +    $ref: /schemas/display/atmel/atmel,hlcdc-dc.yaml
> +
> +  hlcdc-pwm:

Same comment.

> +    $ref: /schemas/pwm/atmel,hlcdc-pwm.yaml

There is no such file.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    hlcdc: hlcdc@f0030000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +      compatible = "atmel,sama5d3-hlcdc";
> +      reg = <0xf0030000 0x2000>;
> +      clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +      clock-names = "periph_clk","sys_clk", "slow_clk";

Missing space after ,

> +      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +      hlcdc-display-controller {
> +        compatible = "atmel,hlcdc-display-controller";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0>;
> +
> +          hlcdc_panel_output: endpoint@0 {
> +            reg = <0>;
> +            remote-endpoint = <&panel_input>;
> +          };
> +        };
> +      };
> +


Best regards,
Krzysztof


