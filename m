Return-Path: <linux-kernel+bounces-14114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30B8217FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CE81C214F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D920FA;
	Tue,  2 Jan 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2xbUS+V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D520F8;
	Tue,  2 Jan 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-554a0cc9f43so1421624a12.0;
        Mon, 01 Jan 2024 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704180558; x=1704785358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5l93tQapbWDtCqgiK4xtoedXmQGMpfp1WmR3y4qKOA=;
        b=K2xbUS+Vj3GU4MizgPSrX+m6wwVJeLwFow7+pxBD3X5/k8CeA1/D5dXWyVUoHk5iIb
         q8JJ4r/FKi8fuolE2YjjvRGHQKN69Ydo/QxGYgS7nz6Q7A3ExUFCTlR53WAAe5ljlpR/
         ec9vkZgzt6ZmeroZvvvO5yRKn6Krfk3lj+mQrU88AAh59D3tilCNNVm4DeBMyEniKHgv
         DDfQ4J1VhJZtoHU5KisiEFLUuQtcIXGJvHxeNy27/nFoXUMw73NZXJeZSwGpm19cbQgo
         y83D3w5/IGcAeKrmDGQUiSurc91SU9kybrSh23kj/5nGkMdCQ3KOctdQHxJiyjqiP9z0
         7alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704180558; x=1704785358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5l93tQapbWDtCqgiK4xtoedXmQGMpfp1WmR3y4qKOA=;
        b=PPZGeAfgjF5fzJ6sTqVNCmoiCHyMjrRzT7xWylbfmxz39zsPmFTZQa6aRPGneuBvsu
         3MeKKBJRpZ/+la65t9VP6Sj5PYRkmYpO56LrWANyFE2afDbZ218B78ZjAnAT2AtuHHM3
         y+Do6AW1ctG8053XDDPKwWCN9Qy3bwv/CgPU98U2MVELDAqMy3JxAoyAjCleHqclQVUP
         cGUL9SmtBLthR3wCNca3z0ZFZrrC5qx1sPYCQ5CgbDw3TgTvT4F1fXMQeMzcJMX2W0Ra
         0I7fiQb3ckIjwXohlJpqDeLX/XPPhKs8mY+OdbGy5dg61R8ycDDJd3KBdEHV3JEDwpQA
         Nu4Q==
X-Gm-Message-State: AOJu0Yy+TzaqncDiqBdveE+m7pBegp7nvgmFkDJT+8qtlHp+wDgleW+c
	nUIwAwNqmdZfvjw6SehiYSdxJou1KJmRwP0FAeg=
X-Google-Smtp-Source: AGHT+IFH0l2itsTVMv6hqRHtTJdm1TaZyqv1rYOz811lVQoOycE+ahTvn4Tj++EefWASgDw1CLMsxSKqf+A/w8WwCtY=
X-Received: by 2002:a50:cd8a:0:b0:554:4916:ac5e with SMTP id
 p10-20020a50cd8a000000b005544916ac5emr22287662edi.4.1704180557818; Mon, 01
 Jan 2024 23:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com> <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
 <CAAfSe-ukBxD2+Q7tuc_jBk3mJjqPpn0DWUKpCOBaN=UaasuEXw@mail.gmail.com>
