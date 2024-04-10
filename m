Return-Path: <linux-kernel+bounces-138945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C289FC64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51581F21AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4916F0CC;
	Wed, 10 Apr 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9uR8xEq"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8C16F0F7;
	Wed, 10 Apr 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764843; cv=none; b=QpIg8si3qxfTE/Phg/Y4xfPYxTn1MLOhfLQGhTvyrPoTokqe26PB7XvdJnmQ9oEaH/I9qT73RvBkQ9g8UQdMuB/4zW7aNeyX1JxVvXwGsnQFLgonQyWkHWe64L7S4UFs5e6623eAZK+OP4XdKGPYDuoAnq9PxJb3OleJ09x4pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764843; c=relaxed/simple;
	bh=Lg8ZLX35H41RWjwo6tGdMSwExU6jijt9qhVZP6f5lYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFlRRWeqVwpyoCKSmpOvnu6jgQIiRb3D5ZY5/bnoKFfMM6ffN8aWUw98kUk+7UhDNL3zQyUth0o+Hfjiilx0xRwRfuBPPvoeS27QrCy/6Bkq6zJ25cLYa5y1Ug+HUtWbK0xynZcbHzDScek2kDxtF5uB3ZjPZo+8i3wqWRhabF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9uR8xEq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516db2214e6so5941046e87.1;
        Wed, 10 Apr 2024 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764839; x=1713369639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKWbmnv6SxDP9tlVgHINWCDu40XftNmGokOibIuXS38=;
        b=A9uR8xEqpqz7FTOX6Ry7e5SaRe3jT4vWBqnM2EaV7QA1SElN3xwjtm6JQ4PotstoTj
         kNzrUWswWAngF/O7KKGJsmBd2qXhFWxlJYL/9JrCily25Kq+IrDwBka/F7u/HnQYnLsH
         yJsdscRtJbg5+iMp0gIp0sWXDtBsQwF45vKe5GrSMo3EaZrkjvVIUdkhERBdvbSSS7mT
         sE+URFqD3j2bNRalrHb9tZgMIEjTN2V1SBtG4mJkDL6oHcocawRpaV+glkVeIlfZtPKJ
         PqnTZZbYZcp0+j2vDPTgbmyPjkP/lgV3It0CdftnoFUFmCUfl2a2X5uwARhqwAgZ4nHH
         0yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764839; x=1713369639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKWbmnv6SxDP9tlVgHINWCDu40XftNmGokOibIuXS38=;
        b=XtQAs0N9XLuEtFxD+ZxPJs7WPrzyoBFBEIkexxgg7BO4mQ1uzfyxEFxCwEMTHK/uK6
         0KoE/a74NpapHfuKy7UHKQBUk/0mG0q1yk3AgS1ReshNlnGpuml/YPcxL1PGBzQsPoCd
         QUyrwPS7PIQLBMiXlTnZtmrqby82Yr6DXP6ZR+lLo/RejlRUOlu8LerbTskn0OhbW5vI
         o6N+F2VBg2IR3RMO0JYUpJ9bG+5mm+RiYChODGtjj8W1QtLimQwquxf4Q3fbGPw6qhIz
         8X2AZsUWQhqsKW8SHGHmUwd0TAjFL5gutU1J94y/3Q1/RhQ0ElN1IIgGU4pd9wmciYTG
         Trvg==
X-Forwarded-Encrypted: i=1; AJvYcCXGvVzlaIkK4sbK8rdz6Q31f1t+J6w65cxeh/K9r5W4nvr59e/y/jZwV+Uj7Nu4qz09VvwNqXBwbUQd2/5igs+HzZIsBHAm2Rgm2kimbJPj1fqDIhL0iCxmBSKZoXLgUtrqukc5wiT+vCnBRXzO6ZVWS8HsE/dY6BYCC3+0bl7MFVlRTgVP
X-Gm-Message-State: AOJu0YxvAu2e2cOQ9OStqkI/xGwUFOrNZEXaTwizNiv5iNupt6xDquSL
	1r99T0xRoLrTUpne9noaPs8AhWPHm3LfFbJbS1r3bVUn0k9H7KSMlFMjkXi0g0Ar0KkHt03laMB
	WSgzCBX5eSzQqA4wAu/xD3f3I2+U=
X-Google-Smtp-Source: AGHT+IGSHnOK96vFCJZzvUgQ3k6lZ3ILiLB0lx+xPZ8yyAfCfIUY48DwUBLftgt9NPbhHq8s1QzITneytfpnGjLKsOE=
X-Received: by 2002:ac2:59c1:0:b0:515:c190:140f with SMTP id
 x1-20020ac259c1000000b00515c190140fmr1842452lfn.14.1712764838860; Wed, 10 Apr
 2024 09:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410104002.1197-1-zhi.mao@mediatek.com> <20240410104002.1197-3-zhi.mao@mediatek.com>
In-Reply-To: <20240410104002.1197-3-zhi.mao@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Apr 2024 19:00:02 +0300
Message-ID: <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Heiko Stuebner <heiko@sntech.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	shengnan.wang@mediatek.com, yaya.chang@mediatek.com, yunkec@chromium.org, 
	10572168@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:40=E2=80=AFPM Zhi Mao <zhi.mao@mediatek.com> wrot=
