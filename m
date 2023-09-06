Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083F2793EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbjIFO1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjIFO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:27:31 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAF10F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:27:26 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a294a4ee4bso604150241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694010445; x=1694615245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW/0ftx44nuZvnIVfoBb4IXQmDJJsfiAnE8tMNiYS4g=;
        b=O9xhEB3Plkxv5dvcADeOe1tj7cOcbLoR2NDbG5kcwLAOeK3P4tA4+sJm6a03eNZ0d/
         vRjfL7g6VlDq4GsMpFGGnreKG9aqsTwcEWVN+49kZZzj12SusOUAPjHHdrtWZWqb/5n9
         MfhqV1ShoTknqadFy6QQNyaD5SebwwdzChO9l5cxdylXiYyr/qI+qGl08fJeg6zGOlO9
         aEZdGyaBc5jD47p+ioo+jhnohFgVZVjuIhm978HlZUQ5B5FP45R70X5BOUEhK0BSAa1K
         g3iBH+uPGjOWixtNEYIu/6UxV9lITjIWm1ytCAiEjs4+5BaXRc6+PNa31GyqUDn2aZYa
         vacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010445; x=1694615245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW/0ftx44nuZvnIVfoBb4IXQmDJJsfiAnE8tMNiYS4g=;
        b=DoZuVorje8EaWGR+8JE6/HhlLBswuyNVmLs29N9vfqQwXbCB50xKv9FInbEADPXN9V
         VG/rOPb747MwVTNHaunUIJSkUNogU8R+DipQiukeaFAH8ggm+Yrx4E2H6lDfCsAKbpZX
         nQYQTL77eGdNg8lRXROHhTJyzVbncy7zY2HW/7KqreB8mF560JUBfyrGFbfDVtuoplaV
         RDL2Siy1PMHJiF+3gLAtdTvCePCqrw9y7LfO7wRlPuN+xMHRnkn+l89p9P+z15X6sNct
         A/CgqOYgOIREPawdHkUHpujBtWLsUmA8Oo95zDUzXr7SkTJ3u3etWRjfEYWs00v/Rau/
         HKng==
X-Gm-Message-State: AOJu0Yxau6N7utbmbjiG09rWkFCTYrUwD44yWeo5Ht6nZzX2uZ/Lpp8w
        goGl4RXJyCDGSv6K/MMU0pGWoqwxN/RF1hevVvznog==
X-Google-Smtp-Source: AGHT+IHoZDtEvlafSlOtaL3eIj2H5vP48KL4yKOmxNr5WPPA1hwUKpDDD/YvuNOyFoHGnvDWIVi1aWHPf6UcXmEixBk=
X-Received: by 2002:a05:6102:3003:b0:44d:acfd:6f0a with SMTP id
 s3-20020a056102300300b0044dacfd6f0amr1975222vsa.16.1694010445227; Wed, 06 Sep
 2023 07:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-12-brgl@bgdev.pl>
 <8f51b4a8-bb9c-4918-61a8-4ab402da1ed0@redhat.com>
