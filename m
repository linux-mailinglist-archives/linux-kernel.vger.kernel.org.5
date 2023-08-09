Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04BF77529A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHIGLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHIGLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:11:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE21E61;
        Tue,  8 Aug 2023 23:11:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-94ea38c90ccso165802366b.1;
        Tue, 08 Aug 2023 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691561489; x=1692166289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+GprpEYaWKSIBz3lNF0rHXfz5G4zWTRgIo6CIukXOs=;
        b=dnisEdRnrIJchTHxIMrhNDkguZRPzCt9B/4Cf+cd5/0Yfl73fh6DiodUad0URAMbxZ
         jQ9GzsCW1jsLdJjBaQGAs8A+Dn1Ee7JTBG9DCWKBR4PON3tSWoyQc4OHGECV/uMpyUVA
         HlDFm0BRopDqYg7gWa1WRujuEv++HLcX8rkgPJzAzWcPXYing6Qqa94S6udQ56nag23Z
         kjoE4JABZ+LNAPqIPEKzKwksvz5u8reMIlyLzXfGHaJu6MuN05P15aXC7ByIxzUpjbUY
         36hAE118gfg1pZReKzZsLwwJzIXhOMRrasdWocjWisjkNUN72Z8++hLHZgDOHzD/d6rp
         SZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691561489; x=1692166289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+GprpEYaWKSIBz3lNF0rHXfz5G4zWTRgIo6CIukXOs=;
        b=KFfm2SjWipNzd0+9tPSswt0en39eMUmHDBxBSRYSb5FUaBcU+yHN/RQlZl8PMsrI9K
         FOUM2D4IVshdb8XP4k2K+XJAxT+4P+1GK7wLTOmXI9ih3Zzq+ekStG+XhBNIiqMwe1rj
         9fg/kfRdtZ8yBvjmBoikWZ66k1iNe6TLq/8d8LrzjVp/1qeAWYLOClau5AFSEcTDQtst
         58XXwHe5XsOlncAHbx6LuBrCNEQzvUvJzr2Muv0UYE4VNEHuxVPpPhHvw8VvQNvC6GhY
         OOg7CZJUlWUD/ow6L9HRnyK0stzuvLl1BVGsyyalVt3ozhizK66PXbo+hispLE+CUsYl
         R8Aw==
X-Gm-Message-State: AOJu0YzJTgXnvC1W6yUa8sH07jotUzAQ5ZbVDtOCEOYoEtQ7+yDR6Rok
        yfjTSMDYUMz47eWEjbf8NAs6mdVFnZEsxvLKHBSpbbYULYy04A==
X-Google-Smtp-Source: AGHT+IEhNfeIaqOgU2Z4nHn5r7cWIj7seZfQvuXYfR9BPPNljofoqTvdY5xLqoSAiw7dlOzjepxAtst+AQo9el3AgMU=
X-Received: by 2002:a17:906:10c9:b0:99c:c178:cef9 with SMTP id
 v9-20020a17090610c900b0099cc178cef9mr1176187ejv.2.1691561488616; Tue, 08 Aug
 2023 23:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com> <20230808134442.75bb6f04b5612c07d3b7d731@hugovil.com>
In-Reply-To: <20230808134442.75bb6f04b5612c07d3b7d731@hugovil.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Wed, 9 Aug 2023 14:11:17 +0800
Message-ID: <CAB9BWhcvVj-J-NyqQE6NBW_fNvMvbg9ZMkkMD26QnQexawbU0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic number
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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

Hi Hugo:
We will re-split the patch submission and explain our reasons for
modification in the submission information, thank you very much for
your review.

Hugo Villeneuve <hugo@hugovil.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 01:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 8 Aug 2023 11:31:06 +0800
> Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> > Automatic calculation through matching nodes,
> > subsequent projects can avoid modifying driver files.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 84352a6f4973..0d85d9e80848 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -50,10 +50,10 @@
> >  #define SPRD_EIC_SYNC_DATA           0x1c
> >
> >  /*
> > - * The digital-chip EIC controller can support maximum 3 banks, and ea=
ch bank
> > + * The digital-chip EIC controller can support maximum 8 banks, and ea=
ch bank
> >   * contains 8 EICs.
> >   */
> > -#define SPRD_EIC_MAX_BANK            3
> > +#define SPRD_EIC_MAX_BANK            8
> >  #define SPRD_EIC_PER_BANK_NR         8
> >  #define SPRD_EIC_DATA_MASK           GENMASK(7, 0)
> >  #define SPRD_EIC_BIT(x)                      ((x) & (SPRD_EIC_PER_BANK=
_NR - 1))
> > @@ -99,33 +99,32 @@ struct sprd_eic {
> >
> >  struct sprd_eic_variant_data {
> >       enum sprd_eic_type type;
> > -     u32 num_eics;
> >  };
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
> >  static const char *sprd_eic_label_name[SPRD_EIC_MAX] =3D {
> >       "eic-debounce", "eic-latch", "eic-async",
> >       "eic-sync",
> >  };
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
> >  static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd=
_eic,
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
> >       sprd_eic->chip.base =3D -1;
> >       sprd_eic->chip.parent =3D &pdev->dev;
> >       sprd_eic->chip.direction_input =3D sprd_eic_direction_input;
> > @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device =
*pdev)
> >               sprd_eic->chip.set =3D sprd_eic_set;
> >               fallthrough;
> >       case SPRD_EIC_ASYNC:
> > +             fallthrough;
>
> Hi,
> this probably should go in a separate patch as a fix or an
> improvement with proper comments explaining the reason?
>
> >       case SPRD_EIC_SYNC:
> >               sprd_eic->chip.get =3D sprd_eic_get;
> >               break;
> >       case SPRD_EIC_LATCH:
> > +             fallthrough;
>
> ditto.
>
> Hugo Villeneuve
>
>
> >       default:
> >               break;
> >       }
> > --
> > 2.17.1
> >
