Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774A77291F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjHGP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHGP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:27:08 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BE10F6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:27:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58419517920so50866567b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691422024; x=1692026824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRItn2cF5TQNt64raTRsWPd5Q0EJhD3/KF9OeDZ1Jek=;
        b=MUElYBBzp1nPLlNHE6f/TMFiwNBEnp4Jh6A6+RXtQRmfIPxPveRZ6FSfvExGpHEGoB
         RiwQQQxoK/oWcZ1+Ls05mu9ejhCXsQ2dUL1r0Kc6+JldzbZTVfBMJ+14l7tCB3/VFwM8
         Y/DaiHPImTPCgI+S4a/8uWx8qZVK9u5sqRdc5zw9BXE9M2F6fPwyWWl4t+ZkK2PtuTFi
         /GwylrICjRXYosRcN3l5CqE5HrLmurEEGMIsJmx1k7ga9EPPnKZgoAL+d6Rqmp/IiGy8
         7SDUc8lLFjCOfstH631w+MQ/5F4gCNV69IDXo0Uogb/QrQvPBTD+I+H4+Rxdi65+8hhl
         /NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422024; x=1692026824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRItn2cF5TQNt64raTRsWPd5Q0EJhD3/KF9OeDZ1Jek=;
        b=kvkGnk0I2BKNeZ9ds4oDTDqNL9JxWZEsL/uZ4XxiA0bzsvJpqIMdrUV7veZ0FQX5UG
         XFyH4emY+JvOB7TLXS+Ih9oLpSLRAal8hbpaSsPfYReLmDTHzf3SEjLPKT1XThoyRxxG
         A88fl/D++SInxXwEKVms1QxSqRHaozLpzlxCy1NpjyYKNXxof00v2lVqT/FaRZlQxVvc
         9Vgt9wnhUtGkfazVgcnd7pupJuqcqXI6cq8JEK8ULgG23hgokHHnpSIGEARxSdI5+0Ay
         YOksmxCerDZCoxmBROapuSXIglVgzoe0bKjY2vK1v6L1m9aPMfwoOvLj7U5UdXlHs7ww
         EUXg==
X-Gm-Message-State: AOJu0Yxe+d1+j4tnWFDxoR8zSFM7y0oo/0F6wHVJwpzdUVRbEFqg5z65
        PQyjZWZiMGs4kQ/LBoOc1T0JQsQpaykJzFXHsIDA6Q==
X-Google-Smtp-Source: AGHT+IEnVXumr0NCmry9RyuOxY6r32vIR+eeIv8r9xUwQJax2apeM8tRM+axH69DYQH98HK4UUlOM0RO2JbMTbOXpMg=
X-Received: by 2002:a25:2396:0:b0:c12:29ac:1d36 with SMTP id
 j144-20020a252396000000b00c1229ac1d36mr10222700ybj.7.1691422023820; Mon, 07
 Aug 2023 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com>
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 17:26:27 +0200
Message-ID: <CAPDyKFr5smUN5VHCo-O_iFB=qzHFg5Gn9d6wm3bw+5UEy9n=Ww@mail.gmail.com>
Subject: Re: [PATCH v3 01/62] mmc: sunxi: Convert to platform remove callback
 returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 09:01, Yangtao Li <frank.li@vivo.com> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Normally I would prefer one patch per host driver, but in this series
the changes are so trivial that it just becomes more difficult for me
to manage.

Please squash all changes that convert from using ->remove() to
.remove_new() into one single patch for the mmc host drivers. Note
that, I discovered there are some additional cleanups being part of
the series, those deserve to be submitted indepently of this.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 69dcb8805e05..d3bd0ac99ec4 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
>         return ret;
>  }
>
> -static int sunxi_mmc_remove(struct platform_device *pdev)
> +static void sunxi_mmc_remove(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc =3D platform_get_drvdata(pdev);
>         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> @@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_device =
*pdev)
>         }
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
>         mmc_free_host(mmc);
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_PM
> @@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver =3D =
{
>                 .pm =3D &sunxi_mmc_pm_ops,
>         },
>         .probe          =3D sunxi_mmc_probe,
> -       .remove         =3D sunxi_mmc_remove,
> +       .remove_new     =3D sunxi_mmc_remove,
>  };
>  module_platform_driver(sunxi_mmc_driver);
>
> --
> 2.39.0
>
