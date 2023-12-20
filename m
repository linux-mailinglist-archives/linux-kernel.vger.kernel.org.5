Return-Path: <linux-kernel+bounces-7184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDDA81A2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA861C22BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76081405ED;
	Wed, 20 Dec 2023 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4JXCcbp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B7405C9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so5660505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703087090; x=1703691890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbcoKOLolHIGvbvQqAAbJtKlJU8NeEowJJnb4OdKCes=;
        b=g4JXCcbpdSzUaYG+Vhfebov70KW7/ixm4jx/5B4xLX1Q/6LQMCk8ec3fcFCsVeMLrV
         xQNJwcCluD33P5BqY76G8bv38yn8fGEtwYr0t+4vOY9hqIs3OfVeWqoAhCihyhfemqD1
         SKrFinG7i0NXhpVJ+gXi0pSTLnEXmHKfO70m07a66daSaImzMTI09DDD6mVkV7l4Lobp
         EtSIvHe4hqd77tjlsa7zzx+aja6l0sKMKz/9E5Znrb8Hibo2/zihOkIkm3te74IkrZLF
         jjfyhtA/CNNSgB63zjxC4W3tW60dZEiF7mLGrrfSvVo3nFdsmH0MhjxfEyYMuo5ftBos
         W6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087090; x=1703691890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbcoKOLolHIGvbvQqAAbJtKlJU8NeEowJJnb4OdKCes=;
        b=jzFIS63NuHdDWPY51ZGkRGsQGvmuFcVhcJk0TUwRVkbW6PWOaYneAsj7DJTHY/Ai8s
         FUUGTZxFqcQICfS0rEFbb2QjtbYKMPDhTHAzhA76TyrBNqUnIy8O8Dd+CFXBqDEGa6D7
         KPKt2SfV9U+G/ikUYetJMEZ7yNRKuCowAMa87XtwpVA/bcuzwq5eOeZ2GrCdfX7r7jx9
         vlERWK/qWgikyv7ilEQzo2edUGbsjREj1hIFlDU303K/sQJdaiO+gM6l3EnVMMJ71prP
         Y/FwFwPw8laP8jJX3NmuheAMi902/ErjykmKwwH+fHUPxkPNtGTM/XuKw60WRuZ3yz+e
         4Fhg==
X-Gm-Message-State: AOJu0Yw9SJ6ibsuj+k7HfHvUS+FCmidbOl1lRy/BPeF0tYs4fJVpc7fa
	j1HX+Du7OYKciRv246IXywcEGRYC3oi9cdus4qs=
X-Google-Smtp-Source: AGHT+IGybtDZus8NVWxk0ZzUhIhIzn004ss2rYy0mAL4p2jcHBnbyAWqUsqODln0mIlbJ6WLs/2vNg==
X-Received: by 2002:a05:600c:3145:b0:40c:6d85:99ff with SMTP id h5-20020a05600c314500b0040c6d8599ffmr1918882wmo.49.1703087090410;
        Wed, 20 Dec 2023 07:44:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b0040d2524270asm42721wmq.8.2023.12.20.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 07:44:49 -0800 (PST)
Message-ID: <fe87e220-560b-4d47-bc7f-cc7104d40921@linaro.org>
Date: Wed, 20 Dec 2023 16:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: crypto: Add Tegra Security Engine
Content-Language: en-US
To: Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
 davem@davemloft.net, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 catalin.marinas@arm.com, will@kernel.org, mperttunen@nvidia.com,
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
 <20231219125614.33062-2-akhilrajeev@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231219125614.33062-2-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2023 13:56, Akhil R wrote:
> Add DT binding document for Tegra Security Engine.
> The AES and HASH algorithms are handled independently by separate
> engines within the Security Engine. These engines are registered
> as two separate crypto engine drivers.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../crypto/nvidia,tegra234-se-aes.yaml        | 53 +++++++++++++++++++
>  .../crypto/nvidia,tegra234-se-hash.yaml       | 53 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
>  create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
> new file mode 100644
> index 000000000000..35c2e701bd42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-aes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra Security Engine for AES algorithms
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Tegra Security Engine accelerates the following AES encryption/decryption
> +  algorithms.

s/./:/ and join lines? Wasn't that your intention here?

> +  AES-ECB, AES-CBC, AES-OFB, AES-XTS, AES-CTR, AES-GCM, AES-CCM, AES-CMAC
> +
> +maintainers:
> +  - Akhil R <akhilrajeev@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra234-se2-aes

Why "se2"?

Anyway, filename like compatible.


> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/tegra234-mc.h>
> +    #include <dt-bindings/clock/tegra234-clock.h>
> +
> +    crypto@15820000 {
> +        compatible = "nvidia,tegra234-se2-aes";
> +        reg = <0x15820000 0x10000>;
> +        clocks = <&bpmp TEGRA234_CLK_SE>;
> +        iommus = <&smmu TEGRA234_SID_SES_SE1>;
> +        dma-coherent;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
> new file mode 100644
> index 000000000000..e3848e9a53b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/nvidia,tegra234-se-hash.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra Security Engine for HASH algorithms
> +
> +description: |
> +  The Tegra Security HASH Engine accelerates the following HASH functions.

Similar comment

> +  SHA1, SHA224, SHA256, SHA384, SHA512, SHA3-224, SHA3-256, SHA3-384, SHA3-512
> +  HMAC(SHA224), HMAC(SHA256), HMAC(SHA384), HMAC(SHA512)
> +

> +maintainers:
> +  - Akhil R <akhilrajeev@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra234-se4-hash

What is se4?

Anyway, filename like compatible.



Best regards,
Krzysztof


