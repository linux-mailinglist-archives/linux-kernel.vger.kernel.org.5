Return-Path: <linux-kernel+bounces-131024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F3898217
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BCF287088
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DA5812B;
	Thu,  4 Apr 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N03qbChc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4EC1CD3F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215232; cv=none; b=Sbj3eG4UEiq77wqp4N8rjd9jzIgBMJEMv9FL8BnNVINlMt8bYifFAyn9qNpoUySmyXoxYhUvS04mclX85Hv2KhSyLlAlKwApaEanH+dwyYPb9jKE+oZ1jmeAqMoUKTFe8QZmHk9OA0SQCa21sQQSAZU5NFp4qHZAPsmTltSe1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215232; c=relaxed/simple;
	bh=dZ/LJzmIyKBBAugpjKDRIEBQXdbiUc+yi6wlw2Eq2aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0DWiRqYfeIlMCGgRN6qlva5uuJwZJF4+3EKWwqjFhXs56saGqdkHQuWK4eq6gD7xAvyouQvSXU4C091Ok9bAueS8ub4lhcCaE+la81rwXNXZR7FoxMoAtC10NP/ku9vdqGbO6WzgXgiJSUDz8a7YryTl8Jml+npO97K1Bv7gbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N03qbChc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e40fad4fdso80719666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712215229; x=1712820029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OgaBRRYm38Qfzq1LavdZ1TJFYqk4dhlgKQGGttrD9nM=;
        b=N03qbChcJzl3ykq1LRn3Q6wutxWKr1+zju2T5ilkbCy3Rflz/vOJWKFpP9gzkxGEkY
         JWigQ/emZmKm1sXFoOVrZLRJoLFlsILpfDlSd1+MWB9TXMR32V8b8IG/6eCw0QlIEWVI
         F6sEBtF96SUwMPXtSIWh2nQdEH+szIQIzkcqnvj149nmz3apIjv2WQ4YE5MtMabcIN7m
         v2G9Td6jSVsOLnGhPmM752NjaCHdap0rzfQIheL2tvNNoslM6cMbfHmvqiA+OowWw2dX
         JSZ9uA5fzsDb5ssEYQrRgrVX0aHUXiuebQ59OYtStltc24tvcLgSaz63aCbnLFXSoErg
         DY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215229; x=1712820029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgaBRRYm38Qfzq1LavdZ1TJFYqk4dhlgKQGGttrD9nM=;
        b=HptgJIEu3Ybe1MUXW69UIjjany08dEPP4U0J+tEKd9zZG5qeI8Qj39OVtf1QRtfJr9
         0PgnxVnqS5pNMN0ZxDlB08P5OENDc+c0gkRBwruBwaO8Ev+NnGzvkMNPyjRvd4K/8QaH
         W2+X2LA8r/VtZAXScst4+RS1aYBkxdgf4MkmqnUbq46OjwQ8la8qlcvD/5pH2sY+LDUq
         1QIhIgFGqdzvmjwr9BqCBVl1XTjO0Dp5ykte9rNppBNUZEvxNGQNLjbph0QaRHO61utP
         rMYUwl8tA2JENqM7j1oR7jqOOVvWI2C0sCgJgl4kDBiFxRFlSVtDCQC9XNr6NnVDldy5
         v+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyLSXL/jGQfUJ1BfUfq1cDBDltq33lzUP8kd+D0kGY6ab/mp683hd4pswV6WmgzmZpXZDDuWqnyUe9tFnXYhUjaNlAhov20dyaUs0W
X-Gm-Message-State: AOJu0YzUb/9FZF4/ez9pvgb+Lm/QyNfOgGmxkNQ2J/SPiLp9Hsf9OTXZ
	wgbOoligoWTKSKOrP67HMxhDj5nNBEyNZMU6K1k3mk/uo47f+a2UQmvfv4LUiRkwhKxiraz4WUm
	8
X-Google-Smtp-Source: AGHT+IHl0rGgS/mCzgzYRofFpn+QrHpDe+GqBD6Ys4LT2Ywyrlwb4JRyu6MPi2jR8akgovW2mqdwPA==
X-Received: by 2002:a17:906:3502:b0:a46:e8c1:11ac with SMTP id r2-20020a170906350200b00a46e8c111acmr833320eja.18.1712215229087;
        Thu, 04 Apr 2024 00:20:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dq4-20020a170907734400b00a4e2a09efcasm8126596ejc.217.2024.04.04.00.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:20:28 -0700 (PDT)
Message-ID: <0a21f8e8-f4a6-4311-ab35-a02a1a593629@linaro.org>
Date: Thu, 4 Apr 2024 09:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] usb: ohci-exynos: Use devm_clk_get_enabled()
 helpers
To: Anand Moon <linux.amoon@gmail.com>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-4-linux.amoon@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404071350.4242-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 09:13, Anand Moon wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: new changes in this series.
> ---
>  drivers/usb/host/ohci-exynos.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> index 20e26a474591..85d04ae0ae40 100644
> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -135,20 +135,15 @@ static int exynos_ohci_probe(struct platform_device *pdev)
>  
>  	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
>  	if (err)
> -		goto fail_clk;
> -
> -	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
> +		goto fail_io;
>  
> +	exynos_ohci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
>  	if (IS_ERR(exynos_ohci->clk)) {
> -		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> -		err = PTR_ERR(exynos_ohci->clk);
> -		goto fail_clk;
> +		usb_put_hcd(hcd);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ohci->clk),
> +				"Failed to get usbhost clock\n");

Why do you introduce entirely parallel exit paths? There is already
single error handling part with labels. Use that.



Best regards,
Krzysztof


