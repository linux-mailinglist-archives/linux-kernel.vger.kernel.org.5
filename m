Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2457807BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358896AbjHRJBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358914AbjHRJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:01:38 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94274207
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:01:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58dfe2d5b9aso9694497b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692349269; x=1692954069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIMtbwO8KD2IoehzK5xo4XD4MDFkwlTkyaP30vazrWk=;
        b=NDfj2KfLreW7RME+Ag6gxRjuiq9PNGwZfPQPeviCqL2NUfJkae/2HCgd3m/jtS0apu
         leZvRg9JZkjD9Mw9U7OSxzUe2P5M7ffzeFKuw8SG2p1bCOti8I71pn04HrOAD4fEn/97
         +WmSaIskdk9+zBYWNy5bTAZ9/4hOe9v1YHHVSrTQ2J4j2rxudlGWszAs4SR5VVNVEEn5
         s012F44gHb1tDv/6FXRo19cZhIa2AUbkeG+b3L+ZrVi7bOKTUyVpT+KYmEpdSanJAPT3
         COGQTXzvMHlGBYGKkVunlc0XCyo6xgwNU/4KOukvANvoXSMxKaT+etjXoPRaCSsQVqhN
         NxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349269; x=1692954069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIMtbwO8KD2IoehzK5xo4XD4MDFkwlTkyaP30vazrWk=;
        b=FX91TwAy7GhVtgmZ7KU8OuV/wcaV+3Xfew/gNWnRhu+DPvqyaPWneAm5wnTS3iDoNt
         cpz+HNWVNQjw7iUDWAGLmfYTw5i7aPjU61mQ9/Hf7zO8b/70zmWhl7k1koXoyDGMXN0y
         AOdb2R073BAeK7SHeBVz9v0n9CSYIAGXLH2B8onqE1zUFYdjCeOtK250woysirUVmkdc
         oNCb/79mIG3vg+IP09JH86jWSnvNniKvU44ayCYHP0EfNvLZB1Yod9OTlPfyES8CuSHI
         l1ClXeefqZCTP6T+m7+fiFMWLms4iJ223/PwnR8nOuDhyHOivQac868DLaU4J2E9w73d
         Px9A==
X-Gm-Message-State: AOJu0YzZ6iBYdLDRNaH+B7gM4zl6Ovh7PqNxocTXhB7VI0yAb9dYVDLC
        zSsPJBj2RYtqZOWYAvdD0QYzHpn49RAL1W6XOA7bng==
X-Google-Smtp-Source: AGHT+IEWzDCK5yYkY70jff+msXhncrz8POQ3xpL2mas+Bp/FNL0VSiTT9JywxXmqjpwqUVsHlBPOJ1oXEhXsuZnoE8Q=
X-Received: by 2002:a0d:eb0e:0:b0:58c:adf9:eb03 with SMTP id
 u14-20020a0deb0e000000b0058cadf9eb03mr2530783ywe.6.1692349268872; Fri, 18 Aug
 2023 02:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230817162159.242087-1-limings@nvidia.com>
In-Reply-To: <20230817162159.242087-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Aug 2023 11:00:32 +0200
Message-ID: <CAPDyKFpezrjPk6Y+TS1A1E2tK4WbjdpTjPwPxLaAUD9fcaQonQ@mail.gmail.com>
Subject: Re: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 18:22, Liming Sun <limings@nvidia.com> wrote:
>
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
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
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76 +++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..3b40f55ce2a4 100644
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
> @@ -602,9 +612,13 @@ static int dwcmshc_suspend(struct device *dev)
>         struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
> +       pm_runtime_get_sync(dev);
> +
>         ret = sdhci_suspend_host(host);
> -       if (ret)
> +       if (ret) {
> +               pm_runtime_put(dev);
>                 return ret;
> +       }
>
>         clk_disable_unprepare(pltfm_host->clk);
>         if (!IS_ERR(priv->bus_clk))
> @@ -642,11 +656,65 @@ static int dwcmshc_resume(struct device *dev)
>                         return ret;
>         }
>
> -       return sdhci_resume_host(host);
> +       ret = sdhci_resume_host(host);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_put(dev);

To simplify the error path, I would suggest that you move the call to
pm_runtime_put() to dwcmshc_suspend(). In fact what you need is just a
call to pm_runtime_put_noidle(), somewhere after the call to
pm_runtime_get_sync().

This is because runtime suspend is prevented by the PM core as it
bumps the usage count with a pm_runtime_get_noresume() in the
device_prepare() phase.

> +
> +       return 0;
>  }
>  #endif

[...]

Kind regards
Uffe
