Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC7791589
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbjIDKNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbjIDKM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:12:59 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A919B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 03:12:56 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a01719d3c5so1338649241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693822375; x=1694427175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksCsuoIwPCAp5DUzYypALLhC3L9hllQJaYwOdLWw3DQ=;
        b=doyd7PIp7gC/ktdUYOSKV+WadE4npLiJU7GBBkEsG5xzLkr2ao2F6YbMURKPg3LKVj
         nYvauCFT4pWRkGKAg+KepreNlWug3HMkcDB02uNfzkjAx/R1qCGkKXdnPpJEXgI+gBNm
         bRt7yV56mDvY9txV5b8ZYyHtLy4zJ9l7koSzWk9M0Z3EwW2J919rL6EL0DlnmVGSDR+Y
         xKZJpDBp9VTeHmqmN1KghG06kbe1imvv4qzj6P+l8H0bFPsDdrtyA1vQtwf4AgCROorw
         jAaTRCxAAlL1m3SSGr3sA3WAqyu4CIhAtuG7fuz2RO8vLce3QKcoSRUrqMhoN7dvILSM
         ndQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693822375; x=1694427175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksCsuoIwPCAp5DUzYypALLhC3L9hllQJaYwOdLWw3DQ=;
        b=IE18EPnnp2B4RNAHgGe3tIExXp3TPMAQkq8QwGP4Ar7faO2zIaFx2vGPFa0HkTVkYh
         v3dRmxoyGkbm3k560lEtmbH/oI9sZLi1PzFj1NNRuKu2tOFxPlHg3HPyr4BxTAVwkXnS
         /palb7aSi1ISMGpRIsVrPm7m/60ruJfKTua7VUR+4MfauNPFKqflSXj3Tv5CnJ6XaRIm
         wr+rPteCZ8RqgMQTQqsQ7/tjgiQRlSLri1+GPo8IYDdLnanc6R5J1/r7fhdIVu5N4ohu
         hvOuAKn4QGeVM4xxlKbX/NHsE0jJ4SPumUwoaETClGDxurdyRWp0x/EYTwSKse/7I14u
         9RHg==
X-Gm-Message-State: AOJu0YzS+Zzb3ZDQMztZxLtrcxg3yq1y6MZ8eDhMcseOuCRClDHxI+tw
        lWPtfaS7AKzKOTEyLRNvcZhp1hpiF5S1/dQzDLuD4A==
X-Google-Smtp-Source: AGHT+IEQmqSU1Z2ETMpuVCd8CbuDQ6TQk4Y89zgYkqzhGxK3XW7uof7R0vXQ1t259BZKHPfWiTF2FSSonc9UoxAG3yA=
X-Received: by 2002:a05:6102:442a:b0:44d:3b54:c81b with SMTP id
 df42-20020a056102442a00b0044d3b54c81bmr8231330vsb.12.1693822375210; Mon, 04
 Sep 2023 03:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230901183240.102701-1-brgl@bgdev.pl> <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com> <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com> <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com>
In-Reply-To: <ZPWr3dRP5C1GSY9F@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Sep 2023 12:12:44 +0200
Message-ID: <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
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

On Mon, Sep 4, 2023 at 12:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 4, 2023 at 11:40=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Sep 4, 2023 at 10:59=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Fri, Sep 1, 2023 at 11:10=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski=
 wrote:
>
> ...
>
> > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > >
> > > > > > > dev pointer of firmware node is solely for dev links. Is it t=
he case here?
> > > > > > > Seems to me you luckily abuse it.
> > > > > >
> > > > > > I don't think so. If anything we have a helper in the form of
> > > > > > get_dev_from_fwnode() but it takes reference to the device whil=
e we
> > > > > > don't need it - we know it'll be there because we created it.
> > > > > >
> > > > > > This information (struct device of the GPIO device) can also be
> > > > > > retrieved by iterating over the device children of the top plat=
form
> > > > > > device and comparing their fwnodes against the one we got passe=
d down
> > > > > > from probe() but it's just so many extra steps.
> > > > > >
> > > > > > Or we can have a getter in gpio/driver.h for that but I don't w=
ant to
> > > > > > expose another interface is we can simply use the fwnode.
> > > > >
> > > > > dev pointer in the fwnode strictly speaking is optional. No-one, =
except
> > > > > its solely user, should rely on it (its presence and lifetime).
> > > >
> > > > Where is this documented? Because just by a quick glance into
> > > > drivers/base/core.c I can tell that if a device has an fwnode then
> > > > fwnode->dev gets assigned when the device is created and cleared wh=
en
> > > > it's removed (note: note even attached to driver, just
> > > > created/removed). Seems like pretty reliable behavior to me.
> > >
> > > Yes, and even that member in fwnode is a hack in my opinion. We shoul=
d not mix
> > > layers and the idea in the future to get rid of the fwnode_handle to =
be
> > > _embedded_ into struct device. It should be separate entity, and devi=
ce
> > > instance may use it as a linked list. Currently we have a few problem=
s because
> > > of the this design mistake.
> >
> > I don't see how this would work if fwnodes can exist before struct
> > device is even created.
>
> That's whole idea behind swnodes. They (ideally) should be created _befor=
e_
> any other object they are being used with. This is how it works today.
>

Yes, this is what I meant: if fwnodes can be created before struct
device (as it is now) and their life-time is separated then how could
you possibly make the fwnode part of struct device?

> And doing swnode->dev =3D ... contradicts a lot: layering, lifetime objec=
ts, etc.
>

No it doesn't. We have the software node - the template for the
device. It can only be populated with a single device entry. Once it's
done, I don't see why you wouldn't want to assign this device to its
corresponding software node. Provided locking is in place etc.

> > They - after all - represent the actual
> > physical device hierarchy which may or may not be populated at
> > run-time depending on many factors.
>
> No. This is a mistaken assumption.
>

How so?

> > Once populated, being able to retrieve the software representation of
> > the device (struct device) from the node from which it was populated
> > sounds like a reasonable thing to do. What are those problems and are
> > they even linked to this issue?
> >
> > > The get_dev_from_fwnode() is used only in devlink and I want to keep =
it that way.
> > > Nobody else should use it, really.
> >
> > I don't care all that much, I can get the device from the children of
> > the platform device. Still comparing fwnodes, though this time the
> > other way around.
>
> Fine, but do not use dev pointer from fwnode, esp. software node.
>

I will do it but I'd like to clarify the above at some point.

Bart

> > > We can discuss with Saravana, but I don't believe he can convince me =
otherwise.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
