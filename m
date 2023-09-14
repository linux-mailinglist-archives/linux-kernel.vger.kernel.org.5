Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885047A0009
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjINJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjINJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:30:18 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C039CF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:30:14 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a512434bc9so1217265241.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694683813; x=1695288613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2ppFbBJ6eSrXngOvBl4Cb6zXMC/U2RNI6NUtLKD4qk=;
        b=A5qFBXPuNfXapaDc1ES++K3Rar679LuNluYnHoBx4L14PSGbpK9ddRuMsWEoL7+Vee
         lP3zM0IkQoM8uljFn+F4dbxumEu0ueiQgIq9/W4yvjXJM33GBy2/1L1yjrM4Ln5c1IZH
         AvjAeo+h+ZuaKdmy0Aklm3m5XRVm0RyOmpTqwzRjoOOvstR1lQrb7r0vCkO3gmp/t5ie
         l4wOVi6LbbOIoZGzd8Tv1Kim6pHPelF41P8+6SMPS5JV7ghq4kdx3Tftj/XGv/Jdwapd
         IViDH4k83ORDqoNusi2GSdur//QOznyHDy7gZZR53WsNi0YeTMyYeWlNVgAO0l06PIfc
         0pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694683813; x=1695288613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2ppFbBJ6eSrXngOvBl4Cb6zXMC/U2RNI6NUtLKD4qk=;
        b=OZ5vl2Wnk7wZ7bjWqsqflJFxQrfLESWdBvEaND9BJD04HHSOXuYt/E4VzFS4o0y0Bc
         hKJ9aFGmxxz5xkVTpbxaKABb8r3YqC/8pv62ksHzQ4bqb8meClQGGoQgf11GIbYbVD1b
         5oPhRgrcxnRvjUlui8dqKjA2qLykljAXE8Ul/Q1NzeCSn2Wv7xlTklCSPz5MQaRAYeKN
         l+KFsoESx3ek/JwijjVzazj+3BklhEq0k0O7k53xTzb6Y/iFyhdqAana5mARNzYGEfUW
         +44tClqTmd+E0Ag1YKQe3eetIR8dFwVYYmkf9gnxIAi5UxKaUtlJbY3Cmtq/GhNyLfzN
         wd7g==
X-Gm-Message-State: AOJu0YxfpNBOTZOiXQSgRBrqfBLHcvXTtgdOsPj7plkn5HiH34xDn2Qf
        oOdVxKkIceKvNheGSk3wJfLpXnwyJ5nqzYY2yTT0IA==
X-Google-Smtp-Source: AGHT+IFdpKc86Ba4+Ce1Kw+37JilCE4JPGPOzMp6WOHfoT2BLvKGNI+DWUjLDVVh+a1NN/cT820cMVMpi35QbT24b9U=
X-Received: by 2002:a05:6102:3169:b0:450:6ef1:e415 with SMTP id
 l9-20020a056102316900b004506ef1e415mr582724vsm.13.1694683813313; Thu, 14 Sep
 2023 02:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-3-brgl@bgdev.pl>
 <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
 <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
 <20230913222338.07d1625b@xps-13> <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
 <4de724a1630eda74f4f304dc224dc981eb3b0875.camel@crapouillou.net>
In-Reply-To: <4de724a1630eda74f4f304dc224dc981eb3b0875.camel@crapouillou.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Sep 2023 11:30:02 +0200
Message-ID: <CAMRc=MfnPdr66OPSkkjjpZY2VY7wN4WO2uBPbpyExFH0F6e=1Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
To:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:30=E2=80=AFAM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
>
> Hi,
>
> Le jeudi 14 septembre 2023 =C3=A0 10:02 +0300, Andy Shevchenko a =C3=A9cr=
it :
> > On Wed, Sep 13, 2023 at 11:23=E2=80=AFPM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > > linus.walleij@linaro.org wrote on Wed, 13 Sep 2023 22:12:40 +0200:
> > > > On Wed, Sep 13, 2023 at 10:05=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski
> > > > > <brgl@bgdev.pl> wrote:
> >
> > ...
> >
> > > > > Why not moving this quirk to gpiolib-of.c?
> > > >
> > > > That's a better idea here I think, it's clearly a quirk for a
> > > > buggy device tree.
> > >
> > > Agreed, it's just for backward compatibility purposes in a single
> > > driver. I believe it should stay here.
> >
> > I believe Linus was for moving.
>
> Which Linus? Because the one who's also the gpio maintainer just wrote
> above that it was better to keep it in the driver.
>

I'm also under the impression that Linus meant moving it to gpiolib-of.c. L=
et's

Linus: Could you clarify?

Bart

> Cheers,
> -Paul
>
> >
> > gpiolib-of.c contains a lot of quirks, including this one. Calling
> > these new (or old) APIs for overriding polarity in many cases
> > shouldn't be needed if were no issues with DT or something like that.
> >
>
