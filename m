Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29677D30D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjHOTK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjHOTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:10:25 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4F1FF9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:10:07 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-447c7607b72so2083535137.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692126606; x=1692731406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiUxUt5zsNu7YvGS43EgY8hBy5YnTNcR0LzuDxUSonI=;
        b=OoRky4z7z2k+pVNnv2paMYSyzLbht0EaTRzRmeJw8QmznvnjGBu2J40Xb1atfsI43K
         9XKKAQQLh94m4fLJzf+SSAexlIHo1tIQuyma13YCYpAeGbZAwEWxT4a4xwUpX7bj9+co
         6VUkuA8wt6iij34h5iuip5bNLpAXaZTATUjuqReqM5bywKr+zFRwFN+fEX/niTGILOqn
         ajWWJcXSshRyKxijRLaZkTaX6Jatigyl++Y1RzdR/ZmFI6vRqH66duV1T0tc2Nsi4wvk
         AmH1JXpmZSLmGm2CMpbYdqqHUJdaZ67XjU7FUhmPjn4Mzh9EYiYnn4+S/KLnq6aH7qap
         J42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692126606; x=1692731406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiUxUt5zsNu7YvGS43EgY8hBy5YnTNcR0LzuDxUSonI=;
        b=PJH1kWPrCfY8LFR1/m7/GDoOiEcDN/q0EA+Z0eb7Ncmd/SW5VWjsT3QX/dD5VjKxnR
         1mKJJ0XmnZFIISCvjBHP85IeoceFvFOwXRNDGnvjYKYaYXwhqlWZKwG4UrYZZL/qrgDc
         kptGfU07rieXg4Ms6Jn/yMTUL05m1GUyIQH15wTZLELD3YOUTxQ2KS0BNc9807lhxCge
         veVyRAueELt3C7LtlaZ9+6iWduoay/wJBxuCWoi4YlLRHEG7crMLAv1clEPV8HxJetQx
         XLgdMUK0qPSinnr6LJsuyvKjkwaros4qIyUeBCRJh4N1ixcqPtUaHMpqjZtkt85QTgnM
         eUlA==
X-Gm-Message-State: AOJu0YxGQKhM+bbw0ciU+Ai1cgEW5OWr6S80Yfk+95Y3FvAsc++6cLwQ
        8Sl6+3EKWZMT+l7hxv3IPskM/gqwaMQDuWuEq9BkfA==
X-Google-Smtp-Source: AGHT+IHnW+Qapu3KsvoKRVkEgCydWxhc70EI3sroVoORi+Hj0jCfSux1fJ1DhvuZxaSyTXlFs9uXafPQIAIIKoNBWWE=
X-Received: by 2002:a67:db04:0:b0:449:6e0e:b2d5 with SMTP id
 z4-20020a67db04000000b004496e0eb2d5mr9613977vsj.8.1692126606625; Tue, 15 Aug
 2023 12:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230812183635.5478-1-brgl@bgdev.pl> <ZNtT37d3eR6FcQyR@smile.fi.intel.com>
In-Reply-To: <ZNtT37d3eR6FcQyR@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Aug 2023 21:09:55 +0200
Message-ID: <CAMRc=McqdnBBSe1QhyNEFCs3E+Qb_K-z1dT+B8+n2KvWajj5hA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sim: simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Aug 12, 2023 at 08:36:35PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in gpio-sim.
>
> ...
>
> >  static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, in=
t value)
> >  {
> >       struct gpio_sim_chip *chip =3D gpiochip_get_data(gc);
> >
> > -     mutex_lock(&chip->lock);
> > -     __assign_bit(offset, chip->value_map, value);
> > -     mutex_unlock(&chip->lock);
> > +     scoped_guard(mutex, &chip->lock)
> > +             __assign_bit(offset, chip->value_map, value);
>
> But this can also be guarded.
>
>         guard(mutex)(&chip->lock);
>
>         __assign_bit(offset, chip->value_map, value);
>

Come on, this is total bikeshedding! I could produce ten arguments in
favor of the scoped variant.

Linus acked even the previous version and Peter says it looks right. I
will queue it unless some *real* issues come up.

> >  }
>
> ...
>
> >  {
> >       struct gpio_sim_chip *chip =3D gpiochip_get_data(gc);
> >
> > -     mutex_lock(&chip->lock);
> > -     bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->=
ngpio);
> > -     mutex_unlock(&chip->lock);
> > +     scoped_guard(mutex, &chip->lock)
> > +             bitmap_replace(chip->value_map, chip->value_map, bits, ma=
sk,
> > +                            gc->ngpio);
>
> Ditto.
>
>         guard(mutex)(&chip->lock);
>
>         bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->=
ngpio);
>
> (exactly 80 for the sectants of 80 characters :).
>
> >  }
>
> ...
>
> >  {
> >       struct gpio_sim_chip *chip =3D gpiochip_get_data(gc);
> >
> > -     mutex_lock(&chip->lock);
> > -     __assign_bit(offset, chip->value_map, !!test_bit(offset, chip->pu=
ll_map));
> > -     mutex_unlock(&chip->lock);
> > +     scoped_guard(mutex, &chip->lock)
> > +             __assign_bit(offset, chip->value_map,
> > +                          !!test_bit(offset, chip->pull_map));
>
> Ditto.
>
>         guard(mutex)(&chip->lock);
>
>         __assign_bit(offset, chip->value_map, test_bit(offset, chip->pull=
_map));
>
> (in this form fanatics of 80 can sleep well :-)
>
> Note that !! is redundant as test_bit() family of functions were fixed to
> return boolean.

Ha! TIL... I'll change it in a separate patch.

Bart

>
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
