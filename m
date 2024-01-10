Return-Path: <linux-kernel+bounces-22793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4A82A2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F086D1F297B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6264F208;
	Wed, 10 Jan 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh8Y8aM9"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95064F1E0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3376555b756so2708092f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704920347; x=1705525147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAK4lUrvjOcxQfIkMXO9fleipqDkyWnsJuySNjvXBAA=;
        b=Xh8Y8aM9WK4UdTuwU5lGUWM+/E3iH2YKFu0bWiPCTkV1nd0viF/jiZsUMg/UXl6VrS
         y+4R7iru7k2DW9bzf3gEiwZQTe+LjwEash3WoDvRBG4tz/hzh7UxlGKLF9z9Anx5AZDp
         FaysPPsnsqIh0cqVCwcCAhA/J1aF/pSYycvO+UQDrSnvRMMGVJj5oC+2vPHLq1c0COXn
         Y3cutNzje99mAQxJxwAk+UaeSxovYW8odq1yMNeanEoCN9fC367zHfRTF1Y0fBo3QR2/
         6TtFHFIKpJBzB6O3hDD9Oe0nXrjUlLV9L7S8rwCOlVS9GxuuVbuJxEyIHiKqx5cm5Y7U
         Nn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920347; x=1705525147;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAK4lUrvjOcxQfIkMXO9fleipqDkyWnsJuySNjvXBAA=;
        b=Trta8QCs/ipwW75ans8Yj9BFzCUufmRNUHgVS8YeX1sJ/xhigtk0HrOXvQjSi4aWfX
         2D2KD4a3qNE3+lH40227V9sRMB8+Q65DIpbgFPhG68+0TrbDvAHwMPpPDdSJhj5PxlBZ
         ur2J/VBuNg+DLq3rM2VIS0x/O8oF6LI3Y/bWq/ZnCTMhnmREtpDLSzpfIHBXIL7hYcng
         CutYKqpLAUYb1AhCP5clem4Nn1QSw0WjaFxyAcr4KeXNBCMmYctLysbw/f/zrYhh19yL
         cXW/n2Poo/69DSWagB59g4oOFLrRIwxZeZ0fHEl4g+aK8Smiti1Erhn3S8D8v4Iufh1J
         Dw5Q==
X-Gm-Message-State: AOJu0YznIjP4ysRgl+fGaHlZponS1dxgXC8GgrsMXAJ/pZNmsMkdbggl
	p3zSNxSGVChnSZbd9+9oBTnos44R9HjhDA==
X-Google-Smtp-Source: AGHT+IEoGPgbL9FeeyJiBVnhM8y7KzwmWXMqqA2vgWlzPc3KOSDY3LoSbQHqpZmO7UPhSKbD9sfcMw==
X-Received: by 2002:adf:fd0e:0:b0:337:6528:9c08 with SMTP id e14-20020adffd0e000000b0033765289c08mr28156wrr.64.1704920347165;
        Wed, 10 Jan 2024 12:59:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d6e8c000000b00336f43fa654sm5686931wrz.22.2024.01.10.12.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:59:06 -0800 (PST)
Message-ID: <98eaac00-1e3d-4c27-89f5-0b6ec0fcb710@linaro.org>
Date: Wed, 10 Jan 2024 21:59:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 4/8] dt-bindings: soc: nuvoton: add binding for clock
 and reset registers
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com,
 benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-5-tmaimon77@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240108135421.684263-5-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 14:54, Tomer Maimon wrote:
> A nuvoton,*-clk-rst node is present in nuvoton-common-npcm7xx.dtsi and
> will be added to nuvoton-common-npcm8xx.dtsi. It is necessary for the
> NPCM7xx and NPCM8xx clock and reset drivers, and may later be used to
> retrieve SoC model and version information.
> 

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> This patch adds a binding to describe this node.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---

How possibly could it be v22 if there is:
1. No changelog
2. No previous submissions
?

NAK, it's something completely new without any explanation.

Limited review follows.


>  .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> new file mode 100644
> index 000000000000..dfec64a8eb26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-clk-rst.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock and reset registers block in Nuvoton SoCs

This is vague. Any block? All blocks? Your SoC has only one block? I
doubt, although possible.

Anyway, clocks go to clock directory, not to soc! We've been here and
you already received that feedback.


> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description:
> +  The clock and reset registers are a registers block in Nuvoton SoCs that 
> +  handle both reset and clock functionality.

That's still vague. Say something useful.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nuvoton,npcm750-clk-rst
> +          - nuvoton,npcm845-clk-rst
> +      - const: syscon
> +      - const: simple-mfd

No, it's not a syscon and not a simple-mfd. You just said it is clock
provider and reset controller. Thus missing clock cells and reset cells.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  type: object

No, instead:
additionalProperties: false

> +
> +examples:
> +  - |
> +    clk_rst: syscon@801000 {

Suddenly a syscon?

Drop unused label.

> +      compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
> +      reg = <0x801000 0x6C>;

Only lowercase hex.

You just sent some v22 of something new, making all the mistakes from
the past submissions for which you received feedback.
> +    };

Best regards,
Krzysztof


