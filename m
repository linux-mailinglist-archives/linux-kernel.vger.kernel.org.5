Return-Path: <linux-kernel+bounces-72601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F785B5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BABF1C23D30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CC5F57C;
	Tue, 20 Feb 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsTGgmlS"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAA5F492;
	Tue, 20 Feb 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419018; cv=none; b=GP3Mu1QW0tiqUZHzPA3AWZ3SifhhDhSRdjSCDNyoSrZ44+GKTXcOLdeBDNbAfOjdL3m0OmOIGwVdmAs9jh4YCRhRmMSG4yt0bfC0VsxI+fszKZNEQQv1TbQOd8QyRQtgSwjNkk4Go/4uCzj4JSUJuuB77drUvEb3moKOwSXC4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419018; c=relaxed/simple;
	bh=Cd1y/rChrSDGUSk0PfL9IEV+460/jQJCxZCP3pTca4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKbUP8wVrZQJb8hO6QJZaFc86peJXqePQoO3A//dl76yTx0wgp/85LxUaTf3mqfqNk2uIA1XTUobr9/c4p+JvqE0rSV7KZd1gtQx6xn1tRgPDpkYfxLvk/7qhpVqj7DtwtKKNDAtpfB5wZX5oAkRS8IIKPtKUbTKD6k7g9mIIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsTGgmlS; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59d78deb469so3284430eaf.1;
        Tue, 20 Feb 2024 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419015; x=1709023815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISjtOW1rVch6OpIclD9zs0LraDCkma/k5yMSLlAqjcE=;
        b=UsTGgmlSSA0DYglBvmeLVMOnVpAEhQIBpB2Ot5BBcIjqD+BivBkEyEu5sqdE1RJHN2
         K3qVH/EJvRbQE7G6Q2ImVPG+XQ6WyRTCiNLpjA9b9Y1hZ5fg5qHT11m4lTlEa3fIJmDs
         tvtYnn7XohFXa1E/Fd3XjD6nmgE6FZWoN+NQ8c3KBypBmQ7bNhn5nssvRe8tUXh3J/9S
         Y3KFj4CcyYuq7X0rZ+wafTFHS/pgutBz/UGiWYypcGOwmO2N6KuO8LmGjDq1dK5KBxdt
         Dzkc7uKuMnS4A+CaXocrPpnO7T4+y5Ol2eJapCst7PfOq5l2HMTyJuQR7ibl5T29X7oq
         QVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419015; x=1709023815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISjtOW1rVch6OpIclD9zs0LraDCkma/k5yMSLlAqjcE=;
        b=k8wKNZwqw9MuIdA/tCN0uEFT0Liwd/n+SFaCWPHQjMFc+t7fIMj2OmMyWSmLmWFO4x
         D/oAEOl+ceY/EPhh9iGDazh4q+UKffjVKQn73e6pW9XiC0RvG/WYw1UKQd2zdWXSiKj5
         mW6CeEuRV4fPQF7HejuZHf/404t4PB/qVXQwOlucjYGMzHvxjc2bzFXJh4bD//V8146c
         quMKr1J0sXsO/rclt8RkHeF83xAnhYN/FjjQthULyaGUUVo4DdedSh5j0dyLe3Gnnyij
         Y3AgfSaNVbmchPtKIntV0ttKZGK2wbtzoL7FuP+UQLjCXzwnAspf8BVWSKvNSIG49nbH
         xBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEfJ0RckReySpRhE4Ccf0xGP02qBuqUTv3oicpvLFpybktPlWV43nfkm2WGSUfQGBi7QUlfAX0CoeOoYTk123ZcyKUdJoOnGJ+XAwmZJMoO8ggOhofUh67iWaJb8sBCGy7pL+U5/MCdA==
X-Gm-Message-State: AOJu0YyOV2VKBN6qsoyJLyQifacy0SWuTI7JCPFpfWleF1PPY1hy+Js5
	g7kMWnvI0jFlRoGJ+2DrOkHWvKbqhiRZ99XviSAYU08ZjdKIprecG9zqqjXr5bqSh8hLXXTa+me
	kntuAiAZR9CgKrCoCTcTYwlMXxsU=
X-Google-Smtp-Source: AGHT+IHUeUUD1us0WTBbLO42YcQrKgDTE54WFKhsrE0OQVLIDgt8TfmP4k04V7d7sglhDpBt3cEXJn747PW1XMCZ73U=
X-Received: by 2002:a4a:a8cc:0:b0:59f:8464:b004 with SMTP id
 r12-20020a4aa8cc000000b0059f8464b004mr11975539oom.0.1708419014633; Tue, 20
 Feb 2024 00:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com> <20240212121729.1086718-3-qiujingbao.dlmu@gmail.com>
In-Reply-To: <20240212121729.1086718-3-qiujingbao.dlmu@gmail.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 20 Feb 2024 16:50:03 +0800
Message-ID: <CAJRtX8TKfSf9BxTKrrDmOp=7aXOYXKgZ89PF7En_UvYOTkfi+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

