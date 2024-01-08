Return-Path: <linux-kernel+bounces-19185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D601C82697E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2791C21C00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E0C8CE;
	Mon,  8 Jan 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bOWZ+OQq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C109473
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed4b84667so791941276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704702472; x=1705307272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvJpgUA4AhlF5UzDkm4aNhAt25RJ3NPKJbdB1Fs6ecM=;
        b=bOWZ+OQqRn+9/rAkwO/3OG3E8L3xCsiLwM7QTnI+PuG/HmIqZa2bwWd6eOT3JtgryE
         wF/1bvKpU361+3xEvijraqQU6eloqwmMXQ3KafpoiCXo7hF+ffcnFyZgYNa/Qj5wNANS
         K32D/k7O/2PdoAAsnpme1ugsKT+KIemelVuezCDMm0SyHrEqyp90EiLRfWN6v4Jg/0ki
         dMgfYW201b/rNTMwmSr05fm9+fNVYBmjz1sAVgM2PearSn81vJ8DD84x6iFve28hKU2l
         PsXbsJUvdjvDO/Hx+HwmO/y4jtVi3vWetZRgkA86Jr6QxC8d/E+HVcOuta0OBkP44xA5
         NEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702472; x=1705307272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvJpgUA4AhlF5UzDkm4aNhAt25RJ3NPKJbdB1Fs6ecM=;
        b=wWxp+f9sAqKCSrKLoG+wHIqu5DdrRiZwp1QEjlxJSy4G9wKyigPoOnL6E162Uv40Om
         Pt5Qs5VzkpjcrOkGUcNNnby3dUUHz8jhN0ictGmbuO0Q5iileVhvQH5RRYSXqVCvr422
         vLSTMePSQKrT4VCD5j70nMii8Lgd0d6ySSroZ63qU1DhfA6VZNkbA5AjyqpKcDMNUgB6
         Dpe3iZPx2TCP7J2thIClpWA1jRq3Nf/diDofRiG6HaqnXjSziBMgl4ohMvA5FV95HeJ3
         NiaCZQcmTtZ7rjinfPVdt9UnQbde7PAUSeg1xmU+fk+z6fh7PaAmcgu79nwPm3KadkJ6
         faMQ==
X-Gm-Message-State: AOJu0YxRb1oralH/m0JrHf1FZ4+TziPwrwU4i1g5/ww3Xlx9xgWv4uzq
	vwIkmi+pGjDW8YpWrIWjL8wjUD2+CaEGBWD/uS2eLl+n307cKg==
X-Google-Smtp-Source: AGHT+IFFb/Niyem1I290kG8fWBodwAxnQ44aza9G+jPqE1Lo+m061UGkuugFtDe83W4bVPZF0f7YxoMVpvdXsCZV7iU=
X-Received: by 2002:a25:2689:0:b0:dbe:9ef5:9605 with SMTP id
 m131-20020a252689000000b00dbe9ef59605mr1156037ybm.4.1704702472335; Mon, 08
 Jan 2024 00:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024101902.6689-1-nylon.chen@sifive.com> <20231024101902.6689-3-nylon.chen@sifive.com>
 <20231211204950.fkaqsnpzb6kixqf2@pengutronix.de>
In-Reply-To: <20231211204950.fkaqsnpzb6kixqf2@pengutronix.de>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Mon, 8 Jan 2024 16:27:40 +0800
Message-ID: <CAHh=Yk-9-M2G_cfdxLig2d0g1DucEytXhfFO5dp5HcDn+egWBw@mail.gmail.com>
Subject: Re: [v5 2/2] pwm: sifive: change the PWM controlled LED algorithm
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	thierry.reding@gmail.com, emil.renner.berthing@canonical.com, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com, 
	nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2023=E5=B9=
=B412=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:50=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hello Nylon,

Hi Uwe, thanks for your feedback.
>
>
>
> On Tue, Oct 24, 2023 at 06:19:02PM +0800, Nylon Chen wrote:
> > The `frac` variable represents the pulse inactive time, and the result
> > of this algorithm is the pulse active time. Therefore, we must reverse =
the result.
> >
> > The reference is SiFive FU740-C000 Manual[0]
> >
> > Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed=
8b16acba_fu740-c000-manual-v1p6.pdf [0]
> >
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >  drivers/pwm/pwm-sifive.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index eabddb7c7820..353c2342fbf1 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifi=
ve_ddata *ddata,
> >
> >       /* As scale <=3D 15 the shift operation cannot overflow. */
> >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH =
+ scale);
> > -     ddata->real_period =3D div64_ul(num, rate);
> > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
>
> It's unclear to me, why you changed that.
Because there is a gap in idempotent tests.
e.g.
root@unmatched:~# echo 110 >
/sys/devices/platform/led-controller-1/leds/d12/brightness
[  706.987712] .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985)
-> (ena=3D1 pol=3D0 1739630/4032985)
root@unmatched:~# echo 120 >
/sys/devices/platform/led-controller-1/leds/d12/brightness
[  709.817554] .apply is not idempotent (ena=3D1 pol=3D0 1897846/4032985)
-> (ena=3D1 pol=3D0 1897784/4032985)

Round the result to the nearest whole number. This ensures that
real_period is always a reasonable integer that is not lower than the
actual value.

After modification, idempotent errors can be avoided.
>
>
> >       dev_dbg(ddata->chip.dev,
> >               "New real_period =3D %u ns\n", ddata->real_period);
> >  }
> > @@ -121,13 +121,14 @@ static int pwm_sifive_get_state(struct pwm_chip *=
chip, struct pwm_device *pwm,
> >               state->enabled =3D false;
> >
> >       state->period =3D ddata->real_period;
> > +
> > +     duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;
>
> I would have placed that directly after
>
>         duty =3D readl(...);
>
> which then also influences
>
>         state->enabled =3D duty > 0;
>
> (as it should?).
>
Yes, you are right. I will make relevant corrections.
...
        duty =3D readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+       duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;
-       state->enabled =3D duty <=3D 65535;
+       state->enabled =3D duty > 0;
...
        state->period =3D ddata->real_period;
-       duty =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - duty;

>
> >       state->duty_cycle =3D
> >               (u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
> > -     state->polarity =3D PWM_POLARITY_INVERSED;
> > +     state->polarity =3D PWM_POLARITY_NORMAL;
> >
> >       return 0;
> >  }
> > -
> >  static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> >                           const struct pwm_state *state)
> >  {
> > @@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       int ret =3D 0;
> >       u32 frac;
> >
> > -     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > +     if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >               return -EINVAL;
> >
> >       cur_state =3D pwm->state;
> > @@ -158,6 +159,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> >       frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
> >       /* The hardware cannot generate a 100% duty cycle */
> > +     frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
> >       frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
>
> frac can only be > (1U << PWM_SIFIVE_CMPWIDTH) - 1 if an overflow
> happend the line above. Is that what you want here?
I made a mistake, I pushed the wrong changes.

I want to invert it after taking the minimum value, which makes sense to me=
.
        frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
        /* The hardware cannot generate a 100% duty cycle */
        frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+       frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;

>
> >       mutex_lock(&ddata->lock);
>
> Best regards
> Uwe
Best regards
Nylon
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

