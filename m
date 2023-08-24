Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC50786860
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjHXHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjHXHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:32:21 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC310E0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:32:18 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44d38d91885so1968353137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692862338; x=1693467138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1Bn0cxBjqE0pyyXB8ARHyqe7vQgtksdTcou31X/fVg=;
        b=A2UQn1XvE+b0VLoufkJ4SOpM90cBclcRkdWclgMfG6V4fQmKUd3KyrefrFzDOUNuyj
         3eAxnCY62ocFUNQDAVIpzpVZkpLNjn2ZMz95tgqIArhAUa03aWNt5hxH0IFN0WjI7TLz
         pBYnWoKDgryUOKo//SWo2ER80mlj9+d2+qRKuijbeAaP+tBALesUJCrbi2Uu9zS1Wou0
         ZkHwDzrzwTWz4+Ru9W/KoNaNRuHkrzehC+177OBuo5m9EVCY9s+9WbOtoSJxsFWtGQaz
         weaZZIZJFSRO3fTR9Kqddz3exdN3/XFeYdgqcPhG9A9nbbMk/2fA9E6cT00tshKo2kEI
         YTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692862338; x=1693467138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1Bn0cxBjqE0pyyXB8ARHyqe7vQgtksdTcou31X/fVg=;
        b=My1ZsY1vCUw4U+VFSf4zWAwSf6BaMdjkbmMrIaZFkdwB03yVpZPtdCsBQ74aqiYq6k
         v6LJuy9IqE84xF82CfC0nX0HDYc0aWRPMD9MvXM7bhvan/er0/pjB1g17LjfzsYnm3Ld
         dzdBAXCXNI025EUR9WOrY/NbzMjGy9hmKjToi1REbwQ0TvgDmpSCowECbUvB+J0njcYT
         xUkU7B0vRw1eilqbEFRX8ZOQ6uVhap1R4UaUPw4B5wnGGhiT+xnUj+Mc4+NOWFn3DI2g
         wy7epI7TtF0J0Jf0vCQrC/nhXwVqKmrM68OEqUSVXOcqOs2WdYnZOsZhGbHJaHmXoiDN
         Bmkw==
X-Gm-Message-State: AOJu0YzJOa7219SzJTW8edjQypdSwCWx9REHqJKm/Y0dq95FELuuLO2p
        JHvv32MaurGc0vBJ/DLffKkcvoZEGxfTwyygt8o6lw==
X-Google-Smtp-Source: AGHT+IE53E71htBVBrG7OV8KFBWPW7KoS2vOtaEWJyNGG42BNh/5Ao8R0hUiCjlfTKuRKw49gWDAHzyHOZXzrvPSbS0=
X-Received: by 2002:a05:6102:3564:b0:44d:5e09:e392 with SMTP id
 bh4-20020a056102356400b0044d5e09e392mr7699062vsb.6.1692862337826; Thu, 24 Aug
 2023 00:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230821153339.26305-1-brgl@bgdev.pl> <ZOP/n30hYR/8zN60@sol> <CAMRc=Mep_AZPht6cQFQ-Pz8UJC-q1r4F29SJ=+_WgJX1cz5wtw@mail.gmail.com>
In-Reply-To: <CAMRc=Mep_AZPht6cQFQ-Pz8UJC-q1r4F29SJ=+_WgJX1cz5wtw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 09:32:06 +0200
Message-ID: <CAMRc=MdoZJbiNUbdO6VOzS7NJTJtbmD1uoywa7+iWjeoy+RecQ@mail.gmail.com>
Subject: Re: [libgpiod v1.6.x][PATCH] tests: mockup: unbind mockup devices
 before unloading the module
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Aug 22, 2023 at 9:08=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Aug 22, 2023 at 2:21=E2=80=AFAM Kent Gibson <warthog618@gmail.com=
> wrote:
> >
> > On Mon, Aug 21, 2023 at 05:33:39PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > gpio-mockup relies on the GPIO devices being registered in module's _=
_init
> > > function and them being unregistered in __exit. This works with the G=
PIO
> > > subsystem as it only takes a reference to the underlying owner module=
 when
> > > a GPIO descriptor is requested and not when the GPIO device is
> > > instantiated.
> > >
> > > This behavior may change in the future in the kernel so make the beha=
vior
> > > of libgpiomockup more correct and have it unbind all mockup devices o=
ver
> > > sysfs before unloading the module.
> > >
> >
> > Never knew that unbinding was even an option.
> > Maybe update gpio-mockup's documentation?
> >
>
> Yeah, I might once we agree on that reference counting patch.
>
> > Just clarifying what the potential impact of the existing libgpiomockup
> > behaviour and future kernel behaviour is - the kernel may log errors bu=
t
> > otherwise correctly handle userspace unloading behaving badly?
> > So this patch is pre-emptory noise reduction?
> >
>
> No, it's a bug-fix-in-advance. gpio-mockup will fail to unload (until
> we unbind all devices anyway) if we couple the module's reference with
> struct gpio_device. So will every driver that registers devices from
> its module_init() function and tears them down in module_exit(). But
> these drivers are wrong to do so in the first place and unloading them
> sound like a rare thing to do anyway, so I'm willing to give it a try.
>
> Bartosz

So what do you think Kent? Does it make sense to have it in v1.6? I
would need to make a new bugfix release but I have something else
queued anyway.

Bart