Gentle ping. Could you share some comments on this patch?

Best regards,
Jingbao Qiu

On Mon, Feb 12, 2024 at 8:17=E2=80=AFPM Jingbao Qiu <qiujingbao.dlmu@gmail.=
com> wrote:
>
> Implement the PWM driver for CV1800.
>
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-cv1800.c | 248 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 259 insertions(+)
>  create mode 100644 drivers/pwm/pwm-cv1800.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..455f07af94f7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -186,6 +186,16 @@ config PWM_CROS_EC
>           PWM driver for exposing a PWM attached to the ChromeOS Embedded
>           Controller.
>
> +config PWM_CV1800
> +       tristate "Sophgo CV1800 PWM driver"
> +       depends on ARCH_SOPHGO || COMPILE_TEST
> +       help
> +         Generic PWM framework driver for the Sophgo CV1800 series
> +         SoCs.
> +
> +         To compile this driver as a module, build the dependecies
> +         as modules, this will be called pwm-cv1800.
> +
>  config PWM_DWC_CORE
>         tristate
>         depends on HAS_IOMEM
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..6c3c4a07a316 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)         +=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)     +=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)          +=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)      +=3D pwm-cros-ec.o
> +obj-$(CONFIG_PWM_CV1800)       +=3D pwm-cv1800.o
>  obj-$(CONFIG_PWM_DWC_CORE)     +=3D pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)          +=3D pwm-dwc.o
>  obj-$(CONFIG_PWM_EP93XX)       +=3D pwm-ep93xx.o
> diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
> new file mode 100644
> index 000000000000..3d7f2ff3a6c2
> --- /dev/null
> +++ b/drivers/pwm/pwm-cv1800.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * pwm-cv1800.c: PWM driver for Sophgo cv1800
> + *
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + *
> + * Limitations:
> + * - It output low when PWM channel disabled.
> + * - This pwm device supports dynamic loading of PWM parameters. When PW=
MSTART
> + *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) wil=
l be
> + *   temporarily stored inside the PWM. If you want to dynamically chang=
e the
> + *   waveform during PWM output, after writing the new value to HLPERIOD=
n and
> + *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value e=
ffective.
> + * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1)=
.
> + * - By setting HLPERIODn to 0, can produce 100% duty cycle.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_CV1800_HLPERIOD_BASE       0x00
> +#define PWM_CV1800_PERIOD_BASE         0x04
> +#define PWM_CV1800_PWM_CV1800_POLARITY 0x40
> +#define PWM_CV1800_START               0x44
> +#define PWM_CV1800_DONE                0x48
> +#define PWM_CV1800_UPDATE              0x4c
> +#define PWM_CV1800_OE                  0xd0
> +#define PWM_CV1800_HLPERIOD_SHIFT      0x08
> +#define PWM_CV1800_PERIOD_SHIFT        0x08
> +
> +#define PWM_CV1800_HLPERIOD(n)         \
> +       (PWM_CV1800_HLPERIOD_BASE + ((n) * PWM_CV1800_HLPERIOD_SHIFT))
> +#define PWM_CV1800_PERIOD(n)           \
> +       (PWM_CV1800_PERIOD_BASE + ((n) * PWM_CV1800_PERIOD_SHIFT))
> +
> +#define PWM_CV1800_UPDATE_MASK(n) (BIT(0) << (n))
> +#define PWM_CV1800_OE_MASK(n)     (BIT(0) << (n))
> +#define PWM_CV1800_START_MASK(n)  (BIT(0) << (n))
> +
> +#define PWM_CV1800_MAXPERIOD      (BIT(30) - 1)
> +#define PWM_CV1800_MINPERIOD      BIT(1)
> +#define PWM_CV1800_MINHLPERIOD    BIT(0)
> +#define PWM_CV1800_PERIOD_RESET   BIT(1)
> +#define PWM_CV1800_HLPERIOD_RESET BIT(0)
> +#define PWM_CV1800_REG_DISABLE    0x0U
> +#define PWM_CV1800_REG_ENABLE(n)  (BIT(0) << (n))
> +
> +struct cv1800_pwm {
> +       struct pwm_chip chip;
> +       struct regmap *map;
> +       struct clk *clk;
> +       unsigned long clk_rate;
> +};
> +
> +static const struct regmap_config cv1800_pwm_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +};
> +
> +static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip=
)
> +{
> +       return container_of(chip, struct cv1800_pwm, chip);
> +}
> +
> +static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +                            bool enable)
> +{
> +       struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> +       u32 pwm_enable;
> +
> +       regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
> +       pwm_enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> +
> +       /*
> +        * If the parameters are changed during runtime, Register needs
> +        * to be updated to take effect.
> +        */
> +       if (pwm_enable && enable) {
> +               regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +                                  PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +               regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
> +                                  PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_DISABLE);
> +       } else if (!pwm_enable && enable) {
> +               regmap_update_bits(priv->map, PWM_CV1800_OE,
> +                                  PWM_CV1800_OE_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +               regmap_update_bits(priv->map, PWM_CV1800_START,
> +                                  PWM_CV1800_START_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_ENABLE(pwm->hwpwm));
> +       } else if (pwm_enable && !enable) {
> +               regmap_update_bits(priv->map, PWM_CV1800_OE,
> +                                  PWM_CV1800_OE_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_DISABLE);
> +               regmap_update_bits(priv->map, PWM_CV1800_START,
> +                                  PWM_CV1800_START_MASK(pwm->hwpwm),
> +                                  PWM_CV1800_REG_DISABLE);
> +       }
> +
> +       return 0;
> +}
> +
> +static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +                           const struct pwm_state *state)
> +{
> +       struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> +       u32 period_val, hlperiod_val;
> +       u64 tem;
> +
> +       if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +               return -EINVAL;
> +
> +       tem =3D mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_P=
ER_SEC);
> +       if (tem > PWM_CV1800_MAXPERIOD || tem < PWM_CV1800_MINPERIOD)
> +               return -EINVAL;
> +       period_val =3D (u32)tem;
> +
> +       tem =3D mul_u64_u64_div_u64(state->period - state->duty_cycle,
> +                                 priv->clk_rate, NSEC_PER_SEC);
> +       if (tem > period_val)
> +               return -EINVAL;
> +       hlperiod_val =3D (u32)tem;
> +
> +       regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val=
);
> +       regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod=
_val);
> +
> +       cv1800_pwm_enable(chip, pwm, state->enabled);
> +
> +       return 0;
> +}
> +
> +static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +                               struct pwm_state *state)
> +{
> +       struct cv1800_pwm *priv =3D to_cv1800_pwm_dev(chip);
> +       u32 period_val, hlperiod_val;
> +       u64 period_ns =3D 0;
> +       u64 duty_ns =3D 0;
> +       u32 enable =3D 0;
> +
> +       regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val=
);
> +       regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod=
_val);
> +
> +       if (period_val !=3D PWM_CV1800_PERIOD_RESET ||
> +           hlperiod_val !=3D PWM_CV1800_HLPERIOD_RESET) {
> +               period_ns =3D DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,=
 priv->clk_rate);
