Return-Path: <linux-kernel+bounces-163325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFD8B697D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284141C21A96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469C11702;
	Tue, 30 Apr 2024 04:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lni58lhF"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5479DE;
	Tue, 30 Apr 2024 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451831; cv=none; b=al7/PeO2VeAbDT2IQtEkoKPnazMRgKEnHt2pB5se/VsFUUKbX5D1uJfxhKdfYI2zrLV4B9fHTNEyEOi4naARwK3Pn06sZ5S6kaTWkKyCHod5x4tzWtgVI2TxUU38DDgVcGFtfUfNP5MAZSAmma2zqZ8QaGHrGyIbbCpZwX18Zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451831; c=relaxed/simple;
	bh=ZN7Zq+jiw7Kjs/LYwfdHP/3ry2hvJCD2BKi3S3GlNLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGeCrZFk3oYA4AbFbudDzKFgkFt5XVcMkv9LVqwiJZRBbgmxE3I9dtZOKOrfNGFUPEAe+fc9+wE1ds40BiWtX0+rOliHmzDS/xNO4Fv4JQT6N79O9sb97sohr3Fg//m/LGCYaLLsCb6UJ5RUq4chS056nfqosi0YOzTFi4iiEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lni58lhF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5af27a0dde1so3343320eaf.3;
        Mon, 29 Apr 2024 21:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714451828; x=1715056628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MUvhJfdV6HNHsUortMTUYfgCW5/FmZUUA2yG0TvW7Q=;
        b=Lni58lhFieDXuF/xJdZjiiuIsUosxsu2kK6xqaLVyPEDJVXcEuZ3ZMAnSxFhd9o/ox
         FpCsl7ZoI93I6zHYNTYG9JRH3BF496EDNEAm5lbOYGevDxUELPMLPWlGJRsrGUSn1kE0
         BAsbsTlBPHJdavPisvA5+fMEltz+GAHyklBS1sYC5G3j2TvYCXghTLzaIw0DDKCRMeKw
         xU/f5x8g7btxLfGLPC4ayigjaqPWn0Z9LfSSRxXaEBE2EllXh/rmUNiE4yvT8JQiwvjx
         BHdExhevR8WqH4OAFGjsOHYNZRSKvmHQUUe+el8+hmkOSvJzBIhc/0utPnX2SBSO/lmo
         uY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451828; x=1715056628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MUvhJfdV6HNHsUortMTUYfgCW5/FmZUUA2yG0TvW7Q=;
        b=I05bYLItcgEAhFJ52o1qKj1p3cntM76VkM4xeElhcNCpMNK4lE2la5NAasijuOWLUg
         HeecJL6Jbp9TFJV5+9UVhKrb5l7lKt8N7Tv1bMs2q80FUCdyYkFkuSYGdjb5igjElLHf
         E1CnYp2tnCUbw6twW6gxGWqpJu5wR7VWGaWibOcM5OKVnxnqPZQOb5eVPCYZCDBVkoVC
         5XcYeuKAP/CRA19S0taPEQxg7Dd+OhfqszsvIRrtQ3J7TVIXjal32CvUgv19YZqYAUgP
         l9QX2F2d0q8nK9t2l2YtjrMjHv6Ww9iXrcxDU+N2Dab3WqqKWgHTM4xCC6hoeNZZq/th
         qvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXufl8Sqip4PZWM1UaHJ56CVQJESLhAGIG1+IpDQDAEOsT1nLeKP3Nq6RBWcM8RY2yGwLm8iwqrJMa7+xRRWSZ+1zrplyKMoli1WAK9oux9pYD33WRjbkxhZ0lHw2O+ZBNEa30u6bE14RIwlFU4F6k9qdK7tPN1aFn2tyJ8uGNSws6c/A==
X-Gm-Message-State: AOJu0YytCyCZaXb1evOCYRs+16ZazJFQHmekgan4o1SG+9O71D5M1tNM
	U81COoyfTlPF2vC0InYHH5KlfVeI9O8FkCsU2hoils2Lt8E8L3j4YcxGimVMUkMDHBNZOSmy0xJ
	4rs5mc2XRXoTuZkITxD+OND2iJ5W/rUv4m4w=
X-Google-Smtp-Source: AGHT+IHn4gh/sB1tEugAYrmg5GZjqdVSjS4c8zKVmn67NjF6sglhqekaIgD8LjH89RZR6dOSsOOaU3lnGy85arhHTl4=
X-Received: by 2002:a4a:8c10:0:b0:5aa:6404:936a with SMTP id
 u16-20020a4a8c10000000b005aa6404936amr13212891ooj.5.1714451828143; Mon, 29
 Apr 2024 21:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406063413.3334639-1-qiujingbao.dlmu@gmail.com>
 <20240406063413.3334639-3-qiujingbao.dlmu@gmail.com> <njsvev4dxjln2guw3lr5zwvytzvvmj7qcuduo2v56dhvuxujs4@eqm4cmh6ddva>
In-Reply-To: <njsvev4dxjln2guw3lr5zwvytzvvmj7qcuduo2v56dhvuxujs4@eqm4cmh6ddva>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 30 Apr 2024 12:36:56 +0800
Message-ID: <CAJRtX8So3PifNFfsnq1BmP3+8kevhM6Fk6moMp=wFX4o8q89SQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uwe

