Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71479CB04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjILJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjILJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:02:53 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D70199C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:02:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44d5c49af07so2187213137.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694509334; x=1695114134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7KVxkN+wFW5ag2l+y+JF3MWG+d5IfgJLJxlIyvtbLs=;
        b=w5beJWF94HjM5NHDCEl3hhtH5SKr+bzU4M4nvtCvLE2+HdyHwoDHJ5FxyTJg7A3+Jz
         TInaM3nISzMRsTdaiiaPYvA8ROr03Qr6/yfjlY64ueJh8n5U1g2zVhtJOsU0PgU5UZed
         fNBuGY0ZBBCIkCYNv1I/UtQ1q0UFQJ9EvxKwelCossBKIoXDI6vfiiYw7M5BeIgSLJ0g
         N+5OyiDv14cvri8gT7zKdw2FALCD9S8gMXiN7wlj3twseEq4IKjQsHAm0B7jXRv3U59P
         fxyUP6KGbUy/oVpF/bW52QIGxJ2zPPOYq+w6TghThHD08790OwiSYVwc+s+T/6E6aAEx
         fmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509334; x=1695114134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7KVxkN+wFW5ag2l+y+JF3MWG+d5IfgJLJxlIyvtbLs=;
        b=RCihqUMpF18DUjLamzSkYgeyyQGa5QBfg+0eAhX//DTI5Qt1rFAVv2kEX03/d7AeAX
         N2SOTw3gvtd6pjjj1oCdDD6+TbYn2KRgI4eyK7yHsi7zfjq5uqHnvW40dFkgw/ufy0Pe
         mj6m3BWa7Vb/P7CmfIc/PAfZT/nyDg/sNV8/0N18QHAkb9w5Oc2Tj2KUl9Z/abI1VL4M
         quuzK6uGzAip7xyE1ABvmwgbErV90srVZ1UB538IYHJMp3vouXzftCXY/tD4Fp/NKPNR
         /Xp18cC8oe8ADMPOosVreP0g282mDTWMYKQkoCWAdNkMkmUQrDhxctkH32rvYh4qPk8W
         S93g==
X-Gm-Message-State: AOJu0Yzb0HuSi4TuF14jMSSfwy8UbWuI+drPfyCUAax4GAJkYVNEr7Ja
        UHD7HwuzaIk0oNI5Ys7m8IKm9IDiN254YqwRSGnYvw==
X-Google-Smtp-Source: AGHT+IHkpFkb0Yj6bALXgKHWxrwXR38GD7tyi+XhyBH5dw/3Ap6StZroSfHVUOLeHDyS0bJSnQssrvvCtBY5Eo+qI8k=
X-Received: by 2002:a05:6102:24d:b0:44d:547d:4607 with SMTP id
 a13-20020a056102024d00b0044d547d4607mr9039765vsq.35.1694509334207; Tue, 12
 Sep 2023 02:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230829123524.17291-1-zhuyinbo@loongson.cn> <20230829123524.17291-3-zhuyinbo@loongson.cn>
