Return-Path: <linux-kernel+bounces-35600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1168393D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265B21F236A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40A60BAE;
	Tue, 23 Jan 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhQErZlx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FE60B94
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025324; cv=none; b=Y2s39JBSRyfSZZnKQu+PA7y7MR8PYq7QUYwdSUcxV58jfcL7jH824/ZrxXLgUw9BsxNoJiXWC+JN+azZ4+rlvbP5z5I/lw5Aa5msai/wk39zh2lFcVNdybO0YgXtuBGykDm3y9ZRNoyEwoeapBLVM7dQNr793+2XVpvDIlueyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025324; c=relaxed/simple;
	bh=90Sqy3oqcG58CRvQQ5Q8ou0x/wbc3VZnYOvFbL2VNok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyG5jYEd3s2mF7rsgvh/nvsFbVDc/bLSas8I5ZoyEGi6iYCS1oQ2NJ7KtB8xrk3Yfah/du77b7U+WBlfzj/IZvk74y6S3gofwkxRzecmREZIvufE66Qa12On/2N2BAHy2Zh8SJbCG/4rEu/1D5qA0/lsTbIDv24ol1GIeElb9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhQErZlx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368abe1093so3801187f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706025320; x=1706630120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbmGUCtpvGsX2MG2T5Vsy8zkaT6VJaj+LUjlkN2ktUw=;
        b=vhQErZlxbDc9bDmAje57lkPubw8J1vnxy6QDU8s+/8W6RAKzat0Wd8LjOJHt/UEjqO
         WgxNKgg5eZJTG2TrU4Xymmqmmn/ydO/bddfRc802MEIVToTxelTZM0jSDJb0VJmc9xy/
         CuduGgr8jHzqHm50s+zyI/4bY8ZnzybdcnlsGs+wWi//GPd16fJOMKwGDluwHlYyVi8A
         hEVEKJjAmdELFmp/czMZTptTKnSiduZ+Qpw+DDd8xd/gLkd9n4CA1X+Zs71eTq/BqYny
         0SVs61ltBfKy0E/LyOcVjbkYysRXS3G2ZR5DSsYLnogbiUtwo/fUA7EAe6NIMnB6ehgP
         IObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025320; x=1706630120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbmGUCtpvGsX2MG2T5Vsy8zkaT6VJaj+LUjlkN2ktUw=;
        b=DuQlt4+yXFuc/RlxX6TB5DODkq5xJfML4V592F9ZQ1a3FEloraBOn6uOF3EvIIkjUu
         BKP3KIOBEIFCm/8jSR4u5vRsHm6yPswh5Jc0JRqn55yMDUWLgmE/IwxFCuPMx6ItyL2W
         a4q5B5bgvMdljFeXRN/gM109cadWx3Ls0DtYa9WsURLg5O18+c59DLNbwYNkr53SAnmv
         vyQSa17AzjdR2OkwmkurZB4sKrmOLF20fyPPjW+tSkjRuY7fN3pEjLyUrxVvltUB37HN
         a57ZAbMkaj16VLzxJ3As8r/Ry919h87/jFAyX+0jCVxZHzt61m8NLy6eoXmS/n1KGsOd
         WWdg==
X-Gm-Message-State: AOJu0Yw1CBJLfKQ9YFgCpt8scaiKXKDydosTNHbBC/I9FDLQ1V/kp8Em
	xYN3lcs7lFtX8SJYXh8C4gyKGfQJp3Z6It1Q4SSi78ZAw26xTCQPd1x0jAq/m6M=
X-Google-Smtp-Source: AGHT+IG+R/C8YCaDFTa18cfX2wQwa06wkBpx0UU0UGrHPYEN8yENQ938bOZZytXwaxWJImBcA2FazA==
X-Received: by 2002:a5d:640a:0:b0:339:37a2:732a with SMTP id z10-20020a5d640a000000b0033937a2732amr1950015wru.29.1706025320515;
        Tue, 23 Jan 2024 07:55:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w15-20020adfec4f000000b00338a3325331sm11730174wrn.69.2024.01.23.07.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:55:20 -0800 (PST)
Message-ID: <2f168df8-218f-40a0-9371-56d330120b4d@linaro.org>
Date: Tue, 23 Jan 2024 16:55:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: regulator: microchip,mcp16502: convert to
 YAML
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240123154525.157448-1-andrei.simion@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240123154525.157448-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 16:45, Andrei Simion wrote:
> Convert devicetree binding mcp16502-regulator.txt to YAML format.
> 
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Reverse subject prefixes. See: `git log --oneline -- DIRECTORY_OR_FILE`
on the directory your patch is touching.


