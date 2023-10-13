Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739BD7C7E13
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJMGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjJMGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:50:51 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE95E1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:50:49 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b2ca45d5cfso902006241.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697179848; x=1697784648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+21d47K5pMKUUp+ZZCwfOqG7e0i0/Qbr9a+Z9J91e90=;
        b=1gD/aYlmA5tguC/7wZbdgXm6yj6Jkt1on3VVnC3meMX0Mt6OFGpGWakVr3vheUBbCb
         VRDXBzd2fUzO06/ul8kuSyUg/2ozbnQVm8o2CAjz404b4aEx/iMfpri+Y+/rEHMr1Gko
         TaWpJ5zAd5h0nNQWETAhuL6aLCnOx5sBR7ypH4HAHE0XI/Ld8QdoDNT+3cZjjP5Kdlyu
         MSWSmUJzp3vr9VVKfM9r4pQYjgyvA/9mHDSGA43uYOYaVEC6XCBXWbIulyjuvfpHT7PQ
         QOgLFlGWQvWrsdC+zhMfo8uAabjKJ9npT0OfSM1mrj/ffGUNbszOp6A5WNSm1r6PaFFx
         l+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179848; x=1697784648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+21d47K5pMKUUp+ZZCwfOqG7e0i0/Qbr9a+Z9J91e90=;
        b=RyQRvbMFNR5Uzh5fGmIYTuL8as8hQw+fUMEYJXkAdB1gLS8z7eEtkA/1ludgFLk8Hw
         twIRo2jVGL9XeMYiRtis2jLgu2hM9J6U0xg4zrofBtnp9tpcbLrs5jx2trr9L097Ynv2
         WYQwLg0t+bZKRkkZCveMiDMCUwPEAsIlPFvSDe14oY5peat9T/6ybs1RJETgCIYfoPwn
         KGZduR/0mUKRtHiGvlgHc7I23obrjiYpM5MXKnHkxjtFCT8Nr6N5hKKah6g4J4F6sBf7
         r+X4QCO6hOwwbcQe+in3KB9nxyx41/sYppsZSvrLcW4jWV8pQACrGOKjnqrbv1wLvoDb
         zVhA==
X-Gm-Message-State: AOJu0YwouocZKs9QXPE41vLGSaJURI38IcFBkN0ABYOy6bQKkWm30nXZ
        I0ln3z4CaAyZ3hb67npa6ton/RORqP4YgeAFOq4fYZhAoisvap65
X-Google-Smtp-Source: AGHT+IGUPPVDzkY+t6V7na/IoGgX3NTGckYGIbPTAIBlmkhFGXFHY0fa90vJx5ZFBdKtS4pGD5mDtMUpnJLiElATz+A=
X-Received: by 2002:a1f:e2c3:0:b0:49c:37a1:2358 with SMTP id
 z186-20020a1fe2c3000000b0049c37a12358mr21402810vkg.14.1697179848192; Thu, 12
 Oct 2023 23:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231011130204.52265-1-brgl@bgdev.pl>
In-Reply-To: <20231011130204.52265-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Oct 2023 08:50:37 +0200
Message-ID: <CAMRc=MdxF-0TE2uTOCQU8XJdgtQf_8t_yZPd2+xbF6_0WUmSGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] i2c: mux: don't access GPIOLIB internal structures
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
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

On Wed, Oct 11, 2023 at 3:02=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The backstory for this short series is that we are identyfing and
> removing all unauthorized uses of GPIOLIB structures across the kernel.
>
> For example: there are many users that access struct gpio_chip when the
> only user allowed to safely do this is the provider of that chip.
>
> We are very close to removing gpiochip_find(). Another function that
> poses a similar problem is gpiod_to_chip() which also returns the
> address of the underlying gpio_chip without assuring that it will not go
> away e.g. due to a hot-unplug event or a device unbind.
>
> We'll need to replace it with gpiod_to_gpio_device() across the entire
> tree. Let's start by actually providing it and adding the first user:
> the i2c-mux-gpio driver which dereferences the otherwise opaque struct
> gpio_desc.
>
> Let's also add a helper that allows to retrieve the address of the
> struct device backing the GPIO device as this is another valid use-case.
>
> Finally, let's un-include the GPIO private header and fix the code to
> access the device in a safe way.
>
> As the change is pretty minor, it would be best if patch 3/3 could be
> acked by the I2C mux maintainers and went through the GPIO tree.
> Otherwise, I can apply patches 1 and 2 and provide an immutable branch.
>
> Bartosz Golaszewski (3):
>   gpiolib: provide gpio_device_to_device()
>   gpiolib: provide gpiod_to_gpio_device()
>   i2c: mux: gpio: don't fiddle with GPIOLIB internals
>
>  drivers/gpio/gpiolib.c           | 38 ++++++++++++++++++++++++++++++++
>  drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++-----
>  include/linux/gpio/driver.h      |  3 +++
>  3 files changed, 47 insertions(+), 6 deletions(-)
>
> --
> 2.39.2
>

Queued for v6.7.

Bart
