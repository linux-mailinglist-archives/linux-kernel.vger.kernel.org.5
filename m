Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CC80E8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjLLKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:18:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1395
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:18:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28abb3c5b9cso174115a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702376324; x=1702981124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSUO831C0k3zJ4lMk/4vhFQk4D7Yty6lM+SDoI+HnHs=;
        b=bE7xfcWCgQFy1Xw27iM2GJMs3C++p4JEyGs5Yu0bEPEwxqJRQW0r3y1yjx0H/4zQrX
         HYixvOfRzWsp1GI05apuLYgpAFJ9BuUafnNSGVoD65lM1Pwsc9BuaQ5amKs0+lHkwxCi
         KVI3hYWVaUuC1zGZ6hq7+HmUXL1x7r5Vw7lnOxAvBBXBAP7md43wSLnYAEzIg2q+vhPs
         I9ZA0kK6GRg2X6df1A0WP/uqJhgW2Q7a53CQBVk3/Mf6s/rUnQq4usylZRiRfQFHfPGn
         yNwuyZ2BvXu9cRi2Iw0avu+zrk/Q+EgVLdOOHzQDjk8rNMhAUgboVtS7zmcI0ds2Usvw
         G4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376324; x=1702981124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSUO831C0k3zJ4lMk/4vhFQk4D7Yty6lM+SDoI+HnHs=;
        b=RsG9PBFSElBLn8soh6Q7yZUhTmypmG3dDYaXy2qt7Rrw3p9jhTlrJR93eOUG3ES6ig
         XkkUqGOFT4DGjxz800eMPLCvBZDUXmRgDzWDC3t5e9yQ1buCNH9DSTEZqcmCd0Z9y6sX
         TD/JwL67xjh+4nBZHDU2HghRPyAN0q9iUEX0zDFvLPSK4OygKYyvszcnAl/jWCgavOG/
         XsigjwdGaMc7MQuL0YzAfZlHR8CaNZ5JRNrA6Ta1R9F5mJdec6VEiKAbSGgmoY3lV/SI
         C76IQoVRR8Bwvt3IaWWF78KeIC7Po0lj8QLIpNaj6o9cO23Xmo4oer63P7XBGv9KdRnn
         nV9g==
X-Gm-Message-State: AOJu0YyoH4X2sFBE3QZAbbacJDIRbPlbbSho/0bfNFD/4WIu8kOJZdqU
        0TvM6lI0rZK+hj+kyrtHGKKmU0FGrgvS35KIxUI=
X-Google-Smtp-Source: AGHT+IEwr8qiMkSf+0nazlS52eBLr0olBbN55l3LGQ5Nkz92qoHujo9VaP50vK9sUbgPdB3EW5DvktPKkO1yQd48Xps=
X-Received: by 2002:a17:90b:ec7:b0:28a:3526:a404 with SMTP id
 gz7-20020a17090b0ec700b0028a3526a404mr2331746pjb.32.1702376324117; Tue, 12
 Dec 2023 02:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20231212033259.189718-1-aford173@gmail.com> <6bdf9e39-e938-4644-b0ce-37191e1c00d2@kontron.de>
In-Reply-To: <6bdf9e39-e938-4644-b0ce-37191e1c00d2@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 12 Dec 2023 04:18:33 -0600
Message-ID: <CAHCN7xLSP22-37h7VfQScyVpW=-BcO6k+vvAqN0C+pVYo2=O-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: samsung-dsim: Set P divider based on
 min/max of fin pll
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
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

On Tue, Dec 12, 2023 at 2:25=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Adam,
>
> On 12.12.23 04:32, Adam Ford wrote:
> > The P divider should be set based on the min and max values of
> > the fin pll which may vary between different platforms.
> > These ranges are defined per platform, but hard-coded values
> > were used instead which resulted in a smaller range available
> > on the i.MX8M[MNP] than what was possible.
> >
> > Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference cl=
ock")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index be5914caa17d..239d253a7d71 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -573,8 +573,8 @@ static unsigned long samsung_dsim_pll_find_pms(stru=
ct samsung_dsim *dsi,
> >       u16 _m, best_m;
> >       u8 _s, best_s;
> >
> > -     p_min =3D DIV_ROUND_UP(fin, (12 * MHZ));
> > -     p_max =3D fin / (6 * MHZ);
> > +     p_min =3D DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
> > +     p_max =3D fin / (driver_data->pll_fin_min * MHZ);
>
> I did some tinkering with the PLL settings the other day and this is
> literally one of the things I came up with.
>
> So I'm happy to provide:
>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>

Thank you!

> Regarding the P divider, I'm also wondering if there is an upper limit
> for the p-value (not for the resulting fin_pll) that we should take into
> account, too. The problem is that we have conflicts in the documentation
> (again) so we don't really know what the correct limit would be.
>
> There are the following ranges given in the RMs:
>
> * 1..63 (i.MX8MM RM 13.7.8.18.4)
> * 1..33 (i.MX8MM RM 13.7.10.1)
> * 1..63 (i.MX8MP RM 13.2.3.1.5.2)
> * 1..63 (i.MX8MP RM 13.7.2.4)

1...63 (i.IMX8MN RM 13.7.2.4)
>
> Unfortunately there are similar discrepancies for the other parameters
> and limits.

For what it's worth, I compared these values to the NXP downstream
branch [1], and they seemed to indicate the values were as follows:

.p =3D { .min =3D 1, .max =3D 63, },
.m =3D { .min =3D 64, .max =3D 1023, },
.s =3D { .min =3D 0, .max =3D 5, },
.k =3D { .min =3D 0, .max =3D 32768, }, /* abs(k) */
.fin =3D { .min =3D 6000, .max =3D 300000, }, /* in KHz */
.fpref =3D { .min =3D 2000, .max =3D 30000, }, /* in KHz */
.fvco =3D { .min =3D 1050000, .max =3D 2100000, }, /* in KHz */

In a previous commit [2], I mentioned the fact that I reached out to
NXP asking about the discrepancies and my NXP Rep and I received the
response:

"Yes it is definitely wrong, the one that is part of the NOTE in
MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
not correct. I will report this to Doc team, the one customer should
be take into account is the Table 13-40 DPHY PLL Parameters and the
Note above."

adam

[1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/im=
x/sec_mipi_pll_1432x.h#L38C1-L47C1
[2] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/gpu/drm/bridge/samsung-dsim.c?h=3Dnext-20231212&id=3D54f1a83c=
72250b182fa7722b0c5f6eb5e769598d

>
> Thanks
> Frieder
>
> >
> >       for (_p =3D p_min; _p <=3D p_max; ++_p) {
> >               for (_s =3D 0; _s <=3D 5; ++_s) {
>
