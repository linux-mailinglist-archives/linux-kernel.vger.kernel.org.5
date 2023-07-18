Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B897574D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGRHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjGRHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:01:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2AE70
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:00:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso79866e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689663658; x=1692255658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzieHZlpDOLsgEPivisv9+3RDs3SyQFnGZbkeHuzeX0=;
        b=np/Ysr8mFnATx1zGSjJaJBGBYCAYp8ngWc4vLS4YQ2TLze9a/kHLMsU7fUjND/pPf4
         jgy4m4GJVitBizM1aGRXQ78vBu2y5ZEOuYxE/fIoDV5qdl6UKPKqGE0DZBlSeAMrMCs6
         6e6x4gg0LruYJ5qulCOPP9MKR/3V9jUFZEx7tPVwre3/NXYVYWrtNkTI2ljPURj/RPKP
         I38ksF65IYD9pcaDpH/hvTkC9x8M9BbbdtlTykBNgpQom216hMO5YOgHbX6OFpVaAFmD
         osq0rbYlJlxgkkgaa9l2rd66vXBJnfcGxtL/KcgAYzDLs86tF+dStoW6SWf091UY94yT
         4tlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663658; x=1692255658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzieHZlpDOLsgEPivisv9+3RDs3SyQFnGZbkeHuzeX0=;
        b=RiX9fphEgdROBh0/c0shVYHCvBqsm7F77rwMTtIZEbNvIDbH2YJRVIBB5IAklKtO8Y
         nQUQGs6Ft57CX5NIbp7Zk4v8TS/s0WwlC7AB9RPo0uacZNfCtbhg+/FfkSz+cRD/cv0H
         tE89qyD1daJ9OKCvi4Zjooseu/vbne7faMov0PAib4zQH6FsNDbDpgB748OxVoyeE52K
         RbSEKT61qscYyZm9D9Xc9SCketDPBtm0BFaFm5sc7R3P4XL0ORPuJqkSEIVgEEKqMdNu
         Rhl7u5Yj0PzZ2ph4TDuiZSv4g0flGH+mu2Bz4HurfL2G+hGy098Am73/jdhgUGwMWeag
         wI0A==
X-Gm-Message-State: ABy/qLbhN7vEMIuRoXHXa89TH4LDf5RlYa/C7sBf/GrdH+dEE6csQqu6
        vQrf3DPw1x9rr6J8MIwtYp6pGpHMQldub+omfGw=
X-Google-Smtp-Source: APBJJlFHvd7M7a9soGmSZ+09TiCIcaPpyWtKjUfbn2SPfV0Vkwikg+WrazoT8xrn8UbRc9VLObqhfQ==
X-Received: by 2002:a19:e001:0:b0:4f9:6256:2a7e with SMTP id x1-20020a19e001000000b004f962562a7emr8964387lfg.31.1689663657398;
        Tue, 18 Jul 2023 00:00:57 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:4ac8:4223:8b53:53c1? (p200300f6ef0587004ac842238b5353c1.dip0.t-ipconnect.de. [2003:f6:ef05:8700:4ac8:4223:8b53:53c1])
        by smtp.gmail.com with ESMTPSA id x25-20020aa7cd99000000b0050488d1d376sm779394edv.0.2023.07.18.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:00:57 -0700 (PDT)
Message-ID: <1c3fde3a873b0f948d3c4d37107c5bb67dc9f7bb.camel@gmail.com>
Subject: Re: [PATCH V2] drm: adv7511: Fix low refresh rate register for
 ADV7533/5
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Alexandru Ardelean <alex@shruggie.ro>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     architt@codeaurora.org, bogdan.togorean@analog.com,
        nuno.sa@analog.com, daniel@ffwll.ch, airlied@gmail.com,
        jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, festevam@gmail.com
Date:   Tue, 18 Jul 2023 09:03:27 +0200
In-Reply-To: <20230718062854.29875-1-alex@shruggie.ro>
References: <20190716131005.761-1-bogdan.togorean@analog.com>
         <20230718062854.29875-1-alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-18 at 09:28 +0300, Alexandru Ardelean wrote:
> From: Bogdan Togorean <bogdan.togorean@analog.com>
>=20
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
>=20
> Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>=20

It looks like you dropped your S-o-b tag in v2? I guess it was not on purpo=
se :)

- Nuno S=C3=A1

> Changelog v1 -> v2:
> *
> https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@an=
alog.com/
> * added Fixes: tag
> * added Reviewed-by: tag for Nuno
>=20
> =C2=A0drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index ddceafa7b637..09290a377957 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(adv7511->re=
gmap, 0xfb,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A00x6, low_refresh_rate << 1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (adv7511->type =3D=3D ADV75=
11)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0regmap_update_bits(adv7511->regmap, 0xfb,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x6, low_=
refresh_rate << 1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0regmap_update_bits(adv7511->regmap, 0x4a,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xc, low_=
refresh_rate << 2);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_update_bits(adv751=
1->regmap, 0x17,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x60, (vsync_polarity << 6) | (hsync_polarity << 5)=
);
> =C2=A0

