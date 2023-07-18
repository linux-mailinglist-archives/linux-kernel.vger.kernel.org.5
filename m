Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA807588D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGRXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:03:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDE12F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:03:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso3611643a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1689721415; x=1692313415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjVb67zK5fci1JLxDxdAWaUIUY9AVKFFP1LANpJq4VY=;
        b=Ncr9LczxS9OGMK7l3AC9wyNoxg7tChYI69P+5FaLA/3M1tthVkR3L+7roTFK4X3qf4
         bsvd0kszqWHAfD114t21jI4Z8ZFjbNiCHGg0ojOoT0a1cTQtBV0Q2oDB3UI+FYdE4cvy
         PQpq2PgwOxXOzvX3a8wnYiDbkKJKEFGSmtvbzlq1r2WqBIWanK1pFLCIpZ1ekshXzkel
         Cge5ekkCfwWQSWmea7zjEMFP9ITb+lWlojA+LHokqwiXhvbNxufW/KtkkFTIMvS25+Rb
         q0ANM1DUs/7hQS1GR5b3mdNeQHoMcvk17lH8Gz6aLpVXQC05xky9GJuTeerWWYELSNPm
         0KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721415; x=1692313415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjVb67zK5fci1JLxDxdAWaUIUY9AVKFFP1LANpJq4VY=;
        b=QIsMEvyaO75SSXixCDCsV4WPyiZMc5PG3qtQVtXM8jn1KEMnbfiSORed3WTTFlnQHo
         jIoTBvORKdZL/gLYYzypWD3c8l/a77+PuAiHQfJSnHKQobsREJmqcpyWO3GAXOJ3Ee8G
         6nLc6KkM0W4axlJchZ6iXWJT/5RGgh8e47/N/te1NzMSKvN351nSEbl/E2g3f5u687+3
         t0q5qhBWS3CHtFAVHx+wVd0aoMg6ANxcFl1mWRTrFH2DtJgKrhJ5OtCpX0qdgGltFef3
         QXp4DxN0wj2Y1Eij3RW0gRvzTgx3f25ZHtv1DpqYEFg/CnDmDTcxZQz8+nuUniDl1SxT
         fmrw==
X-Gm-Message-State: ABy/qLZ6xvr7UHVkiosYIKfGDU9pz6fa6h5tZyY8gFy8Lq74hN1Fu9ge
        KRPNN6GhzsQ10Ld3gxqlS3jh31XSobFrLQJIhSEFrQ==
X-Google-Smtp-Source: APBJJlE9ua2YXZrd+A6OCufJ++b12yc9+KrmefVWiLR84nCQH081BfMUhZ2QEitvN+rRkrGq9ZU7vaZRu3KuQ4HHrUw=
X-Received: by 2002:a17:90a:990e:b0:267:6586:f39a with SMTP id
 b14-20020a17090a990e00b002676586f39amr14364869pjp.47.1689721414649; Tue, 18
 Jul 2023 16:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230503163313.2640898-1-frieder@fris.de> <20230503163313.2640898-2-frieder@fris.de>
 <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
 <5dc55bcf-abec-78cd-74b8-54fa67fd1fb2@kontron.de> <a7e6611a-a147-607c-9df4-9fcc4e2cf397@kontron.de>
