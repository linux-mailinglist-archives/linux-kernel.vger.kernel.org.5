Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033479FD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjINHr0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjINHrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:47:24 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C791BF6;
        Thu, 14 Sep 2023 00:47:20 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7ba4c5f581so686012276.0;
        Thu, 14 Sep 2023 00:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694677639; x=1695282439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH2NAACEuqLTwvTPSksNHJiP3v0GBMYJgjJTtcx+5Sw=;
        b=PRwPqxvoLae1QR4SqZCoBuGowcsLr65i549L6ojjMgZZpwb8HKiexWnD50Y8fp432c
         lHomy8t+9d6c6xnOKS5Rs41KaVUCm2ZJY73v0niUC5NeQFrUvrNJp76Vy9Zg6C/Fm3xk
         KmqbcH/spPkFAvdsXvt/RSqpbhigbfm0ysvt3ubcnViDYnJiMGE6CLcysFZ8YUkWr7E2
         3sTzqFeS0rmvLE0rmx7VXXr31PD1JjFxHdarfTDkkV+hNhyWbVUO7aVCmMc14cFeFoWL
         ikWiaygL6mbRV/daXKDPI7IZuMwQqdS4Cz2yXAr58cqo8Y6lZbsfSBBG4bf+lprFhGXb
         qf8A==
X-Gm-Message-State: AOJu0Yx2RKDC8DpejIYgmwVJ5xj25UFyML6q8hJF4YqPDR5JvR3PFvZe
        xoQox82eMXwQFEt4T97C9V49rbNgWrRxQw==
X-Google-Smtp-Source: AGHT+IGGc71cjLXfVuEx4Q7iM0vMEDydwunljfwf+/VqDOqnkaHeIqU9R8qZrYTl7n5AULPpQlM1Kw==
X-Received: by 2002:a25:8683:0:b0:d7b:8d9a:4ec5 with SMTP id z3-20020a258683000000b00d7b8d9a4ec5mr4386915ybk.41.1694677639567;
        Thu, 14 Sep 2023 00:47:19 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id e9-20020a259249000000b00d43697c429esm216628ybo.50.2023.09.14.00.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:47:18 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59231a1ca9eso7546727b3.1;
        Thu, 14 Sep 2023 00:47:18 -0700 (PDT)
X-Received: by 2002:a05:6902:285:b0:d81:5ec1:80cf with SMTP id
 v5-20020a056902028500b00d815ec180cfmr3698465ybh.12.1694677638369; Thu, 14 Sep
 2023 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
 <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org> <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
In-Reply-To: <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 09:47:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
Message-ID: <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
Subject: guard coding style (was: Re: [PATCH v1 05/10] gpio: pca953x: Simplify
 code with cleanup helpers)
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mitchell Levy <levymitchell0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Wed, Sep 13, 2023 at 5:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Wed, Sep 13, 2023 at 4:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 1 Sep 2023, Andy Shevchenko wrote:
> > > Use macros defined in linux/cleanup.h to automate resource lifetime
> > > control in gpio-pca953x.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Thanks for your patch, which is now commit 8e471b784a720f6f
> > ("gpio: pca953x: Simplify code with cleanup helpers") in
> > gpio/gpio/for-next.
> >
> > > --- a/drivers/gpio/gpio-pca953x.c
> > > +++ b/drivers/gpio/gpio-pca953x.c
> > > @@ -557,9 +554,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
> > >       u32 reg_val;
> > >       int ret;
> > >
> > > -     mutex_lock(&chip->i2c_lock);
> > > -     ret = regmap_read(chip->regmap, inreg, &reg_val);
> > > -     mutex_unlock(&chip->i2c_lock);
> > > +     scoped_guard(mutex, &chip->i2c_lock)
> > > +             ret = regmap_read(chip->regmap, inreg, &reg_val);
> >
> > I can't say I'm thrilled about the lack of curly braces.  I was also
> > surprised to discover that checkpatch nor gcc W=1 complain about the
> > indentation change.
> > I know we don't use curly braces in single-statement for_each_*() loops,
> > but at least these have the familiar "for"-prefix.  And having the scope
> > is very important here, so using braces, this would stand out more.
> >
> > Hence can we please get curly braces, like
> >
> >      scoped_guard(mutex, &chip->i2c_lock) {
> >             ret = regmap_read(chip->regmap, inreg, &reg_val);
> >      }
> >
> > ?
> >
> > Thanks! ;-)
>
> I strongly disagree. The scope here is very clear - just like it is in
> a for loop, in a while loop or in an if block:
>
> if (foo)
>     bar()
>
> if (foo) {
>     bar();
>     baz();
> }
>
> Only compound statements need curly braces in the kernel and it has
> been like this forever. I don't really see a need to make it an
> exception.
>
> That being said - I don't think the coding style for guard has ever
> been addressed yet, so maybe bring it up with Peter Zijlstra?

That's a good idea!

I see Peter always used curly braces (but he didn't have any
single-statement blocks, except for one with an "if", and we do tend
to use curly braces in "for"-statements containing a single "if", too),
but he does put a space after the "scoped_guard", as is also
shown in the template in include/linux/cleanup.h:

    scoped_guard (name, args...) { }:

Then, "guard" does not get a space (but it is funny syntax
anyway, with the double set of parentheses ;-).  The template in
include/linux/cleanup.h doesn't match actual usage as it lacks the
second set of parentheses:

    guard(name):

Peter: care to comment?
Or do you have a different bikeshed to paint today? ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
