Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FCB77528D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjHIGJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHIGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:09:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F0E61;
        Tue,  8 Aug 2023 23:09:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso2012131a12.1;
        Tue, 08 Aug 2023 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691561339; x=1692166139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwXXHFU3z7b4p7pSwEJV5qOMc5cSwj3eTpJphQxUhLQ=;
        b=d/gN0o19EpEHAWeVeLzdsEgWtqimSwwJOnA45ak75MESlsJDM4dS4V+Qsl+SwbP23/
         6i13MRTTytmwgGkKdneHk+gNsVtCw1MzG4yzuo3SHvJbUYZSt7foBZp3KmR+YxLMWOEo
         C/v1zQ4t3AACp2AWJptkF+Umri0w1rLwH1elAC7KyEkK75v+Rj8Udo+Sfy7UahGy4VEA
         gojWtZrwY+c99nzKb+eyETWiTx5nz8AEvqFZUQy5nERp/YmTNTfcIbmBRQ5THcwRO8IS
         yyYWb3j7Vl29oKsriPghPyITGV54O+kerV3agCIlA60L0f+dJTGAI2fUx+7+5oQfJ1XO
         tbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561339; x=1692166139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwXXHFU3z7b4p7pSwEJV5qOMc5cSwj3eTpJphQxUhLQ=;
        b=cCdjh1k2u0ZsoK/LD0gpWOnnBUrkojUrU4PawHbBmtXbSWre0HWcuyu91WMBXytB0P
         AJOoklzxyy2EasCoYx3Uo3GDcw8oIRRfI5TeopokITjTS1OpS+KSbq2iLwbbQT6cTPYK
         XJAVvdzMGMwaGWYLb4d48oJCGyReWk0J/u8LtGiLUDv+6ll34ACkLogmMm7SI4LEBw+Y
         WUKhAUxS57rJPVxgUTlgr0LHZLyyK9o0kcu9afI1OhVOfg22vXdeGlyiyw70wxGm1ogJ
         +NLkftJYn7I3aUg5T15rSAf3/X9kCBU/v/8I3Ukrky7/q+h5YkQoA6DEczE0j3EEYxFS
         97WA==
X-Gm-Message-State: AOJu0YwqffeUtMzcJ/L3S/hKO2WyGOIeLImwZ5nW7ekcrGTTC9uCWypn
        6DkG+A5ded9etKnMVcy0k2WnbPczSgGGGo0Gw+urOb+HavU4wQ==
X-Google-Smtp-Source: AGHT+IG3fVy3p2Hays25fiftM84u4+aTKMWkl3nlyPKPyeLkA/h2K3zJm4UEzNdjVJqoPH3YU4SRlbQEThj0j1po4Xc=
X-Received: by 2002:a17:906:7486:b0:99c:d9cc:9667 with SMTP id
 e6-20020a170906748600b0099cd9cc9667mr1156249ejl.7.1691561339293; Tue, 08 Aug
 2023 23:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com> <0ac280ab-08f1-b031-e21b-49390182f090@linux.alibaba.com>
In-Reply-To: <0ac280ab-08f1-b031-e21b-49390182f090@linux.alibaba.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Wed, 9 Aug 2023 14:08:47 +0800
Message-ID: <CAB9BWhfRHSqWrBbeisoGLqeBYXc9Pc_uGH0GxnfedXROpU_0-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic number
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi baolin:
1.Please describe the problem in detail, not only what you did.

We will describe the reason for the modification by supplementing the
commit message.

2.Can you explicit on which controller can support 8 banks in the commit
log? And you did not change all the related comments in this file.

The old project EIC controller can support maximum 3 banks,
now our new project eic controller can support maximum 8 banks=EF=BC=8C
and each bank contains 8 EICs.
We will modify the comment in this file.

3.If you want to introduce a readable macro, that's fine, but it should be
split into a separate patch.
4.This change looks good to me, and this seems a software bug in the
original driver. So I think this change should be moved into a separate
patch with a suitable Fixes tag.
5.Do not add unreated changes that you did not mentioned in the commit log.

We will re-split the patch submission and explain our reasons for
modification in the submission information, thank you very much for
your review.

Baolin Wang <baolin.wang@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=
=889=E6=97=A5=E5=91=A8=E4=B8=89 09:24=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> > Automatic calculation through matching nodes,
> > subsequent projects can avoid modifying driver files.
>
> Please describe the problem in detail, not only what you did.
>
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++----------------=
-
> >   1 file changed, 26 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 84352a6f4973..0d85d9e80848 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -50,10 +50,10 @@
> >   #define SPRD_EIC_SYNC_DATA          0x1c
> >
> >   /*
> > - * The digital-chip EIC controller can support maximum 3 banks, and ea=
ch bank
> > + * The digital-chip EIC controller can support maximum 8 banks, and ea=
ch bank
>
> Can you explicit on which controller can support 8 banks in the commit
> log? And you did not change all the related comments in this file.
>
> >    * contains 8 EICs.
> >    */
> > -#define SPRD_EIC_MAX_BANK            3
> > +#define SPRD_EIC_MAX_BANK            8
> >   #define SPRD_EIC_PER_BANK_NR                8
> >   #define SPRD_EIC_DATA_MASK          GENMASK(7, 0)
> >   #define SPRD_EIC_BIT(x)                     ((x) & (SPRD_EIC_PER_BANK=
_NR - 1))
> > @@ -99,33 +99,32 @@ struct sprd_eic {
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
>
> If you want to introduce a readable macro, that's fine, but it should be
> split into a separate patch.
>
> >   static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *spr=
d_eic,
> >                                                unsigned int bank)
> > @@ -583,6 +582,7 @@ static int sprd_eic_probe(struct platform_device *p=
dev)
> >       struct sprd_eic *sprd_eic;
> >       struct resource *res;
> >       int ret, i;
> > +     u16 num_banks =3D 0;
> >
> >       pdata =3D of_device_get_match_data(&pdev->dev);
> >       if (!pdata) {
> > @@ -613,12 +613,13 @@ static int sprd_eic_probe(struct platform_device =
*pdev)
> >                       break;
> >
> >               sprd_eic->base[i] =3D devm_ioremap_resource(&pdev->dev, r=
es);
> > +             num_banks++;
> >               if (IS_ERR(sprd_eic->base[i]))
> >                       return PTR_ERR(sprd_eic->base[i]);
> >       }
> >
> >       sprd_eic->chip.label =3D sprd_eic_label_name[sprd_eic->type];
> > -     sprd_eic->chip.ngpio =3D pdata->num_eics;
> > +     sprd_eic->chip.ngpio =3D num_banks * SPRD_EIC_PER_BANK_NR;
>
> This change looks good to me, and this seems a software bug in the
> original driver. So I think this change should be moved into a separate
> patch with a suitable Fixes tag.
>
> >       sprd_eic->chip.base =3D -1;
> >       sprd_eic->chip.parent =3D &pdev->dev;
> >       sprd_eic->chip.direction_input =3D sprd_eic_direction_input;
> > @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device =
*pdev)
> >               sprd_eic->chip.set =3D sprd_eic_set;
> >               fallthrough;
> >       case SPRD_EIC_ASYNC:
> > +             fallthrough;
> >       case SPRD_EIC_SYNC:
> >               sprd_eic->chip.get =3D sprd_eic_get;
> >               break;
> >       case SPRD_EIC_LATCH:
> > +             fallthrough;
>
> Do not add unreated changes that you did not mentioned in the commit log.
