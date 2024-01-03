Return-Path: <linux-kernel+bounces-15488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B25822CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4100D1C226EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4018EB2;
	Wed,  3 Jan 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efbJI7yw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671E18EA7;
	Wed,  3 Jan 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2328f2b6e5so331236166b.0;
        Wed, 03 Jan 2024 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283486; x=1704888286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYsi7PxdsGtiLQTh+fjCQRAZRKpUc8NniH0MtVqrow8=;
        b=efbJI7ywqjqV59/cbcG7CClvuPu1TOeEJPugf3QKZYfcwpooWuGASYz1TgExdiYfzG
         LgXIo+TIaaSzG5Tqe7AA45gs+yIb13/BkFLmzuAR5klLspqNHEX9dBQY95JM9QZPG0WB
         OeIrbp/tzB1C5xIvuGbyjzrDIx/4vm6yg/5R7vN2VsSgqEX9M8Hfz7vcqap7grLV7k8f
         bYix7oUZWC0Jh/cdecyAqnI2UJ34kDHe5aSiKnHMSf0cWrmzExoG69JUkSGjB4bSpQQL
         Dz1uoVZ2+a9ORDl2MidXd6/wcd+tLZfl887pxJx9/yZz3FMPKbZfZkgD2wlv1TZy+cjU
         zRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283486; x=1704888286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYsi7PxdsGtiLQTh+fjCQRAZRKpUc8NniH0MtVqrow8=;
        b=tnoFZEgYLs9NUsedoYOkhBAXj3IOrs4W+S+d94znP70NlG17lbfQkJY8nZ1PAr4cBh
         UKwCczmAMFxfX+X563BgsvZ65By4KYAIyV81Zfo3YAkVr+GR/7YUIKU/A31OJXGSzf4E
         Gu9BFNk/6fHW25uNrHO7emqqV56uwksLXy0aoiTQCuUQBgQXk2F+lXeHnPdQpU00ksNr
         9NnYn39TD3l7Xui5RObJHIEmVuGlbUJinTze+htARMQTJ3tCouVuc+oBYtM9ivVqEZ3K
         x6aJreENTiuhDNozDq8n+Sx8uqcCie2+NwlUAToq0mg0RZ9Q4hZ5W8T2x0GwQc4HQMYQ
         N7sg==
X-Gm-Message-State: AOJu0Yx/J1mVO7i2moyB/r74rQieQmjuVL0+I6bnqUmlDs3P6zgP3fzZ
	INwaWbkPOs8kKZM0zb5WGIKbMytaLMvtPXylRMM=
X-Google-Smtp-Source: AGHT+IHhyqsmCjMts9eu/l80XOvO25tg5HyP6DHFIHPgbwTqDmYU0uU0eywORA8cW3glvKuzjGAWcfnayhdt71znNNo=
X-Received: by 2002:a17:906:1682:b0:a27:76d1:aa66 with SMTP id
 s2-20020a170906168200b00a2776d1aa66mr7644690ejd.1.1704283486256; Wed, 03 Jan
 2024 04:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
 <07a9e3c1-0ed4-6f30-81c9-4eabcc11a18b@linux.alibaba.com>
