Return-Path: <linux-kernel+bounces-130385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25858897761
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EE01F3269B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD415444A;
	Wed,  3 Apr 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYiUckUz"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB7154429
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165879; cv=none; b=Rb0OSvm7loVr2juOCsu1Tq3aXvNUiKvVaGZJptyzeN6iX8OcwterDGXWIBX8l+suggvKJw6mvbuqE7cNb459nzjghv/gYfE2YnH7CsgGNzmn99T/Y939ooXfReMzAClOpkllmz84Wn6yNMqgzbkIkKWXwRNX6Ymc9v6lw2mm/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165879; c=relaxed/simple;
	bh=ra9udlrsP1LZeqsTZuzFHjBE/Jhohg/y6A5nl4xoNrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9RU2eth2SrC8jM8NBha7y6c0mZOo145OwQ/uTVIZXZ9gLp4vLKOltgjE2tYQrxbclnAACkHmvx64Y/z//yWxJDN9Cfv/Btc0tKkh1xIBPBDT5X2egMmWBMQmkSjSlSClB6ixYWjGlslzC7yn9ZHMbkYSQ67DMSGr9YeMqpR0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYiUckUz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45f257b81fso19023966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712165876; x=1712770676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LxoI1opATw8Rb6R6z0Sf//pYUFJC5qhTSpe8fxqLo9Y=;
        b=RYiUckUztvA0gPGFWfcSlMXLad8JdXLrJ0TQLB+F2KOEYffRzOspq+KKTjo2XZXGi3
         KZVsY9BOeEnumTI5bzSzGDOUutu1b40NmL+UIcA/F7cjCU+skLNFaShjEJKkEKgBhpPy
         y7ej+2AsiXk348T3ptiNOS5eQt09UWQqidq07CfSrMkro/qPeYkvdYiX03+yUE3S+7s+
         J6cisHjTaiBFlPbTZdgBl9x8ZePkCDOh9+euIbyJgz75cDCDkDXZ00taTF+XN5W28oJd
         Wq72k6SwedbX81we/hDbF+Wz4rAU9X6Wehm5GwfCVhU/27pIfHPskU0I05No79hkGnLO
         37+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712165876; x=1712770676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxoI1opATw8Rb6R6z0Sf//pYUFJC5qhTSpe8fxqLo9Y=;
        b=EvutTkZxSasXbx6NyIMBxfUUg6JRoCP+ffEIvGjzvXEmzB7ni7gtbGbioFlyuHoJNM
         Q96cKe0BKtKeXl6X3nMhTLetFoXSJO6B2+VUGqUR+64uz6Ucq+EWES3Z8LYlMxIWkOq+
         R40Ll43ZsxN2v9edk+PmXNEdnbEzhKGrCDnZPBQ5rCbRpi8VuZY9FadSFBlg9H34YC6W
         sRA24UovOwzbskczb9aOnoHhA1WXFqx2GtOjnx4lJYP8Yc8fz7RFevLE9F3c9Ok/RKAh
         zO0sfye0mA5s8NDkCOzCZbVpKZHjR2oMYmVHLi32AxdM+wGgivHejJ4d5ZBQXq1UNaU9
         zUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/lKY4SnVJe/OjZ6n72V78RdAaM+cjZCeqfvjP47rvNPMY5f/B9kiJ2Gx6bhcGKqrBhS1Ew+y+HWaJx/vWTq2dPuPUYsvQGd2tFVah
X-Gm-Message-State: AOJu0YwBFfa1PURpITKzZ1qHAqEQ5GJ0hYirUaolw4aCjwZFQRJubnSA
	prdEOYMQHsu0333qjPSI2SqB2AyzE10wKin0J4khFbvuRB7okX3cD9NGJHSRwv0=
X-Google-Smtp-Source: AGHT+IETxUK21A0KsNzK9uV4jSaqPiHsT4Z04ne4/mLarpl+PLnigTZaYl1e7uHL+dwx5qwbEwnH9Q==
X-Received: by 2002:a17:906:a57:b0:a4f:c80c:1b69 with SMTP id x23-20020a1709060a5700b00a4fc80c1b69mr17634ejf.8.1712165875715;
        Wed, 03 Apr 2024 10:37:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ay12-20020a170906d28c00b00a46a9c38b16sm7954412ejb.138.2024.04.03.10.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 10:37:55 -0700 (PDT)
Message-ID: <10f02618-f16c-47d4-a27f-074b1ecffaa1@linaro.org>
Date: Wed, 3 Apr 2024 19:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add basic support for LG G4 (H815)
To: Alexander Reimelt <alexander.reimelt@posteo.de>, andersson@kernel.org,
 pvorel@suse.cz, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240403104415.30636-3-alexander.reimelt@posteo.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240403104415.30636-3-alexander.reimelt@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 12:43, Alexander Reimelt wrote:
> To make it easier for downstream projects and avoid duplication of work.
> Makes the device bootable and enables all buttons, most regulators, hall sensor, eMMC and SD-Card.
> 
> Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts | 422 +++++++++++++++++++
>  2 files changed, 423 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..5b7f8741006f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-h815.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-xiaomi-libra.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-huawei-angler-rev-101.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> new file mode 100644
> index 000000000000..b7fa48337e25
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * MSM8992 LG G4 (h815) device tree.
> + *
> + * Copyright (c) 2024, Alexander Reimelt <alexander.reimelt@posteo.de>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8992.dtsi"
> +#include "pm8994.dtsi"
> +#include "pmi8994.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/* different mapping */
> +/delete-node/ &cont_splash_mem;
> +
> +/* disabled downstream */
> +/delete-node/ &dfps_data_mem;
> +
> +&CPU0 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU1 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU2 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU3 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU4 {
> +	enable-method = "spin-table";
> +};
> +
> +&CPU5 {
> +	enable-method = "spin-table";
> +};

That's wrong order. Top level nodes goes after node deletions. Please
observe DTS coding style.

> +
> +/ {
> +	model = "LG G4 (International)";
> +	compatible = "lg,h815", "qcom,msm8992";
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <251 0>;
> +	qcom,pmic-id = <0x10009 0x1000a 0x00 0x00>;
> +	qcom,board-id = <0xb64 0>;
> +
> +	/* psci is broken */
> +	/delete-node/ psci;
> +
> +	chosen {
> +		bootargs = "earlycon=tty0 console=tty0";

Drop

> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		spin-table@6000000 {
> +			reg = <0 0x6000000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		ramoops@ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xff00000 0x0 0x100000>;
> +			console-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			record-size = <0x10000>;
> +			ecc-size = <0x10>;
> +		};
> +
> +		cont_splash_mem: fb@3400000 {
> +			compatible = "framebuffer";
> +			reg = <0 0x3400000 0 0xc00000>;
> +			no-map;
> +		};
> +
> +		crash_fb_mem: crash_fb@4000000 {

No undercores in node names. Please open DTS coding style and follow it.

...

> +
> +&pm8994_resin {
> +	status = "okay";

status is the last property.



Best regards,
Krzysztof


