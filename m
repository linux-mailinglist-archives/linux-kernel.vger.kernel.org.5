Return-Path: <linux-kernel+bounces-71620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5085A7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0413F1C21EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C93A8CC;
	Mon, 19 Feb 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sCL4nwJt"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83E39840
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358098; cv=none; b=gr1sA7nAMIrrZDqRhk6ZGZ1h9gErtvVDoLrioOduMhWOQ8aNal8uVgmstZulxHH9qmSVI3tpwp+Kf/Nnr6KvYA4nv0bQzvL9DWgJL65xDo6UywBrHXpWVrTrYyouRRZmBftJO/Gu5wCnZjyxfOrf25BSZM8Gab4nJ+jpQrxjXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358098; c=relaxed/simple;
	bh=RiKNqdAWkc15btUAvtH8gwvQqvzLDrXQfP0TuTCrgc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmMmGi70UmpfgACJh00Yv6jdxRY2JWkZtMDgoOwEsobyJ38p6bTQyLiRTwzIGFX2I0gPs7tObUslCH+0hkAIGdyHxPi+2Tb03EnhpGonFUKyJV//iiVgmIxwh/jI+Mu/P4IIIej+hoevVDXaAumnUPaCK7qNXIW9cKUitV/AsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sCL4nwJt; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso2671161241.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708358095; x=1708962895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EZ3A2c0ZKjpnKWkkWce/b5c+QP/TKCtzjAs9idwae4=;
        b=sCL4nwJtwYy1tFrxvYCa8cHAMsh/+xgQUl6HYgA5pVOBnbCzL1hcGwr1TBH8hAUKfM
         tZr2JhYGy6VbGYA7uIUtbiu98UIoTEMniehEV3W1IvQSmFYwiSJInS6hQ3HYwwut+jzH
         yjfJ1DI9bYVZX/KyK6Mx/cnqzyTqNyq9YfEypBCUuwAndlsREeeoKB480tMoNMRJea3H
         Vmzx2a1e4UwriJQiMsTiJSMf/7hpwd9fjkfARuwHffh2GYwE+RWeATx3AqbUn33uS2ZZ
         bSaQIKfBPoTLlCtZ0OrH2vBm4KmFdhd9GMzWCCrwQuItJC4ObKykKSOol7JiSrWWLr0Q
         GrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358095; x=1708962895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EZ3A2c0ZKjpnKWkkWce/b5c+QP/TKCtzjAs9idwae4=;
        b=RS+cTsBEnDQAq37vOPEsffzsexP7XvOEI7pKMZE4gwiKgl2OatAYXIDYfHKiJk+h6c
         sWkmyOPHcC3x+hQRNft4LmHHpNHJV683IqU/66RSs1CuDWJJcfA9/SBQ9VzrScmiyuLT
         Zeqfa1ULzLn6+eETxKyAzue0Nx4W8PxvEnVFh4OD+K1nmzrb9C5csprGSNtENjFDo/PL
         2uoEe+J58g0b3WSWYE27OWdBHWkzs3j7yWq/eOUk76gMxqyUhQqDjPuBm3dz9oupwIdJ
         KDSeuP5XyFa4Igs7zQfXoxGW1m+ounKKfqLjQDZhJaNukRKRoK3kDq5oGTcqNcNwZIMX
         NR6w==
X-Forwarded-Encrypted: i=1; AJvYcCWyntWezhXA0NzL+r9jv4Jy80ytvjsqyIPbTqvTq6y+dXxbXjXBpTM/JvrWIKfficwrERFv8JFff94RrIAc6Jk81fU54jwpyaHW9jJA
X-Gm-Message-State: AOJu0YztgqCEo7JAUnoeNXWlc5LZg9F1EY9GFUgkfa4T2KpRKmZ1tXDB
	1nlnIN6TFW3UHFY6ObZdiMmyXScLl7L06+lCUl49Q8O58orX6Ug9nx+SxkXs+OnZnpLoOA+wMLW
	lDfZ3S+Oox7R+gDbGWlXClKcNqJ95LkBl8Tlq4A==
X-Google-Smtp-Source: AGHT+IFVBEUOIdiIo9CXYAQsKMkED1i4PMCL4v5mm6zw8jSR88hZQ+SvhJJ9wdEoocImvLl4O0SeMqWkEwZE8ZJciIE=
X-Received: by 2002:a05:6102:3710:b0:470:43f2:d10a with SMTP id
 s16-20020a056102371000b0047043f2d10amr5296383vst.33.1708358093997; Mon, 19
 Feb 2024 07:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com> <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 16:54:43 +0100
Message-ID: <CAMRc=MdwAQUgc=LP45r-j0UCtN1gzPg9_y3hrbQhCyH91D=W-g@mail.gmail.com>
Subject: Re: [PATCH 13/23] gpio: nomadik: fix offset bug in nmk_pmx_set()
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
> Previously, the statement looked like:
>
>     slpm[x] &=3D ~BIT(g->pins[i]);
>
> Where:
>  - slpm is a unsigned int pointer;
>  - g->pins[i] is a pin number which can grow to more than 32.
>
> The expected shift amount is a pin bank offset.
>
> This bug does not occur on every group or pin: the altsetting must be
> NMK_GPIO_ALT_C and the pin must be 32 or above. It is possible that it
> occurred. For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2
> has the right altsetting and has pins 229 and 230.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Maybe add a Fixes: tag and put it at the beginning of the series so
that it can go upstream earlier as a fix?

Bart

> ---
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/=
nomadik/pinctrl-nomadik.c
> index c7693fbc0484..99bdb25f358d 100644
> --- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> +++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
> @@ -913,8 +913,9 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, u=
nsigned int function,
>                  */
>                 for (i =3D 0; i < g->grp.npins; i++) {
>                         struct nmk_gpio_chip *nmk_chip;
> +                       unsigned int bit;
>
> -                       nmk_chip =3D find_nmk_gpio_from_pin(g->grp.pins[i=
], NULL);
> +                       nmk_chip =3D find_nmk_gpio_from_pin(g->grp.pins[i=
], &bit);
>                         if (!nmk_chip) {
>                                 dev_err(npct->dev,
>                                         "invalid pin offset %d in group %=
s at index %d\n",
> @@ -922,7 +923,7 @@ static int nmk_pmx_set(struct pinctrl_dev *pctldev, u=
nsigned int function,
>                                 goto out_pre_slpm_init;
>                         }
>
> -                       slpm[nmk_chip->bank] &=3D ~BIT(g->grp.pins[i]);
> +                       slpm[nmk_chip->bank] &=3D ~BIT(bit);
>                 }
>                 nmk_gpio_glitch_slpm_init(slpm);
>         }
>
> --
> 2.43.1
>

