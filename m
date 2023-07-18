Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB67576A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGRIfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGRIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:35:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617BE4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:35:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso8869861e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689669316; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FAjjlFJMhYYhEn4cuk55R7hTz2rcMK9MMxmywNIilg=;
        b=us7q9Q7bMQD6QiZGe7pAzDFn9TJxGirtRL8iZql96Zy6630wyGXPeHXYKmndc2adge
         defvKpa39g1PLfi/Qa87PSa5VjYDOFj1/sf26QrS6bvKBfVyEjHRgTEF931rQ633349i
         HiAd8ubJEEeXEHnxixYxEbTGGUv8HSMEOvrAMko7piHcGLxcHEXH3GSpxck8UYBgmYUG
         CaefSXyl9tInyUc97WnYFdQF+3/x+o1hg2DOlUXpSlz30iCHlxb1TqIGqDwnBEHEKvzk
         cKFQAZOnu1piVVjEyOAwFh076QZtXqZT152xYMsoV0M+e62CCOHazXpJp+ooaTT9P0wJ
         9S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669316; x=1692261316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FAjjlFJMhYYhEn4cuk55R7hTz2rcMK9MMxmywNIilg=;
        b=NoeSqywbIhQjrrrkuuxTVVL0h/EvJ89KTOiekhWIc89O66XSmTendf/kJA2sgGqrIx
         /3Rd3vHFE7TDNa/7BetsRD0DNFi38YU0lQ03eGAPfc9pr0ue/G0B1kUjEUzZK/nocRq0
         LCxtEB4SEeVom3/NhhCNrQSsQ3DowhsuyQBx43llcoPbLqnb5IqFp5vIC63QKKuVy6gV
         CJoXGB5w3yfBsbPJgM9onwW1twr1DH/FcU1/AgudJxAajZgHsRyuAP+87al41PHpzAgU
         /Jto7cXinnWhwobmJHMHki1Iinc6RgQPvcCBbUh2ZzNHhgCd8/qr+aZEogsIwzKbZwPY
         3oRQ==
X-Gm-Message-State: ABy/qLYYmJlORn480NLr/1OAdItLwk+iw0t/56hUK97+jUm1cvdrSI/w
        FI2HaI07+uYE4/43D9xOD8KCBG/G3Dpt8HsVXlIxiw==
X-Google-Smtp-Source: APBJJlEJn1y3olhyRFcIsFIYaiJDoObNMuP+6Cs83oTwOX312nUsL5Z1YPgoLWGUZh71ZI4HY5BOOq9Vnc6ESIcr0Wg=
X-Received: by 2002:a2e:9891:0:b0:2b6:d6e1:a191 with SMTP id
 b17-20020a2e9891000000b002b6d6e1a191mr1205288ljj.23.1689669315761; Tue, 18
 Jul 2023 01:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190716131005.761-1-bogdan.togorean@analog.com>
 <20230718062854.29875-1-alex@shruggie.ro> <1c3fde3a873b0f948d3c4d37107c5bb67dc9f7bb.camel@gmail.com>
In-Reply-To: <1c3fde3a873b0f948d3c4d37107c5bb67dc9f7bb.camel@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 18 Jul 2023 11:35:04 +0300
Message-ID: <CAH3L5Qq5t3FgMCCF7YB7-W1R2kewz_OFFETz1NQc_K5egfps=w@mail.gmail.com>
Subject: Re: [PATCH V2] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        architt@codeaurora.org, bogdan.togorean@analog.com,
        nuno.sa@analog.com, daniel@ffwll.ch, airlied@gmail.com,
        jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, festevam@gmail.com
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

On Tue, Jul 18, 2023 at 10:00=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> On Tue, 2023-07-18 at 09:28 +0300, Alexandru Ardelean wrote:
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
> > ---
> >
>
> It looks like you dropped your S-o-b tag in v2? I guess it was not on pur=
pose :)

oops; yes;
will send a V3;

thanks for the notification;

>
> - Nuno S=C3=A1
>
> > Changelog v1 -> v2:
> > *
> > https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@=
analog.com/
> > * added Fixes: tag
> > * added Reviewed-by: tag for Nuno
> >
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
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
>
