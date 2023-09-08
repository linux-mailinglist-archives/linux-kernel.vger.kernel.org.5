Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47EE7985FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbjIHKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjIHKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:41:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0A1BEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:41:13 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58fba83feb0so18614037b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694169673; x=1694774473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGzW1Gsz6nFeulWPUu5AH12nWhKzRRmn3Tj1YKt22hc=;
        b=kFN7NPKKLUPaw9sa8GJ9ta0yj+eIYLE/f7miHdy9iVFF6GvbwCjxrQyjhWZ/fMYEgE
         yU7exxON6pczDfKvaMzEStDjQ9xCittF5BP2tLBfbRPn0ZTKQC0eIRriRj2Pt4yWKVf3
         BHMpWYO+E2RLnD29oIF6AFHP/4llrKhBI+qvTrHLI/0Bzd25uhCqcm4nArDjYM1bBVDZ
         Y4hiFPu74RaSwXEpUuHij8BWoIRyG8Uj9bdDiZUJ17O2h5KtdhsEpqP6GjXQUzadgnqs
         YUqDozLHaWQgPrs4aiCBFYwH1km2PZ3Qrro2KLMpDOA6eSVNnhKrxGzXPJgBTarB+ZHl
         kLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694169673; x=1694774473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGzW1Gsz6nFeulWPUu5AH12nWhKzRRmn3Tj1YKt22hc=;
        b=Y9oy6UnwhcaZwjVj9O/yPFipYudOHoy8q1uK9SRdn34j+4x0xmENSTWDzDX+AhPPBv
         874NnBtXg1UTEB0a8S+dnXqRKSsq5MTFgjYzXFjQQwVSoeWstccK4FCkQlQsE8l1WCmb
         7OPEYu8k2Gcm4H+YH3p7lQoYOVCEA5uvvuS/lXnd4QmP+1Ktt4Sqki32lGBXsbCrdHGC
         F4DAi1FVNsSXd93gKJvslrg1UVU6bwwsTqGZU11qareVbDobUjsUxZ3Qk3dRFLf17bb4
         KlMYrQ7zE0XuKzTelhtt/3RKTFpaNU3O4+tTG3VcIefCQ7Ei9XwtePHIAHqU9uAvTbjK
         JdMw==
X-Gm-Message-State: AOJu0YwQgBH34BvDjmywIHY6je7baOtvm6WI63fw0FS662srVFaF/aVs
        XqHAh+Qz6E1Zr1sovRwXWE6qwn3V3WMfVJwTrc10/g==
X-Google-Smtp-Source: AGHT+IF6rwnNU+XqC+wcXUFyvM1oC64hNO07qjBFEtIkD2cenu0xbaTRBvPawtOx+Jz8TQCmLbUd8CK9kX8IPGIgmns=
X-Received: by 2002:a81:5f8b:0:b0:59b:a28:389d with SMTP id
 t133-20020a815f8b000000b0059b0a28389dmr2617270ywb.19.1694169672736; Fri, 08
 Sep 2023 03:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230130093229.27489-1-nylon.chen@sifive.com> <20230130093229.27489-3-nylon.chen@sifive.com>
 <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
In-Reply-To: <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Fri, 8 Sep 2023 18:41:00 +0800
Message-ID: <CAHh=Yk8R02NXK33aogQeJQB6x88B_gpbnjHj9wRrJEbDQf67Aw@mail.gmail.com>
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

Hi Uwe,

Sorry it's so long ago.

I have completed the implementation of the new version, but there is
one thing about this letter that I still don't quite understand.

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=B9=
=B41=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:17=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> > The `frac` variable represents the pulse inactive time, and the result =
of
> > this algorithm is the pulse active time. Therefore, we must reverse the
> > result.
> >
> > The reference is SiFive FU740-C000 Manual[0].
> >
> > [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8=
b16acba_fu740-c000-manual-v1p6.pdf
> >
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > ---
> >  drivers/pwm/pwm-sifive.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index 62b6acc6373d..a5eda165d071 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >       /* The hardware cannot generate a 100% duty cycle */
> >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
>
> The same problem exists in pwm_sifive_get_state(), doesn't it?
>
> As fixing this is an interruptive change anyhow, this is the opportunity
> to align the driver to the rules tested by PWM_DEBUG.
>
> The problems I see in the driver (only checked quickly, so I might be
> wrong):
>
>  - state->period !=3D ddata->approx_period isn't necessarily a problem. I=
f
>    state->period > ddata->real_period that's fine and the driver should
>    continue
>
I still don=E2=80=99t quite understand the description of this paragraph.

state->period !=3D ddate->approx_period seems to be used to compare the
results of the previous and next two times.

I'm unsure what to do if I replace the conditional expression with
something else.

In addition, I don't understand the meaning of this.
"if state->period > ddata->real_period that's fine, and the driver
should continue"

At present, my new version of the implementation has passed the test
of the pwm_apply_state_debug() function.

Would you suggest I send the new implementation version before
continuing the discussion?

Thank you again for everything you=E2=80=99ve done.

>  - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>    is wrong for two reasons:
>    it should round down and use the real period.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
