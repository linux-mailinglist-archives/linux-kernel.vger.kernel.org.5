Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729F276FF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHDLXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHDLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:22:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED77E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:22:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso1448883fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691148177; x=1691752977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn7trNe3dp1mcfDcT90chQDFTqjFrpKrHN2t55C4hRo=;
        b=h8k1fJ86O8e50jai+n2+QbrEkHj1ndtJF3OoRpIorLn0Q8x+bb4IAOPhBIiNzHLHLv
         MQs4XP2vs+52XeoYJYQF/B1ot1IgVJr2OiugYCMi49BSeEGwTM+W1+RkvARKLX6HS9Ai
         G5xx9b+frta2ubwm3cJ0LLkXJPPnJ8P5wUcgO7n1WVKtEqeLjZioZIai0mJxEaNGFeBP
         jTioRIHx+5KuA+NGJQhscTKMq7YM+0w50h/So35ndoeWxy7D4yGzGkZP9GtiUjJg2D6T
         lfDZyaNSxRCJdSKFL5OEsJT84OiFzzXWPhb9WYIaH6nOXRAka6GW6i4enA9I92v4l3ci
         +25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691148177; x=1691752977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn7trNe3dp1mcfDcT90chQDFTqjFrpKrHN2t55C4hRo=;
        b=U67a25qmZ66JPOFe2kIdvEe7I/c7z3MkXFhpWnQ4GlPDsJRndXz0avHtHml0u9pyWq
         8oyJVrpy3zwsRAih0AvzGw30rk4P59/6Yo4HNJxj+TJK3ouQPoxNXFpc/1oBPo4Z4OrC
         93zAOsC6LoSfVdv1XvYwLtnhYzk89NyUwQYN9C3ssbss4n1aAXPtry7McIf+YKU0dILK
         d2n+fe8myZb5w7EL0LnQSvDb3foLCdc8Qg8UxZwmdRQObxJZ9pwgnZihejaJ+heAlzZS
         tvwGjtnlxa3Xco2J18waQvHaviaJ8xoyDUjz5yiiNaP2PyZQdsxL0ryqht4gWEWWMl1I
         NPFA==
X-Gm-Message-State: AOJu0Ywp+Vxqs8ApJ3EwcvKmn1Ht3kQS7Nwkj/vEycPSXTnalEJqS3ta
        zzOa/6WyHEv98CxOL2c208fgYD79WW/37r7wXnU=
X-Google-Smtp-Source: AGHT+IEr5d/guugs9ceHWwv9P/La9OMqu92JElPp/hvOJaD9VFuLdYPTgJrihdoG/fgD9VvxleKY5S6aTsHdKmqZr+8=
X-Received: by 2002:a05:6870:8187:b0:1b3:8cfb:78c5 with SMTP id
 k7-20020a056870818700b001b38cfb78c5mr1992428oae.34.1691148176721; Fri, 04 Aug
 2023 04:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230804030140.21395-1-rdunlap@infradead.org>
In-Reply-To: <20230804030140.21395-1-rdunlap@infradead.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 4 Aug 2023 06:22:44 -0500
Message-ID: <CAHCN7xJS6DC7BJhGWrgtczfye05z_Jeet1gjwKZkbRRrUk0cYQ@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 10:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Three DRM bridge drivers select GENERIC_PHY_MIPI_DPHY when GENERIC_PHY
> might not be set.  This causes Kconfig warnings and a build error.
>
> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>   Depends on [n]: GENERIC_PHY [=3Dn]
>   Selected by [y]:
>   - DRM_NWL_MIPI_DSI [=3Dy] && DRM_BRIDGE [=3Dy] && DRM [=3Dy] && COMMON_=
CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
>   - DRM_SAMSUNG_DSIM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && COMMON_=
CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
>
> (drm/bridge/cadence/Kconfig was found by inspection.)
>
> aarch64-linux-ld: drivers/gpu/drm/bridge/samsung-dsim.o: in function `sam=
sung_dsim_set_phy_ctrl':
> drivers/gpu/drm/bridge/samsung-dsim.c:731: undefined reference to `phy_mi=
pi_dphy_get_default_config_for_hsclk'
>
> Prevent these warnings and build error by also selecting GENERIC_PHY
> whenever selecting GENERIC_PHY_MIPI_DPHY.
>

Reviewed-by: Adam Ford <aford173@gmail.com>

> Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
> Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller suppor=
t")
> Fixes: 171b3b1e0f8b ("drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_=
DPHY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Aleksandr Nogikh <nogikh@google.com>
> Link: lore.kernel.org/r/20230803144227.2187749-1-nogikh@google.com
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Guido G=C3=BCnther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/bridge/Kconfig         |    2 ++
>  drivers/gpu/drm/bridge/cadence/Kconfig |    1 +
>  2 files changed, 3 insertions(+)
>
> diff -- a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge=
/cadence/Kconfig
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -4,6 +4,7 @@ config DRM_CDNS_DSI
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
> +       select GENERIC_PHY
>         select GENERIC_PHY_MIPI_DPHY
>         depends on OF
>         help
> diff -- a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -181,6 +181,7 @@ config DRM_NWL_MIPI_DSI
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
> +       select GENERIC_PHY
>         select GENERIC_PHY_MIPI_DPHY
>         select MFD_SYSCON
>         select MULTIPLEXER
> @@ -227,6 +228,7 @@ config DRM_SAMSUNG_DSIM
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
> +       select GENERIC_PHY
>         select GENERIC_PHY_MIPI_DPHY
>         help
>           The Samsung MIPI DSIM bridge controller driver.
