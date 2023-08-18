Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F97809E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354938AbjHRKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351695AbjHRKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:19:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4329B3592
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:19:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58cd9d9dbf5so10776347b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692353994; x=1692958794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A263qDAilO21yTbqLbTuQ/l8iRap3GaNXl1w5/CO22A=;
        b=OLM7IjB52+ggwSa/UVwfVqgAXdKVZPGcQSx45gvD0BV/elA1Qs2OvMQb0UhtPifhe9
         eXikzUETDpiI8Et6h7VJ5FZj3CfxXiTkb8nGTIRHcLzTnjLyCy+QpALE6HSzrkjhV/Nk
         Q4o0/3Gx39y59epsYbJl5rJVHX+0uE3AcTiMsMyDv06POqJqtaoPZFSIwr6TkzD/i2bs
         vnM3GHgX9iPI9FiGNO6+bI18MLl+YZ5dBNMVR+r4/ZPUOwWmlNT1e7jkSu4BEd4M8c7e
         uA7WBkuKu39BdaG7xuvUaaUSA01FVOCseXpWijXc8FsUmZx0Fey7Y9SOpTLpXA+BYkvs
         R31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353994; x=1692958794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A263qDAilO21yTbqLbTuQ/l8iRap3GaNXl1w5/CO22A=;
        b=FAXu+7WquWC5zZzlDvbsiuu/w9YTFdx3wGsP2E3hOsdCPjUiIpHUoGRP+gJN3UbjpC
         uL1uWHvC4G3umYTWlJlB0k7XbbM2VUyPT/gjWlYE8SnnuNLC/hFAIezJk+pEJRTrL37N
         Y7wB3CBobbKWuREBpfV7Z5gwCzf2SBDVwK0OTypeprtdxojhi0DzhoimFhE1D7bbTjcS
         qO6itK5RML6FLWVIaIotccU/uLUMaKUgjUgHCmIy7t/2DxYFZKCfxCLMP86o3Q3969OY
         SzvpAv8Yyc9+GF22QpRCBnOTc5PFPvUuKir8xRpGb35H0BuP/jSV5UHZuPC6zWdpuugG
         J8IQ==
X-Gm-Message-State: AOJu0Yx3ZIqkSwIyRBLagJ+zM6MLbanGcLB3f3wNPcXtwN/sHBMvvmIy
        u+4BdviNbJJGQZn+AvQPJkmsYRwzpKS28rz3PDE5eQ==
X-Google-Smtp-Source: AGHT+IG8+ezNT84A04MwfR3HtsuZskPbVm+ReMxWxrudL/7l5+KeDeVVwyLGJDdzIVkFgRRy+6Av/aDKQMtOFFlcRp4=
X-Received: by 2002:a81:49c5:0:b0:583:9935:b8ba with SMTP id
 w188-20020a8149c5000000b005839935b8bamr6977405ywa.6.1692353994471; Fri, 18
 Aug 2023 03:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230817162159.242087-1-limings@nvidia.com> <CAPDyKFpezrjPk6Y+TS1A1E2tK4WbjdpTjPwPxLaAUD9fcaQonQ@mail.gmail.com>
 <c5f59dfd-a0dd-3b77-55fb-1087cbbbef25@intel.com>
In-Reply-To: <c5f59dfd-a0dd-3b77-55fb-1087cbbbef25@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Aug 2023 12:19:18 +0200
Message-ID: <CAPDyKFpEfc7EjpKDczwk9XDySug+uJ064FbrxsD6A0CY9ccOaw@mail.gmail.com>
Subject: Re: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Liming Sun <limings@nvidia.com>,
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

