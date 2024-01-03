Return-Path: <linux-kernel+bounces-15058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A88226C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEDF1C21CD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D3139F;
	Wed,  3 Jan 2024 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oiznzegw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018F1379;
	Wed,  3 Jan 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204301f2934so7337242fac.1;
        Tue, 02 Jan 2024 18:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704247538; x=1704852338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p020yGJyYpoVDenDw3eDpTN5RjpFSz8umqgrPZ/4H8o=;
        b=Oiznzegw1W8aj2OMWtJxXfyNPNF1qpUsiqB09UxFcqveacWPY3H4aDiUytTTgMnBw0
         vOwmj8jEfUfTwoX9wb0NllrpF6KreA32FI6FfhvnjH/PxPA6ryE/9duydDVmt6nMMNhV
         gRUxJ50A8uKjsdeP5Q+GWmGGcCpPnemX39AiMWJIQXMQ7kcNL69Ih2KvttD2+SHagtBZ
         E1ocGaGAYDKUgS+99fySV+X0Acs1lh2jB0N83wsvEvdCEKvUghc3vpw8HFsTjFkKSlhy
         CU9CbZekbEtepkf3CG2Bdx090UOjhz/8hLCak8a7LHji0YVchRqAw9E+yEX1Z7WwNHoc
         ZXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704247538; x=1704852338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p020yGJyYpoVDenDw3eDpTN5RjpFSz8umqgrPZ/4H8o=;
        b=eeTCXJsPo3JUNWFWUzgyhp85gYLpRlxtKI2MwjFhZZ1fON6KWN+x4AyE4hZfBV4zbr
         CAbBJ53PzNAju9FektBTxTM5E+xdAfr53Q1LLok+9MPmla764vPErgATwwweg+FfYkTb
         v2GXufSjx6KPEAj13/8K3Uj5V8GL0sLBoiheHxL9rIHuzWVqsc3uwz5pulqJFbQHj/5j
         VONgeadABzGxsQ8pdE/tvKsvNbaocl8gEUSeDUsgWbUByyZ1WShCEnn/uSmmD1Z7+AVL
         sYMs8i58qomHimUmu3TEefzkxt8uEZYPQNKZBYLaNEuSvuVE0w8fMU6Zj+reF5efRHnl
         BY3Q==
X-Gm-Message-State: AOJu0Yzq2eKW3CZ6TXMaJ3YGHC6OXSxJoMYjw6IH4igjMWFfHWYt6g6P
	oycjjgx0ZTpTaOz/C7Sw5UN5i6nkMFaNxP7ZRP8RDdQr
X-Google-Smtp-Source: AGHT+IEffjYGB+G4zoepu/jPH6eB9cuUM3oNqCu62NlS+1/u6d3KCu9pGHloVQH+rFxwnIf8SXQJqngVwv1U6ASg28A=
X-Received: by 2002:a05:6870:d24a:b0:204:2bd9:7e89 with SMTP id
 h10-20020a056870d24a00b002042bd97e89mr22822057oac.88.1704247538555; Tue, 02
 Jan 2024 18:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102082829.30874-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240102082829.30874-1-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 3 Jan 2024 10:05:01 +0800
Message-ID: <CAAfSe-sJSwvPLi0OaGUDShrFZKpworStH=6LTjzfK82w-bbDZg@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: pmic-eic-sprd: Configure the bit corresponding
 to the EIC through offset
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 16:29, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> A bank PMIC EIC contains 16 EICs, and the operating registers
> are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> will cause the configuration of other EICs to be affected when
> operating a certain EIC. In order to solve this problem, configure
> the bit corresponding to the EIC through offset.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>


> ---
> Change in V3:
> -Change title.
> -Change commit message.
> -Delete the modification of the two-dimensional array maintenance pmic eic,
>  and add the corresponding bits to configure the eic according to the offset.
> ---
> ---
>  drivers/gpio/gpio-pmic-eic-sprd.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> index 01c0fd0a9d8c..d9b228bea42e 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
>         struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
>         u32 offset = irqd_to_hwirq(data);
>
> -       pmic_eic->reg[REG_IE] = 0;
> -       pmic_eic->reg[REG_TRIG] = 0;
> +       pmic_eic->reg[REG_IE] &= ~BIT(offset);
> +       pmic_eic->reg[REG_TRIG] &= ~BIT(offset);
>
>         gpiochip_disable_irq(chip, offset);
>  }
> @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
>
>         gpiochip_enable_irq(chip, offset);
>
> -       pmic_eic->reg[REG_IE] = 1;
> -       pmic_eic->reg[REG_TRIG] = 1;
> +       pmic_eic->reg[REG_IE] |= BIT(offset);
> +       pmic_eic->reg[REG_TRIG] |= BIT(offset);
>  }
>
>  static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
>  {
>         struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
>         struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
> +       u32 offset = irqd_to_hwirq(data);
>
>         switch (flow_type) {
>         case IRQ_TYPE_LEVEL_HIGH:
> -               pmic_eic->reg[REG_IEV] = 1;
> +               pmic_eic->reg[REG_IEV] |= BIT(offset);
>                 break;
>         case IRQ_TYPE_LEVEL_LOW:
> -               pmic_eic->reg[REG_IEV] = 0;
> +               pmic_eic->reg[REG_IEV] &= ~BIT(offset);
>                 break;
>         case IRQ_TYPE_EDGE_RISING:
>         case IRQ_TYPE_EDGE_FALLING:
> @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
>                         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
>         } else {
>                 sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> -                                    pmic_eic->reg[REG_IEV]);
> +                                    !!(pmic_eic->reg[REG_IEV] & BIT(offset)));
>         }
>
>         /* Set irq unmask */
>         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
> -                            pmic_eic->reg[REG_IE]);
> +                            !!(pmic_eic->reg[REG_IE] & BIT(offset)));
>         /* Generate trigger start pulse for debounce EIC */
>         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
> -                            pmic_eic->reg[REG_TRIG]);
> +                            !!(pmic_eic->reg[REG_TRIG] & BIT(offset)));
>
>         mutex_unlock(&pmic_eic->buslock);
>  }
> --
> 2.17.1
>

