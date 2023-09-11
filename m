Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388679AD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353934AbjIKVvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjIKNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:14:59 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF7E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:54 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44ee3a547adso1722976137.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694438093; x=1695042893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmHlHXBKieO1ptu2ldznM8ZuZhTbj+/naN6JcvAFLCM=;
        b=wMbspLXnU4SWJPP2pyiFS+UPFCNPGYLSf7ttzlXYAlHzDhVZW7HVGa2l9NwlellZJE
         njOC3G16h+joZnmK7I9iIFB+fNBIjy4gsffff7BLFLKycGVnAhDL9SNDPFOKQVtPIyKL
         KgvKxOKEeCpMKUx+LLmH4Kve69knsX4HPJjf0h5QaVBII8vQBPS4tD0JkrVZaqxhJisA
         jnYS2/kGs69torDAx8w+jn0ySA4fIvj3s8mGyhCjeMldRAFv4+DiDllCXiYLIuZIky1Y
         bi34YIU6PyRFd+MPjR5QGvsk+pqn/ffJoDFP2AXXlp/Bu18d3f+Mqsa5qSk/HAHiD5Mj
         ZPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438093; x=1695042893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmHlHXBKieO1ptu2ldznM8ZuZhTbj+/naN6JcvAFLCM=;
        b=MYoyFpe7HtgaHWuSMsnFo/QusC3G6PkexFknrlm4QfRytu3rKc6Z04NUFFnmX6s8oq
         LeXKQ40T4WY2eCLCvtblMRHmt6Uk7EVFEEukI2byFmQvu6JnAnCD4bP+eNZvYRIhac94
         0ApQ3cL1WYVM+GPGw3kIksgrtKVPGRuV6yhQIB/2S3SJ44FBC/RKJG4m4cFQWeWnXiuZ
         9b7cQRnP1UWGuGW8fLNUsd4xtyMPZHDb0WdU7PISfIblyIrt0Z69lfshrqLMOqJX477S
         T6Uv+7Q7mQSJFM5qMYjP95GUXpeJRggqcLQuz49OfyKWC9wJ5800kUxlh/lA1RFjLfbW
         Sc7A==
X-Gm-Message-State: AOJu0YzQ1JO4YxrQvNTDpeRncqUDB4FtviFd3MzBZWC65T2UvLmW/sh2
        9ByU6aEs//wDx9DUB8kHWG2esmHVuJCsgZO7MY0+8A==
X-Google-Smtp-Source: AGHT+IGbBUp7apcBf0Wo94rPuei/uMCOLdfymAUYtbXkWV6tuJHuzpKRqe3xeH+LKJOYB5mMHTLfbCwIf2IHKGe4l8I=
X-Received: by 2002:a67:fe92:0:b0:44d:5a92:ec45 with SMTP id
 b18-20020a67fe92000000b0044d5a92ec45mr8588355vsr.23.1694438093755; Mon, 11
 Sep 2023 06:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-3-brgl@bgdev.pl>
 <ZPiISpLoVx35PuYc@smile.fi.intel.com>
In-Reply-To: <ZPiISpLoVx35PuYc@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 15:14:42 +0200
Message-ID: <CAMRc=MfLGZNmQT55dtrLuqsKbfXjTn7kqOm029oJrOnH002wBw@mail.gmail.com>
Subject: Re: [PATCH 02/21] gpiolib: provide gpio_device_find()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
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

On Wed, Sep 6, 2023 at 4:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 05, 2023 at 08:52:50PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_find() is wrong and its kernel doc is misleading as the
> > function doesn't return a reference to the gpio_chip but just a raw
> > pointer. The chip itself is not guaranteed to stay alive, in fact it ca=
n
> > be deleted at any point. Also: other than GPIO drivers themselves,
> > nobody else has any business accessing gpio_chip structs.
> >
> > Provide a new gpio_device_find() function that returns a real reference
> > to the opaque gpio_device structure that is guaranteed to stay alive fo=
r
> > as long as there are active users of it.
>
> ...
>
> > +/**
> > + * gpio_device_find() - find a specific GPIO device
> > + * @data: data to pass to match function
> > + * @match: Callback function to check gpio_chip
>
> > + * Returns:
> > + * New reference to struct gpio_device.
>
> I believe this is wrong location of the Return section.
> AFAIU how kernel doc uses section markers, this entire description become=
s
> a Return(s) section. Have you tried to render man/html/pdf and see this?
>

Yes, it works just fine. Try for yourself: scripts/kernel-doc -rst
drivers/gpio/gpiolib.c

Bart

> > + * Similar to bus_find_device(). It returns a reference to a gpio_devi=
ce as
> > + * determined by a user supplied @match callback. The callback should =
return
> > + * 0 if the device doesn't match and non-zero if it does. If the callb=
ack
> > + * returns non-zero, this function will return to the caller and not i=
terate
> > + * over any more gpio_devices.
> > + *
> > + * The callback takes the GPIO chip structure as argument. During the =
execution
> > + * of the callback function the chip is protected from being freed. TO=
DO: This
> > + * actually has yet to be implemented.
> > + *
> > + * If the function returns non-NULL, the returned reference must be fr=
eed by
> > + * the caller using gpio_device_put().
> > + */
> > +struct gpio_device *gpio_device_find(void *data,
>
> > +                                  int (*match)(struct gpio_chip *gc,
> > +                                               void *data))
>
> One line?
> Or maybe a type for it? (gpio_match_fn, for example)
>
> > +{
> > +     struct gpio_device *gdev;
> > +
> > +     guard(spinlock_irqsave)(&gpio_lock);
> > +
> > +     list_for_each_entry(gdev, &gpio_devices, list) {
> > +             if (gdev->chip && match(gdev->chip, data))
> > +                     return gpio_device_get(gdev);
> > +     }
> > +
> > +     return NULL;
> > +}
>
> ...
>
> > +struct gpio_device *gpio_device_find(void *data,
> > +                                  int (*match)(struct gpio_chip *gc,
> > +                                               void *data));
>
> Ditto.
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