In-Reply-To: <a7e6611a-a147-607c-9df4-9fcc4e2cf397@kontron.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 18 Jul 2023 16:03:19 -0700
Message-ID: <CAJ+vNU00AsaGQ4nqCJ+XqUtYsbr8ow49BV78QZx6CgF0xn6s+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow
 to meet spec
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>
Cc:     Frieder Schrempf <frieder@fris.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 3:01=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Tim,
>
> On 13.07.23 09:18, Frieder Schrempf wrote:
> > Hi Tim,
> >
> > On 13.07.23 00:34, Tim Harvey wrote:
> >> On Wed, May 3, 2023 at 9:33=E2=80=AFAM Frieder Schrempf <frieder@fris.=
de> wrote:
> >>>
> >>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>>
> >>> According to the documentation [1] the proper enable flow is:
> >>>
> >>> 1. Enable DSI link and keep data lanes in LP-11 (stop state)
> >>> 2. Disable stop state to bring data lanes into HS mode
> >>>
> >>> Currently we do this all at once within enable(), which doesn't
> >>> allow to meet the requirements of some downstream bridges.
> >>>
> >>> To fix this we now enable the DSI in pre_enable() and force it
> >>> into stop state using the FORCE_STOP_STATE bit in the ESCMODE
> >>> register until enable() is called where we reset the bit.
> >>>
> >>> We currently do this only for i.MX8M as Exynos uses a different
> >>> init flow where samsung_dsim_init() is called from
> >>> samsung_dsim_host_transfer().
> >>>
> >>> [1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-=
operation
> >>>
> >>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>> ---
> >>> Changes for v2:
> >>> * Drop RFC
> >>> ---
> >>>  drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
> >>>  1 file changed, 23 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/=
bridge/samsung-dsim.c
> >>> index e0a402a85787..9775779721d9 100644
> >>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> >>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> >>> @@ -859,6 +859,10 @@ static int samsung_dsim_init_link(struct samsung=
_dsim *dsi)
> >>>         reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> >>>         reg &=3D ~DSIM_STOP_STATE_CNT_MASK;
> >>>         reg |=3D DSIM_STOP_STATE_CNT(driver_data->reg_values[STOP_STA=
TE_CNT]);
> >>> +
> >>> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> >>> +               reg |=3D DSIM_FORCE_STOP_STATE;
> >>> +
> >>>         samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> >>>
> >>>         reg =3D DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
> >>> @@ -1340,6 +1344,9 @@ static void samsung_dsim_atomic_pre_enable(stru=
ct drm_bridge *bridge,
> >>>                 ret =3D samsung_dsim_init(dsi);
> >>>                 if (ret)
> >>>                         return;
> >>> +
> >>> +               samsung_dsim_set_display_mode(dsi);
> >>> +               samsung_dsim_set_display_enable(dsi, true);
> >>>         }
> >>>  }
> >>>
> >>> @@ -1347,9 +1354,16 @@ static void samsung_dsim_atomic_enable(struct =
drm_bridge *bridge,
> >>>                                        struct drm_bridge_state *old_b=
ridge_state)
> >>>  {
> >>>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> >>> +       u32 reg;
> >>>
> >>> -       samsung_dsim_set_display_mode(dsi);
> >>> -       samsung_dsim_set_display_enable(dsi, true);
> >>> +       if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> >>> +               samsung_dsim_set_display_mode(dsi);
> >>> +               samsung_dsim_set_display_enable(dsi, true);
> >>> +       } else {
> >>> +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> >>> +               reg &=3D ~DSIM_FORCE_STOP_STATE;
> >>> +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> >>> +       }
> >>>
> >>>         dsi->state |=3D DSIM_STATE_VIDOUT_AVAILABLE;
> >>>  }
> >>> @@ -1358,10 +1372,17 @@ static void samsung_dsim_atomic_disable(struc=
t drm_bridge *bridge,
> >>>                                         struct drm_bridge_state *old_=
bridge_state)
> >>>  {
> >>>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> >>> +       u32 reg;
> >>>
> >>>         if (!(dsi->state & DSIM_STATE_ENABLED))
> >>>                 return;
> >>>
> >>> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> >>> +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> >>> +               reg |=3D DSIM_FORCE_STOP_STATE;
> >>> +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> >>> +       }
> >>> +
> >>>         dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
> >>>  }
> >>>
> >>> --
> >>> 2.40.0
> >>>
> >>
> >> Hi Frieder,
> >>
> >> I found this patch to break mipi-dsi display on my board which has:
> >>  - FocalTech FT5406 10pt touch controller (with no interrupt)
> >>  - Powertip PH800480T013-IDF02 compatible panel
> >>  - Toshiba TC358762 compatible DSI to DBI bridge
> >>  - ATTINY based regulator used for backlight controller and panel enab=
le
> >>
> >> I enable this via a dt overlay in a pending patch
> >> imx8mm-venice-gw72xx-0x-rpidsi.dtso [1] which works on 6.4 but not
> >> 6.5-rc1 which has this patch.
> >>
> >> The issue appears as:
> >> [    6.110585] samsung-dsim 32e60000.dsi: xfer timed out: 29 06 00 00
> >> 64 01 05 00 00 00
> >> [    6.326588] tc358762 32e60000.dsi.0: error initializing bridge (-11=
0)
> >>
> >> Instead of
> >> [    1.011729] samsung-dsim 32e10000.dsi: supply vddcore not found,
> >> using dummy regulator
> >> [    1.019829] samsung-dsim 32e10000.dsi: supply vddio not found,
> >> using dummy regulator
> >> [    5.649928] samsung-dsim 32e10000.dsi:
> >> [drm:samsung_dsim_host_attach] Attached tc358762 device
> >>
> >> I'm curious what board/panel were you needing this for and do you have
> >> any ideas why it broke my setup?
> >>
> >> I'm also curious what board/panel Alexander tested this with and if
> >> Adam or Jagan (or others) have tested this with their hardware?
> >
> > Sorry for breaking your setup. My test- and use-case is the same as
> > Alexander's. I have the SN65DSI84 downstream bridge and without this
> > patch it fails to come up in some cases.
> >
> > The failure is probably related to your downstream bridge being
> > controlled by the DSI itself using command mode. The SN65DSI84 is
> > instead controlled via I2C.
> >
> > Actually we should have tested this with a bridge that uses command mod=
e
> > before merging, now that I think of it. But I wasn't really aware of
> > this until now.
> >
> > I'll have a closer look at the issue and then will get back to you. In
> > the meantime if anyone can help analyze the problem or has proposals ho=
w
> > to fix it, please let us know.
>
> With my patch samsung_dsim_init() now initializes the DSIM to stop
> state. When being called from samsung_dsim_atomic_pre_enable() this
> works as the stop state is cleared later in samsung_dsim_atomic_enable().
>
> When being called from samsung_dsim_host_transfer() to handle transfers
> before samsung_dsim_atomic_pre_enable() was called, the stop state is
> never cleared and transfers will fail.
>
> This is the case in your setup as tc358762_init() is called in
> tc358762_pre_enable().
>
> I think that requiring to initialize the DSI host during transfer could
> be avoided in this case by moving tc358762_init() from
> tc358762_pre_enable() to tc358762_enable().
>
> But at the same time according to the docs at [1] this seems to be a
> valid case that we need to support in the DSIM driver:
>
>   Whilst it is valid to call host_transfer prior to pre_enable or
>   after post_disable, the exact state of the lanes is undefined at
>   this point. The DSI host should initialise the interface, transmit
>   the data, and then disable the interface again.
>
> Therefore I would propose to try a fix like in the attachement. If you
> could test this, that would be great.
>
> Thanks
> Frieder
>
> [1]
> https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operatio=
n

Hi Frieder,

The patch does not resolve the issue. I still get the 'xfer timed out'
from samsung-dsim but noticing today that this issue doesn't exist in
linux-next I've found that its resolved by Marek's patch:
commit 8a4b2fc9c91a ("drm/bridge: tc358762: Split register programming
from pre-enable to enable")

I'm not clear on how that patch is staged in linux-next. If we can get
that pulled into 6.5 then it will resolve the breakage.

best regards,

Tim
