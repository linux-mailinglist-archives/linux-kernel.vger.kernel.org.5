Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48E87A4A47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbjIRM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjIRM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:57:24 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F409B2;
        Mon, 18 Sep 2023 05:57:18 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49369d29be3so1882757e0c.3;
        Mon, 18 Sep 2023 05:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695041837; x=1695646637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BEz+li0aM2yAw5zG65/N2MxxkFouvW01zCcc98qURY=;
        b=bmScx56++v3Yi4rZHbpRX5ChmS9Zes8jZrmnA19qyVDUeUkuGMJ5r3/DmOaGCz9qkZ
         eOda2PTluTh+MXDNc1DzGXOmZORp80eaM2mCMiC6FRuachJ9aQdOUjhTZ43iAXv3b0y3
         puxGO+N9J/79mlApVR6a5V+san0EYZ3AvTRmA7O+onpVU1WQLmk8Zys/tAk/BHTfC6FU
         3vywqgksDyS3qikyiOhn05oSNxBPi7HV8SglvJtGteTjttl1dQ6a8D6dQg+7FjFpPpT8
         A2PoBJSgsoKkpX/h+m9MRHug9Uh47dMxZZOJT2npkz1iEmLsznppWzia4ZbZ+qPAPF56
         VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041837; x=1695646637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BEz+li0aM2yAw5zG65/N2MxxkFouvW01zCcc98qURY=;
        b=L6q3dUBpdhXj/pRku3BPAlAuvRANUiUasJQ1+/Zg7A4X6ZSxkWxseZ+ro7eB9cXoVG
         zRUeSE6CGzLPJ1WRe41k4qxAsNUGnKhplagb6X1htqenLE6d5pJpfbBTsbFBZH2FGr9Y
         ExIjbz//cpr6V+QB8XM6tNKtxm/qyk0B5xoXbnle/Y/RrXMrFZCKzwdtvKGVpH5tB3Lm
         Imr1El8OV1EEWVKMFb+W6VdyVCA5DffgBw+OLbfTlXY+VXggbgKg1IieydKchrkc/Q33
         21CnxX3lpb/3S0KV1rhU7UerUbYFwigzi9ucibkCxQvDaeArQBHmiDkaci7N+hl+UnTF
         /Cnw==
X-Gm-Message-State: AOJu0Ywks2gSJwknUTRhG/RrT+4oALm/7FzGFm3TO6HGn6HndXNxkryF
        a+cFQJ/FibCE4hc7XuAr17n1PT3Vu8DomyAvGeZ3zHZznKtNig==
X-Google-Smtp-Source: AGHT+IGQV/28QZIvdVFqYDR7gAtvpQe0MN+yQi6gBHXAbw4j35W0RA1hZgwKG9s2x3A1YHawgWZxiHLaIzoW5W0wp+k=
X-Received: by 2002:a05:6122:c57:b0:496:b3b7:5d4d with SMTP id
 i23-20020a0561220c5700b00496b3b75d4dmr1747884vkr.6.1695041837405; Mon, 18 Sep
 2023 05:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131638.443055-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVcuMGTwNaTY8v-hcbov22zTU268meU28J7+FrWiPioxw@mail.gmail.com>
In-Reply-To: <CAMuHMdVcuMGTwNaTY8v-hcbov22zTU268meU28J7+FrWiPioxw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 18 Sep 2023 13:55:56 +0100
Message-ID: <CA+V-a8vkbTE2LiO23sjFBb7bJK9gmfQN+SQdbDOvoOjrXrYfoA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: renesas: pinctrl-rzg2l: Add validation of
 GPIO pin in rzg2l_gpio_request()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Mon, Sep 18, 2023 at 1:31=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Sep 11, 2023 at 3:17=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Validate the GPIO pin request in rzg2l_gpio_request() callback using
> > rzg2l_validate_gpio_pin() function. This stops any accidental usage
> > of GPIO pins which are not supported by the SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> > v1->v2
> > * Maintained reverse christmas tree order.
> > * Included RB/TB tags from Claudiu.
>
> Thanks for your patch!
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_con=
fops =3D {
> >  static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int off=
set)
> >  {
> >         struct rzg2l_pinctrl *pctrl =3D gpiochip_get_data(chip);
> > +       const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[offset=
];
> >         u32 port =3D RZG2L_PIN_ID_TO_PORT(offset);
> >         u8 bit =3D RZG2L_PIN_ID_TO_PIN(offset);
> > +       u64 *pin_data =3D pin->drv_data;
>
> isn't drv_data a pointer to unsigned int aka u32?
>
Agreed. I will fix this and send a v3.

Cheers,
Prabhakar

> >         unsigned long flags;
> >         u8 reg8;
> >         int ret;
> >
> > +       ret =3D rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
> > +       if (ret)
> > +               return ret;
> > +
> >         ret =3D pinctrl_gpio_request(chip->base + offset);
> >         if (ret)
> >                 return ret;
>
> The rest LGTM.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
