Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5B75C2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGUJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGUJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:11:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21D35A7;
        Fri, 21 Jul 2023 02:11:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977e0fbd742so268965066b.2;
        Fri, 21 Jul 2023 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689930679; x=1690535479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM3KGadjDOYHGZ48CafeghyP+SvOLq0YqUvtd5Ztz2M=;
        b=Ywzlu3+6SQgXc6CxnRdfrOev1LvalA/Mzdak59xCHnJpYFrR7trnuUUuNGI1LWo6p4
         rkCNo5xMLr3CsWYWWvQGWs+udNN10OImgWhIq6wmRU1TINy++ynyL0JbIa1BcmeRdk1K
         TRsPwZp/K2v6pXUFlicQ7sW7QmxuCY+irJceospNhpG5zaptQN7lZiikzzmodPJj87ix
         03CVJE3M/xdwma4oSc5X3XEFyKFV+bP4w9BW5h1iDzkN9pgcSdR4IUr4SCQYHakpfKXU
         uMb8jdDEA1mBG8qajnD88uvmzVnLCmGKa9Z+r+p7M3NYLpAJN5JJu2XUdogU7oYbkNV9
         JUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689930679; x=1690535479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM3KGadjDOYHGZ48CafeghyP+SvOLq0YqUvtd5Ztz2M=;
        b=cYoWWXe4rKSdEkySSdCA2FuHu8jx5u+2K1/G6hNOn12yeC740/O2UxLBMbVKtp98wr
         Ly6x8wh51eFW2Nr5RKcLIXerBU65uC/ryhOhvJ5iNSEEZ0zVeCnEH4ikl2SPJlK0teti
         1BmhQC+CPPTNLywrtFeAmtWDctMDHho8XPn3mHgjQze82bHbsvgGJp1eZZlHWI4Os/1P
         ugtpqrJOTWeeEzSMBodFIahFc8PI2NIEj8Ed6Mc6Sm/HCZHuxWRd/4MJ3xzuLyPlZWKq
         5b1LH7Jtb4N0H5xaDTDn0ZC52rJ4sMA8x8eqxCo9MENNhJHlR1Ko3gRF2fY3xXgGANmD
         A2Rg==
X-Gm-Message-State: ABy/qLargsJATG2nI4XHM+PX8A/+k3EnWdYBwNF+t/rvMqK4Rotx0pTB
        O+RBrWnCxbuBKbiHIRp+AKvX2QtI1VamM1mzxl4=
X-Google-Smtp-Source: APBJJlG23C9IQ8C77apuuCpxCvPq7IQ3XI4qgYHy56Nc3u0wfmova7/RDtmPGqd0Fia+p0KcdtIUzY/HD9E5C/4nMG8=
X-Received: by 2002:a17:906:328f:b0:993:f611:7c95 with SMTP id
 15-20020a170906328f00b00993f6117c95mr1123747ejw.39.1689930678523; Fri, 21 Jul
 2023 02:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230721090332.1528569-1-victor.liu@nxp.com>
In-Reply-To: <20230721090332.1528569-1-victor.liu@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jul 2023 12:10:42 +0300
Message-ID: <CAHp75Vd3e66G1jWnrXX7jgcP3bQ5m91Z=Sd=e8hHF4nr39wJXQ@mail.gmail.com>
Subject: Re: [PATCH v3] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "andy@kernel.org" <andy@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:58=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrot=
e:
>
> If gpio pin is in input state but backlight is currently off due to

GPIO

> default pull downs, then initial power state is set to FB_BLANK_UNBLANK
> in DT boot mode with phandle link and the backlight is effectively
> turned on in gpio_backlight_probe(), which is undesirable according to
> patch description of commit ec665b756e6f ("backlight: gpio-backlight:
> Correct initial power state handling").
>
> Quote:

> ---
> If in DT boot we have phandle link then leave the GPIO in a state which t=
he
> bootloader left it and let the user of the backlight to configure it furt=
her.
> ---

Just use ---8<--- or drop these completely, as your (commit message of
the) patch is broken now.

>
> So, let's drop output gpio direction check and only check gpio value to s=
et

GPIO
GPIO

> the initial power state.
>
> Fixes: 706dc68102bc ("backlight: gpio: Explicitly set the direction of th=
e GPIO")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

--=20
With Best Regards,
Andy Shevchenko
