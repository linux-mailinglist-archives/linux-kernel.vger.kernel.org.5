Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBD7516CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjGMDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjGMDfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:35:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850D1FF0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:35:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78360b822abso6357539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689219322; x=1691811322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QV7vh1ogKfJf1Qa4ERBfjeAWDEN5HhFP3tvUsoJaZI=;
        b=YXOvx/QCIwWe/mnLJSqx4+w5eNIQZp13Z42w1IjSiMAnUZ60UNsNEegI7Ntzf/7LHu
         AWgiBL447GRQUwI/ofnzRDDkSG089pghzB44RTgWz07FnbqRoE7w19nIwW1KZIk9eI8A
         E91XIUbh/iZH8iS7CppKKWWvZAmeTKWc7UY50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689219322; x=1691811322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QV7vh1ogKfJf1Qa4ERBfjeAWDEN5HhFP3tvUsoJaZI=;
        b=U00MR2Ejgx5jFi0/ha68cQTusSibb95eaPbvAGWVUuKB+T/MO+hTu8LXfGaHC4CqqR
         bv0Gq7IoNXU+0n1g6SpfCz60LRHe/nl2jl//A6icUoCl927mLxQUKhJw5FDOZ8VxmRNw
         x2HvFGX12BR9OhP3ZGrzg5w1h7QQaVjDmHmGEJpyy19PVn+vsOuJFfaoY3B60fJJc6YH
         sVbR1sLCaTu5BJyXjWqi/oT7NqoeB2Hqay08rTbJSdxHmGnO+TL0RJmIYTfLy+pqrvLn
         fHSZcXYG/nOcTd1NH9dvoEpb88yOg6VmH0UKudya5SsxrM7Kx53E8Z3eF3edidC2Mdxl
         8hpQ==
X-Gm-Message-State: ABy/qLY+BjU5WebrBShytlkoLK+suCg4AqB+jddc/YaeEUqhiRJVlQe/
        gwLlfvuyF9jNAakUQBhK55qmGRiqhe4HsKlu0q8=
X-Google-Smtp-Source: APBJJlG3Lp+TAf9GIKs8fFlUp93sUElvn/oYjScOVS+w7lw35OY0/l/UC55aDNRvkWjl9H9DnBT52Q==
X-Received: by 2002:a92:130f:0:b0:33d:8720:7d98 with SMTP id 15-20020a92130f000000b0033d87207d98mr369206ilt.13.1689219321960;
        Wed, 12 Jul 2023 20:35:21 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id c14-20020a02a40e000000b0042b426e353dsm1648800jal.127.2023.07.12.20.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:35:21 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7835971026fso6178539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:35:21 -0700 (PDT)
X-Received: by 2002:a05:6602:18c:b0:786:2125:a034 with SMTP id
 m12-20020a056602018c00b007862125a034mr572395ioo.18.1689219320748; Wed, 12 Jul
 2023 20:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230421021609.7730-1-nancy.lin@mediatek.com>
In-Reply-To: <20230421021609.7730-1-nancy.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 13 Jul 2023 11:34:44 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj2Mwfbs_fgzcMsauhjaWdj0_0=t2F708i4F=u0oGgo-w@mail.gmail.com>
Message-ID: <CAC=S1nj2Mwfbs_fgzcMsauhjaWdj0_0=t2F708i4F=u0oGgo-w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:16=E2=80=AFAM Nancy.Lin <nancy.lin@mediatek.com>=
 wrote:
>
> fix Smatch static checker warning
>   - uninitialized symbol comp_pdev in mtk_ddp_comp_init.
>
> Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT=
8195")
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

This seems to be unnoticed and I just want to get some attention for
it. Any action items here?

Regards,
Fei

> ---
> v2: add Fixes tag
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index f114da4d36a9..e987ac4481bc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -546,7 +546,7 @@ unsigned int mtk_drm_find_possible_crtc_by_comp(struc=
t drm_device *drm,
>  int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *com=
p,
>                       unsigned int comp_id)
>  {
> -       struct platform_device *comp_pdev;
> +       struct platform_device *comp_pdev =3D NULL;
>         enum mtk_ddp_comp_type type;
>         struct mtk_ddp_comp_dev *priv;
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> @@ -588,6 +588,9 @@ int mtk_ddp_comp_init(struct device_node *node, struc=
t mtk_ddp_comp *comp,
>             type =3D=3D MTK_DSI)
>                 return 0;
>
> +       if (!comp_pdev)
> +               return -EPROBE_DEFER;
> +
>         priv =3D devm_kzalloc(comp->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> --
> 2.18.0
>
>
