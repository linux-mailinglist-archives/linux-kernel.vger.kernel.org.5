Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8779D017
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjILLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjILLfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:35:19 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749519AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:34:58 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49334907238so2071764e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694518497; x=1695123297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YIaHca9L6DlBxoBywNU/CHGT1sBfum6G53FjGrK7WY=;
        b=nR3NiDNM623aUxgs/u7c5gwh8mJUibPo2zrY6YC7OK14uqzQ5Dm2YLro/lDvsNOwx6
         isQf76Mz112uSZsTQ3e8NtowD9iow069LUfJdlRsTlq4+Dpxrr6yBei7TKK2DhwQzktR
         xr5MmJqPKk75c/YMaPoVjt0D2PRU1Ktz7EWA5o8RfcZYmCeX4d49S2hx7wTKVSFbSSXu
         3FfVfdWKwjTg/AknSxh2qeySZebLwfKYVT+aDlKx6hh5N2Mkdag1olruthGRms+pDRh9
         273tfFFTVKUHspBvc6lshiO4mz8I27HrFpoXV204Wzl7kOsJBQh4rGQgqi8RKJIKZybz
         RI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518497; x=1695123297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YIaHca9L6DlBxoBywNU/CHGT1sBfum6G53FjGrK7WY=;
        b=jEICOgs1Cw5aygP/FnSGJgrE4Z3qNALlz64L1XnYwYEf2gDlNwzyqXvpkZJNP4yaDr
         rdUyYeS9Zd+1zXUxd/pnocN3o3U1Die8AZvqA92NECFT0OtxvrqyT5/Fg/k5uenHydOp
         +v+9CryCzJZ73C4JpxeOe8NjUMk9b76c2qWT3in+2AtB94rZvpunhxGU6xi+jsNXY5Gb
         kYyKu7CtlG0fiAvbjnE6zBEkXEP2s+73B0Lkt+sfyanYVF1KNqnI1oswJ99DUl5485cn
         dSJU7yYvHMgSjdfwvYZ7IOgGCO+KahG5VSBy2OTsM3oWXj9P1AQ3nQg8I8myR8EqcNdn
         L4Gw==
X-Gm-Message-State: AOJu0YzKX/rP2T8032qqTXoi0OicKfDW9RQBnalXkhTkoDbije1uDRvc
        UC2diD/hmmF1Y+yXkrWsl2c43ARG20iXOl/14wfpUg==
X-Google-Smtp-Source: AGHT+IE0g1BAly+Torn3Y8awx8eZTxAYMdFDBqzY5C/JVBOT47BAkRRWCD93T+gKPr7Zp7s7+7Zh73rYPsI2W9czxQ4=
X-Received: by 2002:a1f:c806:0:b0:48d:5be:2899 with SMTP id
 y6-20020a1fc806000000b0048d05be2899mr9191193vkf.2.1694518497246; Tue, 12 Sep
 2023 04:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230912100727.23197-1-brgl@bgdev.pl> <20230912100727.23197-8-brgl@bgdev.pl>
 <ZQBGlSnx3McF8m2r@smile.fi.intel.com>
In-Reply-To: <ZQBGlSnx3McF8m2r@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 13:34:46 +0200
Message-ID: <CAMRc=MdBEm71uVYwRYiLvi2ROTDH5O5exa9Nq5qQc=yQOiXpew@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 1:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 12:07:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Remove all remaining uses of find_chip_by_name() (and subsequently:
> > gpiochip_find()) from gpiolib.c and use the new
> > gpio_device_find_by_label() instead.
>
> ...
>
> >       for (hog =3D &hogs[0]; hog->chip_label; hog++) {
> > +             struct gpio_device *gdev __free(gpio_device_put) =3D NULL=
;
>
> In the loop?! How does it work when loop goes second iteration and so on?
>

This works fine, the variable goes out of scope (reference is put) on
every iteration.

Bart

> >               list_add_tail(&hog->list, &gpio_machine_hogs);
> >
> >               /*
> >                * The chip may have been registered earlier, so check if=
 it
> >                * exists and, if so, try to hog the line now.
> >                */
> > -             gc =3D find_chip_by_name(hog->chip_label);
> > -             if (gc)
> > -                     gpiochip_machine_hog(gc, hog);
> > +             gdev =3D gpio_device_find_by_label(hog->chip_label);
> > +             if (gdev)
> > +                     gpiochip_machine_hog(gpio_device_get_chip(gdev), =
hog);
>
> So, do we expect the chip_label be different between hogs? Ah, seems so
> as it covers _all_ hogs in the system.
>
> >       }
>
> Even if the __free() scope works fine, I think this algorithm should be
> revisited to make sure we have iterating only on hogs of the same chip.
> Hence, the hogs should be placed into tree structure with a label being
> the key in it.
>
> ...
>
> > +             struct gpio_device *gdev __free(gpio_device_put) =3D NULL=
;
>
> > +             gc =3D gpio_device_get_chip(gdev);
>
> Similar wish here, perhaps maple tree can be utilized in the future for b=
oth of them.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
