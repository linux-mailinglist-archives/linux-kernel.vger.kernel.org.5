Return-Path: <linux-kernel+bounces-105102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B367A87D921
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B1E1C20C61
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3FE576;
	Sat, 16 Mar 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl4oPlzi"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F86DDA0;
	Sat, 16 Mar 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573215; cv=none; b=FodnOnRloUvB5NQs2OXVjR27DbFfOaRtuwKmCfdUpBIil25tG4jJ8miwdc/gjH45JbnIMB+EMCqoDGQui4Sxe07ilzPm76B5rcFeAjBaJqPebJCUR3uGH8o0gF7HAkt+ZN4Gz6xJCAcGu5jUonHYrXxR2ALl0pY72JVmyDHb6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573215; c=relaxed/simple;
	bh=fRxJhlJU5nJuH3yGn/7/q+rm5xSlke51hiT+mYNAMUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnFq21wpmFQajb0AIMI6STcQnv0ZMQBe08vhSP1miyue4U016ZD06m2AGjglPesAL5CKTn6GSA79hQd8QAZpHc+vbgrtIo32VtwvJpGuM8cSoJX499hua3uYot4bEr/PlZMRCgpofYxXsdlTHdkAzsvR/U7727fFxXpMnX6CNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl4oPlzi; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4f874f958so1034893a34.3;
        Sat, 16 Mar 2024 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710573213; x=1711178013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH1HjKXgqWamM9V7+gGjSorEBrJBtznwrDfjafJprJo=;
        b=gl4oPlziAAbcQwfecxy5Uu2KfnjXN1P6/wb44w3BnnJBWZfjip/nFWw91YFsTNrsgN
         5So+0sq0AvtVkszm8lwHoZD5Q/8DWpAQeXRxzR5zfxlbAtnAdH1a+dtkbTGvjgxfAEjP
         RrD9/TejYYj5XMD6pGAIljhizw+Mbbjyy+5TNjuIAMQfe5OeIon7UdvajklDYbjaEw8b
         A9kNkxmrIrc3LOaEKg4kKTWILdPBsToozI4cPHLB1lwCJsNoG68coWG4AQT2jaRIa00I
         RoZQrp0MrMO/MwUELvI87sIDcfR+pynC3z26W23UFzej0DZItRaI9zdNq2gQq6NZ3YT1
         EeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710573213; x=1711178013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH1HjKXgqWamM9V7+gGjSorEBrJBtznwrDfjafJprJo=;
        b=EL0R6DKSLfl6z9rBA5zRTtRXv/dS2P6atlsFxWYWAc3du5CBHUjdIJbjNxr0g+Ru8s
         b1yG9EfXvA2ePEgZqoXniy2tUSBMi25MMQ8E14YOuTx6R2ayhKfbBHhQnIUmZdGXQsnE
         sZGRjcbazYPqcXvxNWPXpxowC3jk/SUkiMGgxyR8Boi5DZgU8si7fZ0r4rHOMSMFFsZv
         EVKeMLowZEMTIlch/wN4ZSE96QwNmoDWKhwSTtW4gY62kL0NPr6pNHyRNpYMyaH9oz9h
         bni0BHeaT13D90KVdCAjkBd9cFnT5YxdP8g56wB1fZfbMjaLiiRmsxqIq608N8wlq8gj
         Dc/w==
X-Forwarded-Encrypted: i=1; AJvYcCVuNEG2SMlwlHfau3llv1n5K895f1dluSrxp0QJa8YbH8qM/itqel8saEWgry48LTtS+bLaH2/i2LwXdtchKt8WlQ3dTL6+rmejINZq7k2KH6clfnWeQ/5iVch/X14+75yEHmkvRs6FMB2rNyAfW+bWIZtaVKuyB08FfQlW0CsJFhP3ww==
X-Gm-Message-State: AOJu0YxM/xI9DsccO6N6AWTPblE/0hVH/C53KclWZXcOgMYZuRIJwTJr
	9K+YuF69GHtqicRC8eMUEtjC5JNWYi4RwiqkJORiBjlUAu/uoT3WJ+TsWQ9Ub8h9jLuQ2LdyvhE
	a7aZIiz1rD3ldMmybO/wpL0Nu+e8=
