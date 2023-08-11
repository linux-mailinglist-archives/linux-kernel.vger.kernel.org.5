Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8277920C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHKOl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjHKOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:41:21 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29E273E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:41:18 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79aa01cc971so668266241.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691764877; x=1692369677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6U7eDiY81AXagbKXjhk/2GWeqBZwyqOSn+11Vfodus=;
        b=GNRlf/U8s89yB08jsjXe5rJP6JeIbq5lm13Gxpq7Lzy5yWWMDHpY95Y2O554iWlKXJ
         NBxCCYKH1bx+qJOZ7jkSYpUGmd8vkg0PKzQ9qOX6LW+FgyE/ESbbWY7Kd/SF4r/Eu8bw
         XdKTXglo3Hpm0yvoZzLdaf3WPgrlB9JhcdjPfFz0h2+izW2AKgKCVWtypI1TyUEuhQSm
         pCn8DC4Nu5TNaSpBocDT9MxadFRJDml8Ri6ftVj4v84nEVDVxspMifH9RS61ZFECg5+2
         KFijjHwcQP+jNNnh7NovZY1AdB4ufeqqGzQbGhs8C8X4qJ40bq3zEugy/2+klqCOpVKn
         FqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691764877; x=1692369677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6U7eDiY81AXagbKXjhk/2GWeqBZwyqOSn+11Vfodus=;
        b=bXQpGYbn3q6OsYyLo/ZpjM0QcQPhpnLiJS0KDcKFkWl5a6wZBWPu6GunQ/j8olGi9K
         1RH+dhtyIhMd3uGAJBeWia+ZOW8zk9zrQq8bD2TdHDU/9VjH6vVpbqqsx58R+E2Kj3nH
         pkW5uGdwqd+VZsC4IaiW3TkqUgAv2nd5j8/RwPT2I8PqFArSuhB/EvlhqoUrTBXOU/sf
         jBTdmTVCeBJoMOeuT/dcZAKDPa2tqJjN90XwL9/3eSxjOTUPBL+p7LaaynM/D97DUuKH
         8CG+yGTxtN2gie0RxGncWRAWSV3r8BeUZIP2rGREDtRS+Z6MndXVFkU59bywFKh9MhjR
         w91g==
X-Gm-Message-State: AOJu0YyQdl/+VJ2ZCL4qiI2/io2JZr0kQb0720ZNjNkNV8WB5HdCV1ZF
        uIBU/k2Wxt+arCxY2Wjp/B/831IU2GkAp/9NL9fvSA==
X-Google-Smtp-Source: AGHT+IHc/x2G0HRhVHGmvk3nAYGLax6vxhgmzgLN/i1Z2VCjX+E30DlfCl2BzMuCn5qRgwZHMhTUAsLEePyUDrRzxt8=
X-Received: by 2002:a05:6102:2836:b0:443:6449:479e with SMTP id
 ba22-20020a056102283600b004436449479emr1800832vsb.8.1691764877631; Fri, 11
 Aug 2023 07:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230811131427.40466-1-brgl@bgdev.pl> <20230811131427.40466-2-brgl@bgdev.pl>
 <ZNZEq5wo655rttb/@smile.fi.intel.com>
In-Reply-To: <ZNZEq5wo655rttb/@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 16:41:06 +0200
Message-ID: <CAMRc=Mehcxgy-5FnpawZo+M2dpweP8kG2oXTcZ=nuqpRB3taDA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] gpio: sim: simplify code with cleanup helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 4:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 11, 2023 at 03:14:27PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in gpio-sim.
>
> ...
>
> >       struct gpio_sim_chip *chip =3D gpiochip_get_data(gc);
> >       int ret;
> >
> > -     mutex_lock(&chip->lock);
> > -     ret =3D !!test_bit(offset, chip->value_map);
> > -     mutex_unlock(&chip->lock);
> > +     scoped_guard(mutex, &chip->lock)
> > +             ret =3D !!test_bit(offset, chip->value_map);
> >
> >       return ret;
>
> Isn't the same approach applicable here?
>
> ...
>
> >  {
> >       struct gpio_sim_chip *chip =3D gpiochip_get_data(gc);
>
> With
>
>         unsigned long *map =3D ...->value_map;
>
> > -     mutex_lock(&chip->lock);
> > -     bitmap_replace(chip->value_map, chip->value_map, bits, mask, gc->=
ngpio);
> > -     mutex_unlock(&chip->lock);
> > +     scoped_guard(mutex, &chip->lock)
> > +             bitmap_replace(chip->value_map, chip->value_map, bits, ma=
sk,
> > +                            gc->ngpio);
>
> ...you can satisfy me as well :-)
>
>                 bitmap_replace(map, map, bits, mask, gc->ngpio);
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
> Ditto (I checked the line size).
>

Sorry but no. This is bikeshedding. I'm not going to add temp
variables to only use them once.

Bart

> >  }
>
> ...
>
> >       struct gpio_sim_device *dev =3D gpio_sim_bank_get_device(bank);
> >       struct gpio_sim_chip_name_ctx ctx =3D { bank->swnode, page };
> > -     int ret;
> >
> > -     mutex_lock(&dev->lock);
> > +     guard(mutex)(&dev->lock);
> > +
> >       if (gpio_sim_device_is_live_unlocked(dev))
> > -             ret =3D device_for_each_child(&dev->pdev->dev, &ctx,
> > -                                         gpio_sim_emit_chip_name);
> > -     else
> > -             ret =3D sprintf(page, "none\n");
> > -     mutex_unlock(&dev->lock);
> > +             return device_for_each_child(&dev->pdev->dev, &ctx,
> > +                                          gpio_sim_emit_chip_name);
> >
> > -     return ret;
> > +     return sprintf(page, "none\n");
>
> I looked at the original and at the change and maybe it could be done as
>
>         struct device *parent =3D &dev->pdev->dev; // Naming?
>         bool live;
>
>         live =3D gpio_sim_device_is_live_unlocked(dev);
>         if (!live)
>                 return sprintf(page, "none\n");
>
>         return device_for_each_child(parent, &ctx, gpio_sim_emit_chip_nam=
e);
>
> ...
>
> >       int ret;
> >
> > -     mutex_lock(&dev->lock);
> > -     ret =3D sprintf(page, "%s\n", hog->name ?: "");
> > -     mutex_unlock(&dev->lock);
> > +     scoped_guard(mutex, &dev->lock)
> > +             ret =3D sprintf(page, "%s\n", hog->name ?: "");
> >
> >       return ret;
>
> guard() ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