In-Reply-To: <20230829123524.17291-3-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 11:02:03 +0200
Message-ID: <CAMRc=Md6c+z09PuHT+DsXPBwrmDDF8gmLNUAbikgA8fbJHGWFg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: loongson: add more gpio chip support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 2:35=E2=80=AFPM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
> driver support.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/gpio/gpio-loongson-64bit.c | 125 ++++++++++++++++++++++++++---
>  1 file changed, 113 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loong=
son-64bit.c
> index 06213bbfabdd..2608f7eeba3b 100644
> --- a/drivers/gpio/gpio-loongson-64bit.c
> +++ b/drivers/gpio/gpio-loongson-64bit.c
> @@ -23,9 +23,10 @@ enum loongson_gpio_mode {
>  struct loongson_gpio_chip_data {
>         const char              *label;
>         enum loongson_gpio_mode mode;
> -       unsigned int            conf_offset;
> -       unsigned int            out_offset;
> -       unsigned int            in_offset;
> +       u32                     conf_offset;
> +       u32                     out_offset;
> +       u32                     in_offset;
> +       u32                     inten_offset;

Why are you doing this? If this change is needed, it warrants at least
a mention in the commit message.

Bart

>  };
>
>  struct loongson_gpio_chip {
> @@ -117,19 +118,29 @@ static void loongson_gpio_set(struct gpio_chip *chi=
p, unsigned int pin, int valu
>
>  static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int off=
set)
>  {
> +       unsigned int u;
>         struct platform_device *pdev =3D to_platform_device(chip->parent)=
;
> +       struct loongson_gpio_chip *lgpio =3D to_loongson_gpio_chip(chip);
> +
> +       if (lgpio->chip_data->mode =3D=3D BIT_CTRL_MODE) {
> +               /* Get the register index from offset then multiply by by=
tes per register */
> +               u =3D readl(lgpio->reg_base + lgpio->chip_data->inten_off=
set + (offset / 32) * 4);
> +               u |=3D BIT(offset % 32);
> +               writel(u, lgpio->reg_base + lgpio->chip_data->inten_offse=
t + (offset / 32) * 4);
> +       } else {
> +               writeb(1, lgpio->reg_base + lgpio->chip_data->inten_offse=
t + offset);
> +       }
>
>         return platform_get_irq(pdev, offset);
>  }
>
>  static int loongson_gpio_init(struct device *dev, struct loongson_gpio_c=
hip *lgpio,
> -                             struct device_node *np, void __iomem *reg_b=
ase)
> +                             void __iomem *reg_base)
>  {
>         int ret;
>         u32 ngpios;
>
>         lgpio->reg_base =3D reg_base;
> -
>         if (lgpio->chip_data->mode =3D=3D BIT_CTRL_MODE) {
>                 ret =3D bgpio_init(&lgpio->chip, dev, 8,
>                                 lgpio->reg_base + lgpio->chip_data->in_of=
fset,
> @@ -148,15 +159,15 @@ static int loongson_gpio_init(struct device *dev, s=
truct loongson_gpio_chip *lgp
>                 lgpio->chip.direction_output =3D loongson_gpio_direction_=
output;
>                 lgpio->chip.set =3D loongson_gpio_set;
>                 lgpio->chip.parent =3D dev;
> +               device_property_read_u32(dev, "ngpios", &ngpios);
> +               lgpio->chip.ngpio =3D ngpios;
>                 spin_lock_init(&lgpio->lock);
>         }
>
> -       device_property_read_u32(dev, "ngpios", &ngpios);
> -
> -       lgpio->chip.can_sleep =3D 0;
> -       lgpio->chip.ngpio =3D ngpios;
>         lgpio->chip.label =3D lgpio->chip_data->label;
> -       lgpio->chip.to_irq =3D loongson_gpio_to_irq;
> +       lgpio->chip.can_sleep =3D false;
> +       if (lgpio->chip_data->inten_offset)
> +               lgpio->chip.to_irq =3D loongson_gpio_to_irq;
>
>         return devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
>  }
> @@ -165,7 +176,6 @@ static int loongson_gpio_probe(struct platform_device=
 *pdev)
>  {
>         void __iomem *reg_base;
>         struct loongson_gpio_chip *lgpio;
> -       struct device_node *np =3D pdev->dev.of_node;
>         struct device *dev =3D &pdev->dev;
>
>         lgpio =3D devm_kzalloc(dev, sizeof(*lgpio), GFP_KERNEL);
> @@ -178,7 +188,7 @@ static int loongson_gpio_probe(struct platform_device=
 *pdev)
>         if (IS_ERR(reg_base))
>                 return PTR_ERR(reg_base);
>
> -       return loongson_gpio_init(dev, lgpio, np, reg_base);
> +       return loongson_gpio_init(dev, lgpio, reg_base);
>  }
>
>  static const struct loongson_gpio_chip_data loongson_gpio_ls2k_data =3D =
{
> @@ -187,6 +197,57 @@ static const struct loongson_gpio_chip_data loongson=
_gpio_ls2k_data =3D {
>         .conf_offset =3D 0x0,
>         .in_offset =3D 0x20,
>         .out_offset =3D 0x10,
> +       .inten_offset =3D 0x30,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k0500_data0=
 =3D {
> +       .label =3D "ls2k0500_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x0,
> +       .in_offset =3D 0x8,
> +       .out_offset =3D 0x10,
> +       .inten_offset =3D 0xb0,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k0500_data1=
 =3D {
> +       .label =3D "ls2k0500_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x0,
> +       .in_offset =3D 0x8,
> +       .out_offset =3D 0x10,
> +       .inten_offset =3D 0x98,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data0=
 =3D {
> +       .label =3D "ls2k2000_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x0,
> +       .in_offset =3D 0xc,
> +       .out_offset =3D 0x8,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data1=
 =3D {
> +       .label =3D "ls2k2000_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x0,
> +       .in_offset =3D 0x20,
> +       .out_offset =3D 0x10,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls2k2000_data2=
 =3D {
> +       .label =3D "ls2k2000_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x84,
> +       .in_offset =3D 0x88,
> +       .out_offset =3D 0x80,
> +};
> +
> +static const struct loongson_gpio_chip_data loongson_gpio_ls3a5000_data =
=3D {
> +       .label =3D "ls3a5000_gpio",
> +       .mode =3D BIT_CTRL_MODE,
> +       .conf_offset =3D 0x0,
> +       .in_offset =3D 0xc,
> +       .out_offset =3D 0x8,
>  };
>
>  static const struct loongson_gpio_chip_data loongson_gpio_ls7a_data =3D =
{
> @@ -202,6 +263,30 @@ static const struct of_device_id loongson_gpio_of_ma=
tch[] =3D {
>                 .compatible =3D "loongson,ls2k-gpio",
>                 .data =3D &loongson_gpio_ls2k_data,
>         },
> +       {
> +               .compatible =3D "loongson,ls2k0500-gpio0",
> +               .data =3D &loongson_gpio_ls2k0500_data0,
> +       },
> +       {
> +               .compatible =3D "loongson,ls2k0500-gpio1",
> +               .data =3D &loongson_gpio_ls2k0500_data1,
> +       },
> +       {
> +               .compatible =3D "loongson,ls2k2000-gpio0",
> +               .data =3D &loongson_gpio_ls2k2000_data0,
> +       },
> +       {
> +               .compatible =3D "loongson,ls2k2000-gpio1",
> +               .data =3D &loongson_gpio_ls2k2000_data1,
> +       },
> +       {
> +               .compatible =3D "loongson,ls2k2000-gpio2",
> +               .data =3D &loongson_gpio_ls2k2000_data2,
> +       },
> +       {
> +               .compatible =3D "loongson,ls3a5000-gpio",
> +               .data =3D &loongson_gpio_ls3a5000_data,
> +       },
>         {
>                 .compatible =3D "loongson,ls7a-gpio",
>                 .data =3D &loongson_gpio_ls7a_data,
> @@ -215,6 +300,22 @@ static const struct acpi_device_id loongson_gpio_acp=
i_match[] =3D {
>                 .id =3D "LOON0002",
>                 .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls7a_data=
,
>         },
> +       {
> +               .id =3D "LOON0007",
> +               .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls3a5000_=
data,
> +       },
> +       {
> +               .id =3D "LOON000A",
> +               .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls2k2000_=
data0,
> +       },
> +       {
> +               .id =3D "LOON000B",
> +               .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls2k2000_=
data1,
> +       },
> +       {
> +               .id =3D "LOON000C",
> +               .driver_data =3D (kernel_ulong_t)&loongson_gpio_ls2k2000_=
data2,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
> --
> 2.20.1
>
