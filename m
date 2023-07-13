Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328C751F81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGMLG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjGMLGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:06:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107D211F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a1d9b64837so553385b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246406; x=1691838406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbUK0+KNfrljZMGdgezGa1VL09M/PuMCUQ4epk9qz0M=;
        b=HRrK+UjkOE9au7uixJmgJoJJwdJJw80q2zzyGjawwloFE9dAYM7WQ8ry/KwjoAIPGn
         y0xHA1iL/6AosK+IUCmOr+ttHAEMZSDeaHPpLW7BokW3BKOR7vewcX5eFnXYmGtOFYXn
         qWuiiINC5LresbHCXNrVqryHTfHVyI1WG5gsGcfArUiSxRa9n3xmg03wpVZqndWT0frb
         L97zBjgIc6z1RoaxMXS1UDmdEcoE65iSJdFgo3/Uxt5rfRaeXPLhHGfALG0c+HCJjzl/
         0dCyysqqrWp/3Ck62qZPhpYygAJX1sZGfBPmK2H/SRoD4rS/cBsnok2+/D2ITNNqI2GV
         MOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246406; x=1691838406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbUK0+KNfrljZMGdgezGa1VL09M/PuMCUQ4epk9qz0M=;
        b=Cq7I/P6BGVgnmwUL9fgsZPwJ+wr3TYULWnNdreEBTSy8g09XpHRwhwTzUOWBvmIPfZ
         ySGfN1w60AQdfOJK5l1VZUkzsh9WOw3G1vk1tJRH5leCinfHDpjXvjeHq+RbZ9GdYXjO
         XPt6uMtvcK3A7KR2EJNgLfLq+GVKUAqfQCYorsu3265JePTly2VRz+Fpa2Tto8N3Y95g
         GhJjlD6l4ZkowHOcRi9vXzCYJ+yAnHhBdXXdqe8mo+M8vhC9Wm71vE7hQJKCC/qKZlNA
         APeKC8mHzZDZs9DXOEXCKrjvakDZ9XxxLLHTE1OOpcQ4kbzVkEa9Neq0ZnQNzP8hRF8I
         f4/A==
X-Gm-Message-State: ABy/qLabNMQomPkGiq8w7NMXiyD4nHzKQ7hOa/uI+ZszmQOYDILaLQia
        Fu9GxDB5ceh47YGWm2kmYpGo7KsIwuMKOEcFS/YlXw==
X-Google-Smtp-Source: APBJJlH87jC6lHbK8IaI52Wr3SdxRDpbsQG0LS30do7Cik4nP1JSk/l2B0BiEbVR5NI/+S1TDJt37YbwSqC5TFuaRSs=
X-Received: by 2002:aca:6c1:0:b0:3a1:f237:ec62 with SMTP id
 184-20020aca06c1000000b003a1f237ec62mr1189805oig.48.1689246405987; Thu, 13
 Jul 2023 04:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:10 +0200
Message-ID: <CAPDyKFqJU3VwXJJDQPWvNBDz1+gSjYxFJBST3s8mpJoh7-c9-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 02:45, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
> This applies sdhci_pltfm to this driver to fix this issue.
>
> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
>   other functions that covered by sdhci_pltfm.
> - Move ops and quirks to sdhci_pltfm_data
> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
>
> Fixes: 87a507459f49 ("mmc: sdhci: host: add new f_sdh30")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Or maybe this should go for fixes and have a stable tag too?

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
>
> Changes since v1:
> - Add Fixes and Acked-by tags
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index a202a69a4b08..b01ffb4d0973 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -29,9 +29,16 @@ struct f_sdhost_priv {
>         bool enable_cmd_dat_delay;
>  };
>
> +static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return sdhci_pltfm_priv(pltfm_host);
> +}
> +
>  static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>  {
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>         u32 ctrl = 0;
>
>         usleep_range(2500, 3000);
> @@ -64,7 +71,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>
>  static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>         u32 ctl;
>
>         if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
> @@ -95,30 +102,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
> +       .ops = &sdhci_f_sdh30_ops,
> +       .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> +               | SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +       .quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
> +               |  SDHCI_QUIRK2_TUNING_WORK_AROUND,
> +};
> +
>  static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
>         struct device *dev = &pdev->dev;
> -       int irq, ctrl = 0, ret = 0;
> +       int ctrl = 0, ret = 0;
>         struct f_sdhost_priv *priv;
> +       struct sdhci_pltfm_host *pltfm_host;
>         u32 reg = 0;
>
> -       irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> -
> -       host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
> +       host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
> +                               sizeof(struct f_sdhost_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> -       priv = sdhci_priv(host);
> +       pltfm_host = sdhci_priv(host);
> +       priv = sdhci_pltfm_priv(pltfm_host);
>         priv->dev = dev;
>
> -       host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> -                      SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> -       host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
> -                       SDHCI_QUIRK2_TUNING_WORK_AROUND;
> -
>         priv->enable_cmd_dat_delay = device_property_read_bool(dev,
>                                                 "fujitsu,cmd-dat-delay-select");
>
> @@ -126,18 +135,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err;
>
> -       platform_set_drvdata(pdev, host);
> -
> -       host->hw_name = "f_sdh30";
> -       host->ops = &sdhci_f_sdh30_ops;
> -       host->irq = irq;
> -
> -       host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(host->ioaddr)) {
> -               ret = PTR_ERR(host->ioaddr);
> -               goto err;
> -       }
> -
>         if (dev_of_node(dev)) {
>                 sdhci_get_of_property(pdev);
>
> @@ -204,24 +201,21 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  err_clk:
>         clk_disable_unprepare(priv->clk_iface);
>  err:
> -       sdhci_free_host(host);
> +       sdhci_pltfm_free(pdev);
> +
>         return ret;
>  }
>
>  static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> -
> -       sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
> -                         0xffffffff);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>
>         reset_control_assert(priv->rst);
>         clk_disable_unprepare(priv->clk);
>         clk_disable_unprepare(priv->clk_iface);
>
> -       sdhci_free_host(host);
> -       platform_set_drvdata(pdev, NULL);
> +       sdhci_pltfm_unregister(pdev);
>
>         return 0;
>  }
> --
> 2.25.1
>
