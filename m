Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8B790F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 03:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348431AbjIDBFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 21:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjIDBFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 21:05:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFDBB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 18:05:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1121818a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693789533; x=1694394333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbVUwcw2PJC4RfyAHaiAoxmA0J3kEw6h6OC2FpKWQRY=;
        b=FuoDAc0CROG5x8mY7sIuAC2YSkD7+NVArWj2x8d+U+VfD8aj/D4mHWjCyJDERFxx2M
         IQYN4mwr3BU+Z8A4d1a9U9dEbC1UxajGlgd6g+wMQ4FFdi+AQ9Q16uYzoAUacivDW/br
         CmVfAf5vYwMjAbCBTViiCs3WVuPEwr+qEBif0VPB9fkzYD+WoDD7dqbVyFAf+tjGrAB8
         P48MFWir2lSQuiQa18WR2nmA1zGaylsTEg3kB72XmyYNLOUeZHyD+AfDv7KM8GvlEk0w
         XkNwe26WORwuA7SMNLhv3oWRT4OxbGVimhu57hkxOQmwBPx9vjIttJju/8hkJxqdnxVv
         uwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693789533; x=1694394333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbVUwcw2PJC4RfyAHaiAoxmA0J3kEw6h6OC2FpKWQRY=;
        b=c+rv5roFK5Fy1UP+uS9vLanhoF+/So4oCealKI10Z3/tfrc3FIm8NxOwix7nx3JIVC
         6VEHnNGVUAKqiR5MpVTKs4R90yML+BmWmcRE+RsrPUIkQUwvtL7xhjoFgw092NXEVWom
         DWwU9TLmjHx1sgN4i7Lk+dOdBIk0N2Jrg58iFchVuPHzLNwH+05eW3TsJfCZjWPogYxp
         VQ+uOHc9w8q5h1qrpmZwp+fJCr+WfvHZ7XJi7Vp2lHZZWI2spJoLuDO74jukUpYPmV+I
         FqviYEUQxutnsG8PWpZwiySdeG63VIJbyJ9gTNN8xeDo4WmwFHcNfcv0h7NxOKSEvpcW
         /Pzg==
X-Gm-Message-State: AOJu0Yxg5dDGRaau9hKRGoR4jWXN7Qniz6e348Wnnbd7Ypp9IGmmRLyD
        1cbUM35W4HGtig4kkOBH8kXAJYZrnOBtxNQJruA=
X-Google-Smtp-Source: AGHT+IGoOCM67CfAPti9p9KNf+sBBUTpbJt4yh8hMpYKIFaqa7GfnKeqIe49SGBnSowjTgY1/YMIZJCkjd4ei3FUKP4=
X-Received: by 2002:aa7:ca51:0:b0:523:4996:a4f9 with SMTP id
 j17-20020aa7ca51000000b005234996a4f9mr7087154edt.34.1693789533077; Sun, 03
 Sep 2023 18:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de>
 <20230818-samsung-dsim-v1-1-b39716db6b7a@pengutronix.de> <CAHCN7x+J_umWCBvivuZsrHTvjw=4CvBqOSeO-j_+fTMm=DdAOg@mail.gmail.com>
In-Reply-To: <CAHCN7x+J_umWCBvivuZsrHTvjw=4CvBqOSeO-j_+fTMm=DdAOg@mail.gmail.com>
From:   Inki Dae <daeinki@gmail.com>
Date:   Mon, 4 Sep 2023 10:04:55 +0900
Message-ID: <CAAQKjZM9UGgzAgfg-Rt92BNdvLuUJ90=QRUrd=FnDFwGvoC-zA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/bridge: samsung-dsim: add more mipi-dsi device
 debug information
To:     Adam Ford <aford173@gmail.com>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@pengutronix.de,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=EB=85=84 8=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 7:38, A=
dam Ford <aford173@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Aug 28, 2023 at 10:59=E2=80=AFAM Michael Tretter
> <m.tretter@pengutronix.de> wrote:
> >
> > From: Marco Felsch <m.felsch@pengutronix.de>
> >
> > Since the MIPI configuration can be changed on demand it is very useful
> > to print more MIPI settings during the MIPI device attach step.
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>
> Reviewed-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon
> Tested-by: Adam Ford <aford173@gmail.com>  #imx8mm-beacon

Reviewed-by: Inki Dae <inki.dae@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>

>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 73ec60757dbc..6778f1751faa 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1711,7 +1711,10 @@ static int samsung_dsim_host_attach(struct mipi_=
dsi_host *host,
> >                 return ret;
> >         }
> >
> > -       DRM_DEV_INFO(dev, "Attached %s device\n", device->name);
> > +       DRM_DEV_INFO(dev, "Attached %s device (lanes:%d bpp:%d mode-fla=
gs:0x%lx)\n",
> > +                    device->name, device->lanes,
> > +                    mipi_dsi_pixel_format_to_bpp(device->format),
> > +                    device->mode_flags);
> >
> >         drm_bridge_add(&dsi->bridge);
> >
> >
> > --
> > 2.39.2
> >
