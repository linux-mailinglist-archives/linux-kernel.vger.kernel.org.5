Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA177852DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHWIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjHWIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:36:51 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439711721
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:35:01 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-48f7e0d46e0so870871e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692779700; x=1693384500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmMZFZ62OdIAtWcX5zw3zpQ/Qr+ShV602MOY+LKIebw=;
        b=aSQ7medMm32HRzU8weU8tNYTnPBrEEFQ41Kbmbur21/iF3yhiy/NKXSjPFkJmK47ce
         bLOyRL2bjw153X6Zfwi5lIUgdDgBV2F3vQilek37DvEZdVgNnc4KT3GmiQLXPZQAlUJC
         qynbBKaZYR7QVIC3/bxEKKUVTr1QP0b3/ezgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692779700; x=1693384500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmMZFZ62OdIAtWcX5zw3zpQ/Qr+ShV602MOY+LKIebw=;
        b=gJvAc7LvXBN99g/xyMB5fetMf+l/WLRS+GZ4aaSPH7xgFww3nObGimiWxglOiSTrrr
         rwOX3vMIPZK8B+ASgEdBQTUejcqpT3IIIGMEm5YtQ1FK7khhlnf5pIXj1dcZrns3K59H
         lKItxp2qmIexdY0pnwHkYW5DbsekSfmsSrf+d0YXl4k4IcTFD2gE4dseDZJUftkBpFR3
         qBfqNzAwG/0XHlLEepURnETNUssHZYQOEo1Big8f7PA20eAwVMErpXGe3jtCTxwdWbkE
         fmjuOHjDKoqhsYqqgziTo7rLyqNRfp9P4Os5SX3MM1nyXIdzIfBlSVULbwXstW5JXd/7
         LT4A==
X-Gm-Message-State: AOJu0Yy6aB0tTLKqKpIJSLXO5HvBeeWyO4utSRHYwbz8VnZ9dj8mXwRy
        umVzM6V76J07S1MvD4PYP5Q49p4FJSSe3w0sCy7mvQ==
X-Google-Smtp-Source: AGHT+IGSDVGVupZv/MLbXhRgCOL+pMnSbFh3lgLbXxMSB5Hcf2CbFqQt0tXsFwyI797JMNTB1vUE2gYu9sF1UiFPuZQ=
X-Received: by 2002:a1f:cd85:0:b0:48d:2a1:5d26 with SMTP id
 d127-20020a1fcd85000000b0048d02a15d26mr9307618vkg.4.1692779700344; Wed, 23
 Aug 2023 01:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230823082549.24756-1-shuijing.li@mediatek.com>
In-Reply-To: <20230823082549.24756-1-shuijing.li@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 23 Aug 2023 16:34:49 +0800
Message-ID: <CAGXv+5FKpt0uxPPBTd0D0+PSD068NJFSf2AuQ5nckK8KW7WNag@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Support IGT in dp driver
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:25=E2=80=AFPM Shuijing Li <shuijing.li@mediatek.c=
om> wrote:
>
> Support IGT (Intel GPU Tools) in Mediatek DisplayPort driver

The commit message makes little sense.

First of all, you are changing the DSI driver, not the DisplayPort driver.

Second, the subject should say what was changed. In this case it would be
something like "Add mode_valid callback to DSI bridge". "Support IGT" is
*why* the change was done, should only be mentioned in the commit message
body, and you could be more specific about which test in IGT needs it.

ChenYu

> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 7d5250351193..a494e04f0ddf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -806,6 +806,25 @@ static void mtk_dsi_bridge_atomic_post_disable(struc=
t drm_bridge *bridge,
>         mtk_dsi_poweroff(dsi);
>  }
>
> +static enum drm_mode_status
> +mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
> +                         const struct drm_display_info *info,
> +                         const struct drm_display_mode *mode)
> +{
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +       u32 bpp;
> +
> +       if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> +               bpp =3D 16;
> +       else
> +               bpp =3D 24;
> +
> +       if (mode->clock * bpp / dsi->lanes > 1500000)
> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs =3D {
>         .attach =3D mtk_dsi_bridge_attach,
>         .atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> @@ -815,6 +834,7 @@ static const struct drm_bridge_funcs mtk_dsi_bridge_f=
uncs =3D {
>         .atomic_pre_enable =3D mtk_dsi_bridge_atomic_pre_enable,
>         .atomic_post_disable =3D mtk_dsi_bridge_atomic_post_disable,
>         .atomic_reset =3D drm_atomic_helper_bridge_reset,
> +       .mode_valid =3D mtk_dsi_bridge_mode_valid,
>         .mode_set =3D mtk_dsi_bridge_mode_set,
>  };
>
> --
> 2.40.1
>
