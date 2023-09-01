Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1941578F936
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbjIAHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:40:26 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE5E7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:40:23 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d167f6cffso606920e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693554022; x=1694158822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdSEnSSizczTE8HJIRHe+3r0VQs218gZ30sV8UlBVvo=;
        b=yZA8qyctQFfw3y8c3bJ/tEmiiWf7nsBvhdEKU8qSr1pvETfeX53fx1Bi8QUCXvz8mj
         c/m9YJZk/vvWIDLpDyDzs+qfQGC+eksxmZISEU5l32P5BRP99YCNjfzyvEHOAD1GCIXl
         js9MWZMHU4KDcdtPkoEqel2t+QNHdRCfq6fyUvTxomKHDRqjMcHC7YR3P4rOwhlyuqaJ
         OAp7gHf6OedwMF28BRAeagTHzSyLtbc+pWGCi1EkSQQjDC1rXNrj8jb/LhITyfxAPXLQ
         FUKiLC3Qrow90wTEV9nrPIzXcxb9AuA7/jRhGOW/Hpq6WgA4bXvoIbuA6TUNIi8P+Xim
         lYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693554022; x=1694158822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdSEnSSizczTE8HJIRHe+3r0VQs218gZ30sV8UlBVvo=;
        b=TzJkxskjsdAyrCJBRWGGvlqDH7wzjcAgJjglhM25+IR/ntsOxDecQJXlQjikOgq6NI
         zqrwiGOh2KgpzvUB3aMcn7OzWcjl81YOJYKUqwJTh13GKqe88Fk/tW4SJBmCyCyUupL/
         cnutQVgZvecGKCAxC6I5t2AENgX9bM4GKzB9ga1S44XtJesxmW3XB8sspe5nb9Ur8gbm
         Sc7NYMBQzlJPadMI/IMRzZjmyTYhsUi1oTayYxa0lgQi/pRQN8WM5/gVrqdAZhWSIhKa
         zWjPBsJDQHxR5Ozc957vLox5BOD4K0C8sftKRQFNacDMXqBTZidNDcZNJ0JstlTg9XWR
         flPA==
X-Gm-Message-State: AOJu0YyOQyVqqsSV3x7fz/7awiHh/GFlv1eyRcdXM+RTPPCsmiIqqjne
        35eIxVuakhGzx+U6a6yxrQtcZiPOStNCQQUTJIM1/w==
X-Google-Smtp-Source: AGHT+IF4/dIUb/yBKlSH666awkw3CGUYKSZGAkFwNTY7ILWywn+c24x4A5D+cmyWsgAnTqUbFGhsKHxztcUzGlh/8wc=
X-Received: by 2002:a1f:df01:0:b0:48d:bdd:9913 with SMTP id
 w1-20020a1fdf01000000b0048d0bdd9913mr2102598vkg.12.1693554022565; Fri, 01 Sep
 2023 00:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194934.19628-1-brgl@bgdev.pl> <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
In-Reply-To: <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Sep 2023 09:40:11 +0200
Message-ID: <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
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

On Fri, Sep 1, 2023 at 1:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 31, 2023 at 09:49:34PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Currently the bcm2835 SPI driver uses functions meant for GPIO provider=
s
> > exclusively to locate the GPIO chip it gets its CS pins from and reques=
t
> > the relevant pin. I don't know the background and what bug forced this.
>
> ...
>
> >       /*
> > +      * TODO: The code below is a slightly better alternative to the u=
tter
> > +      * abuse of the GPIO API that I found here before. It creates a
> > +      * temporary lookup table, assigns it to the SPI device, gets the=
 GPIO
> > +      * descriptor and then releases the lookup table.
> >        *
> > +      * Still the real problem is unsolved. Looks like the cs_gpiods t=
able
> > +      * is not assigned correctly from DT?
> >        */
>
> I'm not sure why this quirk is here. AFAIR the SPI CS quirks are located =
in
> gpiolib-of.c.
>

I'm not sure this is a good candidate for the GPIOLIB quirks. This is
the SPI setup callback (which makes me think - I should have used
gpiod_get(), not devm_gpiod_get() and then put the descriptor in
.cleanup()) and not probe. It would be great to get some background on
why this is even needed in the first place. The only reason I see is
booting the driver with an invalid device-tree that doesn't assign the
GPIO to the SPI controller.

Bart