X-Google-Smtp-Source: AGHT+IHFm1pk3MhaYLjKF5FvPa3megVs0xsRdtydd9ia8Rk4aY9IXlZA8suyd3aMqnOZx7VXpFjukxiRHQ001S2F/1w=
X-Received: by 2002:a9d:7854:0:b0:6e4:da53:7e36 with SMTP id
 c20-20020a9d7854000000b006e4da537e36mr7297684otm.19.1710573212476; Sat, 16
 Mar 2024 00:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
 <20240314100131.323540-3-qiujingbao.dlmu@gmail.com> <ZfT42gzJhVd1NQzd@xhacker>
In-Reply-To: <ZfT42gzJhVd1NQzd@xhacker>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Sat, 16 Mar 2024 15:13:21 +0800
Message-ID: <CAJRtX8TRcBFKSrPm8C4-MxUrin6B0aNJ7KjCDkAdMWPw2W-2VQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Jisheng Zhang <jszhang@kernel.org>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 9:55=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Thu, Mar 14, 2024 at 06:01:31PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 315 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 326 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-cv1800.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4b956d661755..455f07af94f7 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -186,6 +186,16 @@ config PWM_CROS_EC
> >         PWM driver for exposing a PWM attached to the ChromeOS Embedded
> >         Controller.
> >
> > +config PWM_CV1800
> > +     tristate "Sophgo CV1800 PWM driver"
> > +     depends on ARCH_SOPHGO || COMPILE_TEST
> > +     help
> > +       Generic PWM framework driver for the Sophgo CV1800 series
> > +       SoCs.
> > +
> > +       To compile this driver as a module, build the dependecies
> > +       as modules, this will be called pwm-cv1800.
> > +
> >  config PWM_DWC_CORE
> >       tristate
> >       depends on HAS_IOMEM
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c5ec9e168ee7..6c3c4a07a316 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)               +=3D pwm-clk.o
> >  obj-$(CONFIG_PWM_CLPS711X)   +=3D pwm-clps711x.o
> >  obj-$(CONFIG_PWM_CRC)                +=3D pwm-crc.o
> >  obj-$(CONFIG_PWM_CROS_EC)    +=3D pwm-cros-ec.o
> > +obj-$(CONFIG_PWM_CV1800)     +=3D pwm-cv1800.o
> >  obj-$(CONFIG_PWM_DWC_CORE)   +=3D pwm-dwc-core.o
> >  obj-$(CONFIG_PWM_DWC)                +=3D pwm-dwc.o
> >  obj-$(CONFIG_PWM_EP93XX)     +=3D pwm-ep93xx.o
> > diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> > new file mode 100644
> > index 000000000000..8eca07c60942
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Sophgo CV1800 PWM driver
> > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > + *
> > + * Limitations:
> > + * - It output low when PWM channel disabled.
> > + * - This pwm device supports dynamic loading of PWM parameters. When =
PWMSTART
> > + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) w=
ill be
> > + *   temporarily stored inside the PWM. If you want to dynamically cha=
nge the
> > + *   waveform during PWM output, after writing the new value to HLPERI=
ODn and
> > + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value=
 effective.
> > + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-=
1).
> > + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
> > + * - This hardware could support inverted polarity. By default, the va=
lue of the
> > + *   POLARITY register is 0x0. This means that HLPERIOD represents the=
 number
