Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580277526C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHIGAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:00:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1696D1BF3;
        Tue,  8 Aug 2023 23:00:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99c3ca08c09so194305266b.1;
        Tue, 08 Aug 2023 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691560829; x=1692165629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kOj5hkCytVF9p6t8f5EzVsQz2GAyrNoDqZIkxREsAc=;
        b=lWxHMTxVsIB5O8ttLXUGRISS13rwbQN107FblAKFR+uxOIZPjvimYgBBIkAJzfnI2j
         Br3ntdEcaSHuxC0I2yR38WaOfNebBYgFQqDMicEBjoIULfep6FlFSbJgDW7cFRtM27od
         wl5z7pC0gltewIvRYXeMc0Og8uvkDBLX7xqTHbJ4rMD+rqiGGKLpy9/su7ggn8gx36MW
         DMZPiQeNROpArfnDPd02DABtxbTfwpNtlVAPH7+ib1bZ+fgI/yFq2PHaFDUYm9i9KBrx
         J/qwAb746yhZ1IFpYvgMGna4q0l9zHbwbFg/1df+IxxIeSzj6/vTe+JxR+hxRF22DXjS
         itbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560829; x=1692165629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kOj5hkCytVF9p6t8f5EzVsQz2GAyrNoDqZIkxREsAc=;
        b=C+Ght42fdj9u0f0w3yZpyLWgjtVc9Vn4wp7+oeXjwc0uwHuh8vP+0CV84BttFmQg/b
         Q+QdYs0mu/eqo0eM3zSOorrI2q33eKcqTpL82i/pI7FDPtzFdIiSqHNgClsnj/Fn52HA
         tZwYuGAguj/AyRDMWQpJqoKYQ5L6UasVzuh9K5K2kmDxvYXN0fFuKpRvhUFhyALQG1Ap
         PduLFNb4L+41COWCnFI/I3y76aGiJuTzd8HZz8zRIShDhx4IruvRA6A+F+8FylbtnEl7
         MJ7klZXMbvOlyl+eFCYzYguKA6KYmDAVWecBGv3aUEoOTzf3Pwxt0eZTEF1+9mGzJRPU
         TzIg==
X-Gm-Message-State: AOJu0Yz7+HtCTh/Y7oy1oLaJ7u4ILbcfAO6eLBkZ9GhR2Yd7pDokj13l
        x41NcwRdHHIx2//ih+in+gOwoODkx8+8/6sIFtg=
X-Google-Smtp-Source: AGHT+IEY5VdUCigKWZHcz0YmghlXJ/akS0M33c3oDrc+Uhrv6b9S4UuoRKmzdOBHZM7/1diu7PVgMBWZykoIJbwZdw0=
X-Received: by 2002:a17:906:109:b0:99b:c845:7917 with SMTP id
 9-20020a170906010900b0099bc8457917mr1275775eje.4.1691560829427; Tue, 08 Aug
 2023 23:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230807091801.17988-1-Wenhua.Lin@unisoc.com> <ef866767-b95a-8288-4a09-d29fd2717d0a@linux.alibaba.com>
In-Reply-To: <ef866767-b95a-8288-4a09-d29fd2717d0a@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Wed, 9 Aug 2023 14:00:18 +0800
Message-ID: <CAB9BWhdLJp9NWp2+no=x9ZnJ1H32ZUfebiuK8BA3_wywFufqSg@mail.gmail.com>
Subject: Re: [PATCH] gpio: sprd: Two-dimensional arrays maintain pmic eic
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi baolin:
1.We have recorded the offset, no need two-dimensional array unless you
have other strong reasons.

One-dimensional array reg[CACHE_NR_REGS] , the array to cache the EIC
registers., pmic eic has different channels, if the pmic eic does not
increase the offset two-dimensional array to maintain separately, it
will cause one of the eic channels to close the interrupt enable, and
it will be synchronized Disable other eic channel interrupt enable.

