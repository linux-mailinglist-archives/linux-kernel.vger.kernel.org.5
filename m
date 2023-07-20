Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16A75B267
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjGTPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjGTPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:23:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F222132
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:23:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b708e49059so14066541fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689866591; x=1690471391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPQnrOARiDFo5sqjfjZ2rVtHE8KTAkxuOmgwA4v7Z5A=;
        b=xuPC1yT5GRzBtJCOV0E3sv+xf43uZLpnDcJYPuKFf+eCUFcTWZfGCQYnQk6MzXITne
         MwJ5ldTCa9NXMRFEnbR8lZzn9BdisGRYTdWwuYReJTZV+V7RG/p0Q63oTpLzQd+HO5Oc
         g2Ozna4mxVHFG1qTPAdHJxtwVhuJMxqF8vyMWyTlR8VaVvX3VW5kzILuxb0xGbhQiLwc
         mTWIuNpS2HZDH8wWyJdeAAaeZ24gpxthbxUMAKvXfZlPNVmP7RKJtx1LFJwnxvrfw/ta
         cmIaNO8RVO9pV3OOGIx18MrBB/SGaYAsNVGDlDN9lkLFuv+sfD150Ul11H3CKKJyCZ9e
         7NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866591; x=1690471391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPQnrOARiDFo5sqjfjZ2rVtHE8KTAkxuOmgwA4v7Z5A=;
        b=QQrhRqImDwFLuXLtU/EZ8K1iaoHaYWl2qZAde/w+jygazkkXkrspnsXpNDGjRychRP
         91/BddvF717I/OHhatTnLPlKF25XSVZRKcs+KIwTg4UoGD07TyjUdX62y3VbD5OJkapu
         J6MvXoAAVby0o5QH78oUankb/YbuRb3zG50xouZbcw+w3iBzCinauqcEFE5tn/BIyEi7
         2oAdw0rojOJ04NPecJbcIQPCUzZqrrI2Xfm/tSGcdxWBlBjUqKhldt8alTmMwhoXOyLs
         6+Ylem7F/Sxd18A0RJNe2+wja4T98ThjDQm6uEafELY3BLXGSMfwPDpZVzBatmA2pZHd
         fhQw==
X-Gm-Message-State: ABy/qLb+/U6kkCAIy91N4nCGYu3Ii2w937JesxjRR3AnijUVWk+XQNZP
        xlbFUqH7TmEr/roxygjB1y168nLiRoaOYltzhOlPEA==
X-Google-Smtp-Source: APBJJlFrjnHLPRbT8vq98J4JSA5g0Ix+9H636iwdDSzQ2q/7eIkXKBUVQqIhUeFIrh9kQh/FwAwZtQYLfzenXzIo4tE=
X-Received: by 2002:a2e:3004:0:b0:2b6:efd0:5dd8 with SMTP id
 w4-20020a2e3004000000b002b6efd05dd8mr2511816ljw.46.1689866590876; Thu, 20 Jul
 2023 08:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230711072053.2837327-1-geert+renesas@glider.be> <CAMRc=Mef-J-WinQxphm+CU8u-PoBan1hPT2yLih4i-RFUDePBQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mef-J-WinQxphm+CU8u-PoBan1hPT2yLih4i-RFUDePBQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:22:59 +0200
Message-ID: <CAMRc=MfsbngW4dor9UXX1ncyabZ=NjUFZFTarcfgOO3iMz4zgw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Improve PM configuration
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 5:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Jul 11, 2023 at 9:20=E2=80=AFAM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > If CONFIG_PM=3Dn (e.g. m68k/allmodconfig):
> >
> >     drivers/gpio/gpio-mxc.c:612:12: error: =E2=80=98mxc_gpio_runtime_re=
sume=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >       612 | static int mxc_gpio_runtime_resume(struct device *dev)
> >           |            ^~~~~~~~~~~~~~~~~~~~~~~
> >     drivers/gpio/gpio-mxc.c:602:12: error: =E2=80=98mxc_gpio_runtime_su=
spend=E2=80=99 defined but not used [-Werror=3Dunused-function]
> >       602 | static int mxc_gpio_runtime_suspend(struct device *dev)
> >           |            ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
> > callbacks, and by wrapping the driver.pm initializer insider pm_ptr().
> >
> > As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
> > __maybe_unused annotations for the noirq callbacks are no longer needed=
,
> > and can be removed.
> >
> > Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/gpio/gpio-mxc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> > index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
> > --- a/drivers/gpio/gpio-mxc.c
> > +++ b/drivers/gpio/gpio-mxc.c
> > @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *d=
ev)
> >         return 0;
> >  }
> >
> > -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> > +static int mxc_gpio_noirq_suspend(struct device *dev)
> >  {
> >         struct platform_device *pdev =3D to_platform_device(dev);
> >         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> > @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(st=
ruct device *dev)
> >         return 0;
> >  }
> >
> > -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> > +static int mxc_gpio_noirq_resume(struct device *dev)
> >  {
> >         struct platform_device *pdev =3D to_platform_device(dev);
> >         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> > @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(str=
uct device *dev)
> >  }
> >
> >  static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
> > -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_=
noirq_resume)
> > -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_r=
esume, NULL)
> > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noir=
q_resume)
> > +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resum=
e, NULL)
> >  };
> >
> >  static int mxc_gpio_syscore_suspend(void)
> > @@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver =3D {
> >                 .name   =3D "gpio-mxc",
> >                 .of_match_table =3D mxc_gpio_dt_ids,
> >                 .suppress_bind_attrs =3D true,
> > -               .pm =3D &mxc_gpio_dev_pm_ops,
> > +               .pm =3D pm_ptr(&mxc_gpio_dev_pm_ops),
> >         },
> >         .probe          =3D mxc_gpio_probe,
> >  };
> > --
> > 2.34.1
> >
>
> Applied, thanks!
>
> Bart

Nevermind, Arnd has a better fix for that so I'll apply his change.

Bart
