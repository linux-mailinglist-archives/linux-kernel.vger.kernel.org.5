Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4E7914FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIDJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351144AbjIDJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:48:11 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E81AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:48:05 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79d8edd6d99so385063241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693820885; x=1694425685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgWhsYP5jdoH1SRXWXyJyanPFkqLwbfNNY7M0pK5FD0=;
        b=eqJEqI9FK4Nf7kfcJGgKZXaWiIxMSM7AucV72D1cW8/OcqYJ3TRf42H0Klye7d8Oia
         +Ay3h1zlbY5L0S0m0WYyIkZhiE2Ix43ltHpLVWtEQFVH4Dmf2vjr9bNCB1VTTBdJohsI
         MK1p1mHPkWtlg09LN/cKDjRIWKsmhBnqjGVjPT9jFJgrszPvEjfc1tjSdUycB6BMmc9e
         sj32DlhXk2+XsHsTptaTrXz/qrqLbpZS6AZBjtSNJlixiiVCNvXXWMVU8QtkgMhCv3YB
         G+DGZCAdLu9dY/IDe+JIEaJLUxm6F+F5/EKTpJ8cxpIc7a4mZLeknBIJ1rdbbnfDEbis
         Eu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820885; x=1694425685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgWhsYP5jdoH1SRXWXyJyanPFkqLwbfNNY7M0pK5FD0=;
        b=GqkU8hQvr2WW3tgzlvcs4WvBlpOysjjZDLwS8igeYbpj5ZX1pkLooTK6mDhNi3bNAT
         4npi3lbnrRntdX/cLlQQAG51PATlAHdVgddA43Y878rwy/Q/XIit73yZYWni1tUOSlYU
         2HNQ2LXjtdWuBzzCwTCCbKRlCSmBENNQmHw9SsrLAgB2gTm7k/7oDZVkAPsSQystgL87
         hwHhlgoXlDI7Wq05m15NsjFnpqcu8fFgD5dP0+7pV204kgQfoFiqdBivIzaX4mseKp7u
         iKgpJxEJyo3YJkiLl1zq3BIiRBikRpZia34xWfFFVKkWaPS4CnKEFY6eXthpXLKCtXrV
         MyRg==
X-Gm-Message-State: AOJu0YxS5b+esN3lhpHisb2nBlWI0mxRHoE7F9QA/9JXbfaQcnGYwo5U
        WUeE2DM+gAYLBCnLieeMs1Y5vCYU2t0dyFtMHZjwRQ==
X-Google-Smtp-Source: AGHT+IEVW9yt/XK1jQ9+2lxO7PDtw85uCxOug68qbZmHCNYDdFNE/Z4ThK/QJtAaRL0KaQstPR4ZVRjTk7cDt3tSEtk=
X-Received: by 2002:a67:ec07:0:b0:44d:4a41:893b with SMTP id
 d7-20020a67ec07000000b0044d4a41893bmr8366237vso.8.1693820884901; Mon, 04 Sep
 2023 02:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230901183240.102701-1-brgl@bgdev.pl> <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com> <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
In-Reply-To: <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Sep 2023 11:47:54 +0200
Message-ID: <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Mon, Sep 4, 2023 at 11:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 4, 2023 at 10:59=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wrote:
> > > > On Fri, Sep 1, 2023 at 11:10=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wro=
te:
>
> ...
>
> > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > +     /* Used by sysfs callbacks. */
> > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > >
> > > > > dev pointer of firmware node is solely for dev links. Is it the c=
ase here?
> > > > > Seems to me you luckily abuse it.
> > > >
> > > > I don't think so. If anything we have a helper in the form of
> > > > get_dev_from_fwnode() but it takes reference to the device while we
> > > > don't need it - we know it'll be there because we created it.
> > > >
> > > > This information (struct device of the GPIO device) can also be
> > > > retrieved by iterating over the device children of the top platform
> > > > device and comparing their fwnodes against the one we got passed do=
wn
> > > > from probe() but it's just so many extra steps.
> > > >
> > > > Or we can have a getter in gpio/driver.h for that but I don't want =
to
> > > > expose another interface is we can simply use the fwnode.
> > >
> > > dev pointer in the fwnode strictly speaking is optional. No-one, exce=
pt
> > > its solely user, should rely on it (its presence and lifetime).
> >
> > Where is this documented? Because just by a quick glance into
> > drivers/base/core.c I can tell that if a device has an fwnode then
> > fwnode->dev gets assigned when the device is created and cleared when
> > it's removed (note: note even attached to driver, just
> > created/removed). Seems like pretty reliable behavior to me.
>
> Yes, and even that member in fwnode is a hack in my opinion. We should no=
t mix
> layers and the idea in the future to get rid of the fwnode_handle to be
> _embedded_ into struct device. It should be separate entity, and device
> instance may use it as a linked list. Currently we have a few problems be=
cause
> of the this design mistake.

I don't see how this would work if fwnodes can exist before struct
device is even created. They - after all - represent the actual
physical device hierarchy which may or may not be populated at
run-time depending on many factors.

Once populated, being able to retrieve the software representation of
the device (struct device) from the node from which it was populated
sounds like a reasonable thing to do. What are those problems and are
they even linked to this issue?

>
> The get_dev_from_fwnode() is used only in devlink and I want to keep it t=
hat way.
> Nobody else should use it, really.

I don't care all that much, I can get the device from the children of
the platform device. Still comparing fwnodes, though this time the
other way around.

Bartosz

>
> We can discuss with Saravana, but I don't believe he can convince me othe=
rwise.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