In-Reply-To: <8f51b4a8-bb9c-4918-61a8-4ab402da1ed0@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 6 Sep 2023 16:27:14 +0200
Message-ID: <CAMRc=Mfmp3Nd5jwNWr=kc8RFO-arFDwEvLxj5Qu9_1OOXR2gHQ@mail.gmail.com>
Subject: Re: [RFT PATCH 11/21] platform: x86: android-tablets: don't access
 GPIOLIB private members
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 3:01=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi Bartosz,
>
> On 9/5/23 20:52, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We're slowly removing cases of abuse of the GPIOLIB public API. One of
> > the biggest issues is looking up and accessing struct gpio_chip whose
> > life-time is tied to the provider and which can disappear from under an=
y
> > user at any given moment. We have provided new interfaces that use the
> > opaque struct gpio_device which is reference counted and will soon be
> > thorougly protected with appropriate locking.
> >
> > Stop using old interfaces in this driver and switch to safer
> > alternatives.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> First of all sorry for the issues this hack-ish kernel module
> is causing for cleaning up gpiolib APIs.
>
> I don't know how close a look you took at the code, so first of
> all let me try to briefly explain what this hackish kernel module
> is for:
>
> There are some x86_64/ACPI tablets which shipped with Android as
> factory OS. On these tablets the device-specific (BSP style)
> kernel has things like the touchscreen driver simply having
> a hardcoded I2C bus-number + I2C client address. Combined
> with also hardcoded GPIO numbers (using the old number base APIs)
> for any GPIOs it needs.
>
> So the original Android kernels do not need the devices
> to be properly described in ACPI and the ACPI tables are
> just one big copy and paste job from some BSP which do
> not accurately describe the hardware at all.
>
> x86-android-tablets.ko identifies affected models by their
> DMI strings and then manually instantiates things like
> i2c-clients for the touchscreen, accelerometer and also
> other stuff. Yes this is ugly but it allows mainline kernels
> to run pretty well on these devices since other then
> the messed up ACPI tables these are pretty standard x86/ACPI
> tablets.
>
> I hope this explains the hacks, now on to the problems
> these are causing:

This makes sense! Maybe we'd need a good-old board file setting up all
non-described devices using the driver model?

