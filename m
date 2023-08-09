Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA0775952
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHIK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjHIK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:59:25 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1DED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:59:24 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-585fd99ed8bso11075317b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691578764; x=1692183564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iaYB/Ipn2a2m2D4N0I3VurARbvsG5OxcIS7VBhxmako=;
        b=d4VL+01TABHXmsF/sknTHW8Rix2EH/NZaxjVqxatJUJtf08r7M+zh6yn+PA1us+AzV
         z3awp9BTZ2SGvAVHohC08w9xi18NAqlf+RppMRyqUQK0mLFwDujbuBKRT0tgpXbVWIke
         aq848fTgmA1SRmqy3cqqq14DDujIjW1G1iBJYQV53M0VYtgCxQNpMG+07HJCgi7gvKgS
         Kj/yC+kHVl8mfSdUD8fMH6jZMGo0/Qw4Z8dGgDVkeUoKILysPjl5CydscQykfuKaTwrL
         Ighftu4Ff/D7o+4a/6brj1dWeuOz5Csxqp1h3BZ0aOmOEM8fg8RHIt1RvZbXwNpit3tQ
         rOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578764; x=1692183564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaYB/Ipn2a2m2D4N0I3VurARbvsG5OxcIS7VBhxmako=;
        b=Sn3EKqDfn3CPI7GoA+DfyTpFMkdPxI/syK7HE7qAZo4uGGWWDezq0k6R3RBGrUxeJ2
         09ixEcH0dbJOist51iY1kMi538Kjb3bX3l20Kn1cr5gjhjN5oXbbwSYCr1rQHKzpB4JP
         9GQTKdlEUd7y8Wy647udfc0tTpIRdz9T39q9oVCieee9IG7GCvgzn5LRqn22EGBgUsZR
         AmRngJgyHiTM4eW5W1eQXvlSUE/hYv0UFQoq3eQFjsRSPPBIcwSn7m5CeEGItdH0jAIS
         FtQwvGvr7ZcQAnBl4af4hMybEQgpCEko4FBLc1A79vEEzNnq6c0kjg42/dw/Ency/MHj
         QDyg==
X-Gm-Message-State: AOJu0YzkawTQJ4J/hvbvy7gRmlrd3i01zsevLfrL1a4XloupKLMK1hwu
        ZHiNsdB/iCLrzK1nTMBFR0AWTx9x4TB+TZF8R9ciQw==
X-Google-Smtp-Source: AGHT+IGf9KnfBxey/rY1ABAA/l9zjpo/dhTHXbZOjXu+o3ulWFuAqa5B3FD+/+ICLarj2DWZ2/xD4E0zUqP8mxA+PW4=
X-Received: by 2002:a0d:cb52:0:b0:577:186c:2a3c with SMTP id
 n79-20020a0dcb52000000b00577186c2a3cmr11621366ywd.19.1691578763825; Wed, 09
 Aug 2023 03:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com>
In-Reply-To: <20230804233015.173957-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 12:58:47 +0200
Message-ID: <CAPDyKFo0TYw-8Mq8eUasvh0bVM1NLcWR+QZvt-=S2Jb+S7rYBA@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

sdhci_suspend_host() is called a few lines above, which requires the
host to be runtime resumed when called. This may not be the case here.

To fix this there are in principle two options:

1) Call a pm_runtime_get_sync() around here and a corresponding
pm_runtime_put_noidle() somewhere after you have called
pm_runtime_force_suspend().

2) Move away from using sdhci_suspend|resume_host(), but use
sdhci_runtime_suspend|resume_host() instead. This requires some
additional changes, but with the benefit that we can avoid runtime
resuming the device upfront. In this case,
sdhci_runtime_suspend|resume_host() should be called from
dwcmshc_runtime_suspend|resume(). Moreover, we either need to move the
entire clock mgmt from dwcmshc_suspend|resume() into the
dwcmshc_runtime_suspend|resume() or call pm_runtime_get_noresume()
before calling pm_runtime_force_suspend() and pm_runtime_put_noidle()
just after it.

> +       ret = pm_runtime_force_suspend(dev);
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

Kind regards
Uffe
