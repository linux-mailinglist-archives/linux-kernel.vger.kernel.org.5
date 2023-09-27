Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6879E7AFBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjI0HWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjI0HWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:22:08 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C4126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:22:07 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44ee3a547adso4473168137.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695799327; x=1696404127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmxAHXmVUHGDcJ0DBWWl1uYiQCGSb58dGdZ67AkLMLQ=;
        b=QXRMbtLsnAncWJjxmB0wKw1B6DqfAB27Ps73bRuVZAiZcOspaq1lsJVM4ISZfiW5oW
         U6HaiSryBBwLLd4Avg29oCtySzLaiU9++U8d2sxzUQlE/xQCDtDKoLMFEVymy6kwJzGe
         pfWNaIzzgWxwpBaJx/RbYhmi2xkvgVHluUqP8q9uEhBNMHIZdIKSS3f3YOZAgUMhoEzi
         8wEVxsrhZPe581UeQqa9z/8q/HJxjXQoxmebojHH2Fwvv1gkioKOPZZN7yYYyjl0DLai
         k1P5QLLX305TmYVkcVZLi6JRPSQ1irYDahiu/Lskho8fbYBiw0+lxU21+9vVOTeRbY/1
         eS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695799327; x=1696404127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmxAHXmVUHGDcJ0DBWWl1uYiQCGSb58dGdZ67AkLMLQ=;
        b=X6qE8VJCTxWy7sg2Bb2ZZKePhxGC5KU9xs2U8dYK/tXFmzEjqe+YX+RZiavzsDRrO9
         U1FXdiSe7DtjQj+xFeJMuLhmNrmZXpqJLKy1I/vFeSZbrqiRFCtXmMdE7HJABBFgrjpx
         6kO6Av+0ULw7bFelfO8QxPEizKxBUAz3oFl8NuHsEJJ/FdzjzKthzPhrK1vme1kpJhJr
         O4VWYUm9JS0uuTRCQn+pohfbTCUeUyEyzmuq4LvwOBgPCXVFrd+bM3LsZP8o2/q2ypbI
         NmyqoN4/xsHRUr6qnaI+YBNbmfWSjpoXjRenmGncXLAYlQKScf7Qwe1RcHMp7UHunMP2
         dD0A==
X-Gm-Message-State: AOJu0Yz9CulGA/8cj9jQr0u0r3w2/UT0OiZkQLlvuRAl0mnFyP1CoNkY
        n0UUE73ovhIBctFG5q11GvHCyHLfEAswMcGVYz7jgw==
X-Google-Smtp-Source: AGHT+IFo/CuSjFSJA5xlKHIrrmlEZyrIGXD0woZ0j7yTTbp2AaRcGnZSIuZZjnKQGtUQxbpXrSmdXIgi98fac1/f5+I=
X-Received: by 2002:a05:6102:570b:b0:454:607d:196f with SMTP id
 dg11-20020a056102570b00b00454607d196fmr356030vsb.20.1695799326908; Wed, 27
 Sep 2023 00:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com> <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
In-Reply-To: <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 09:21:56 +0200
Message-ID: <CAMRc=MfxG+fyjskTwzQ-5Rh7vPbTuFQCnf=N9XV+TZBf7k6d-g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] gpio: pmic-eic-sprd: Two-dimensional arrays
 maintain pmic eic
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 2:27=E2=80=AFPM Wenhua Lin <Wenhua.Lin@unisoc.com> =
wrote:
>
> A bank PMIC EIC contains 16 EICs, and the operating registers
> are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> will cause the configuration of other EICs to be affected when
> operating a certain EIC. In order to solve this problem, the register
> operation bits of each PMIC EIC are maintained through the two-dimensiona=
l
> array reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS] to avoid mutual interference.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-pmic-eic-sprd.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-e=
ic-sprd.c
> index c3e4d90f6b18..442968bb2490 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
>         struct gpio_chip chip;
>         struct regmap *map;
>         u32 offset;
> -       u8 reg[CACHE_NR_REGS];
> +       u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
>         struct mutex buslock;
>         int irq;
>  };
> @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *d=
ata)
>         struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
>         u32 offset =3D irqd_to_hwirq(data);
>
> -       pmic_eic->reg[REG_IE] =3D 0;
> -       pmic_eic->reg[REG_TRIG] =3D 0;
> +       pmic_eic->reg[offset][REG_IE] =3D 0;
> +       pmic_eic->reg[offset][REG_TRIG] =3D 0;
>
>         gpiochip_disable_irq(chip, offset);
>  }
> @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data =
*data)
>
>         gpiochip_enable_irq(chip, offset);
>
> -       pmic_eic->reg[REG_IE] =3D 1;
> -       pmic_eic->reg[REG_TRIG] =3D 1;
> +       pmic_eic->reg[offset][REG_IE] =3D 1;
> +       pmic_eic->reg[offset][REG_TRIG] =3D 1;
>  }
>
>  static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_da=
ta *data,
>  {
>         struct gpio_chip *chip =3D irq_data_get_irq_chip_data(data);
>         struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
> +       u32 offset =3D irqd_to_hwirq(data);
>
>         switch (flow_type) {
>         case IRQ_TYPE_LEVEL_HIGH:
> -               pmic_eic->reg[REG_IEV] =3D 1;
> +               pmic_eic->reg[offset][REG_IEV] =3D 1;
>                 break;
>         case IRQ_TYPE_LEVEL_LOW:
> -               pmic_eic->reg[REG_IEV] =3D 0;
> +               pmic_eic->reg[offset][REG_IEV] =3D 0;
>                 break;
>         case IRQ_TYPE_EDGE_RISING:
>         case IRQ_TYPE_EDGE_FALLING:
> @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct ir=
q_data *data)
>                         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_=
IEV, 1);
>         } else {
>                 sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> -                                    pmic_eic->reg[REG_IEV]);
> +                                    pmic_eic->reg[offset][REG_IEV]);
>         }
>
>         /* Set irq unmask */
>         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
> -                            pmic_eic->reg[REG_IE]);
> +                            pmic_eic->reg[offset][REG_IE]);
>         /* Generate trigger start pulse for debounce EIC */
>         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
> -                            pmic_eic->reg[REG_TRIG]);
> +                            pmic_eic->reg[offset][REG_TRIG]);
>
>         mutex_unlock(&pmic_eic->buslock);
>  }
> --
> 2.17.1
>

This looks good to me but I want to let the SPRD maintainers
review/test it before applying.

Bart
