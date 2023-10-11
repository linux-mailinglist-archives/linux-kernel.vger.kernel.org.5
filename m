Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334DA7C583C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjJKPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjJKPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:39:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6BEA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:39:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7afd45199so32469977b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697038780; x=1697643580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6TGfEyuvebEaZWUEyk1hloX7p7Dxc5o+Os6nRYfszo=;
        b=GKXU7aHMZbeUt/6olc/O7S9ViGQAWK+gccLEvbvxJA3XyvoOwSIALXLQODvO+V3PBo
         ruQohI6UqYYi39Q6lMf2Ko7EQoejFP6BYtyjhGrUpedSrbpx0CKP9YQFoE9l+1paqw8o
         tMBhGFWMqVoR4fvkT1ZSbPKP7UP38UwZIvIubP1hZICPd0tJgAowI7X6Is1buIpYKOTs
         V8ox0uxBMy1GxHmZTB4JlVoUVqn14IUTtp08Gb5fbFSXCWtwiD8qKRx+GoQJtpNEgeWU
         Tjx6uR/yGNPc7XM+jXYsqRmDuKlABhNVdiv3oaEnk6XNpGIM7XUM0XuLfjLpaQtuOylO
         Do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038780; x=1697643580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6TGfEyuvebEaZWUEyk1hloX7p7Dxc5o+Os6nRYfszo=;
        b=jle6m38jemC1fUPUVdDnYQP5NOn+V6yOM0WTWzbfOFE4WhY34YU3zvmZGyMTFLuLES
         MDvXHUIubn5VRCetm0yYy0o1w5dqBgZGKf6v659ItoVOsXdw3KnrbgzfeOA8a9RGmLAw
         /0H+9X4emiBVKTgFYYXEwYFFNplLx3qBFcftZJ26M/wPwM++Pc2NmH4qDqKz3F/QynpD
         4Dihan99FK8M1TyCF334vcz1BQBCMB27ADiZ6bd0CbCOvmpYN0e9qBHqNfLHPSTBmi1z
         M7k7Sos428HoblNCAkPvfbDZcXXCt35OdWKz0ITnGPVH9zRfMomJhW5HBRtRf+I9Ju3l
         gTTw==
X-Gm-Message-State: AOJu0YxkZTXplclNnBvCjrDpYcRkcyuloLC1egsrgayVzBp6OTOgMCGK
        5mtdwxAkuMcvaBfWuMKZZQtnCP7AUqsJExPqhtc0tA==
X-Google-Smtp-Source: AGHT+IHNy4ujK7ZBjaTedMwtwhKKTRRoQvdHX8r5Shdstx65sswCfVmN1phjaC0SnvMmMIdAiccUCCAdyYoYsU/BmmY=
X-Received: by 2002:a25:8d8b:0:b0:d78:1724:1b1a with SMTP id
 o11-20020a258d8b000000b00d7817241b1amr19199871ybl.37.1697038780668; Wed, 11
 Oct 2023 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231011130204.52265-1-brgl@bgdev.pl> <20231011130204.52265-3-brgl@bgdev.pl>
 <CAHp75Vc2vGEYmbaurzEoh-ejkvFwGeo98LtAGvEq5idXNPgnRQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc2vGEYmbaurzEoh-ejkvFwGeo98LtAGvEq5idXNPgnRQ@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Wed, 11 Oct 2023 17:39:29 +0200
Message-ID: <CACMJSetxih3kwAVDpQNm_fApgdkOv-XfErqC8+hi7Nac4J+ZOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: provide gpiod_to_gpio_device()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 17:23, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Wed, Oct 11, 2023 at 4:02=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Accessing struct gpio_chip backing a GPIO device is only allowed for th=
e
> > actual providers of that chip.
> >
> > Similarly to how we introduced gpio_device_find() in order to replace
> > the abused gpiochip_find(), let's introduce a counterpart to
> > gpiod_to_chip() that returns a reference to the GPIO device owning the
> > descriptor. This is done in order to later remove gpiod_to_chip()
> > entirely.
>
> My concern with this API is the following scenario:
> 1. One driver requests the GPIO descriptor.
> 2. Another driver does take an arbitrary number, converts to a
> descriptor and calls for this API.
>
> Is there any (potential) problem?

YES! And I have it already on my TODO list! But it's great to know I'm
not the only one seeing it.

Basically we need to

The end-goal should be to make gpio_to_desc() an internal GPIOLIB
symbol. There are still around 10 users outside drivers/gpio/ that
will need to be addressed in one way or another. Preferably by being
converted to using descriptors.

Bart

>
> --
> With Best Regards,
> Andy Shevchenko
