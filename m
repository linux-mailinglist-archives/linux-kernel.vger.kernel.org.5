Return-Path: <linux-kernel+bounces-166063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA58B9569
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9A81F223E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763B22EF2;
	Thu,  2 May 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEvfHznr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2202209F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635675; cv=none; b=DEh9hVIZiDiLO6IUYtbiNIXO6RE4OF0w394ID4Repir948P0nXMZP2ITF5IKcC9zjLHKRCW486CJDRG3Ix86fWBeEaQwOMRY5tvowdir6BVPhZEEQwz47wroumEZcGepF4IhCJ9ZatUheLiqtUIpUM0QS9Se1rsYNxBBNNS6X08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635675; c=relaxed/simple;
	bh=zABtKC+Rtoh7jI4D99cudXvLlTLkH2cSA0Kfdm54lQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRmMDoXUgsU92DxlhdlbU6GOyWWhq5L5ZaPDekkRNSX4dGYffSggRRrejFQcc9zGnAWj2xPulAntwInEir+cvnGsGqADAAqxstkwx1D+J2hOU5LNtWX6WOb1E+vrQpdK6FZtJFYPfEGylZRGNlUJ4b4284MATjwKKFaaUZ6yil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEvfHznr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso267075566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714635672; x=1715240472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Q2C006YjdfPOCf5/2sNCH0MuBR/EBBXkcEnDcvy0KM=;
        b=hEvfHznrQGIHw6Oxw9hqIYbiE0jrtzkUrHvwH/Bs1QQfvC0tpoE7hK5Pp4h6u2jizY
         UGBQKK/ZOlrl898RWELZOVPaQBN/zjzx38781a7nhMKWN3z+dfRvr4DtuAZ6l2phrSvE
         G2hTa/TyNCIlGQKRhjNQ0onh33cjCSmczsv5V88S6RphNblHRL1i0PGASYUQSwcRQJSI
         OLQCERFG6re06EYXcEZRAMqBIYisN0lrKscrgpfqTHi/lE8juzLG37fh9raW2OIhBl2g
         FnWIJue+9lhbAr3hp4IvfVq8SzYCKKzfdThf++a/oHYvrc/lwqDaMUGnV1nlpGgBSwFn
         OVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635672; x=1715240472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q2C006YjdfPOCf5/2sNCH0MuBR/EBBXkcEnDcvy0KM=;
        b=qfP7DEOABy6mEfZRq7hxHA0CE/81yEocfUMhrdfHRCzDqjq9kRwQaHsSr7j28eC8LY
         OqYmZdCUbkNb963LkGH0tVyK94HzqBOgAyE0AL+qBqtc306miDhAL3unXk30NQ9DWm2Z
         myoGoLPlioUcsfQFgCXHJ7UF1h9Lzgq0j0SUwR7z4V4D4ptf0O3ldsZo1+TuAgGZiWzf
         wGQsUWe0qknXlIUGimTl7R0Mp5JslumS6lnG1cCJH9DeihJg26QUL+05DBfWHvSo9BKD
         zTk9p44dIoaILTevjHwXJtYPucplOQACP18gathjFxmuNC2U1aBnn5bHOA+FoxTaoqKa
         fsdw==
X-Forwarded-Encrypted: i=1; AJvYcCVye2eLSPrPY9t3tB2HIkLsfUK9a+CWmETeEtbIqDtHiFEAU4psbNbAQZlA7anTLbZbdOfWa1Rb8Hm4Yti2cOtygYjk+HhHyWz2hd4k
X-Gm-Message-State: AOJu0YzZiyEReySO4Q0REnC/fZ53UGlQeootfLQTkRpd9hNGb2vFG1hw
	0vdEUm4fWPdEeXM8MAEDvRxoBp8yP81PnHNJoajVBS+CmEF07BkAXihDhulON0g=
X-Google-Smtp-Source: AGHT+IFP6c4sujTOMTIqEmlCFgQb9BiI3UfyLMTVFf3tUx1jI6Xp+ozJDDd4kk44gM2ZM9XkX8ZcNg==
X-Received: by 2002:a17:907:7d94:b0:a59:5693:d709 with SMTP id oz20-20020a1709077d9400b00a595693d709mr1777751ejc.30.1714635671861;
        Thu, 02 May 2024 00:41:11 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.85.172])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906089a00b00a587868c5d2sm229664eje.195.2024.05.02.00.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:41:11 -0700 (PDT)
Message-ID: <ea6f17d7-49bf-4a1e-ba3b-757e29221590@linaro.org>
Date: Thu, 2 May 2024 08:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pinctrl: samsung: support a bus clock
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240426-samsung-pinctrl-busclock-v3-0-adb8664b8a7e@linaro.org>
 <20240426-samsung-pinctrl-busclock-v3-2-adb8664b8a7e@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240426-samsung-pinctrl-busclock-v3-2-adb8664b8a7e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, André!

On 4/26/24 14:25, André Draszik wrote:
> @@ -200,6 +235,14 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
>  	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
>  	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
>  
> +	ret = clk_enable(bank->drvdata->pclk);
> +	if (ret) {
> +		dev_err(bank->gpio_chip.parent,
> +			"unable to enable clock for configuring pin %s-%lu\n",
> +			bank->name, irqd->hwirq);
> +		return ret;

here we return an error
> +	}
> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  
>  	con = readl(bank->pctl_base + reg_con);
> @@ -209,6 +252,8 @@ static int exynos_irq_request_resources(struct irq_data *irqd)
>  
>  	raw_spin_unlock_irqrestore(&bank->slock, flags);
>  
> +	clk_disable(bank->drvdata->pclk);
> +
>  	return 0;
>  }
>  
> @@ -223,6 +268,13 @@ static void exynos_irq_release_resources(struct irq_data *irqd)
>  	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
>  	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
>  
> +	if (clk_enable(bank->drvdata->pclk)) {
> +		dev_err(bank->gpio_chip.parent,
> +			"unable to enable clock for deconfiguring pin %s-%lu\n",
> +			bank->name, irqd->hwirq);
> +		return;

but here we just print an error. I guess that for consistency reasons it
would be good to follow up with a patch and change the return types of
these methods and return the error too when the clock enable fails.

Cheers,
ta

