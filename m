Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E317929DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbjIEQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354409AbjIEL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:26:49 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C48F1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:26:46 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44ebf4c623eso568672137.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693913205; x=1694518005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC3YFMsJSmvlacNFVM4d9QObfDtxdje+kbFA9klZN9A=;
        b=Fo7ZeVz6+SLZf8/kYHv/gCukM+8SpRVjg1Dt/Ac19XDlN7gxWXRc/q0LDYk9Q8ctHm
         EnW8puomAADwvkvC4BzbxZymUrsNpxcCgIkEAjF8U2N+N8x8CqKTWjgYT7h5kkf6meo3
         4gnmGXaB/9vAMgjAairuKZnH5Ilur5Ya8Y3L2MqR0pHPgqrWB96RkcBI5bndx77fphLq
         3wXooWoUzi5vCB9CkbkUqddhVnKW6kPD4pdY000VUrR+SVOhYgWHdco6IZLUFLHL6UuH
         tLEio4H28doASHy0HUPiCLjv6NVQnZxve7k63j5Q7n2ca5bzg8z0a/xUlFeRXdSX4cSv
         96Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693913205; x=1694518005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC3YFMsJSmvlacNFVM4d9QObfDtxdje+kbFA9klZN9A=;
        b=BjJC+LLzxbveA35fx6+lVjWpAOL/dtpL9Och0SrO7hakQQyLHmz5hbbplp5tVzlvJK
         hNOshagRdfuS/XRGny0WgKM/KjnkHodMiNs+u7xh+vSdxDPqTOYgQuRLWXIms3LDwYZi
         J5nizU6O31u48Q/mw/uH4B0AqQYvYnbWiNE7I7/EkUo0jjAIxB0mZHbJggfY7GCFTorj
         3YyFdvNpEJ6Y/TbeSwkqSRm9+i9iY+G9g0fAxkEgTe97rzW0ubj+fhaetrYsZ616T53o
         Ww1mxtoMSgMoFaJuedfTtm2N1uFk/6aWgaKCb5WfwkB1k8rRhJCYDtudhMl3TwW7SR+E
         icLg==
X-Gm-Message-State: AOJu0YxgJiqmVkhH7uext0e1maqb5QRyGyu1ag+8v+hnsHxQcOCRiXVv
        g1L8XWcy6eaiivCsHCMhROmM6Iiv0Kp0rCNN1IQtNQ==
X-Google-Smtp-Source: AGHT+IGWKBuS/CgJoZ15ah67m0Cnr8Fe9lpMBdsC8lcKBo1P/kb7K67la8xwEvkJCglO3I3uGuGvey0sJpB0suOOY3E=
X-Received: by 2002:a67:cd8d:0:b0:44d:6320:b713 with SMTP id
 r13-20020a67cd8d000000b0044d6320b713mr7909008vsl.0.1693913205119; Tue, 05 Sep
 2023 04:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230904073410.5880-1-brgl@bgdev.pl> <20230904073410.5880-2-brgl@bgdev.pl>
 <ZPWjAUzqeAwF1wro@smile.fi.intel.com> <CAMRc=MeMYi0KbK=1RYGX2zbUjVZyQp-Y_aXfy6+EZcEtUSEU0A@mail.gmail.com>
 <ZPcEFXF9Fz762kzK@smile.fi.intel.com>
In-Reply-To: <ZPcEFXF9Fz762kzK@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Sep 2023 13:26:34 +0200
Message-ID: <CAMRc=MctTGNe2v8bBKQp6Dh3EuhP+OmO8yxrMgrHT3+m2AGjnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: rename gpio_chip_hwgpio() for consistency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Sep 5, 2023 at 12:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 05, 2023 at 10:37:32AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 4, 2023 at 11:27=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Sep 04, 2023 at 09:34:10AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > All other functions that manipulate a struct gpio_desc use the gpio=
d_
> > > > prefix. Follow this convention and rename gpio_chip_hwgpio() to
> > > > gpiod_get_hwgpio().
> > >
> > > Same comment. Also, I don't think it's good idea as it steps on the e=
xported
> > > API's toes. I.o.w. I won't mix those two.
> >
> > Even if I agreed with your other comment, gpio_chip_hwgpio() is a
> > terrible name and if I didn't know, I couldn't tell you what it does
> > just from looking at the name.
>
> That's can be improved, my previous comments were basically to avoid
> mixing prefixes for internal and external APIs, let's say prefix them
> similarly, but for internal with space and/or more verbose naming
>
>         gpiod_          gpio_desc_
>         gpiochip_       gpio_chip_
>         gdev_           gpio_device_
>

There's one more possibility. Have all exported symbols be prefixed
with gpiod in one way or another and the internal symbols just drop
the prefix so it would be like:

gpiod_
gpiochip_
gpio_device_

and

desc_
chip_
device_

Because for internal symbols we already know they refer to gpiolib.

Anyway, I'll drop the patches for now and let's revisit in the future
when the consensus is reached.

Bart

> (as an example).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
