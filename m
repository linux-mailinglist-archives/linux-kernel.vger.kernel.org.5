Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81C757ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGRLqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGRLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:46:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F51B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:46:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so85092971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689680762; x=1692272762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kahMnjiGb0a+BAKQ+PGSCJLgK5Xwr5yNiHBFNUBoTw=;
        b=vyFCR+ny/btEupQuRxIlDOiNfd1dSyBqFLdX4PL1+tEBLB8u/WdH4NJjw3PcaUWz1D
         dNOyoFsRg/sRcROztZ06d6I8trHoDGC1eDldxrwPyo6hHr9Hz+gS6SaauPpSO05kfQd1
         LpVYQkSrnzvyyVgYbdy6sD9+TOVj/lncOrgYwLzM9Prgo0btROG8+EXEFtM9QLSzxeuW
         jn1o64Lk/UD2bh/lMDdOIP5QwnAL44frwEp+J4RjrReCLc318DTKEKn3UcTIp3RNzTrf
         foRHPNx0pR2jkjLtujeXjBaYsUbNwufufkUKdONnXJK50Htj9L14Gk2y5sopY8OxZ1kk
         Rsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680762; x=1692272762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kahMnjiGb0a+BAKQ+PGSCJLgK5Xwr5yNiHBFNUBoTw=;
        b=EgN5/T/KgizFuT4m3dpPwKTWKZ/wgYkJ5wEGratIEhc0Ea8zSaJNvaV6LCBWc2Uzpf
         3eEczjb9oztsnN4FGvQl1ck/+z8fXtqxgv1k+pYdr/3KU2Oi7JMm5PpZFx3Dot5xlG/g
         Yk951oEdVG3NFUo5cnyKx8d7xa0v2DUC8B2IW+iyyp5e39lMndC/xFFs39oCtGqbOWKc
         9a5rmj7NxSXesv3Jml23of8q4goB2odbSi4YLRmByKVGJdJsG28znBd5sYFf8TFkNrBP
         allkZAAQCGBtOVpTZNLY9ZW3e6mweaL3rhD9VRVqDTr9R9wAxtyvCME17EIzvYO0gS7B
         nrIA==
X-Gm-Message-State: ABy/qLYfXvbEDoaZ8cGFv5cghJyeBXRHIPYL+qaw5DcN2hkKOIOXpihv
        pA2GWZlkGGDBJVE/cTRpmQKmF5J4J6Vogn0ER+Zdzw==
X-Google-Smtp-Source: APBJJlHFP6SXU1NB/79g7oicNLEruyE/4c19mGoJXPpXQGAUSi9zbmzTwRjfkyxMvFrMCqcm+hhGqkWP5xVT9VedvN4=
X-Received: by 2002:a05:651c:233:b0:2b6:d47f:2a4 with SMTP id
 z19-20020a05651c023300b002b6d47f02a4mr5142113ljn.13.1689680762245; Tue, 18
 Jul 2023 04:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190716131005.761-1-bogdan.togorean@analog.com>
 <20230718084215.12767-1-alex@shruggie.ro> <CAN6tsi5+WV65FSpuzjJY46beHU8SkOMYfZNS3DnXiVft_6MG4A@mail.gmail.com>
In-Reply-To: <CAN6tsi5+WV65FSpuzjJY46beHU8SkOMYfZNS3DnXiVft_6MG4A@mail.gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 18 Jul 2023 14:45:51 +0300
Message-ID: <CAH3L5QoYgU7HVF-Dc2ZJVcK-paoxwh0ZHWWxBhYudm+Mjvt7tA@mail.gmail.com>
Subject: Re: [PATCH v3] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     Robert Foss <rfoss@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bogdan.togorean@analog.com, nuno.sa@analog.com, daniel@ffwll.ch,
        airlied@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:50=E2=80=AFAM Robert Foss <rfoss@kernel.org> wro=
te:
>
> On Tue, Jul 18, 2023 at 10:42=E2=80=AFAM Alexandru Ardelean <alex@shruggi=
e.ro> wrote:
> >
> > From: Bogdan Togorean <bogdan.togorean@analog.com>
> >
> > For ADV7533 and ADV7535 low refresh rate is selected using
> > bits [3:2] of 0x4a main register.
> > So depending on ADV model write 0xfb or 0x4a register.
> >
> > Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533"=
)
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >
> > Changelog v2 -> v3:
> > * https://lore.kernel.org/dri-devel/1c3fde3a873b0f948d3c4d37107c5bb67dc=
9f7bb.camel@gmail.com/T/#u
> > * Added my S-o-b tag back
> >
> > Changelog v1 -> v2:
> > * https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorea=
n@analog.com/
> > * added Fixes: tag
> > * added Reviewed-by: tag for Nuno
> >
> >
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index ddceafa7b637..09290a377957 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv75=
11,
> >         else
> >                 low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
> >
> > -       regmap_update_bits(adv7511->regmap, 0xfb,
> > -               0x6, low_refresh_rate << 1);
> > +       if (adv7511->type =3D=3D ADV7511)
> > +               regmap_update_bits(adv7511->regmap, 0xfb,
> > +                       0x6, low_refresh_rate << 1);
> > +       else
> > +               regmap_update_bits(adv7511->regmap, 0x4a,
> > +                       0xc, low_refresh_rate << 2);
> > +
> >         regmap_update_bits(adv7511->regmap, 0x17,
> >                 0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
> >
> > --
> > 2.41.0
> >
>
> This looks good, but I'm seeing some checkpatch style warnings, with
> those fixed feel free to add my r-b.

Thanks.
Will do.
May I ask what options you are using for checkpatch.pl?
I don't seem to get those warnings.
And I'm basing on an "exynos-drm-fixes"branch from here
   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git/
(I'll admit it may not be the correct branch)

# /scripts/checkpatch.pl
v3-0001-drm-adv7511-Fix-low-refresh-rate-register-for-ADV.patch
total: 0 errors, 0 warnings, 15 lines checked

v3-0001-drm-adv7511-Fix-low-refresh-rate-register-for-ADV.patch has no
obvious style problems and is ready for submission.


>
> CHECK: Alignment should match open parenthesis
> #32: FILE: drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:791:
> +        regmap_update_bits(adv7511->regmap, 0xfb,
> +            0x6, low_refresh_rate << 1);
>
> CHECK: Alignment should match open parenthesis
> #35: FILE: drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:794:
> +        regmap_update_bits(adv7511->regmap, 0x4a,
> +            0xc, low_refresh_rate << 2);
>
> total: 0 errors, 0 warnings, 2 checks, 15 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> Commit 1955dfe734e4 ("drm: adv7511: Fix low refresh rate register for
> ADV7533/5") has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
