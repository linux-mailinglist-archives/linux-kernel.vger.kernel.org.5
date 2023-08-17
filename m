Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17F877F6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350993AbjHQMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbjHQMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:53:17 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244792D7B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:53:16 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79da1a3e2e2so1547916241.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692276795; x=1692881595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVD91ng2nzcZPCmLCAjFsthLokOGG3l7sW97wTnzFb4=;
        b=xKOvdCqFREmUVQ7/uVf2xKJsPIjx6VBhZFAl9jn0MF51UBFkhmqafjtz+syFSIUH0J
         j2zbdAMVh4D266HtEyLtHziWnYbSqPpEun9zbdl2yAMxWQjNAXbr13Y25ghze2HbrpOh
         lyBqSWCn89Rde0Sko3E2Ok6Ey5gjeCL4BQWqYKt7XXv6LLSeO8rH9Cr1dVb7xSFmU6WC
         aAm91B07hgqVfL2uSIgPQOwIbaKhskfjxlhxDjzctDeuyrGO9ZHM+uFg/Ifzu/l9xzWc
         I6hYUC3+wWWJRuKR8EYEXuqZlj0v6aeQQzo+t7KmGHQHqRdxZFokYrh5Dp1ozRpDs74T
         RaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276795; x=1692881595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVD91ng2nzcZPCmLCAjFsthLokOGG3l7sW97wTnzFb4=;
        b=SldfNr4/u8A3xLHA9+CZrlITb3KhN/31t+3eKiBMesIqqC6BCjkUmWc5zLg1IDLFM5
         qDdiZG/qQlgYQdzqs5U/BwaHR4IycxMSeZyn1u6zZ0iK937ZN1vsarEf946iKLe8MBGk
         r+ANFJHfslJVpItRkrU1g58wu5cvuFgR3uOtvydDbWpCNim+NjRchIa6ycrdr3AHFiBb
         uq0OZ+ZMNgLStaf+P9Z2g3BkEAkIhtZdg0y+bNyZrMJdue/zWlUyMhTIqzS1QI1IEfrU
         KOFsQchuW9iMviX3TNghcTPkI2QKobRgIK/9bUkzVvhVu+finy9Hm5QYrUbd8djBp560
         fRwg==
X-Gm-Message-State: AOJu0YxyPOgLC9keToqKZYkugpfoZx2QwXkELnIoeU5u74Ce95O6oUH8
        pl0rk3YY9ms6cZTjVFVdNkILZfgQ3vgeaHnp0PmtpA==
X-Google-Smtp-Source: AGHT+IFSUhaVs6YKTpmeJQ1phY3olcaJRC5TEgoTSVm1DV+rjdpc4ovNIBYb9NvX7VbrxR/M1Bjd/lh926f5uFxRVS8=
X-Received: by 2002:a67:e456:0:b0:447:ba75:9c81 with SMTP id
 n22-20020a67e456000000b00447ba759c81mr2775608vsm.28.1692276795222; Thu, 17
 Aug 2023 05:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230815185650.152968-1-brgl@bgdev.pl> <ZN3wauUBENDd7aRU@smile.fi.intel.com>
 <CAMRc=MdUWXZVnjkPqH2BZvDY0v-OOysQ=NMjwQEi1rt+16NEQQ@mail.gmail.com> <ZN4U2u9h0vVNmf9d@smile.fi.intel.com>
In-Reply-To: <ZN4U2u9h0vVNmf9d@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Aug 2023 14:53:04 +0200
Message-ID: <CAMRc=Mds_PC8xO25HfjGbAP1LTqop4vkuz0OPHbcx9UO7QFF5A@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 2:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 02:14:04PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Aug 17, 2023 at 12:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 15, 2023 at 08:56:50PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > > > +
> > > > +     guard(mutex)(&dev->lock);
> > > > +
> > > > +     return sprintf(page, "%s\n", lookup->key);
>
> (1)
>
> ...
>
> > > > +static ssize_t
> > > > +gpio_consumer_lookup_config_offset_show(struct config_item *item, =
char *page)
> > > > +{
> > > > +     struct gpio_consumer_lookup *lookup =3D to_gpio_consumer_look=
up(item);
> > > > +     struct gpio_consumer_device *dev =3D lookup->parent;
> > > > +     unsigned int offset;
> > > > +
> > > > +     scoped_guard(mutex, &dev->lock)
> > > > +             offset =3D lookup->offset;
> > > > +
> > > > +     return sprintf(page, "%d\n", offset);
> > >
> > > Consistently it can be simplified same way
> > >
> > >         guard(mutex)(&dev->lock);
> > >
> > >         return sprintf(page, "%d\n", lookup->offset);
> > >
> > > BUT. Thinking about this more. With guard() we put sprintf() inside t=
he lock,
> > > which is suboptimal from runtime point of view. So, I think now that =
all these
> > > should actually use scoped_guard() rather than guard().
> > >
> >
> > Precisely why I used a scoped guard here. Same elsewhere.
>
> So the 1) has to be amended then.

No! lookup->key is a string stored in the lookup struct BUT protected
by the consumer device's lock (it must be or else the lookup could get
removed while it's being modified). Unless you want to duplicate the
string in order to release the mutex earlier, it has to be locked
until sprintf() returns.

>
> > > > +}
>
> ...
>
> > > > +     enum gpio_lookup_flags flags;
> > > > +
> > > > +     flags =3D gpio_consumer_lookup_get_flags(item);
> > >
> > > This is perfectly one line < 80 characters.
> >
> > There's nothing wrong with setting the variable on another line though.
>
> Why do we need 3 LoCs instead of a single one? Do you increase your line
> statistics? :-) I really would like to know the rationale behind this.
>

No reason. It's just that churning out new patch versions changing
minute coding style details is not conducive to "getting stuff done".
At some point the code is *good enough*. It will never be perfect.

Bart
