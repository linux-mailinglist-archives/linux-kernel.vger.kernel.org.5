Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2381E7B04A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjI0MsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI0MsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:48:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08912A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:48:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-693375d2028so1036946b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695818885; x=1696423685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+q11IEuEpxpbMHfQrNpP6uY5LoxWEiXG+rgWu0fXno=;
        b=aNCpfdFvCeYSflXBGAO7S4irD9Ie8f6J2wMDYfVog47BlXgMUjBbNT39ND0gALV887
         qOQs+VEK2/J0vqVsvYw9oBPGxXrvKPQwdApa/JaARQVPvXr215qaiaMGOIMYwZIrO1Bg
         eiS3XqmirrVZEGta5Y8k0TDdbZCNEflJYHBkWXe2g6llSzHqv/nKz+BVeWlJVHXaKFpZ
         yp/92IwKDyNvAN6MHODBOj13bATbhKSjPVr6pAILreDaCGExJKmOk7WoN8GhWdQN3W5B
         0i4MOFc37qVS85IOXUj5aalldGgbH0pVhP9euZEtWb4FLJiVS37NshJOTvFYqku0yNa3
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818885; x=1696423685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+q11IEuEpxpbMHfQrNpP6uY5LoxWEiXG+rgWu0fXno=;
        b=CUwSlcMX74MxAbicBs13eJlgFBk+Fyl3AUGElF7RjPopsQiMJWIuFH3zdbdpw8LUul
         gGD6j/oLsfHKd99wOl2O/6tTtffUk4Yg6VRkBttOPB+WfVIgp0btTBm+c79rDqqSe5Qd
         AeC0SEPC2A1WMMtoOKWow2b0JiuBfUjJSJGyN59WM4sL8RmrVHXMc94ScxSa3jTe7d9i
         u1F+NfH5aMhuwVBXEa5Mn9wkWZI3sV0DkoKzKLMHg/V2n4PY8AnuTZnEnaP7eCJMtSQa
         S2zcrwq0AQPFGIR9vdnp431l9Cgsn7sgmO8STNoEGAML3gCLBlpmoIGw5z5CJbjdyzvJ
         knyQ==
X-Gm-Message-State: AOJu0YxPaOavX4m5fhjndtlRT69k3DFQ8XQe6Z+0kaSkyZ7YOgygxf8M
        YVfvWIkoGEDHwLx9aL7z9LKpn6/ERaYYZX8rG3Q=
X-Google-Smtp-Source: AGHT+IGQdPYHMqTr4zNlzxJt6CA/xWfpM/ppZnKjYbKGmAsCanhjAOi4K+CnfdCrirywt9q82CL1CgNeAe1zxdaPCgE=
X-Received: by 2002:a05:6a20:1607:b0:15a:3eaa:b7f8 with SMTP id
 l7-20020a056a20160700b0015a3eaab7f8mr2188328pzj.50.1695818884995; Wed, 27 Sep
 2023 05:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-1-b39716db6b7a@pengutronix.de> <CAHCN7x+J_umWCBvivuZsrHTvjw=4CvBqOSeO-j_+fTMm=DdAOg@mail.gmail.com>
 <CAAQKjZM9UGgzAgfg-Rt92BNdvLuUJ90=QRUrd=FnDFwGvoC-zA@mail.gmail.com>
In-Reply-To: <CAAQKjZM9UGgzAgfg-Rt92BNdvLuUJ90=QRUrd=FnDFwGvoC-zA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 27 Sep 2023 07:47:53 -0500
Message-ID: <CAHCN7xJLH2oBzvn6V0VRpisr1Pmh3knx0t0Vesck5q_-RGnN6A@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/bridge: samsung-dsim: add more mipi-dsi device
 debug information
To:     Inki Dae <daeinki@gmail.com>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
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

On Sun, Sep 3, 2023 at 8:05=E2=80=AFPM Inki Dae <daeinki@gmail.com> wrote:
>
> 2023=EB=85=84 8=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 7:38,=
 Adam Ford <aford173@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Mon, Aug 28, 2023 at 10:59=E2=80=AFAM Michael Tretter
> > <m.tretter@pengutronix.de> wrote:
> > >
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > >
> > > Since the MIPI configuration can be changed on demand it is very usef=
ul
> > > to print more MIPI settings during the MIPI device attach step.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> >
> > Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> > Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
>
> Reviewed-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>

What needs to be done in order to get this accepted?  This series is a
very nice improvement in i.MX8M Mini / Nano.

adam
>
> >
> > > ---
> > >  drivers/gpu/drm/bridge/samsung-dsim.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/=
bridge/samsung-dsim.c
> > > index 73ec60757dbc..6778f1751faa 100644
> > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > @@ -1711,7 +1711,10 @@ static int samsung_dsim_host_attach(struct mip=
i_dsi_host *host,
> > >                 return ret;
> > >         }
> > >
> > > -       DRM_DEV_INFO(dev, "Attached %s device\n", device->name);
> > > +       DRM_DEV_INFO(dev, "Attached %s device (lanes:%d bpp:%d mode-f=
lags:0x%lx)\n",
> > > +                    device->name, device->lanes,
> > > +                    mipi_dsi_pixel_format_to_bpp(device->format),
> > > +                    device->mode_flags);
> > >
> > >         drm_bridge_add(&dsi->bridge);
> > >
> > >
> > > --
> > > 2.39.2
> > >
