Return-Path: <linux-kernel+bounces-1225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E104E814C01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9692B284973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8454374F2;
	Fri, 15 Dec 2023 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H0mwJ/iU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB837163
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9dc3215d2so380364b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702655042; x=1703259842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7aJHSr2v0aXZU02xkacVR4ZEcIVwOeki7KFEoLbvYY=;
        b=H0mwJ/iUmraKTz/xal39Z/DhCVEsKZ26v9lrokF2n3J8z0uQIAiPPEldQ65gEypC0b
         dIRZFAWrPtpzNzw/BfJpW/brxHHlL8N/WvX9PJ7Y9KYW/LPj5Jg1xwG89O3TXvwGhk7j
         iUDa+t0KHQFMIGJFiiJRmLvBh6OGUSq7dD8tF7ahVSvo/NXasa4SxokeMv6fCD0HSQFL
         NLMWkWKL/uCRs3MShdKlHMZ+RB3cZW/VziZeLuwWVeUpQPVtnBVOhDNhUSoQklP7jtAT
         juJda2ZT4o4T2wRHNY+wVo7CGdQX0osx14BEs4LN0DmZba5Qegumrq8ukvlrcQUFg+pe
         LvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655042; x=1703259842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7aJHSr2v0aXZU02xkacVR4ZEcIVwOeki7KFEoLbvYY=;
        b=riI5YZszH9vRolvpV5iqxf9OPTetW8ICCQta9yVtvqTwhLRnJV9MjP9CqgzkXyKkGp
         Nnf0OuV/9QHdel4aVG3XzTDCt2QIjXrHSLQo8NNJ+gjLlnV/WA1roPytxHby/6WH4aBN
         pZoxx4zA2jgiI7ybCK6foRoNO+0kAZ0ttq7eNrHEu6y2dqGGWcTDRZSRlfiBqer2Tn/Q
         V3RoLeAyd/ZKV0C5Jvvkj0k5NmFzWaRuTQa4twOxZo1qf5iQ9tkvlEww1mttvbBS01iN
         /qtTyPrLQ48S2eO17N3IxvuY+ByjZaC7NyLQepGRG3vUbcl1zfbJkaAqJgBwkL8Eyj+B
         Fsbw==
X-Gm-Message-State: AOJu0Yy+eYZPvD1LyC3SrdNsgQcQJN0rABH/rS92CfItVXMdFOFh3wYU
	QfMOzRQLiRt35o5jcbcwbfNrN+CdaxGgwaFtO6Nfeg==
X-Google-Smtp-Source: AGHT+IFN1tbCZ18F6HzWn4m42IKz8p0WMXaWajidN/61VmChg/3Rs/7g12h23MCSJU/ilj4aibP5ErMbBe8sRh1jxN0=
X-Received: by 2002:a05:6808:448c:b0:3b8:632e:a83c with SMTP id
 eq12-20020a056808448c00b003b8632ea83cmr13794717oib.17.1702655042017; Fri, 15
 Dec 2023 07:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212105501.16347-1-brgl@bgdev.pl>
In-Reply-To: <20231212105501.16347-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 15 Dec 2023 16:43:50 +0100
Message-ID: <CAMRc=McFJzZ0+WpnpfdoSRkUbc8AxskCTPD8igVMw4N5=hoi0A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: allocate memory atomically with a spinlock held
To: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We will eventually switch to protecting the GPIO descriptors with a mutex
> but until then, we need to allocate memory for the label copy atomically
> while we're holding the global spinlock.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/62588146-eed6-42f7-ba26-160226=
b109fe@moroto.mountain/T/#u
> Fixes: f8d05e276b45 ("gpiolib: remove gpiochip_is_requested()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 4e190be75dc2..6efe44570333 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2399,7 +2399,15 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc=
, unsigned int offset)
>         if (!test_bit(FLAG_REQUESTED, &desc->flags))
>                 return NULL;
>
> -       label =3D kstrdup(desc->label, GFP_KERNEL);
> +       /*
> +        * FIXME: Once we mark gpiod_direction_input/output() and
> +        * gpiod_get_direction() with might_sleep(), we'll be able to pro=
tect
> +        * the GPIO descriptors with mutex (while value setting operation=
s will
> +        * become lockless).
> +        *
> +        * Until this happens, this allocation needs to be atomic.
> +        */
> +       label =3D kstrdup(desc->label, GFP_ATOMIC);
>         if (!label)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.40.1
>

Patch applied.

Bart

