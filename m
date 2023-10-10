Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D87C02DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJJRkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjJJRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:40:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611897
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:40:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c00df105f8so75825041fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696959614; x=1697564414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh67zzVngCjOBB0HFeX9Jhktm6NSJyRL2/VUfJuzB14=;
        b=1K1+zSk7IP8FvNaN2QfP6NvJaYOP+Vyqva8pasCI8h3FKJmqPb6uX3/YYBKQQa+ZtP
         rRqlHshmJct8odJF1LQXf9h8mVF4n1HPWFQY4orzJ3rkiSztPgU7Ziktp0ci+8malGCW
         2CEOEWw5RqQuQYvpQL+ebhyE3NYtl+FHvgHb4++Rpd4ujcMm17kBbnnqJJqpS1d17Xri
         fJAY70suoOP5iQwRwbOfsssjSh1rvZB9Ewe4twgzcCmKb30SrsTwlS7UGog74S7cie1m
         MHs1Hg3o4sPGdBXSSj0tJ7+bSRSEbY9VWeTUCyqigsasuVrWBts6vxWG66gLPfu6R9hg
         VLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959614; x=1697564414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh67zzVngCjOBB0HFeX9Jhktm6NSJyRL2/VUfJuzB14=;
        b=jUt8e2HlbciAXX8CWApYwurdgQt2mXfNdUbGiMZhmq4fvMZ/nUdBHP5VWwE6W6Dbwj
         tb6alD2O2DXGn//k83Tfej8SIpeJAaVqOq0wfiuSHmgfOaCsVXTeESaMRkOxR2feTL7A
         JZzUPPMWrLAfSy0tsDiK+U3ARfQaRIxmCKvAuSd5gvKzZV1T3QZIT7JIsX+gdOkcaUhp
         vSwhzvsVT1Khh46rKHwsO4Po0jP2gGNgYNZwQd2dtsukxyTSFpIKj6Y4v4Zxs6iMvTCt
         ypEBX9i55Q+kKwbMbgGTVEIubaU2ElDRQMzUAxKfE3frqzY1/R4mLZk//lOB7n6aMjkX
         bLjA==
X-Gm-Message-State: AOJu0YzBRIMWhox+5ToHLNLH2IyHZuHiYFfmEO/lEVfDM2FlBzyDbylb
        /ZaFQMN78K8HdI2rB6pmvZu4Rwde+/jUFv2bw1ZeKg==
X-Google-Smtp-Source: AGHT+IH2dIZaBzJpuTwJpmIDz8iPbuG6Si7zQ5/GO2AxnRvRLgTo8Q0DoI2Hr5h8+YihQJDY7PTmfVOLciKXa9h99CI=
X-Received: by 2002:a2e:b0d5:0:b0:2b9:e304:5f82 with SMTP id
 g21-20020a2eb0d5000000b002b9e3045f82mr16089497ljl.13.1696959614366; Tue, 10
 Oct 2023 10:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
 <20231005-ad2s1210-mainline-v4-17-ec00746840fc@baylibre.com> <20231010171738.5a23e66e@jic23-huawei>
In-Reply-To: <20231010171738.5a23e66e@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Tue, 10 Oct 2023 12:40:03 -0500
Message-ID: <CAMknhBFP1Or+06rAMNOAU1Dc3sx1QgO44-N5xpsE-54DVOHYSQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/17] staging: iio: resolver: ad2s1210: simplify code
 with guard(mutex)
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:17=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu,  5 Oct 2023 19:50:34 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > We can simplify the code and get rid of most of the gotos by using
> > guard(mutex) from cleanup.h.
> You could consider scoped_guard() for a few cases in here, but perhaps
> it's better to be consistent and always use the guard() version.

Yes, there it doesn't look like there are any cases where there is any
long-running operation that could be done after unlocking the mutex,
so I went with the simpler approach everywhere.

>
> There is a small timing question wrt to the gpio manipulation inline.
>
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v4 changes: New patch in v4.
> >
> >  drivers/staging/iio/resolver/ad2s1210.c | 157 ++++++++++--------------=
--------
> >  1 file changed, 50 insertions(+), 107 deletions(-)
> >
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/=
iio/resolver/ad2s1210.c
> > index c4e1bc22e8b0..c4e0ffa92dc2 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -47,6 +47,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -404,11 +405,13 @@ static int ad2s1210_single_conversion(struct iio_=
dev *indio_dev,
> >       s64 timestamp;
> >       int ret;
> >
> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
> > +
> >       gpiod_set_value(st->sample_gpio, 1);
> >       timestamp =3D iio_get_time_ns(indio_dev);
> >       /* delay (6 * tck + 20) nano seconds */
> >       udelay(1);
> > +     gpiod_set_value(st->sample_gpio, 0);
> >
> >       switch (chan->type) {
> >       case IIO_ANGL:
> > @@ -418,14 +421,13 @@ static int ad2s1210_single_conversion(struct iio_=
dev *indio_dev,
> >               ret =3D ad2s1210_set_mode(st, MOD_VEL);
> >               break;
> >       default:
> > -             ret =3D -EINVAL;
> > -             break;
> > +             return -EINVAL;
> >       }
> >       if (ret < 0)
> > -             goto error_ret;
> > +             return ret;
> >       ret =3D spi_read(st->sdev, &st->sample, 3);
> >       if (ret < 0)
> > -             goto error_ret;
> > +             return ret;
> >
> >       switch (chan->type) {
> >       case IIO_ANGL:
> > @@ -437,17 +439,11 @@ static int ad2s1210_single_conversion(struct iio_=
dev *indio_dev,
> >               ret =3D IIO_VAL_INT;
> >               break;
> >       default:
> > -             ret =3D -EINVAL;
> > -             break;
> > +             return -EINVAL;
> >       }
> >
> >       ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
> >
> > -error_ret:
> > -     gpiod_set_value(st->sample_gpio, 0);
> > -     /* delay (2 * tck + 20) nano seconds */
> > -     udelay(1);
>
> Dropping this delay isn't obviously safe (though it probably is given stu=
ff done before we exit).
> I assume there are no rules on holding the gpio down for the register rea=
d.

Correct. The SAMPLE gpio only needs to be held for a short time (~350
nanoseconds) to latch in the current values, then it doesn't matter
when it is released. (Figure 35 in datasheet)

>
> If nothing else I think the patch description needs to made an argument f=
or why it is fine.

The longest possible delay needed after releasing the SAMPLE line
before reasserting is ~350 nanoseconds. Is there a rule of thumb for
deciding when there are enough instructions that no processor could
execute them faster than this vs. when we should add an explicit
delay?

I think I will consider adding a patch in the next round to refactor
the SAMPLE toggle to a separate function so we can be sure it is
handled the same in all cases.

>
> > -     mutex_unlock(&st->lock);
> >       return ret;
> >  }
> >
