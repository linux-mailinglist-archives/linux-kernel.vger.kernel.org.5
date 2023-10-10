Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327457BFF44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjJJO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjJJO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:11 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B263D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d865854ef96so6056241276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948088; x=1697552888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alViJn9wr9hEami8tBTxM86DiA2WqQugL84JflHHVFE=;
        b=TADHbS7ShwdgF5AOUuae7PRNM2y/+3XUGtoETm1A8TJV0MGjyM/NMdGx89pe+crK8z
         VAIyDHEgMPYmsGmRSE+vU4M/AV+JIqdvZ0Y63KHUQCcyd2ehW1vH4baYvBHLIv6zrfE7
         oLwHVxC7tAoZ2uutx1/WadF4CSl1onHmb/oxQyatUFGp5/3pITf3XusbYGFoUD2fksbj
         6z794f8Pcx+bnvDb2ogWhobwgJSg1E48wse3//6hQzBf+0GQI4m5oR248sUv1MBdLcOk
         m+Bzds9j9brXcthGe+2bgW2NRzmKLIGWLAP8AQBcwfXoCP7Y7Q6pSHsfaqqXem6aeE6u
         WHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948088; x=1697552888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alViJn9wr9hEami8tBTxM86DiA2WqQugL84JflHHVFE=;
        b=VSvKbD6Sz1SGfSmHAdO1nhNwD5mLF4E46etZdcCOXbeRlJerRda0603Aqw7Wr1jeyt
         LaDq9DFupg3ieFiBnvFLkMEVE9zxYmIS5kDagULyUPFQKy278lRg1ctL1HCG6lGL3wzV
         pU24/jNhrAUqg1IMndYy9kTrfDTb55RMUUrHAVWxf7e3wrTAqOrouy3+Ss3AGsejuMTP
         9B+jj97gfEzRmrMC+3lnosUfaHCH9KJbbPjBoOM8g3I4xX4kLwpPob2shB6Zhbq2nj5m
         W+uo/42ccOkx9FyV9Bo3t7oFu4U1OZNWy8yDK/bGDBCGj9RZPtL2SwAUPYr7IwhZlQlg
         1www==
X-Gm-Message-State: AOJu0YyVR20eSd9SunxwXw+2wdFP6rhXSExwd37+r68Z9ZeKE1Yg1Iza
        zX1V45IcBBHdafNv2XEF9jFw+nEIL4D5K2hDQaFP7MNmOGnx+GGD
X-Google-Smtp-Source: AGHT+IGCuVm5tfzzCQRJLgAPe/QFgRUKObDDu9q6XLFDHXNneXmxPF+QjDjGrUh+AlHyp3RMyudNaztMFnoej3Pvy94=
X-Received: by 2002:a25:cd45:0:b0:d91:1296:947 with SMTP id
 d66-20020a25cd45000000b00d9112960947mr14699613ybf.40.1696948088333; Tue, 10
 Oct 2023 07:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:32 +0200
Message-ID: <CAPDyKFodA+MS_B8XNAr--R0Zq3LNYARfVHN9bgoo=_opU8=O4w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-pltfm: Drop unnecessary error messages
 in sdhci_pltfm_init()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 12:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The devm_platform_ioremap_resource() and platform_get_irq() print
> the error messages themselves and our "failed" one brings no value
> and just noise. Refactor code to avoid those noisy error messages.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a72e123a585d..4d1a703a5bdb 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -115,26 +115,21 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  {
>         struct sdhci_host *host;
>         void __iomem *ioaddr;
> -       int irq, ret;
> +       int irq;
>
>         ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(ioaddr)) {
> -               ret = PTR_ERR(ioaddr);
> -               goto err;
> -       }
> +       if (IS_ERR(ioaddr))
> +               return ERR_CAST(ioaddr);
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               ret = irq;
> -               goto err;
> -       }
> +       if (irq < 0)
> +               return ERR_PTR(irq);
>
>         host = sdhci_alloc_host(&pdev->dev,
>                 sizeof(struct sdhci_pltfm_host) + priv_size);
> -
>         if (IS_ERR(host)) {
> -               ret = PTR_ERR(host);
> -               goto err;
> +               dev_err(&pdev->dev, "%s failed %pe\n", __func__, host);
> +               return ERR_CAST(host);
>         }
>
>         host->ioaddr = ioaddr;
> @@ -152,9 +147,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>         platform_set_drvdata(pdev, host);
>
>         return host;
> -err:
> -       dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
> -       return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
>
> --
> 2.40.0.1.gaa8946217a0b
>