In-Reply-To: <07a9e3c1-0ed4-6f30-81c9-4eabcc11a18b@linux.alibaba.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 3 Jan 2024 20:04:34 +0800
Message-ID: <CAB9BWhcFgTP1M5LxnYAWLaCZpfxZfqmQh6e63vX7rri-j87FqA@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] gpio: sprd: Modify the calculation method of eic number
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 5:24=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> > When the soc changes, the corresponding gpio-eic-sprd.c
> > code needs to be modified, and the corresponding
> > Document must also be modified, which is quite troublesome.
> > To avoid modifying the driver file, the number of EICs
> > is automatically calculated by matching dts nodes.
> >
> > Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")
>
> This is not a bugfix and you still use an incorrect Fixes tag.
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 43 ++++++++++++++++++-----------------=
-
> >   1 file changed, 22 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 96f1c7fd3988..e85addbdf8aa 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -100,33 +100,32 @@ struct sprd_eic {
> >
> >   struct sprd_eic_variant_data {
> >       enum sprd_eic_type type;
> > -     u32 num_eics;
> >   };
> >
> > +#define SPRD_EIC_VAR_DATA(soc_name)                          \
> > +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data =3D=
 {       \
> > +     .type =3D SPRD_EIC_DEBOUNCE,                                     =
 \
> > +};                                                                   \
> > +                                                                     \
> > +static const struct sprd_eic_variant_data soc_name##_eic_latch_data =
=3D {      \
> > +     .type =3D SPRD_EIC_LATCH,                                        =
 \
> > +};                                                                   \
> > +                                                                     \
> > +static const struct sprd_eic_variant_data soc_name##_eic_async_data =
=3D {      \
> > +     .type =3D SPRD_EIC_ASYNC,                                        =
 \
> > +};                                                                   \
> > +                                                                     \
> > +static const struct sprd_eic_variant_data soc_name##_eic_sync_data =3D=
 {       \
> > +     .type =3D SPRD_EIC_SYNC,                                         =
 \
> > +}
> > +
> > +SPRD_EIC_VAR_DATA(sc9860);
> > +
> >   static const char *sprd_eic_label_name[SPRD_EIC_MAX] =3D {
> >       "eic-debounce", "eic-latch", "eic-async",
> >       "eic-sync",
> >   };
> >
> > -static const struct sprd_eic_variant_data sc9860_eic_dbnc_data =3D {
> > -     .type =3D SPRD_EIC_DEBOUNCE,
> > -     .num_eics =3D 8,
> > -};
> > -
> > -static const struct sprd_eic_variant_data sc9860_eic_latch_data =3D {
> > -     .type =3D SPRD_EIC_LATCH,
> > -     .num_eics =3D 8,
> > -};
> > -
> > -static const struct sprd_eic_variant_data sc9860_eic_async_data =3D {
> > -     .type =3D SPRD_EIC_ASYNC,
> > -     .num_eics =3D 8,
> > -};
> > -
> > -static const struct sprd_eic_variant_data sc9860_eic_sync_data =3D {
> > -     .type =3D SPRD_EIC_SYNC,
> > -     .num_eics =3D 8,
> > -};
> >
> >   static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *spr=
d_eic,
> >                                                unsigned int bank)
> > @@ -595,6 +594,7 @@ static int sprd_eic_probe(struct platform_device *p=
dev)
> >       struct sprd_eic *sprd_eic;
> >       struct resource *res;
> >       int ret, i;
> > +     u16 num_banks =3D 0;
> >
> >       pdata =3D of_device_get_match_data(&pdev->dev);
> >       if (!pdata) {
> > @@ -625,12 +625,13 @@ static int sprd_eic_probe(struct platform_device =
*pdev)
> >                       break;
> >
> >               sprd_eic->base[i] =3D devm_ioremap_resource(&pdev->dev, r=
es);
> > +             num_banks++;
>
> Please move this after the validation of the sprd_eic->base.

Thank you very much for your review.
I will fix this issue in patch v3.

>
> >               if (IS_ERR(sprd_eic->base[i]))
> >                       return PTR_ERR(sprd_eic->base[i]);
> >       }
> >
> >       sprd_eic->chip.label =3D sprd_eic_label_name[sprd_eic->type];
> > -     sprd_eic->chip.ngpio =3D pdata->num_eics;
> > +     sprd_eic->chip.ngpio =3D num_banks * SPRD_EIC_PER_BANK_NR;
> >       sprd_eic->chip.base =3D -1;
> >       sprd_eic->chip.parent =3D &pdev->dev;
> >       sprd_eic->chip.direction_input =3D sprd_eic_direction_input;

