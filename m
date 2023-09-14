Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB27A0F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjINUvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjINUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:51:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94811BEF;
        Thu, 14 Sep 2023 13:51:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-530196c780dso1298631a12.1;
        Thu, 14 Sep 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694724673; x=1695329473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHE32EWDYAptcdQ86MDImV1ZwZxVabv6m9dyzNl/smc=;
        b=RIB5uzNLYgO+bx3HtInshreHxhrWYwQBrwqI0ZKV4jW9nyrcSZoCwjVsrv6kX1jVPl
         VScUTgmPhJmDnzYIuqdzFxNJ64FFiWztztDnuiXAtDykkuE/sgHNbCp19SGL+DCBsITY
         DWOidtZBnx878GGr6+ZLkoGg7EwQWW4iPk6esPeRZN7Ck8PT/5PYKcDsmR8dESDG0hXD
         3FzWiXI7GRobrxjFvw3SZrFhMsGoHoDr94aorBbzuKvRVN/6F7956Jt8WUpY+WNzzPpN
         KGPKkV2+FrbxbZsOUhZlxeMI2ei3qKy1Qp9v3ke2Onhlzfey1+KCEjIdMgA63W4JW6lD
         bkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724673; x=1695329473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHE32EWDYAptcdQ86MDImV1ZwZxVabv6m9dyzNl/smc=;
        b=JjCAbp93OZUwhYEtcLeiXZKuWmJLx3NRWp7oIEqycQgVMW01Fd1oCUCWXzWaEleHUx
         2TpqWML/MIwnUnh3qX8d4uV0lq20WUm/SdI2exCtC9t5+LryiVUWtv+o48BIjFdjRXNn
         5wHck4x+1aGNtrZB4k7eEWxWhDm3xYWYh0kl2WQiSQHN/pbhbxH1oBH6USFR1IgAk/yh
         /1PsuoL+uRxvbADOMlJw8AZubBLqZPEtoHcti3MvCI2vU5POYIJ/5gcR6578DXEo2oQ6
         tWaZT/wqZ1LDjS831+i+kIBtrZKhSuW+YoG9Hli6AoMSHA49BYzcc8BQAbGeOI1/OU38
         IK0g==
X-Gm-Message-State: AOJu0YysZ40erHIvUEWbtANDG/gp8bBtYS8BEih0EChHniJWV8+9u2zm
        /RFGN6cWmoHY2aA4bBIOnZUHfqAOWxQUB7NCUxo=
X-Google-Smtp-Source: AGHT+IFTX2l9fGDZgeRqEPkarXTYPwsF3a4ioooK4lBG8i/kLDoHzno7rSe2oAhCBNpDMMqZqahmoxSRjyoMfHVFbTY=
X-Received: by 2002:aa7:c655:0:b0:523:4933:b024 with SMTP id
 z21-20020aa7c655000000b005234933b024mr5604349edr.14.1694724672927; Thu, 14
 Sep 2023 13:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
 <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org> <CAMRc=Merdmv_gFm58y1iHWmYmT=t_OmXyQgOXCxqwr7wsmjjYQ@mail.gmail.com>
 <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com>
From:   Mitchell Levy <levymitchell0@gmail.com>
Date:   Thu, 14 Sep 2023 13:51:01 -0700
Message-ID: <CAMJwLczd7oZ3JPqKNW-qOiB0S2WRsqV7TVFWGD=yysK0nmZrSQ@mail.gmail.com>
Subject: Re: guard coding style (was: Re: [PATCH v1 05/10] gpio: pca953x:
 Simplify code with cleanup helpers)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
A brief disclaimer, I'm a fairly new kernel contributor, but since I
was cc'd directly, I figured I might as well drop into the
conversation.

On Thu, Sep 14, 2023 at 12:47=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Wed, Sep 13, 2023 at 5:27=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Wed, Sep 13, 2023 at 4:35=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Fri, 1 Sep 2023, Andy Shevchenko wrote:
> > > > Use macros defined in linux/cleanup.h to automate resource lifetime
> > > > control in gpio-pca953x.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Thanks for your patch, which is now commit 8e471b784a720f6f
> > > ("gpio: pca953x: Simplify code with cleanup helpers") in
> > > gpio/gpio/for-next.
> > >
> > > > --- a/drivers/gpio/gpio-pca953x.c
> > > > +++ b/drivers/gpio/gpio-pca953x.c
> > > > @@ -557,9 +554,8 @@ static int pca953x_gpio_get_value(struct gpio_c=
hip *gc, unsigned off)
> > > >       u32 reg_val;
> > > >       int ret;
> > > >
> > > > -     mutex_lock(&chip->i2c_lock);
> > > > -     ret =3D regmap_read(chip->regmap, inreg, &reg_val);
> > > > -     mutex_unlock(&chip->i2c_lock);
> > > > +     scoped_guard(mutex, &chip->i2c_lock)
> > > > +             ret =3D regmap_read(chip->regmap, inreg, &reg_val);
> > >
> > > I can't say I'm thrilled about the lack of curly braces.  I was also
> > > surprised to discover that checkpatch nor gcc W=3D1 complain about th=
e
> > > indentation change.
> > > I know we don't use curly braces in single-statement for_each_*() loo=
ps,
> > > but at least these have the familiar "for"-prefix.  And having the sc=
ope
> > > is very important here, so using braces, this would stand out more.
> > >
> > > Hence can we please get curly braces, like
> > >
> > >      scoped_guard(mutex, &chip->i2c_lock) {
> > >             ret =3D regmap_read(chip->regmap, inreg, &reg_val);
> > >      }
> > >
> > > ?
> > >
> > > Thanks! ;-)
> >
> > I strongly disagree. The scope here is very clear - just like it is in
> > a for loop, in a while loop or in an if block:
> >
> > if (foo)
> >     bar()
> >
> > if (foo) {
> >     bar();
> >     baz();
> > }
> >
> > Only compound statements need curly braces in the kernel and it has
> > been like this forever. I don't really see a need to make it an
> > exception.

The more I think on this issue, the more I go back and forth. If we
only had guard(...), the only way to approximate scoped guard would be
to either just do what the macro does (i.e., a dummy for loop that
only runs once) or use an anonymous scope, e.g.,
{
    guard(...);
    my_one_statement();
}
Since this is how I've previously used std::lock_guard in C++, this
pattern feels very familiar to me, and the scoped_guard feels almost
like syntax sugar for this. As such, I feel like including the braces
is most natural because, as Geert mentioned, it emphasizes the scope
that "should" (in my brain, at least) be there.

Thanks,
Mitchell

> > That being said - I don't think the coding style for guard has ever
> > been addressed yet, so maybe bring it up with Peter Zijlstra?
>
> That's a good idea!
>
> I see Peter always used curly braces (but he didn't have any
> single-statement blocks, except for one with an "if", and we do tend
> to use curly braces in "for"-statements containing a single "if", too),
> but he does put a space after the "scoped_guard", as is also
> shown in the template in include/linux/cleanup.h:
>
>     scoped_guard (name, args...) { }:
>
> Then, "guard" does not get a space (but it is funny syntax
> anyway, with the double set of parentheses ;-).  The template in
> include/linux/cleanup.h doesn't match actual usage as it lacks the
> second set of parentheses:
>
>     guard(name):
>
> Peter: care to comment?
> Or do you have a different bikeshed to paint today? ;-)
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
