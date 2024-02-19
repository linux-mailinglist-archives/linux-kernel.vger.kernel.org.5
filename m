Return-Path: <linux-kernel+bounces-71658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A132685A895
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4268AB21C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8213CF7B;
	Mon, 19 Feb 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dcpdvjf1"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC873B1B2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359486; cv=none; b=DufVd1H/m3+yJfmGBBDtRkljhph75N6vtkebxxCiheWTFverOgIzs9B2hwzplbu7JRkrwjDolRF8Oz8QRzEGQOwv5rk3ks5woCYiDRHfdNfPEZ0qmR9goxHJmQzb3w5G7F2t2M2Qcu3DJEm0XoT3K8qmEaz1iHQZBiA+f++AvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359486; c=relaxed/simple;
	bh=qjzcx+ky+m9LqUCnQsunFaXlJI8F3Ray2e8gmZDQnsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsDhUsTB/XJkgsyGDa785Gwbs2z1SxXipxT1fpmbrjp85+uUmpbbbTsyL7htq7L9UHsMTnyOd2DaFeyj34jBe6FR1ETRhDNOF1PlnnD51OXcUSrN9i9h9n5v2NKg5XnYNoMESqgjC7el6gjsIETNMOOO/t7I7md2beQeOqa2sOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dcpdvjf1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e7c3e3cf3so2416028fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708359483; x=1708964283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkkKZJCCytTGAljspGkyIipfcm+Bvc2X5TtIBHDj2O0=;
        b=dcpdvjf1TK+Ev/Mj+ftRw+S4+JCtcDmwlMU8lw+zETf52zeuO0VJI6AVprwjcLhY9Y
         TvobkL7WVjHzERUl91TIu/CS5I2BpQ9XuCvDdquE+G5UrNj+EaISCqJJ7dynzXL3lSRn
         zpPaoOFzaSl76JhxqP5eCpQViiWYAaV3hkWD+tCrploWTbzkgPsx9IKEsILoJhkuQKLf
         aJThTzdVr6cPs+Yl1IGLn/1lzbUBb9HY9UEMMi/5+mvKnWnUmpYVFMC8ccRWNDrlofm5
         Roe+VhvVlpBva0iokGAhkiMUlPAv2xl5r+RBWIa7xzeNg1AaFVz9Yufnfs/X1kBKwWrw
         eZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359483; x=1708964283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkkKZJCCytTGAljspGkyIipfcm+Bvc2X5TtIBHDj2O0=;
        b=Px+ibADHfECnczMAH5A4d2l8cTUp5fWFrZtQEgzEWXqgyLCZrE/szYTVR0fB4g0X54
         qUjfLTYFgXGY+1oNQS2WgMkyRt21tWpKMpQ3Xvu783dGI/mkDh+qBEyHURKJaq0rv/K9
         887VvlilZMDB6Q/mHeJ4S3wOQa+SegVcToc/E6DEydvpvoM//eLXtM12EYdAve4SE2gr
         am5Q4xBfF6vWO96412Cd3shFdt1ciBsdgGOp9Nf+Gt99VsMHtlkevqvLSRra9SWsgi7f
         MHkej6YPzsexEB0y3Putgp4vP2DIYohVRyOq4XkBGMG4SWO6ZoZ5Z1DESR5OUUoTfcaq
         B8gg==
X-Forwarded-Encrypted: i=1; AJvYcCV+5BNspCKjKRFwLuKxfyOfJEULGmktZR7fGL7a4bGFfmlKQILPMIH1aUCU+pzdTAc3oxH5vmWnaz42xxkhiu+BBW3tbxAHxO0g3ZlX
X-Gm-Message-State: AOJu0YweDTEQqP58V66v5oaI7HKg2Ek2aCUb1wsX0f/ECoAQzWDudRaa
	LwINz0wGJHJbHq8x52VCkI8y/M2vw0GTQeYCJ3g+YwJCUS2Vu106iPQhYbJLzOHJG6IbJiUZnWF
	sxKKbkaReHrhJETFq8+FXH5FvWxnyWSKpZ4gMLw==
X-Google-Smtp-Source: AGHT+IG5pyvJ8VZ6IeRCjDQVoO+8UramCL2g0nrYiEFGzvjye6ON6eV4Qtkb+srU6g6Hef9hGKjITtSXzU2gX9D/suw=
X-Received: by 2002:a05:6871:79a:b0:219:3054:3ea5 with SMTP id
 o26-20020a056871079a00b0021930543ea5mr12969383oap.45.1708359483560; Mon, 19
 Feb 2024 08:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-17-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-17-f88c0ccf372b@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 17:17:52 +0100
Message-ID: <CAMRc=Me=SiS5oScmm8jMNsed_2smN4p6s+xPnkTzjHM_hPPULQ@mail.gmail.com>
Subject: Re: [PATCH 17/23] gpio: nomadik: handle variadic GPIO count
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:
>
> Read the "ngpios" device-tree property to determine the number of GPIOs
> for a bank. If not available, fallback to NMK_GPIO_PER_CHIP ie 32 ie
> the current behavior.
>
> The IP block always supports 32 GPIOs, but platforms can expose a lesser
> amount. The Mobileye EyeQ5 is in this case; one bank is 29 GPIOs and
> the other is 23.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/gpio/gpio-nomadik.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> index 5b1e3b3efcff..02b53c58adf7 100644
> --- a/drivers/gpio/gpio-nomadik.c
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -490,7 +490,7 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct d=
evice_node *np,
>         struct resource *res;
>         struct clk *clk;
>         void __iomem *base;
> -       u32 id;
> +       u32 id, ngpio;
>
>         gpio_pdev =3D of_find_device_by_node(np);
>         if (!gpio_pdev) {
> @@ -518,10 +518,15 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struct=
 device_node *np,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> +       if (of_property_read_u32(np, "ngpios", &ngpio)) {

As commented elsewhere - please try to use device_property_read_u32().

Bart

> +               ngpio =3D NMK_GPIO_PER_CHIP;
> +               dev_dbg(&pdev->dev, "populate: using default ngpio (%d)\n=
", ngpio);
> +       }
> +
>         nmk_chip->bank =3D id;
>         chip =3D &nmk_chip->chip;
>         chip->base =3D -1;
> -       chip->ngpio =3D NMK_GPIO_PER_CHIP;
> +       chip->ngpio =3D ngpio;
>         chip->label =3D dev_name(&gpio_pdev->dev);
>         chip->parent =3D &gpio_pdev->dev;
>
>
> --
> 2.43.1
>

