Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F717D22C1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJVKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:49:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04981B4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:49:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2f4a5ccebso1671273b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697971792; x=1698576592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsyTofoiJdTaMgzaZy88bV2Z5IwkB35oaVbzN5yV92E=;
        b=e+5NQoDI87tL3cK8fQ9EEfMXDdzYf68v0TMMxSL9lPl2FkWAbqNwk2lWluI8GiivRF
         dRPlTXhqtBBa8hnkVNVNaU0ad8hh08yfQs+HIiVC/vHho/N+YCRUhqqvBhJ0+KI9GimB
         HkrGDzCPPpdJuqnSEgPOo4Zj4+ZeyNXKz/01vcFA0eVHKy3zlEnH/15GmZtzY2XrLfjc
         TI7xD7ULwdTp4VaK68XS0oZpHEkOp0hLbVJuQnYpq1fRBUHeiM0pD+0txqBK1l8fcb4Z
         MAf6c+JfN0aQowUzK2BEIF4UpsyYrXnyDJkFa375GO0mDda8S3ft2cbpp5zDhsub8vIn
         lT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697971792; x=1698576592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsyTofoiJdTaMgzaZy88bV2Z5IwkB35oaVbzN5yV92E=;
        b=DdIROMlWYW0sg9EQlY93HC2APQpd5yIzGf15TuJZZeIqgUE9gB3RYIidkOnsRPBfcv
         e7oySM6WZSGSOsrHdpP/JeFAxzUi6eHCwrG1UFxVwNpkS+b9GnUZT0yM9m1mYqaYuUKr
         9oOeIEZDfq5MiqVS725xS2a3htf4CbNvnwYtxzFdHM7jov9nArcspDfV5M+b0LbC+nRR
         eS+f/s2DAEyINsqdYw3Nz4EysumyPeZ6EU24wH5+ji/6fdHg398orvaYa1leWvjO/PxY
         /vPwLKZVjOLfaHXPEhkl+VXxSLVRMy9iSoY8kEol+GUlv4azulwu0mr21/rDNb/oKS18
         ZrPA==
X-Gm-Message-State: AOJu0YxnBP+GFy/sN+WIgAnx4IH7os9KhwBOUGmkiWptdNe6b2qQjYsu
        7/Gss0aGshdIJQ6JZ9MwhhWgeJzQRKho4hpWwmjDsw==
X-Google-Smtp-Source: AGHT+IFYXaKkpzLl4qJI/DncbAgnwW8J71rYXJnTnU4eGIVRz0Vjuz/xbiFDBIAw8QrSlrmqpaDym7qOPLPbGVgCWY8=
X-Received: by 2002:a05:6808:c3:b0:3ae:251f:923f with SMTP id
 t3-20020a05680800c300b003ae251f923fmr6825013oic.28.1697971792253; Sun, 22 Oct
 2023 03:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
 <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com> <1907377.IobQ9Gjlxr@steina-w>
In-Reply-To: <1907377.IobQ9Gjlxr@steina-w>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 22 Oct 2023 13:49:41 +0300
Message-ID: <CAA8EJpoN36PHoZH=Osfn_wr7kO-dypius2ae_FuJ4Hk+gjeBtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Marek Vasut <marex@denx.de>, Robert Foss <rfoss@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 14:42, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Donnerstag, 19. Oktober 2023, 13:19:51 CEST schrieb Dmitry Baryshkov:
> > On Thu, 19 Oct 2023 at 12:26, Maxime Ripard <mripard@kernel.org> wrote:
> > > On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wrote:
> > > > The MIPI DSI links do not fully fall into the DRM callbacks model.
> > >
> > > Explaining why would help
> >
> > A kind of explanation comes afterwards, but probably I should change
> > the order of the phrases and expand it:
> >
> > The atomic_pre_enable / atomic_enable and correspondingly
> > atomic_disable / atomic_post_disable expect that the bridge links
> > follow a simple paradigm: either it is off, or it is on and streaming
> > video. Thus, it is fine to just enable the link at the enable time,
> > doing some preparations during the pre_enable.
> >
> > But then it causes several issues with DSI. First, some of the DSI
> > bridges and most of the DSI panels would like to send commands over
> > the DSI link to setup the device. Next, some of the DSI hosts have
> > limitations on sending the commands. The proverbial sunxi DSI host can
> > not send DSI commands after the video stream has started. Thus most of
> > the panels have opted to send all DSI commands from pre_enable (or
> > prepare) callback (before the video stream has started).
> >
> > However this leaves no good place for the DSI host to power up the DSI
> > link. By default the host's pre_enable callback is called after the
> > DSI bridge's pre_enable. For quite some time we were powering up the
> > DSI link from mode_set. This doesn't look fully correct. And also we
> > got into the issue with ps8640 bridge, which requires for the DSI link
> > to be quiet / unpowered at the bridge's reset time.
>
> There are also bridges (e.g. tc358767) which require DSI-LP11 upon bridge
> reset. And additionally this DSI-(e)DP bridge requires LP11 while accessi=
ng
> DP-AUX channel, e.g. reading EDID. So bridges need at least some control =
over
> DSI line state.

