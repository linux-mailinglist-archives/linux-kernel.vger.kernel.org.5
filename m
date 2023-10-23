Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942517D3F05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjJWSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJWSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:21:02 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDC9B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:20:58 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so1367712241.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698085257; x=1698690057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lA7u/KwHbZjDwkrCQtE/aGz8soCrQO6TnRku5ElS1M=;
        b=cMuKwbsdsACZu4fhzqcYot4GUCplJDQANkyqYPqz9wBgHoCHaE/Xhm5NeLgE3PybZQ
         fDTrWSZF4Q7JIo6m+7F0VdgWfxcy/wK+UqTyULLXV6lhBfOjuMXkIPSybfjEEffijKGW
         eqEu9E4T386D2QaJwy8jleLACsLaowIrUGROcL/7Wguhqz55WUx9gSU9W2O9pw90bjP4
         /PMHTl21HYnDWcTfuru56AaMfhiHORrznmtqorcDsRgmVS24KtLiM5IfnC715SEAtj3E
         mqEve+4YLnxn685zcZcRJfQc7x3k2saGApLlSAhzYucl+H5Sf9B8lAIfL51ooVCWkqnw
         FdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085257; x=1698690057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lA7u/KwHbZjDwkrCQtE/aGz8soCrQO6TnRku5ElS1M=;
        b=ONV3fZ+IV7x8hi8MAo0COQcGvL3xE1tPl87Xb66tas+OiC2kQZNCBzoic8gdvGYP3M
         VpnBpyW+nkTx34nelXmcHiihEX4kfhRTrog2YL1KnTKhX6MTtAGKCDrHeZg7HQ6+VR8A
         JMqacSbp5u/Qoz0YVWDmq66Uu81oZmKrb6pHRR6/X+7n1x9sg/MfIoubR39djEeHYZxH
         MPXZUs6sIkbEIs33YtD45AKleap6x3+MfoDJwNZvwL15RBQLwYGy0xGeAs9FRoPZoFWE
         mVPtIuv9zeOK9K78JVJGdSbFcTlhyHihR9JIXTnv5nG6p0Z3xCHGz0sc1ai9HSegIJ/X
         OrLw==
X-Gm-Message-State: AOJu0YxoJlA8y+ZwqWj1N1Mjck+l8h/RyJtYc8PlrIpurO8J5/UmbIqE
        yfCWOrzlJNi/JR02BA7FWzLdhwrOTDFE+y7HkU2gt/rTUm/kF/Pv
X-Google-Smtp-Source: AGHT+IEss1D7rJx7U841FkofMmztsAi5XD53agAT3T0X85OAQ68mbw9ZhE5Uif3hbK4ONSG5WfHdXGuanHDmltk1Rjk=
X-Received: by 2002:a67:cb9d:0:b0:458:3bc1:9777 with SMTP id
 h29-20020a67cb9d000000b004583bc19777mr8102288vsl.15.1698085257266; Mon, 23
 Oct 2023 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231023115646.3573494-1-arnd@kernel.org> <CAMRc=MdoRWn_grWoKWagAi11S=mZ9RbP673L77a+qfN_8oTBcg@mail.gmail.com>
 <CAMRc=Mc7PCEimVEJ_JYg=4+X5PAJ1Lh2SxXsNEFpuKctbEPiYg@mail.gmail.com> <1e603c14-54aa-1ea8-cac7-99b29af92b4b@nvidia.com>
In-Reply-To: <1e603c14-54aa-1ea8-cac7-99b29af92b4b@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Oct 2023 20:20:46 +0200
Message-ID: <CAMRc=Mc-G2DMcvBGpxZbEjgX9GZDTNLmpMJix+-AC23nKqPCpQ@mail.gmail.com>
Subject: Re: [PATCH] hte: tegra194: add GPIOLIB dependency
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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

On Mon, Oct 23, 2023 at 7:26=E2=80=AFPM Dipen Patel <dipenp@nvidia.com> wro=
te:
>
> On 10/23/23 5:02 AM, Bartosz Golaszewski wrote:
> > On Mon, Oct 23, 2023 at 2:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>
> >> On Mon, Oct 23, 2023 at 1:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
> >>>
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> The driver started calling into a few interfaces that are part of GPI=
OLIB and
> >>> don't have stub implementations otherwise:
> >>>
> >>> drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
> >>> drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of fun=
ction 'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=
=3Dimplicit-function-declaration]
> >>>   424 |                 line_id =3D desc->attr.line_id - gpio_device_=
get_base(gs->gdev);
> >>>       |                                                ^~~~~~~~~~~~~~=
~~~~~~
> >>>       |                                                gpio_device_ge=
t_desc
> >>>
> >>> Add a Kconfig dependency to only allow building when this is defined.
> >>>
> >>> Fixes: dc850faa28ee0 ("hte: tegra194: don't access struct gpio_chip")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> ---
> >>>  drivers/hte/Kconfig | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
> >>> index 083e67492bf2e..641af722b555d 100644
> >>> --- a/drivers/hte/Kconfig
> >>> +++ b/drivers/hte/Kconfig
> >>> @@ -17,6 +17,7 @@ if HTE
> >>>  config HTE_TEGRA194
> >>>         tristate "NVIDIA Tegra194 HTE Support"
> >>>         depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
> >>> +       depends on GPIOLIB
> >>>         help
> >>>           Enable this option for integrated hardware timestamping eng=
ine also
> >>>           known as generic timestamping engine (GTE) support on NVIDI=
A Tegra194
> >>> --
> >>> 2.39.2
> >>>
> >>
> >> Thanks. None of the new interfaces are "consumer" APIs and are not
> >> meant to have stubs so depending on GPIOLIB is correct here.
> >>
> >> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Ah, this goes on top of the patch that is in my tree so I'll wait for
> > Dipen's Ack and apply it.
>
> Acked-by: Dipen Patel <dipenp@nvidia.com>
> >
> > Bart
>

I queued it. There's a trivial conflict with your HTE branch, Stephen
should be able to resolve it.

Bart
