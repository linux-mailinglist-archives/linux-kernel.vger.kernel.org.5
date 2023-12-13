Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F0811DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442088AbjLMTEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjLMTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:50 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7610E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:55 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9df0a6560so4927933b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702494235; x=1703099035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6EvQbWBxIRTsH6Y2Z/isMaFnqNg9G4sCjqKAgEN8tY=;
        b=fhhcjdo9Tq9yixiokiX9xYW9EcVOlK5JBJC6XC7+xVd9JFVXMDyMk6TC/al6KSlYaM
         sbbi8bMwEaX7Foyb4NYeK7Mvyija56QeYwxwCmyuen+pHTkwGFd7A27wN98i7SUifbqU
         xwcp6RUndUEsWYojYQat8EnDxXkljlOsR96EBW7mi40TezYGpmiZSjg/DDgbdqz1g8J0
         3PrcxO0x/fESsQow/ZKgKy50/j6FAnOwVm45Cf2noJAg1KmPNeMcSf9L+gHfwQRVKEqT
         0U3JfPSOdxsU45oUUwNB5jWoVsB1ppwGsckb3lTxuFBlkmcSIeu4e62H9GMULqTu8EdM
         1fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494235; x=1703099035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6EvQbWBxIRTsH6Y2Z/isMaFnqNg9G4sCjqKAgEN8tY=;
        b=E/neDLp+ioRQVmd8/EAhmesp7iFcoOYUd3hpelptvWumHGDZkeefwLm87yEYUdqn39
         QybfxEz/oPqqdIweS1s60ObcBWwCW59AFVqagcUmXVL0pmqFKBkuWz5mAwkIAhm20dsH
         hT7Y7pKZd52Ecfvj/pNfT8S4060LytCJ0r3pBBfqRVCUNlE/4/oXBTih1frp9cQMJ7cq
         R2LlEEVuuUH++73bxXdXKM3yqfDCtYmtCj2deEt6Uw9o5JR7Emu6S4m3BIPgOb5kbbCu
         jC5hl64CRp82aqK0kZDDXL7h0yUM5UzJhh1IGID4Svi47AEsgjzX6tUzKwnVrXm0OWo7
         y2sg==
X-Gm-Message-State: AOJu0YxT+menPU4jEiEX5kzvW17c1bcylLU42K+h9VpzyEVnZBZ8gbyF
        c1731C4Nx36gy0mg/uCRsedeNN+/9C4hoZq59rFn3w==
X-Google-Smtp-Source: AGHT+IHIOwlCduZy1QCxXMjwEcfj8brVA/2lcFJQNN8ueldOWDI5HPR7VX1WPGOnIBHHf503IiSlUYRqk6H08T7QFdA=
X-Received: by 2002:a05:6870:5486:b0:203:e6e:c730 with SMTP id
 f6-20020a056870548600b002030e6ec730mr2666570oan.101.1702494235199; Wed, 13
 Dec 2023 11:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20231212054253.50094-1-warthog618@gmail.com> <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com> <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel> <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com> <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
In-Reply-To: <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Dec 2023 20:03:44 +0100
Message-ID: <CAMRc=MfaHKKKNkXW0L1FPjCH4VvG22Vn9q8z9tupZCtCEKZU2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:29=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Wed, Dec 13, 2023 at 05:15:38PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Dec 13, 2023 at 5:12=E2=80=AFPM Andy Shevchenko <andy@kernel.or=
g> wrote:
> > > On Wed, Dec 13, 2023 at 11:59:26PM +0800, Kent Gibson wrote:
> > > > On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Wed, Dec 13, 2023 at 3:27=E2=80=AFPM Kent Gibson <warthog618@g=
mail.com> wrote:
> > > > > > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote=
:
> > > > > > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:
>
> ...
>
> > > > > > > > +static struct supinfo supinfo;
> > > > > > >
> > > > > > > Why supinfo should be a struct to begin with? Seems to me as =
an unneeded
> > > > > > > complication.
> > > > >
> > > > > I think we should keep it as a struct but defined the following w=
ay:
> > > > >
> > > > > struct {
> > > > >     spinlock_t lock;
> > > > >     struct rb_root tree;
> > > > > } supinfo;
> > > >
> > > > That is what I meant be merging the struct definition with the vari=
able
> > > > definition.  Or is there some other way to completely do away with =
the
> > > > struct that I'm missing?
> > >
> > > Look at the top of gpiolib.c:
> > >
> > > static DEFINE_MUTEX(gpio_lookup_lock);
> > > static LIST_HEAD(gpio_lookup_list);
> > >
> > > In the similar way you can simply do
> > >
> > > static DEFINE_SPINLOCK(gpio_sup_lock);
> > > static struct rb_root gpio_sup_tree;
> >
> > The fact that this has been like this, doesn't mean it's the only
> > right way. IMO putting these into the same structure makes logical
> > sense.
>
> I disagree on the struct like this on the grounds:
> - it's global
> - it's one time use
> - it adds complications for no benefit
> - it makes code uglier and longer
>

It boils down to supinfo.lock vs supinfo_lock. I do prefer the former
but it's a weak opinion, I won't die on that hill.

Bart

> What we probably want to have is a singleton objects in C language or at =
least
> inside Linux kernel project. But I'm not sure it's feasible.
>
> > > > > > Yeah, that is a hangover from an earlier iteration where supinf=
o was
> > > > > > contained in other object rather than being a global.
> > > > > > Could merge the struct definition into the variable now.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
