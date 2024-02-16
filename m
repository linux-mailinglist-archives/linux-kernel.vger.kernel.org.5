Return-Path: <linux-kernel+bounces-68227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87045857797
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A532C1C228F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D971B27D;
	Fri, 16 Feb 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLTEdWL2"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392418B1B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071679; cv=none; b=jkP5KAMWf5P3QIoeny7YymNiQeuPoDldi5QLM9oT04sy90gOHbuJZyEsZcLyNJm32JClRQHMk/n1UqeGrC/n27QyBBqGJoKe/nvj3gTS84Nse2ziHaA1e8JNSlmOaYi5GaCGww5pl9usLnl0ABqhHaoni98xCgK37h98wFdoKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071679; c=relaxed/simple;
	bh=wNvH8irpVIRGBM1PyLQ/DV1p5gcS7Gn8xxWO4Z4gyY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS9tmtoCp4JyxC3ueskC8DKXocxafnfnVlPaUHX/uGuNh+W5SgKWhi1CZGsWfBP3Dw4Me0QdG8q1xq7gjWli1ePTs1mpAwW4FvWg/7tiA3J5nFa4Hm1WkVlgB7v2mP/zcZ7S78TvqczisHjHYCo/GNTU/3wpDn5BOhGer7OiNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qLTEdWL2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563cc707c7cso1882952a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708071675; x=1708676475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHQjCM3MJVOw9z8k4SHGf+NLiuXZ/198hcpHesrOvd0=;
        b=qLTEdWL20yhzYw2xKZlYoRiugT/xod3sb4H3NkxRm+AISOyY6fzKZrlwRaSxp8WSby
         NovXtneJhWHlxzr/RZgaalYZcaRfS7wN0qLll+7Ncj7KclX/nMI2qTRwAqRHi1SaLUox
         aow/ulXMR84VY01oVOXxf7bqEbTjxW9sPsITBI2CYdLcbQFKUy5Jis0tSNT/iYgi+MFJ
         OLz6Asf+yJcHjOVEHPJy58Skf7DKnjQmtQ+mwtJvWecWZREnZpdZPRNbHo7cJHlGY1Bc
         HFiLzMU65qPxgT9s09J5sEDmELNW9lXScSdetwB/vM130yBmXjx4r6gWug5UBarqJhJt
         5xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071675; x=1708676475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHQjCM3MJVOw9z8k4SHGf+NLiuXZ/198hcpHesrOvd0=;
        b=j2GEwsA/F/XjeyY8FXvUFp+Y1zeQ4uqBI99j4AxYHTta5SpLY8sMzWmYQj2urtrSHS
         eIu5CYhJm+fud9PkXfg6+g7AXRJgl/W2k/9VzHNEXnPh0AJcS2ZUblt0jwF4O7ZmsUEA
         KGsPLvArAG6mbc7dKbZV3GAeikKxD3QTrt721VrpAcdYglVov6G/tvs8PkRz7QOVFnMD
         XSqnByiOZPWxULtFe/ooO9vfKDtp3xlNCQrlWYEZY9WQ2Ye3Zno+2QAaAU5VouHP1Zye
         AH0a8a/XAaEIkLD2Syjm31GJUvLsLwNZ6hdoGiEO5GLDRoIScHOgQ2pbG9sQzZ73p8Mn
         e2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwaJ4oF/QmuderWBBkZPcXj95AB1ZYs1YqX4rdYEIQhKc+HlnF7HIVj7IS/mUCz3SQrD7e+HbLH46z4Cjbb8lOelyUnePpAdH013Kp
X-Gm-Message-State: AOJu0Yx3+N0Vmh39PqRcsN1FMdJHhPFmC5//NbW8brgbPATpwyqjmT3q
	fmDQsXcihHFi5H52BtD8m9cd7I877SOO1ht8S97WiD77sKwwaZGFThWoAdT3Tj4=
