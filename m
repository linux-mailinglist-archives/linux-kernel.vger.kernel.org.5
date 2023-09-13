Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371579ECC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIMP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIMP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:27:47 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C26E54
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:27:43 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-495e3d1edb4so708648e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694618862; x=1695223662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSmC0s21CEToS8tT8/hcVHG8zlJnCs3gFSAowj5TofQ=;
        b=O/YQl8YeczH8YccBwr2fU3w7x515nnv5UNEkKB8hk9zGCI3Bf158GNNwrptLS7DNOb
         mddGay6+YLPz2U1bvb0vUZwq+KJA2lDx4ueueNv/b+ip3dPZSa8pgRsun99tzGAzIKh1
         GcaMTC4IVynVkO79NWqxfBANR6PFgZFheYEQofQ0xeu9GY/n4IslpxoUkiYATjLsYhIT
         zJoqi/oyE0hka2WbKN/t5H81MRzjCNOWgvnO+gJ+ZdbnyBMpHMV+vB13YxThnqSjvst6
         Vyq5CROWiZ6QWdR0yPWc2LXgh0bFvQ/Kba8E0Vxicxws+x2jy8ysumibYoj8/WkmjtAa
         15pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618862; x=1695223662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSmC0s21CEToS8tT8/hcVHG8zlJnCs3gFSAowj5TofQ=;
        b=QSI5+AbR0PFl+533G5SVueZ/4AzlP4ROMThXIu8Mxx9vVfc6F8dNP0DXXYFtNhf0C5
         GZlTvKgsiwWCSobCPjdX7FmmxT3JFleN01jCoRBp+DNPyHbZXfSthLgFZZZ2osbbU5Oc
         VzxzPhBao0zBBCp4ikd4loDx9Pr2GY7NeSFG5zFup9gFBe8V7q3PMCJ5dIfCJ6f5mNvi
         z722u1rOGgwQNYyzEBE2qteNfO1gzyNvqHhUfD55qA5NVhOtFIMW4+T1MnwPv5IdJLl3
         mg4qY3bqJN07uHtXfdXEnD3RhLWkQUs/MEPDv05p7HS/U6FmSIIorC1YKruWSOos1GIm
         Aa7Q==
X-Gm-Message-State: AOJu0Ywq73XLwhtuIEE1x3G+O47lEQagwdWa716HZCtTQ2Q/Fm6gli8O
        i/J0oL5VZKnEtTafys3XPNXkRX+1JPnjV9Gw8Yj4ng==
X-Google-Smtp-Source: AGHT+IGJvSLa8C0RY/pr1gb/IZEvzflaY24bVdWemEE/cCm0VktS9dQ2lxieIG0IxGCKKXQOFQUu8JrCk0IMybi8d6g=
X-Received: by 2002:a1f:c743:0:b0:490:1723:a491 with SMTP id
 x64-20020a1fc743000000b004901723a491mr1488004vkf.5.1694618862617; Wed, 13 Sep
 2023 08:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com> <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
In-Reply-To: <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Sep 2023 17:27:31 +0200
Message-ID: <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] gpio: pca953x: Simplify code with cleanup helpers
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 4:35=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
>         Hi Andy,
>
> On Fri, 1 Sep 2023, Andy Shevchenko wrote:
> > Use macros defined in linux/cleanup.h to automate resource lifetime
> > control in gpio-pca953x.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Thanks for your patch, which is now commit 8e471b784a720f6f
> ("gpio: pca953x: Simplify code with cleanup helpers") in
> gpio/gpio/for-next.
>
> > --- a/drivers/gpio/gpio-pca953x.c
> > +++ b/drivers/gpio/gpio-pca953x.c
> > @@ -557,9 +554,8 @@ static int pca953x_gpio_get_value(struct gpio_chip =
*gc, unsigned off)
> >       u32 reg_val;
> >       int ret;
> >
> > -     mutex_lock(&chip->i2c_lock);
> > -     ret =3D regmap_read(chip->regmap, inreg, &reg_val);
> > -     mutex_unlock(&chip->i2c_lock);
> > +     scoped_guard(mutex, &chip->i2c_lock)
> > +             ret =3D regmap_read(chip->regmap, inreg, &reg_val);
>
> I can't say I'm thrilled about the lack of curly braces.  I was also
> surprised to discover that checkpatch nor gcc W=3D1 complain about the
> indentation change.
> I know we don't use curly braces in single-statement for_each_*() loops,
> but at least these have the familiar "for"-prefix.  And having the scope
> is very important here, so using braces, this would stand out more.
>
> Hence can we please get curly braces, like
>
>      scoped_guard(mutex, &chip->i2c_lock) {
>             ret =3D regmap_read(chip->regmap, inreg, &reg_val);
>      }
>
> ?
>
> Thanks! ;-)

I strongly disagree. The scope here is very clear - just like it is in
a for loop, in a while loop or in an if block:

if (foo)
    bar()

if (foo) {
    bar();
    baz();
}

Only compound statements need curly braces in the kernel and it has
been like this forever. I don't really see a need to make it an
exception.

That being said - I don't think the coding style for guard has ever
been addressed yet, so maybe bring it up with Peter Zijlstra?

Bart

>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
