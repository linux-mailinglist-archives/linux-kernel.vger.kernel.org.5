Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1139773FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHHQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjHHQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:50:20 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A65B17AA0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40fcc91258fso38457711cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510231; x=1692115031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRLcdBtw9nwQOUfKRavX3wZrUe68VBy1FGiQoaTHfg0=;
        b=oSwEruyrhBM1eNwGNtbPTifgC1FtRbzfQYz2TBebWH4Brx+f7khIIQvV4mqlMjHr1p
         xlYj/78SP1NB0EVbXGsNptKtQZJf4pTSA85nwbJ+XOks/0n0BYGHIcCibuEGqfCm+r8y
         FyvNIE+uaANKtpW85X9VcfGBlFgfS73WxRZ9G8BQ2fkCX5PFT+VKZmyx5JTJV83Qh7x7
         0c/LBoVodE1/nh+TJZb0glznG0vsMlmrTgCfivadZ5UvtvZUKCxCEKLC5ZH4vEUpZYzS
         +Zx9tMhrydxy71mZNivQz3XLimUNTllMso3UEypkioO6Vcx8xk1JpTl//hOc5PjHb1JJ
         yHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510231; x=1692115031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRLcdBtw9nwQOUfKRavX3wZrUe68VBy1FGiQoaTHfg0=;
        b=FzUhKdOMvBlifn3xplvwGfg+i3tZE/+lE/qQ1BDbG6lrukmFkofvFjqcF1IuLNdg6c
         SbxsCEaiOBkn5exDNiXPCtwomBt8ukOK07oc61YtwWS8WhnmPCb9bywLtZw6626uWtKS
         LIZGyM9bOVzrZHmY736W7i+S1+HUn6n1a38DeX5dO2PdCuB/U0Cjepvu9TS0izlTUQTe
         wYvttDnF60JU/teIcwMoV9yhFZIKW6w22GoTOfrzXkEgjonv/L/EEHmfAxrLJlemwJyq
         VfFI1HZRirxWg3touzI0DivmFJkpZQVjHjXuC5uGXDyrllCiRSkiX+ajHj4vKVY9IzMP
         iLXw==
X-Gm-Message-State: AOJu0YwVEcxa6u3aS10sOeYb3TvBV7Cq/mGlkh347EtNJIBvGR4xY8qa
        n9tsSBFbEa/Ba+SfgVmtIsUpJj9P58Z8OfQOD2uVzSyaVXeFEwrxo3c=
X-Google-Smtp-Source: AGHT+IFrsfzZvvS9Y2tPd1opRtAE2Y8xhZ8ahi0a7jdb/3eExJtyrsIJsefl4ij3MUC3ojS26P+vxE02fIVGontyL1w=
X-Received: by 2002:a25:8d12:0:b0:d1e:be4:e7b5 with SMTP id
 n18-20020a258d12000000b00d1e0be4e7b5mr12737679ybl.4.1691487625704; Tue, 08
 Aug 2023 02:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com>
In-Reply-To: <20230804233015.173957-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:39:49 +0200
Message-ID: <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2023 at 01:30, Liming Sun <limings@nvidia.com> wrote:
>
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
> v5->v6:
>     - Address Adrian's more comments and add coordination between
>       runtime PM and system PM;
> v4->v5:
>     - Address Adrian's comment to move the pm_enable to the end to
>       avoid race;
> v3->v4:
>     - Fix compiling reported by 'kernel test robot';
> v2->v3:
>     - Revise the commit message;
> v1->v2:
>     Updates for comments from Ulf:
>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..aaf66358f626 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>
> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
>         err = sdhci_setup_host(host);
>         if (err)
> -               goto err_clk;
> +               goto err_rpm;
>
>         if (rk_priv)
>                 dwcmshc_rk35xx_postinit(host, priv);
> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_setup_host;
>
> +       pm_runtime_put_sync(dev);
> +

The async pm_runtime_put() is probably sufficient - and it would allow
the probe to complete a bit "sooner".

>         return 0;
>
>  err_setup_host:
>         sdhci_cleanup_host(host);
> +err_rpm:
> +       pm_runtime_disable(dev);
> +       pm_runtime_put_noidle(dev);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       ret = pm_runtime_force_suspend(dev);

Can dwcmshc_suspend() be called for a device that may be attached to
the ACPI PM domain?

> +       if (ret) {
> +               sdhci_resume_host(host);
> +               return ret;
> +       }
> +
>         clk_disable_unprepare(pltfm_host->clk);
>         if (!IS_ERR(priv->bus_clk))
>                 clk_disable_unprepare(priv->bus_clk);
> @@ -625,6 +641,10 @@ static int dwcmshc_resume(struct device *dev)
>         struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
>         ret = clk_prepare_enable(pltfm_host->clk);
>         if (ret)
>                 return ret;
> @@ -646,7 +666,55 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +               ctrl |= SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +       dwcmshc_disable_card_clk(host);
> +
> +       return 0;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +       dwcmshc_enable_card_clk(host);
> +
> +       return 0;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
> +       SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +                          dwcmshc_runtime_resume, NULL)
> +};
>
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
> --

Kind regards
Uffe