>
> > ---
> >  .../platform/x86/x86-android-tablets/core.c   | 38 ++++++++++---------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/=
platform/x86/x86-android-tablets/core.c
> > index 2fd6060a31bb..687f84cd193c 100644
> > --- a/drivers/platform/x86/x86-android-tablets/core.c
> > +++ b/drivers/platform/x86/x86-android-tablets/core.c
> > @@ -12,6 +12,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/dmi.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/gpio/machine.h>
> >  #include <linux/irq.h>
> > @@ -21,27 +22,28 @@
> >  #include <linux/string.h>
> >
> >  #include "x86-android-tablets.h"
> > -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> > -#include "../../../gpio/gpiolib.h"
> > -#include "../../../gpio/gpiolib-acpi.h"
> > -
> > -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
> > -{
> > -     return gc->label && !strcmp(gc->label, data);
> > -}
> >
> >  int x86_android_tablet_get_gpiod(const char *label, int pin, struct gp=
io_desc **desc)
> >  {
> > +     struct gpio_device *gdev;
> >       struct gpio_desc *gpiod;
> > -     struct gpio_chip *chip;
> >
> > -     chip =3D gpiochip_find((void *)label, gpiochip_find_match_label);
> > -     if (!chip) {
> > -             pr_err("error cannot find GPIO chip %s\n", label);
> > +     /*
> > +      * FIXME: handle GPIOs correctly! This driver should really use s=
truct
> > +      * device and GPIO lookup tables.
> > +      *
> > +      * WONTDO: We do leak this reference, but the whole approach to g=
etting
> > +      * GPIOs in this driver is such an abuse of the GPIOLIB API that =
it
> > +      * doesn't make it much worse and it's the only way to keep the
> > +      * interrupt requested later functional...
> > +      */
> > +     gdev =3D gpio_device_find_by_label(label);
> > +     if (!gdev) {
> > +             pr_err("error cannot find GPIO device %s\n", label);
> >               return -ENODEV;
> >       }
> >
> > -     gpiod =3D gpiochip_get_desc(chip, pin);
> > +     gpiod =3D gpio_device_get_desc(gdev, pin);
> >       if (IS_ERR(gpiod)) {
> >               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), =
label, pin);
> >               return PTR_ERR(gpiod);
>
>
> So rather then the above I think what needs to happen here
> (and I can hopefully make some time for that this weekend) is:
>
> 1. Have the x86-android-tablets code instantiate a
>    "x86-android-tablets" platform-dev
> 2. Have the code generate a gpiod_lookup_table for all GPIOs
>    for which it currently uses x86_android_tablet_get_gpiod()
>    with the .dev_id set to "x86-android-tablets"
> 3. Use regular gpiod_get() on the "x86-android-tablets" pdev
>    to get the desc.
>
> I think this should solve all the issues with
> x86_android_tablet_get_gpiod() poking inside
> gpiolib external since now it is only using
> public gpiolib APIs, right ?
>
> One question about 2. there are 2 ways to do this:
>
> i. Have the module_init() function loop over all
> x86_dev_info members which will result in calling
> x86_android_tablet_get_gpiod() and have it generate
> one big gpiod_lookup_table for all GPIOs needed
> in one go. At which point x86_android_tablet_get_gpiod()
> goes away and can be directly replaced with gpiod_get()
> calls on the pdev.
>
> ii. Keep x86_android_tablet_get_gpiod() and have it
> generate a gpiod_lookup_table with just 1 entry for
> the GPIO which its caller wants. Register the lookup
> table, do the gpiod_get() and then immediately
> unregister the lookup table again.
>
> ii. Would be easier for me to implement, especially
> since there is also some custom (board specific)
> init code calling x86_android_tablet_get_gpiod()
> which would require some special handling for i.
>
> OTOH I guess some people will consider ii. somewhat
> ugly, although AFAICT it is perfectly ok to use
> the gpiolib lookup APIs this way.
>
> Can you please let me known if you are ok with ii,
> or if you would prefer me going with solution i. ?
>

I am fine with ii. I have recently sent a patch that does exactly that
in one of the SPI drivers. It's ugly but it's better than what we have
now.

> That way when I can make some time to start working
> on this I can pick the preferred solution right away.
>
>
>
> > @@ -257,9 +259,9 @@ static void x86_android_tablet_cleanup(void)
> >
> >  static __init int x86_android_tablet_init(void)
> >  {
> > +     struct gpio_device *gdev __free(gpio_device_put) =3D NULL;
> >       const struct x86_dev_info *dev_info;
> >       const struct dmi_system_id *id;
> > -     struct gpio_chip *chip;
> >       int i, ret =3D 0;
> >
> >       id =3D dmi_first_match(x86_android_tablet_ids);
> > @@ -273,13 +275,13 @@ static __init int x86_android_tablet_init(void)
> >        * _AEI (ACPI Event Interrupt) handlers, disable these.
> >        */
> >       if (dev_info->invalid_aei_gpiochip) {
> > -             chip =3D gpiochip_find(dev_info->invalid_aei_gpiochip,
> > -                                  gpiochip_find_match_label);
> > -             if (!chip) {
> > +             gdev =3D gpio_device_find_by_label(
> > +                             dev_info->invalid_aei_gpiochip);
> > +             if (!gdev) {
> >                       pr_err("error cannot find GPIO chip %s\n", dev_in=
fo->invalid_aei_gpiochip);
> >                       return -ENODEV;
> >               }
> > -             acpi_gpiochip_free_interrupts(chip);
> > +             acpi_gpio_device_free_interrupts(gdev);
> >       }
> >
> >       /*
>
> After some recent improvements there is only 1 board left which sets
> dev_info->invalid_aei_gpiochip and that can easily be replaced with
> with adding 1 extra entry to gpiolib_acpi_quirks[] inside
> drivers/gpio/gpiolib-acpi.c .
>
> So I believe the right solution here is to just remove
> dev_info->invalid_aei_gpiochip support for x86-android-tablets
> all together and then at least x86-android-tablets will no
> longer be making any hackish acpi_gpiochip_free_interrupts() calls.
>
> I don't want to make any promises wrt the timing, but I should
> be able to prepare a set of patches which simply removes all
> the private gpiolib API use from x86-android-tablets, so that
> you don't need to workaround that in this patch series.
>
> With some luck I can have an immutable branch with 6.6-rc1 +
> such a patch-series ready for you soon after 6.6-rc1 is
> released.
>

That would be awesome, thanks a lot!

> Regards,
>
> Hans
>
>
>

Bart

[1] https://lore.kernel.org/lkml/d57a99ce-77eb-409f-8371-95f2658fa0c0@siren=
a.org.uk/T/
