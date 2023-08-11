Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509A778838
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHKHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjHKHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:31:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790E2D54;
        Fri, 11 Aug 2023 00:31:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-521caf0d7a6so452755a12.1;
        Fri, 11 Aug 2023 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739074; x=1692343874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KexaGluKURIcI7riq+JEU96WXsMp5CAvJcWSFuitbNA=;
        b=CFp6kkaEgKSr/SaE8/AItUvx/gVysrRQnIYYEdTUwc74MwKPGz5CT0g/9tnIXsps0P
         HNO4DRttQ/F3o7iAMl10KRxaSU6vdZYZU9Lh+ciwI5+Y1juCojXcdAUBWhtPe57APapb
         fMujgwfNuvoZpriZBj262aI8xbUqyQZk2FiPjAq7S0xBSDmONZcgfED9WBylg6CkClSO
         hsCmjkDhR8WbLcDKi6JyvgErEOj/qxiV5GyqsbqMvUJMiP41mCJjkHOXxQND2ziG7X49
         sMI1vqpOJyF5MdHhv3Nv6vtjv8Fg0/6xCMjNEk8ereE32mPJi8jfpBggCZKmFmrpzC3k
         wlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739074; x=1692343874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KexaGluKURIcI7riq+JEU96WXsMp5CAvJcWSFuitbNA=;
        b=PEf/V0RDV8QKglfYS3TouEPB5PRByx8O23kXZyNX2xuQZjRthFWzwLcIomy5rCw+4U
         +uaW9bZ72SapXLNbvCuYNvEVGqwxtf4dS8GQUP9+CiNujtsR+lxaP1+DplCOcdcwePUq
         5d47wUO3h/kQ2zZvgRGyfeyC0+9ivqgdr4p2CogLAunbcK60mlluPqTn7v2Zx2eqk2CY
         6MzOi1KulERsQyDqf8bEW/ezEd7ByanY6nBSc4YAkgL0ZioCpV1wuCWvyhbKTJWfZ+mD
         6K1ksJtkMz7uC735HZ57YdFI1ddU2CnIiiJLU7D2NKcAQ7TYuk3/XPPrBQyL21jxXfpR
         F3oQ==
X-Gm-Message-State: AOJu0YwN1IWt9sMK/+T8iQtEOcvS+I8QCGOvr0dhudRADqszx00cMz4w
        uMvkkplwU3d1Eq9M4V/q57Un6CxpL8nthWz1HSI=
X-Google-Smtp-Source: AGHT+IF0Z3QBn06K4OzK+UnP4dxE9xhJryDaXp8o7wlAumUwOl43mVukQZbokv2YqXl7+jttnwXZo1neIS+9a1NuEAs=
X-Received: by 2002:a05:6402:4407:b0:522:28b9:e85f with SMTP id
 y7-20020a056402440700b0052228b9e85fmr1085776eda.1.1691739073378; Fri, 11 Aug
 2023 00:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com> <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
 <CAB9BWhcPpZRNPki1j0spCzN0kF=-1P1ZwtOLULmr2Raz6aO-_w@mail.gmail.com> <ZNTtl9MKHWWbqpnq@smile.fi.intel.com>
In-Reply-To: <ZNTtl9MKHWWbqpnq@smile.fi.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Fri, 11 Aug 2023 15:31:01 +0800
Message-ID: <CAB9BWhd6cmYSGXF33hKMq6x0USm+tjFCKLZHRvj7aPXuomDzng@mail.gmail.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:01=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 10, 2023 at 08:42:36PM +0800, wenhua lin wrote:
> > On Tue, Aug 8, 2023 at 9:51=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 08, 2023 at 03:25:01PM +0800, Wenhua Lin wrote:
> > > > Add matrix keypad driver, support matrix keypad function.
> > >
> > > Bindings should be prerequisite to this, meaning this has to be a ser=
ies of
> > > two patches.
> >
> > I don't quite understand what you mean.
> > Can you describe the problem in detail?
>
> ...
>
> > > > +     help
> > > > +       Keypad controller is used to interface a SoC with a matrix-=
keypad device,
> > > > +       The keypad controller supports multiple row and column line=
s.
> > > > +       Say Y if you want to use the SPRD keyboard.
> > > > +       Say M if you want to use the SPRD keyboard on SoC as module=
.
> > >
> > > What will be the module name?
> >
> > Keypad
>
> With capital letter?
> Are you sure?
>
> Also I'm asking this here to make sure that you will make sure the users =
of it
> will know without reading source code.

Thank you very much for your review.
I will fix this issue in patch v2.

>
> ...
>
> > > >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)    +=3D st-keyscan.o
> > > >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)   +=3D sun4i-lradc-keys.o
> > > >  obj-$(CONFIG_KEYBOARD_SUNKBD)                +=3D sunkbd.o
> > > > +obj-$(CONFIG_KEYBOARD_SPRD)          +=3D sprd_keypad.o
> > >
> > > Are you sure it's ordered correctly?
> >
> > This configuration is correct, we may not understand what you mean?
> >  Any suggestions for this modification?
>
> Latin alphabet is an ordered set.

I will fix this issue in patch v2.

>
> > > >  obj-$(CONFIG_KEYBOARD_TC3589X)               +=3D tc3589x-keypad.o
> > > >  obj-$(CONFIG_KEYBOARD_TEGRA)         +=3D tegra-kbc.o
> > > >  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)  +=3D tm2-touchkey.o
>
> ...
>
> > > Missing bits.h at least.
> > > Revisit you header inclusion block to add exactly what you are using.
> >
> > The sprd_keypad.c file will include <linux/interrupt.h>, interrupt.h
> > will include <linux/bitops.h>,
> > and the bitops.h file will include bits.h. Can this operation method be=
 used?
