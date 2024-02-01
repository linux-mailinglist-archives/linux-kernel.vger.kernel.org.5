Return-Path: <linux-kernel+bounces-48015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A377E845643
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5944628C479
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C915B970;
	Thu,  1 Feb 2024 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iho0mFhR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2059F51A;
	Thu,  1 Feb 2024 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787054; cv=none; b=Jo+1rJfaBVTuWzgIBneI+n4zmJuGyPVs7Jtxo84Q5/pNQpmO0R/0kYbLIU94iuALY4psFi7PWRDgu/g9EE1jUtCosTrJqmcNKVhLyunH2Unyzp0z8Qd4mGFUoanKjAWG0/WaQ40kAAxLMw+fS/G+c9sSC7nWclIzP8f5nBqUnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787054; c=relaxed/simple;
	bh=ymwI0jN49xybT/Ng8gZ2rmIN5iSeKZU+oWXLZSdT+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q36izT2DVsnVyqb7AU4YEy10AWG0Jazs7v9Fbchu0KDeN1eGkJnW6MdccDK3qNKDWNGax/HiM8k1G68d1MPrfnun7MFHwFxSz56Wec114UpsHZi/jfdrtaGNVPAzzB3wrYlUhqzQq/gFhf77QW7iHcGuO9bdFXI1Q7Cfq+0Q0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iho0mFhR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so1132344a12.2;
        Thu, 01 Feb 2024 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706787051; x=1707391851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeJ8Vo9euL1nRT/+mK/nP/qb3zO+GpIrLJzkyd6z9vk=;
        b=Iho0mFhRYpHfJ+NErtefTdd4XFfOaoJk4aJMVaekgK5o+EDC7CI2xZ0daoSECqHPwB
         4j+RJb+s2EtSaRz3rLo+rLN88aUrEy0TXr2TytvELvHMoGc81vOWwgYINlZDTxcynbUS
         idpcnxNLLX5D+mGt3heMdRdF+I5kMvCrGSkmo2co1uraN3f3PQEXsI9oeJdGD4eCy0/B
         aEzLI1FZaF0dZdEX8Li5nQPELNY8NEMN02D9hqjghipd5DnnxB+GDACml7+cmLbwJT3r
         WZPX5LJXcFul7LDdabe0aZGI1B113Y/D8vayhrH0/3v32dI7DY9edfhld6lNxJS9JOHH
         GXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787051; x=1707391851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeJ8Vo9euL1nRT/+mK/nP/qb3zO+GpIrLJzkyd6z9vk=;
        b=R6+JNShfh+Ur+YicTP/lHHcTDxUOBq4ilI0OAgpDxgdUEny0wvL0CVwEiCCWdg/jQE
         Dx/tIZtnoQPOuAJchsJdcfwYG9eev1XB0DYZll4CVk+MEHSzOVrBZXLgi7qC8ZG0sEq5
         K3DcfAqWipSKaqLZLVcaN6rA204lm838gwMT0elSnvpsVNEk/IPlIB9JpjEITFnb/5eN
         y8xi8LfX3Pag9az6aO2pBJChZFbtEet7ZHQEsVjAxNLWBnDjD4UzjD7JjEYdXYklW5zY
         D9q5Xi6DPyV0BIG0qJRtcq5hNuXg+83TBN8Rkmnqv/zt4v6wIeAu7aeGw9nBLSsLI2v7
         Ke+Q==
X-Gm-Message-State: AOJu0YwFgPfmzcQygNaNMSQDW8ARWEw1eX7AIDqU3rN2NqxWda/Kb9FD
	zzir1DzhglhfrVoTUIspkp8aFIkl18Ok9LVtt0dPz3FfIV8UxgIg
