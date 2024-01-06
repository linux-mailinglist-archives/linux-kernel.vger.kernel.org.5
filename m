Return-Path: <linux-kernel+bounces-18557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC8825F51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F31283599
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083136FB6;
	Sat,  6 Jan 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rxf7YInv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D76FA7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbdd013c68bso166223276.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704539231; x=1705144031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8xsCw2olSbVegp5OaUais3sktHtUAk2PIqMv7T4kYk=;
        b=rxf7YInvWym5HrRH/DqxN9KmNFjIhyTPtWC+1T6jztYSHnIUOoAHp3qA307cS3mCOD
         efrnW6JDR2iBGCeOMunzEbzP15s8zkJEWFmceyw2MOUYzYCsNOX+snkfu2YwprX4aF7Q
         IgbHWiEoLBQ72IwPZVmFwoykjpSDZ9RfmIRUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704539231; x=1705144031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8xsCw2olSbVegp5OaUais3sktHtUAk2PIqMv7T4kYk=;
        b=iEpFF+s0/ag3K37bbSTvXSH2/TVhjrZcGCwxrLJWBt7dqfpfL+8lFAloFdQRdY/oFX
         uuIiNF6H8Us6APGScgqfA3kwbosMeHuyp6zDFzlr4sYDHFyH/mD/zNZDXlfKg2PLEzeq
         iZR2VpY9B1SxJoTfbW1O3c2Xq7JiBppB4J0UdpK33MJjtE6rUhhZA4n9go053hSf4sBr
         wVHUU4lMmBsTfSERt54L6wJ11CivvU+0vC78IRmWOISCrvPD86Hkk3nf20z3uVZxZay1
         4B1Bo4tBH5pX4u1ZIxhrncbKQyaZ1Y68I1LE3sHFiWgotIsU8kl8/vFRQkVnox1KX/ba
         VWcQ==
X-Gm-Message-State: AOJu0YzrVBpaBIvzHo5+TLimiVVSlnlnUpbxJ3E0sfDRdUnjZoz0Fv79
	OxN/jXARH7ZRnr7iEs0AYilaj4DKVEgmmBmPXA54seZVTegACQ==
X-Google-Smtp-Source: AGHT+IGi0GE3tCB884LTGzWxfRKn1Ioki/1f2HTD7URSrt/lafAnz5cGneg6VG6mOJODrgKHSI2Lnf0ucxcmmTh9SK8=
X-Received: by 2002:a5b:38b:0:b0:dbe:3152:56b2 with SMTP id
 k11-20020a5b038b000000b00dbe315256b2mr213397ybp.86.1704539231630; Sat, 06 Jan
 2024 03:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104084206.721824-1-dario.binacchi@amarulasolutions.com>
 <20240104084206.721824-9-dario.binacchi@amarulasolutions.com> <CACRpkda+=Zq+v-505O3pHazKzukSifBnNx_CPKbKd2JH-KYpYg@mail.gmail.com>
In-Reply-To: <CACRpkda+=Zq+v-505O3pHazKzukSifBnNx_CPKbKd2JH-KYpYg@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 6 Jan 2024 12:07:00 +0100
Message-ID: <CABGWkvoNuJNmxhrOE6csE2mGwF50ou-jx-kpmH-oQ2zBgzLrSg@mail.gmail.com>
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

On Fri, Jan 5, 2024 at 8:09=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, Jan 4, 2024 at 9:42=E2=80=AFAM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
>
> > The initialization commands are taken from the STMicroelectronics drive=
r
> > found at [1].
> > To ensure backward compatibility, flags have been added to enable gamma
> > correction setting and display control. In other cases, registers have
> > been set to their default values according to the specifications found
> > in the datasheet.
> >
> > [1] https://github.com/STMicroelectronics/STM32CubeF7/blob/master/Drive=
rs/BSP/Components/nt35510/
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > (no changes since v2)
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> (also tested to not regress my hardware)

After submitting v4, I tested the driver under different conditions,
i. e. without enabling display support in
U-Boot (I also implemented a version for U-Boot, which I will send
only after this series is merged into
the Linux kernel). In that condition I encountered an issue with the reset =
pin.

The minimal fix, would be this:

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index c85dd0d0829d..89ba99763468 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1133,7 +1133,7 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
        if (ret)
                return ret;

-       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS=
);
+       nt->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_=
HIGH);
        if (IS_ERR(nt->reset_gpio)) {
                dev_err(dev, "error getting RESET GPIO\n");
                return PTR_ERR(nt->reset_gpio);

With the doubt that this might cause a regression in your use case.

I then tried modifying the device tree instead of the nt35510 driver.
In the end, I arrived
at this patch that leaves me with some doubts, especially regarding
the strict option.

diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva=
09.dts
b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-m>
index 014cac192375..32ed420a6cbf 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
@@ -13,6 +13,17 @@ &panel0 {
        compatible =3D "frida,frd400b25025", "novatek,nt35510";
        vddi-supply =3D <&vcc_3v3>;
        vdd-supply =3D <&vcc_3v3>;
+       pinctrl-0 =3D <&panel_reset>;
+       pinctrl-names =3D "default";
        /delete-property/backlight;
        /delete-property/power-supply;
 };
+
+&pinctrl {
+       panel_reset: panel-reset {
+               pins1 {
+                       pinmux =3D <STM32_PINMUX('J', 15, GPIO)>;
+                       output-high;
+               };
+       };
+};

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c
b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 346a31f31bba..6f055f7f96a2 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -895,7 +895,6 @@ static const struct pinmux_ops stm32_pmx_ops =3D {
        .set_mux                =3D stm32_pmx_set_mux,
        .gpio_set_direction     =3D stm32_pmx_gpio_set_direction,
        .request                =3D stm32_pmx_request,
-       .strict                 =3D true,
 };

Another option to fix my use case without introducing regressions
could be to add a
new property to the device tree that suggests whether to call
devm_gpiod_get_optional()
with the GPIOD_ASIS or GPIOD_OUT_HIGH parameter.

What is your opinion?

Thanks and regards,
Dario Binacchi

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

