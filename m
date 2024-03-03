Return-Path: <linux-kernel+bounces-89720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E286F4AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D12F1F2185B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B6BE6B;
	Sun,  3 Mar 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZdc1srT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE1BE4A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467442; cv=none; b=Ca8EimKBt3bKa3/tA4welab9I7Fho8SlWQLteDTmBO5SKWgr9QIJa0MzS7WoX/kIh+dY6FGOV3/2HH1tLiLuSBgrlyhazeO0ZJqJKEQkqFpMvF2U6wdVedjNEOJTdNuTi5OL1BNyKCx4POT+M1Jp9Bxvho80e/Qj6INUXmRVcZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467442; c=relaxed/simple;
	bh=oPXSk/YxU1QIPz3f+1SftqYNzi1kMy8lY2qsKcTPLNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbKlDGvfYpdP+Qm5gMnlu6jjyw6oSw17GGQJN7GOITofczndAMTVYJaSRuPHSClhYNeEMBKlCreaMvtYGnvqS9ULVhv2olKX8LaO4QluaXRYyCYNCTuOZivTZT33ZVGKpF0wuX7npF2evyM/GLN4J6CJSEt2dQAMEjwOm/H0Rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZdc1srT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso862564266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709467439; x=1710072239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3U70A99f5HFVcKmyUTH22KHtdQlBYgBoI/eOiSa2c=;
        b=RZdc1srTIzBm+BU8z7zJ+33xDE6T0kA2neWh4nXUi035KyG0wWyuRxocdfKmrtlUOh
         xx0u7B9PiuGz+82OuAeWpXxI3H9lga9VTEfNp5HJ6XdzE6/hnK003yfO8oW7lRchSwzC
         51HwnM/c2Qoww+tFCmbkYWTlAwA4r1YhdW5/IKdk+mtF9u6RwLuV/ynyoLVxoBQs8b8L
         sL85ToMkJ1omwljnEhLp6kEVK4omsxffNvh4UFGKa20Zqgo52LenkzUu0KN3wsNVfq+1
         R+6pqomIZ5Jesj5FZZZr6+OR7qrIOqOPQj54GGZU4D7tUbzOnQGlOhqEGTDmHWsscmpi
         CbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709467439; x=1710072239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3U70A99f5HFVcKmyUTH22KHtdQlBYgBoI/eOiSa2c=;
        b=qJ2RBTWemQjWLaKjKU09Y7lSR4fhot/HxrQ3S1vuEX0ub+e5cYQXc4Wb9ArljbgKAR
         69Y6o1ixPHMtVsNxVMRaLLbHgFB6OTFS5BxKDEY03EZMkp3Tvf250h1VM8ohk7G5t4id
         ACf7mPnLBwUfTbehcNadhe7VLU8hM9/kd1+P2qHUxJ+mLS9b78Zr8eeUhiZ4aJ+avCpr
         dTkVSo2X00IXc8o1bd1WkrXFe1CObgpdd5L6j0lOheIv0QLpdD1wq8vYnDj9h/PvYBKg
         MJ62T8yukJJS6c1P96veJj4qvUQFpwutTb+S1SqaQ+k9YhYUSHxbY4yafQkZOMmWrWpO
         OLTg==
X-Forwarded-Encrypted: i=1; AJvYcCUp600xK+JwJBnSw0QVFCGaB5Rby6+Se6gx2YnPB+U9/8frywc6VW9aQMVlAoDNyYb3PCO6E8QBnWca76qrG0qv89wwXlAtolz4OSR2
X-Gm-Message-State: AOJu0YyrtrjmBaYMel9QUC+3z9hxJwkQz+BusZoTd8ru0EATUBZztehQ
	8xFaN35DVtvEwjm806fKQgnCzypb3zSFTwUUAByp7sc2IzxrP3+aMz1j5bD8yIU=
X-Google-Smtp-Source: AGHT+IFWR/nXu1pgKsznuU346uBOJfm39XaoOATJ7iWJ2v6/8StwzLe8UPwoC5LHxCcyem3dj/F5uw==
X-Received: by 2002:a17:906:f6d7:b0:a3f:c3f0:69bf with SMTP id jo23-20020a170906f6d700b00a3fc3f069bfmr5945044ejb.13.1709467439042;
        Sun, 03 Mar 2024 04:03:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id oy29-20020a170907105d00b00a43fe57b2basm3628120ejb.61.2024.03.03.04.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:03:58 -0800 (PST)
Message-ID: <86387c8d-35f2-4715-86a2-3aff571c3dd8@linaro.org>
Date: Sun, 3 Mar 2024 13:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Content-Language: en-US
To: Supreeth Venkatesh <supreeth.venkatesh@amd.com>, joel@jms.id.au,
 andrew@aj.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org
References: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 23:22, Supreeth Venkatesh wrote:
> Add initial device tree and makefile updates for
> AMD Onyx platform.
> 
> AMD Onyx platform is an AMD customer reference board with an Aspeed
> ast2600 BMC manufactured by AMD.
> It describes I2C devices, UARTs, MAC, FMC, etc.
> present on AMD Onyx platform.
> 
> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> ---
> Changes since v1:
> * Incorporate review comments

I don't see how did you resolve checkpatch warning.

> * Update commit message
> * Remove vmalloc and earlyprintk
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |  1 +
>  .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 94 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index fb9cc95f1b60..2b27d377aae2 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-amd-daytonax.dtb \
>  	aspeed-bmc-amd-ethanolx.dtb \
> +	aspeed-bmc-amd-onyx.dtb \
>  	aspeed-bmc-ampere-mtjade.dtb \
>  	aspeed-bmc-ampere-mtmitchell.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> new file mode 100644
> index 000000000000..1831b8d18db2
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2021 - 2024 AMD Inc.
> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "AMD Onyx BMC";
> +	compatible = "amd,onyx-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

Again: drop, not needed. You ignored my comment. Use stdout path.

This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof


