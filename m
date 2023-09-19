Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3647A5F64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjISKWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F7F1;
        Tue, 19 Sep 2023 03:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F18AC433CD;
        Tue, 19 Sep 2023 10:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695118925;
        bh=dmvhQW3YLOhvdxKcJnLHYW07oPHwFw9/FP6t9KaaBPU=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=hriYbPVslGyfrsnGFmcsr7R+8NjC4RqrTjShBOKOHR9REu/ziEQxVzgDOVmLgChEi
         CJhReFFBIkcSyRDUEq2BPCZtw8WZPuvYQ2ZXSZ43WUA4DGJWwvwXaga0T01VWuNHrC
         BX4E7A0ySENPPHPi/tMZ0ggl4h97MrFAiFYQgTVEo8TqxMvuMww/Vl4BDxK4Bq6df/
         7AsxoDxZMtsdpp2uNCxd+H/LzznDZyhyCqPjBSVygrjRzZr1+EbRcw2XBL4OwD+WCs
         otVTSCa1ZQe9dt2fHgKp7O+fPBS+ISN625MdoLY0jRn/HDqVqRhwgN1G+JwEG/kuhq
         ZIwGdggkI4biQ==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2746889aa89so3704658a91.2;
        Tue, 19 Sep 2023 03:22:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyWr+RagHaewJ2xyPRe50BmX5aL2kzz2MWM3uLzimusNGxeMohF
        P4NKg3CnK3WQGNAcsM4y9lRqhpJiG6vIwzLiO1I=
X-Google-Smtp-Source: AGHT+IFLP8u/IhPMpECtmeJDblMAwMQZVF6Uy108M/E7nMutryw3NKtyqd+bECmp03Rcsik4eRGitLcY4pbQ8nsu5Hs=
X-Received: by 2002:a17:90b:4f82:b0:276:ae0f:57bc with SMTP id
 qe2-20020a17090b4f8200b00276ae0f57bcmr628564pjb.2.1695118924779; Tue, 19 Sep
 2023 03:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com> <20230919095938.70679-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919095938.70679-3-angelogioacchino.delregno@collabora.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 19 Sep 2023 18:21:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66rEqWBjdMNO3VMZhYj36hhKTxPk+9pborPjnqW0B-=ZA@mail.gmail.com>
Message-ID: <CAGb2v66rEqWBjdMNO3VMZhYj36hhKTxPk+9pborPjnqW0B-=ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: platform: mtk-mdp3: Use devicetree phandle to
 retrieve SCP
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
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

On Tue, Sep 19, 2023 at 6:00=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of walking the entire parent node for something that has the
> right compatible, use the scp_get() function provided by the MediaTek
> SCP remoteproc driver to retrieve a handle to mtk_scp through the
> devicetree "mediatek,scp" (phandle) property.
>
> In case of multi-core SCP, this also allows to select a specific core.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drive=
rs/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> index 8677e7fd5083..d93d3833633e 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> @@ -254,13 +254,17 @@ static int mdp_probe(struct platform_device *pdev)
>                 goto err_destroy_job_wq;
>         }
>
> -       mm_pdev =3D __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
> -       if (WARN_ON(!mm_pdev)) {
> -               dev_err(&pdev->dev, "Could not get scp device\n");
> -               ret =3D -ENODEV;
> -               goto err_destroy_clock_wq;
> +       mdp->scp =3D scp_get(pdev);
> +       if (!mdp->scp) {
> +               mm_pdev =3D __get_pdev_by_id(pdev, NULL, MDP_INFRA_SCP);
> +               if (WARN_ON(!mm_pdev)) {
> +                       dev_err(&pdev->dev, "Could not get scp device\n")=
;
> +                       ret =3D -ENODEV;
> +                       goto err_destroy_clock_wq;
> +               }
> +               mdp->scp =3D platform_get_drvdata(mm_pdev);

You need to keep the original code as a fallback for old device trees.

ChenYu

>         }
> -       mdp->scp =3D platform_get_drvdata(mm_pdev);
> +
>         mdp->rproc_handle =3D scp_get_rproc(mdp->scp);
>         dev_dbg(&pdev->dev, "MDP rproc_handle: %pK", mdp->rproc_handle);
>
> --
> 2.42.0
>
