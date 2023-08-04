Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9E76FD6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHDJfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHDJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:35:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5C4236
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:35:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so70615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691141738; x=1691746538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG/hBNu1GQAj2OK0xpKDkaIiZaaGafuOT1wyHJ92KUE=;
        b=NxzXN8kae6zug4q6tWPIQXj58WTnWDUNK2etKvXWpMe8V9M2VrJFR1dYIvtuKa1UB4
         kRFN4jzXjGxIMhDwJjPxhvKtSYho5msJ9A0X6BpHcInDzBH0D091X8+QDwkD2PYZw+N7
         sJKGCQGSzBNxNlgzZNHpMqej8EGrEVmjYMHcm6JiPFIyj5FZyAKF0JIf3r3xcWpBSQka
         z+vKIK7O2g1trqKFsS7JSNDLWBr4RzT53cedmf/5nE5LhQzNDneVMXVzsyccQkNfeSnl
         zrk6ey0FACp+G9oq87nbNjvljvxmXNwuNrtkiwk2Cm3XNA7cljhoSygLAafz6YBuDkBP
         8NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141738; x=1691746538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG/hBNu1GQAj2OK0xpKDkaIiZaaGafuOT1wyHJ92KUE=;
        b=DabuPitZMSUlvYT798vnqXmSNriAsRFoXZAZWJUf7HLVaZtenhlvzpoxnsxHj9ZJHw
         A9/L/e8SbN/NyrsB1E/A/giUu6N/wIoprxGMC51AioRLfBdFE53jZPmWFr3eYEzJEGhP
         RzM+zGgm960hegBTQV3j908jr6NmjXhSZ3My9eo8J60QxG+G+ME4Uk8/cX3hyocxRGnY
         fbAn1++RkxAE1iJnLkt9G6mzE9Ru+hd8tRbtjvaii+SsYPf/CDvYsqDlllASZlGt3LDu
         EskJOYo4UbVTytwdyaXCbwV+gj6eM1IL2Km4Z+4TXb08KUvW3qLQ+T4X7KXBjdHU3NfH
         jmNg==
X-Gm-Message-State: AOJu0Yw7Af9K8AY4QGZUmRX0dBgM7Tp8mV3O0QCBmdOeXvm8dWwJyC7Q
        /+zIhsSjR0MFms2rEi4MiL5a4raC4PGTlTdtD53UGQ==
X-Google-Smtp-Source: AGHT+IEwo+ZtUuqQhcrazD8v+nNjuIoQZOhMJIRaf2kxpQIbs0CjisNKpq8sTDUzeUT/HeKKQIaMrZT+owjkAQx9b2k=
X-Received: by 2002:a05:600c:3ba9:b0:3f4:fb7:48d4 with SMTP id
 n41-20020a05600c3ba900b003f40fb748d4mr48822wms.3.1691141737646; Fri, 04 Aug
 2023 02:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230804030140.21395-1-rdunlap@infradead.org> <ZMyq9e/On2wzSJWj@qwark.sigxcpu.org>
In-Reply-To: <ZMyq9e/On2wzSJWj@qwark.sigxcpu.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 4 Aug 2023 11:35:25 +0200
Message-ID: <CANp29Y6AnNeouWgAevBEDZcYcOjzDQwxLDfLxe41Lp3BC=h8bA@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for resolving this issue so quickly!

I've applied the patch locally and gone through the reproduction
steps. The kernel builds fine now.

Tested-by: Aleksandr Nogikh <nogikh@google.com>

On Fri, Aug 4, 2023 at 9:38=E2=80=AFAM Guido G=C3=BCnther <agx@sigxcpu.org>=
 wrote:
>
> Hi,
> On Thu, Aug 03, 2023 at 08:01:37PM -0700, Randy Dunlap wrote:
> > Three DRM bridge drivers select GENERIC_PHY_MIPI_DPHY when GENERIC_PHY
> > might not be set.  This causes Kconfig warnings and a build error.
> >
> > WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
> >   Depends on [n]: GENERIC_PHY [=3Dn]
> >   Selected by [y]:
> >   - DRM_NWL_MIPI_DSI [=3Dy] && DRM_BRIDGE [=3Dy] && DRM [=3Dy] && COMMO=
N_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >   - DRM_SAMSUNG_DSIM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && COMMO=
N_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >
> > (drm/bridge/cadence/Kconfig was found by inspection.)
> >
> > aarch64-linux-ld: drivers/gpu/drm/bridge/samsung-dsim.o: in function `s=
amsung_dsim_set_phy_ctrl':
> > drivers/gpu/drm/bridge/samsung-dsim.c:731: undefined reference to `phy_=
mipi_dphy_get_default_config_for_hsclk'
> >
> > Prevent these warnings and build error by also selecting GENERIC_PHY
> n> whenever selecting GENERIC_PHY_MIPI_DPHY.
> >
> > Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
> > Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller supp=
ort")
> > Fixes: 171b3b1e0f8b ("drm: bridge: samsung-dsim: Select GENERIC_PHY_MIP=
I_DPHY")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: Aleksandr Nogikh <nogikh@google.com>
> > Link: lore.kernel.org/r/20230803144227.2187749-1-nogikh@google.com
> > Cc: Adam Ford <aford173@gmail.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Guido G=C3=BCnther <agx@sigxcpu.org>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: Robert Foss <rfoss@kernel.org>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/bridge/Kconfig         |    2 ++
> >  drivers/gpu/drm/bridge/cadence/Kconfig |    1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff -- a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/brid=
ge/cadence/Kconfig
> > --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> > +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> > @@ -4,6 +4,7 @@ config DRM_CDNS_DSI
> >       select DRM_KMS_HELPER
> >       select DRM_MIPI_DSI
> >       select DRM_PANEL_BRIDGE
> > +     select GENERIC_PHY
> >       select GENERIC_PHY_MIPI_DPHY
> >       depends on OF
> >       help
> > diff -- a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconf=
ig
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -181,6 +181,7 @@ config DRM_NWL_MIPI_DSI
> >       select DRM_KMS_HELPER
> >       select DRM_MIPI_DSI
> >       select DRM_PANEL_BRIDGE
> > +     select GENERIC_PHY
> >       select GENERIC_PHY_MIPI_DPHY
> >       select MFD_SYSCON
> >       select MULTIPLEXER
> > @@ -227,6 +228,7 @@ config DRM_SAMSUNG_DSIM
> >       select DRM_KMS_HELPER
> >       select DRM_MIPI_DSI
> >       select DRM_PANEL_BRIDGE
> > +     select GENERIC_PHY
> >       select GENERIC_PHY_MIPI_DPHY
> >       help
> >         The Samsung MIPI DSIM bridge controller driver.
> >
>
> For NWL:
>
> Reviewed-by: Guido G=C3=BCnther <agx@sigxcpu.org>
>
> Cheers,
>   -- Guido
