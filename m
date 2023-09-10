Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4754799E70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbjIJNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIJNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:16:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A719C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 06:16:22 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59b50b4556eso24969227b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694351782; x=1694956582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjN8Of+pjWX2CIVjsxXC9mGE1z6Iz0B/xqCqiSzzvAM=;
        b=f8gJp92hUB5JuKVo9palR3Aerpd2bdVR4MneqqSNR8YU7djH7qXfrIR9qnprJPnzOB
         hzpf8m5OGJjHq0/iI8lq+4uUJmrceZN0mgQtFzp0ZviLmYYkVPML0zvIdyjk/9zeyToi
         Ligilr6BfzvaqfRNTJ3g1wmRxdNmuP/xKqUDdBXn9fI0Nnnsfbt5s61mBR+YfTKIji4v
         1PIP37QWZ9hxMSRrzsWYnr23BeqONv77Dsy2JPhX0YdjbhsM4LHnV/jSm1ERRYktGc0G
         n0RcbFC5GNmwiInqysGuzo/hW95CxGMJFR5DQEKmUfcnWrIGL70+yTEZAN4OoYjv8+l2
         V9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694351782; x=1694956582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjN8Of+pjWX2CIVjsxXC9mGE1z6Iz0B/xqCqiSzzvAM=;
        b=w2fYZo9ZxTGvX9UnNFpHkw7jpgsOygpApd9GSeH+7Lzwfu90N3I8HCt3M8784Lm7Co
         qpKNJCOBEV+QtcQ6zvqhcy2XG0RaNx7qW/AtjFwFM6ocnbDCFkBaVhDYJqq1t1nnd81Y
         ZEa57jUDctKd5Ua7xYYTv5H4vRMw2qYshEl/rWH5VLI9m594JE6gK0gZmBPMtvlbM7xY
         jsEkqZqmjRECvl+WZsxM53TUqqjX+rumDI9tKCxS5UqHab90RggthW8Jkgx8vY0XsGiv
         FA0FLcshmg1DXuRcgtFrXrgWYB+vjkdx2bXXuD8qIXwgMluQx9t1l9VdjlM8UUAxnAFJ
         YQhw==
X-Gm-Message-State: AOJu0YygtBekhXel8KumQzmTcDLXPb0PyqSuZtJga/uWpZOYR088Qblq
        3JjziCj0RMSvVy1y2Aylf0B/QfbBWdLwCgYRTBPZ8Q==
X-Google-Smtp-Source: AGHT+IEdl77algUKJuww50Wn5JRJSRoXn8xdxcz8+JHG/Ps8qzQnbLkhisoVtUzAvd4QI8dp5BFqrRqOymoPVtvG7R4=
X-Received: by 2002:a0d:ddcf:0:b0:586:a684:e7b6 with SMTP id
 g198-20020a0dddcf000000b00586a684e7b6mr8360407ywe.9.1694351781945; Sun, 10
 Sep 2023 06:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de> <CAHh=Yk8R02NXK33aogQeJQB6x88B_gpbnjHj9wRrJEbDQf67Aw@mail.gmail.com>
 <20230908144942.d3feisuyctppfb3l@pengutronix.de>
In-Reply-To: <20230908144942.d3feisuyctppfb3l@pengutronix.de>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Sun, 10 Sep 2023 21:16:10 +0800
Message-ID: <CAHh=Yk9EU74aeG2P1Sd0JG8hQdvkQpL3QE4VhZ9DmMN+JV2xHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED algorithm
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe

I'm glad the example was helpful to you. I will double-check and
verify my implementation once again.

Thank you for your assistance.

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=B9=
=B49=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:50=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Fri, Sep 08, 2023 at 06:41:00PM +0800, Nylon Chen wrote:
> > Sorry it's so long ago.
> >
> > I have completed the implementation of the new version, but there is
> > one thing about this letter that I still don't quite understand.
> >
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=
=E5=B9=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > > > The `frac` variable represents the pulse inactive time, and the res=
ult of
> > > > this algorithm is the pulse active time. Therefore, we must reverse=
 the
> > > > result.
> > > >
> > > > The reference is SiFive FU740-C000 Manual[0].
> > > >
> > > > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-8=
6ed8b16acba_fu740-c000-manual-v1p6.pdf
> > > >
> > > > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > > > ---
> > > >  drivers/pwm/pwm-sifive.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > > index 62b6acc6373d..a5eda165d071 100644
> > > > --- a/drivers/pwm/pwm-sifive.c
> > > > +++ b/drivers/pwm/pwm-sifive.c
> > > > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> > > >       /* The hardware cannot generate a 100% duty cycle */
> > > >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > > > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> > >
> > > The same problem exists in pwm_sifive_get_state(), doesn't it?
> > >
> > > As fixing this is an interruptive change anyhow, this is the opportun=
ity
> > > to align the driver to the rules tested by PWM_DEBUG.
> > >
> > > The problems I see in the driver (only checked quickly, so I might be
> > > wrong):
> > >
> > >  - state->period !=3D ddata->approx_period isn't necessarily a proble=
m. If
> > >    state->period > ddata->real_period that's fine and the driver shou=
ld
> > >    continue
> >
> > I still don=E2=80=99t quite understand the description of this paragrap=
h.
> >
> > state->period !=3D ddate->approx_period seems to be used to compare the
> > results of the previous and next two times.
>
> There are two things to consider:
>
>  - usually the hardware doesn't support all requestable states because
>    the hardware's quantum is > 1 ns. That is, it might for example
>    support periods in the form (160 ns * i / 3) for i in 1 .. 1023.
>
>    If this hardware runs with i =3D 500 (that is period ~=3D 26666.66
>    ns) because the first channel is configured to run with period =3D
>    26667, and .request is called for the 2nd channel with .period =3D
>    26700 ns, there is no need to refuse that, because 26666.66 is the
>    best possible approximation for 26700 ns anyhow.
>
>  - .apply is supposed to implement the highest possible period that
>    isn't bigger than the requested period. So in the above case even if
>    the hardware runs at 26666.66 ns without the possibility to change
>    that, a request to configure for period =3D 30000 ns could succeed (an=
d
>    keep 26666.66 ns).
>
> > Would you suggest I send the new implementation version before
> > continuing the discussion?
>
> Note that the above implements the optimal behaviour for a driver.
> (For some definition of "optimal" that admittedly also yields strange
> behaviour at times. The reasoning for this to the be thing to implement
> is, that's the corner cases are easier to implement, idempotency is
> possible and it's easier to work with than rounding to the nearest
> possible value.)
>
> While I'd like to see the sifive driver to implement this optimal
> behaviour, it's not mandatory that you convert the driver to that
> behaviour. Just make sure to not make it worse.
>
> So to answer your question: If you understood what I wrote above and are
> motivated to improve the driver, it would be great to do that before the
> next review round.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
