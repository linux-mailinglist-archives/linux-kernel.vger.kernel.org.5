Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02A77F62E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350732AbjHQMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350777AbjHQMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:14:18 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70C2112
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:14:16 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79dbd1fb749so548412241.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692274456; x=1692879256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp2jFPd5H/9xqBM8BS9hQEvHXOE5m+c15k9g0RAPmQs=;
        b=109doTdOPGel7wMM6UfGY1JZDmid+V04laFQMn/GFnVUCoUblIfUQOfzouhVGqhbxf
         hvq54yg4t87eKAAqpsRc4QBoGqOdZAK7uZ1ycGAH0zSWoN3giEYZeCIGYM8EkngSWJ7Z
         cgNc4IOs4pbmYKtorA4A7wXgsuBjXcrq1GoIRUhoLymXUndtg/7Iqgfq0dKDQn8bhrFj
         l18TaFm/DDVtHC6buL3k0c/H7xCT9kpsAW77aHhYtALrShXagkNAq/EZsyoLjVPioPes
         pXqv1f7hORA3mLxbCL5CQOnu5CgzbqElz62y31rDiXokmz+xYwDlu1RvO3At9t8gY4rO
         eagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692274456; x=1692879256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp2jFPd5H/9xqBM8BS9hQEvHXOE5m+c15k9g0RAPmQs=;
        b=Fujo8CE4TaUkEwTUqIHvXKYIUL8u8SlMhrJveMjrx+oEZknAP2vKirhqMovEImrW1t
         OlJ7jyckQN4GJboKixXKGvcYySVTGc5p6MrQLUAvsnXjtRMngJm6VlsRvm2WC8NJTeMJ
         bgDwQ8gJuyLdS9S8PIpBrPF5o+gWmG8iNYFr3wiahvn4k8jWGl63Fe6xJZr0DV+rqh+z
         C8GdxLrosU6rVXFUSUGTfFo54ajKhNPg8p4eekGTlUrJ9M1h+wyYxPCNptA2iSNNb4TY
         bNtXxvnJ6UNvH2q07Tm+tC63zjykiY5D/XGrWS1iB28TeiMNidOyENmIGCOEd6LO63+k
         pDTw==
X-Gm-Message-State: AOJu0YxQgU0h3EAYRlj8GLznJc/QHLqj3Op3VnJzUOCeqs8NZp9XAM5R
        WZDrKkammerDG5eBtWBwADvKIRR9zUs/XFFG9DGefg==
X-Google-Smtp-Source: AGHT+IEM0kid+C1ABw0K4dQ5YTSG/4EfeBg6JureDmfYnzZJz/RpG5c4KTKXZLIN2joDPAl31cKupwmKfDz+BI+39gI=
X-Received: by 2002:a05:6102:511e:b0:44b:f485:2727 with SMTP id
 bm30-20020a056102511e00b0044bf4852727mr2330114vsb.4.1692274455861; Thu, 17
 Aug 2023 05:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230815185650.152968-1-brgl@bgdev.pl> <ZN3wauUBENDd7aRU@smile.fi.intel.com>
In-Reply-To: <ZN3wauUBENDd7aRU@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Aug 2023 14:14:04 +0200
Message-ID: <CAMRc=MdUWXZVnjkPqH2BZvDY0v-OOysQ=NMjwQEi1rt+16NEQQ@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: consumer: new virtual driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 15, 2023 at 08:56:50PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The GPIO subsystem has a serious problem with undefined behavior and
> > use-after-free bugs on hot-unplug of GPIO chips. This can be considered=
 a
> > corner-case by some as most GPIO controllers are enabled early in the
> > boot process and live until the system goes down but most GPIO drivers
> > do allow unbind over sysfs, many are loadable modules that can be (forc=
e)
> > unloaded and there are also GPIO devices that can be dynamically detach=
ed,
> > for instance CP2112 which is a USB GPIO expender.
> >
> > Bugs can be triggered both from user-space as well as by in-kernel user=
s.
> > We have the means of testing it from user-space via the character devic=
e
> > but the issues manifest themselves differently in the kernel.
> >
> > This is a proposition of adding a new virtual driver - a configurable
> > GPIO consumer that can be configured over configfs (similarly to
> > gpio-sim).
> >
> > The configfs interface allows users to create dynamic GPIO lookup table=
s
> > that are registered with the GPIO subsystem. Every config group
> > represents a consumer device. Every sub-group represents a single GPIO
> > lookup. The device can work in three modes: just keeping the line
> > active, toggling it every second or requesting its interrupt and
> > reporting edges. Every lookup allows to specify the key, offset and
> > flags as per the lookup struct defined in linux/gpio/machine.h.
> >
> > The module together with gpio-sim allows to easily trigger kernel
> > hot-unplug errors. A simple use-case is to create a simulated chip,
> > setup the consumer to lookup one of its lines in 'monitor' mode, unbind
> > the simulator, unbind the consumer and observe the fireworks in dmesg.
> >
> > This driver is aimed as a helper in tackling the hot-unplug problem in
> > GPIO as well as basis for future regression testing once the fixes are
> > upstream.
>
> ...
>
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +
> > +     guard(mutex)(&dev->lock);
> > +
> > +     return sprintf(page, "%s\n", lookup->key);
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_offset_show(struct config_item *item, char=
 *page)
> > +{
> > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_lookup(i=
tem);
> > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > +     unsigned int offset;
> > +
> > +     scoped_guard(mutex, &dev->lock)
> > +             offset =3D lookup->offset;
> > +
> > +     return sprintf(page, "%d\n", offset);
>
> Consistently it can be simplified same way
>
>         guard(mutex)(&dev->lock);
>
>         return sprintf(page, "%d\n", lookup->offset);
>
> BUT. Thinking about this more. With guard() we put sprintf() inside the l=
ock,
> which is suboptimal from runtime point of view. So, I think now that all =
these
> should actually use scoped_guard() rather than guard().
>

Precisely why I used a scoped guard here. Same elsewhere.

> > +}
>
> ...
>
> > +     guard(mutex)(&dev->lock);
> > +
> > +     return lookup->flags;
>
> ...
>
> > +static ssize_t
> > +gpio_consumer_lookup_config_transitory_show(struct config_item *item,
> > +                                         char *page)
> > +{
>
> > +     enum gpio_lookup_flags flags;
> > +
> > +     flags =3D gpio_consumer_lookup_get_flags(item);
>
> This is perfectly one line < 80 characters.
>
> > +     return sprintf(page, "%s\n", flags & GPIO_TRANSITORY ? "1" : "0")=
;
> > +}
>

There's nothing wrong with setting the variable on another line though.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
