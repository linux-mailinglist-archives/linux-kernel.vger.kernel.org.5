Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B0786D54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbjHXLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240971AbjHXLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:01:48 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4576F1FCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:04 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59205f26e47so46152237b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692874862; x=1693479662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJk4IWME6WZnVOUMNwZF4Tbaz/pIeHP6xJOYCe2MNEo=;
        b=JPExiglr0NcR9gmjqfOtKhqTCoZ+GIpcZHkXoLnzHQx2rvXmKJSaEo4EVHg2uN8pnb
         iYwnoN88nlqa8HGSm95nEB6gRN481Uf5O5+zK2DItpEo9OjlqtkU159LeXKu4D8SJJQ+
         pThPN2YT5mW+1f8fzVmsmNT0pXxxJq14ocH3FaJI9JrUAFyyArP2m1KH3zrywEmqXhma
         ZFcSYQfcp51872cPlc99e6JHq5+544he0ZiLCkJGaydxKMdYwMjKxcytZTf0dYvpPfHo
         zVWXccq9pqS3ThDluKPUBVfMCjrfm0veJaLWxsWEKW5+wAFWVG5dsyNLJCAmz4BTk2cP
         1Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874862; x=1693479662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJk4IWME6WZnVOUMNwZF4Tbaz/pIeHP6xJOYCe2MNEo=;
        b=WZ6mVBQ3KSCRuXbqOQ4SomFO7Vyn0e7mIxYotAX2YXUj4Tlwo9imoBWJN20Z9foqLV
         MhzukYIZQIs8ZncSD3n8A36n+1YViErNTosE3sNvJW26Lijq1pH8LQgwqwkiAQhphoto
         UwQY/A60F1mG2DyWTZjM31ncYvnX4yW6IeTf95YA1YT2hkjgsv2TkK+fqJHTnv8rZFMd
         30jonIKbDGky/HNBYU1fMkAXyDARnh6RSCXOB1mult507fieRdI8PhvkSWD7LFwjOzXm
         8yZqlHty/oH6luwSCwp9dxqTCohe/7xH69vWGeTnknInrSsnNPo/MDMga2448Kx1/Pe3
         rcRw==
X-Gm-Message-State: AOJu0Yz3bLEmrtnIhNPFrQ2kJGEua4YwVZpuSRplTnZoU60whNqE4vIi
        rggCaeQ2n1lyYVWH4UNoxk0yBqzNIm4p+QruSR4d6E0UvSKKESDmjJw=
X-Google-Smtp-Source: AGHT+IEyJLIqk0j3Ygcx2L3vmQ3TrSLWoUiGRyZ7mxxe8fj0nQlDwVH+ISzkOpH8tSg5MBrqxSWyZxzMFvnPUN8i84w=
X-Received: by 2002:a0d:d7c5:0:b0:592:264c:a88c with SMTP id
 z188-20020a0dd7c5000000b00592264ca88cmr10153718ywd.18.1692874862653; Thu, 24
 Aug 2023 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230822195929.168552-1-limings@nvidia.com>
In-Reply-To: <20230822195929.168552-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 13:00:26 +0200
Message-ID: <CAPDyKFofKO_B8h5QY0c_XGaEQQdAeXw8iv52+J+NbJghRhXPWA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] mmc : sdhci-of-dwcmshc : add error handling in dwcmshc_resume
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 21:59, Liming Sun <limings@nvidia.com> wrote:
>
> This commit adds handling in dwcmshc_resume() for different error
> cases.
>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next (I amended the patch according to Adrian's
suggestions), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 31c1892f4ecd..bc332a035032 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -630,17 +630,32 @@ static int dwcmshc_resume(struct device *dev)
>         if (!IS_ERR(priv->bus_clk)) {
>                 ret = clk_prepare_enable(priv->bus_clk);
>                 if (ret)
> -                       return ret;
> +                       goto disable_clk;
>         }
>
>         if (rk_priv) {
>                 ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>                                               rk_priv->rockchip_clks);
>                 if (ret)
> -                       return ret;
> +                       goto disable_bus_clk;
>         }
>
> -       return sdhci_resume_host(host);
> +       ret = sdhci_resume_host(host);
> +       if (ret)
> +               goto disable_rockchip_clks;
> +
> +       return 0;
> +
> +disable_rockchip_clks:
> +       if (rk_priv)
> +               clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> +                                          rk_priv->rockchip_clks);
> +disable_bus_clk:
> +       if (!IS_ERR(priv->bus_clk))
> +               clk_disable_unprepare(priv->bus_clk);
> +disable_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       return ret;
>  }
>  #endif
>
> --
> 2.30.1
>