In-Reply-To: <CAAfSe-ukBxD2+Q7tuc_jBk3mJjqPpn0DWUKpCOBaN=UaasuEXw@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 2 Jan 2024 15:29:06 +0800
Message-ID: <CAB9BWhdq92ysEwSGUBP60wZqMPqV59PMhg91rU8r+N983rAHag@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] gpio: pmic-eic-sprd: Two-dimensional arrays
 maintain pmic eic
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 5:01=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com=
> wrote:
>
> On Thu, 21 Sept 2023 at 20:27, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > A bank PMIC EIC contains 16 EICs, and the operating registers
> > are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
> > Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
> > will cause the configuration of other EICs to be affected when
> > operating a certain EIC. In order to solve this problem, the register
> > operation bits of each PMIC EIC are maintained through the two-dimensio=
nal
> > array reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS] to avoid mutual interference=
.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/gpio/gpio-pmic-eic-sprd.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic=
-eic-sprd.c
> > index c3e4d90f6b18..442968bb2490 100644
> > --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> > +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> > @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
> >         struct gpio_chip chip;
> >         struct regmap *map;
> >         u32 offset;
> > -       u8 reg[CACHE_NR_REGS];
> > +       u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
> >         struct mutex buslock;
> >         int irq;
> >  };
> > @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data =
*data)
> >         struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
> >         u32 offset =3D irqd_to_hwirq(data);
> >
> > -       pmic_eic->reg[REG_IE] =3D 0;
> > -       pmic_eic->reg[REG_TRIG] =3D 0;
> > +       pmic_eic->reg[offset][REG_IE] =3D 0;
> > +       pmic_eic->reg[offset][REG_TRIG] =3D 0;
>
> I would suggest just using this one-dimensional array which is enough
> for saving 16-bit values.
>
> To solve the issue mentioned in the commit message, we can set/clear
> the bit according to the value of 'offset', for example:
>
> pmic_eic->reg[REG_IE] &=3D ~BIT(offset);
>
> >
> >         gpiochip_disable_irq(chip, offset);
> >  }
> > @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_dat=
a *data)
> >
> >         gpiochip_enable_irq(chip, offset);
> >
> > -       pmic_eic->reg[REG_IE] =3D 1;
> > -       pmic_eic->reg[REG_TRIG] =3D 1;
> > +       pmic_eic->reg[offset][REG_IE] =3D 1;
> > +       pmic_eic->reg[offset][REG_TRIG] =3D 1;
>
> For setting operations:
>
> pmic_eic->reg[REG_IE] |=3D BIT(offset);
>
> >  }
> >
> >  static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> > @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_=
data *data,
> >  {
> >         struct gpio_chip *chip =3D irq_data_get_irq_chip_data(data);
> >         struct sprd_pmic_eic *pmic_eic =3D gpiochip_get_data(chip);
> > +       u32 offset =3D irqd_to_hwirq(data);
> >
> >         switch (flow_type) {
> >         case IRQ_TYPE_LEVEL_HIGH:
> > -               pmic_eic->reg[REG_IEV] =3D 1;
> > +               pmic_eic->reg[offset][REG_IEV] =3D 1;
> >                 break;
> >         case IRQ_TYPE_LEVEL_LOW:
> > -               pmic_eic->reg[REG_IEV] =3D 0;
> > +               pmic_eic->reg[offset][REG_IEV] =3D 0;
> >                 break;
> >         case IRQ_TYPE_EDGE_RISING:
> >         case IRQ_TYPE_EDGE_FALLING:
> > @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct =
irq_data *data)
> >                         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EI=
C_IEV, 1);
> >         } else {
> >                 sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> > -                                    pmic_eic->reg[REG_IEV]);
> > +                                    pmic_eic->reg[offset][REG_IEV]);
>
> When using the array we can deal with it like below since
> sprd_pmic_eic_update() would do a shift for the parameter 'val':
>
> (pmic_eic->reg[REG_IEV] & BIT(offset)) ? 1 : 0;
>

Thank you very much for your review.
I will fix this issue in patch v3.

> >         }
> >
> >         /* Set irq unmask */
> >         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
> > -                            pmic_eic->reg[REG_IE]);
> > +                            pmic_eic->reg[offset][REG_IE]);
> >         /* Generate trigger start pulse for debounce EIC */
> >         sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
> > -                            pmic_eic->reg[REG_TRIG]);
> > +                            pmic_eic->reg[offset][REG_TRIG]);
>
> Similar here.
>
> Thanks,
> Chunyan

