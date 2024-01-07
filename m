Return-Path: <linux-kernel+bounces-18973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5B8265DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9BF1F21484
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050411170A;
	Sun,  7 Jan 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzzlR65q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35511700
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbd6e377ceso1377758b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 12:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704657721; x=1705262521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsQYY7qqo+FrBHe/RokTU8lf3E6e+C6A/j4bBRjxl58=;
        b=vzzlR65qsZbFKeopf349phTqqgHIxTito9FyggnbxgjF2d2Y6zhLmDFtmGtcDpaCXi
         d6uvcuSUUKh9L7qa3vVuRiJkZ3kw6aIMiBh5o1UTyllvqymUb53NFLK3BNLd/mL2s9lY
         wINDwAR2VKqg6t/8ZmqbKsNGq+sAZj8BtU+C2n/hvYVgXJMmGzkCdMsaE+pDWelE7bva
         8bjLOPtQCcJZ4DcMr+PrInqcqdzTA1bDctv2qCkNK6RUfQHLwCP2RaRyiUxcq/xgqh3L
         WjKzqLAG/6K3V6LniSdm8zwrUmy5pqA3yVSagzQ4c4iU0rUhG84V2n3qBhy/OE6wpstP
         IGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704657721; x=1705262521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsQYY7qqo+FrBHe/RokTU8lf3E6e+C6A/j4bBRjxl58=;
        b=qm85KYJ1b8+fIwY4K1Gqc5ps8yLbjQqlRYfWCLQJYSJVk8lUrufiq6ZjhTpefSOAsQ
         DbfSj3bfHfWL48LF1ALh0ol5CoC5d8LzyKO8ndzW7HiLTYDfFIcZhq0fcCBQ6ljMIcVo
         o9BkLuQQRp+P/NDSkj786l2AQPHyWoQoRCODz4r7U21beXEdVR1cOHuXi8pwqBHbAEZr
         i/Q48kpKy4l2SgXM9j2tmvXck/Xkc4AXpKP3X4omk0SONVrF58n9pnC3HI88dUxjGR6j
         /z5WnCG+VLxJW+E4PUHrUssWEOqMFA4ynstdQPDPcTQ/0D8PUJTtRroS7hgJ150EcLrz
         61Og==
X-Gm-Message-State: AOJu0Yz4f1DZBFLhCELw+f9OEpYxarh5JmDFpLYWCuDsnb+0Z6EHfU6l
	zUdFxBqWUJZ3aA9x5KVJ9VhXbET0fuPr1Idxjr6rQ5BUhW4sgg==
X-Google-Smtp-Source: AGHT+IGywVTBJjpXydC+fLvcp4XUEIt9/GT2WV7oS29NQUNx0cTWCHookn5mwrDpBsjcRympVKZCp3IcNmPj0BDGxa4=
X-Received: by 2002:a54:4088:0:b0:3bc:2a4f:7722 with SMTP id
 i8-20020a544088000000b003bc2a4f7722mr3057800oii.90.1704657720778; Sun, 07 Jan
 2024 12:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
 <20240104084206.721824-9-dario.binacchi@amarulasolutions.com>
 <CACRpkda+=Zq+v-505O3pHazKzukSifBnNx_CPKbKd2JH-KYpYg@mail.gmail.com> <CABGWkvoNuJNmxhrOE6csE2mGwF50ou-jx-kpmH-oQ2zBgzLrSg@mail.gmail.com>
In-Reply-To: <CABGWkvoNuJNmxhrOE6csE2mGwF50ou-jx-kpmH-oQ2zBgzLrSg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 7 Jan 2024 21:01:49 +0100
Message-ID: <CACRpkdZJF-WE8oTi3RXpX_+W+D6bV_o2Nt1ikRbErR6pBc2OJg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 12:07=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> After submitting v4, I tested the driver under different conditions,
> i. e. without enabling display support in
> U-Boot (I also implemented a version for U-Boot, which I will send
> only after this series is merged into
> the Linux kernel). In that condition I encountered an issue with the rese=
t pin.
>
> The minimal fix, would be this:
>
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> index c85dd0d0829d..89ba99763468 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -1133,7 +1133,7 @@ static int nt35510_probe(struct mipi_dsi_device *ds=
i)
>         if (ret)
>                 return ret;
>
> -       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_AS=
IS);
> +       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OU=
T_HIGH);


This is fine, because we later on toggle reset in nt35510_power_on(),
this just asserts the reset signal already in probe.

I don't see why this would make a difference though?

Is it to make the reset delete artifacts from the screen?

Just explain it in the commit message.

It is a bit confusing when I look at your DTS patch:

https://lore.kernel.org/linux-arm-kernel/20240104084206.721824-7-dario.bina=
cchi@amarulasolutions.com/

this doesn't even contain a reset GPIO, so nothing will happen
at all?

> I then tried modifying the device tree instead of the nt35510 driver.
> In the end, I arrived
> at this patch that leaves me with some doubts, especially regarding
> the strict option.
>
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-re=
va09.dts
> b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-m>
> index 014cac192375..32ed420a6cbf 100644
> --- a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dt=
s
> +++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dt=
s
> @@ -13,6 +13,17 @@ &panel0 {
>         compatible =3D "frida,frd400b25025", "novatek,nt35510";
>         vddi-supply =3D <&vcc_3v3>;
>         vdd-supply =3D <&vcc_3v3>;
> +       pinctrl-0 =3D <&panel_reset>;
> +       pinctrl-names =3D "default";
>         /delete-property/backlight;
>         /delete-property/power-supply;
>  };
> +
> +&pinctrl {
> +       panel_reset: panel-reset {
> +               pins1 {
> +                       pinmux =3D <STM32_PINMUX('J', 15, GPIO)>;
> +                       output-high;

But this achieves the *opposite* of what you do in the
other patch. This sets the reset line de-asserted since it is
active low.

Did you add the reset line to your device tree and forgot to
set it as GPIO_ACTIVE_LOW perhaps?

> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -895,7 +895,6 @@ static const struct pinmux_ops stm32_pmx_ops =3D {
>         .set_mux                =3D stm32_pmx_set_mux,
>         .gpio_set_direction     =3D stm32_pmx_gpio_set_direction,
>         .request                =3D stm32_pmx_request,
> -       .strict                 =3D true,

To be honest this is what I use a lot of the time, with non-strict
pin control you can set up default GPIO values using the pin control
device tree, and it's really simple and easy to read like that since e.g.
in this case you set it from the panel device node which is what
is also consuming the GPIO, so very logical. So I
would certainly remove this .strict setting, but maybe Alexandre
et al have a strong opinion about it.

> Another option to fix my use case without introducing regressions
> could be to add a
> new property to the device tree that suggests whether to call
> devm_gpiod_get_optional()
> with the GPIOD_ASIS or GPIOD_OUT_HIGH parameter.
>
> What is your opinion?

It's fine either way, but just use GPIOD_OUT_HIGH and I can test
it on my system as well, I think it's fine.

Yours,
Linus Walleij

