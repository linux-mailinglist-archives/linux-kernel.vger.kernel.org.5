Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C147A07A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbjINOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbjINOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:46:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680361FC8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:46:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7e741729a2so1116161276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702789; x=1695307589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4qtZmBwwjpiJ1Z7K5tiJyvsgnf0O0Obv1kjqllyr8Pc=;
        b=kpJdpyULMiebQx8arQdUZrjCegUNeyZ3VjdNDHMSLx8MphuoQk7wSDuuW3otYilR5n
         /F/6LNGmvVDZ7cmfHRTXrwZdDF/aGCCefIbA1U8DBBf8ofMOvzbp3oZ2F0qaQCuYVFR1
         qepD8+fA5Yd822ug0NfaxuaDVJlylAQvONKplwMjQ/0ia7aB4s0meWWROq1Ioxzo83f8
         9HwCOMjzZViAACXA+MK3aU1PrYrRKUFOaUWFXN9fxXD/ekdkGy0n6xI5KRGdzSqE9/05
         Z0xD0hrUkhW3EZFprsFX3uus7UxYSY0LygbYU67g7RxrxzLo+8zoxtrmeYL1jPoiO0M7
         sfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702789; x=1695307589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qtZmBwwjpiJ1Z7K5tiJyvsgnf0O0Obv1kjqllyr8Pc=;
        b=A8VEmgfNkC/NAkG3oWUlhNA4DoB7xY2ZQSNlX2EwMdj3Gqf1bfmLfAKnwzKmERZCE1
         awZpfFZY2erEIz4rdUJPU5whMcxiclkni1mavQ86jV3/NZd2OQomhtDFUf+d3cncjOg8
         IWLKCLLlarY5TBJBWBM0kq7ak10MeePE3maAo4QOPE8eRIO4hytWht7+gAZCEjjPrPjY
         7fQ/2cMHLZDKlbw2e+Vrn/8XFhPf0CQsxWjID+cMtsc0sjr36UpmaEOQZs44Hqdpc49g
         TgIqYbzo+0sXweSUWuedSlGlgMzJ70d2CWOWhsU/d/ootjupYiMRc5urLLeEniCXviWf
         6nZA==
X-Gm-Message-State: AOJu0YwkVshArvRkwBPChFWCr8BaBH7HLqMwY+Xkmqf+vd4AGzHkFaap
        nr78lPM6HeaI80HqQlrTU3c6+3uGNX0C9krV/yPQGw==
X-Google-Smtp-Source: AGHT+IGf1v5b0F0uzbAyJ1jj+d9Q8GYVHSjjTlKHADrRvbsB5zOjl01k8leJ2gfqNujX8IM/MTANKn4OHcIM7UCTJvk=
X-Received: by 2002:a25:760c:0:b0:d7b:9d44:76dc with SMTP id
 r12-20020a25760c000000b00d7b9d4476dcmr5924626ybc.38.1694702789586; Thu, 14
 Sep 2023 07:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:45:53 +0200
Message-ID: <CAPDyKFqyi97kjdiNM60WYK+cs4pw5pW3AyfiWKnsCRXd5BXUww@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>,
        martin.blumenstingl@googlemail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Thorsten

On Mon, 19 Jun 2023 at 19:36, Ziyang Huang <hzyitc@outlook.com> wrote:
>
> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
> Then we set rx_clk_phase to 11 or 15 which is out of range and make
> hardware frozen. After we send command request, no irq will be
> interrupted and the mmc driver will keep to wait for request finished,
> even durning rebooting.
>
> So let's set a common value - 1 just for initialization. Then let
> meson_mx_sdhc_execute_tuning() to find the accurate value for data
> transfer.
>
> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

I don't quite understand if this patch is ok for everybody for me to apply?

It seems like it solves at least some part of the problems that
Martin/Thorsten were looking at too [1], right?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com/#r

> ---
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index da85c2f2..a01090a2 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -269,7 +269,6 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
>  static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> -       u32 rx_clk_phase;
>         int ret;
>
>         meson_mx_sdhc_disable_clks(mmc);
> @@ -290,31 +289,12 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>                 mmc->actual_clock = clk_get_rate(host->sd_clk);
>
>                 /*
> -                * according to Amlogic the following latching points are
> -                * selected with empirical values, there is no (known) formula
> -                * to calculate these.
> +                * This value is just for initialization. For data transmission,
> +                * meson_mx_sdhc_execute_tuning() will find a accurate value
>                  */
> -               if (mmc->actual_clock > 100000000) {
> -                       rx_clk_phase = 1;
> -               } else if (mmc->actual_clock > 45000000) {
> -                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> -                               rx_clk_phase = 15;
> -                       else
> -                               rx_clk_phase = 11;
> -               } else if (mmc->actual_clock >= 25000000) {
> -                       rx_clk_phase = 15;
> -               } else if (mmc->actual_clock > 5000000) {
> -                       rx_clk_phase = 23;
> -               } else if (mmc->actual_clock > 1000000) {
> -                       rx_clk_phase = 55;
> -               } else {
> -                       rx_clk_phase = 1061;
> -               }
> -
>                 regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
>                                    MESON_SDHC_CLK2_RX_CLK_PHASE,
> -                                  FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
> -                                             rx_clk_phase));
> +                                  FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE, 1));
>         } else {
>                 mmc->actual_clock = 0;
>         }
> --
> 2.34.1
>
