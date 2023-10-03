Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F143B7B676A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbjJCLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbjJCLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:13:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75520FB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:13:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d865854ef96so803529276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331590; x=1696936390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMzuAMLC8oWHrefC2Cvtktz7gTrG3/X+VCGWjMzxEXs=;
        b=c/E8QEN/NoZ+SbV3q/ndWAX+h/+Sj3sJeK68SBG9eGANVyOlghb9MCI5v5RSJ2daFx
         sNKX4TJtUXjJxDoChcXEiVPJQCsQUjS6BOMeL+MTTM1XFnS136JXHRVFw2uGifZBNYOV
         9xbfpzW01YJTREEjLMiFmTrpDklkGV6bOi9QWHcGdWwji9nCP5lLPb43NIASc/i7b6WA
         5ExMVW1QatQxoJhpigDb9UBRKUgTaLo5/Sz5tWvxUKRmFI43c2KFk65uCLsAcjvveT2A
         XUXb2clHb0uO9eX1UQmPanoVwOyjtG8qVeX0zWfc9kH8w1+Edd1Eabg5cO7yquyGBj/P
         RGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331590; x=1696936390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMzuAMLC8oWHrefC2Cvtktz7gTrG3/X+VCGWjMzxEXs=;
        b=E+8oZPLljxFtzzcE8WEcDfUR7YhZdIdXkfETyZ65E6pAxpgmMqSL52IreRYefYt0Kt
         wPQ18spUorBuuBfxm8nzQO+5TlzRixjNAoz1brlU40sR5k1EfePuPq1nVf6om3kEJ6GN
         XfkUpuFcOv5blFjmAlGUovRKgPEg7x4dlf+QQOZT/Etn0N3Q3TWZh0Q/siopkE0hQ+sM
         zo+kSDhBNxNlDBi7Bgyk2ZRho61euv52QvHJPaZM0BqM0C/T2jch54qjNNzgX5kbL/LB
         5bb8J68LX20Tr9mPX40jm2XdY4Wc2T6KgOBM1BO2vH5aO73M+akEIC660eTJJmm9U+lw
         rilQ==
X-Gm-Message-State: AOJu0YxNWt+5BjqFA1fKi+bKM/QNw44NKdGQSEfH5QnTTpnA/nwHhZXf
        yvih6vBgn1djFh4ZOBDzszIWf5tXNQ/SVR1DsUjta5ywIK1iVfZQWb0=
X-Google-Smtp-Source: AGHT+IG/CW1SUwPYpkSqEtrqM5VVydbWqWOLLufX/qlAlZ9PiUj8iLVWSpIrGDx7A/McbCUwf/mo0BZopftgLh+iXwM=
X-Received: by 2002:a25:9f85:0:b0:d4a:4b59:367e with SMTP id
 u5-20020a259f85000000b00d4a4b59367emr12576425ybq.38.1696331590107; Tue, 03
 Oct 2023 04:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-17-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-17-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 13:12:33 +0200
Message-ID: <CAPDyKFoeBgoEyCg8GmZB718g1dg8dqi_kdLr-jLqWdEE5q4Oyg@mail.gmail.com>
Subject: Re: [PATCH V12 16/23] mmc: sdhci-uhs2: add clock operations
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

The similar comments as posted for patch 15 applies to $subject patch
too. Please have a look at those and fix these for the $subject patch
too.

> ---
>
> Updates in V8:
>  - Remove unnecessary include file.
>  - read_poll_timeout() to instead of read_poll_timeout_atomic()
>    in sdhci_uhs2_enable_clk().
>  - Put the comment on the end and put the lines in descending
>    line length in sdhci_uhs2_enable_clk().
>  - Modify return value in sdhci_uhs2_enable_clk().
>
> Updates in V6:
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 4c2a56629ab3..af1b0c5e48fd 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -329,6 +329,36 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         return 0;
>  }
>
> +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clk &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       int timeout_us = 20000; /* 20ms */
> +       u32 val;
> +
> +       clk |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
> +                             10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
> +               pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +               return -EIO;
> +       }
> +       return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *

Kind regards
Uffe
