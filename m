Return-Path: <linux-kernel+bounces-48691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E513F845FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9370EB2AF16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFED84055;
	Thu,  1 Feb 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY9Bq9v6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C684FC0;
	Thu,  1 Feb 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811794; cv=none; b=lU/buG8nHssoPHk65g6aKJ/kzy8QOxeWLcsjYoBe+bApPBlo2nqvUb2UK0xYozoic0M0kOKn6PZqIZ9uFe2/xwCAI/HSuHwlAKOH2cvfl7w3jg5SSvENuTOD3PA3T1MfuNk0xcL4RyAYdtGKiqdsmJeLaXT3rVCBhumezhivmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811794; c=relaxed/simple;
	bh=ogV7GvdZt6YyCj/tWdJxbt2NIxMLRcjU/P0OzTk7O5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCaBtX+SMC+T/uXHlnJd9eTDYY3IhwFfAvvT7wWSdV0Lb4BpEGmh48vpArLnX9cVzKTgGnvZCjFlCK1OVCH1Lf75zzwYqfXVf5pIgI7iWnCB9RHckHeki4HZUidlgYZBrnUsgNeTtHFC46R7e562N7e1FIyHfltBJf/tKC2aFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY9Bq9v6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a359e6fde44so132131466b.3;
        Thu, 01 Feb 2024 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706811791; x=1707416591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDk4/I3bKMa0G5KpJtieeLmumvANCayNAEiZNJHgZu4=;
        b=UY9Bq9v6FGouacypOWxFoQejqz4UGxEHTHtchf39PqNQ8bsGrmODBqcO26khTB9CzL
         7msIPlV4bYnkWaywMhLCiDWxLve1cTIy3ekT72z9fYNsm8K8z+DZOiSLYEfMDCXGkrr1
         xRZXFp+X4uasMePa3f/yQ1tAqaKGTu2Hy3xrrbdf1mOUtWSJ5ZNHou7mLL2BuJY/zFP6
         x8moJnXCt95ZWm+bPSoqx8ovQQ58RfvvAy6mrTgvSsFodb+0a0P5wEyUtFm6eFYwXBXt
         1OydySNwbTRQnsN+dkfBCRj4ycCOLXuPs4I9t9KpOFH9C+qYO1CMZhzYiQ05KdRwvHda
         GvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811791; x=1707416591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDk4/I3bKMa0G5KpJtieeLmumvANCayNAEiZNJHgZu4=;
        b=MW8hzZfuaedDUCwACsTTfOgD/bmsxbJ3mhC4N8PmqGMfXVbyhYI6N1X2G09k3+Hpwf
         6z8IRdqetnOYDGAI/VkaBBO6Moev59xZkQPsbqq6sbz9en0AegV3KlJbCcccbHpAjjDg
         r/EedCyHHPCzqGlhy9rMg5F15OgYTmNXcdTT4eer0+5re6I8cPTXV+v15F/FLs2CYmq9
         n1CI1dRmTTKyG4A2PagEp1xkCd9TWOMqgo/0Q5xx6c9/gzy4J/BrjGiFN7W6RVbpPmQc
         LV26uPmG/uNXdL+ovtEC+cOZ3przsiwqh2tGAUk/P9e98z6tmcp7fz9qJiyWySROZrGa
         X31A==
X-Gm-Message-State: AOJu0YyeCg7MWgdRaOljz8HycKYChiwi1gOs3TxHgolYnRh+MHw0MdMf
	4boKBlH9lwXDKSrT7TYRjLUjJriQ4beCUFkpKUKyYAa03E3a/+nLKQ6UUO/nyn5pVQ==
X-Google-Smtp-Source: AGHT+IG5CPplvGLonZc8xM+jICyAuaMr9N5QG0wHARTP+/UokArb/SWT9izO2KFBKh8clvIlQZJ7Lw==
X-Received: by 2002:a17:907:171b:b0:a31:3162:4a6f with SMTP id le27-20020a170907171b00b00a3131624a6fmr4596587ejc.59.1706811790140;
        Thu, 01 Feb 2024 10:23:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVD7zXyRp3Oy4jXfzIceCAO8UeOWkswxmRwVK35mnbXpuez92+IhD0r2UOrNHb+NlO35PJ2MJjWYv5NZFu/Sw7sD/e+EqbZvBXYjhpTp8ec5W2GctUGxg69xeJp0LLvDbC1nzpbanLi+IrbE2HYf7MHcBeBMdXYdNCpixYqjhiHavUVl/CS9nc1WYaJ0rzq3Mvnf21cG1lUgyNQQyaMKT5eWnG69+BJSxERaWEKcO803zBTl+xVwN9ggaz8R8Da6QkRNCJ/Zs3hTphYDgCgs9fte2HhlcO6ry/zghvNkMcnscF4wrJ01iVPkAzZ8uESuk0N/3m2NQAvKQCTMNfI8Uug56Dxyho=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709063bcc00b00a36c2ab1b14sm38736ejf.139.2024.02.01.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:23:09 -0800 (PST)
