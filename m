Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0D760FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjGYJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjGYJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:58:23 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757E1FC6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:58:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so4212943241.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690279092; x=1690883892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0CXr8qUO3I0b7KpmPpq9/x2xv1za5Y0XE1WB4W2dco=;
        b=lL+qxX++mKtv4r4f3KBsqJpG6c+NUpeIZF7o8MnMcy+bdBdH7QAGMhjJD+hATUi3V3
         6uHgehJ6yU6DCnQ5z2KMjsI6OGboAZiIPy45Eyu8SEh24DIiOdYd76Dp3u8vGPGBX5nm
         HY8JhyPgSv3zfr0ULBKqdi/spIsqYrkDvLYEzRUDAQxbkfIzpbse4pWmwovfd+Hpf8xH
         1lUspD322S0cE1WXgBeDjIO8sZ6ARh4/K6gsk2HaSLVyf3BbcCv5tiAf+JlGaUnj/tPM
         BaJqcicgsKxWwJeUlnUS2/U4ZfWGCoBFkEAsewMSAq9+rL++k5Dig/Yg5ldU8qmR8o+X
         PUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279092; x=1690883892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0CXr8qUO3I0b7KpmPpq9/x2xv1za5Y0XE1WB4W2dco=;
        b=dwW3hmzETpUK90IWHTHVzdqNBcXQ3u/9S37zgkhoky0WOLw2MQdydJmzZvM6MNJZKJ
         z2bJGitpqn7WmL7q3c1ihtQ265VHmD2WWgOoYmcd+P8KW+AdHuJ58r4OOVhbUPENJZ7W
         iiqi54OXpXsbzGjf8Eo/aNPnZDhX4CMSo9LJbMYyl+9rysP43p/xPWkwYvrTe9hqdndw
         5tazZ/6iq0+AG/K4sFCSnVHXfsTTBS0ReyOltuuH3omFJTGPzzewaWNugbDVJmYCm/xN
         i6n6y3fgjp5NVl1hA+BAevbWIxN1TuMaqGJxfGzZVZwtUUPw2ZHPuHAdOlEbQ8TJcYYY
         1w+A==
X-Gm-Message-State: ABy/qLYo4VqmQxuU4CX5P6yzTPYxbmLtGnjAkZrzj+MxO7Vfoej7kwA1
        DTJ071op7pe0VjIuIojd9zoEzUbnig4txAfKnEhzdw==
X-Google-Smtp-Source: APBJJlFdl4pjj60VCQ6ocL2zvFgFApGyitoMmdpxPHUtlbE9IO6z24Zk9if6TZexgwuwVsc1CxNfczNoRuu0LPDWCZA=
X-Received: by 2002:a67:f5c3:0:b0:43f:3426:9e35 with SMTP id
 t3-20020a67f5c3000000b0043f34269e35mr517225vso.12.1690279092356; Tue, 25 Jul
 2023 02:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230711072053.2837327-1-geert+renesas@glider.be>
 <CAMRc=Mef-J-WinQxphm+CU8u-PoBan1hPT2yLih4i-RFUDePBQ@mail.gmail.com>
 <CAMRc=MfsbngW4dor9UXX1ncyabZ=NjUFZFTarcfgOO3iMz4zgw@mail.gmail.com> <CAMuHMdUratvH_C=EXaMxY+SDpvdRbLGPhe4qN7h_TtvHc_zWSg@mail.gmail.com>
In-Reply-To: <CAMuHMdUratvH_C=EXaMxY+SDpvdRbLGPhe4qN7h_TtvHc_zWSg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Jul 2023 11:58:01 +0200
Message-ID: <CAMRc=Mcqk+DSGS6co8oLD1K+_BFaUwirCgy0j0oTPDH3R_MKCw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: Improve PM configuration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 6:50=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Bartosz,
>
> On Thu, Jul 20, 2023 at 5:23=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Thu, Jul 20, 2023 at 5:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > > On Tue, Jul 11, 2023 at 9:20=E2=80=AFAM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > If CONFIG_PM=3Dn (e.g. m68k/allmodconfig):
> > > >
> > > >     drivers/gpio/gpio-mxc.c:612:12: error: =E2=80=98mxc_gpio_runtim=
e_resume=E2=80=99 defined but not used [-Werror=3Dunused-function]
> > > >       612 | static int mxc_gpio_runtime_resume(struct device *dev)
> > > >           |            ^~~~~~~~~~~~~~~~~~~~~~~
> > > >     drivers/gpio/gpio-mxc.c:602:12: error: =E2=80=98mxc_gpio_runtim=
e_suspend=E2=80=99 defined but not used [-Werror=3Dunused-function]
> > > >       602 | static int mxc_gpio_runtime_suspend(struct device *dev)
> > > >           |            ^~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Fix this by using the non-SET *_PM_OPS to configure the dev_pm_ops
> > > > callbacks, and by wrapping the driver.pm initializer insider pm_ptr=
().
> > > >
> > > > As NOIRQ_SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr() internally, the
> > > > __maybe_unused annotations for the noirq callbacks are no longer ne=
eded,
> > > > and can be removed.
> > > >
> > > > Fixes: 3283d820dce649ad ("gpio: mxc: add runtime pm support")
> > > > Reported-by: noreply@ellerman.id.au
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/gpio/gpio-mxc.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> > > > index a9fb6bd9aa6f9645..a43df5d5006e62d3 100644
> > > > --- a/drivers/gpio/gpio-mxc.c
> > > > +++ b/drivers/gpio/gpio-mxc.c
> > > > @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct devic=
e *dev)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *de=
v)
> > > > +static int mxc_gpio_noirq_suspend(struct device *dev)
> > > >  {
> > > >         struct platform_device *pdev =3D to_platform_device(dev);
> > > >         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> > > > @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspen=
d(struct device *dev)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev=
)
> > > > +static int mxc_gpio_noirq_resume(struct device *dev)
> > > >  {
> > > >         struct platform_device *pdev =3D to_platform_device(dev);
> > > >         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> > > > @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume=
(struct device *dev)
> > > >  }
> > > >
> > > >  static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
> > > > -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_g=
pio_noirq_resume)
> > > > -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runti=
me_resume, NULL)
> > > > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_=
noirq_resume)
> > > > +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_r=
esume, NULL)
> > > >  };
> > > >
> > > >  static int mxc_gpio_syscore_suspend(void)
> > > > @@ -695,7 +695,7 @@ static struct platform_driver mxc_gpio_driver =
=3D {
> > > >                 .name   =3D "gpio-mxc",
> > > >                 .of_match_table =3D mxc_gpio_dt_ids,
> > > >                 .suppress_bind_attrs =3D true,
> > > > -               .pm =3D &mxc_gpio_dev_pm_ops,
> > > > +               .pm =3D pm_ptr(&mxc_gpio_dev_pm_ops),
> > > >         },
> > > >         .probe          =3D mxc_gpio_probe,
> > > >  };
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Applied, thanks!
> > >
> > > Bart
> >
> > Nevermind, Arnd has a better fix for that so I'll apply his change.
>
> I disagree. And my patch was first ;-)
>
> Arnd's version lacks the pm_ptr() around the mxc_gpio_driver.driver.pm
> initializer, so the compiler cannot throw out the (rather large) unused
> mxc_gpio_dev_pm_ops structure.
>
> Thanks!
>

Fair enough, I replaced Arnd's patch with yours.

Thanks,
Bartosz
