Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEC77D1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjHOShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbjHOSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:36:43 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D11BF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:36:40 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-79b4d2c0621so1224365241.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692124599; x=1692729399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/gm8VIirKbWjGg9AYjZNZ2Y5WKF3yMdSVTPVL+vjiw=;
        b=ujspkdT1OIXfCPUwFoFmCSSRKm6PA4kuPPOyaMRM+Fc0fbuPxEHaERoW8gaOMP7ccg
         ckpBOzTtlu7A9GdzV1qHhRpYVxn+UMiHHePNbGw36CfKKWNJU1nVB2W+KEiYPP9goGA9
         QYnVp8t98FdiyfL/PyucZLQ8KiFv5Pv/IQivpWiqQQ0wB7bJJAoSzJttWnbJVgt+Csin
         jDX3PrWAiSp60QJktrMEBDCH2v+trP6duw3Ymw8EWyX6F7tAbB5lhLm/d0LTqmfktozU
         c7rUBteZQ7FPEBRRxtMg7EqBf8v5LOYVi7YM5gyY368T4QbxQkp23jlIjUAjpMKYL/Gt
         9QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124599; x=1692729399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/gm8VIirKbWjGg9AYjZNZ2Y5WKF3yMdSVTPVL+vjiw=;
        b=hEVQ6bTi1M6Lg9DwZr+EEixqVMD4GAJC24JmvLoVT3J9T91Ek2A3OUrBmhYsK2YrtY
         5D723SHBeKP6caSCviHMivG6BGn76jb27yueasKMYC+20VVuM6K9/WUVGZK9+TtgVtOf
         fATkZkAXgleMXQZT8DAyExD27auYq80fA1/atHGBe6NKLyRiqSpaJSlDtRw9H+96nSUT
         hP342+exOETxgPgM2ZGuS9s/1152nRqbAbaXW8tG1PfXyWS5vRAd7UBgQSLNSHM0iMli
         sn7mql0esjIOZunZ8E5PVzztdo6hZY+bO51U6KTMZ6zl18CMq0VykH3uCdhiAa1vMUE5
         v5Zw==
X-Gm-Message-State: AOJu0YyHAaFpfpDAKn5xJlS5Kx021rAccm3wXY08sXmaYwznaZwx7fbY
        +2o3ol1xS+Wcy2NPP5WbVVIeRxOizDL6HkWAMLl4ww==
X-Google-Smtp-Source: AGHT+IFtjjbPMjPhm6f5tF/yhZPrDpjCdpsgVcUVVPtJ+VOaYBLmCOprQT7FJ8jVCneyB51Pf1pxVYaClhP8OSkqQRs=
X-Received: by 2002:a67:db85:0:b0:443:571d:c947 with SMTP id
 f5-20020a67db85000000b00443571dc947mr9389575vsk.24.1692124599093; Tue, 15 Aug
 2023 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230811193034.59124-1-brgl@bgdev.pl> <ZNtKQlnQxFediB0J@smile.fi.intel.com>
 <CACRpkdZ32gW3YgQKPbWTnoRwxjXkViendGMhrAxfyp+W4NbqkA@mail.gmail.com>
 <ZNt2KQMtpMdK9TyY@smile.fi.intel.com> <CACRpkdbij=8NMVodezEXG-rtiBzp1q_fecizYtda4HbDXheu8Q@mail.gmail.com>
 <ZNuPKf8NqcgcuGSd@smile.fi.intel.com>
In-Reply-To: <ZNuPKf8NqcgcuGSd@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Aug 2023 20:36:28 +0200
Message-ID: <CAMRc=McU9-5u=OWDFRF-eaE62ZOnRsEAPg2fokkBGOYGqZ3SoQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: fix reference leaks when removing GPIO chips
 still in use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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

On Tue, Aug 15, 2023 at 4:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 15, 2023 at 03:07:50PM +0200, Linus Walleij wrote:
> > On Tue, Aug 15, 2023 at 2:57=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Aug 15, 2023 at 01:40:22PM +0200, Linus Walleij wrote:
> > > > On Tue, Aug 15, 2023 at 11:50=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Aug 11, 2023 at 09:30:34PM +0200, Bartosz Golaszewski wro=
te:
>
> ...
>
> > > > > > +     module_put(desc->gdev->owner);
> > > > > > +     gpio_device_put(desc->gdev);
> > > > >
> > > > > So, if gdev can be NULL, you will get an Oops with new code.
> > > >
> > > > I read it such that gdev->chip can be NULL, but not gdev,
> > > > and desc->gdev->owner is fine to reference?
> > >
> > > Basically the Q is
> > > "if desc is non-NULL, does it guarantee that gdev is non-NULL either?=
"
> >
> > gdev->desc is assigned in one single spot, which is in
> > gpiochip_add_data_with_key():
> >
> >        for (i =3D 0; i < gc->ngpio; i++)
> >                 gdev->descs[i].gdev =3D gdev;
> >
> > It is never assigned anywhere else, so I guess yes.
> >
> > We may also ask if it is ever invalid (i.e. if desc->gdev can point to
> > junk).
> >
> > A gdev turns to junk when its reference count goes down to zero
> > and gpiodev_release() is called effectively calling kfree() on the
> > struct gpio_device *.
> >
> > But that can only happen as a result of module_put() getting
> > called, pulling the references down to zero. Which is what we
> > are discussing. The line after module_put(), desc->gdev
> > *could* be NULL.
>
> Yes.
>
> > But then we just call gpio_device_put(desc->gdev) which is
> > just a call to device_put(), which is NULL-tolerant.
>
> But gpio_device_put() does not NULL tolerant.
> So, oops in this line then.
>

No. struct gpio_device is reference counted and as long as we get the
reference counting right - the descriptor is guaranteed to hold it and
only put it when it itself is being destroyed. In other words:
desc->gdev cannot be NULL here and cannot be junk. If it is, then it's
a programming bug on our side and we do want to crash and burn so that
we can catch and fix it.

If you think more comments are needed here, feel free to add them or
I'll do it at a later time. I don't want to delay this patch any
longer as it's one of the issues we need to fix to make driver unbind
great again. Unless you see an issue with its logic, I want to queue
it tomorrow so that it gets built in next and send it upstream by the
end of this week.

Bart
