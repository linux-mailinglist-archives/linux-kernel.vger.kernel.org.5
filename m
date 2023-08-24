Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA23786C99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjHXKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbjHXKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:11:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C3198A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:11:49 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59231a1ca9eso37533187b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871908; x=1693476708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl1Q50iBdvCe5yXtMKZeggNf2z/kDCkF0CSNbFHkckI=;
        b=MWPeZiaV94eD0r+5t0wdUz9wReNqAYmRAENUMMJEkml4RH2wlEoFqGlDit+EWODwQA
         5ZG4ehZHT9fkISlrVp95oFTdEQwKHpkGxTsn/Oa+djoo1naBWG+DRNh9KZDx+x0uUyNL
         lkgk5aqZ8GpuvHQlymX/f19ZkYdlftRtLDWyBc2HBVNRqCi+JMwmsMdBG92IUaMytyH2
         3npp5YsqUIzJjVXp2INqN26cid6g95//+SeEsv8EuIN4g9PPEIXfjxEPPW9IYbA/V/GO
         Z6vgS6WlFMnff9hs2GXybOmJyjrcaMeF6EA4eF7cRWk/oVE7DabMtnx6g14lhoCR6srH
         zVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871908; x=1693476708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bl1Q50iBdvCe5yXtMKZeggNf2z/kDCkF0CSNbFHkckI=;
        b=Fh07aY3Ju3I7g3KzmBsN+Ij5lWcga+xluLSw5dYDizvGbPlV0AmtMkPlf4u6xICa42
         QTBV7Al2tkzz/1SqxAV05MD9YmkN8uKsNDa0+ozri5q4Xmk4Lk5VZjhfJgi/TgOK2siP
         k9t7P0YKvlOHHx0Vk1sgnYVwpjVHqzJ1s+cfpeoQBUShUzFRQOTdJPmU6c2IqJPfyIdG
         uwrsbGwIV/1Qf02n+vLnmMXR3Zh7/R86oBF65/NGPP12FWPfDXBq2xNRypUxkyhlwIa7
         bLdP+VwnBulqKDUAThhh12dQAyi//UtBDPH9Sxvu5uzyA/STO1Q1ry1pREbLLDYdi8kE
         mhKQ==
X-Gm-Message-State: AOJu0YxOBtjt4x5T0soqnSPnSGdkS8ZIVrRvkRuUUWCsOt4CIRAJmPxP
        KH/7wZ+7IUU9lWA72oicsb+iQIi7dyVFaaSpqRseIQ==
X-Google-Smtp-Source: AGHT+IGvSXY7+rdDaIUHF9HjDvskEigToneQarxKPoW1CYKgFy0fTTrMflFl3uOlx1h55l1O4xnlqO1ip0o2IVD4ULk=
X-Received: by 2002:a0d:e692:0:b0:565:c21d:8ec6 with SMTP id
 p140-20020a0de692000000b00565c21d8ec6mr14885752ywe.6.1692871908391; Thu, 24
 Aug 2023 03:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com> <20230815014057.13589-2-wenchao.chen@unisoc.com>
In-Reply-To: <20230815014057.13589-2-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 12:11:12 +0200
Message-ID: <CAPDyKFphAPOSj5L6Q8tdmD0S3EkxTW8EfMyXKsoUU2jqLydx=g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: core: Add host specific tuning support for SD
 HS mode
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 at 03:41, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Added .prepare_hs_tuning and .execute_hs_tuning host callbacks to
> support host-specific tuning for SD high speed mode.

Please clarify this is entirely optional, host specific - and that
there is nothing in the SD spec that mentions this.

>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd.c    | 12 ++++++++++++
>  include/linux/mmc/host.h |  6 ++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 246ce027ae0a..ac2da8f2fbce 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1518,6 +1518,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                  */
>                 mmc_set_clock(host, mmc_sd_get_max_clock(card));
>
> +               if (host->ops->prepare_hs_tuning) {

Shouldn't we check if we actually succeeded to enable MMC_TIMING_SD_HS
before invoking this callback?

> +                       err = host->ops->prepare_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
> +
>                 /*
>                  * Switch to wider bus (if supported).
>                  */
> @@ -1529,6 +1535,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>
>                         mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>                 }
> +
> +               if (host->ops->execute_hs_tuning) {

Ditto.

> +                       err = host->ops->execute_hs_tuning(host, card);
> +                       if (err)
> +                               goto free_card;
> +               }
>         }
>  cont:
>         if (!oldcard) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..13cf894b9e3c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -184,6 +184,12 @@ struct mmc_host_ops {
>         /* Execute HS400 tuning depending host driver */
>         int     (*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
>
> +       /* Prepare HS tuning depending host driver */

How about rephrasing this into something along the lines of "Optional
callback to prepare for SD high-speed tuning"

> +       int     (*prepare_hs_tuning)(struct mmc_host *host, struct mmc_card *card);

To make it more clear this if for SD high-speed, maybe we should
rename the callback into:

"prepare_sd_hs_tuning"

> +
> +       /* Execute HS tuning depending host driver */

How about rephrasing this to something along the lines of "Optional
callback to execute SD high-speed tuning"

> +       int     (*execute_hs_tuning)(struct mmc_host *host, struct mmc_card *card);

Maybe execute_sd_hs_tuning instead?

> +
>         /* Prepare switch to DDR during the HS400 init sequence */
>         int     (*hs400_prepare_ddr)(struct mmc_host *host);
>

Kind regards
Uffe
