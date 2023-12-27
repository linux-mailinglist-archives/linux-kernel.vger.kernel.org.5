Return-Path: <linux-kernel+bounces-12071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5481EF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C17283288
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713045956;
	Wed, 27 Dec 2023 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vEkv4lgU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51245947
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-466ed49e160so321512137.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703689055; x=1704293855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPwYlFzLXOEgIDvGNQAPkxljqrw9tzBnxiCJwbRyHFo=;
        b=vEkv4lgUaktmyCqFyvY039A+/AmSP3FMFJosfh3mW80aHldmLCKmeC6sLHO3PvfaSN
         +cx7zogUf54EZbruI/bQ2DVZKTnEQSpDweyUI9w1HJJlaBWNbU5W2DaXDuEGhWUa1VGe
         TSdgRRkL0g2JMFHU0yyZBfAp0ivLPLcN3lo5zrv2UjjrNmhrlUdhjRDPJdXkmu11YC8l
         rjyYPeCfYbtkXp1NRH8rGQ47+A41twttGvH1tJzcwrJtbXAa2BAn2z3rTV/Csk7tKUpt
         ANC1P7ODaZLRJ4mN/eDplq6N5in4DMJhENJZEkz0KWBZGhUPZpLeukHgeuESofKOBHAt
         1FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703689055; x=1704293855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPwYlFzLXOEgIDvGNQAPkxljqrw9tzBnxiCJwbRyHFo=;
        b=mm7HRuBYoH4OiV0YYz43qKiKpjqzLyGt1dhem0z22Ip+xiW2m0dFMKqgxgqWc81vS2
         UpTvM1wNAuVevTG72D8g3hTbe2R3+qS/D7KmOcuqV9OAvCa9SevzjDK0QYKvYXBq762R
         SD9ZOfAgzbXhvq84T5NfNluwvkOG2JqXR4dHveFpoC7z0DihD3eXWe6pHA5f0nOrLb7P
         L9ghOwqDQVdT+p9AUdMWX8AQ5MX+zwsycl9Lj7aEf0/zKS3DH5KoHP/55lIdTltxMN76
         EvrAzPugVr7gRXRvVto20XKTxgrpjs7eWzGkdG1BEwrgr36e28iGjf0GUbry4K6rIY4G
         pznw==
X-Gm-Message-State: AOJu0YxpJolXCdDKYR+WOqoNoch3Gqp4raLLabnz7n7MdWNoZudgDmUl
	ZUmoEE2vG2YJ8tlpKdEmW4/N/12NDFYNpcVwDRnuRqrSJNn+UQ==
X-Google-Smtp-Source: AGHT+IGcRfZbZ6GD/38RMunGjOMWkfj1gorgKGXgkV+wAuDKpd+R1WQpSXou73Y/dgxrfpAKHRnVE4G6hvCVi989afc=
X-Received: by 2002:a67:e685:0:b0:467:7a5:c475 with SMTP id
 hv5-20020a67e685000000b0046707a5c475mr2313638vsb.35.1703689055526; Wed, 27
 Dec 2023 06:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221185702.24685-1-brgl@bgdev.pl>
In-Reply-To: <20231221185702.24685-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Dec 2023 15:57:24 +0100
Message-ID: <CAMRc=Mfu9tQNTYETtdmXyGtB1Gox7s_AcBwETVinZwR=LWdTLQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: tps65219: don't use CONFIG_DEBUG_GPIO
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:57=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> CONFIG_DEBUG_GPIO should only be used to enable debug log messages and
> for core GPIOLIB debugging. Don't use it to control the execution of
> potentially buggy code. Just put it under an always-false #if.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-tps65219.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
> index 7b38aa360112..cd1f17041f8c 100644
> --- a/drivers/gpio/gpio-tps65219.c
> +++ b/drivers/gpio/gpio-tps65219.c
> @@ -96,16 +96,16 @@ static int tps65219_gpio_change_direction(struct gpio=
_chip *gc, unsigned int off
>          * Below can be used for test purpose only.
>          */
>
> -       if (IS_ENABLED(CONFIG_DEBUG_GPIO)) {
> -               int ret =3D regmap_update_bits(gpio->tps->regmap, TPS6521=
9_REG_MFP_1_CONFIG,
> -                                            TPS65219_GPIO0_DIR_MASK, dir=
ection);
> -               if (ret) {
> -                       dev_err(dev,
> -                               "GPIO DEBUG enabled: Fail to change direc=
tion to %u for GPIO%d.\n",
> -                               direction, offset);
> -                       return ret;
> -               }
> +#if 0
> +       int ret =3D regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MF=
P_1_CONFIG,
> +                                    TPS65219_GPIO0_DIR_MASK, direction);
> +       if (ret) {
> +               dev_err(dev,
> +                       "GPIO DEBUG enabled: Fail to change direction to =
%u for GPIO%d.\n",
> +                       direction, offset);
> +               return ret;
>         }
> +#endif
>
>         dev_err(dev,
>                 "GPIO%d direction set by NVM, change to %u failed, not al=
lowed by specification\n",
> --
> 2.40.1
>

Patch applied.

Bart

