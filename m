Return-Path: <linux-kernel+bounces-72933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB37585BAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3861C2433B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3267E83;
	Tue, 20 Feb 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBa9qCxb"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA667E6B;
	Tue, 20 Feb 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429491; cv=none; b=EvQFcWdmDwRtGOBb6bAIJotcPiBnA/Z9UHNPQmGsxeAhvurdCAOpX2rMX8h7E5FUyJtmzDqnqRoOoKy7OoICzsoRldlgSqgVTsEFKtgufpj9O89i6+9eFI+5dYHxPSuB5rvSNQCFst5tmyyF+ypuXCWhXOL3vuuFb4zvlLlacd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429491; c=relaxed/simple;
	bh=u8NlyapnNc6JqE5jvPSW96xkHzJJJHYbWhJ2wxqVaZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+A4lh9yY2vMdlgO/hpdWAOYpV54AxybXDVapig+fXh3WotkZ9nEiZNFAPN/d6+n30Lr1nSXg/C1VDEhwvnlvKR0owZjpO3iTt3JNWxDHeDv927J8eEu64Auzs97398REKun79f1u9d0BAeGvt+SjNU2opxzBXQ6vCVnqJwxNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBa9qCxb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2f0d6c82eso1650808a34.2;
        Tue, 20 Feb 2024 03:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708429488; x=1709034288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUcGIro5WLoekC5KppRiU2TXdVc4DYZE/u0zVdSGu8g=;
        b=BBa9qCxbea31WAbPH/I3L+8SG/vgkSwwhg1aFDxV2WhQaRIXrufMDFEnJ3gXhHHhNh
         btM/neoJMNHXYmwquPZx+a4u0NUyBcrNmntXvXJbSSq+R2biOuknKvTZ/MHafb7RguYS
         3Ik5O6Tc+xe0VIHVc5QYoxWi6zOPdDphFrXuFsnJWZ7PTjRN0bWgrT8S5ktuH6DJI+V7
         4Sy0vN6mKzn611orVyJgRsiFubn1Fp4AJG12INu83TJGcigzv/Fdn3qSeL8i2VuKIps9
         OhpXkg5dAfgy5k3A2vswQ8eble+DJbJgjB3Vj5gjCglXptseliFSayI6Ilh3QZ+bKXfa
         x/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429488; x=1709034288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUcGIro5WLoekC5KppRiU2TXdVc4DYZE/u0zVdSGu8g=;
        b=J35N15SD1Yss/48i2o+F3CuT8SQ8L+GTqIIlWglLenzRcOOVwsm2HP4G56d09FlIdt
         woUIjW/LgEWTIPRFc1npC4TS05PxWH6uaivZz3/cpfqKEMUO+iQcmIIY1/t/DxZKXe37
         gC94yBAsDVtd/jpwanY2Tpnt4mSkl8xiEbwTYrh75/wDDcqKHvm/bmLsaxmvqoNIhUlj
         RZOpIdYsFAxgAbFRRuP7K/zmFZeLSCErYbHPrmG/51ZewT1HHuKBFDoXToEwxGJPKaF/
         GvdEC1ZSiMn+LcZNypTmtAymGbD+C5JgqXbJQDtJnh6IoVWPP6iPHNLoquOsKusR1hq/
         oabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFarHfLt3W+KtIS86ZpW2O6XgMrmxojAJNtKUqbDnWejT+E5nQ15lMAyFG9PLZFlE/Ada2wMCtL4hp5lYbUxM9dMotQuYVSmG3U8sgxi/x9W9k5OpsMbwyOJLjCAh2/uMelTG6yinB/TGWde4VeKF1tcGa68BMBHF7u1zOLT197FhphA==
X-Gm-Message-State: AOJu0YwpnlPQ4TvaL/nJGVYl8aaUGcUtI+9EQYhxfSpI9Zh3jLvkvNfd
	DE8WmRC3bGez/aWf4ECQujCtJneQbCj4X0URj5xZH/g9CmZbJHmiK8dhdN23yuk4YaVF1GSs1+t
	tQV0kuLUV/2XGW6mmMEhTaID4Kq0=
X-Google-Smtp-Source: AGHT+IHVL6NrwdvAXz1SJ0J88EgTMp8U1Ew95VIjLmWd0lsQv0ykQoECjp1LqCnc7kD+2EBWcyCPVhWgyoe5TdpV7E8=
X-Received: by 2002:a05:6830:183:b0:6e2:fb6d:db51 with SMTP id
 q3-20020a056830018300b006e2fb6ddb51mr13679234ota.3.1708429487703; Tue, 20 Feb
 2024 03:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
 <20240212121729.1086718-3-qiujingbao.dlmu@gmail.com> <54cwiddo4rsfgryxcgrniauwu2jqfynatmw5i7fzssbxm7txbp@cydhntyrls4p>