On Mon, Apr 29, 2024 at 10:54=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sat, Apr 06, 2024 at 02:34:13PM +0800, Jingbao Qiu wrote:
> > Implement the PWM driver for CV1800.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-cv1800.c | 296 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 307 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-cv1800.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 1dd7921194f5..3869ca022aeb 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -182,6 +182,16 @@ config PWM_CROS_EC
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
> > index 90913519f11a..6295e2259efc 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_PWM_CLK)               +=3D pwm-clk.o
> >  obj-$(CONFIG_PWM_CLPS711X)   +=3D pwm-clps711x.o
> >  obj-$(CONFIG_PWM_CRC)                +=3D pwm-crc.o
> >  obj-$(CONFIG_PWM_CROS_EC)    +=3D pwm-cros-ec.o
> > +obj-$(CONFIG_PWM_CV1800)     +=3D pwm-cv1800.o
> >  obj-$(CONFIG_PWM_DWC_CORE)   +=3D pwm-dwc-core.o
> >  obj-$(CONFIG_PWM_DWC)                +=3D pwm-dwc.o
> >  obj-$(CONFIG_PWM_EP93XX)     +=3D pwm-ep93xx.o
> > diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> > new file mode 100644
> > index 000000000000..37a6be3f63aa
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-cv1800.c
> > @@ -0,0 +1,296 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Sophgo CV1800 PWM driver
> > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > + *
> > + * Limitations:
> > + * - It output low when PWM channel disabled.
>
> Just to be sure: the output is low independant of the POLARITY register?

When the value of the POLARITY register is 1, the PWM outputs a high level.
When the value of the POLARITY register is 0, the PWM output is low.
Should I make this point here?

>
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
> > +#define PWM_CV1800_HLPERIOD_BASE    0x00
> > +#define PWM_CV1800_PERIOD_BASE      0x04
> > +#define PWM_CV1800_POLARITY         0x40
> > +#define PWM_CV1800_START            0x44
> > +#define PWM_CV1800_DONE             0x48
> > +#define PWM_CV1800_UPDATE           0x4c
> > +#define PWM_CV1800_OE               0xd0
> > +
> > +#define PWM_CV1800_HLPERIOD(n)      (PWM_CV1800_HLPERIOD_BASE + ((n)*0=
x08))
> > +#define PWM_CV1800_PERIOD(n)        (PWM_CV1800_PERIOD_BASE + ((n)*0x0=
8))
> > +
> > +#define PWM_CV1800_UPDATE_MASK(n)   (BIT(0) << (n))
> > +#define PWM_CV1800_OE_MASK(n)       (BIT(0) << (n))
> > +#define PWM_CV1800_START_MASK(n)    (BIT(0) << (n))
> > +#define PWM_CV1800_POLARITY_MASK(n) (BIT(0) << (n))
> > +
> > +#define PWM_CV1800_MAXPERIOD        0x3fffffff
> > +#define PWM_CV1800_MINPERIOD        2
> > +#define PWM_CV1800_CHANNELS         4
> > +#define PWM_CV1800_PERIOD_RESET     BIT(1)
> > +#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
> > +#define PWM_CV1800_REG_DISABLE      0x00U
> > +#define PWM_CV1800_REG_ENABLE(n)    (BIT(0) << (n))
>
> BIT(n)?

yes, I will fix it.

>
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
> > +     u32 pwm_enable, state;
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
>
> I think using a plain 0 instead of PWM_CV1800_REG_DISABLE would be a tad
> clearer.

I will fix it.

>
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
> > +     /* check and set OE/Output-Enable mode */
> > +     regmap_read(priv->map, PWM_CV1800_OE, &state);
> > +     state &=3D PWM_CV1800_OE_MASK(pwm->hwpwm);
> > +
> > +     if (state =3D=3D PWM_CV1800_REG_DISABLE && enable)
>
> Here I'd use:
>
>         regmap_read(priv->map, PWM_CV1800_OE, &state);
>
>         if ((state & BIT(pwm->hwpwm)) && enable)
>

I will fix it.

> > +             regmap_update_bits(priv->map, PWM_CV1800_OE,
> > +                                PWM_CV1800_OE_MASK(pwm->hwpwm),
> > +                                PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> > +
> > +     return 0;
> > +}
> > +
> > [...]
> > +static int cv1800_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cv1800_pwm *priv;
> > +     struct pwm_chip *chip;
> > +     void __iomem *base;
> > +     int ret;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, PWM_CV1800_CHANNELS, sizeof(*pri=
v));
> > +     if (!chip)
> > +             return PTR_ERR(chip);
> > +     priv =3D to_cv1800_pwm_dev(chip);
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     priv->map =3D devm_regmap_init_mmio(&pdev->dev, base,
> > +                                       &cv1800_pwm_regmap_config);
> > +     if (IS_ERR(priv->map))
> > +             return PTR_ERR(priv->map);
>
> devm_regmap_init_mmio() doesnt' emit an error message on failure, so
> please add one here.

I will fix it.

Thank you for your suggestion.

Best regards
Jingbao Qiu

