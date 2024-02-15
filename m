Return-Path: <linux-kernel+bounces-67545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BC856D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1091F22C19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B3139564;
	Thu, 15 Feb 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQsaz+hA"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA01386B8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023756; cv=none; b=cfAbRFGbC/F1kE6ROR77j+CrEGIRiGBO/Dq5CE2gkx3dvsOQhU6fADGg5j9tzy441J6YU7dDqprL7Rp/sdWutOVcE58PM79CuqDdNb6b14GfPJsUIt/5Cp3ieVcX8zB6kdmWupqyv8p7/TO2e8aVjH5+gzA6gHVrjumbcAln++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023756; c=relaxed/simple;
	bh=uRv/RoHUmRyyAx309YjPjU51VhE+9Mv+j5Ha4YmG7WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1y6g9x6WeIfggs7z7ccar8BL7JnWPqJiDmIoZpqNaodOyL3EFPE8OF4xjn4WXeLNnZ5Eq/MnMd2FCU/4hiI1QJCsApe9O/8Imtr5qF/YUt8pOr0JxEi2sL0SWcYp8FueIOspy0bApWVmXYa/ODaupQiYPnGjkWE8DeqVd9OvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dQsaz+hA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1606982e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708023752; x=1708628552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WINM1CAiAfhoXZ192uGwEElhM4Prco8Dh6+uC1Zs1Sk=;
        b=dQsaz+hACRpUOhGRDaF0YSkZ7dnJPWHSVgttbr1cZP6o7TAEmDb8yJ+XcxeFI5q4hQ
         5lvCLZLeIS4mgv4I2GVPT2ZSB3lpBaP4mxoe6ScantM007aCoPOjkaM8G72ezNjAZTDk
         zAxHHNaSgrq+dxZCZLd0rvllYoXiWwl6yYBE0zg51gp3hYN96UBXWJz0zdljACQKKX+j
         WkvhCp41z0BA7R6rzLy3BY0/UvtyVCIm5dtqENo8np8OzVMRlq8kOQVpXw5cr5Kp3Md4
         QKjNyFX+MPu5LJXu+8DL7K8fIEgEty1iWUSdYU2KcNWC7ZOFnMyB/aTk6DfyG4hl4iZ7
         q3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023752; x=1708628552;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WINM1CAiAfhoXZ192uGwEElhM4Prco8Dh6+uC1Zs1Sk=;
        b=RGsZ36RA9+4gz0PRLfDQdyTW44JJWTyctsr98fI1l/ysPYWqPvX+2lmZyxJt90s3cN
         g6Z2iabBgN/ub0PvrxUI92In7fv37P0GiMF0sjaFjQR7k5iQkqHVKXRF2rJkNZLxjUeG
         LRsrwAJqMXh3OCmleDZPqI/RRnB8V8FfgQrlXarTTRRkaWdUdRUqX+qxKnhpOQU76HLj
         YIwj9aDZG+4uLbmh54PEiFJfPCXF7C8w4INKC2zkq71ewifJni8XbWSBVemo5bClIm65
         SQr+s34jXZy+3D/7zbaG73XyTRciqmVCi0ydg78EmarBAccU86d6qPMDIiqvYYvThd29
         pJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUoKXBixh+Iewnu+GHEqbhErZ9unvTs4TwaA5fm1IS8tl3S2l8qUFZymuo0/KZuGVVZhs2iOrvYWUWE67G9r/L2Th4HtFWR2qVGbr
X-Gm-Message-State: AOJu0YwbFx8QX6u+yQNIT2jFPelbq6+Se04kqIsZCcI6qg+gi9GkU4NP
	2bHfRwev5msWGDdDMok+DbNlewyvA8tpmN5uum2w2ijbByrMYxPcvTzpd6rrTF0=
X-Google-Smtp-Source: AGHT+IGPISWatCsmdezcsFzOVFA1u++4PVNjsFb3qToyHec4nyciHsccN+lriRsa3TovwxGoo4rxVQ==
X-Received: by 2002:a19:ca42:0:b0:511:66f0:8287 with SMTP id h2-20020a19ca42000000b0051166f08287mr2120743lfj.28.1708023752222;
        Thu, 15 Feb 2024 11:02:32 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id au2-20020a170907092200b00a3cf5450b28sm820024ejc.189.2024.02.15.11.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:02:31 -0800 (PST)
Message-ID: <8c3d8fc3-2c1e-4ece-abb1-b427a909ad39@linaro.org>
Date: Thu, 15 Feb 2024 20:02:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240215134856.1313239-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 14:48, Md Sadre Alam wrote:
> Add device-tree binding documentation for QCOM QPIC-SNAND-NAND Flash
> Interface.
> 

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  .../bindings/spi/qcom,spi-qpic-snand.yaml     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> new file mode 100644
> index 000000000000..fa7484ce1319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml

Filename like compatible.

> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPIC NAND controller
> +
> +maintainers:
> +  - Md sadre Alam <quic_mdalam@quicinc.com>
> +

Provide description which will describe hardware.

> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq9574-snand
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3

You must document the items (could be sufficient in clock-names if the
names are obvious).


Why the clocks are flexible? This given IPQ9574 has variable clock
inputs? Please explain.

> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +

required goes here.

> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#


> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-snand
> +
> +    then:
> +      properties:
> +        dmas:
> +          items:
> +            - description: tx DMA channel
> +            - description: rx DMA channel
> +            - description: cmd DMA channel
> +
> +        dma-names:
> +          items:
> +            - const: tx
> +            - const: rx
> +            - const: cmd

No clue why it is here, move it to top level.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +    qpic_nand: spi@79b0000 {

Drop unused label

> +        compatible = "qcom,ipq9574-snand";
> +        reg = <0x1ac00000 0x800>;
> +
> +        clocks = <&gcc GCC_QPIC_CLK>,
> +                 <&gcc GCC_QPIC_AHB_CLK>,
> +                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +        clock-names = "core", "aon", "iom";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +            compatible = "spi-nand";
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            nand-ecc-engine = <&qpic_nand>;
> +            nand-ecc-strength = <4>;
> +            nand-ecc-step-size = <512>;
> +            };

Fix indentation.

> +        };

Best regards,
Krzysztof


