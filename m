Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3BA751BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjGMIj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjGMIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:39:44 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6E2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:34:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3466725f0beso1727025ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689237292; x=1691829292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyEkQpgIXNpGAjYikyKRrMbeGwRnjSnhMc5RNVKg7IY=;
        b=SuN0gI3WYHAX8shoQNwqeFprlVQ8IlcjG4+vVg3/k+WlhXvoKWl8Oyqp7BzSja8Ovm
         rflXUmOOO+A+Cbj3R1HjaMCxbrjQP8ZDFsfHR2jV5q3MQTS/n1V0JUV4KbPwR7GEzZZE
         mzHZd9R7IuWNDglILxglP65SjFO31Vrc0dfrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237292; x=1691829292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyEkQpgIXNpGAjYikyKRrMbeGwRnjSnhMc5RNVKg7IY=;
        b=SEjbopo9hL37YS+G4MEGYb4b3oDekdhE9W5ucbSSylsfXf/WDD5QZceYSnWpyElNfq
         MYrr8oqaZejJBGWu9NdQ2DSLCpis9tCe3C0wa7LNVTv4Uso9+9M7OQlrWEHR6ZwjLww+
         75PBAMePqJoQxFOM7Y0sOR+Tlgv+AkEyl6SxbzkQVOAW0z9+H3mMbojl5E3gptScDQuO
         oLrP9hL0xPJm+xtR9bGwcGuGyhNQVFLVHcujlhswCuYuZyIYeCxj5pP5l5f2c36HXQTX
         lQ7FevTvRbul6x/xn/vtz14JWaSN+pbBxl2UD4d61Aivlyg8zLCqVq0OxlFssEWfFkSl
         6Drg==
X-Gm-Message-State: ABy/qLZoPrim28e6i5A4GeGUjvFJ6TPOp+6AVThu+4TBBhMkelRvZxr3
        XomEdVzCsJ2OPXEWJZWgYbtaMxgK7eMfmwvpF6s=
X-Google-Smtp-Source: APBJJlFSKfVoys5IpCSlevdRHCSDy8/Ei1tZ610ADL1CYLN1cU/zKGzu3neAyN8LpVLx4T6EkQ7EjQ==
X-Received: by 2002:a92:c6c1:0:b0:346:5aeb:44ec with SMTP id v1-20020a92c6c1000000b003465aeb44ecmr1014400ilm.22.1689237292534;
        Thu, 13 Jul 2023 01:34:52 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id b3-20020a920b03000000b00345d4f7cbe2sm1891252ilf.3.2023.07.13.01.34.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:34:51 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-78372b895d6so13273239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:34:51 -0700 (PDT)
X-Received: by 2002:a5e:c918:0:b0:786:f10e:a473 with SMTP id
 z24-20020a5ec918000000b00786f10ea473mr1591076iol.16.1689237291411; Thu, 13
 Jul 2023 01:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com> <20230412115250.164899-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115250.164899-5-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 13 Jul 2023 16:34:15 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngkoQJKi6AozAOQY1WKvMhMrgKfA8S7MdbqmzSD5rRmdw@mail.gmail.com>
Message-ID: <CAC=S1ngkoQJKi6AozAOQY1WKvMhMrgKfA8S7MdbqmzSD5rRmdw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/mediatek: mtk_dpi: Use devm_platform_get_and_ioremap_resource()
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
> Instead of the open-coded platform_get_resource, devm_ioremap_resource
> switch to devm_platform_get_and_ioremap_resource(), doing exactly the
> same.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 9025111013d3..45535dc7970f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -1038,8 +1038,7 @@ static int mtk_dpi_probe(struct platform_device *pd=
ev)
>                         dev_dbg(&pdev->dev, "Cannot find pinctrl active!\=
n");
>                 }
>         }
> -       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       dpi->regs =3D devm_ioremap_resource(dev, mem);
> +       dpi->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &me=
m);

"mem" appears to be unused elsewhere, so I assume
devm_platform_ioremap_resource() would be a better fit.

Regards,
Fei

>         if (IS_ERR(dpi->regs))
>                 return dev_err_probe(dev, PTR_ERR(dpi->regs),
>                                      "Failed to ioremap mem resource\n");
> --
> 2.40.0
>
>
