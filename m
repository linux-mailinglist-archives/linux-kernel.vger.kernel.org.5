Return-Path: <linux-kernel+bounces-10449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1481D485
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94494282D46
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1CDF4E;
	Sat, 23 Dec 2023 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZ/J7zce"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D0BDDC4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2699ee30d1so224711966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703341163; x=1703945963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83VtYImUtbPprS2K355dwHQVBUydhmcdDS9Z8jHn5I8=;
        b=sZ/J7zcexRtLtOte5OLOCKZAZGmst2GbgqUKxLg3hjz8+4PkI75HyxuQDVxm0WYgkp
         y/n/crYcPo8oqBOW6HDyqjpR/EUpBSsmzbQWn53JjhEv9ZyX2TdGzBCTJGCt6aeR6Cfd
         5zp2UdOGMnfz871XX8Bwk1HunSh07Xu2fHC0UErGc1Fpo65UQyanQ4YF2YwLZWFctT2/
         WAK1iXITd+PMhn/G/yQK8cyzI36xLbF7NfpayInHvrF0ZgZEWApoOTvTmLJ/ld0PJVPu
         bBu6rYwY6LUADYtMECRDRWMpz56b4apDJnv5mnyHni1H259yFR9NKomeOqd0i5ScanhV
         L/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703341163; x=1703945963;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83VtYImUtbPprS2K355dwHQVBUydhmcdDS9Z8jHn5I8=;
        b=fTUPjRdzu+ioq75+UBCtzxU4E5g/NW+avL2EvmIwxkZFqAAqiw3/j9QTQorbjFA8O/
         8GzvEIIwzGYtwBNZ8Yx5B9oB0O1FRmGHaDh4pkit05QKi2wlpzZYJLETMIv5/bBrktNa
         9vTXP2RUQNP8k3qF9i9+3CkJWl9zbwT/uHMdT7Siun/CZT+2WtQhBZq4norZUgL04rMP
         WsJMiog7YBRhQHMPp2lYX+ak05HSg0zxgj9J4wskgsNUzhZmgEXBWDScYaKRQua1aXKC
         ZXcPR8pw+0g2jd083JCLrv62EHIzzh5QyBi783k73UAmgvdzZD6si6cfgLWsJpHgPIVs
         6jVA==
X-Gm-Message-State: AOJu0YwTZ/NMmzNP/JaytIKkCf63hT62GoCghfZeoE6+bmDbObd3I1sR
	I9miFBggmi5x0QbK7+FLjmKd6BPe4KLvyA==
X-Google-Smtp-Source: AGHT+IGfbQxqYxDleKPo1JkM1gC0P65e6rtPrpGvV3iE3dGUd5YqFYf2CYNI7WVOGVkDqPdAU79OeA==
X-Received: by 2002:a17:907:50a0:b0:a18:4b1b:9522 with SMTP id fv32-20020a17090750a000b00a184b1b9522mr1338999ejc.41.1703341163208;
        Sat, 23 Dec 2023 06:19:23 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id ge21-20020a170907909500b00a18c2737203sm3100498ejb.109.2023.12.23.06.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:19:22 -0800 (PST)
Message-ID: <2a44fe91-b4a5-4842-8abc-f30c532f14e0@linaro.org>
Date: Sat, 23 Dec 2023 15:19:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Content-Language: en-US
To: Tzuyi Chang <tychang@realtek.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231222075812.6540-1-tychang@realtek.com>
 <20231222075812.6540-3-tychang@realtek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231222075812.6540-3-tychang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2023 08:58, Tzuyi Chang wrote:
> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---


...

> +static int rtd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct rtd_gpio *data = gpiochip_get_data(gc);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	u32 mask = BIT(hwirq % 32);
> +	unsigned long flags;
> +	int dp_reg_offset;
> +	bool polarity;
> +	u32 val;
> +
> +	dp_reg_offset = rtd_gpio_dp_offset(data, hwirq);
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		polarity = 1;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		polarity = 0;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		polarity = 1;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	raw_spin_lock_irqsave(&data->lock, flags);

Why are you using raw spinlock? This question applies to entire driver.

> +
> +	val = readl_relaxed(data->base + dp_reg_offset);
> +	if (polarity)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +	writel_relaxed(val, data->base + dp_reg_offset);
> +
> +	raw_spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}

...

}
> +
> +module_init(rtd_gpio_init);
> +
> +static void __exit rtd_gpio_exit(void)
> +{
> +	platform_driver_unregister(&rtd_gpio_platform_driver);
> +}
> +module_exit(rtd_gpio_exit);

Why not using module_platform_driver?

Best regards,
Krzysztof


