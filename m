Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB40D7D3602
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjJWMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJWMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:02:20 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C521AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:02:18 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49b289adca9so1168388e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698062537; x=1698667337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV9S8Dl1QFTNoTqt6zU/0XcXKKZm0RVI8YwTgV3zwuI=;
        b=RlzmMQaXlHo6k3AQChxwTd8URqjxvdveJdiNWjwVJYtUdpwEs6yfw07BH6PNAW548i
         Ynjbr8CjuIIsv7I4eiR63d7m9b+2cxD/iHg8IpCMzhEE9eR4RUwSVDBPsNLTDCky+HDO
         JTWkrWEO0IULfra4yg59U1On55k158x4xNTEE1KkvfBsgP21tyemyYTIF5cVFzQ+Rlh1
         Ny2aWjEmyVrbozWLFcsbuss0Qsgig+RbJ6mYtKIt/YjnO8vs/g8RZ5H4gZA8o+wDIkAC
         J1q7oX+bGQw96XIttd+QZmFB3idi6oGRKbTqHhiJ/vKK2gZdOq+zJwj3I9zmLh8MngEb
         wGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062537; x=1698667337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV9S8Dl1QFTNoTqt6zU/0XcXKKZm0RVI8YwTgV3zwuI=;
        b=CdqzUUwMz5zm58Ly9rZ4iDzNhlf/Pc3zrFXq1QEu15UXywhYo8lqHYcVsvSVM0ctJu
         aUHxsnggHewQrCVXyJsrDQHaZFv7a4h0lKiLajuYxT6pLvFBHOUW8exTYpIsxYLV+Y11
         hy1Xy8of0T8dPFzzxNpm1Tmh1fwqru48FQ6VbIPo9vUnJ+eHLmY6ofKiI55sXqODoffi
         /hR72+74VXRJrSfeiLZ19Ve0UoVBd34TEKhg4sWoiWAVZoVhYdZKo929LYK8LhHgFdK8
         9RI8Cn++hhe4uaANcX20KSzOhK0MKTBeekXT4mXqC+9ku/1U2/8aRC+/Kex1Lfp1TYYM
         DzTA==
X-Gm-Message-State: AOJu0YxH8/oMlRbYa/olRVAe5ZqYOeaW6KCACnP2/LUQc57W67Ihy1Vi
        E9+6vwGERlkS0Izbm9emgPowBzQbmuUwlMQRflnigA==
X-Google-Smtp-Source: AGHT+IH6TOp8anEI3dc3+ZGWts26YrV2cbzK9P5VunniwZKaSBSFLIWnU9EDk0SITpYbVx8W2UYUyUZnG5nwjipSgOY=
X-Received: by 2002:a05:6122:1d42:b0:490:c49e:3fe0 with SMTP id
 gd2-20020a0561221d4200b00490c49e3fe0mr8110182vkb.11.1698062537379; Mon, 23
 Oct 2023 05:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231023115646.3573494-1-arnd@kernel.org> <CAMRc=MdoRWn_grWoKWagAi11S=mZ9RbP673L77a+qfN_8oTBcg@mail.gmail.com>
In-Reply-To: <CAMRc=MdoRWn_grWoKWagAi11S=mZ9RbP673L77a+qfN_8oTBcg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Oct 2023 14:02:06 +0200
Message-ID: <CAMRc=Mc7PCEimVEJ_JYg=4+X5PAJ1Lh2SxXsNEFpuKctbEPiYg@mail.gmail.com>
Subject: Re: [PATCH] hte: tegra194: add GPIOLIB dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, timestamp@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 23, 2023 at 2:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Oct 23, 2023 at 1:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The driver started calling into a few interfaces that are part of GPIOL=
IB and
> > don't have stub implementations otherwise:
> >
> > drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
> > drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of funct=
ion 'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=
=3Dimplicit-function-declaration]
> >   424 |                 line_id =3D desc->attr.line_id - gpio_device_ge=
t_base(gs->gdev);
> >       |                                                ^~~~~~~~~~~~~~~~=
~~~~
> >       |                                                gpio_device_get_=
desc
> >
> > Add a Kconfig dependency to only allow building when this is defined.
> >
> > Fixes: dc850faa28ee0 ("hte: tegra194: don't access struct gpio_chip")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/hte/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> > index 083e67492bf2e..641af722b555d 100644
> > --- a/drivers/hte/Kconfig
> > +++ b/drivers/hte/Kconfig
> > @@ -17,6 +17,7 @@ if HTE
> >  config HTE_TEGRA194
> >         tristate "NVIDIA Tegra194 HTE Support"
> >         depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> > +       depends on GPIOLIB
> >         help
> >           Enable this option for integrated hardware timestamping engin=
e also
> >           known as generic timestamping engine (GTE) support on NVIDIA =
Tegra194
> > --
> > 2.39.2
> >
>
> Thanks. None of the new interfaces are "consumer" APIs and are not
> meant to have stubs so depending on GPIOLIB is correct here.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Ah, this goes on top of the patch that is in my tree so I'll wait for
Dipen's Ack and apply it.

Bart
