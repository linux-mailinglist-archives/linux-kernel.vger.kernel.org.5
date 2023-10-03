Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9597B666D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJCKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjJCKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:30:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49993
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:30:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d89ba259964so764421276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696329053; x=1696933853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVwfFUWyiMyIuOlyBEbAGxUKblcDseIlgsjk2Nx2xkY=;
        b=mrMmC/LBMgbw1CVz0QuuAMEP/2oAHpXunkZZ5GSwfNPq/a0oqThoBL0twNxHMqUAyP
         lVwDKm4waZiAYxEXopf9/Hpo574toTiBx31YXYltpDLNox7sLHD5zuwrb6pqNdkCtfSx
         WRV5S9LinBWDqJiJ0ntJKO2DgLxbXDSskqhbEuPA/T50HhA57WKvUSymfWHdGp/1LqBU
         GWUdN0QbHRyYBTVeSghMe3f7qqf9MfMvDFP1pcyKAosuW8hqljIjKKXK9hQTSbVFRLMj
         +ZZjcrkgAkZgkTRN4xQ/Kib+5X2gh/aYEjze3ePEmvq7JSCBhECVXo7ElIYGG/7wqTZV
         Sc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329053; x=1696933853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVwfFUWyiMyIuOlyBEbAGxUKblcDseIlgsjk2Nx2xkY=;
        b=fKRRP47bjuziWS6VnOHkGKUbT2UsHQTDfhCknGrV0wEyMoDOioDfd3m+49VXLnOuSm
         hGA/TJQICWHO0A+A7ZBjlzJ/WE5p3vTYFvpDDpOmQDbIrwjS+flK6knCTAbGP9fz6qGl
         SkKsSbtdwn6u1ceZVBA/Qq6IkUD+MWG71VrsoyjQSxCtm5nInHwYQrOu8rXWJqJVMkF6
         z6iosLckB8U8knpx7fzyDZJRozP+sE389s+gB64te/DMTBUVJ2r2j7ci4VPYlhQNPQ5H
         JNMqDMKhEZr7JDMNayL0aTJmwRv2s/Jhb50rmxiryg+9mgjlZAnQa5snQJt/JDqOdFj/
         46pQ==
X-Gm-Message-State: AOJu0Yy1tSIb2NVjvvZuvCLHOVO2V9v7rSUnx6nwqapWiVMsT+Yn24Kz
        3fUyvKVwxrQLv0TkKrnzIZrhNDbIgADzQAz9ax54xA==
X-Google-Smtp-Source: AGHT+IHVRVSpfyrBedF23ZuSgpOA5q5YBP6BOnOD2FUGzu6+0s46SlWES+Ezs1YuyagbPz9u47t19l5ffiMj0ymytno=
X-Received: by 2002:a25:ade6:0:b0:d48:1936:14d0 with SMTP id
 d38-20020a25ade6000000b00d48193614d0mr14521918ybe.53.1696329053136; Tue, 03
 Oct 2023 03:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-11-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-11-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 12:30:16 +0200
Message-ID: <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V8:
>  - Adjust the position of matching brackets.
>
> Updates in V6:
>  - Remove unnecessary functions and simplify code.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index e339821d3504..dfc80a7f1bad 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,7 +10,9 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>
> +#include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/iopoll.h>
>
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +bool sdhci_uhs2_mode(struct sdhci_host *host)
> +{
> +       return host->mmc->flags & MMC_UHS2_SUPPORT;

The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
should be using mmc->ios.timings, which already indicates whether we
are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
this.

That said, I think we should drop the sdhci_uhs2_mode() function
altogether and instead use mmc_card_uhs2(), which means we should move
it to include/linux/mmc/host.h, so it becomes available for host
drivers.

> +}
> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +       unsigned long timeout;
> +       u32 val;
> +
> +       sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +       if (mask & SDHCI_UHS2_SW_RESET_FULL)
> +               host->clock = 0;
> +
> +       /* Wait max 100 ms */
> +       timeout = 100000;

Please convert into using a define and use that directly, below instead.

> +
> +       /* hw clears the bit when it's done */
> +       if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> +                                    timeout, true, host, SDHCI_UHS2_SW_RESET)) {
> +               pr_err("%s: %s: Reset 0x%x never completed.\n", __func__,
> +                      mmc_hostname(host->mmc), (int)mask);
> +               pr_err("%s: clean reset bit\n", mmc_hostname(host->mmc));

It looks silly to do two pr_err immediately after each other, please
combine them into one.

Moreover, I think we should probably convert into using a pr_warn() instead.

> +               sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +               return;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 2bfe18d29bca..8253d50f7852 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -177,5 +177,7 @@
>  struct sdhci_host;
>
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +bool sdhci_uhs2_mode(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>
>  #endif /* __SDHCI_UHS2_H */
> --
> 2.25.1
>

Kind regards
Uffe
