Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD32809E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573314AbjLHIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:34:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B9BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:34:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso21751651fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702024492; x=1702629292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlzW/rf2HelGsf6Q2WVJDDVEnvIjksUp/xAKKkchs/Y=;
        b=WLxGB9DpUBIPH3dL08WfvaVYPCcX0wLMGixjrcMH2TP4zJsJB4X7j1IWUzsBxxZvl4
         1ffBcxZGwU9X7tCJiSehTUaPcGSCm+qaq7+CxT9ZWW3YPexZxfzmnWvQB9OiecDzNjCt
         caIF1aTCdC9Bl0KhKXfJWjB5HLlIp1PuQLju0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024492; x=1702629292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlzW/rf2HelGsf6Q2WVJDDVEnvIjksUp/xAKKkchs/Y=;
        b=fJEtq3SKTcHN/dPXV3R2EUuK0Fdz+fehpUP5FAuNAJOvAtOdcTk9a7dlmNJDdc+B3A
         VUEBpiLC4tJp1kLNn+laoFqI9wwgxuOyHSdp/UusVrOWFoNXkj03i9U+UEOjOuoNehaB
         czeuE1eJivt6PmyzWme6DHeOdEpZaEKfJo0ntOT++hd9+yS+Rvh66tMuOU8om6Q9p7FL
         HFGjHvZ2W/ox5bxavANxcLIeRk5JKopHCYQRJwirP3G3O+5fGp0TVYtGTZrfV/vgN+0n
         DjdrIS/7iWVAA1ono5QFEPCMgayReLh7er9xySBvTJ06iy1kPjx4VeWzrAao9+Y5z+79
         K7Nw==
X-Gm-Message-State: AOJu0Yw2ylHWQQqkJJSrl5nS9N9BXgxxUtOtfNtYoTQdBKVDnX8IYow6
        ckzInZlGANhALYM91aADtKgnaAH9ImjXZpTpCQrt4w==
X-Google-Smtp-Source: AGHT+IHYQcXvlIHXkV8cyjUJ8LSw43LcQtotQfIhLDNGWBEFVxXJ+v1X/BS2BxUNwhyW1CzLftaqo0T1DNz3Z4mDFeo=
X-Received: by 2002:a2e:98d4:0:b0:2ca:14ef:3845 with SMTP id
 s20-20020a2e98d4000000b002ca14ef3845mr1210470ljj.160.1702024491938; Fri, 08
 Dec 2023 00:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
 <20231207141723.108004-5-dario.binacchi@amarulasolutions.com> <21e1b508-328a-4ec0-9f1f-75773f2686c3@kontron.de>
In-Reply-To: <21e1b508-328a-4ec0-9f1f-75773f2686c3@kontron.de>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 8 Dec 2023 09:34:41 +0100
Message-ID: <CAOf5uwmcCA8hxeDv4dDPe1PRag2Gj_myHrGhuF7c2=-e=NPcfQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] drm: bridge: samsung-dsim: complete the
 CLKLANE_STOP setting
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder

On Thu, Dec 7, 2023 at 5:58=E2=80=AFPM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 07.12.23 15:16, Dario Binacchi wrote:
> > The patch completes the setting of CLKLANE_STOP for the imx8mn and imx8=
mp
> > platforms (i. e. not exynos).
>
> This also affects i.MX8MM, so better just mention i.MX in general in the
> commit message.
>
> >
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 15bf05b2bbe4..13f181c99d7e 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -96,6 +96,7 @@
> >  #define DSIM_MFLUSH_VS                       BIT(29)
> >  /* This flag is valid only for exynos3250/3472/5260/5430 */
> >  #define DSIM_CLKLANE_STOP            BIT(30)
> > +#define DSIM_NON_CONTINUOUS_CLKLANE  BIT(31)
> >
> >  /* DSIM_ESCMODE */
> >  #define DSIM_TX_TRIGGER_RST          BIT(4)
> > @@ -945,8 +946,12 @@ static int samsung_dsim_init_link(struct samsung_d=
sim *dsi)
> >        * power consumption.
> >        */
> >       if (driver_data->has_clklane_stop &&
> > -         dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
> > +         dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
> > +             if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> > +                     reg |=3D DSIM_NON_CONTINUOUS_CLKLANE;
> > +
> >               reg |=3D DSIM_CLKLANE_STOP;
> > +     }
>
> I really wonder what the difference between DSIM_NON_CONTINUOUS_CLKLANE
> and DSIM_CLKLANE_STOP is.
>
> If Exynos only has the latter, it's pretty clear what to use. But as
> i.MX has both of these bits, should both be set? Or is setting
> DSIM_NON_CONTINUOUS_CLKLANE enough and we should leave DSIM_CLKLANE_STOP
> alone?
>

We add the DSIM_NON_CONTINUOUS_CLKLANE because there was a similar
commit in NXP bsp.
Now according to the datasheet the DSIM_NON_CONTINUOUS_CLKLANE should
be the right bit.

NXP guys should clarify then a bit

Michael

> Maybe someone has a clue here. The description of the bits in the RM is:
>
> DSIM_NON_CONTINUOUS_CLKLANE - Non-continuous clock mode
> DSIM_CLKLANE_STOP -  PHY clock lane On/Off for ESD
>
> >       samsung_dsim_write(dsi, DSIM_CONFIG_REG, reg);
> >
> >       lanes_mask =3D BIT(dsi->lanes) - 1;
