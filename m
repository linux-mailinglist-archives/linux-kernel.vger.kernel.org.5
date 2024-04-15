Return-Path: <linux-kernel+bounces-145493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C318A56E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D381C21E17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C457F7EF;
	Mon, 15 Apr 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR5RKTz/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3D2837D;
	Mon, 15 Apr 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196834; cv=none; b=nZMyIL1cKxW9MM3r8RlneDiX0VZvQu/3OgcxgaPEuo3Ryw13JMUtRkhZJGfN6YWztk1X6bR3ibP81myuqwsoddUCdRxp+uw8Kk60S6XdXfxYHhao6Y0drUms3/Zv6EUG/+6VaeZPdxVOHslPKgUP4/5csZc64AD75o5olQYjYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196834; c=relaxed/simple;
	bh=AIurx8M7UROIIHeLqraX05WDHOH/h7A8uObPQDPI2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP+wJzznuJihIcfA93AFlvinMyml+89RrE9SXZ87a5xHiC/JRXKDvXIKOpFgByJqGUWmyeNi0coiDVF+VhXSIkQaAFaY5s7/QZPlgYNAITNMpOirR23Is79qZ41SA/V7t0OVsmEqYJS6YCRIxc0qNu6Jz5KSFY4yFAEE3RrbzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR5RKTz/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da01cb187cso61665341fa.0;
        Mon, 15 Apr 2024 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713196830; x=1713801630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WonYqSzvWT83jIX0IgNtkReYkS7CHkadpcuSarICRPQ=;
        b=iR5RKTz/yrvZ9nCboAo1nWXktPhapgHwq0JWB5kPflUer7S2Z7FbX/d3BxqZPV6Cmt
         Msyz1SIsXwgG4Y/0GMFxFX1OZXIrOgsCMZuG02PGvnGLQtML11+9yhopk7vaQEzyQuF+
         iML4sO0SUkhgv/2S5mf191ce6u+gyS6E/2AqVoOUlns3jhqiOGKl7Y3FowQlUr5LDiGt
         YKbTC9wvuBu+ibflf6cTlR0Xmr+DNkzEbzd9So0xC+xlcyZ1g39ovDk07OYmef5OImGr
         MI6K2uXOBEoz8++cpEmZuTX9SUfbCtPZSEkn48K8Jnl6GgZ9gmi2tSwjaTXY1NRS3mvR
         7S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196830; x=1713801630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WonYqSzvWT83jIX0IgNtkReYkS7CHkadpcuSarICRPQ=;
        b=Tk+e8xcTORGpYEffGGxiIv++pOGbQs2BPIdN1yDeMdGDO+0Gn2yPXLTJhPJ8P23vVc
         7lYW7+NYWzqo5Tazm4WQ3nVMY35YHG8IvZSekeaCRYbvs7yXKPk04bP9Fcd50zENfxj8
         CxL7njXzMNdmsd30WmbilXIOd3ec3fN7pGN+DFe+u/2wRcddDCoiofuwrV+RVnnMvlMh
         Al6kKuCM7sMXZ1y+uAsfP7G0JZUJ5GovOkrXdTJt2t3N7W+aTUi5HJSLvf3k5ROfNwHQ
         3LN6DjgqgjwQBI86vwYsN6ImfC1fI8x/cnwoaRJudOheO72N32um4eacFzE1/coBWl9P
         k0RA==
X-Forwarded-Encrypted: i=1; AJvYcCUYWsDqROxSpRv//vZncK4w+sGCDLl7ShqwgU685pUFJq8M7gUPHt5MOixMaM6xPIoFa5vnWARtWZk2g+W+INBLEtU/6W9xBMVt+4d9BW4qI7rw0fq93bTYSXgZdCkjAMNY2t2HazRFBZfg9ARR9Z+5TR3gydRiP31X/+Aaq+3zlkLhgp1P
X-Gm-Message-State: AOJu0YxlqHjGBBo1ha1PNAz7x9uGnTKQ5MO+PLCiYJVrvMNUfpAaGuQJ
	p59W2HTKi58A/z9Bpt/bSQFQQPLNpTR7XauRcToizHDppIwtUWMD
X-Google-Smtp-Source: AGHT+IFOUuLN0irhPLHYXZ6mYv7PuyHiv+G70JXmObZzyVsigzU8qLZr9NJrU7yz6GsEcOBavXFeVg==
X-Received: by 2002:a05:651c:b0b:b0:2d4:7455:89f6 with SMTP id b11-20020a05651c0b0b00b002d4745589f6mr9666567ljr.40.1713196829400;
        Mon, 15 Apr 2024 09:00:29 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906701500b00a53d6b895ddsm783830ejj.200.2024.04.15.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:00:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:00:26 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v4 23/25] media: i2c: imx258: Add support for reset gpio
Message-ID: <Zh1PGuTjFlttNnLX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-24-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414203503.18402-24-git@luigi311.com>

Hi Luis,

On Sun, Apr 14, 2024 at 02:35:01PM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> It was documented in DT, but not implemented.

Good catch :-)

> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  drivers/media/i2c/imx258.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index f0bd72f241e4..5de71cb7c1ae 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -699,6 +699,7 @@ struct imx258 {
>  	unsigned int csi2_flags;
>  
>  	struct gpio_desc *powerdown_gpio;
> +	struct gpio_desc *reset_gpio;
>  
>  	/*
>  	 * Mutex for serialized access:
> @@ -1250,7 +1251,11 @@ static int imx258_power_on(struct device *dev)
>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>  	}
>  
> -	return ret;
> +	gpiod_set_value_cansleep(imx258->reset_gpio, 0);
> +

I think you can remove this new line here.

> +	usleep_range(400, 500);
> +
> +	return 0;
>  }
>  
>  static int imx258_power_off(struct device *dev)
> @@ -1260,6 +1265,7 @@ static int imx258_power_off(struct device *dev)
>  
>  	clk_disable_unprepare(imx258->clk);
>  
> +	gpiod_set_value_cansleep(imx258->reset_gpio, 1);
>  	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>  
>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> @@ -1573,6 +1579,12 @@ static int imx258_probe(struct i2c_client *client)
>  	if (IS_ERR(imx258->powerdown_gpio))
>  		return PTR_ERR(imx258->powerdown_gpio);
>  
> +	/* request optional reset pin */
> +	imx258->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(imx258->reset_gpio))
> +		return PTR_ERR(imx258->reset_gpio);
> +
>  	/* Initialize subdev */
>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>  

Looks good to me.
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>

> -- 
> 2.44.0
> 
> 

