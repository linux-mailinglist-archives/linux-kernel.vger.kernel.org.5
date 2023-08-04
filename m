Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71790770590
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjHDQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHDQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:04:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF94C0C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:03:58 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a7781225b4so769248b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691165038; x=1691769838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbGJEAvdY+U9pkMi+EcWXOXKA+bs3Kgp9vMkmWDzcz8=;
        b=QrqDDAN8zg5+KFMKpnaDIOVUHHKDIgCp6oNZZt9zwh/dKhK9ZZkfn/D23gkbN6zULG
         /CcgkIHQj8GnIdmeFxygZG6hEDZcrui4LkoTDhxOLqW0ujq/C2sKPO8mhszZmVPNjtZf
         A2njYcuQ0i8nj3E4lAycOdGHgBA96Fu6Z4hvmIJvuF68DgESdsPBeMJADI9XvX3WXxBP
         xCPMUsqnmyYBl2acwqXtCu6NWNWrlMYRH2dBBuDBsg2Tb+lR0h8iX65cCrl6iOnI9uH9
         tzah90jKLjSYIfjXXM8qpzA5iPfzS3qqE3Stma7gJxZNgksdDLCkCOyv2LLlpYYEL7CL
         MvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165038; x=1691769838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbGJEAvdY+U9pkMi+EcWXOXKA+bs3Kgp9vMkmWDzcz8=;
        b=dwmAP9koZKBzguB50Z01HpMWpzHNKqajdzIIGf9qjZMZA+N3l7534OBMVx6jZlWuWr
         n66AtHfEnYpyiQxAQ9RlCMj2GPH7zjAOVhmAZEoovjq8ZOeru7DteQWByVFNCuvYOAcz
         ZfhO9r1eVzm3yKSXjE8CkQVQ/7+JgAqKHAGG6rbXTK3c6kH8gpc5wTFHdurHH2I6vHFV
         rYc3QrwI7g6iRIpX3+CpdDBVxNmZOx/Y6Z//VWyCLvkrgSNuhEZVhO7uRSWqlkyR8BQ0
         sLOFDNDcNwD3O9HyYZLK1hnEo1g0av8xvbI1rI40s54yi5Lr5ao9UOvLKMS6aNS8tAiO
         SPzA==
X-Gm-Message-State: AOJu0Yyzt/64Cg9E+WAQkiASICuuZ1AZVhXbEOCftJPqVXeB9nsN4FZ8
        mhuZuPW/28O+eV5XXcn0pV1ustELv3WC14oaAQmEGQ==
X-Google-Smtp-Source: AGHT+IHZBH5r6emqQTL8xn4X8zOQdBhq06zI27xzGze62f+uqh1H/6qUhFPHofwIukXunpgiL/z49dHmYRxALsPUwtw=
X-Received: by 2002:a05:6358:249f:b0:13a:9d5:356a with SMTP id
 m31-20020a056358249f00b0013a09d5356amr1211941rwc.21.1691165037916; Fri, 04
 Aug 2023 09:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230802152808.33037-1-brgl@bgdev.pl> <ZMuR0W303WCbS1K0@smile.fi.intel.com>
In-Reply-To: <ZMuR0W303WCbS1K0@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 4 Aug 2023 18:03:47 +0200
Message-ID: <CAMRc=McEAG7Ezgb=OwMPoRhQzu_A66JMnB=aBSgmdZUvS-ZPhw@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: consumer: new virtual driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Thu, Aug 3, 2023 at 1:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

>
> > +#include <linux/of_platform.h>
>
> Wrong header. Use mod_devicetable.h.
>
> > +#include <linux/platform_device.h>
> > +#include <linux/printk.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/timer.h>
>
> And general recommendation is to revisit this block and refine it accordi=
ngly.
>

I kept track of the interfaces I used for most part, so it should be
mostly fine.

[snip]

