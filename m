Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC275155D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjGMAho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjGMAhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:37:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3695D1FFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:37:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso27909a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689208660; x=1691800660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whmdMEUUiwwAHXxRe9EzWuR9AdLwUbEmg7zwFXy9qJc=;
        b=FgzTxrwqLyTL76VhukozF58uA+839P4HiYDRL89Dt8sJeXMeML/DhHKqqIOrhs355b
         gyEnp83WHpq/8d3DBwqiiJ/QKZIqwbuu1LiojxTILOPiaIc2VIX+LrvCNnH0RLl/0fIO
         HPL1oZUgqf+zG/Gd6hFJTOA9RyD5KXoxWsz3Qp1/bT0BPck8Wmo5DAtMss0aqt2dvrK8
         DdtonNy+lNNjHSBvwV0+Ri2TuYArISLz93iOVdI3CwOcp1BdFxHo6kBS5wL7UTDlrvCQ
         u9aKWLgppJLtBB/ChS+8ISVz2JfD+2X/znYZGfZ47OSxyi6yvzczGTPwNhgwtjI+Cy6u
         SAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689208660; x=1691800660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whmdMEUUiwwAHXxRe9EzWuR9AdLwUbEmg7zwFXy9qJc=;
        b=SwIWcBkFfmak0H1g9ekLhDISmzMD7a0RDsjV3f4PkHj+4qVP8QG8R0vCgUAnHmAFq8
         wfEFEVBe6HcSRBdL1XfY5ayGUfqi+M/5zm1TtZFms9sy2fpg1BqBiKgbI+d2gBS4PyCD
         o7yRq8mxpbDo4YrxXPE8dYAGFiSP++S4ay9qHJYkaYDjNki5Kaxf4YGVdXO99X8RdJjg
         pWoRm6WCedip9RfGBzK/lOlb3OBUoJj5zl/KgR2hzTrOyVFZ2Vg9sKR0qZsMqI+tkhpe
         y/R+s29mHhat2jRmj7FuntQM0Gu6qAoJTBNTNOq7ezNuHoA70IaCP9aFbQ1Y+QkAy1ow
         NWGA==
X-Gm-Message-State: ABy/qLaTWVBEhUPvEb6g+X+rqIsas90VLThplrtUMoQjqzoIYSp9u2QV
        A5xNuKi5KT72GjGyrboLzmrX/KVMT99FNtyRHIo=
X-Google-Smtp-Source: APBJJlGnbG449Fe6/pZd3CZuJVbGY/zUB3uf3huj+Ugvl+S32cur8MjE6SOKjXHOZt6k36yxcHwL9QbvvG+64AtViGY=
X-Received: by 2002:a17:90a:6984:b0:262:edb9:bf44 with SMTP id
 s4-20020a17090a698400b00262edb9bf44mr15241503pjj.19.1689208660341; Wed, 12
 Jul 2023 17:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230503163313.2640898-1-frieder@fris.de> <20230503163313.2640898-2-frieder@fris.de>
 <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
