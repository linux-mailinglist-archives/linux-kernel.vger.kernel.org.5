Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B5751F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjGMLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjGMLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:07:25 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF362686
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:07:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579d5d89b41so4936887b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246443; x=1691838443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1X6eNhBTJxyZAA2cC+a9zRtrXgflOJ4PWxxjhd5jKI=;
        b=L5WMUOn2qxVhMX/WOCYk880GFyBMWzdLDyRWpQLs7jAFZT52XgtRj6bGuX34glr3nr
         rDGmCutzUqyxkuEvy13JPa0UqT0GoTZe1xOWUpDf64Jo0x0bhlsdlfTlFhFn//Kg3Z1V
         mTfQw/ItZ17rzOhmv3679QGAvKpg++hT2RZWufH+lbljGwwvrEsh87REvponNSVVcOEa
         Wpo4Oy+cQ0BSB2SHzgoPiUQiWLlJp8ANYQBWB+SSxIRpY7hb3+q5hADV+jFGjflH4tXn
         f1Ez51xA3nzGfgh0pwwGVVgXO8MbQFeQIvOjF2pSzV1mQQFAm9LdhAu1bd3GiTrt+1Ol
         RKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246443; x=1691838443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1X6eNhBTJxyZAA2cC+a9zRtrXgflOJ4PWxxjhd5jKI=;
        b=Y+2D9kvDVWIuAIssThod3bSPRcIVBS5bwgOtk4uFIY3R4QgVunY3QbvNG/yoJhJZps
         3yuGoCzgDsCcwPROtTGChP07S5fKjIu1GYmiyNaym7HMRPxLfNoSDFqNsPpIcabEyQUI
         jGEx1mzCCzrrvmOiLOwQ+eP2yPvgVDOnodSPFXhLxwApAdgFuZDRciPNU3eQYgPa56Cv
         berNI7v8V0idCahSEZosXAvcG10UZ8l2xgGYaRdeyfwjx5uefKXrCJxw60odcE5o+GD3
         9HVL9/jdkPUaqcrMgte6i2nbQ0+uAi1TirS+y4i00kHf+N2zkL6my74UCk0JZ5bzgOq2
         y39Q==
X-Gm-Message-State: ABy/qLY57XQ2q6pas9f8VR1y1NrGjic3KmIn/AfiCRimDU7bfJwnmkcH
        J+fCxPLGJEd9aj0E49IpNpcf0tFifkss/pr24qKfwQ==
X-Google-Smtp-Source: APBJJlH2P039fSEsr0FrFFqBrnQbLDD077beS/CwvVXjAT1DR8HmrZix0F4wo1Hx7dZohCkGiVdlIoKk6riWLtG39wc=
X-Received: by 2002:a0d:c2c4:0:b0:57a:8de8:f3b3 with SMTP id
 e187-20020a0dc2c4000000b0057a8de8f3b3mr1395566ywd.48.1689246443561; Thu, 13
 Jul 2023 04:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131939.22562-1-frank.li@vivo.com> <20230704131939.22562-2-frank.li@vivo.com>
In-Reply-To: <20230704131939.22562-2-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:47 +0200
Message-ID: <CAPDyKFo90Z-4gGnywfUf6QOY_QP4yLdh6y-=kMMSAYR9hhH5Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: omap_hsmmc: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 15:19, Yangtao Li <frank.li@vivo.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1e0f2d7774bd..93de00a06aba 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1790,14 +1790,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 return -ENXIO;
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENXIO;
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
>
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> --
> 2.39.0
>
