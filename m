Return-Path: <linux-kernel+bounces-45948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F9843840
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC351F22F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74059140;
	Wed, 31 Jan 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IN6Hu/Qs"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACF55C10
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687367; cv=none; b=GH5Gnvkwwv6LN5c0FcKycpu8hOSiSizZdp9BQIJEgShzjv+ogO7HTs7594fpfeMLtkXJIrKi6zZ7aLOjK4n6eOI/ddNFy647ejQdldnd14RKxUwJC88cEf9adpZTD7oed34dHDgO+8x70HKgVED9qBg62HEfNDC6ymIN/EDRp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687367; c=relaxed/simple;
	bh=HWlsuebpHOu78hg2aYWycWjuTahQJBrgSHh6JjdB35k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqLIWnD2OyHMjEjQ9q9ZLc41c0PgMomaoODK87dgx4szu+ZYvBZYE85xuyXBa9f7S/rkEy9eEUfUIeeksOSKpsBETlpXeEdKo0MEVoot/m+W45xeKi8iZjuMXLJJkDzwFPziMG8xKGXEmohz6FQn59qDFm+j3DJADl1Jr3d4e5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IN6Hu/Qs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51117bfd452so3249003e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706687361; x=1707292161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8XrPzUmDR9L0vMMMofKY15kNeMStha1JJ8k77KyawU=;
        b=IN6Hu/QsPEU1ArxOjj7w2RVFsX6pjtdh7IAyGHn9fkug2vJvWgU1E2DTaVoZCriVOL
         MxVqqLiHhP3oz8FdyxMzHfHAFWiUMu04yjKpRC3fwD1AKqDLtelFq865KO1YUcUkGh9j
         MLsqy53MVJnnhktEeUpiSU1XIGkymDwIdJkaVC9HKJBcxHZpMY9wc4WQ6jVoiEZJO3dO
         UsmXOxarxJTmdEQIJeMu1OQM8U3PZ5pnXjAu9YDayCYS7/sll8tFa+MQj8fXYvMwIDiu
         ijL1q7U7Qc7+/vGbCReakwc16f9G9qDr7HC4wkqKkwTNh5LY08psfhRRR4feT5KVn/TB
         zbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687361; x=1707292161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8XrPzUmDR9L0vMMMofKY15kNeMStha1JJ8k77KyawU=;
        b=pwwSg8gp84ELSEc2RNkqtJQxhxcpa5xUEx4dQKpTnjDzeUBqDIgbkQGexNaHBCMQNo
         N2KRZ+Ov1nLCcG7CTw8ULG567AjNmYhz9vUEpaxzZsWHaLA2WwisnacgdsprHx6TBhTi
         AdQiJVKc9csBd6ThZvyKldHMjnciAgiYvUOmz7ZEsnwnYBkKJDSzhZjTT7AtgQHoBTs2
         D4sYi6iYyZmFkRNZxUOMqTXxAxVaf4Vb5rtYQ3pfi0/QLxli24a2DLQGJFRPEIoSnijv
         VywHAL2jiA46dL8xa10aTT30GOaqw76xaS3GImP6nfRuCzWwiJ1RpnhAgJ2qVGD9Jh9J
         GfMg==
X-Gm-Message-State: AOJu0YypkgtdHe4kFpOLDZjQ3VYglgvD3lyS58GH21MsMFecpm8blp2N
	Cos/nNyxIxvD6VLhZemCfgzNVB0wi7UQEJ/UQI7qI+99lTtuCoNfr2zrBsuVSGGZ5MjmZxJVKI9
	p
