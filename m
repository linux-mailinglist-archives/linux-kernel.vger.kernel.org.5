Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B9786D55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjHXLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbjHXLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:01:50 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6A219B7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:09 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-791b8525b59so2388562241.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692874866; x=1693479666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GPLbtkGvhRTI4nLdlhcl04mxk22rA+TGcPb9vjfWTg=;
        b=BCLGw81RA5j/aS72VpSz9j7JDcOo8jpYBHFmYtNQw0muHBgHMyNOKRBBFrqU3iXwFB
         Qz4Dzm+zCFzhLwXovZGokRljaOLBoJ76MmFClMPHjWrggJ3+Id7Pp04BnhVPKJxRVwrc
         FOngNCEHNHZ+x8K8ldzrl5U0zy05bN9hwGscCi0YJZiBPx5cxdO+GQFjDpORGI++4vFL
         aFukHEIzHxWvvmVjucRLVFA9EdObBHamXQQZk7bUm0fi1qaMBUaIqcBC/Yn6WTSg7A5z
         tDl12uBC8mSI+7b4PLBD7pJAqtVSnTA2hvAX0cVaLAHtXiE7LPITjm2aOJrJcB14yMzf
         C1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874866; x=1693479666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GPLbtkGvhRTI4nLdlhcl04mxk22rA+TGcPb9vjfWTg=;
        b=CY0oc5dnzvjE2NuuXGGjoG9mn8RzUfXRjiAlKDHS6zHuN33apevrNoT/jS+MAalMT6
         rygnnqaPDrnxWu0eASvrn1+5KBMEP5nPZF0LO+VQh3025BVDz6y8EROch9QCxhDGA4uv
         QUCFpOOrtj/BcDntre0d8WSLaXkuYQr89CB82dW6oOeebAvQYO9NGOoJGP4eIMP7dj4j
         /pkdKkmfp/7VqdQ0IG1vJAA7A8K4zSNHlMQ4GgENzzCifPJg1H3skTnKtmo3TtdkApOQ
         QgxZ7qT9ArE+eHcoGLrY6uXgWfn7e44sKOMQYbp36ygiTkcVemPxmntbWW0JxStSoTTx
         QEWQ==
X-Gm-Message-State: AOJu0YyAaeOGtB830WnV191uv8OWOyGiInhA810MgaOpA3kxECCGfyIt
        IeqMzQyfReolOXraMzZ6HijfBMCY4Vzq1rlJPEdcNw==
X-Google-Smtp-Source: AGHT+IGWCJpOWag14Bj6Se5haNndu77EFWcJi3R3zMoubagdCfr/Y/6bWhEdmjCKV1CtkebqHiWGyuRsevGqdwqZXGg=
X-Received: by 2002:a67:f8d8:0:b0:444:17aa:df60 with SMTP id
 c24-20020a67f8d8000000b0044417aadf60mr13626910vsp.13.1692874866062; Thu, 24
 Aug 2023 04:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230822195929.168552-2-limings@nvidia.com>
In-Reply-To: <20230822195929.168552-2-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 13:00:30 +0200
Message-ID: <CAPDyKFpQOTdrOm2FkJL+EoDhq9u4puKVnnTfFGA82Nmy9UTibA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] This commit implements the runtime PM operations
 to disable eMMC card clock when idle.
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 21:59, Liming Sun <limings@nvidia.com> wrote:
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next (I amended the patch according to Adrian's
suggestions), thanks!

Kind regards
Uffe


> ---
> v9->v10:
>     - Simplify the changes with pm_runtime_resume() in
>       dwcmshc_suspend().
> v8->v9:
>     - Address Adrian's comment to do the pm_runtime_put() in
>       dwcmshc_resume() instead; Error path changes not included yet.
> v7->v8:
>     - Address Ulf's comment (option-1);
>     - Updates for Adrian's comment to remove the force_suspend/resume
>       in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
>       dwcmshc_resume()/dwcmshc_suspend();
> v6->v7:
>     - Address Ulf's comment;
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
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 64 ++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bc332a035032..3a3bae6948a8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
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
> +       pm_runtime_put(dev);
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
> @@ -600,6 +610,8 @@ static int dwcmshc_suspend(struct device *dev)
>         struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
> +       pm_runtime_resume(dev);
> +
>         ret = sdhci_suspend_host(host);
>         if (ret)
>                 return ret;
> @@ -659,7 +671,55 @@ static int dwcmshc_resume(struct device *dev)
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
> 2.30.1
>