In-Reply-To: <54cwiddo4rsfgryxcgrniauwu2jqfynatmw5i7fzssbxm7txbp@cydhntyrls4p>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 20 Feb 2024 19:44:36 +0800
Message-ID: <CAJRtX8RfTCZt3Dfz9AEbamDDy-nGpJi+FKFROE4o9TMM+syyjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:48=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Mon, Feb 12, 2024 at 08:17:29PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 248 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 259 insertions(+)
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
> > index 000000000000..3d7f2ff3a6c2
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * pwm-cv1800.c: PWM driver for Sophgo cv1800
> > + *
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
> > +#define PWM_CV1800_HLPERIOD_BASE       0x00
> > +#define PWM_CV1800_PERIOD_BASE         0x04
> > +#define PWM_CV1800_PWM_CV1800_POLARITY 0x40
> > +#define PWM_CV1800_START               0x44
> > +#define PWM_CV1800_DONE                0x48
> > +#define PWM_CV1800_UPDATE              0x4c
> > +#define PWM_CV1800_OE                  0xd0
> > +#define PWM_CV1800_HLPERIOD_SHIFT      0x08
> > +#define PWM_CV1800_PERIOD_SHIFT        0x08
> > +
> > +#define PWM_CV1800_HLPERIOD(n)         \
> > +     (PWM_CV1800_HLPERIOD_BASE + ((n) * PWM_CV1800_HLPERIOD_SHIFT))
> > +#define PWM_CV1800_PERIOD(n)           \
> > +     (PWM_CV1800_PERIOD_BASE + ((n) * PWM_CV1800_PERIOD_SHIFT))
>
> I would have used a plain 0x08 instead of PWM_CV1800_HLPERIOD_SHIFT and
> PWM_CV1800_PERIOD_SHIFT.

I will fix it.

>
> > +#define PWM_CV1800_UPDATE_MASK(n) (BIT(0) << (n))
> > +#define PWM_CV1800_OE_MASK(n)     (BIT(0) << (n))
> > +#define PWM_CV1800_START_MASK(n)  (BIT(0) << (n))
> > +
> > +#define PWM_CV1800_MAXPERIOD      (BIT(30) - 1)
> > +#define PWM_CV1800_MINPERIOD      BIT(1)
> > +#define PWM_CV1800_MINHLPERIOD    BIT(0)
> > +#define PWM_CV1800_PERIOD_RESET   BIT(1)
> > +#define PWM_CV1800_HLPERIOD_RESET BIT(0)
> > +#define PWM_CV1800_REG_DISABLE    0x0U
> > +#define PWM_CV1800_REG_ENABLE(n)  (BIT(0) << (n))
> > +
> > +struct cv1800_pwm {
> > +     struct pwm_chip chip;
> > +     struct regmap *map;
> > +     struct clk *clk;
> > +     unsigned long clk_rate;
> > +};
> > +
> > +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *ch=
ip)
> > +{
> > +     return container_of(chip, struct cv1800_pwm, chip);
>
> Please rework the driver to use pwmchip_alloc(). See
> https://lore.kernel.org/linux-pwm/a37a167364366b6cbe2dd299dce02731706213b=
2.1707900770.git.u.kleine-koenig@pengutronix.de/T/#u
> for a simple example for such a rework.
>

I will fix it.

> > +}
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
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +     } else if (pwm_enable && !enable) {
> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +             regmap_update_bits(priv->map, PWM_CV1800_START,
> > +                                PWM_CV1800_START_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_DISABLE);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         const struct pwm_state *state)
> > +{
> > +     struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> > +     u32 period_val, hlperiod_val;
> > +     u64 tem;
> > +
> > +     if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +             return -EINVAL;
> > +
> > +     tem =3D mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_P=
ER_SEC);
> > +     if (tem > PWM_CV1800_MAXPERIOD || tem < PWM_CV1800_MINPERIOD)
> > +             return -EINVAL;
>
> Please use:
>
>         if (tem < PWM_CV1800_MINPERIOD)
>                 return -EINVAL
>         if (tem > PWM_CV1800_MAXPERIOD)
>                 tem =3D PWM_CV1800_MAXPERIOD;
>

I will fix it.

> > +     period_val =3D (u32)tem;
> > +
> > +     tem =3D mul_u64_u64_div_u64(state->period - state->duty_cycle,
> > +                               priv->clk_rate, NSEC_PER_SEC);
>
> Given that you're supposed to configure the biggest duty_cycle not
> bigger than the requested value, you have to round up here.
>

I will fix it.
Thank you for your patient reply.

Best regards
Jingbao Qiu

