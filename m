Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBB7AFFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjI0JY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjI0JY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:24:56 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301792;
        Wed, 27 Sep 2023 02:24:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1dc863efb61so5639607fac.0;
        Wed, 27 Sep 2023 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695806695; x=1696411495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZHfUTnIi/+tYMD4CQDLq6wn6RnNFZ3TBrKVNMLL2a0=;
        b=NDqKIxaVxokp6ySLmgEFP7mxhuv6TbdvxX/1FL9bwGsr6XxZnJWG+Z3zMPFaDmrKa9
         lffZhmPcsbd2YotZNxCvOAh05stm/llPg50M8viYrH8GL8VWFLVrvPfnBMPCbtFGkKj+
         BV4Vr7JX0eU1Gxebo9RB6j+ewhfipso4KwdTZdTG5caCQk6xHnnP+zZEATl044p2TnQR
         q6UETkqq34lhNn5vct7pskr/2U5qSWsQQfg8uVvtA+XkpF7kTxMu6eUUx2/JcIdUhQjw
         ntbkz1i5xMZ6f+oiwXhsAvo5IWiybaY7LzMALR9e415GK8Jqb5/KjO3NWhwVxxh9S3uF
         09TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806695; x=1696411495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZHfUTnIi/+tYMD4CQDLq6wn6RnNFZ3TBrKVNMLL2a0=;
        b=Gg3y3D0UEC9usau9xzghKKdvtC7Fkpio+FjMIBTBvVi/6NgeLfCOJRh1umoeiJy9SB
         XK+O2guZVli4/mrnXkExgl51yEkSoXCmo0aWkGnZKDjwe+m9NoCTVQGnwlTlLAI/KFW7
         w+9zTXfks8776gSzvjweJiZdCooHN8ACZduL1AmOF1ZjJ2NjRS0ffkKB3neVBKhxcOLp
         4lf3gPNne2np1UlZI7pEgZxxLTcm47ssg1z4r4adQeVouXGrHDGmuHI5NHm2D7UXumUb
         RyxO0vl024j5gG/9BJ1D2r+3je9QKx/DLwHSZ/Q/geMXruzxUr09oiE45lIgZ5zw3IDV
         CGQQ==
X-Gm-Message-State: AOJu0YxWfJbQR5fF2+5nQzlzrsEm3gHuag6+6gW3uhfSyP9esuUG1vYO
        pLLfeDqV27zIW35jlSmSBss+1JEDpl6MHKxr6sU=
X-Google-Smtp-Source: AGHT+IF6+ObcwAKEOqCd1hbcguKkAGio2VFRSCNIAEwoldqXnQlfohF2oZPfMjpC4cgkx33MdTLlzPCe110tg27Q9PU=
X-Received: by 2002:a05:6870:5609:b0:1d5:af57:e916 with SMTP id
 m9-20020a056870560900b001d5af57e916mr1914039oao.16.1695806694787; Wed, 27 Sep
 2023 02:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com> <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
 <9dd68b0e-e36a-b87c-e66d-586f2442da6c@linux.alibaba.com>
In-Reply-To: <9dd68b0e-e36a-b87c-e66d-586f2442da6c@linux.alibaba.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 27 Sep 2023 17:24:17 +0800
Message-ID: <CAAfSe-tDFJtq77zw2vHsHAvrwXSy4KFwAEPnVJ6fP8e4PgRF6A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] gpio: pmic-eic-sprd: Two-dimensional arrays
 maintain pmic eic
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Wed, 27 Sept 2023 at 17:04, Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/21/2023 8:25 PM, Wenhua Lin wrote:
> > A bank PMIC EIC contains 16 EICs, and the operating registers
> > are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> > Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> > will cause the configuration of other EICs to be affected when
> > operating a certain EIC. In order to solve this problem, the register
> > operation bits of each PMIC EIC are maintained through the two-dimensional
> > array reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS] to avoid mutual interference.
>
> LGTM. And this also deserves a Fixes tag.

Do we really need a two-dimensional array to save 16-bit value?

> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-pmic-eic-sprd.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> > index c3e4d90f6b18..442968bb2490 100644
> > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
> >       struct gpio_chip chip;
> >       struct regmap *map;
> >       u32 offset;
> > -     u8 reg[CACHE_NR_REGS];
> > +     u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
> >       struct mutex buslock;
> >       int irq;
> >   };
> > @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
> >       struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
> >       u32 offset = irqd_to_hwirq(data);
> >
> > -     pmic_eic->reg[REG_IE] = 0;
> > -     pmic_eic->reg[REG_TRIG] = 0;
> > +     pmic_eic->reg[offset][REG_IE] = 0;
> > +     pmic_eic->reg[offset][REG_TRIG] = 0;
> >
> >       gpiochip_disable_irq(chip, offset);
> >   }
> > @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
> >
> >       gpiochip_enable_irq(chip, offset);
> >
> > -     pmic_eic->reg[REG_IE] = 1;
> > -     pmic_eic->reg[REG_TRIG] = 1;
> > +     pmic_eic->reg[offset][REG_IE] = 1;
> > +     pmic_eic->reg[offset][REG_TRIG] = 1;
> >   }
> >
> >   static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> > @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> >   {
> >       struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
> >       struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
> > +     u32 offset = irqd_to_hwirq(data);
> >
> >       switch (flow_type) {
> >       case IRQ_TYPE_LEVEL_HIGH:
> > -             pmic_eic->reg[REG_IEV] = 1;
> > +             pmic_eic->reg[offset][REG_IEV] = 1;
> >               break;
> >       case IRQ_TYPE_LEVEL_LOW:
> > -             pmic_eic->reg[REG_IEV] = 0;
> > +             pmic_eic->reg[offset][REG_IEV] = 0;
> >               break;
> >       case IRQ_TYPE_EDGE_RISING:
> >       case IRQ_TYPE_EDGE_FALLING:
> > @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
> >                       sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
> >       } else {
> >               sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> > -                                  pmic_eic->reg[REG_IEV]);
> > +                                  pmic_eic->reg[offset][REG_IEV]);
> >       }
> >
> >       /* Set irq unmask */
> >       sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
> > -                          pmic_eic->reg[REG_IE]);
> > +                          pmic_eic->reg[offset][REG_IE]);
> >       /* Generate trigger start pulse for debounce EIC */
> >       sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
> > -                          pmic_eic->reg[REG_TRIG]);
> > +                          pmic_eic->reg[offset][REG_TRIG]);
> >
> >       mutex_unlock(&pmic_eic->buslock);
> >   }