For sending commands in LP11 it is typical to toggle the
MIPI_DSI_MODE_LPM flag, for example see panel-=3Djdi-lt070me05000.c or
some other drives. It might be a good idea to make that more explicit.
All suggestions here would be appreciated.

>
> > Dave has come with the idea of pre_enable_prev_first /
> > prepare_prev_first flags, which attempt to solve the issue by
> > reversing the order of pre_enable callbacks. This mostly solves the
> > issue. However during this cycle it became obvious that this approach
> > is not ideal too. There is no way for the DSI host to know whether the
> > DSI panel / bridge has been updated to use this flag or not, see the
> > discussion at [1].
> >
> > Thus comes this proposal. It allows for the panels to explicitly bring
> > the link up and down at the correct time, it supports automatic use
> > case, where no special handling is required. And last, but not least,
> > it allows the DSI host to note that the bridge / panel were not
> > updated to follow new protocol and thus the link should be powered on
> > at the mode_set time. This leaves us with the possibility of dropping
> > support for this workaround once all in-kernel drivers are updated.
>
> I want to use this series to support tc358767 properly, because
> pre_enable_prev_first is not enough, see AUX channel above. I hope I'll f=
ind
> any time soon.
>
> Best regards,
> Alexander
>
> >
> > > > The drm_bridge_funcs abstraction.
> > >
> > > Is there a typo or missing words?
> >
> > missing comma in front of The
> >
> > > > Instead of having just two states (off and on) the DSI hosts have
> > > > separate LP-11 state. In this state the host is on, but the video
> > > > stream is not yet enabled.
> > > >
> > > > Introduce API that allows DSI bridges / panels to control the DSI h=
ost
> > > > power up state.
> >
> > [1]
> > https://lore.kernel.org/dri-devel/6c0dd9fd-5d8e-537c-804f-7a03d5899a07@=
lina
> > ro.org/
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/drm_mipi_dsi.c | 31 ++++++++++++++++++++++++++++++=
+
> > > >  include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
> > > >  2 files changed, 56 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c
> > > > b/drivers/gpu/drm/drm_mipi_dsi.c index 14201f73aab1..c467162cb7d8
> > > > 100644
> > > > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > > > @@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
> > > >
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
> > > >
> > > > +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *h=
ost)
> > > > +{
> > > > +     const struct mipi_dsi_host_ops *ops =3D host->ops;
> > > > +
> > > > +     return ops && ops->power_up;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_control_available);
> > > > +
> > > > +int mipi_dsi_host_power_up(struct mipi_dsi_host *host)
> > > > +{
> > > > +     const struct mipi_dsi_host_ops *ops =3D host->ops;
> > > > +
> > > > +     if (!mipi_dsi_host_power_control_available(host))
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     return ops->power_up ? ops->power_up(host) : 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_up);
> > > > +
> > > > +void mipi_dsi_host_power_down(struct mipi_dsi_host *host)
> > > > +{
> > > > +     const struct mipi_dsi_host_ops *ops =3D host->ops;
> > > > +
> > > > +     if (!mipi_dsi_host_power_control_available(host))
> > > > +             return;
> > > > +
> > > > +     if (ops->power_down)
> > > > +             ops->power_down(host);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_down);
> > > > +
> > >
> > > If this API is supposed to be used by DSI devices, it should probably
> > > take a mipi_dsi_device pointer as a parameter?
> >
> > Ack.
> >
> > > We should probably make sure it hasn't been powered on already too?
> >
> > Ack, I can add an atomic count there and a WARN_ON. However I don't
> > think that it is a real problem.
> >
> > > Maxime
> >
> > --
> > With best wishes
> >
> > Dmitry
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>


--=20
With best wishes
Dmitry
