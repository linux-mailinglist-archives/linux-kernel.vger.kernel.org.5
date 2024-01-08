Return-Path: <linux-kernel+bounces-20072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334658278F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C411F237D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE635576F;
	Mon,  8 Jan 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NY4xJ2qd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986F5576E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so1269231276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704744769; x=1705349569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO+k5lvbngjS92ouyx3R3uEoQtzTI+waqD9Cqv6JLzo=;
        b=NY4xJ2qdPO5Ru62RGbL1EaZnXBl2PyKoaficnh1lpCVqZO+VoXyroYUQO227AUfwVo
         g8wdgc/urhYKP+H03RLnVP6YpqPFtSGrZfG9wdSVk4zg0qZKJj29XRKubreLWvZUbDUS
         wvI8kgMMh98cBRK/l+jR0hv2m1y6oMpPc0TNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744769; x=1705349569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO+k5lvbngjS92ouyx3R3uEoQtzTI+waqD9Cqv6JLzo=;
        b=mC/Xrwj40nTjvJs6QY6cr6W2bTJOnaTN3YXurstvPJy/yL0XLMuvzZocXrnVjAznpN
         a+5ET9oyyFPTL7MHhQvQc06Z0wrtlobUiwiTjYR73QSYwmows7TI3jic4AN1kFFl7Vrp
         Jhxgn/C+Rp5nRzbr1Bs7FXKjnx0S3usJ4wLa8Okrv5wnfPimQouXnAc5M4nMKwvDJSHd
         qrHO91wgXVqm97Tf4RjhKtfN0VRnjmvHhDVWmHGTDht+amsNcZCv15A8K5snxtdp8mnP
         qXtM58Fc8Z7FMZ0rf+wQxqAvTjLTIJZeuuuve8sg8bmFZ4kpqECB0OUFjPnsi3D/BoKy
         mgCA==
X-Gm-Message-State: AOJu0Yy1hOB1YsR+aH7fSY0JgDraoD9em0SpzpBHEJYVn/mq0ODIqmC3
	FUsRVpq6PXIlYjTAcsCuck81tj+u1u1w76SDqZOu4SPvc9zl2Q==
X-Google-Smtp-Source: AGHT+IFUUedhilU//0xZ1+dgQGu1fYRJoi2KV/ctlDlSR1L6Xlf0TFmrxtXePndYD4C7J5WXLQ80bM9Ha0k8nMgP2ZU=
X-Received: by 2002:a25:8441:0:b0:db7:dad0:76ad with SMTP id
 r1-20020a258441000000b00db7dad076admr1590636ybm.73.1704744768971; Mon, 08 Jan
 2024 12:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
 <20240104084206.721824-9-dario.binacchi@amarulasolutions.com>
 <CACRpkda+=Zq+v-505O3pHazKzukSifBnNx_CPKbKd2JH-KYpYg@mail.gmail.com>
 <CABGWkvoNuJNmxhrOE6csE2mGwF50ou-jx-kpmH-oQ2zBgzLrSg@mail.gmail.com> <CACRpkdZJF-WE8oTi3RXpX_+W+D6bV_o2Nt1ikRbErR6pBc2OJg@mail.gmail.com>
