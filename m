Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6C751B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjGMIdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjGMIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:33:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2687282
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:24:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-78362f574c9so9191739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689236684; x=1691828684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC8wLptS4WXWt8bW8YWC7ooVYG9MHbSN/yLxSgqam3k=;
        b=OG+cmDQ9vAuwCIb4A70FoqcL/dGFjXJGwUAeRUHDub7+E9E50ulm8eNhwS3f1ite0M
         Z5P0Y9vVlBEED+T8dA8EzXAxWoKCGvswnN70yAnH42b1NqxzjjLSNwzKII/n+6qF6Lyn
         IoS12nMis2tiwaXVNnrUbkZWJxiluxvn78Tuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236684; x=1691828684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC8wLptS4WXWt8bW8YWC7ooVYG9MHbSN/yLxSgqam3k=;
        b=I/g+hrODKDQ144M9ryeURkvKlMJfLgiCvUQeESNnaQt8jKxrD2BzDvv93MhNdXOuc3
         u48X/Vj2ytQ1hYizqaYELbnr6YQ2Ha/dlrNhlt/0gNYWZ8dHlfZV0v7i7vYuHPriD+9+
         IGQrcdYqqtdwQ+gSBKKsbDG9YwvetBE5NxKPJokLaETOAhxUkGMrDuvRqPR872G/aZdR
         3sw7AI2Z01GJYox6kyMz6y673MA8MbyNnzh9CWjQDxP9OMr1q8kRVetVtCJQzRF61/YK
         9VCJItoKYZtdInMXGroNTr5ekU+sAJpOxH8ypZ8pgywEorZCF2Os9/5alzFOxY0fCbxF
         IvdQ==
X-Gm-Message-State: ABy/qLZ26UoZkPg8jOK2KrKNy+MAUrtJMd7kk9r4ICEkNW+esxeVDMYF
        QNUFyHw01xqW1Dt32uid4RUZY2iTtpA0cZ47VwQ=
X-Google-Smtp-Source: APBJJlG1rXd8MZF3/jTfqJuUWUGpRc8I0uGmMaHLNz8vIM2V8EzPw/DyqTppmmrccX+awgwV6SpZvQ==
X-Received: by 2002:a5d:85d7:0:b0:787:5a3f:d957 with SMTP id e23-20020a5d85d7000000b007875a3fd957mr888520ios.9.1689236684600;
        Thu, 13 Jul 2023 01:24:44 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id eq23-20020a0566384e3700b0042b0f3f9367sm1790077jab.129.2023.07.13.01.24.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:24:43 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78362f574c9so9190939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:24:43 -0700 (PDT)
X-Received: by 2002:a6b:e70c:0:b0:777:8e86:7702 with SMTP id
 b12-20020a6be70c000000b007778e867702mr1334033ioh.16.1689236683371; Thu, 13
 Jul 2023 01:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com> <20230412115250.164899-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115250.164899-4-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 13 Jul 2023 16:24:07 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhePNeKY=q3XofzPcbwvyonz-bSuSLDNgsKx088qB3ZJA@mail.gmail.com>
Message-ID: <CAC=S1nhePNeKY=q3XofzPcbwvyonz-bSuSLDNgsKx088qB3ZJA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/mediatek: mtk_dpi: Switch to devm_drm_of_get_bridge()
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
> Function drm_of_find_panel_or_bridge() is marked as deprecated: since
> the usage of that in this driver exactly corresponds to the new function
> devm_drm_of_get_bridge(), switch to it.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 6be65ea21f8f..9025111013d3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -1063,10 +1063,9 @@ static int mtk_dpi_probe(struct platform_device *p=
dev)
>         if (dpi->irq <=3D 0)
>                 return -EINVAL;
>
> -       ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -                                         NULL, &dpi->next_bridge);
> -       if (ret)
> -               return ret;
> +       dpi->next_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0,=
 0);
> +       if (IS_ERR(dpi->next_bridge))
> +               return PTR_ERR(dpi->next_bridge);

The original code doesn't print any log so it's probably fine, but
given you're already at it, perhaps you want to also make use of
dev_err_probe() here?
devm_drm_of_get_bridge() can also pass -EPROBE_DEFER from its wrapped
drm_of_find_panel_or_bridge(). Furthermore, that will make the code
visually align with your previous patch.

But that's just optional, and since this patch works anyway,

Reviewed-by: Fei Shao <fshao@chromium.org>

>
>         dev_info(dev, "Found bridge node: %pOF\n", dpi->next_bridge->of_n=
ode);
>
> --
> 2.40.0
>
>