Date: Thu, 1 Feb 2024 20:23:07 +0200
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
Subject: Re: [PATCH net-next v5 05/11] net: dsa: realtek: common rtl83xx
 module
Message-ID: <20240201182307.mls7qnrpu2zhh5xk@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-5-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-5-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-realtek_reverse-v5-5-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-5-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:24PM -0300, Luiz Angelo Daros de Luca wrote:
>  /**
>   * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
>   * @pdev: platform_device to probe on.
>   *
> - * This function should be used as the .probe in a platform_driver. It
> - * initializes realtek_priv and read data from the device-tree node. The switch
> - * is hard resetted if a method is provided. It checks the switch chip ID and,
> - * finally, a DSA switch is registered.
> + * This function should be used as the .probe in a platform_driver. After
> + * calling the common probe function for both interfaces, it initializes the
> + * values specific for SMI-connected devices. Finally, it calls a common
> + * function to register the DSA switch.
>   *
>   * Context: Can sleep. Takes and releases priv->map_lock.
>   * Return: Returns 0 on success, a negative error on failure.
>   */
>  int realtek_smi_probe(struct platform_device *pdev)
>  {
> -	const struct realtek_variant *var;
>  	struct device *dev = &pdev->dev;
>  	struct realtek_priv *priv;
> -	struct regmap_config rc;
> -	struct device_node *np;
>  	int ret;
>  
> -	var = of_device_get_match_data(dev);
> -	np = dev->of_node;
> -
> -	priv = devm_kzalloc(dev, sizeof(*priv) + var->chip_data_sz, GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -	priv->chip_data = (void *)priv + sizeof(*priv);
> -
> -	mutex_init(&priv->map_lock);
> -
> -	rc = realtek_smi_regmap_config;
> -	rc.lock_arg = priv;
> -	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
> -	if (IS_ERR(priv->map)) {
> -		ret = PTR_ERR(priv->map);
> -		dev_err(dev, "regmap init failed: %d\n", ret);
> -		return ret;
> -	}
> -
> -	rc = realtek_smi_nolock_regmap_config;
> -	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
> -	if (IS_ERR(priv->map_nolock)) {
> -		ret = PTR_ERR(priv->map_nolock);
> -		dev_err(dev, "regmap init failed: %d\n", ret);
> -		return ret;
> -	}
> -
> -	/* Link forward and backward */
> -	priv->dev = dev;
> -	priv->variant = var;
> -	priv->ops = var->ops;
> -
> -	priv->setup_interface = realtek_smi_setup_mdio;
> -	priv->write_reg_noack = realtek_smi_write_reg_noack;
> -
> -	dev_set_drvdata(dev, priv);
> -	spin_lock_init(&priv->lock);
> -
> -	/* TODO: if power is software controlled, set up any regulators here */
> -
> -	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> -	if (IS_ERR(priv->reset)) {
> -		dev_err(dev, "failed to get RESET GPIO\n");
> -		return PTR_ERR(priv->reset);
> -	}
> -	if (priv->reset) {
> -		gpiod_set_value(priv->reset, 1);
> -		dev_dbg(dev, "asserted RESET\n");
> -		msleep(REALTEK_HW_STOP_DELAY);
> -		gpiod_set_value(priv->reset, 0);
> -		msleep(REALTEK_HW_START_DELAY);
> -		dev_dbg(dev, "deasserted RESET\n");
> -	}
> +	priv = rtl83xx_probe(dev, &realtek_smi_info);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
>  
>  	/* Fetch MDIO pins */
>  	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->mdc))
>  		return PTR_ERR(priv->mdc);

Be consistent in the usage of the API you create. Every time rtl83xx_probe()
succeeds and something else down the line fails, you must call
rtl83xx_remove(). Otherwise, it is a shaky base to build upon.

The rtl83xx_remove() function can even be left empty if you feel that
the existing hard reset is of no value (which I would agree with) - see
mv88e6xxx_hwtstamp_free() as an example.

> +
>  	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->mdio))
>  		return PTR_ERR(priv->mdio);
>  
> -	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
> +	priv->write_reg_noack = realtek_smi_write_reg_noack;
> +	priv->setup_interface = realtek_smi_setup_mdio;
> +	priv->ds_ops = priv->variant->ds_ops_smi;
>  
> -	ret = priv->ops->detect(priv);
> -	if (ret) {
> -		dev_err(dev, "unable to detect switch\n");
> +	ret = rtl83xx_register_switch(priv);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
> -	if (!priv->ds)
> -		return -ENOMEM;
>  
> -	priv->ds->dev = dev;
> -	priv->ds->num_ports = priv->num_ports;
> -	priv->ds->priv = priv;
> -
> -	priv->ds->ops = var->ds_ops_smi;
> -	ret = dsa_register_switch(priv->ds);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "unable to register switch\n");
> -		return ret;
> -	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);