On Fri, 18 Aug 2023 at 11:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 18/08/23 12:00, Ulf Hansson wrote:
> > On Thu, 17 Aug 2023 at 18:22, Liming Sun <limings@nvidia.com> wrote:
> >>
> >> This commit implements the runtime PM operations to disable eMMC
> >> card clock when idle.
> >>
> >> Reviewed-by: David Thompson <davthompson@nvidia.com>
> >> Signed-off-by: Liming Sun <limings@nvidia.com>
> >> ---
> >> v8->v9:
> >>     - Address Adrian's comment to do the pm_runtime_put() in
> >>       dwcmshc_resume() instead; Error path changes not included yet.
> >> v7->v8:
> >>     - Address Ulf's comment (option-1);
> >>     - Updates for Adrian's comment to remove the force_suspend/resume
> >>       in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
> >>       dwcmshc_resume()/dwcmshc_suspend();
> >> v6->v7:
> >>     - Address Ulf's comment;
> >> v5->v6:
> >>     - Address Adrian's more comments and add coordination between
> >>       runtime PM and system PM;
> >> v4->v5:
> >>     - Address Adrian's comment to move the pm_enable to the end to
> >>       avoid race;
> >> v3->v4:
> >>     - Fix compiling reported by 'kernel test robot';
> >> v2->v3:
> >>     - Revise the commit message;
> >> v1->v2:
> >>     Updates for comments from Ulf:
> >>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> >> v1: Initial version.
> >> ---
> >>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76 +++++++++++++++++++++++++++--
> >>  1 file changed, 72 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> index e68cd87998c8..3b40f55ce2a4 100644
> >> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/sizes.h>
> >>
> >> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>
> >>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >>
> >> +       pm_runtime_get_noresume(dev);
> >> +       pm_runtime_set_active(dev);
> >> +       pm_runtime_enable(dev);
> >> +
> >>         err = sdhci_setup_host(host);
> >>         if (err)
> >> -               goto err_clk;
> >> +               goto err_rpm;
> >>
> >>         if (rk_priv)
> >>                 dwcmshc_rk35xx_postinit(host, priv);
> >> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>         if (err)
> >>                 goto err_setup_host;
> >>
> >> +       pm_runtime_put(dev);
> >> +
> >>         return 0;
> >>
> >>  err_setup_host:
> >>         sdhci_cleanup_host(host);
> >> +err_rpm:
> >> +       pm_runtime_disable(dev);
> >> +       pm_runtime_put_noidle(dev);
> >>  err_clk:
> >>         clk_disable_unprepare(pltfm_host->clk);
> >>         clk_disable_unprepare(priv->bus_clk);
> >> @@ -602,9 +612,13 @@ static int dwcmshc_suspend(struct device *dev)
> >>         struct rk35xx_priv *rk_priv = priv->priv;
> >>         int ret;
> >>
> >> +       pm_runtime_get_sync(dev);
> >> +
> >>         ret = sdhci_suspend_host(host);
> >> -       if (ret)
> >> +       if (ret) {
> >> +               pm_runtime_put(dev);
> >>                 return ret;
> >> +       }
> >>
> >>         clk_disable_unprepare(pltfm_host->clk);
> >>         if (!IS_ERR(priv->bus_clk))
> >> @@ -642,11 +656,65 @@ static int dwcmshc_resume(struct device *dev)
> >>                         return ret;
> >>         }
> >>
> >> -       return sdhci_resume_host(host);
> >> +       ret = sdhci_resume_host(host);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       pm_runtime_put(dev);
> >
> > To simplify the error path, I would suggest that you move the call to
> > pm_runtime_put() to dwcmshc_suspend(). In fact what you need is just a
> > call to pm_runtime_put_noidle(), somewhere after the call to
> > pm_runtime_get_sync().
> >
> > This is because runtime suspend is prevented by the PM core as it
> > bumps the usage count with a pm_runtime_get_noresume() in the
> > device_prepare() phase.
>
> I thought you didn't want to assume that, because in that case
> it can just be pm_runtime_resume() instead of pm_runtime_get_sync(),
> and then no 'put' is needed at all.

I don't really care, but just wanted to keep it as simple as possible.

So yes, I am fine with a pm_runtime_resume() too. Maybe even simpler
in this case, as we are not using pm_runtime_force_suspend|resume()
anymore.

Kind regards
Uffe
