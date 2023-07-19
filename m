Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747D7596BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGSN2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGSN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:28:06 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F3CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:28:04 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4815756d742so2090669e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689773284; x=1690378084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flEwfn9BpI6GLbTD9ZQxNq/h4BeiJLyxxD5aIyE9kIA=;
        b=wRtkVyr3297wr6GJR9LD3x3GIr5dtP27Y+0VJvbyN3UOp/Img7GGPZ/uPuw1DyQPgR
         yiuD4isYWpQyy3Q/+6V/PBssPy42oq5nGo34HEl0y8Idn1Z3jBpEM049BBl2y3JxxiFj
         ZHhVirPxt30HWnZf5WhykMaAQOxHyGOCwckV9xephk8QoL6FArRXhGDX59NVKekiY3lC
         /Pjyd9EP5ao2vdAVqYWIkpCdx9lAebS/j6bkVM0+BsNcl74Lpkr4mGIrVQ0IW5JEExTm
         lBEbXg+AbZFIPqPsMKMO4MtaQwyUEFHcOM+iM9RLCN0dN+AMkg/oR6IVBFv88BrwcR8d
         4tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773284; x=1690378084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flEwfn9BpI6GLbTD9ZQxNq/h4BeiJLyxxD5aIyE9kIA=;
        b=RRpAFb01ydz+3VvCfNzpdvHwiWlHa69Dj2960pQQnNVO/CG+apwdGwRdigAPAT5O18
         iQsCqFXu09jwxCX1v4/j6X7S1Z/ybZRKyh3KT8ePU/0iZO+6YAzJP/lV2D0hG1BQ8qTc
         5+WUdRIF1BAusEp/gm3dQM6Ew2qOON2bbX0l0fUDLvasAPU+9y6IOhIErUMPwKjpbm18
         qMgecpWbXvF4R9or4occfROF9RX4MBSaT1xgd32IzfS4c0u4wWSzFloDy6mD2lsTaPIZ
         rtZK+ev3SzqZSeXhDRwLM4NHQZq1uWk/kNMic6sPr9Bo/Cs4e1O4sVKFdyBZ+sKz4qWZ
         kxGw==
X-Gm-Message-State: ABy/qLY32TozW/5xnmHkc3hOTgYd8P4EAkJZ9L0Bv/K+sxwwGnbn51gf
        E7r4HajU/BL8tz9Nny89K/MOZ/95oJdxGPOEsLgmpQ==
X-Google-Smtp-Source: APBJJlFJm2ZMiFRABNNtoXvQlrC7EHOreqZ1E7RaK2D8FV20PxDW2Tlho5AZvU4VBfgpyWUiBERBrDIqdnJimDI905k=
X-Received: by 2002:a1f:d087:0:b0:471:b557:12a with SMTP id
 h129-20020a1fd087000000b00471b557012amr3157493vkg.11.1689773283085; Wed, 19
 Jul 2023 06:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230719114101.55051-1-brgl@bgdev.pl> <CAHp75VfdCsAE8dGfTe2PsT5kxvoT84nChNptwgaA4Q5jf5oJvQ@mail.gmail.com>
In-Reply-To: <CAHp75VfdCsAE8dGfTe2PsT5kxvoT84nChNptwgaA4Q5jf5oJvQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 19 Jul 2023 15:27:52 +0200
Message-ID: <CAMRc=MdxY0s347g36jjvPc_HC-LtJyhNbycF3ZmtUwe1AZywpQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: fix irq domain leak
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:03=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 19, 2023 at 2:41=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Uwe Kleine-K=C3=B6nig pointed out we still have one resource leak in th=
e mvebu
> > driver triggered on driver detach. Let's address it with a custom devm
> > action.
>
> One nit-pick below, in either case
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Fixes: 812d47889a8e ("gpio/mvebu: Use irq_domain_add_linear")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index a35958e7adf6..67497116ce27 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platfo=
rm_device *pdev,
> >         return 0;
> >  }
> >
> > +static void mvebu_gpio_remove_irq_domain(void *data)
> > +{
> > +       struct irq_domain *domain =3D data;
> > +
> > +       irq_domain_remove(domain);
>
> The from/to void * doesn't need an explicit casting in C. This can be
> a one liner
>

I know but I prioritise readability over brevity. I prefer this version.

Bart

> static void mvebu_gpio_remove_irq_domain(void *domain)
> {
>       irq_domain_remove(domain);
> }
>
> > +}
> > +
> >  static int mvebu_gpio_probe(struct platform_device *pdev)
> >  {
> >         struct mvebu_gpio_chip *mvchip;
> > @@ -1246,13 +1253,18 @@ static int mvebu_gpio_probe(struct platform_dev=
ice *pdev)
> >                 return -ENODEV;
> >         }
> >
> > +       err =3D devm_add_action_or_reset(&pdev->dev, mvebu_gpio_remove_=
irq_domain,
> > +                                      mvchip->domain);
> > +       if (err)
> > +               return err;
> > +
> >         err =3D irq_alloc_domain_generic_chips(
> >             mvchip->domain, ngpios, 2, np->name, handle_level_irq,
> >             IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_LEVEL, 0, 0);
> >         if (err) {
> >                 dev_err(&pdev->dev, "couldn't allocate irq chips %s (DT=
).\n",
> >                         mvchip->chip.label);
> > -               goto err_domain;
> > +               return err;
> >         }
> >
> >         /*
> > @@ -1292,10 +1304,6 @@ static int mvebu_gpio_probe(struct platform_devi=
ce *pdev)
> >         }
> >
> >         return 0;
> > -
> > -err_domain:
> > -       irq_domain_remove(mvchip->domain);
> > -       return err;
> >  }
>
>
> --
> With Best Regards,
> Andy Shevchenko
