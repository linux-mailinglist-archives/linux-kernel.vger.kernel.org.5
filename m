Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4127A1DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjIOLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjIOLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:43:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678126B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:43:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8198ca891fso1491278276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694778202; x=1695383002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3gobU7LzW64CHCMbP4jJ1t/LrglwPbKfnb/Fh1ltUs=;
        b=KoYv5NzKHwSfWllZmBJjqCj8XJU+tfJjA2pcEpBB8UnAyqm2UGZCJzfzzt+uuX3dj/
         DT27XLm6M+uy9uIBwEF3U0X4NyMj/8EIN5d7rAqFyNdXi6R0w59nx4Z+nu4QRgJaqZJK
         0kfNkT8ucR1o1AEC+ecx+b8tRGT3iHBy1o/25J/DUxKFsImSokzB6IOVyk+QpExweqxJ
         fbtJvDVEEGngXPTnH255msAq4P32BIVpThSj6R6lYQ1R7mhRbZfHoRU94bIaoB/Anwzp
         1mXUlFso4I9+zh3guhWuvgXDQGuR5/Se7/tjynSnvOUZVKTfgCE7rtTiAfDHYjr+FcUW
         ZwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694778202; x=1695383002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3gobU7LzW64CHCMbP4jJ1t/LrglwPbKfnb/Fh1ltUs=;
        b=ebP50rl1VnZiKPoBtooNeAk4IhEN76EG6dnMx2fgGFDyf1d0v6nsAk1Rb9FAmik7I6
         W8L1XnyuU48A0LfGd+BaEPAS58rSSKcNb3oYYwPvaLq6zFIt3sLubmM84vNjAdGR45cd
         vpAXiClFirnofZQ0R85/99g+a8bVfjZh4zTZ6eERXRypFO+2ZowHuleX5o6+nENo7nMk
         Maz5+3j2gd3+PIj/YU/aI/hbAD4wOMOmnQWnzZUQ/O4dtZ7SJVJ2ioBw0OGDJW+21Uvs
         CSOQ62vYYSzwo9K7jUPZmVFs0pvXS/FFIojcInahIML7XGXTlU45L2+VqIz4NUiLHOqj
         sswg==
X-Gm-Message-State: AOJu0Yz+sL7GP7pFoMBZFsTJe8kMUf8Yz2Evr/5lOrq3e/dlzbvWlOhl
        6BYSZb6iRlRwbbO02yfBdc22YcEB2fAYga/n3d3PUQ==
X-Google-Smtp-Source: AGHT+IHsjUuXQRzzbhvFhMS8P8hV21qrc5hzO5QFZZxgUNTAqYMnZtraigW7oVoBiFiqcizSKCa4p0mxC3Tm3xkj7XE=
X-Received: by 2002:a25:348c:0:b0:d74:6163:db8c with SMTP id
 b134-20020a25348c000000b00d746163db8cmr1068410yba.41.1694778202289; Fri, 15
 Sep 2023 04:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-14-ulf.hansson@linaro.org> <20230915-lark-gangrene-b7cbd445b511@wendy>
In-Reply-To: <20230915-lark-gangrene-b7cbd445b511@wendy>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Sep 2023 13:42:45 +0200
Message-ID: <CAPDyKFp8UXj6wPqP13RJBS7EUDiZ09GBkOUbTGfm5rTRAKr3NA@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] pmdomain: starfive: Move Kconfig file to the
 pmdomain subsystem
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:30, Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Fri, Sep 15, 2023 at 11:19:59AM +0200, Ulf Hansson wrote:
> > The Kconfig belongs closer to the corresponding implementation, hence let's
> > move it from the soc subsystem to the pmdomain subsystem.
>
> Thanks for updating the MAINTAINERS bits.
>
> > Cc: Walker Chen <walker.chen@starfivetech.com>
> > Cc: Conor Dooley <conor@kernel.org>
> > Acked-by: Conor Dooley <conor@kernel.org>
>
> Unless my macro changed without me noticing, I don't think that's
> the email address I used for the ack. Just to be sure:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Sorry, my bad. I will change it, if/when applying. Thanks again!

Kind regards
Uffe

>
> Thanks,
> Conor.
>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  MAINTAINERS                                | 3 +--
> >  drivers/pmdomain/Kconfig                   | 1 +
> >  drivers/{soc => pmdomain}/starfive/Kconfig | 0
> >  drivers/soc/Kconfig                        | 1 -
> >  4 files changed, 2 insertions(+), 3 deletions(-)
> >  rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6b491ebcf790..40744fefed3d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20515,7 +20515,7 @@ M:    Walker Chen <walker.chen@starfivetech.com>
> >  M:   Changhuang Liang <changhuang.liang@starfivetech.com>
> >  S:   Supported
> >  F:   Documentation/devicetree/bindings/power/starfive*
> > -F:   drivers/pmdomain/starfive/jh71xx-pmu.c
> > +F:   drivers/pmdomain/starfive/
> >  F:   include/dt-bindings/power/starfive,jh7110-pmu.h
> >
> >  STARFIVE SOC DRIVERS
> > @@ -20523,7 +20523,6 @@ M:    Conor Dooley <conor@kernel.org>
> >  S:   Maintained
> >  T:   git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> >  F:   Documentation/devicetree/bindings/soc/starfive/
> > -F:   drivers/soc/starfive/
> >
> >  STARFIVE TRNG DRIVER
> >  M:   Jia Jie Ho <jiajie.ho@starfivetech.com>
> > diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> > index 08f8a3aa9805..2286c36076db 100644
> > --- a/drivers/pmdomain/Kconfig
> > +++ b/drivers/pmdomain/Kconfig
> > @@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
> >  source "drivers/pmdomain/rockchip/Kconfig"
> >  source "drivers/pmdomain/samsung/Kconfig"
> >  source "drivers/pmdomain/st/Kconfig"
> > +source "drivers/pmdomain/starfive/Kconfig"
> >
> >  endmenu
> > diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kconfig
> > similarity index 100%
> > rename from drivers/soc/starfive/Kconfig
> > rename to drivers/pmdomain/starfive/Kconfig
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 8b46da40f107..10a9ff84ff41 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
> >  source "drivers/soc/rockchip/Kconfig"
> >  source "drivers/soc/samsung/Kconfig"
> >  source "drivers/soc/sifive/Kconfig"
> > -source "drivers/soc/starfive/Kconfig"
> >  source "drivers/soc/sunxi/Kconfig"
> >  source "drivers/soc/tegra/Kconfig"
> >  source "drivers/soc/ti/Kconfig"
> > --
> > 2.34.1
> >