>
> Seems you misunderstand how C language works. The idea is that you need t=
o
> include _explicitly_ all library / etc headers that your code is using.
> The above is a hackish way to achieve that.

I will fix this issue in patch v2.

>
> ...
>
> > > > +#include <linux/of.h>
> > >
> > > Why?
> >
> > ret =3D of_property_read_u32(np, "debounce-interval", &data->debounce_m=
s);
> > if (of_get_property(np, "linux,repeat", NULL))
> >
> > Two interfaces of_property_read_u32 and of_get_property are used
> > in the sprd_keypad_parse_dt function. If of.h is not included, the
> > compilation will report an error.
>
> Do not use of_*() in a new code for the drivers.
> There are only few exceptions and this driver is not one of them.

I will fix this issue in patch v2.

>
> ...
>
> > > > +#define SPRD_DEF_LONG_KEY_MS         1000
> > >
> > >         (1 * MSEC_PER_SEC)
> > >
> > > ?
> >
> >     Yes.
>
> It makes more sense to update so easier to get the value and units from
> the value.
>
> ...
>
> > > > +     u32 rows_en; /* enabled rows bits */
> > > > +     u32 cols_en; /* enabled cols bits */
> > >
> > > Why not bitmaps?
> >
> > Bitmap has been used, each bit represents different rows and different =
columns.
>
> I meant the bitmap type (as of bitmap.h APIs).

I understand what you mean, I need to study how this bitmap is used.

>
> ...
>
> > > > +static int sprd_keypad_parse_dt(struct device *dev)
> > >
> > > dt -> fw
> >
> > I don't quite understand what you mean,=E3=80=82
> > is it to change the function name to sprd_keypad_parse_fw?
>
> Yes. And make it firmware (which may be ACPI/DT or something else).

We need to think about how to modify it.

>
> ...
>
> > > And I'm wondering if input subsystem already does this for you.
> >
> > I don't quite understand what you mean.
>
> Does input subsystem parse the (some of) device properties already?

Yes
>
> ...
>
> > > > +     data->enable =3D devm_clk_get(dev, "enable");
> > > > +     if (IS_ERR(data->enable)) {
> > > > +             if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > > > +                     dev_err(dev, "get enable clk failed.\n");
> > > > +             return PTR_ERR(data->enable);
> > > > +     }
> > > > +
> > > > +     data->rtc =3D devm_clk_get(dev, "rtc");
> > > > +     if (IS_ERR(data->rtc)) {
> > > > +             if (PTR_ERR(data->enable) !=3D -EPROBE_DEFER)
> > > > +                     dev_err(dev, "get rtc clk failed.\n");
> > > > +             return PTR_ERR(data->rtc);
> > > > +     }
> > >
> > > Why not bulk?
> > > Why not _enabled() variant?
> >
> > I don't quite understand what you mean.
> > Can you give me an example?
>
> Hmm... seems there is no existing API like that, but still you have bulk
> operations.
>
> $ git grep -n clk_bulk.*\( -- include/linux/clk.h
>
> ...

I will fix this issue in patch v2.

>
> > > > +     data->base =3D devm_ioremap_resource(&pdev->dev, res);
> > >
> > > devm_platform_ioremap_resource()
> > >
> > > > +     if (IS_ERR(data->base)) {
> > >
> > > > +             dev_err(&pdev->dev, "ioremap resource failed.\n");
> > >
> > > Dup message.
> >
> >  Do you mean : dev_err(&pdev->dev, "ioremap resource failed.\n")=EF=BC=
=8C
> > I think it is necessary to prompt accurate error message.
>
> Yes, and yours is a duplication of a such.
>
> > > > +             ret =3D  PTR_ERR(data->base);
> > > > +             goto err_free;
> > > > +     }
>
> ...
>
> > > > +             dev_err(&pdev->dev, "alloc input dev failed.\n");
> > > > +             ret =3D  PTR_ERR(data->input_dev);
> >
> > > Too many spaces.
> >
> > We will fix this issue in patch v2.
> >
> > > Here and elsewhere in ->probe() use return dev_err_probe() approach a=
s Dmitry
> > > nowadays is okay with that.
> >
> > I don't quite understand what you mean.
> > Can you describe it in detail?
>
>         return dev_err_probe(...);
>
> or
>
>         ret =3D dev_err_probe(... PTR_ERR(...), ...);
>
> Btw, most of your questions can be answered by looking into the lately ad=
ded
> drivers in the input subsystem.

I need to refer to the new input subsystem and modify the code again,
 thank you very much for your suggestion

>
> ...
>
> > > > +clk_free:
> > > > +     sprd_keypad_disable(data);
> > >
> > > See above how this can be avoided.
> >
> > This is hard to explain.
>
> What do you mean?
> But I guess somebody already mentioned devm_add_action_or_reset().

I may need to understand how to use this interface
and fix this problem in patch v2.

>
> ...
>
> > > > +err_free:
> > > > +     devm_kfree(&pdev->dev, data);
> > >
> > > Huh?!
>
> It's a red flag, and you have no answer to it...

I realized the problem, the interface using devm_  does not need to do the =
free.
I will fix this issue in patch v2.

>
> > > > +     return ret;
>
> ...
>
> > > > +             .owner =3D THIS_MODULE,
> > >
> > > ~15 years this is not needed.
> > > Where did you get this code from? Time machine?
> >
> > Do you mean the keypad driver is no longer in use?
>
> No, I meant specifically emphasized line.

The keypad driver code is used on the platform
 and has not been submitted to the community.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
