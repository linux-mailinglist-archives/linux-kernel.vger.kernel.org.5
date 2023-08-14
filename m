Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5C77B0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjHNFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHNFU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:20:26 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC0E60
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:20:25 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-447abb2f228so1424304137.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691990425; x=1692595225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldE8qOBwh1y7PWVjhUoFCaGJK1VblQjo0GJwUi6utEY=;
        b=Zbtk6rkBw8HM6+xKzgvCmJLkqWs+ewglI5SUHNv17MdQhmreyFIw7dHqD2kGNX7yr7
         z9CInA4M3PZ6HSN71ANoj9zNdZnufXAS1ZqHdqjN94dSeKWq7PN36/3646znxNolzXKl
         cG8590x91xXbknAoO+U+YJatb85wyn92GqGxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691990425; x=1692595225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldE8qOBwh1y7PWVjhUoFCaGJK1VblQjo0GJwUi6utEY=;
        b=GoL+m6edYJXeRMN7+r5lT8Z3NeEn2/b2T2sMb9AeTeYungrUoP2B5ueGWidC/3yJsd
         uKZ+sU8yPYfPtCnyfZJw9Vop++Msl6xcdfmgkYQXHQVHCUT5/pMS5XLi0n9vDxqSun3N
         NQRNT66ffC5BOr1suVJwrtUOVfMceB5IVyLAWVaLCW0G8sDtrEKpb+2w6grv1dmtKplS
         HM9AxR5voXLcBpcQV2LHbxN8kQhuZ8vSgt4cIuQcrjvJhKPzgfCLSyE09nr0BceBZKNH
         RwSBiYBvNCrNk8vFihAa7mtEFT+r/JwOLujN1ZHyjx2xXyudwQkxYF23iUSxtES/Wql7
         g5qg==
X-Gm-Message-State: AOJu0YxTt6WFdQO+Ks3JajqTkvtfhJe6LEKe866GdtNL3SNhCfgVaRi2
        sGjySJ5qKEB9W3r2tdcLyy+ZoqdVrhUAfo0HyBK2FA==
X-Google-Smtp-Source: AGHT+IH/yH76PlnuVqLFpXQ7PucJ3pxTFjkPU6MLyXBUxtaUIJbcdk1Yo71+F/jREDnYnK7jfoaaiGen2gwtpA9rPdo=
X-Received: by 2002:a67:eb57:0:b0:443:8eab:c664 with SMTP id
 x23-20020a67eb57000000b004438eabc664mr8438403vso.13.1691990424769; Sun, 13
 Aug 2023 22:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230813190845.49738-1-alex@shruggie.ro>
In-Reply-To: <20230813190845.49738-1-alex@shruggie.ro>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 14 Aug 2023 13:20:13 +0800
Message-ID: <CAGXv+5F8HZOawAKoDvVCx7+mGmEPsELzp-r-6c5tw64c87Aa_A@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek: remove redundant dev_warn in probe
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, daniel@makrotopia.org,
        void0red@hust.edu.cn, aboutphysycs@gmail.com
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

On Mon, Aug 14, 2023 at 3:09=E2=80=AFAM Alexandru Ardelean <alex@shruggie.r=
o> wrote:
>
> There's no need to print any extra messages in the driver if
> devm_thermal_add_hwmon_sysfs() fails.
> If this function has any failures, they will already be printed.
>
> While looking inside 'drivers/thermal/mediatek/auxadc_thermal.c', the
> failure will be either be one of:
>   'Failed to allocate device resource data'
> or
>   'Failed to add hwmon sysfs attributes'
>
> Also, the failure will be reported on the 'dev' object passed to
> 'devm_thermal_add_hwmon_sysfs()', so it should be clear which device this
> error belongs to.
>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/=
mediatek/auxadc_thermal.c
> index f59d36de20a0..55f7fde470e5 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1290,11 +1290,7 @@ static int mtk_thermal_probe(struct platform_devic=
e *pdev)
>         if (IS_ERR(tzdev))
>                 return PTR_ERR(tzdev);
>
> -       ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> -       if (ret)
> -               dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> -
> -       return 0;
> +       return devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);

You changed the logic here. The original logic is to print a warning
if the hwmon sysfs stuff failed, but continue to probe the driver. In
other words, hwmon sysfs failing is a non-fatal error.

Your changes make it fatal.

ChenYu

>  }
>
>  static struct platform_driver mtk_thermal_driver =3D {
> --
> 2.41.0
>
>