e:
>
> Add a V4L2 sub-device driver for Giantec GT97xx VCM.

..

> +/*
> + * Ring control and Power control register
> + * Bit[1] RING_EN
> + * 0: Direct mode
> + * 1: AAC mode (ringing control mode)
> + * Bit[0] PD
> + * 0: Normal operation mode
> + * 1: Power down mode
> + * gt97xx requires waiting time of Topr after PD reset takes place.
> + */
> +#define GT97XX_RING_PD_CONTROL_REG CCI_REG8(0x02)

> +#define GT97XX_PD_MODE_OFF 0x00

Okay, this seems to be bitmapped, but do you really need to have this
separate definition?

> +#define GT97XX_PD_MODE_EN BIT(0)
> +#define GT97XX_AAC_MODE_EN BIT(1)

..

> +#define GT97XX_TVIB_MS_BASE10 (64 - 1)

Should it be (BIT(6) - 1) ?

..

> +#define GT97XX_AAC_MODE_DEFAULT 2
> +#define GT97XX_AAC_TIME_DEFAULT 0x20

Some are decimal, some are hexadecimal, but look to me like bitfields.

..

> +#define GT97XX_MAX_FOCUS_POS (1024 - 1)

(BIT(10) - 1) ?

..

> +enum vcm_giantec_reg_desc {
> +       GT_IC_INFO_REG,
> +       GT_RING_PD_CONTROL_REG,
> +       GT_MSB_ADDR_REG,
> +       GT_AAC_PRESC_REG,
> +       GT_AAC_TIME_REG,

> +       GT_MAX_REG,

No comma for the terminator.

> +};

..

> +static u32 gt97xx_find_ot_multi(u32 aac_mode_param)
> +{
> +       u32 cur_ot_multi_base100 =3D 70;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(aac_mode_ot_multi); i++) {
> +               if (aac_mode_ot_multi[i].aac_mode_enum =3D=3D aac_mode_pa=
ram) {
> +                       cur_ot_multi_base100 =3D
> +                               aac_mode_ot_multi[i].ot_multi_base100;
> +               }

No break / return here?

> +       }
> +
> +       return cur_ot_multi_base100;
> +}
> +
> +static u32 gt97xx_find_dividing_rate(u32 presc_param)

Same comments as per above function.

..

> +static inline u32 gt97xx_cal_move_delay(u32 aac_mode_param, u32 presc_pa=
ram,
> +                                       u32 aac_timing_param)

Why inline?

..

> +       return tvib_us * ot_multi_base100 / 100;

HECTO ?

..

> +       val =3D ((unsigned char)read_val & ~mask) | (val & mask);

Why casting?

..

> +static int gt97xx_power_on(struct device *dev)
> +{
> +       struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
> +       struct gt97xx *gt97xx =3D sd_to_gt97xx(sd);
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(gt97xx_supply_names),
> +                                   gt97xx->supplies);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to enable regulators\n");

> +               return ret;

Dup.

> +       }
> +
> +       return ret;
> +}
> +
> +static int gt97xx_power_off(struct device *dev)
> +{
> +       struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
> +       struct gt97xx *gt97xx =3D sd_to_gt97xx(sd);
> +       int ret;
> +
> +       ret =3D regulator_bulk_disable(ARRAY_SIZE(gt97xx_supply_names),
> +                                    gt97xx->supplies);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to disable regulators\n");

> +               return ret;

Ditto.

> +       }
> +
> +       return ret;
> +}

..

> +static int gt97xx_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh=
)
> +{
> +       return pm_runtime_resume_and_get(sd->dev);
> +}
> +
> +static int gt97xx_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *f=
h)
> +{
> +       return pm_runtime_put(sd->dev);
> +}

Hmm... Shouldn't v4l2 take care about these (PM calls)?

..

> +       gt97xx->chip =3D of_device_get_match_data(dev);

device_get_match_data()

..

> +       fwnode_property_read_u32(dev_fwnode(dev), "giantec,aac-mode",
> +                                &gt97xx->aac_mode);

No, use device_property_read_u32() directly.

..

> +       fwnode_property_read_u32(dev_fwnode(dev), "giantec,clock-presc",
> +                                &gt97xx->clock_presc);

Ditto.

..

> +       fwnode_property_read_u32(dev_fwnode(dev), "giantec,aac-timing",
> +                                &gt97xx->aac_timing);

Ditto.

..

> +       /*power on and Initialize hw*/

Missing spaces (and capitalisation?).

..

> +       ret =3D gt97xx_runtime_resume(dev);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to power on: %d\n", ret);

Use dev_err_probe() to match the style of the messages.

> +               goto err_clean_entity;
> +       }

..

> +       ret =3D v4l2_async_register_subdev(&gt97xx->sd);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register V4L2 subdev: %d", ret);

Ditto.

> +               goto err_power_off;
> +       }

--
With Best Regards,
Andy Shevchenko