In-Reply-To: <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 12 Jul 2023 19:37:28 -0500
Message-ID: <CAHCN7xKjO_55aNuJYfC9uyc7Ky9VWHtdZpQarht6df1ZhVTPBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow
 to meet spec
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Frieder Schrempf <frieder@fris.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Marek Vasut <marex@denx.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 5:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Wed, May 3, 2023 at 9:33=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:
> >
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >
> > According to the documentation [1] the proper enable flow is:
> >
> > 1. Enable DSI link and keep data lanes in LP-11 (stop state)
> > 2. Disable stop state to bring data lanes into HS mode
> >
> > Currently we do this all at once within enable(), which doesn't
> > allow to meet the requirements of some downstream bridges.
> >
> > To fix this we now enable the DSI in pre_enable() and force it
> > into stop state using the FORCE_STOP_STATE bit in the ESCMODE
> > register until enable() is called where we reset the bit.
> >
> > We currently do this only for i.MX8M as Exynos uses a different
> > init flow where samsung_dsim_init() is called from
> > samsung_dsim_host_transfer().
> >
> > [1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-op=
eration
> >
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > ---
> > Changes for v2:
> > * Drop RFC
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index e0a402a85787..9775779721d9 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -859,6 +859,10 @@ static int samsung_dsim_init_link(struct samsung_d=
sim *dsi)
> >         reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> >         reg &=3D ~DSIM_STOP_STATE_CNT_MASK;
> >         reg |=3D DSIM_STOP_STATE_CNT(driver_data->reg_values[STOP_STATE=
_CNT]);
> > +
> > +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> > +               reg |=3D DSIM_FORCE_STOP_STATE;
> > +
> >         samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> >
> >         reg =3D DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
> > @@ -1340,6 +1344,9 @@ static void samsung_dsim_atomic_pre_enable(struct=
 drm_bridge *bridge,
> >                 ret =3D samsung_dsim_init(dsi);
> >                 if (ret)
> >                         return;
> > +
> > +               samsung_dsim_set_display_mode(dsi);
> > +               samsung_dsim_set_display_enable(dsi, true);
> >         }
> >  }
> >
> > @@ -1347,9 +1354,16 @@ static void samsung_dsim_atomic_enable(struct dr=
m_bridge *bridge,
> >                                        struct drm_bridge_state *old_bri=
dge_state)
> >  {
> >         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> > +       u32 reg;
> >
> > -       samsung_dsim_set_display_mode(dsi);
> > -       samsung_dsim_set_display_enable(dsi, true);
> > +       if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> > +               samsung_dsim_set_display_mode(dsi);
> > +               samsung_dsim_set_display_enable(dsi, true);
> > +       } else {
> > +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> > +               reg &=3D ~DSIM_FORCE_STOP_STATE;
> > +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> > +       }
> >
> >         dsi->state |=3D DSIM_STATE_VIDOUT_AVAILABLE;
> >  }
> > @@ -1358,10 +1372,17 @@ static void samsung_dsim_atomic_disable(struct =
drm_bridge *bridge,
> >                                         struct drm_bridge_state *old_br=
idge_state)
> >  {
> >         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> > +       u32 reg;
> >
> >         if (!(dsi->state & DSIM_STATE_ENABLED))
> >                 return;
> >
> > +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> > +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> > +               reg |=3D DSIM_FORCE_STOP_STATE;
> > +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> > +       }
> > +
> >         dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
> >  }
> >
> > --
> > 2.40.0
> >
>
> Hi Frieder,
>
> I found this patch to break mipi-dsi display on my board which has:
>  - FocalTech FT5406 10pt touch controller (with no interrupt)
>  - Powertip PH800480T013-IDF02 compatible panel
>  - Toshiba TC358762 compatible DSI to DBI bridge
>  - ATTINY based regulator used for backlight controller and panel enable
>
> I enable this via a dt overlay in a pending patch
> imx8mm-venice-gw72xx-0x-rpidsi.dtso [1] which works on 6.4 but not
> 6.5-rc1 which has this patch.
>
> The issue appears as:
> [    6.110585] samsung-dsim 32e60000.dsi: xfer timed out: 29 06 00 00
> 64 01 05 00 00 00
> [    6.326588] tc358762 32e60000.dsi.0: error initializing bridge (-110)
>
> Instead of
> [    1.011729] samsung-dsim 32e10000.dsi: supply vddcore not found,
> using dummy regulator
> [    1.019829] samsung-dsim 32e10000.dsi: supply vddio not found,
> using dummy regulator
> [    5.649928] samsung-dsim 32e10000.dsi:
> [drm:samsung_dsim_host_attach] Attached tc358762 device
>
> I'm curious what board/panel were you needing this for and do you have
> any ideas why it broke my setup?
>
> I'm also curious what board/panel Alexander tested this with and if
> Adam or Jagan (or others) have tested this with their hardware?

I have used the imx8mm and imx8mn with both an Analog Devices ADV7535
HDMI bridge, and a ti,sn65dsi83, and the imx8mp with the just the
adv7535.  I haven't seen any issues with this patch, but I wonder if
the downstream part for Tim needs to do something with this patch
installed, or whether or not we should add some sort of dsim flag that
either does this or skips it.  I would be curious to know if the NXP
downstream code works with either Frieder's or Tim's.

adam
>
> best regards,
>
> Tim
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/202307112=
21124.2127186-1-tharvey@gateworks.com/
