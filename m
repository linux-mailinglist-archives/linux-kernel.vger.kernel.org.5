Return-Path: <linux-kernel+bounces-87331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B986D2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8601F23E29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E681369B2;
	Thu, 29 Feb 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuTSt4td"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E60651A1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234163; cv=none; b=jyCU71A3WuQsP4kTysArkr31vugqETHZMpoiZnztqCglWwW2VYjVv5D4UsStIH7vQo1il0tWccJMoe+zPaKE82nl2kKMHLOe1zuPbojps/6jIObmO9h5qUY/vaTY3HZe+cK3WV5FLJSZXinYFqxGXc2eWK3/V6gUiOrQMzb64FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234163; c=relaxed/simple;
	bh=enTwKiPV6gszlXIWh4NE08XIpcKw+nHbFCK4kikw9OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV1+wht/Ii92RpRiKo8mGaCAriA053T1iYQKjytpFi4Iq6jwOMcWvxX0ZL006rjfqENnfv4SH06rrDoBqTixG1ZVZqkVMTAj+KaQqI31lfpzxcMfYuqubBEQRddmiYOLmQqyJtXIn2zTaU9TZzPyEaMmsu9R049Oefe8l0itrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vuTSt4td; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2063439a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709234160; x=1709838960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KVs2xY5V0DYRFi2eR2P5ZPWnY3v8bG4AFDORnyoQ8nY=;
        b=vuTSt4tdpkNgMe//f9Jg/IvcTY6AuM9QWLTLNiSbPLqHeTJAzX+ZZKJC/cd2Bj9ORn
         Hkhcil4kAY6ayWckM5m+VXdspyN2DA9RHykt3F5bYgRubW1dxyRtmS6kUYo6L0fWKB1t
         QuG+rdqEkhgWZ67R1UEz2tftWvDjOVD4it4b5kX+c+IvhWRZAcs6GQQrbeRcRa9V42Q5
         oRBl4xRCrLzsROERHZXNm7iIquFaju8iYcnaY+Th9YY4puaNPmOpxtwgp8GRVSTwpN3s
         7Ze+jhU+Uo3cVck3wkNh1jCFtplCFulIS8cyf8i53vxAGTJ0EYAiDojbK2u1ajhiDylQ
         MkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234160; x=1709838960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVs2xY5V0DYRFi2eR2P5ZPWnY3v8bG4AFDORnyoQ8nY=;
        b=Sq8MkBW9Hok/DNHXNmTlmccNbeeXYZoOZW3hpPwBsCb1iv8zJ6Ip+vKhQThK+OxHaz
         eeNfogyx4JteR/a8aCWV3o2DPnpXl4s++sYkQ+S6cdsnR6Abb8FzCNy5r38YmGoAQJRq
         G/Wf8mhBq+YNF51bqit1Erva0CAuOC8uNho6kbBtCO8G0kB2c9t42aTkTeMQC6ZXPzMX
         wjYUpR7BmbTmpjtgIlIy8oKq6O/NIRVklEZeTw1ZM07qCeoQZakvx/k/3/IV9I7jT9/b
         3x3T4hKrxtu5/LatI3OCkUcZLKil+eddFN2r9xh3A7WXGvQ0wDTqPEfBJulP5GCofCsx
         C9/w==
X-Forwarded-Encrypted: i=1; AJvYcCWUBda807kid6kEfjuaX/uX9nNUYQYKc5YaewNDXgcw10BzXE4/qErcJXeDeRpc9ZDYRo7ydBO29Id9VJauepQLmD1i7O5u6UFGBWn4
X-Gm-Message-State: AOJu0YwipFRBqD7RPybjCfwSTj2J3trLTalRVnL4Ua9eQtUTgMtA3TEp
	QfDpbJ+kEvSQWvoUCdAebxNn+1MR9xS5YEOiRRDWVrPPaWOSll7NnTPCwIclg/g=
X-Google-Smtp-Source: AGHT+IEmgqO+OalLQ3aKNGjycf8QFvdTDeDT1b9HeTBGmuKlOdMYBUZKxA5tBf7LxQalo7+klDcyag==
X-Received: by 2002:a17:906:2449:b0:a3e:8f38:8d76 with SMTP id a9-20020a170906244900b00a3e8f388d76mr2159220ejb.59.1709234159979;
        Thu, 29 Feb 2024 11:15:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id hu17-20020a170907a09100b00a3e881b4b25sm945322ejc.164.2024.02.29.11.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:15:59 -0800 (PST)
Message-ID: <6db2491d-5f8f-43e7-a8c2-b9018bdb7617@linaro.org>
Date: Thu, 29 Feb 2024 20:15:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: thermal: convert st,stih407-thermal to
 DT schema
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
 <20240226-thermal-v1-1-8b03589ece73@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240226-thermal-v1-1-8b03589ece73@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 08:48, Raphael Gallais-Pou wrote:
> Converts st,stih407-thermal binding to DT schema format and cleans

Please use imperative for your future patches.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> unused property "st,passive_cooling_temp" which does not appear in the
> device-tree.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  .../bindings/thermal/st,stih407-thermal.yaml       | 61 ++++++++++++++++++++++
>  .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
>  2 files changed, 61 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> new file mode 100644
> index 000000000000..807f8d77edf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/st,stih407-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi digital thermal sensor (DTS)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +  - Lee Jones <lee@kernel.org>
> +
> +description:
> +  Binding for Thermal Sensor device for STMicroelectronics STi SoCs series.

Drop "Binding for" and describe the hardware. If you repeat the title,
then the description is not really needed.

> +
> +allOf:
> +  - $ref: thermal-sensor.yaml
> +
> +properties:
> +  compatible:
> +    const: st,stih407-thermal
> +
> +  clocks:
> +    maxItems: 1
> +    description: Phandle of the clock used by the thermal sensor.

Drop description, it's obvious.

> +
> +  clock-names:
> +    items:
> +      - const: thermal
> +
> +  reg:
> +    description:
> +      For non-sysconf based sensors, this should be the physical base
> +      address and length of the sensor's registers.

That's odd, probably old binding was incomplete. You have only one
device described here, so I expect this to be always present (thus
description is obvious).

> +
> +  interrupts:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Standard way to define interrupt number.

???

> +      For thermal sensor's for which no interrupt has been
> +      defined, a polling delay of 1000ms will be used to read the
> +      temperature from device.

Missing thermal-sensor-cells.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names

Missing reg and please mention the change from pure conversion in commit
msg.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    temp0@91a0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "st,stih407-thermal";
> +        reg = <0x91a0000 0x28>;
> +        clock-names = "thermal";
> +        clocks = <&CLK_SYSIN>;
> +        interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
> +        #thermal-sensor-cells = <0>;
> +    };



Best regards,
Krzysztof


