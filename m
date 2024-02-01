Return-Path: <linux-kernel+bounces-48969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E98463E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB10C1F2865A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E646420;
	Thu,  1 Feb 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHHpI8Qx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61041236;
	Thu,  1 Feb 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828310; cv=none; b=ii0xIErn07Fr3b5tyglqBAPA/7ityNH4jzNs5YJhUPjXONfGS5IDx9Ym8o5NLl6wkNmENAqZM2f+vkEon7+hsDgk9wNGSLlsLGUHSFnjXVeo+BAWYhtr6XsnAILpxdd7dROi6vyO/EGQnvHiFHr3Tfj2NUVqfFUnUR68i1yUBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828310; c=relaxed/simple;
	bh=Ok7/1hpZqqt0oRB/qzn82QRcwkZczxAxEI6YBNY06oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCtYZhpcdtXz8BnSkHrHeBFN2Jc4SSTxZUn2sCvEb0xB7eWav4BqmyAfrKx78cR87jz628ZNH9fSvMTC+RfS9oTCIqjlZcTTWPSoLPWij26EWBBCpivOyVtKqZNzsVBN7ebyNkSRKSX1uqOHCNZe8rtynb+zpj60d2tv1eAMRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHHpI8Qx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2893217e87.3;
        Thu, 01 Feb 2024 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706828307; x=1707433107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GMIIiMFIvN25g5ZJXxXmxO4MRIIG5RaYJv++uyfUQOU=;
        b=iHHpI8QxkOWgEi5ryDfXUAec96tK7LEBxIao0k3E5Z2gHaNNwk1/1jTf6VNbYbbBEv
         BEe/HkpY7VFaHyRRTnhPnE4975B5Xag+bv/prumTOjrokqzIBXdNtO5gDEERSFWrnjSN
         GlNzlgcovQIivDu6V7Pdi+6vJ21+AmEmL+mp4oxNfUebdVqjirQVBavrTjB9zZEoJsRq
         BWwDsgTiIv3XVACs5OOGqQYzWYvoQaLZiAYATgapzwBzwtf4PhX5jEWKmuzcc66WR/vo
         pKpbJ9somQsMwGZUASb3uFKNkPxEWyBvHhMAx9bMtpTT6DqX9gfDZTV920ry3Wt9xfpg
         9uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828307; x=1707433107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMIIiMFIvN25g5ZJXxXmxO4MRIIG5RaYJv++uyfUQOU=;
        b=OwSoeki1BR/lADqjXBbl0b+31TEvlcPcLfGdwzuBIzNirWDBTPcdD8VcuitH3iQsTU
         XFBfDp1KJ9EDzab0QzrSKzEQM8DLRfJSa9MJF9nyKJcvxqwdi/+JGSOv+/46uF3UwBn6
         cv53wB8rB1llc+CJRRVLifH0Cm67MthkbMfv0G9UhM8JrJHZ7tQu+q0gZ5NYO/CoSToB
         4DuWYkjh/U5XrpdUPbDLvCUWifbbvlBvDMx8WV9WdMUKL6RgxpLi8Ez65s50QPJI6ih9
         k9fN037pdZcFPC9xJ9nXLzYZ2d1HP02gME04hcIvETJQAZ0fzI0M7PwuOhOI1I6R1Bq9
         cvzA==
X-Gm-Message-State: AOJu0YwM0cp00bDUEYxRJh1vPQYnzzVKfTc0KIplnKroHWyT/c7ZuR08
	263mI1RmalPUCF5+UutHPYn5yh6jdLfnckVGm+xjVod80kcul7je