> > + *   of low level beats.
> > + * - This hardware supports input mode and output mode, implemented th=
rough the
> > + *   Output-Enable/OE register. However, this driver has not yet imple=
mented
> > + *   capture callback.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define PWM_CV1800_HLPERIOD_BASE     0x00
> > +#define PWM_CV1800_PERIOD_BASE       0x04
> > +#define PWM_CV1800_POLARITY          0x40
> > +#define PWM_CV1800_START             0x44
> > +#define PWM_CV1800_DONE              0x48
> > +#define PWM_CV1800_UPDATE            0x4c
> > +#define PWM_CV1800_OE                0xd0
> > +
> > +#define PWM_CV1800_HLPERIOD(n)       (PWM_CV1800_HLPERIOD_BASE + ((n) =
* 0x08))
> > +#define PWM_CV1800_PERIOD(n)         (PWM_CV1800_PERIOD_BASE + ((n) * =
0x08))
> > +
> > +#define PWM_CV1800_UPDATE_MASK(n)    (BIT(0) << (n))
> > +#define PWM_CV1800_OE_MASK(n)        (BIT(0) << (n))
> > +#define PWM_CV1800_START_MASK(n)     (BIT(0) << (n))
> > +#define PWM_CV1800_POLARITY_MASK(n)  (BIT(0) << (n))
> > +
> > +#define PWM_CV1800_MAXPERIOD         0x3fffffff
> > +#define PWM_CV1800_MINPERIOD         2
> > +#define PWM_CV1800_CHANNELS          4
> > +#define PWM_CV1800_PERIOD_RESET      BIT(1)
> > +#define PWM_CV1800_HLPERIOD_RESET    BIT(0)
> > +#define PWM_CV1800_REG_DISABLE       0x00U
> > +#define PWM_CV1800_REG_ENABLE(n)     (BIT(0) << (n))
> > +
> > +struct cv1800_pwm {
> > +     struct regmap *map;
> > +     struct clk *clk;
> > +     unsigned long clk_rate;
> > +};
> > +
> > +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *ch=
ip)
> > +{
> > +     return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          bool enable)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 pwm_enable;
> > +
> > +     regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
> > +     pwm_enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> > +
> > +     /*
> > +      * If the parameters are changed during runtime, Register needs
> > +      * to be updated to take effect.
> > +      */
> > +     if (pwm_enable && enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> > +                                PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +             regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> > +                                PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     } else if (!pwm_enable && enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +     } else if (pwm_enable && !enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void cv1800_pwm_set_polarity(struct pwm_chip *chip,
> > +                                 struct pwm_device *pwm,
> > +                                 enum pwm_polarity polarity)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 config_polarity =3D 0;
> > +
> > +     if (pwm->state.enabled)
> > +             cv1800_pwm_enable(chip, pwm, !pwm->state.enabled);
> > +
> > +     if (polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             config_polarity =3D  PWM_CV1800_POLARITY_MASK(pwm->hwpwm)=
;
> > +
> > +     regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
> > +                        PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
> > +                        config_polarity);
> > +}
> > +
> > +/**
> > + * cv1800_pwm_set_oe() - check and config nth channal output-enable/OE=
 mode
> > + * @chip: PWM chip
> > + * @pwm: PWM device
> > + * @mode: The nth bit of the mode represents the output-enable/OE mode
> > + *        of the nth channal. 1 represents output mode, 0 represents
> > + *        input mode.
> > + */
> > +static void cv1800_pwm_set_oe(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           u32 mode)
>
> Did you get any information about the capture support pwm controller?
>
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 state;
> > +
> > +     regmap_read(priv->map, PWM_CV1800_OE, &state);
> > +     state &=3D PWM_CV1800_OE_MASK(pwm->hwpwm);
> > +
> > +     if (state =3D=3D mode)
> > +             return;
> > +
> > +     /* disenable pwm output before changing output mode */
> > +     cv1800_pwm_enable(chip, pwm, false);
> > +
> > +     regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                        PWM_CV1800_OE_MASK(pwm->hwpwm), mode);
> > +}
> > +
> > +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val;
> > +     u64 ticks;
> > +
> > +     cv1800_pwm_set_oe(chip, pwm, PWM_CV1800_OE_MASK(pwm->hwpwm));
>
> If no capture support, I don't think we need to take care OE, could it
> be done during init?
>

Currently, there is no support for capturing callbacks. you're right,
by default, the
channel is in the output state, it can be initialized as an output
state in the probe.
I will carefully consider your opinion.

Best regards,
Jingbao Qiu

