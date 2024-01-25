Return-Path: <linux-kernel+bounces-38465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A386A83C04C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151A61F23C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D256473;
	Thu, 25 Jan 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HByBT7zP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7555C1F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180245; cv=none; b=dXloLl/bs413qh4lmcZLfuHU6UxAoo12OKU/EyI+SoKkc7u5vmlj5uxYKqJzgxpTqki61CpMPhP0/CIE5e5uDFZ1rXi5X0eKS03F3MoPP1tEYxynNxXVo7XSOqoBSyKVHhjCR5J+sGOEeK770rVZWW/L3EQbjHCD54kSKEtWLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180245; c=relaxed/simple;
	bh=4qD2CXu8N/6r+864TKXfk3a5vuGTZ4qhXFLEbdOxfK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvFth20C0lCoFyz965hNrn52P9Q/Cc1q58MSj+kn00SZ7VSg6v+GzF/+uqJItboBQxMO30zQNBKu1vNVPFCLYVybNGvZALPMQoQRMZp0wcSu4+maFgd1ZwMlrpCuXCksIouRqFaewIBtcRzU+scFKwJPQPMKBF2jDAFtj5B9HdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HByBT7zP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf161b5eadso31337341fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180241; x=1706785041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwpguGkqNwgpijlAt2Oe0B1qzP3LlkGTfciVecu4QVQ=;
        b=HByBT7zPYjtY+36iBWoGVukWS8Ximk4NnYYY1Pb+ydZceB5JLZSaiCoqzO18M2WJom
         8nIWwA4VQKuWJXVSP0FFTJOZGSMZZ3lti5d3AybG7WzyHCX+LhffhZ8dML9pH6og+jBO
         hh8W/4FyMj7B2ojY0j1ZOLGuCT6gxvjn73ZzPlCuKniX2cdi8Vna7RyXoaBdPuVlv2s7
         kOwdjodJ8RJ+bGniJJU5/lLMQr9BialzFE0btoWDVPWfFFZN0zX2lDNc/FfFM/oMvwMG
         nhSnaqlmPuWmCj1Wp51CEYIDHJ1rAMTdCKkSVyCM4ZqCSVwMwRHct28LDic913UC+a+7
         HiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180241; x=1706785041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwpguGkqNwgpijlAt2Oe0B1qzP3LlkGTfciVecu4QVQ=;
        b=Ua7aY4gRHbcqFUO2l79iq+sEoIekeA64tQ39F3ytOwhRFroWQA3cs+KVu74LPvDPil
         YReoQZey+PRVJCAGge3xVqix/nBGephtvV6DVQmsNR61xKZalqQa1k2aPqM7t1WcIMob
         vLlmWG6/+t9sz8TwvjOOScm7fNyLRFAuumFpv8NZwN+HMPcK4Im26geLPBefCqzbGQF8
         g2VGjVcdFjbXWG4cbNPUcn6hZw1UQUCzfBvaYYZ2/LD0lQFsx/SfPUmV4aFEe3LIJq3i
         O5ZCMnJQm4sma05iYD2ywm0zTYQUo8qrZ2Rebh9zf1WwYqAUKrm3BflEc15gM/e701qC
         2qhg==
X-Gm-Message-State: AOJu0Ywleh1omWe+nuHYehLlyLegDYS8DP78P/4mTp/taW686ZUooLkg
	UujPfv+kYFwxMMBpjZJWDfeBjVDTtQiMOWPRiCD3vC7Vu7QHHtHgP6Rz8qQjALs=
X-Google-Smtp-Source: AGHT+IGWm1fEW9w//XlIVmaPmR3FIhXEoLIWxVuRfsxULhe2J7QZD7uMCG5MCVPNBXtBMJ9DTE0kGQ==
X-Received: by 2002:a05:651c:205c:b0:2cd:7039:e281 with SMTP id t28-20020a05651c205c00b002cd7039e281mr530622ljo.8.1706180241628;
        Thu, 25 Jan 2024 02:57:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id qu27-20020a170907111b00b00a331d6c0c70sm13878ejb.71.2024.01.25.02.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:57:21 -0800 (PST)
Message-ID: <4e14b7c7-7f0a-437b-aa84-20fdc30a2361@linaro.org>
Date: Thu, 25 Jan 2024 11:57:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: power: reset: add bindings for NVMEM
 hardware storing PSCR Data
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
 <20240124122204.730370-5-o.rempel@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240124122204.730370-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 13:22, Oleksij Rempel wrote:
> Add device tree bindings that describe hardware implementations of
> Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons
> (PSCR).

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/power/reset/pscrr-nvmem.yaml     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
> new file mode 100644
> index 000000000000..779920dea283
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/pscrr-nvmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic NVMEM Power State Change Reason Recorder
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: This binding describes the Non-Volatile Memory (NVMEM) hardware

Same comment and also: describe the hardware, not the binding. s/This
binding describes/something useful/

> +  that stores Power State Change Reasons (PSCR).
> +
> +allOf:
> +  - $ref: pscrr.yaml#
> +
> +properties:
> +  compatible:
> +    const: pscrr-nvmem
> +

So that's a driver :/. Maybe Rob will like it, but it's a no from me.
Please come up with something really suiting DEVICES, not DRIVERS.

> +  nvmem-cells:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      A phandle pointing to the nvmem-cells node where the power state change
> +      reasons are stored.
> +    maxItems: 1
> +


Best regards,
Krzysztof


