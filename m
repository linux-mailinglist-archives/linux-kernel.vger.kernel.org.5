Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D872E79409A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbjIFPnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIFPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:42:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F91724
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:42:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so238665366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694014970; x=1694619770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/MJXhHq22hXwGov3L8E3lwBxOOyN2+wzo2q2f2Z9Pw=;
        b=htm3ScMb7k9ZdzgaBX3Hucep4LCdH1lF+FhTqifvY8CRkNOq/bNCOsw8tBMnA3zdL9
         jSNUjOlIdNskAC2S2G53BGNX5sYJ1cAfypgDf2Zo53cyQ3jsaxjd+oM2s1/N0ABcu7QN
         rfTFo9g6qk1B4cEfKBQUOWfabTKWr3NpjXfg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014970; x=1694619770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/MJXhHq22hXwGov3L8E3lwBxOOyN2+wzo2q2f2Z9Pw=;
        b=kmetblQeQQNo/iq0MiynaEZnlfNz+L30xpak4DessrI0WFSRS5W2c3fDADx1w1TKM/
         zu2TQ+itdYO6g6y4aUMOV/2S2c7CLTtYu5ukdZdikZ6sgQ9aw5rlLo6tmhhoYA5frTFf
         OwapDCGo+EOtC9L3ge6DMxOX0gmt/cB6lOwhWxIm3gIp0P6cMm1wCPbZRcHnGvAja2KO
         dwY16myzuEcKjajd8iKCpDHrUFogufJcsyrXyLEbaPC5FbNyzvgK946V7HErS0De2zSh
         XEtWM5Py5C4bMzmNtjpH6HViIImQa2zzbdSOR55nhuCcujOoet12KoKmYVkglojQ4hAs
         rOOg==
X-Gm-Message-State: AOJu0YxKhPqj2cWzDNF8U+CeEfKdUQ4S2gc0/3UB7bNALFgkwRPjkZiN
        X+YXm5cJoUv7yENSkeNxqatUIjYfKRWfHunbkS++Kv2s
X-Google-Smtp-Source: AGHT+IGx17GizNKtiflhO8R9lyTygY46/UcJ1kRVQf6/zoxGsfVVRCVmiPjA+4YI1u/jehT6lolpjw==
X-Received: by 2002:a17:907:9619:b0:9a1:e0b1:e919 with SMTP id gb25-20020a170907961900b009a1e0b1e919mr3419121ejc.4.1694014970747;
        Wed, 06 Sep 2023 08:42:50 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b0098669cc16b2sm9118261ejb.83.2023.09.06.08.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 08:42:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so13417a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:50 -0700 (PDT)
X-Received: by 2002:a50:a6de:0:b0:528:ef2:7613 with SMTP id
 f30-20020a50a6de000000b005280ef27613mr163805edc.7.1694014949290; Wed, 06 Sep
 2023 08:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com> <20230831080938.47454-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230831080938.47454-4-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Sep 2023 08:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRZz8W91U=9krOsKgtNmK_PAEg4c6OXtbJiLJcstSvYA@mail.gmail.com>
Message-ID: <CAD=FV=XRZz8W91U=9krOsKgtNmK_PAEg4c6OXtbJiLJcstSvYA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] drm/bridge: Drop CONFIG_OF conditionals around
 of_node pointers
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhu Wang <wangzhu9@huawei.com>,
        =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        Rob Herring <robh@kernel.org>, Sandor Yu <Sandor.yu@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 1:10=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Having conditional around the of_node pointers turns out to make driver
> code use ugly #ifdef and #if blocks. So drop the conditionals.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v5->v6:
>  * Added Rb tag from Douglas Anderson.
>  * Dropped conditionals from remaining drm/bridge drivers.
> v5:
>  * Split from patch#2
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 2 --
>  drivers/gpu/drm/bridge/panel.c                     | 2 --
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 2 --
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 2 --
>  4 files changed, 8 deletions(-)

I think this has had enough time to marinate, so landed to drm-misc-next:

481fc9e7e11d drm/bridge: Drop CONFIG_OF conditionals around of_node pointer=
s
