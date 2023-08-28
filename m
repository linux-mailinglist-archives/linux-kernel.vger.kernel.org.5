Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460B78BB17
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjH1Wlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjH1Wl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:41:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A3139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:41:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564af0ac494so1767081a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693262486; x=1693867286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiU0nSh/bDTOdlRqfdKlunOzKHHTp7UUw1xqmuzkCtg=;
        b=bZHgunuHjmRJzBHOCVfP5J2P1Hzlf0RqyBl2p8RSON21PYnv8kJpWTJhnxu0/YIGF8
         MrQjSiWqo0Hc85WHJwS0LPZmCbtda9bU65vOyzbbAL13lL6d/xN+o/ynngDR9YGms5VV
         6VwdMPtLhxwvh6JcCi6NeHNDthR5RhpjrtjhJYSHrpQCjiNSGHAIqsFv9ci2+LUn6Dml
         E1oB8XI12ABw3QSX4SNWTJos/LwzOmMS5p0WmJZSxXCoOqrqU+bTIZv+hBe6pWuJ3Mvx
         a5s3DIto8pm2pv3lZyty04JeKjyL8zuR6SVOG1cTsBlQQoTRpQEvNZjLipw+l+ETsPat
         X+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262486; x=1693867286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiU0nSh/bDTOdlRqfdKlunOzKHHTp7UUw1xqmuzkCtg=;
        b=cqzg+HAmHqR3E9JGMLpuw2LVWWktp7ckYoH6GV2NNyI7zeGvLIqsOASojh0i38DBjT
         0/wDyEiFUEdNsrLLvDtX+ZHV9OHdljZJKJJlglBU8ewiaQ/gw9+QQq22qY4kvsKZC0uw
         8fXqH61CRzFq+uXYY9360iZnXtWVPqkTWVAZRJI9gfD/rmo56Q5xg7MnraImji5z+cm3
         NCF5K9d5b47waKaaoKwY96GI6LzxW6Az4O58cTiVwlKAcAPRdZ9r6U9yjOaSZnK91TfL
         1K75ezOJw8JNsmA5PDedJMsYHxVOGjgM8pHo+bx/2VoM6ypFyHnyDaJyNVLrOp/8UsNw
         QIqA==
X-Gm-Message-State: AOJu0YxJIQMpz88k924Ss9WzCcvUDXO3iP1HLRDK/yvsm3YlKKLkJiWd
        yj+sJaRJXT1rroKz3I8md67TWvRL7zQyyBG8o/g=
X-Google-Smtp-Source: AGHT+IFE0R3zk5BaHdObWy4m8qUsCAB6DTesmPBPjMdLOtf7rLPpfvqYDTIRJhUvA44rqwAMR6iwgqa+ar6IbJyx+nw=
X-Received: by 2002:a17:90b:8d4:b0:268:6060:c184 with SMTP id
 ds20-20020a17090b08d400b002686060c184mr21076376pjb.45.1693262485738; Mon, 28
 Aug 2023 15:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de> <20230818-samsung-dsim-v1-5-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-5-b39716db6b7a@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Aug 2023 17:41:14 -0500
Message-ID: <CAHCN7xK0J2wZj7Jxgug2vGaCg0A9+RKEmXgBGaNBSk3pXDyrHg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/bridge: samsung-dsim: calculate porches in Hz
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:59=E2=80=AFAM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> Calculating the byte_clk in kHz is imprecise for a hs_clock of 55687500
> Hz, which may be used with a pixel clock of 74.25 MHz with mode
> 1920x1080-30.
>
> Fix the calculation by using HZ instead of kHZ.
>
> This requires to change the type to u64 to prevent overflows of the
> integer type.
>
I would argue this needs a fixes tag since the previous calculations
were not accurately generated for many resolutions and refresh rates.

Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon

> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 459be953be55..eb7aca2b9ab7 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -973,10 +973,12 @@ static void samsung_dsim_set_display_mode(struct sa=
msung_dsim *dsi)
>         u32 reg;
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               int byte_clk_khz =3D dsi->hs_clock / 1000 / 8;
> -               int hfp =3D DIV_ROUND_UP((m->hsync_start - m->hdisplay) *=
 byte_clk_khz, m->clock);
> -               int hbp =3D DIV_ROUND_UP((m->htotal - m->hsync_end) * byt=
e_clk_khz, m->clock);
> -               int hsa =3D DIV_ROUND_UP((m->hsync_end - m->hsync_start) =
* byte_clk_khz, m->clock);
> +               u64 byte_clk =3D dsi->hs_clock / 8;
> +               u64 pix_clk =3D m->clock * 1000;
> +
> +               int hfp =3D DIV64_U64_ROUND_UP((m->hsync_start - m->hdisp=
lay) * byte_clk, pix_clk);
> +               int hbp =3D DIV64_U64_ROUND_UP((m->htotal - m->hsync_end)=
 * byte_clk, pix_clk);
> +               int hsa =3D DIV64_U64_ROUND_UP((m->hsync_end - m->hsync_s=
tart) * byte_clk, pix_clk);
>
>                 /* remove packet overhead when possible */
>                 hfp =3D max(hfp - 6, 0);
>
> --
> 2.39.2
>
