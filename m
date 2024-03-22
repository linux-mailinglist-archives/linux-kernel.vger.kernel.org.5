Return-Path: <linux-kernel+bounces-111048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B5886752
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7553B23987
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BC81119E;
	Fri, 22 Mar 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g55O7fj1"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864815AD9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091251; cv=none; b=sPxj9apBi+cC0VKzDGFX7TkbQeUXMfmZ03SmMRvaEtwmukXkUljtBuMLbofEJpINCWTVZ1Qnas0bUUbTwzPF0ZqReKaO7WAvcNFo1bcrPXJ1g1CmbaLtoUPlhviGT02Jo6Cc0jyjWY6jOJEJp4BqteZUVIF/cUwhezEXrUnadRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091251; c=relaxed/simple;
	bh=dibDD3RK/z7jNjEE6AyFDQpIw0sjzNzfRVggjdX1JEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmawRxIzCSwFrcuiPf2ZJuX9EycIb+MGekZo4V4nBvLLqz8KMrgFx3xvQ4eZgwiafL1rb8V3iaHrvqnHnKb5ob/6ojNGlT3rZEx5t8mbH2HkUfZ5gnvGtWnHxpUJ5kQm2k8OO5XHPRmRyp9hcR7o+k6roDdtn2UbE0XNhHjlyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g55O7fj1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bcbf40cabso1821684a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711091248; x=1711696048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+IqxYSznSF0dOGEo3eRAT53h2zWat2EDnZFz5bA1NmU=;
        b=g55O7fj1Ag90P5mQ5tTRLVkDtyERteU7LkbRKqGzBxYfu8cJPK4A4N3bts7FrulTAz
         0x7VzKXOfS+r8Ahh639LVdcZ8RGndQdhBoTmHcsw2otBelX0zfxOhq+8XD6Ub9ks1//I
         JXxg7slK9mRSC0z5rGJOs4cyT81oQ+Lr+fggnXAUp/W51VNSyjloC+6p/AaeAdrnNOU5
         fN6pClBDmv4m2N3f/8lTsaiVkcX9JD4tpOyPhB42SjwLHJvodapD1bYJtGlMV6uYeO1e
         7Sj99T6+iwP5Qd3f/QDXL9txQjbUzMk8vfgQZcFhJ2kTvIUmtY+edsV/nxR7l34J6lM2
         Ei2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091248; x=1711696048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IqxYSznSF0dOGEo3eRAT53h2zWat2EDnZFz5bA1NmU=;
        b=TVUNkd4iUNy0HwS2gTLUWA3nmdJdGgeltGHUok3tQmNEdABCFLqviaeeAb4WIfUKrt
         Fa5i7jDcCaZD8RaxeG9O9VtpPuiFnR11bsL4nqxM54AqDQga36lzOUnzKFKOTX5U+iN3
         kW/Vqbasx4bAxJUoaxZA57feSUMrwHdX1Duirw6LxWDHy+b4tuL/cuZOgWkd1Rb1MdO2
         2v7WUk0YQub9Sv5czy+JjMGWhGxVy0jlGoLxXSQBkEmp1FSgBvWcIbi9b4FmGrEarwJy
         MpxgkF+376lzgehfX9hwkNGkjH4W8cCnf88uJn494iCFG/woXvj9t431NP8v7l7h+lRk
         pPPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEVKBGE/KHuO9b57DTMBjTzY2CpQ3V2TR7hMOJCgPFQuIJ/EkrxeuhFS+lwlrtRO5f+iIdxfXQ3hVYmP+eu/5EQbdG7ftKdVPE7jvq
X-Gm-Message-State: AOJu0YwPaAzldtLLoUNBVdUoakXi1te3UR8EXzqZpr6rfOth84pPEOXd
	4HtPuQlz5049IappsmGIWRNqbUezqYu2hDQleSYfCYHFDEE8mAtJJ5h5qP+Zd+Y=
X-Google-Smtp-Source: AGHT+IEnFRcf8NA34JzX7H+NXLIfCDHydjoDSkAEynbOJCarizdc+au3qNpI2J4YN4RK8akreuQcaA==
X-Received: by 2002:a50:9e65:0:b0:565:7b61:4c82 with SMTP id z92-20020a509e65000000b005657b614c82mr849247ede.5.1711091248066;
        Fri, 22 Mar 2024 00:07:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ig3-20020a056402458300b00568b6d731e1sm699630edb.4.2024.03.22.00.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 00:07:27 -0700 (PDT)
Message-ID: <f2b2ecd2-7df7-4265-a022-655bffc7ac61@linaro.org>
Date: Fri, 22 Mar 2024 08:07:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: mfd: Add rk816 binding
To: Alex Bee <knaerzche@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240321143911.90210-2-knaerzche@gmail.com>
 <20240321143911.90210-4-knaerzche@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321143911.90210-4-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 15:39, Alex Bee wrote:
> Add DT binding document for Rockchip's RK816 PMIC
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
> new file mode 100644
> index 000000000000..b46de99f60ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
> @@ -0,0 +1,259 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/rockchip,rk816.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RK816 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Chris Zhong <zyw@rock-chips.com>
> +  - Zhang Qing <zhangqing@rock-chips.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Rockchip RK816 series PMIC. This device consists of an i2c controlled MFD
> +  that includes regulators, a RTC, a gpio controller, and a power button.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk816
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      See <dt-bindings/clock/rockchip,rk808.h> for clock IDs.
> +    const: 1
> +
> +  clock-output-names:
> +    description:
> +      From common clock binding to override the default output clock name.

Drop description, it's obvious.

> +    maxItems: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  system-power-controller:
> +    type: boolean
> +    description:
> +      Telling whether or not this PMIC is controlling the system power.
> +
> +  wakeup-source:
> +    type: boolean
> +    description:
> +      Device can be used as a wakeup source.

Drop description, it's obvious. It's considered generic property, even
if we did not document it in dtschema yet.

> +
> +  vcc1-supply:
> +    description:
> +      The input supply for DCDC_REG1.
> +
> +  vcc2-supply:
> +    description:
> +      The input supply for DCDC_REG2.
> +
> +  vcc3-supply:
> +    description:
> +      The input supply for DCDC_REG3.
> +
> +  vcc4-supply:
> +    description:
> +      The input supply for DCDC_REG4.
> +
> +  vcc5-supply:
> +    description:
> +      The input supply for LDO_REG1, LDO_REG2, and LDO_REG3.
> +
> +  vcc6-supply:
> +    description:
> +      The input supply for LDO_REG4, LDO_REG5, and LDO_REG6.
> +
> +  vcc7-supply:
> +    description:
> +      The input supply for BOOST.
> +
> +  vcc8-supply:
> +    description:
> +      The input supply for OTG_SWITCH.
> +
> +  regulators:
> +    type: object
> +    patternProperties:
> +      "^(DCDC_REG[1-4]|LDO_REG[1-6]|BOOST|OTG_SWITCH)$":

Lowercase. No underscores allowed, use hyphens.

> +        type: object
> +        $ref: ../regulator/regulator.yaml#

Full path, so /schemas/regulator/

> +        unevaluatedProperties: false
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:


Best regards,
Krzysztof