In-Reply-To: <CACRpkdZJF-WE8oTi3RXpX_+W+D6bV_o2Nt1ikRbErR6pBc2OJg@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 8 Jan 2024 21:12:37 +0100
Message-ID: <CABGWkvoHuzTPNhh54VihNJ4PtSTF9sRLiup6PRNqG5uoHfJc_A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 9:02=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Sat, Jan 6, 2024 at 12:07=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>
> > After submitting v4, I tested the driver under different conditions,
> > i. e. without enabling display support in
> > U-Boot (I also implemented a version for U-Boot, which I will send
> > only after this series is merged into
> > the Linux kernel). In that condition I encountered an issue with the re=
set pin.
> >
> > The minimal fix, would be this:
> >
> > diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> > b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> > index c85dd0d0829d..89ba99763468 100644
> > --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> > +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> > @@ -1133,7 +1133,7 @@ static int nt35510_probe(struct mipi_dsi_device *=
dsi)
> >         if (ret)
> >                 return ret;
> >
> > -       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
ASIS);
> > +       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
>
>
> This is fine, because we later on toggle reset in nt35510_power_on(),
> this just asserts the reset signal already in probe.
>
> I don't see why this would make a difference though?
>
> Is it to make the reset delete artifacts from the screen?
>
> Just explain it in the commit message.
>
> It is a bit confusing when I look at your DTS patch:
>
> https://lore.kernel.org/linux-arm-kernel/20240104084206.721824-7-dario.bi=
nacchi@amarulasolutions.com/
>
> this doesn't even contain a reset GPIO, so nothing will happen
> at all?
+++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include "stm32f769-disco.dts"
+

The GPIO is contained in the stm32f769-disco.dts:

panel0: panel-dsi@0 {
        compatible =3D "orisetech,otm8009a";
        reg =3D <0>; /* dsi virtual channel (0..3) */
        reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;
        power-supply =3D <&vcc_3v3>;
        backlight =3D <&panel_backlight>;
       status =3D "okay";
...
};

>
> > I then tried modifying the device tree instead of the nt35510 driver.
> > In the end, I arrived
> > at this patch that leaves me with some doubts, especially regarding
> > the strict option.
> >
> > diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-=
reva09.dts
> > b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-m>
> > index 014cac192375..32ed420a6cbf 100644
> > --- a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.=
dts
> > +++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.=
dts
> > @@ -13,6 +13,17 @@ &panel0 {
> >         compatible =3D "frida,frd400b25025", "novatek,nt35510";
> >         vddi-supply =3D <&vcc_3v3>;
> >         vdd-supply =3D <&vcc_3v3>;
> > +       pinctrl-0 =3D <&panel_reset>;
> > +       pinctrl-names =3D "default";
> >         /delete-property/backlight;
> >         /delete-property/power-supply;
> >  };
> > +
> > +&pinctrl {
> > +       panel_reset: panel-reset {
> > +               pins1 {
> > +                       pinmux =3D <STM32_PINMUX('J', 15, GPIO)>;
> > +                       output-high;
>
> But this achieves the *opposite* of what you do in the
> other patch. This sets the reset line de-asserted since it is
> active low.
>
> Did you add the reset line to your device tree and forgot to
> set it as GPIO_ACTIVE_LOW perhaps?

panel0: panel-dsi@0 {
        compatible =3D "orisetech,otm8009a";
        reg =3D <0>; /* dsi virtual channel (0..3) */
        reset-gpios =3D <&gpioj 15 GPIO_ACTIVE_LOW>;

>
> > --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> > +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> > @@ -895,7 +895,6 @@ static const struct pinmux_ops stm32_pmx_ops =3D {
> >         .set_mux                =3D stm32_pmx_set_mux,
> >         .gpio_set_direction     =3D stm32_pmx_gpio_set_direction,
> >         .request                =3D stm32_pmx_request,
> > -       .strict                 =3D true,
>
> To be honest this is what I use a lot of the time, with non-strict
> pin control you can set up default GPIO values using the pin control
> device tree, and it's really simple and easy to read like that since e.g.
> in this case you set it from the panel device node which is what
> is also consuming the GPIO, so very logical. So I
> would certainly remove this .strict setting, but maybe Alexandre
> et al have a strong opinion about it.

I will send a separate RFC PATCH.

Thanks and regards,
Dario Binacchi

>
> > Another option to fix my use case without introducing regressions
> > could be to add a
> > new property to the device tree that suggests whether to call
> > devm_gpiod_get_optional()
> > with the GPIOD_ASIS or GPIOD_OUT_HIGH parameter.
> >
> > What is your opinion?
>
> It's fine either way, but just use GPIOD_OUT_HIGH and I can test
> it on my system as well, I think it's fine.
>
> Yours,
> Linus Walleij



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

