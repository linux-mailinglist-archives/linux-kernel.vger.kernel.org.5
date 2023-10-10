Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B567C02D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjJJRkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjJJRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:40:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61160CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:39:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50306b2920dso100509e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696959595; x=1697564395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4xZpqEwWtfUV1JgIse7nmPsmTUQIv/zlM1eTbPf9Zc=;
        b=D0BZI28AAuxlKIwt2Y0k5v38edjDTKmuGVqY4uy/m17vCEsvmGEbcvOwDu87+7Zb9V
         0D6uCHCzHrBQJrLK/5KTiArgrqq+0ibHB9va84XZdmlUDh9QtD5GZM4bFuHEeVU9MRMU
         9W8ZS1kPKpa5LoCDSDqj99t1Rb/Oxi4oGfL5BneZuZ+Qtoh1p8Wo7FXn/BNfu4j7H6U1
         dCFQrt9mb7tM9LIVgnURnMzgEAwYMNJvgBPZkR7CP6Ym7oBY4JopAmdrGIsJ2rrCq3fz
         qI+hyUqFE8OS+ZmLzq51i92wjxsPjSMs0LSIA8Ahuer7gRileC0Ia2p9cg2TsMZmWUY3
         34Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959595; x=1697564395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4xZpqEwWtfUV1JgIse7nmPsmTUQIv/zlM1eTbPf9Zc=;
        b=E1TAaZQLbcgjTOFni/wRDOeYd2Jk5tQw0v/jqpvxY+StB2PUlN33t71OVXjw2w9zq5
         6i7BABfbpdIIA1b3faayrp43OJzePiIfhhdJwc5+4FqmSjZzeN693b72sopBE+kgrTYV
         9qg/3lmT7wfu9p4L2a0UAiMdJQyqs9Uxf2qUIpbNaPNnIHtWEYJDwWZR9XA0gtnsERhE
         gkp5KQ86Ovd7INYVDlLCdxO54k7b4HMphlDsS5mC+CZ9CqrkaE/5Cc6xUkEB8lLVro3N
         e0yjv20Tb6G5zFIHQo1grBhA7TUSH37uNLRrEz+M0ULZmkrRFS+3mYvFveoSS/JyDDEc
         kVTw==
X-Gm-Message-State: AOJu0YxdofgFzL+tln29psSZh1QguE2v6OtRhp9JO3Xs5+YcwuYLKNW5
        irbyJy7TyHhvjTZefsHT1mQ8xKggHqWLBlUlEwmcdg==
X-Google-Smtp-Source: AGHT+IGSK51KyaDcnsl41rah8ft25iKVz+wl1YCpS4m2RF+QtVWHG/EMQEczDjGuYeiEzvYsApMjlsD9ch7wMtde8XA=
X-Received: by 2002:a05:6512:3183:b0:503:2879:567 with SMTP id
 i3-20020a056512318300b0050328790567mr13675359lfe.28.1696959595193; Tue, 10
 Oct 2023 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr> <20231009-pxa-gpio-v7-2-c8f5f403e856@skole.hr>
 <CAMRc=Mc7=E9bMQgiUM8qqk7UD4+exhJZqw2DucTcsnqHcttR3Q@mail.gmail.com> <12313687.O9o76ZdvQC@radijator>
In-Reply-To: <12313687.O9o76ZdvQC@radijator>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Oct 2023 19:39:43 +0200
Message-ID: <CAMRc=MdWYNmBkJ6Nw6V_FzJKQw--g02tjLSztMYW_atNhisVpw@mail.gmail.com>
Subject: Re: [PATCH RFT v7 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
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

On Tue, Oct 10, 2023 at 6:33=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:
>
> On Tuesday, October 10, 2023 1:12:05 PM CEST Bartosz Golaszewski wrote:
> > Gah! I should have noticed this earlier but this is a perfect
> > candidate for using hogs. Can you use gpiod_add_hogs() from
> > linux/gpio/machine.h instead? That would save you having the lookup
> > and the static leds descriptor array.
>
> From what I can tell, the hogs keep a certain pin at a certain state as l=
ong
> as the machine is powered on. Is this really what we want to do with LEDs=
 or
> am I missing something?
>

It doesn't seem like anyone is using these GPIOs once they're
requested? Wouldn't the above definitios be analogous to:

GPIO_HOG("pxa-gpio", SPITZ_GPIO_LED_ORANGE, NULL, GPIO_ACTIVE_HIGH, GPIOD_A=
SIS)
GPIO_HOG("pxa-gpio", SPITZ_GPIO_LED_GREEN, NULL, GPIO_ACTIVE_HIGH, GPIOD_AS=
IS)

?

Bart
