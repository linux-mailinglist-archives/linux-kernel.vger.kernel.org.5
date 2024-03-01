Return-Path: <linux-kernel+bounces-88006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734186DC07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED661F21B13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509006994E;
	Fri,  1 Mar 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iWQ1U0a4"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F469940
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277820; cv=none; b=p3aeVFaAVhdiQRj+jfAnIrgqfgsamsMX2yrINn4L8W7IMIaVyyu3PMgBX7eNd2gPVqa/6yhBQGfW7ZYAX0L+ulWY4AWXrHvmUqIXd7n3iLTONovVXmJqN/zp9RSoTups76qqiX/u44NZG7xmfoN90VSnNcl15ydvXL3fYaI+34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277820; c=relaxed/simple;
	bh=CjK66I7AAiXRRRBBKwH0tV6G4vJewM6HUWGvkhfyOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIrCXVOBgakf59Dmi3jQOj0+t8JiwKepaChd7EWkH3i8wVbpLZkCC7zS7CQU5R4sxuHb1mZJIrP9KfmwSOLTT5e12cipPnVL8lBNB29Qs5u6dZlIsMxs4LJgaRS55d4Fmv1sECsAdkW5OdEvriOYkWR1YRZef/QYWTZPI9M6oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iWQ1U0a4; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7dad83f225cso580376241.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709277818; x=1709882618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISkilHc4+MWs21rEtu/gLxlqPUCtJS0KbdJABF0S0Go=;
        b=iWQ1U0a4F0NPgiwm5InoPT1US+r+03A2BhWk1l1h2nioEJUBYFgY1RMwlRRef5ep1A
         gyTh3FD2wZQFU0HOGfmKyRpWe1js3qvKIov2M7BZKXHmZmpXJd9PoxBbLCPqjYrHjwqh
         nq0flFDmNJP8lqiVN1ytnjoxBCiMeFExDSLH3UxMYA8Azo0ES+awGhP3pHGJkntdOdVC
         r/9Gfz72IXyYQ/9hDL3yWFmnUUO7u4JNjRmTn5gqiqXp6jPN2h8esOTi8M5FqjpAWmBf
         /9d62bxF7PCfd0UQwxhResXUyYtLTZPHyIEkrabG3qve7ttOW3GiurB1C+8qfgFqeAkM
         AALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709277818; x=1709882618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISkilHc4+MWs21rEtu/gLxlqPUCtJS0KbdJABF0S0Go=;
        b=StdXeSn6VNxAqA9Yt44HuSAzadK883b0vTTrK0LsCet22g5czysa4ns/zSYwaijcPL
         ryZ1dqtJyi0+pCyi1wfdvp7vfdCrpVyirTLwBaDFfdtxXS6gIkSNeQw9ybJgmOolh0yl
         3nxEeu/TRXSVbs5dDBGDX1DZ+j88fmIjBIXWXgRtFRhAYTXUEBT9OtysdBcxE4HGWmVh
         yAm23Sfp06v4d7UeH54oRpUEMSnqgvKq5ByltguGcOQY4pLl9XLzRG7L5lA89T+nsnsR
         l+FfFQd5N2EXOz2z6uHCifw9H1CaIAEfRCVakf9vSE4/euNMqwOAogb1HoCOxZe+T+5O
         SKHg==
X-Forwarded-Encrypted: i=1; AJvYcCVXb+PThrpSjOF6cB0JtrScTVKHHL/15GN4UKtNY5+hLSNbOMYhvG4TudhRQzn4+SecYw4sMxPd5BtoiNnRkeHeI/a+sqhGZvXG37kj
X-Gm-Message-State: AOJu0Yz1wnKsBhgmEBv2szQJMoCIFBAZMy2RHv3n2pWmYY2WdKrSuOhm
	552PLBRyiYWJebeHfcCmeZq6etkfHpG6R8PiE9JXZM8tiWUK/svJfFtwLm5giYlYY4LO3/DRfnN
	WjfN+/RqEQbrSsgsh0PFT5r+++YxWEVohFgfjBA==
X-Google-Smtp-Source: AGHT+IHuXxnItq1PKx1TpfzLZQZEYNVVdnltsCQUp3DoH5HItn6kO+vMOytNWwPNyr6pDjxOFiYTVgZwtN7Y1wM851E=
X-Received: by 2002:a05:6122:2b7:b0:4d3:3ac7:495 with SMTP id
 23-20020a05612202b700b004d33ac70495mr485168vkq.13.1709277818025; Thu, 29 Feb
 2024 23:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301071203.5170-2-arturas.moskvinas@gmail.com>
In-Reply-To: <20240301071203.5170-2-arturas.moskvinas@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 08:23:27 +0100
Message-ID: <CAMRc=Mf47FqjMUGv4YN2eypx_pyvFR6fwf3E=R+jYf4gpGa9Gg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: 74x164: Enable output pins after registers are reset
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, 
	andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 8:12=E2=80=AFAM Arturas Moskvinas
<arturas.moskvinas@gmail.com> wrote:
>
> Chip outputs are enabled[1] before actual reset is performed[2] which mig=
ht
> cause pin output value to flip flop if previous pin value was set to 1.
> Fix that behavior by making sure chip is fully reset before all outputs a=
re
> enabled.
>
> Flip-flop can be noticed when module is removed and inserted again and on=
e of
> the pins was changed to 1 before removal. 100 microsecond flipping is
> noticeable on oscilloscope (100khz SPI bus).
>
> For a properly reset chip - output is enabled around 100 microseconds (on=
 100khz
> SPI bus) later during probing process hence should be irrelevant behavior=
al
> change.
>
> Fixes: 7ebc194d0fd4 (gpio: 74x164: Introduce 'enable-gpios' property)
> Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74=
x164.c#L130 [1]
> Link: https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74=
x164.c#L150 [2]
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
>
> ---
> v2 -> v3
> * Updated commit message to be imperatively moody
> * Converted links to proper tags
> * Added Fixes tag
>
> v1 -> v2
> * Updated commit message to contain more information why change is made.
> ---
>  drivers/gpio/gpio-74x164.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index e00c33310517..753e7be039e4 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -127,8 +127,6 @@ static int gen_74x164_probe(struct spi_device *spi)
>         if (IS_ERR(chip->gpiod_oe))
>                 return PTR_ERR(chip->gpiod_oe);
>
> -       gpiod_set_value_cansleep(chip->gpiod_oe, 1);
> -
>         spi_set_drvdata(spi, chip);
>
>         chip->gpio_chip.label =3D spi->modalias;
> @@ -153,6 +151,8 @@ static int gen_74x164_probe(struct spi_device *spi)
>                 goto exit_destroy;
>         }
>
> +       gpiod_set_value_cansleep(chip->gpiod_oe, 1);
> +
>         ret =3D gpiochip_add_data(&chip->gpio_chip, chip);
>         if (!ret)
>                 return 0;
>
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
> --
> 2.44.0
>

Queued for fixes.

Bart

