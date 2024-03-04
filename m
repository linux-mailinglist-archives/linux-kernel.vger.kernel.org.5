Return-Path: <linux-kernel+bounces-90442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A681F86FF38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE7C1C21347
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E736B1E;
	Mon,  4 Mar 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrAEHXon"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144E36B04
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548806; cv=none; b=sDnHWvVw5WtD0KMBZcovBeejBz7Ayr+X+uPdgBczBBakv/Kg9H2uqpUFbVtNgaKwBx/41tJW75RuzI06HC9o5l8mW9BMRw9KHiqVjKRCDY4LrD4iy6vJ/5F4IOMTZQN+RC5aobA+zIX+/UzyUlV25/X3hh+n3qpSGwSFD0s0X4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548806; c=relaxed/simple;
	bh=1QpDL7otKaLVRfvpxBnWM75rS6/RsB/zuNBPtPTxMoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcqEgf/Z5jsJodfVhiJtWLxPyre2mkKUFq1j9uAlm0GnVoD+NPFx9j2MKuw/TSYJOsscHI+cKGo0eSBh6tKPzmDfWD/ypcyDIMmkWiPAYDdEsXZ0y/FYhtPgAe1uyLetFBDGrJGKlv8cx4R3qPogi4zwJFazJxsqDigYxuCjEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrAEHXon; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d27184197cso58794901fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709548803; x=1710153603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9/tP/ZbC0JsITFItqvv/KxYTeSI+hdxPkuzSwYAtNM=;
        b=CrAEHXonv9u/E+bmwuo6b+6G16H7UbnRbH3VPQOm0Yoo5jziLuaPcvADIlkreP59RZ
         Z/PdWhv4bJAvZ6gQ0N8q+uKk/Nd6acnLc/7gCLHnX7rS2gP5Sm0Ti3OCAu9bJ7JtWnG6
         D4E6HNb5PbVOhJ7wqG27heDjr89ec8t4iHe+ZWaqlQ4IEdXTmhsHxR0Y4YqsIda73VI4
         YUzqLU0YAaUZlAI5DfSqAW8LpOWuTCHOVp+YNYi3AlvNnSGiE4a4YrZLIGQaRMAKTMyH
         6qtqEKNPnqY8RKexSRiUtFw39K99ELr88SBEgm4GaNU9tdIngYpEiPRoJLq2Dk5dmu47
         d7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548803; x=1710153603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9/tP/ZbC0JsITFItqvv/KxYTeSI+hdxPkuzSwYAtNM=;
        b=ijnwYKf5mBeC9cTuVzxQvOOe9wXB8fUodY5WD9xew/oN9v8rLHdSCwP0EG9Hxb/0iy
         jumV2Yd2vtiKe8WzzwkM+ZJQGQXHBK/cdW9Ebs3rF10wqfVewlxuNdG6HvFLnNJeVDyN
         hxRbJFwb9GuFD7Y0UpiWVlszEn0YgBtJOvBo8QynPPTMH97ltlNP763F2xfHObG2jCcJ
         bkliimE/X0MN1i7jLZww3ogEbIpzH7K74E/k9Hkb8ukoxziSCFmikz4hni0vaoN0j0tT
         tnWw38FJaG0izsrgtASmg/je3JbDgLYH5Ga+pNOEP8a1UwcfYn7212y6LJ+Gepa15JzZ
         ZXbg==
X-Forwarded-Encrypted: i=1; AJvYcCUfxwLXb9QqR88v3xsD5f+Cb5MOEPA1ODBZroURZfmMMR5kI4d06fbfavu2uTSjXcXt5oX/XQjpr3L3aIb4QkrTM8RU/mXzDl9TW37I
X-Gm-Message-State: AOJu0YxhiDTNFoDCTKaleRHtpsogxWKbbCjO49L/I0ipXiecsJLP+lh2
	L80jLpcvBh8xMTYtNFkchdYl3q/CRzNrEOjvHRSfWcGE58jTiK4mPc2VrqItQS4=
X-Google-Smtp-Source: AGHT+IHy2hD7I8n57uZ/ZLTPk4mOw39Pr9Mxe+/s9Lm4AJxmZpTlPtP8zpuXOrVna1EzdyQwmIaOcA==
X-Received: by 2002:a2e:3801:0:b0:2d2:a9f8:c436 with SMTP id f1-20020a2e3801000000b002d2a9f8c436mr4984250lja.53.1709548802698;
        Mon, 04 Mar 2024 02:40:02 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b0041228b2e179sm14216843wmb.39.2024.03.04.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:40:02 -0800 (PST)
Date: Mon, 4 Mar 2024 10:40:00 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] backlight: gpio: Simplify with dev_err_probe()
Message-ID: <20240304104000.GA102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:38AM +0100, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/video/backlight/gpio_backlight.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index d28c30b2a35d..9f960f853b6e 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	def_value = device_property_read_bool(dev, "default-on");
>
>  	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> -	if (IS_ERR(gbl->gpiod)) {
> -		ret = PTR_ERR(gbl->gpiod);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Error: The gpios parameter is missing or invalid.\n");
> -		return ret;
> -	}
> +	if (IS_ERR(gbl->gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
> +				     "Error: The gpios parameter is missing or invalid.\n");

The "Error: " should be removed from the string. dev_err_probe() already prints
that.


Daniel.

