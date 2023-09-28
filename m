Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29447B16CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjI1JBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjI1JBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:01:25 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C1B7;
        Thu, 28 Sep 2023 02:01:23 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dce0c05171so5553015fac.3;
        Thu, 28 Sep 2023 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695891683; x=1696496483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N4sSIiErUFVkts7SjuNECRpeR4c/z8o2usI6ei6c04Y=;
        b=GPKM0dj195JW1zGHSfnli5c4/GRh8tll85eRIrocgfvye76YUL4KvyQZoegXYfC9iP
         vZgJVGvf0HLeqYxuSIPsaZpSAAFdFLKIYyjj2mRzhzO1p3vn+UHFZ7G1nCfn1BEL84cw
         ScVHSy2ad2Ry47uOhMzEGiuMXgCwHarNEmM6bsrKu3zQpt6zzj4MYoUGSEEzj3M3vJsl
         y3PjBchqru1d8N6Sb3FFV35HLNgh4j2u680bQUdhApIdKspAiU9m/UtLAmdh/9gNqPPS
         RfoWPE8JMVVfsJQzbxK9XrVZZAD4T1Qy0ydCYCgo6sZxRKTPJRrXvE8AoOXIOQxXqGc0
         NvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891683; x=1696496483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4sSIiErUFVkts7SjuNECRpeR4c/z8o2usI6ei6c04Y=;
        b=CNp/hcjOCe5Mn4RzR39NXLy07NySmEAVen56x+p/3GKSHAfVCn40whIJnyXDGp3Aq5
         NP/dNxSpou5UNYYKR40a0yVSO26GpCFE200ES7b4UxytAOb/GKUf/vg7K2PmyZQvMPxR
         EalvrjkxT8tBVr56o6FzviAwHxIR3tcfc+uA3WsGx5EQCUC12CFZRCWibj0SDWRLUJ+I
         2PHbv7wQOBdpAQTeA278Oi4p5tEODbGDYE9SuLWZzkemMyO6NQIdr/+VITIL/oPquVsD
         OBX1vtpoVQzDOIXyEtnEevCa+Sy+SLCHlUN8zlMXtZTc4yyJ/9JrCGGXgtIsrHkj+8hK
         JBnQ==
X-Gm-Message-State: AOJu0YwAuUmGs3SasFgNvlg74QBeoSDAuelKfu8XPX7EMfT3JOs49UIC
        A9O/IOEfnM0jz4j+MXd3oUAEY84qTNpDwbh1UOKIfSbA6rI=
X-Google-Smtp-Source: AGHT+IGHOSfikFsHQ+LmiGBJTpbzDqJDqQhA8OJk1SijoVEpcGGxG3PaEIcoePytWAT3PRbqG6zGZ1+sa6tRKpP43A4=
X-Received: by 2002:a05:6870:c1d3:b0:1d5:d8f0:7d7e with SMTP id
 i19-20020a056870c1d300b001d5d8f07d7emr728868oad.53.1695891683164; Thu, 28 Sep
 2023 02:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com> <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
In-Reply-To: <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 28 Sep 2023 17:00:46 +0800
Message-ID: <CAAfSe-ukBxD2+Q7tuc_jBk3mJjqPpn0DWUKpCOBaN=UaasuEXw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] gpio: pmic-eic-sprd: Two-dimensional arrays
 maintain pmic eic
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 20:27, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> A bank PMIC EIC contains 16 EICs, and the operating registers
> are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> will cause the configuration of other EICs to be affected when
> operating a certain EIC. In order to solve this problem, the register
> operation bits of each PMIC EIC are maintained through the two-dimensional
> array reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS] to avoid mutual interference.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/gpio/gpio-pmic-eic-sprd.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
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
> @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
>         struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
>         u32 offset = irqd_to_hwirq(data);
>
> -       pmic_eic->reg[REG_IE] = 0;
> -       pmic_eic->reg[REG_TRIG] = 0;
> +       pmic_eic->reg[offset][REG_IE] = 0;
> +       pmic_eic->reg[offset][REG_TRIG] = 0;

I would suggest just using this one-dimensional array which is enough
for saving 16-bit values.

To solve the issue mentioned in the commit message, we can set/clear
the bit according to the value of 'offset', for example:

pmic_eic->reg[REG_IE] &= ~BIT(offset);

>
>         gpiochip_disable_irq(chip, offset);
>  }
> @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
>
>         gpiochip_enable_irq(chip, offset);
>
> -       pmic_eic->reg[REG_IE] = 1;
> -       pmic_eic->reg[REG_TRIG] = 1;
> +       pmic_eic->reg[offset][REG_IE] = 1;
> +       pmic_eic->reg[offset][REG_TRIG] = 1;

For setting operations:

pmic_eic->reg[REG_IE] |= BIT(offset);

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
> +               pmic_eic->reg[offset][REG_IEV] = 1;
>                 break;
>         case IRQ_TYPE_LEVEL_LOW:
> -               pmic_eic->reg[REG_IEV] = 0;
> +               pmic_eic->reg[offset][REG_IEV] = 0;
>                 break;
>         case IRQ_TYPE_EDGE_RISING:
>         case IRQ_TYPE_EDGE_FALLING:
> @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
>                         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
>         } else {
>                 sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> -                                    pmic_eic->reg[REG_IEV]);
> +                                    pmic_eic->reg[offset][REG_IEV]);

When using the array we can deal with it like below since
sprd_pmic_eic_update() would do a shift for the parameter 'val':

(pmic_eic->reg[REG_IEV] & BIT(offset)) ? 1 : 0;

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

Similar here.

Thanks,
Chunyan