X-Google-Smtp-Source: AGHT+IH1Jfr/rQ1P5UV32a4Ha00bRrmflv3srEDsiA+9qsOqq+vnNMHgHuIPfy/dNY4jLcDdbsJGoQ==
X-Received: by 2002:a05:6402:500f:b0:561:fc2:bec0 with SMTP id p15-20020a056402500f00b005610fc2bec0mr7425286eda.4.1708071675397;
        Fri, 16 Feb 2024 00:21:15 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c0d6000000b0055f0b3ec5d8sm1287138edp.36.2024.02.16.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:21:14 -0800 (PST)
Message-ID: <36450b1e-7a80-4d6b-9046-9a57b7c845e2@linaro.org>
Date: Fri, 16 Feb 2024 09:21:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: mmc: dw-mshc-hi3798cv200: rename to
 dw-mshc-histb
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
 <20240216-b4-mmc-hi3798mv200-v1-3-7d46db845ae6@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-3-7d46db845ae6@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Add binding for Hi3798MV200 DWMMC specific extension.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  ...hi3798cv200-dw-mshc.yaml => histb-dw-mshc.yaml} | 60 +++++++++++++++++++---
>  1 file changed, 52 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> similarity index 57%
> rename from Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
> rename to Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> index 5db99cd94b90..d2f5b7bb7a58 100644
> --- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
> @@ -1,11 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
> +$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#

Really, one wrong filename into another...

>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title:
> -  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
> +  Hisilicon HiSTB SoCs specific extensions to the Synopsys DWMMC controller
>  
>  maintainers:
>    - Yang Xiwen <forbidden405@outlook.com>
> @@ -14,16 +14,14 @@ description:
>    The Synopsys designware mobile storage host controller is used to interface
>    a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>    differences between the core Synopsys dw mshc controller properties described
> -  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
> -  specific extensions to the Synopsys Designware Mobile Storage Host Controller.

Just drop this sentence in previous/conversion patch. It's useless.

> -
> -allOf:
> -  - $ref: synopsys-dw-mshc-common.yaml#

Put it in correct place in the first time. Don't needlessly shuffle the
code right after previous patch.


> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon HiSTB specific
> +  extensions to the Synopsys Designware Mobile Storage Host Controller.
>  
>  properties:
>    compatible:
>      enum:
>        - hisilicon,hi3798cv200-dw-mshc
> +      - hisilicon,hi3798mv200-dw-mshc
>  
>    reg:
>      maxItems: 1
> @@ -48,6 +46,12 @@ properties:
>        control the clock phases, "ciu-sample" is required for tuning
>        high speed modes.
>  
> +  hisilicon,sap-dll-reg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle points to the sample delay-locked-loop(DLL)
> +      syscon node, used for tuning.

Does hi3798cv200 have it?

> +
>  required:
>    - compatible
>    - reg
> @@ -55,13 +59,25 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: hisilicon,hi3798mv200-dw-mshc
> +    then:
> +      required:
> +        - hisilicon,sap-dll-reg
> +
>  unevaluatedProperties: false
>  
>  examples:
>    - |
>      #include <dt-bindings/clock/histb-clock.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    emmc: mmc@9830000 {
> +    mmc@9830000 {

???

>        compatible = "hisilicon,hi3798cv200-dw-mshc";
>        reg = <0x9830000 0x10000>;
>        interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> @@ -84,3 +100,31 @@ examples:
>        bus-width = <8>;
>        status = "okay";
>      };
> +  - |
> +    #include <dt-bindings/clock/histb-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@9830000 {
> +      compatible = "hisilicon,hi3798mv200-dw-mshc";

No need for new example.

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
> +      pinctrl-0 = <&emmc_pins>;
> +      fifo-depth = <256>;
> +      clock-frequency = <50000000>;
> +      max-frequency = <150000000>;
> +      cap-mmc-highspeed;
> +      mmc-ddr-1_8v;
> +      mmc-hs200-1_8v;
> +      mmc-hs400-1_8v;
> +      non-removable;
> +      bus-width = <8>;
> +      hisilicon,sap-dll-reg = <&emmc_sap_dll_reg>;
> +      status = "okay";

No, really...

> +    };
> 

Best regards,
Krzysztof


