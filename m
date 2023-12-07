Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47E808958
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441999AbjLGNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441947AbjLGNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:38:29 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CED5E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:38:34 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db538b07865so1070286276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701956314; x=1702561114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAVV2qiEK5RCktShx/Q1QMv0e5n63Am5gtpRCSYF1Yc=;
        b=xmxbajQBGxbyTM3tMWXpxibo5+FikWAk/fYAheLrvMrR15nZJNIrT5h7n2qqHGtRHb
         cGosfGpm8r8rkttxq3Wa0ZnyXsIJHCHoGtIWz/x278e3XIkOQyRyHPrSw91lAGolZnyF
         BLOO/EZjHYjq32wQda1WzaJwYhcd8HVCkoRh6z/TVJAzo34XGI8sA6c+VN0DaSvRwAmJ
         d9kmF1sVMQKpNTe3CsSMUZj9HBChqvacPHA/OH2XqcWdOPN7gXkA8jdvckymKiOSPqgg
         xYZ057XBzgrGPvuSBMaWhsnJBB1PTCNJEaTbtF9UJo0Ojz6vFQfasLOSn9hGb/kuoYXw
         2qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956314; x=1702561114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAVV2qiEK5RCktShx/Q1QMv0e5n63Am5gtpRCSYF1Yc=;
        b=KvgHj6A+72xdT5L8N67DhsY0ABJ/FEQOXUPQbBzB6CTu++i3F8xqylqxBbLdbNlBRy
         lqtxp/Mq1E/SMInjLmr2JeV7H1k1KaVZb2fS3HYo9v5pMrvYr2wQFcHyi499tPDt5hBC
         4LZ1qwqvQ7kNuh2FDOHkrEZMUk4xrqWfxyZf2+WWw/acxajr6YMBi+sTB679TAotdJze
         pPArDWDPUmVLgadQZkM/FXFlvVCjMX2doAzDIUgMTT+4pXebm8UBEX6pw5vZzs+xOXoY
         yDVjt7defw/lDW/qdUWIXCdceXm406xkrMjw38tEWj2tLVaB1BA4/+vkHdI7kEyXiupT
         cRsg==
X-Gm-Message-State: AOJu0Yyon2YysvCvw9xH9C+GWAWN4dDzmzPEPa7GP+I1lruHK5ESdTwY
        zLgGvCl+0Lx5FFPJkml7s9e/1vS/O2C9YjsAIsIJjA==
X-Google-Smtp-Source: AGHT+IEJUzzF+mqKM2cMqlMkgSJjy8gNx2I3xz0+xRFeMN9n4FIMMoQJYpoutX6EOtTJPaW4EAm6phj5PJecY/TvrDE=
X-Received: by 2002:a25:bc84:0:b0:db5:43e7:47b7 with SMTP id
 e4-20020a25bc84000000b00db543e747b7mr2249653ybk.48.1701956314164; Thu, 07 Dec
 2023 05:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 14:37:57 +0100
Message-ID: <CAPDyKFqhGULWp3P2EpxUMLvdiijqu7qxPrY40GU2m3FM7XVCVQ@mail.gmail.com>
Subject: Re: [v1,1/1] mmc: core: Add HS400es support in retune and
 initialization flow
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        wenbin.mei@mediatek.com, yangyingliang@huawei.com,
        adrian.hunter@intel.com, avri.altman@wdc.com,
        vincent.whitchurch@axis.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, 1 Dec 2023 at 04:06, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> In HS400es mode, when we enter mmc_retune(), we will be forced to
> the HS400 mode instead of HS400es mode. So we decided to add support
> for HS400es in the mmc_retune() process.

Hmm, I was under the impression that we really don't need to do
re-tuning at all, when using HS400es mode.

Are we calling mmc_retune_enable() from a place that we shouldn't?

>
> Additionally, during the initialization to the HS400es stage, add
> hs400 tuning as an optional process.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 11 ++++++++++-
>  drivers/mmc/core/mmc.c  | 10 +++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..4bddbbb3d539 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -179,7 +179,7 @@ EXPORT_SYMBOL(mmc_retune_release);
>  int mmc_retune(struct mmc_host *host)
>  {
>         bool return_to_hs400 = false;
> -       int err;
> +       int err = 0;
>
>         if (host->retune_now)
>                 host->retune_now = 0;
> @@ -194,6 +194,15 @@ int mmc_retune(struct mmc_host *host)
>         host->doing_retune = 1;
>
>         if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> +               if (host->ios.enhanced_strobe) {
> +                       if (host->ops->execute_hs400_tuning) {
> +                               mmc_retune_disable(host);
> +                               err = host->ops->execute_hs400_tuning(host, host->card);
> +                               mmc_retune_enable(host);
> +                       }
> +                       goto out;
> +               }
> +
>                 err = mmc_hs400_to_hs200(host->card);
>                 if (err)
>                         goto out;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 705942edacc6..9760eea2c104 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1823,7 +1823,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 if (err)
>                         goto free_card;
>
> -       } else if (!mmc_card_hs400es(card)) {
> +       } else if (mmc_card_hs400es(card)) {
> +               if (host->ops->execute_hs400_tuning) {
> +                       mmc_retune_disable(host);
> +                       err = host->ops->execute_hs400_tuning(host, card);
> +                       mmc_retune_enable(host);
> +                       if (err)
> +                               goto free_card;
> +               }
> +       } else {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
> --
> 2.25.1
>