2.Why? you did not explain this in the commit log.
We will re-split the patch submission and explain our reasons for
modification in the submission information, thank you very much for
your review

3.Ditto. Why?
> +     pmic_eic->chip.can_sleep =3D true;
We will re-split the patch submission, thank you very much for your review

Baolin Wang <baolin.wang@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=80 17:27=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/7/2023 5:18 PM, Wenhua Lin wrote:
> > Maintain the registers of each pmic eic through a Two-dimensional
> > array to avoid mutual interference.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>
> NAK. See below.
>
> > ---
> >   drivers/gpio/gpio-pmic-eic-sprd.c | 23 +++++++++++++----------
> >   1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic=
-eic-sprd.c
> > index c3e4d90f6b18..8d67d130cbcf 100644
> > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
> >       struct gpio_chip chip;
> >       struct regmap *map;
> >       u32 offset;
> > -     u8 reg[CACHE_NR_REGS];
> > +     u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
>
> We have recorded the offset, no need two-dimensional array unless you
> have other strong reasons.
>
> >       struct mutex buslock;
> >       int irq;
> >   };
> > @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data =
*data)
> >       struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
> >       u32 offset =3D irqd_to_hwirq(data);
> >
> > -     pmic_eic->reg[REG_IE] =3D 0;
> > -     pmic_eic->reg[REG_TRIG] =3D 0;
> > +     pmic_eic->reg[offset][REG_IE] =3D 0;
> > +     pmic_eic->reg[offset][REG_TRIG] =3D 0;
> >
> >       gpiochip_disable_irq(chip, offset);
> >   }
> > @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_dat=
a *data)
> >
> >       gpiochip_enable_irq(chip, offset);
> >
> > -     pmic_eic->reg[REG_IE] =3D 1;
> > -     pmic_eic->reg[REG_TRIG] =3D 1;
> > +     pmic_eic->reg[offset][REG_IE] =3D 1;
> > +     pmic_eic->reg[offset][REG_TRIG] =3D 1;
> >   }
> >
> >   static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> > @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_=
data *data,
> >   {
> >       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(data);
> >       struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
> > +     u32 offset =3D irqd_to_hwirq(data);
> >
> >       switch (flow_type) {
> >       case IRQ_TYPE_LEVEL_HIGH:
> > -             pmic_eic->reg[REG_IEV] =3D 1;
> > +             pmic_eic->reg[offset][REG_IEV] =3D 1;
> >               break;
> >       case IRQ_TYPE_LEVEL_LOW:
> > -             pmic_eic->reg[REG_IEV] =3D 0;
> > +             pmic_eic->reg[offset][REG_IEV] =3D 0;
> >               break;
> >       case IRQ_TYPE_EDGE_RISING:
> >       case IRQ_TYPE_EDGE_FALLING:
> > @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct =
irq_data *data)
> >                       sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_=
IEV, 1);
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
> > @@ -335,6 +336,7 @@ static int sprd_pmic_eic_probe(struct platform_devi=
ce *pdev)
> >
> >       ret =3D devm_request_threaded_irq(&pdev->dev, pmic_eic->irq, NULL=
,
> >                                       sprd_pmic_eic_irq_handler,
> > +                                     IRQF_TRIGGER_LOW |
>
> Why? you did not explain this in the commit log.
>
> >                                       IRQF_ONESHOT | IRQF_NO_SUSPEND,
> >                                       dev_name(&pdev->dev), pmic_eic);
> >       if (ret) {
> > @@ -352,6 +354,7 @@ static int sprd_pmic_eic_probe(struct platform_devi=
ce *pdev)
> >       pmic_eic->chip.set_config =3D sprd_pmic_eic_set_config;
> >       pmic_eic->chip.set =3D sprd_pmic_eic_set;
> >       pmic_eic->chip.get =3D sprd_pmic_eic_get;
> > +     pmic_eic->chip.can_sleep =3D true;
>
> Ditto. Why?
>
> Please DO NOT squash different fixes into one patch.
