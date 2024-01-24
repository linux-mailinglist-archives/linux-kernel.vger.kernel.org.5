Return-Path: <linux-kernel+bounces-36640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3028883A43F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C062B1F2849A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966317755;
	Wed, 24 Jan 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="krn/OveB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1468175BF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085511; cv=none; b=cETRDUwnGJQ2nA0oWMr7aRHcr6w3MhaP3YWiKpRGZHZSMQOYRRse7ysEudd0D87raChEodst3AH/MWuvELDAt3++KbdYZMDYqEkgMOOn44UT927iZuUdxUpNEvG3OwJ+ntSEOPYkWiKN2f6OnqxS2AqnLeX/dsh3AYg2B+2BuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085511; c=relaxed/simple;
	bh=jlz6yDARmYRfIwcJEftzYZRs+rGjhCsFQhkX+BsxAu4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ACJoJf1//7/pRuHO5SDO9wkbPuaZCD5z3q5JbzfDpFZnVHlihv3UgYoEuWUunmVD2bH/n9Xvo73v2O3bDGDMe2hzBm3fQ27jFOhKUQNUY9z0311hoSOLU6DIcZmJL6TjUnGazxXc7UZ+exZVaF9ZwWIN40BOzfibVc3ZOIOfZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=krn/OveB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337d5480a6aso4916027f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706085507; x=1706690307; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=h1FUWfiTuw8iaOnUVAaUBuSlg9Mxe6vb31eu30jmGPc=;
        b=krn/OveBgwleslyeOJOyOKtmVAp4dAQsEM5wZawFiBK5IPvQW57QAd+7dcwE96kJKN
         HbOsxi8SWTGY+61VE2s3PeteyevJKeyupkzERqr8sCHIJNQB39zTM7tySOXKbMp6lY5W
         4bZo3t5Z1axLrnTzVc13n9QDvS38kdwig3gO5r/qPcdbSxLRl/lBc6z2Fk2Pf3wB9tzG
         Y4glRu6mVW1cVa0Gg42LctbGJ57p/JGP82FH6h6aSPSeQzoD5DR0lIts2BOgOS+IvGOf
         7wzbXaxc+S7GF4eeDdLM2nrtK1xWz9hEiKZRWb5HIj3it7rpQMO0zSf0B655TkJOMErr
         SmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085507; x=1706690307;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1FUWfiTuw8iaOnUVAaUBuSlg9Mxe6vb31eu30jmGPc=;
        b=YtW6VByWjT9VKTXXy3po2BcI+AEGiMwFaa3BwNmQEGDCejhAIku1NYEJpyt3IZjPHM
         5ZsxanfZfLg3/NVlZ7RgK9LNNs+/2p1d6sVh2kox6Qr3c0l+0TheQ9cEyPI3/QJBkEyg
         vQnJA7PpeZNVENYKgUuBtQ7KNR0RnSJGn3sjBEmqD//eYNi7KuNzAcWPAiBxFfgo4IDg
         JQB8ZFkjrSgcY68TStHPgmepu4SExqayTsEz8TUv2jTA1AwnHTFI/RZOUUi4C2TVK+k7
         sIL+uAyeRbslg3DDeYQhX78pE9CUbVVvDjQKCRh1L2QVGMGVPpfoQPYlWXDtQgmaQ1tX
         ZK1A==
X-Gm-Message-State: AOJu0YysyBxwFgvzqHy86pT6ezIbYiFNW/cfmgzB+DOTjUBj49ab0t6X
	epNhYHUKI+kx1O+Eb+zxidIOI3RzdVfMQ76z9FrT1KNNOZ8GvI3LYa8C88SGbmQ=
X-Google-Smtp-Source: AGHT+IHWDnX0w1SzsoI8DA0xPySEzo5xJtqS7XZt2YHYZTHRfUc5D0hbaLhIUuqtBbzsb1EykQ2hjw==
X-Received: by 2002:a5d:6d52:0:b0:337:bcec:d45e with SMTP id k18-20020a5d6d52000000b00337bcecd45emr300741wri.35.1706085507028;
        Wed, 24 Jan 2024 00:38:27 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d8b6:17b6:386f:c67b])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033947d7651asm2936415wrb.5.2024.01.24.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:38:26 -0800 (PST)
References: <20240123165831.970023-1-avromanov@salutedevices.com>
 <20240123165831.970023-3-avromanov@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-crypto@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@salutedevices.com
Subject: Re: [PATCH v2 02/20] drivers: crypto: meson: make CLK controller
 optional
Date: Wed, 24 Jan 2024 09:28:00 +0100
In-reply-to: <20240123165831.970023-3-avromanov@salutedevices.com>
Message-ID: <1j34unxh1a.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 23 Jan 2024 at 19:58, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Not all Amlogic SoC's uses CLK controller.

That's fairly short description and very likely to be wrong.

Of all the SoCs I have seen mentionned in the bindings, they all have clock
"controllers"

I'd assume you meant "this crypto ip does not take a clock input on some
SoCs", correct ?

If that is what you mean, giving the list of the SoCs which - according
to you - do or don't take a clock ip input would be helpful.

>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-core.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 35ec64df5b3a..a58644be76e9 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -263,16 +263,10 @@ static int meson_crypto_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
>  		return err;
>  	}
> -	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
> +	mc->busclk = devm_clk_get_optional_enabled(&pdev->dev, "blkmv");

Assuming some SoC actually don't have an input clock (I'm not
convinced), the clock still ain't optional for the ones which do.

Use the compatible to properly claim the ressource (or not) 

>  	if (IS_ERR(mc->busclk)) {
>  		err = PTR_ERR(mc->busclk);
> -		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(mc->busclk);
> -	if (err != 0) {
> -		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
> +		dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
>  		return err;
>  	}
>  
> @@ -300,7 +294,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>  	meson_unregister_algs(mc);
>  error_flow:
>  	meson_free_chanlist(mc, mc->flow_cnt - 1);
> -	clk_disable_unprepare(mc->busclk);
>  	return err;
>  }


-- 
Jerome

