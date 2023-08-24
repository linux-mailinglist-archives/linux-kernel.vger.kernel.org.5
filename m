Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAE786C00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbjHXJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjHXJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:32:22 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1DE67
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:32:19 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d165bd108so1417105e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692869539; x=1693474339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1nJSzgjZ7Hvug6lAMKQXqVUZrQzEy/l96DGgOXlfO8=;
        b=CKzVfACJQo1d9tqDKJByGBJEB5Mf/1wUPACkatvtu1RhnpcC3QmqJvYL3EKM3DgJ2f
         WHpdyT8x4bP5n+0YlSUumFj7o7yObmw/vNceTfaLIBIQy6xHSuEEURqqP0GLWW5WK5sE
         PnKcEHUClQCExCPxtUkQOxM9TqncHO15aL98ASTqSqZ01zr4dqAdZTiwQv4Q6HXpM+1n
         l7GBdqoFtzunLgX663GXiqsudg3X7zQfxu8CD4GUTr85AaR8CRH5rA+qQ0nBDKxbIKzB
         Dcozt6RVyn9P2Eh+74c3mCP7J4bUXxJ941oAO2Ft1J72sDu2n+68j4FyTCTBih64uj3s
         NkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692869539; x=1693474339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1nJSzgjZ7Hvug6lAMKQXqVUZrQzEy/l96DGgOXlfO8=;
        b=jiiVQVrsb24nuHneXqfuqUKWhEC5ibmJT9U3h7Ad4lEIRiGu5eVxXdxDBe5RdmyMgU
         VOectKJyBZi4Sl+jQ+wu4BMFvB5poZexwKDwLwOaTmx9UrHrW6erOHT91HQEPCu2PUmA
         RZxhFpQRbubhclypRPDGGlG+UwV/+e8jRCjSoYa8F94p/kgnlxCAdSt08IbOsXWmwPke
         ep9MJxvR8KNQ9Gg9MSBv5c1OwGGcdh8CtpqMzSIRX2fmHCiGP6ZcrcuWNQd6huflO3aR
         jxPOhsQi4J2XOmVPubMcg6jzGmWSmMJ+fb6ueM1vt9ogNA4dmGKVLWcbbDhkbzxWDtQK
         ORoA==
X-Gm-Message-State: AOJu0YxZ4o7yBfYWSE+/mjjqk1U+c8A9r86HVwMK6/YL12JDQ6U8q+PH
        cqlZ8LureAedOONB5RUgxtInBm5mBJ/XmMD9KJ3lSQ==
X-Google-Smtp-Source: AGHT+IEZR1afPLmLtnf4Wou3OYLMnOCWcvex44HH6uxOLkcP+wJPp5CSHamPGXsIsG5oVioubD6oCNLCkNOf27+fhYg=
X-Received: by 2002:a67:ff91:0:b0:44d:4aa1:9d44 with SMTP id
 v17-20020a67ff91000000b0044d4aa19d44mr7806199vsq.8.1692869538789; Thu, 24 Aug
 2023 02:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824085544.110417-1-brgl@bgdev.pl> <ZOceEeBuX+Nh7DJo@sol>
 <CAMRc=MdEqm2U9AfPiw5kerJpB1hXyvEQ1_m7EhgoFZ+G3UyDAA@mail.gmail.com> <ZOcia3Nt+SzypTGm@sol>
In-Reply-To: <ZOcia3Nt+SzypTGm@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 11:32:07 +0200
Message-ID: <CAMRc=MfsWAe-bY62s8iBu+iAy76Wn7pxRnx-3iaOT7ym-FUstQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: notify user-space about line state changes
 triggered by kernel
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:27=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Thu, Aug 24, 2023 at 11:11:18AM +0200, Bartosz Golaszewski wrote:
> > On Thu, Aug 24, 2023 at 11:08=E2=80=AFAM Kent Gibson <warthog618@gmail.=
com> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 10:55:44AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > We currently only emit CHANGED_CONFIG events when the user-space ch=
anges
> > > > GPIO config. We won't be notified if changes come from in-kernel. L=
et's
> > > > call the notifier chain whenever kernel users change direction or a=
ny of
> > > > the active-low, debounce or consumer name settings. We don't notify=
 the
> > > > user-space about the persistence as the uAPI has no notion of it.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > > v1 -> v2:
> > > > - use the gpiod_line_state_notify() helper
> > > > - reorder the code in gpiod_set_debounce() for better readability
> > > >
> > > >  drivers/gpio/gpiolib.c | 16 ++++++++++++++--
> > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > index 40a0022ea719..1cb7731550ca 100644
> > > > --- a/drivers/gpio/gpiolib.c
> > > > +++ b/drivers/gpio/gpiolib.c
> > > > @@ -2439,6 +2439,7 @@ int gpiod_direction_input(struct gpio_desc *d=
esc)
> > > >       }
> > > >       if (ret =3D=3D 0) {
> > > >               clear_bit(FLAG_IS_OUT, &desc->flags);
> > > > +             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > > >               ret =3D gpio_set_bias(desc);
> > > >       }
> > > >
> > >
> > > gpiod_direction_input() is called by cdev when a line is requested.
> > > So requesting a line now creates two events - REQUESTED and
> > > HANGED_CONFIG? Even worse - it calls gpiod_direction_input() first, s=
o we
> > > will get CHANGED_CONFIG then REQUESTED??
> > >
> > > And a config change from cdev can call this and then generate a
> > > CHANGED_CONFIG event itself, so again double events.
> > >
> > > Same for output and probably debounce too (that one is a bit more
> > > convoluted).
> >
> > Ah, should have tested it with user-space too...
> >
> > Back to the drawing board I guess. May be the reason why we're not
> > doing it in the first place yet.
> >
>
> I think we were only looking at it from the userspace PoV, so what
> constitutes a "change" is only well defined when driven from userspace.
> This might be difficult to generalise without redefining what
> "changed" means, or providing cdev with a separate gpiolib API so you
> can tell whether the change is actually part of a cdev request, or ...
>
> So, yeah - more thought required.
>
> Got a use case that requires this, or just a nice to have?
>

I'm extending the virtual consumer driver and wanted to test from
user-spaces things like changing direction and other settings. I
figured it would make more sense to notify about all changes no matter
the source.

Bart