> ...
>
> > +     flags =3D function =3D=3D GPIO_CONSUMER_FUNCTION_MONITOR ?
> > +                                     GPIOD_IN : GPIOD_OUT_HIGH;
> > +     for (i =3D 0; i < num_lines; i++) {
> > +             desc =3D devm_gpiod_get(dev, lines[i], flags);
> > +             if (IS_ERR(desc))
> > +                     return dev_err_probe(dev, PTR_ERR(desc),
> > +                                          "Failed to get GPIO '%s'\n",
> > +                                          lines[i]);
>
> Would it make sense to request GPIOs via devm_gpiod_get_array() and then =
try
> the rest on them in a loop?
>

No it would not. gpiod_get_array() works for properties represented in DT a=
s:

    foo-gpios =3D <&chip ...>, <&chip ...>, <&chip ...>;

while what we have here is:

    foo-gpios =3D <&chip ...>;
    bar-gpios =3D <&chip ...>;

Which makes me think that I need to add proper documentation for this modul=
e.

[snip]

>
> > +static ssize_t
> > +gpio_consumer_lookup_config_offset_store(struct config_item *item,
> > +                                      const char *page, size_t count)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +     int offset, ret;
> > +
> > +     ret =3D kstrtoint(page, 0, &offset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Use -1 to indicate lookup by name. */
> > +     if (offset > (U16_MAX - 1))
> > +             return -EINVAL;
>
> So, offset here may be negative. Is it okay?
>

Yes. If negative - lookup line by name, if positive, by chip and
offset. I will document this properly for v2.

> > +     mutex_lock(&dev->lock);
> > +
> > +     if (gpio_consumer_device_is_live_unlocked(dev)) {
> > +             mutex_unlock(&dev->lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     lookup->offset =3D offset;
> > +
> > +     mutex_unlock(&dev->lock);
> > +
> > +     return count;
> > +}
>
> ...
>
> > +     if (flags & GPIO_OPEN_DRAIN)
> > +             repr =3D "open-drain";
> > +     else if (flags & GPIO_OPEN_SOURCE)
> > +             repr =3D "open-source";
>
> Can it be both flags set?
>

No!

> > +     else
> > +             repr =3D "push-pull";
>
> ...
>
> > +     if (sysfs_streq(page, "push-pull")) {
> > +             lookup->flags &=3D ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
> > +     } else if (sysfs_streq(page, "open-drain")) {
> > +             lookup->flags &=3D ~GPIO_OPEN_SOURCE;
> > +             lookup->flags |=3D GPIO_OPEN_DRAIN;
> > +     } else if (sysfs_streq(page, "open-source")) {
> > +             lookup->flags &=3D ~GPIO_OPEN_DRAIN;
> > +             lookup->flags |=3D GPIO_OPEN_SOURCE;
> > +     } else {
> > +             count =3D -EINVAL;
> > +     }
>
> I prefer to see some kind of the array of constant string literals and do
> sysfs_match_string() here
>

I would generally agree but if the flag values ever change to ones
that make the resulting string array have holes in it, match_string()
will suddenly stop working. I think that with bit flags defined
elsewhere it's safer and more readable to do the above.

>         lookup->flags &=3D ~(GPIO_OPEN_DRAIN | GPIO_OPEN_SOURCE);
>         flag =3D sysfs_match_string(...);
>         if (flag < 0)
>                 count =3D flag
>         else
>                 lookup->flags |=3D flag;
>
> (or something similar). And respectively indexed access above.
>
> ...
>

> ...
>
> > +     if (list_empty(&dev->lookup_list))
> > +             return -ENODATA;
>
> Instead you may count nodes here and if 0, return an error, otherwise pas=
s it
> to the callee.

I'm not following, please rephrase.

>
> > +     swnode =3D gpio_consumer_make_device_swnode(dev);
> > +     if (IS_ERR(swnode))
> > +             return PTR_ERR(swnode);
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_device_config_live_store(struct config_item *item,
> > +                                    const char *page, size_t count)
> > +{
> > +     struct gpio_consumer_device *dev =3D to_gpio_consumer_device(item=
);
> > +     bool live;
> > +     int ret;
> > +
> > +     ret =3D kstrtobool(page, &live);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&dev->lock);
> > +
> > +     if ((!live && !gpio_consumer_device_is_live_unlocked(dev)) ||
> > +         (live && gpio_consumer_device_is_live_unlocked(dev)))
>
>         if (live ^ gpio_consumer_device_is_live_unlocked(dev))
>
> ?

Nah, let's not use bitwise operators for boolean logic.

[snip]

I commented on the ones that needed it, for others, I'll fix them for v2.

Bart