X-Google-Smtp-Source: AGHT+IF1Z5+fSqUwVBB84fVOZDy705a+DBWOrg7uIyRx6Z2Nn9cSVYX1Q6cVqBas+AYpCsfRqgAKUA==
X-Received: by 2002:ac2:554d:0:b0:510:3c1:52dc with SMTP id l13-20020ac2554d000000b0051003c152dcmr185355lfk.69.1706828306470;
        Thu, 01 Feb 2024 14:58:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMPsCbk9bNnuhiAjyBnKyasDiEfcpk0A2qNOAhJVEJgwBxo9pBec6dARPW3dYe1Y6P0UUSUGJvcsQ1Gb3u1kWFLT1mhJVoJT4/WNcRbHIUyGmRfFIyP8Zp6vsXFn8ZCR6n7yRCiEMtF20LTarH2GbJlfxRbHWfAVmzm1OVLI3lERXZOR9ndm+E0qJUfi3xcSYdkAaJn2AdjJm86noMx7Iv1WI4m6Fo+pAEuIvCG1dCkhf89i+i2QvQw4AW9vf5XgeUb/4+ZfaMhkEEJfbLMvII60AkErE9ABEFR6vbubY+lt2T9m8m06ZIpzlDzN4KgY6cXedcj38nI3ZtcXVswVWSTpRGWV8=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id gx23-20020a1709068a5700b00a365b3cba79sm233555ejc.186.2024.02.01.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:58:26 -0800 (PST)
Date: Fri, 2 Feb 2024 00:58:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/11] net: dsa: realtek: embed dsa_switch
 into realtek_priv
Message-ID: <20240201225824.hajwp2dbj7zcbkgp@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-11-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:30PM -0300, Luiz Angelo Daros de Luca wrote:
> To eliminate the need for a second memory allocation for dsa_switch, it
> has been embedded within realtek_priv.
> 
> Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I don't think it would be bad if you could just define a local variable

	struct dsa_switch *ds = &priv->ds;

in all functions, including those which reference &priv->ds just once.

> diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> index 864bb9a88f14..b80bfde1ad04 100644
> --- a/drivers/net/dsa/realtek/realtek.h
> +++ b/drivers/net/dsa/realtek/realtek.h
> @@ -61,7 +61,7 @@ struct realtek_priv {
>  	const struct realtek_variant *variant;
>  
>  	spinlock_t		lock; /* Locks around command writes */
> -	struct dsa_switch	*ds;
> +	struct dsa_switch	ds;
>  	struct irq_domain	*irqdomain;
>  	bool			leds_disabled;
>  
> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index 778a962727ab..9066e34e9ace 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -880,7 +880,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (!extint)
>  		return -ENODEV;
>  
> -	dp = dsa_to_port(priv->ds, port);
> +	dp = dsa_to_port(&priv->ds, port);

Nitpick: I don't think it would be bad if you could just define a local variable

	struct dsa_switch *ds = &priv->ds;

in all functions, including those which reference &priv->ds just once,
like this one.

>  	dn = dp->dn;
>  
>  	/* Set the RGMII TX/RX delay
> diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
> index aa998e15c42b..f65e47339d5b 100644
> --- a/drivers/net/dsa/realtek/rtl83xx.c
> +++ b/drivers/net/dsa/realtek/rtl83xx.c
> @@ -226,16 +226,12 @@ int rtl83xx_register_switch(struct realtek_priv *priv)
>  		return ret;
>  	}
>  
> -	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
> -	if (!priv->ds)
> -		return -ENOMEM;
> +	priv->ds.priv = priv;
> +	priv->ds.dev = priv->dev;
> +	priv->ds.ops = priv->variant->ds_ops;
> +	priv->ds.num_ports = priv->num_ports;

And here, I think it would actually look better to dereference just
through "ds".

Also, priv->dev is dereferenced 4 times in rtl83xx_register_switch(),
maybe you could add a local variable for it in the patch that introduces
rtl83xx_register_switch().

>  
> -	priv->ds->priv = priv;
> -	priv->ds->dev = priv->dev;
> -	priv->ds->ops = priv->variant->ds_ops;
> -	priv->ds->num_ports = priv->num_ports;
> -
> -	ret = dsa_register_switch(priv->ds);
> +	ret = dsa_register_switch(&priv->ds);
>  	if (ret) {
>  		dev_err_probe(priv->dev, ret, "unable to register switch\n");
>  		return ret;