> +               duty_ns =3D DIV_ROUND_UP_ULL(hlperiod_val * period_ns, pe=
riod_val);
> +
> +               regmap_read(priv->map, PWM_CV1800_START, &enable);
> +
> +               enable &=3D PWM_CV1800_START_MASK(pwm->hwpwm);
> +       }
> +
> +       state->period =3D period_ns;
> +       state->duty_cycle =3D duty_ns;
> +       state->enabled =3D enable;
> +       state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +       return 0;
> +}
> +
> +static const struct pwm_ops cv1800_pwm_ops =3D {
> +       .apply =3D cv1800_pwm_apply,
> +       .get_state =3D cv1800_pwm_get_state,
> +};
> +
> +static void devm_clk_rate_exclusive_put(void *data)
> +{
> +       struct clk *clk =3D data;
> +
> +       clk_rate_exclusive_put(clk);
> +}
> +
> +static int cv1800_pwm_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct cv1800_pwm *priv;
> +       void __iomem *base;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->map =3D devm_regmap_init_mmio(&pdev->dev, base,
> +                                         &cv1800_pwm_regmap_config);
> +       if (IS_ERR(priv->map))
> +               return PTR_ERR(priv->map);
> +
> +       priv->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +                                    "clk not found\n");
> +
> +       ret =3D clk_rate_exclusive_get(priv->clk);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "failed to get exclusive rate\n");
> +
> +       ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclus=
ive_put,
> +                                      priv->clk);
> +       if (ret) {
> +               clk_rate_exclusive_put(priv->clk);
> +               return ret;
> +       }
> +
> +       priv->clk_rate =3D clk_get_rate(priv->clk);
> +       if (!priv->clk_rate)
> +               return dev_err_probe(&pdev->dev, -EINVAL,
> +                                    "Invalid clock rate: %lu\n", priv->c=
lk_rate);
> +
> +       priv->chip.dev =3D dev;
> +       priv->chip.ops =3D &cv1800_pwm_ops;
> +       priv->chip.npwm =3D 4;
> +       priv->chip.atomic =3D true;
> +
> +       return devm_pwmchip_add(dev, &priv->chip);
> +}
> +
> +static const struct of_device_id cv1800_pwm_dt_ids[] =3D {
> +       { .compatible =3D "sophgo,cv1800-pwm" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
> +
> +static struct platform_driver cv1800_pwm_driver =3D {
> +       .driver =3D {
> +               .name =3D "cv1800-pwm",
> +               .of_match_table =3D cv1800_pwm_dt_ids,
> +       },
> +       .probe =3D cv1800_pwm_probe,
> +};
> +module_platform_driver(cv1800_pwm_driver);
> +
> +MODULE_AUTHOR("Jingbao Qiu");
> +MODULE_DESCRIPTION("Sophgo cv1800 PWM Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>

