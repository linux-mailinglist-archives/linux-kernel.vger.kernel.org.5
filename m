Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C8C751A80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGMH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:56:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FA2697
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:38 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3461163c0b6so1605595ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689234997; x=1691826997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWwEsAQnXaQRkW6Shvt1/+D7e1Ci6uGSzgoWth1dUeg=;
        b=n0SzY4H4kCH+4yBRfg+Ryn5JJzBOHQwYfP72Z54T9imN35vX4sSyky7tpSC/O7+Bvw
         u2owW/HzgWThDmMAkkfjheDgSCjycdrGijw3uWC9m1+gWLj8WDh7nTFpMMqE/qTmJP7a
         9wnJQAHSKZd82Q1YFCWTYhYL5wAqjupkpPVnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234997; x=1691826997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWwEsAQnXaQRkW6Shvt1/+D7e1Ci6uGSzgoWth1dUeg=;
        b=UkyeZa9gnG2w11F1PO1xyLqJ6WHyP0GNlpNA/VEKdCeEZI9QniY1QTNfpObURFheYn
         2fSQBGMSTVLOtqgsaVoNfVOE9FrjFDbufmPpAPnfXy9hkyp30GKDVXtkNm8EHx4xWYnv
         qZBHSWtcwbjFvPCsi+yOtiWMdBfRmHE/dZhC4X+XU8rCqqQtjAMjqW95y9N0bUkx3hHr
         Ai7VlLgPvR/SjQVwWq48oacAL/OzfVVXhpm9YBpHtCVfrh/yMHqrx9FxbNiFHlSPwn1Z
         sIwKZ+/8fIQJ6KaDcm2xBl4l+xG29je4qX0/Zfr9YQrBqWrLMRyCy1l1eYV0UtJ08gQ2
         5w2Q==
X-Gm-Message-State: ABy/qLZJCI+POzVT50U2tfzg2jJS03uOd0oMUMbART4KpNPWwwr3M26A
        6rDnRQYVR7KWdR+3OTTqFp6zVsCvtPgEAEBY5dI=
X-Google-Smtp-Source: APBJJlFwlaoOpq5sRfk+bkvqQ/xwPWqtJzT2Rglx7B+MZuApIb3V5Ue8dAaPIbthh9GHMUR+SHWaqA==
X-Received: by 2002:a92:4b0f:0:b0:345:b40e:43b3 with SMTP id m15-20020a924b0f000000b00345b40e43b3mr962778ilg.12.1689234997160;
        Thu, 13 Jul 2023 00:56:37 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id u3-20020a02c043000000b0042bb5a8e074sm1729522jam.8.2023.07.13.00.56.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:56:36 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7836164a08aso12558139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:36 -0700 (PDT)
X-Received: by 2002:a5d:850f:0:b0:786:6180:76f6 with SMTP id
 q15-20020a5d850f000000b00786618076f6mr1349053ion.12.1689234995825; Thu, 13
 Jul 2023 00:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com> <20230412115250.164899-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115250.164899-2-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 13 Jul 2023 15:55:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1nivzyX9+3EBtAG5dPmy-c6je74zmY68AXjyFvV2Pigqgg@mail.gmail.com>
Message-ID: <CAC=S1nivzyX9+3EBtAG5dPmy-c6je74zmY68AXjyFvV2Pigqgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Apr 12, 2023 at 7:53=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Change drm_bridge_add() to its devm variant to slightly simplify the
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 948a53f1f4b3..2d5f3fc34f61 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -1090,11 +1090,12 @@ static int mtk_dpi_probe(struct platform_device *=
pdev)
>         dpi->bridge.of_node =3D dev->of_node;
>         dpi->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
>
> -       drm_bridge_add(&dpi->bridge);
> +       ret =3D devm_drm_bridge_add(dev, &dpi->bridge);
> +       if (ret)
> +               return ret;

And also drop the drm_bridge_remove() call in mtk_dpi_remove()?

Regards,
Fei

>
>         ret =3D component_add(dev, &mtk_dpi_component_ops);
>         if (ret) {
> -               drm_bridge_remove(&dpi->bridge);
>                 dev_err(dev, "Failed to add component: %d\n", ret);
>                 return ret;
>         }
> --
> 2.40.0
>
>
