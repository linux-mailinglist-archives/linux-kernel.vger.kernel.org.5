Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F62791644
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbjIDLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjIDLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:32:53 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DF184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:32:49 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44ee1123667so1423341137.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693827169; x=1694431969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQKRtUHFzVci803WRJ9k54xaz9oTzes8TWboMdbSJSI=;
        b=sVnKSlXl8fUyRD3LXPz+2jtwQRkYSG7432CIakdSJGbWp+cIZS9tSiG1/4Ti6ZqZYb
         wbQyc4qbKVQts/wviuAb1bDXGo8emhjR4zfI4YnX1nio/k5iPdZ+LVC8ycPR1u4gwHvy
         e4u89RjmHLcpGTZvr+XKPkm+lDdA1OzZ/qNkpk+vI6tWTkqs4SrvN+2v/+0Mj1NZYuRS
         41RhlxDjTWlzrjkEJl3QDLJlGNz64R5+lOTXErvGVc0jrEM6NLv0SjYiuHIGSi4Z4TN3
         nZ/a3aZjhO9N/589D/UGp1D3+7EJE653OrROFU4PK82BWJoUDtUR9bWw4+jcjEsAbjS7
         Xl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693827169; x=1694431969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQKRtUHFzVci803WRJ9k54xaz9oTzes8TWboMdbSJSI=;
        b=S4oEEsOyFrnC5OLMrZlzRnNbr7B5tCDsPfceozmu5Iv2xmCtwNI7QEmbPWIJ/NwvXC
         Fk0AMtG6/O+PEWjlR1lPeUf0w1hGbl5MW0djKhxqspMt4HMFY6E3jL1RCBaJKcaiezBG
         biqv5VMgjgE/RcrpIHn8nsBjizPPcRFS+5bo15qRdmnhz3SDymeqwTGs34aac9lOTbJV
         85S5FCvS72yCsT5Zoj9SKqDu8xrjIWTet5TWH2g36NeVCBeGxTQ/OcEr41LSrW6qEdB+
         4zfiLKZm7II+h7dzYxdlutvS/NA/pfOycVMe6qH+TP8WOP5NrtIHGN0dyWxd/gnrhcoZ
         XnDw==
X-Gm-Message-State: AOJu0YyFfI+SzTQKxLKCHFzx1o/kM2zp8pQYQFdA+6yh6ifm+F+7JQIA
        RlIkDFl/BmdWlv42Tzec2rXjo9Ox7B/FJwzEWDByJx0w3uysF37o
X-Google-Smtp-Source: AGHT+IE9gYx3TedRkReqYbvPg+wBNqM6EZjuMh8x0FFvRfllaDmx1HduHQe/ZsuIW8qnvjFgcSw4Z7Uby+C7l1GIqZ4=
X-Received: by 2002:a67:e44e:0:b0:44d:453c:a837 with SMTP id
 n14-20020a67e44e000000b0044d453ca837mr6247029vsm.11.1693827168960; Mon, 04
 Sep 2023 04:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230903190657.12393-1-brgl@bgdev.pl> <ZPWvJc90rmIAPR+r@smile.fi.intel.com>
 <CAMRc=MdMiMPFvvpAg7DqStSb07Z8L5p0RAmcTimHN8YkcLPV=A@mail.gmail.com> <ZPW9JuahVYSP1I6m@smile.fi.intel.com>
In-Reply-To: <ZPW9JuahVYSP1I6m@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Sep 2023 13:32:38 +0200
Message-ID: <CAMRc=MdzfvnYJt-SkMzYEwp4rKsaJLN_uoBNQ0seuai+im_b=Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: unexport gpiod_set_transitory()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
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

On Mon, Sep 4, 2023 at 1:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 01:14:29PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 4, 2023 at 12:19=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Sep 03, 2023 at 09:06:57PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > There are no and never have been any users of gpiod_set_transitory(=
)
> > > > outside the core GPIOLIB code. Make it private.
> > >
> > > And rename to be gpio_desc_...()?
> > >
> > > With this done,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > The rationale has been explained in the other threads with renaming m=
atters.
> >
> > I'm not buying this explanation. Public GPIO functions don't have a
> > monopoly on the gpiod_ prefix. Eventually I'd love to unify the naming
> > convention for the three important structures that we use:
> > gpio_device, gpio_chip and gpio_desc, no matter whether they're public
> > or private as that's already clear from their placement in
> > include/linux/ or drivers/gpio/.
>
> And I would like to avoid adding confusion by mixing internal and externa=
l APIs
> under the same prefix.
>
> Personally I do not like this change, when gpiod_ is being used. So, you =
may
> override this, you are the maintainer, but then here is the formal NAK fr=
om me
> (as a user of these APIs internally and externally).

This is still inconsistent with the rest of the public symbols -
especially those in gpio/driver.h. My long-term plan - before making
locking great again - is to limit the usage of any gpiochip_ symbols
to GPIO providers (as the chip is not guaranteed to be valid, unlike
gpio_device) and provide a bunch of gpio_device_ or gpiodev_
interfaces for use by those who *really* need it. Now am I going to
make up two distinct prefixes for public and non-public APIs? That
will be even more confusing IMO.

Just like in C++ you don't make up special names for public vs private
methods except for some deranged coding styles that also require you
to name arguments like "in_foo" and "out_bar".

Bart
