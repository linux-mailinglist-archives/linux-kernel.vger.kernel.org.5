Return-Path: <linux-kernel+bounces-68224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9A857783
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DF528297A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F817741;
	Fri, 16 Feb 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh931LIL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D61BF35
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071562; cv=none; b=YMu972Dm/qX0NRDHXpIyblthVEyRPK3kjuRUG+c7lq3IZIabcLTXWX5RHxNcyyj26rLb06Jj5KMyHRhcwhXn4YUkGkxhHYHXRIzClCTBkbMC6tA+Z4Anilr7gKhT9ODGKGKZPSZFGcLoprWUIlmQ+vwpfRCjH6h4w+bOKflOJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071562; c=relaxed/simple;
	bh=J/K+6S5mLwy5zjOVh0i7IzySh1T/EURkM2aXj5Infgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQY+52u2e8w7MbNi8x1cWDbnxc+9UIyNssqvI92tDHNWdEK55uGcqjsiGh1DzYT82/GALBhqISRaA9a5fPnGLzDfcKmoIuKWUdmy+oH84mCwAcSfn7UN92ysZ54mE6hlFC0W+LLTy91VIoPdEZNbh7Ufyzzm0kMDbya/J0faVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eh931LIL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5620595f743so2212698a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708071558; x=1708676358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRfj07k30BanivCyzMQ2y0qjStEMVI1FUkYTeu08x6w=;
        b=eh931LIL/VBrhJ8z049OxBKFsCZpUD/4p23k1qZerTZB+X5PQa2XmTnkSQaG+nlXi2
         kKEU6Z5RY4PmPGx2U2WqHiXTqlBo/M2QrGCRVPpdAt8LillmaLBg4h8cuGR7pc0Z8Gif
         6+n4zkOTkKaGea5qXoenqYxig33P2UTgtcF7LvfZPLVsngF4mPmE/wmJX8S8V9RYxi8w
         +nSuJPymua/QDyYmvSR2CKA8LM3Ot4bnRfX1nffrxvxWEzM8PRLM6XZqqciTrrKMXE97
         BzC+cJR8z6emjBdcag32fMr5vQJHYFJQ1weu5b/KYrHrw7CG9BftS6iBMpwjxFIR2xHT
         BjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071558; x=1708676358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRfj07k30BanivCyzMQ2y0qjStEMVI1FUkYTeu08x6w=;
        b=GPU2KlTo/mYnuE4AL1nBqG9WLhgGkdo+hMa3pMvK/4/rnDUk+bzxKssGPvyzSiP8Jm
         VRQUgBX28jBOZ83TavdAKoSMKsPwP+P0dkYjpWP5Xu+jdmmvpXoaQqMkdhtAaCxHoVUQ
         BXnBqe30wwndWn4y2GIBzawAqGjp8P3/+toLOzGtGjvHN1kqQnA2nYKh0ehZceMU0J5m
         bvsJuVEBQ8juaJA8a13qKvD9S9T4+tfxZdOUpJvSbOjsRSKmOabGxman2bUSeStLV7uR
         5MiM+0Y5jA3rJ3R1CW/sYPK9qd01qLT0g2fwMm0vP0S5iyUsqrvQ/6psHqHBz/LCgQgI
         Qb2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3DTYtgiIJzOHFMRfoypglHjX1J4RNeN1B7Ht/2mHmrFhN+MgQD5M1q3nVntULA7EPh27QRO7ssLnOKUPLFnAqoI02oIXdMWpW7Bv
X-Gm-Message-State: AOJu0YzAmEcV0alH2nsPm4Zhb8b4ma4GRaJpkSXhbuCA/Fp0eIuXZjxr
	nqI/UlwzojZZjxzMIJVZAkGY8nldYMlij4/25i4BNi/lc3bYGfcNScXTJWFRxhg=
X-Google-Smtp-Source: AGHT+IEmAfC18mHPnDSMCr+fpML1x8Xhcm7zdsm0aN9oQ0YnzYQfSNHIdy3lQ9mpkKDK5kOyK1bp6g==
X-Received: by 2002:a05:6402:1491:b0:561:ae53:565 with SMTP id e17-20020a056402149100b00561ae530565mr3576966edv.32.1708071558144;
        Fri, 16 Feb 2024 00:19:18 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ds14-20020a0564021cce00b00562af79fe8esm1305038edb.19.2024.02.16.00.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:19:17 -0800 (PST)
Message-ID: <b6e9a7f3-1521-47f5-b0a1-b65e79e32495@linaro.org>
Date: Fri, 16 Feb 2024 09:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to
 YAML
Content-Language: en-US
To: forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-2-7d46db845ae6@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-2-7d46db845ae6@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> convert the legacy txt binding to modern YAML. No semantic change.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---


> +++ b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml

Filename like compatible.

> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller

One line please.

> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@outlook.com>
> +
> +description:
> +  The Synopsys designware mobile storage host controller is used to interface
> +  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +  differences between the core Synopsys dw mshc controller properties described
> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
> +  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,hi3798cv200-dw-mshc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4

Drop minItems

> +    maxItems: 4
> +    description: A list of phandles for the clocks listed in clock-names

Drop description

> +
> +  clock-names:
> +    items:
> +      - const: ciu
> +      - const: biu
> +      - const: ciu-sample
> +      - const: ciu-drive
> +    description:
> +      Apart from the clock-names "biu" and "ciu" two more clocks
> +      "ciu-drive" and "ciu-sample" are added. They are used to
> +      control the clock phases, "ciu-sample" is required for tuning
> +      high speed modes.

Description should go to clocks: to individual items.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/histb-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    emmc: mmc@9830000 {

Drop label

> +      compatible = "hisilicon,hi3798cv200-dw-mshc";
> +      reg = <0x9830000 0x10000>;
> +      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&crg HISTB_MMC_CIU_CLK>,
> +               <&crg HISTB_MMC_BIU_CLK>,
> +               <&crg HISTB_MMC_SAMPLE_CLK>,
> +               <&crg HISTB_MMC_DRV_CLK>;
> +      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
> +      resets = <&crg 0xa0 4>;
> +      reset-names = "reset";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&emmc_pins_1 &emmc_pins_2
> +                   &emmc_pins_3 &emmc_pins_4>;
> +      fifo-depth = <256>;
> +      clock-frequency = <200000000>;
> +      cap-mmc-highspeed;
> +      mmc-ddr-1_8v;
> +      mmc-hs200-1_8v;
> +      non-removable;
> +      bus-width = <8>;
> +      status = "okay";

Drop

> +    };
> 

Best regards,
Krzysztof


