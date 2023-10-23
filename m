Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B87D35FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjJWMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjJWMA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:00:56 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295D5FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:00:54 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d39f07066so1420248e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698062453; x=1698667253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXG6D39H/bG+JdWvKirNbcyn6AT+8IVB18CJ9gYiVCs=;
        b=egqY1pedlC9mH+z3URUaxgggJM1qw406AQh1dW8If1gx4Yw+kHP5TuaY8BVH4gEfwy
         561BReRAmDTmgk9Q4vlA30tdmiUcQNUcCwAOCSF0cO7QIP8YlIC0QsprYIxGmIrz24vK
         Z/R8VoitMd0LJo/QgZQ3YZjjD9jc3U4hxJUvkWGL13GYq5NDv1jsvb6Ab9/GJ8d0l3wl
         xFIoU9iT55Ng8DsJMNFaeSPrObyOlKCfYSC0hW920ImDLCNVWZd/GYe3FsVUCArScPGj
         z7TVPkO8b+vdPk8JINO9qpfkPdlLzyyKutPqkTGtR5nikL+YB2QvTnuyyj4ae0Fs7KYz
         wB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698062453; x=1698667253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXG6D39H/bG+JdWvKirNbcyn6AT+8IVB18CJ9gYiVCs=;
        b=oEnKmhZzjlPgMMPcAkR3gPZNZ9Eg8OKPWlZZzf6bHpnt5/ALGwOwcKu85pXd0PUClm
         tFoobeCf2uAyCRe5Lt2kroEtA08aPn8ntSVB0VYanlJAKeyGdG/FD+3hSPc3bJAgwKMP
         VxuaJ3TvjXkCsp+Vq/IpPyGTzpvvnDIACtujwbxDLT0V1WiTATCBQLvAUbIP24xmyqfA
         xd/6j8OM4Hmz8lWO3ld8PasEbsVPKKLr/yUY7wINvu+4vUEOrIMN+DcoOmCNwBNxfF6n
         Rhvd1OsGcfaPktOa9V3jRbkjJiVBSFeNJm7QCancOjaIBiXO+uZ/kn6wZZmIrrWyAek4
         B46g==
X-Gm-Message-State: AOJu0YydUEPepJMRNOWaayJpDJ7Hgrk0n/m3zhTGOmO3ssAmZOLIf5Za
        eWEQBINVeiEevCny63VSrilUMJ7oaB/YMCfz971EYw==
X-Google-Smtp-Source: AGHT+IEGXz1mVss0Wa0MXPTI7LAnBw2Bts58E0ff225vnT/BeF9e4M6TFlY7QUUnrcU56mmYn06MkCpd1A56MG+2bAA=
X-Received: by 2002:a05:6122:12f4:b0:49d:10ce:9a8b with SMTP id
 k20-20020a05612212f400b0049d10ce9a8bmr7783435vkp.15.1698062453198; Mon, 23
 Oct 2023 05:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231023115646.3573494-1-arnd@kernel.org>
In-Reply-To: <20231023115646.3573494-1-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Oct 2023 14:00:42 +0200
Message-ID: <CAMRc=MdoRWn_grWoKWagAi11S=mZ9RbP673L77a+qfN_8oTBcg@mail.gmail.com>
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

On Mon, Oct 23, 2023 at 1:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver started calling into a few interfaces that are part of GPIOLIB=
 and
> don't have stub implementations otherwise:
>
> drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
> drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of functio=
n 'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=3Di=
mplicit-function-declaration]
>   424 |                 line_id =3D desc->attr.line_id - gpio_device_get_=
base(gs->gdev);
>       |                                                ^~~~~~~~~~~~~~~~~~=
~~
>       |                                                gpio_device_get_de=
sc
>
> Add a Kconfig dependency to only allow building when this is defined.
>
> Fixes: dc850faa28ee0 ("hte: tegra194: don't access struct gpio_chip")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hte/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> index 083e67492bf2e..641af722b555d 100644
> --- a/drivers/hte/Kconfig
> +++ b/drivers/hte/Kconfig
> @@ -17,6 +17,7 @@ if HTE
>  config HTE_TEGRA194
>         tristate "NVIDIA Tegra194 HTE Support"
>         depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> +       depends on GPIOLIB
>         help
>           Enable this option for integrated hardware timestamping engine =
also
>           known as generic timestamping engine (GTE) support on NVIDIA Te=
gra194
> --
> 2.39.2
>

Thanks. None of the new interfaces are "consumer" APIs and are not
meant to have stubs so depending on GPIOLIB is correct here.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
