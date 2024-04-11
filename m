Return-Path: <linux-kernel+bounces-140277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479048A11B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3F41F21473
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECF13D24D;
	Thu, 11 Apr 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D48Q7gcp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302263A2;
	Thu, 11 Apr 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832396; cv=none; b=mHjFgejGZF+PW1BoxVIK84zgYBIqTnyjWYlsfEfyB4hWPuBAlPBt/D90UlyfYCSxw1awScNkLOtVAHeNBayVKjnagRyzx2p3O6R83cZIMgKoPPk1rwOoVSQtBsZh+X76h60l2UiX9+xGq6//axC3yeB4ISHuhlVoOZOOUdZKVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832396; c=relaxed/simple;
	bh=5E/ca5c77gR9Zl6uJ+56UId421Q8eo1fpsHoBRfh3M0=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=Rfuh1ORoFbqCOSOBGh1R9vAf5wbsgEQPn3P4NC4EkStpV2V2JpDdK8ft6pXLZx9eJ7Kwq/4DIzzqexOcxJBkZ26QdE6+7XT2cRD+rAPhfdqIY7HB2FUqXgRCkoyq9YuUOBPCc8zZhqKFjIw9ve55wVUrUWPcJbB5MEkdTbJJL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D48Q7gcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DF0C43390;
	Thu, 11 Apr 2024 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832396;
	bh=5E/ca5c77gR9Zl6uJ+56UId421Q8eo1fpsHoBRfh3M0=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=D48Q7gcp5d6vdTxK1pVgGN/JbGtABOsGSQEVFTDQa2pRCYlaZXNZtmoRrd5mq4Y8j
	 vgOlAoLTwHv8fJRxrKGIZfSGqye01dBsY+2+7icW20Ms/WmNW4T3COgGpLEcbqVj/J
	 7FdVB2aH1bCr6d0K2ESPU37gWI8QMaLacM9x+wpoZYGwknvxqqJVL58BSKF5dXYcMr
	 Z8wbw2iZUnRZ/2hc+rFU23j+jRmbD21PPsO59m/KvBnrCv1GE00DW09y5GGMBE4HEE
	 nF9ZIZ381+Uic75A0yrbWbf/gofNdnHpUpF7kgT27zGTzRL/xNwSJbwKdChP8Z/ehN
	 M59rVIGPla/dA==
Content-Type: multipart/signed;
 boundary=f7bcb3103797fb11dc8c9e325de0ccbdaba3a8a308f4ddca767ec9ae9a6c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 11 Apr 2024 12:46:32 +0200
Message-Id: <D0H8EQB97VFA.2P27K85EJXCTB@kernel.org>
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski"
 <brgl@bgdev.pl>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Use -ENOTSUPP consistently
X-Mailer: aerc 0.16.0
References: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--f7bcb3103797fb11dc8c9e325de0ccbdaba3a8a308f4ddca767ec9ae9a6c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Andy,

On Wed Apr 10, 2024 at 8:39 AM CEST, Andy Shevchenko wrote:
> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.

I don't care too much, so if you like you can add

Reviewed-by: Michael Walle <mwalle@kernel.org>

But.. isn't it the wrong errno and isn't it discouraged to use it
because it's a NFS only errno? Thus, wouldn't it make more sense for
the core to accept EOPNOTSUPP and maybe convert it to ENOTSUPP if we
don't want to break userspace?

-michael

> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/gpio/gpio-regmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index c08c8e528867e..71684dee2ca5d 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -129,7 +129,7 @@ static int gpio_regmap_get_direction(struct gpio_chip=
 *chip,
>  		base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
>  		invert =3D 1;
>  	} else {
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  	}
> =20
>  	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> @@ -160,7 +160,7 @@ static int gpio_regmap_set_direction(struct gpio_chip=
 *chip,
>  		base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
>  		invert =3D 1;
>  	} else {
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  	}
> =20
>  	ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);


--f7bcb3103797fb11dc8c9e325de0ccbdaba3a8a308f4ddca767ec9ae9a6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZhe/iBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/isTwF/XCyGf2p6F7G12CDeKBlKMIQwJDLACieE
GTK8iuyzUoL/Legr4j1zapvm+nSkFwIYAYDkgBxqzP3KAplp1eybe6b9EJnZWrpm
Wx3JWhVVjnsw7IkRrxKcvW+3iKI+7QrsGYc=
=DFER
-----END PGP SIGNATURE-----

--f7bcb3103797fb11dc8c9e325de0ccbdaba3a8a308f4ddca767ec9ae9a6c--

