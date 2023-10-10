Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359D67BFF42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjJJO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjJJO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4EB7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:14 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7a77e736dso19077107b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948093; x=1697552893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMFXa2tj0a+3GbwgUKWMupC5Z0wd+3LvMs0h1bAo39o=;
        b=viSngTB5UTPS54403DafsUGlarv9X1qHBAsbrYbduRbC1T9qzdzCx1MKrn6nyPp23k
         uPhDxjDiS0+rOjPileLXefTXURjwi6WQUe9xL9Wum76o2eSL88fFcKpIWQeXyNDo2ez7
         FY3NIlQH1ESyuoQz2wdERDuyHy6OBfkvv0Vdsw+UyZsjwLqoEtvXfrpO+b3bcgQj8g5D
         pKqxU9T4qQWRLvm91ffEBWHvbkWl6g3ff1iR6duZ7mDS4eDcH7+pnRk6ZH94YU1IlOl1
         u9g6RZ0qX8IR26tUsuFuzuqRWNi2iZy2dcS9F/2Ia5/pJVpBZWr//iufbVrbUjLUMEYq
         2gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948093; x=1697552893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMFXa2tj0a+3GbwgUKWMupC5Z0wd+3LvMs0h1bAo39o=;
        b=WP7Zc9Eqn1iSOZXzZYMZUbBJZBE/J/5U7EtewY2wHKMe/mnlVZ4apDwlorfARAFbMw
         lF/NMfefq6IncRj2MdckoG7bbVfWWaoZgArN9QSSdc1j7Vo9r15ZqNfVqOXtAwLV7yxO
         FiOoltHJTUgWWk+UaEVYO6KCwiQahqv2bNRwhsLkjpGEaS1OLFbgj0Yakn3giTYh1odB
         LEknXQT5XziDB/0pTFWNtqouv/coXLcoCNYSERDOEF6gT/mg8HUKaY5ieSWYwxeWGRlo
         TrcmYYWQbTPJq63+BnWwOp9xH/gpo05CiHVVFiIpmWlZn6CrIMhiMBIDLlulYUJySh7U
         4kXQ==
X-Gm-Message-State: AOJu0YyWypwbYio7Cfeb3NHKntNSOE0zz18rfTCijR5WizZjhYPTGXGb
        OVZGy1X39HoSUN0cJL0kZd5wO6gmgsafb079i839Bg==
X-Google-Smtp-Source: AGHT+IHt63DDVUl/54per2q6lWr5RiVDtWg+qRgLwkCNk0JsBHTDvqtDWwUj/zUeerQS+SIIS5OTP4RpQU7Tf+R+YdI=
X-Received: by 2002:a25:f910:0:b0:d81:894b:28e4 with SMTP id
 q16-20020a25f910000000b00d81894b28e4mr16021186ybe.51.1696948093409; Tue, 10
 Oct 2023 07:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com> <20231006105803.3374241-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231006105803.3374241-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:37 +0200
Message-ID: <CAPDyKFq8rDL0OF=wfE6A2g6zRy4WU=byMfZiBCR-45zw2vMktA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-pltfm: Make driver OF independent
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
> Since we have device_is_compatible() API, drop OF dependency
> in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 4d1a703a5bdb..62753d72198a 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -19,7 +19,6 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> -#include <linux/of.h>
>  #ifdef CONFIG_PPC
>  #include <asm/machdep.h>
>  #endif
> @@ -56,19 +55,16 @@ static bool sdhci_wp_inverted(struct device *dev)
>
>  static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> -       struct device_node *np = pdev->dev.of_node;
>
> -       if (!np)
> -               return;
> -
> -       if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> +       if (device_is_compatible(dev, "fsl,p2020-rev1-esdhc"))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>
> -       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> -           of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> -           of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> -           of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> +       if (device_is_compatible(dev, "fsl,p2020-esdhc") ||
> +           device_is_compatible(dev, "fsl,p1010-esdhc") ||
> +           device_is_compatible(dev, "fsl,t4240-esdhc") ||
> +           device_is_compatible(dev, "fsl,mpc8536-esdhc"))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
>
> --
> 2.40.0.1.gaa8946217a0b
>