X-Google-Smtp-Source: AGHT+IGs+Jn8iPuK/FtIE2kpoRkH0WdYVMqjPMM0vsSLY0+89edtc9Xewmzo4uZ+yV1Ne9ZdXcToCQ==
X-Received: by 2002:a05:6512:b1c:b0:511:e8d:a1e6 with SMTP id w28-20020a0565120b1c00b005110e8da1e6mr731393lfu.28.1706687361257;
        Tue, 30 Jan 2024 23:49:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZMPxwSNoyHqZc5YIN13bA3n5mJlYxDyHBF0vIcS3YaJQIBc/ULHsfpM+0H1Lq6dwE4cb0+pX/af3F1Hut/tR84+a+5Hk1cnJNOeWFpu08gFCdD5V5cR6DfJgPgZ2+MBy4rLRZ5STUUDj6nNaKs0962Bjst0sVTpFda0QfrHr1sGs3SH/pzK9iE0rxybi/16Yk4HDSrUB4xxlNlCV/fF+2JHxv3nAQkNQYlFrwDJCyfFuLjFzNbUtEnw31poX8tXLAcC0S0Xpx93R8QmzhGX2Of39vsINGxyH8sQbXMS/wU7CwKQJrNtlSzn/fAmblYUTul2H20mc/Ko4hEgGOztSa8fU5PXO18+02mfoVvTWcdLL/GD8+JR4K6M+sUM3HjruBhl5X1i1gzyt4eF2tq+r8C+KGuWLVa9wQd6sHm8CqSD8=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a368903fc98sm80556ejd.136.2024.01.30.23.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:49:20 -0800 (PST)
Message-ID: <e7bf16fc-b12d-47eb-9197-0694e6829ac8@linaro.org>
Date: Wed, 31 Jan 2024 08:49:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bingdings: perf: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131065953.9634-1-jialong.yang@shingroup.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131065953.9634-1-jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 07:59, JiaLong.Yang wrote:
> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU driver
> for HX.
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
> v1 --> v2:
> 1. Submit dt-bindings file Seperately.

Where is the driver?

Please read:
https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/process/submitting-patches.rst
before posting.

> 2. Do some check:
>    ~ #: make dt_binding_check DT_SCHEMA_FILES=perf
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>    DTEX    Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts
>    DTC_CHK Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dtb

No other changes? Sorry, this is not acceptable. You must implement
feedback and then describe what you changed in the changelog.

> 
>  .../bindings/perf/hx,c2000-arm-ni.yaml        | 53 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  6 +++
>  3 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> new file mode 100644
> index 000000000000..de50c79a5f23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/hx,c2000-arm-ni.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HX-C2000 NI (Network-on-chip Interconnect) Performance Monitors
> +
> +maintainers:
> +  - Jialong Yang <jialong.yang@shingroup.cn>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hx,c2000-arm-ni
> +
> +  reg:
> +    items:
> +      - description: Physical address of the base (PERIPHBASE) and
> +          size of the whole NI configuration address space.
> +
> +  interrupts:
> +    minItems: 1

NAK, I wrote why. You just ignored my comments and did not even wait for
my feedback.

> +    items:
> +      - description: Overflow interrupt for clock domain 0
> +      - description: Overflow interrupt for clock domain 1
> +      - description: Overflow interrupt for clock domain 2
> +      - description: Generally, one interrupt line for one PMU. But this also
> +          support one interrupt line for a NI if merged.
> +
> +  pccs-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Used to identify NIs in system which has more than
> +      one NI.

No, reg does it. Drop the property. Anyway you miss here vendor prefix
and proper explanation.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: true

NAK, not explained in changelog, not correct.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmu@23ff0000 {

Use 4 spaces for example indentation.

> +            compatible = "hx,c2000-arm-ni";
> +            reg = <0x2b420000 0x10000>;
> +            pccs-id = <0>;
> +            interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db4..f6b4103ef436 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -617,6 +617,8 @@ patternProperties:
>      description: Shenzhen Hugsun Technology Co. Ltd.
>    "^hwacom,.*":
>      description: HwaCom Systems Inc.
> +  "^hx,.*":

hexin,

> +    description: HEXIN Technologies Co., Ltd.
>    "^hxt,.*":
>      description: HXT Semiconductor
>    "^hycon,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8999497011a2..101974780710 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18866,6 +18866,12 @@ L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/thead/
>  
> +HX ARM-NI-700 PMU DRIVERS
> +M:	Jialong Yang <jialong.yang@shingroup.cn>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.yaml
> +F:	drivers/perf/hx_arm_ni.c

There is no such file.

Best regards,
Krzysztof