X-Google-Smtp-Source: AGHT+IG+OZWcNv5QlGSK/292NmwxUhG7WXWmnQr1AOXMHR6GCOvKOh/sC3nQLY1afE7JnUaT5apRDQ==
X-Received: by 2002:aa7:ccce:0:b0:55f:c7ad:b92f with SMTP id y14-20020aa7ccce000000b0055fc7adb92fmr547508edt.24.1706787050510;
        Thu, 01 Feb 2024 03:30:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuPe791exN4U8Ea3ojgnWCzKEeIkBgRXEdyACk43lEzdN1Hdr1vjOjAXKP8RzQnPV85tMBuxpqj1pUmG3Q6fvW2c+b++rjlKF0iNG9zEK68k6ea2Vv5zkJTzBvr6ivlCBK+KZpNDPHlctPTMx9XdpgGc7PKS/bgbKfoMw8fTtKo7nxLwPB6yaaPIvSKHTwwJEu2uWaPWtISFutCuBvbEKTF7Wp8IgCb8AGSBuxOMlZOeHFYnGI0IzEot2mJ9cX+mWSqOnLs7gGAm7v0L1WnN15G9Xwb6jmjfSjsbMEs8wavEeSg6CEVvhXb5u1flMoG9W53M8xHNUdt/kWxVwWD4Pjofvdl+4=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e0100b0055d312732dbsm6717894edh.5.2024.02.01.03.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:30:50 -0800 (PST)
Date: Thu, 1 Feb 2024 13:30:48 +0200
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
Subject: Re: [PATCH net-next v5 03/11] net: dsa: realtek: convert variants
 into real drivers
Message-ID: <20240201113048.67td36b6bfufb2gk@skbuf>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-3-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-realtek_reverse-v5-3-ecafd9283a07@gmail.com>

On Tue, Jan 30, 2024 at 08:13:22PM -0300, Luiz Angelo Daros de Luca wrote:
> Previously, the interface modules realtek-smi and realtek-mdio served as
> a platform and an MDIO driver, respectively. Each interface module
> redundantly specified the same compatible strings for both variants and
> referenced symbols from the variants.
> 
> Now, each variant module has been transformed into a unified driver
> serving both as a platform and an MDIO driver. This modification
> reverses the relationship between the interface and variant modules,
> with the variant module now utilizing symbols from the interface
> modules.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Some minor non-functional comments below which you might decide not to
address now, depending on what else is pointed out during review.

> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index c2572463679f..3433f64fb0d7 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -140,7 +141,19 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
>  	.disable_locking = true,
>  };
>  
> -static int realtek_mdio_probe(struct mdio_device *mdiodev)
> +/**
> + * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
> + * @mdiodev: mdio_device to probe on.
> + *
> + * This function should be used as the .probe in an mdio_driver. It
> + * initializes realtek_priv and read data from the device-tree node. The switch
> + * is hard resetted if a method is provided. It checks the switch chip ID and,

nitpick: participle of 'reset' is 'reset'. Same comment for realtek_smi_probe().

> + * finally, a DSA switch is registered.
> + *
> + * Context: Can sleep. Takes and releases priv->map_lock.
> + * Return: Returns 0 on success, a negative error on failure.
> + */
> +int realtek_mdio_probe(struct mdio_device *mdiodev)
>  {
>  	struct realtek_priv *priv;
>  	struct device *dev = &mdiodev->dev;
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index 668336515119..d8a9a6a6b5bc 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -505,8 +518,20 @@ static int realtek_smi_probe(struct platform_device *pdev)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
>  
> -static void realtek_smi_remove(struct platform_device *pdev)
> +/**
> + * realtek_smi_remove() - Remove the driver of a SMI-connected switch
> + * @pdev: platform_device to be removed.
> + *
> + * This function should be used as the .remove_new in a platform_driver. First
> + * it unregisters the DSA switch and cleans internal data. If a method is
> + * provided, the hard reset is asserted to avoid traffic leakage.

FWIW, removing the driver unregisters the net devices, which disables
the ports and performs an orderly shutdown of any upper virtual net
devices as well, like bridges. So ports automatically roll back to
standalone operation before this callback is even issued.

Traffic leakage is prevented, and the switch is hard reset, but I don't
think there is any causal relationship between the two.

> + *
> + * Context: Can sleep.
> + * Return: Nothing.
> + */
> +void realtek_smi_remove(struct platform_device *pdev)
>  {
>  	struct realtek_priv *priv = platform_get_drvdata(pdev);
>  