> ---
>  .../bindings/regulator/mcp16502-regulator.txt | 144 --------------
>  .../regulator/microchip,mcp16502.yaml         | 182 ++++++++++++++++++
>  2 files changed, 182 insertions(+), 144 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> deleted file mode 100644
> index 451cc4e86b01..000000000000
> --- a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> +++ /dev/null
> @@ -1,144 +0,0 @@
> -MCP16502 PMIC
> -
> -Required properties:
> -- compatible: "microchip,mcp16502"
> -- reg: I2C slave address
> -- lpm-gpios: GPIO for LPM pin. Note that this GPIO *must* remain high during
> -	     suspend-to-ram, keeping the PMIC into HIBERNATE mode; this
> -	     property is optional;
> -- regulators: A node that houses a sub-node for each regulator within
> -              the device. Each sub-node is identified using the node's
> -              name. The content of each sub-node is defined by the
> -              standard binding for regulators; see regulator.txt.
> -
> -Regulators of MCP16502 PMIC:
> -1) VDD_IO	- Buck (1.2 - 3.7 V)
> -2) VDD_DDR	- Buck (0.6 - 1.85 V)
> -3) VDD_CORE	- Buck (0.6 - 1.85 V)
> -4) VDD_OTHER	- BUCK (0.6 - 1.85 V)
> -5) LDO1		- LDO  (1.2 - 3.7 V)
> -6) LDO2		- LDO  (1.2 - 3.7 V)
> -
> -Regulator modes:
> -2 - FPWM: higher precision, higher consumption
> -4 - AutoPFM: lower precision, lower consumption
> -
> -Each regulator is defined using the standard binding for regulators.
> -
> -Example:
> -
> -mcp16502@5b {
> -	compatible = "microchip,mcp16502";
> -	reg = <0x5b>;
> -	status = "okay";
> -	lpm-gpios = <&pioBU 7 GPIO_ACTIVE_HIGH>;
> -
> -	regulators {
> -		VDD_IO {
> -			regulator-name = "VDD_IO";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <3700000>;
> -			regulator-initial-mode = <2>;
> -			regulator-allowed-modes = <2>, <4>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-off-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -		};
> -
> -		VDD_DDR {
> -			regulator-name = "VDD_DDR";
> -			regulator-min-microvolt = <600000>;
> -			regulator-max-microvolt = <1850000>;
> -			regulator-initial-mode = <2>;
> -			regulator-allowed-modes = <2>, <4>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-on-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -		};
> -
> -		VDD_CORE {
> -			regulator-name = "VDD_CORE";
> -			regulator-min-microvolt = <600000>;
> -			regulator-max-microvolt = <1850000>;
> -			regulator-initial-mode = <2>;
> -			regulator-allowed-modes = <2>, <4>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-off-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -		};
> -
> -		VDD_OTHER {
> -			regulator-name = "VDD_OTHER";
> -			regulator-min-microvolt = <600000>;
> -			regulator-max-microvolt = <1850000>;
> -			regulator-initial-mode = <2>;
> -			regulator-allowed-modes = <2>, <4>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-off-in-suspend;
> -				regulator-mode = <4>;
> -			};
> -		};
> -
> -		LDO1 {
> -			regulator-name = "LDO1";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <3700000>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-off-in-suspend;
> -			};
> -		};
> -
> -		LDO2 {
> -			regulator-name = "LDO2";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <3700000>;
> -			regulator-always-on;
> -
> -			regulator-state-standby {
> -				regulator-on-in-suspend;
> -			};
> -
> -			regulator-state-mem {
> -				regulator-off-in-suspend;
> -			};
> -		};
> -
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> new file mode 100644
> index 000000000000..13a6806b4604
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MCP16502 - High-Performance PMIC
> +
> +maintainers:
> +  - Andrei Simion <andrei.simion@microchip.com>
> +
> +description: The MCP16502 is an optimally integrated PMIC compatible

Line break after "description:"

> +  with Microchip's eMPUs(Embedded Microprocessor Units), requiring
> +  Dynamic Voltage Scaling (DVS) with the use of High-Performance mode (HPM).
> +
> +properties:
> +  compatible:
> +    const: microchip,mcp16502
> +
> +  lpm-gpios:
> +    description: GPIO for LPM pin.
> +      Note that this GPIO must remain high during
> +      suspend-to-ram, keeping the PMIC into HIBERNATE mode;
> +    maxItems: 1
> +
> +  reg:
> +    description: I2C slave address

Drop description, it's obvious.

> +    maxItems: 1
> +
> +  regulators:
> +    type: object

additionalProperties: false

> +    description: List of regulators and its properties.
> +      A node that houses a sub-node for each regulator within
> +      the device. Each sub-node is identified using the node's
> +      name. The content of each sub-node is defined by the
> +      standard binding for regulators;
> +
> +    patternProperties:
> +      "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$":
> +        type: object
> +        $ref: regulator.yaml#
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$"

regulator-name should not be enforced. Does driver actually require it?

> +
> +          regulator-allowed-modes:
> +            description: Supported modes
> +              2 - FPWM higher precision, higher consumption
> +              4 - AutoPFM lower precision, lower consumption
> +            items:
> +              enum: [2, 4]

What about initial-mode?

> +
> +        unevaluatedProperties: false

Please put this one just after $ref: regulator.yaml

> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c@600 {

Instead:

i2c {

> +      reg = <0x600 0x100>;

Drop

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      mcp16502@5b {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
E.g. pmic

> +          compatible = "microchip,mcp16502";
> +          reg = <0x5b>;
> +
> +          regulators {
> +                  VDD_IO {

Use 4 spaces for example indentation.

> +                          regulator-name = "VDD_IO";
> +                          regulator-min-microvolt = <3300000>;
> +                          regulator-max-microvolt = <3300000>;
> +                          regulator-initial-mode = <2>;
> +                          regulator-allowed-modes = <2>, <4>;
> +                          regulator-always-on;
> +


Best regards,
Krzysztof


