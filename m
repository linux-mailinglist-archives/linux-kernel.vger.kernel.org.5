Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59397786C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjHXJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjHXJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:12:40 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C18198A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:12:38 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-447c7607b72so2724775137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692868357; x=1693473157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ebOu0WuXZaeLQmKdnAN+LwLnsPoc+KaDqpzDQV69Uc=;
        b=qvX7i2c/ll7tyRFAHH6LH105pryUO0iUAi/xU3ySXOaynFwrPDF9m93WyNuEz/Nqfa
         46/p3c1LWibWz72bhqXRgX2aSeux1vx6cR/XOppzrtuR9a8NVO3ULQPjP3LFPDMHiR3B
         +UmGGgs5nw3ZkDTIe6JxjjLhvXJNXoCjJjyL1Fb7yOFUKvpvv3OEUZ6/Db3QD4xxReTj
         8n8PYHSxouRCh0pwuK1PF6TwZi3JgmJYmPhuaWBHUdoxOH8sucKmVhvfTpeOJPfDOVJm
         hF6/PY0iYVfViXvtK/1pUuT2Pbl8qgHl5qd7ywbk+IzgciDvuhnhNzP0Y0vLYeN1MUly
         M/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868357; x=1693473157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ebOu0WuXZaeLQmKdnAN+LwLnsPoc+KaDqpzDQV69Uc=;
        b=SYVZEGx1CaVT6ZTcC8SGvyqUqlW/EU7rnlG7ZqRFk63fPH0h6cJfMP7J2Paa/SC6RG
         GqFs/UHpjVg/gp0Ydp4ClwgPWoSog/iiMt56TDw0h06oZt4XU/n1Ol++v5aUw0xQTyoc
         GRuisRFEg7tX2jPXJ/7t/vpRpXffqmAvrGRYXbrLaUv5q1PQQbFTUoADxlwvuioxqa0w
         1xwHmasfzCp5uHaGVVib8VNjH3n9o9GP1rii9OfUcYphno6CA4KE7mSEMKN1NMEXc2ek
         PdBActGkN0EVd4GboR4X4Ok9uX8PjL5YxIrPBgCVmYbQy9QoT4H58wDbP9ZxqOtEl3nt
         sItw==
X-Gm-Message-State: AOJu0YwLfLJGmMt364Gd0nc4Kse+2C7pQfGGQTQOWF0D5sCpEvtZ3yYx
        2q8MTKWl3pLnB4ahF1/O8l5mJJEqSNmbqt6WUaczPQ==
X-Google-Smtp-Source: AGHT+IHqZWlJ5zxSVsTm3QsxzjX085LvObVj/FvI14JSOtkXCTsuOsjGVZOyszWLcqBPxAbqEbsUvnstGo9xQG4JVnI=
X-Received: by 2002:a67:d08b:0:b0:44d:5a92:ec45 with SMTP id
 s11-20020a67d08b000000b0044d5a92ec45mr7501931vsi.23.1692868357633; Thu, 24
 Aug 2023 02:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230821153339.26305-1-brgl@bgdev.pl> <ZOP/n30hYR/8zN60@sol>
 <CAMRc=Mep_AZPht6cQFQ-Pz8UJC-q1r4F29SJ=+_WgJX1cz5wtw@mail.gmail.com>
 <CAMRc=MdoZJbiNUbdO6VOzS7NJTJtbmD1uoywa7+iWjeoy+RecQ@mail.gmail.com>
 <ZOcIdHVgK1ffzFMb@sol> <CAMRc=MfMu5kq8pM-Wcqz7uST5+etkuvYnTchyrP6NsHZJ32XRw@mail.gmail.com>
 <CACRpkdbQy1XcS4ErHpzqx1qnh_ZH8y2te=exJ3zS8KQiG36Tgw@mail.gmail.com>
In-Reply-To: <CACRpkdbQy1XcS4ErHpzqx1qnh_ZH8y2te=exJ3zS8KQiG36Tgw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 11:12:26 +0200
Message-ID: <CAMRc=Mdp_405T4UVKx+XTt8t5U=faFNAUi1HA7eJkyJ_b1cOhg@mail.gmail.com>
Subject: Re: [libgpiod v1.6.x][PATCH] tests: mockup: unbind mockup devices
 before unloading the module
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:05=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Thu, Aug 24, 2023 at 9:40=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > Kent:
> > > If the plan is to change the kernel such that it will no longer unloa=
d
> > > modules with bound devices then the patch totally makes sense.
> >
> > Linus has not commented on that yet
>
> [Fear Of Missing Out intensifies]
>
> Is this some mail thread I should look at but didn't?
>

I was talking about this one:
https://lore.kernel.org/lkml/20230818190108.22031-1-brgl@bgdev.pl/T/

Bart

> Or do you refer to Torvalds?
>
> > and there's a thing I need to
> > check first (hopefully today) but I think it will make more sense.
> > This patch on the other hand is not incorrect even if the behavior
> > doesn't change. I will queue it.
>
> This patch is doing the right thing from a module management point
> of view for sure.
>
> Yours,
> Linus Walleij
