Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870478BB14
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjH1Wia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjH1WiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:38:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E197
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:38:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56a8794b5adso2251426a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693262279; x=1693867079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMSOhObiScKAaL1YKIguFyCrqTv33hJyJ7dwyMmPz2U=;
        b=sQdjf8goMGTQd+OEOWgxWfkkVSbiA4m20jco1xGGz/8dlfeUJwWb/2QCq83PCIS/Am
         QHP+pyFR6NNCTX5D6U+5TMAxYa2OuzMZGemPVLzI2UF//zzrj7zZKPLxyCoiLkUJO31K
         4/F89i6SvPjszHqNOZuEyC45Ll27mm8gsX6Ekf/hmSqHhU0p0LdpXj/vJtakR5V38V9z
         y5MrKtX8btdXU1+2oy7D9oIrWv+wkrdk2/2W54OGqggXQGyggb/s1CtBBiYo6K7Nw5sB
         8oQgeaoICQwSmKu6La5TxJAaPpwPnbdGL7Na8z3ugASR6/1I9E0OJdDZAn8RuSOEwovI
         cYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262279; x=1693867079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMSOhObiScKAaL1YKIguFyCrqTv33hJyJ7dwyMmPz2U=;
        b=T1hLgx6IC88WeUuq9WMaqA9l+i2BLrZ3AHjyH+GJm5IfmD+UvmuZPjzrJsh1QmQ9r7
         UwKa9Osw3JY0ZQHlNvDEdLwMNZqOubCLTT/vCQAYZNBpUps+Ikezx11ZbHUYFhVRPOKW
         XIV6k2xOMcrhJBjiVWE/Czt1I6QBxC0wluTC0i3U05C885+wsaz8mlkqoQpydc2P5ZEj
         NRE0I3VbJByCn7bwiC+jj09FAzv/rmnI0CmrMEPDZmQUoDxTnlVB1X0vVpXlSeY1hjCG
         RzGI2d4C+NA2kccKH8MyGo340fSd0GuMeedakqIqowQrhvArZiYaSSeDyH/9JD2lLYkd
         pbaw==
X-Gm-Message-State: AOJu0Yw4Y8cXBlcTNxcIZQenws1+sEwg9aYOivPht8bp7eMPAjHOAaEz
        lEgmu1L+dYU9+8me0yTaWbK4VwCsVEi3VFEW8dyLIKEUJMc=
X-Google-Smtp-Source: AGHT+IHE7qapqdV+R+S251VNpoiJ8J4S1FcdDKmVFe+aQD/OVtLFm4MBEYK6nVNBzbAuFYyCGSiDEefkAiihkZVvE4Q=
X-Received: by 2002:a17:90b:364a:b0:26b:be62:c229 with SMTP id
 nh10-20020a17090b364a00b0026bbe62c229mr26249708pjb.32.1693262279272; Mon, 28
 Aug 2023 15:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de> <20230818-samsung-dsim-v1-1-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-1-b39716db6b7a@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Aug 2023 17:37:48 -0500
Message-ID: <CAHCN7x+J_umWCBvivuZsrHTvjw=4CvBqOSeO-j_+fTMm=DdAOg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/bridge: samsung-dsim: add more mipi-dsi device
 debug information
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Mon, Aug 28, 2023 at 10:59=E2=80=AFAM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> From: Marco Felsch <m.felsch@pengutronix.de>
>
> Since the MIPI configuration can be changed on demand it is very useful
> to print more MIPI settings during the MIPI device attach step.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon

> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 73ec60757dbc..6778f1751faa 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1711,7 +1711,10 @@ static int samsung_dsim_host_attach(struct mipi_ds=
i_host *host,
>                 return ret;
>         }
>
> -       DRM_DEV_INFO(dev, "Attached %s device\n", device->name);
> +       DRM_DEV_INFO(dev, "Attached %s device (lanes:%d bpp:%d mode-flags=
:0x%lx)\n",
> +                    device->name, device->lanes,
> +                    mipi_dsi_pixel_format_to_bpp(device->format),
> +                    device->mode_flags);
>
>         drm_bridge_add(&dsi->bridge);
>
>
> --
> 2.39.2
>
