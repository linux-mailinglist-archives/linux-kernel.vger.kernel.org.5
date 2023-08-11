Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695C779091
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHKNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99F26B6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3372865CD5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894B0C43391
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691759746;
        bh=Q0V13OvTHe22/UjIUzwrCyQ9TTmZy8aejdY20cqAG8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l/MFQNi10259REPnnmXhsqSwMU/qesqqzavqh/Lwge8kk8X6NeuYaKDZ7CObdA/bt
         2t+uXedSVWSuiqum9f5cu7CtrkX5XsyJOeEYApBAi095lHz83YnJbLxaOluVLsrIt/
         TfdCph7Rx1XiV1iEeYShZdeeOjMJO9BaywnurXerHDPNJJ0a9xl48LyTTCYVSaLRPr
         Q5TNgttJyi/LaSy6t1Kmk63UWKNVc7D4A6vBvy094SDbJDxn5Oaf2Wa+5ry/fuSWQV
         B5SAmZHZEFCyG7yP+uxjEapsyOkSzugClyCeL1NAPjzCh7m44t515UX32u8OlA1PQZ
         ES/sqsalLarJQ==
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-564b6276941so1509127a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:15:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx06dnCqJgai8wrh6vECfbHPetPlZMa8kskjHVAyWKIdb9GywOg
        iVZaXYdPJ6KYtV1mCMILSp41ZzsMRN5CjpQsJ2UzSQ==
X-Google-Smtp-Source: AGHT+IFsx8ruCT10pi0Uvkim3EB925uy1uvWlf2H32E00/+oatvZRAK9RYhOqodjK7V6u3DS6y4x+dP3yrMDsbE7JQs=
X-Received: by 2002:a17:90a:fd89:b0:268:1e51:3496 with SMTP id
 cx9-20020a17090afd8900b002681e513496mr1504264pjb.21.1691759746112; Fri, 11
 Aug 2023 06:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org> <20230810101203.GB402@pendragon.ideasonboard.com>
In-Reply-To: <20230810101203.GB402@pendragon.ideasonboard.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 11 Aug 2023 15:15:35 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4EUutDP1Dsq5CWEyPMe4n7yG1QGDeG1HM3DL+9+qrXmg@mail.gmail.com>
Message-ID: <CAN6tsi4EUutDP1Dsq5CWEyPMe4n7yG1QGDeG1HM3DL+9+qrXmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: adv7511: fix Wvoid-pointer-to-enum-cast warning
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        lima@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Qiang Yu <yuq825@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:12=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Krzysztof,
>
> Thank you for the patch.
>
> On Thu, Aug 10, 2023 at 11:59:22AM +0200, Krzysztof Kozlowski wrote:
> > 'type' is an enum, thus cast of pointer on 64-bit compile test with W=
=3D1
> > causes:
> >
> >   adv7511_drv.c:1214:19: error: cast to smaller integer type 'enum adv7=
511_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> > ---
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index 2611afd2c1c1..0e284f379602 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -1211,7 +1211,7 @@ static int adv7511_probe(struct i2c_client *i2c)
> >       adv7511->status =3D connector_status_disconnected;
> >
> >       if (dev->of_node)
> > -             adv7511->type =3D (enum adv7511_type)of_device_get_match_=
data(dev);
> > +             adv7511->type =3D (uintptr_t)of_device_get_match_data(dev=
);
> >       else
> >               adv7511->type =3D id->driver_data;
> >
>
> --
> Regards,
>
> Laurent Pinchart
>

Ack for drm/bridge part.

Acked-by: Robert Foss <rfoss@kernel.org>
