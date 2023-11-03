Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377B7E0213
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbjKCLQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjKCLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:16:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B71A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:16:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c95b8d14so23230407b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010191; x=1699614991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zlnj1QcdhJuExKWm5OBOLI9EIo/svVqPZVVzvpe520=;
        b=x9H5rEP/6RSqakgyBKSdUHmsY459HuL4YJIZ+0i54OyymR0ImjKjm7RpjM1VHK6dux
         JVKMFipuY7/J3/8cGHNsvlcjxvTHIhLkppiuG+NOa8wqR28fVeqvKPEm4L74BcQjMA8e
         BI4m9cg2eGf3Qr4rjZPVIciVWT87VTbGE05ST52GiPlNEWzuRIk3jHEdmlcLVU0WLfIE
         X1GyyE2wOa6thh5vfo27bOwnu9YL4O+BDbMjb0RklYD9GFzMj+DinoBWGDaV7ungBVkM
         12aM9jdkbImnTECUAfRF0GJD2C6OfVhqj0kmBYTHsN0FFDtnKZafZ7fJ/mA1VNEWPGOZ
         WlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010191; x=1699614991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zlnj1QcdhJuExKWm5OBOLI9EIo/svVqPZVVzvpe520=;
        b=uyPi9YIfFtfFHY6ra35AUy6ykY4teSXLzWJnGWVtUiXwI/Uh5h8rXuzjy2QVKYgo1K
         BCId4OUm342HUgQlcKJtFO6h9iHr5XfMozrulmmoK8fCAw3hYE0y5DXlVVFSzPZgexu+
         CKVlSk4C/XfxDA5qHM0axXdIYBZkxJZGNR+XsidsUrzEm2yeX+w7ahCJc5kvbXHMCiCx
         NzH3cZko9kylSGldfBotI0B3RPVrCozKayQA/LfPfL79HwALeM6i0OW/116YYkHRBchX
         FumNdO6sMA4eA+CJUdgPUzSJ9g6vurOUXcJ08VcFjgEimwn4nurM+N13wdeA+YibhwHa
         w00A==
X-Gm-Message-State: AOJu0YxLRmttDIY20hpVRfbbVwKMWZ71z0rmKidRglahqUmj4MLmd7a0
        Uj1UFPo/bvwOt3EsvIAnsJYZYfvoOYFHYj9QfgQgAA==
X-Google-Smtp-Source: AGHT+IFQB2tqr6cHk3NEpb+OYZbDnMccJdFpi1Iu915+DK9hWrC0ZE2LOgaTVVsJiLX3xg6hLwz6VWOx0XpNveCijAs=
X-Received: by 2002:a0d:eb03:0:b0:5b3:2128:5667 with SMTP id
 u3-20020a0deb03000000b005b321285667mr2285433ywe.6.1699010190826; Fri, 03 Nov
 2023 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:15:54 +0100
Message-ID: <CAPDyKFpqCkxD9LmFqRM_AaEie0pbgFEsLTYmoj71pEr78+OssA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        yinxin_1989@aliyun.com, regressions@leemhuis.info,
        briannorris@chromium.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Anand

On Tue, 10 Oct 2023 at 18:44, Ziyang Huang <hzyitc@outlook.com> wrote:
>
> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
> Then we set rx_clk_phase to 11 or 15 which is out of range and make
> hardware frozen. After we send command request, no irq will be
> interrupted and the mmc driver will keep to wait for request finished,
> even durning rebooting.
>
> So let's set it to Phase 90 which should work in most cases. Then let
> meson_mx_sdhc_execute_tuning() to find the accurate value for data
> transfer.
>
> If this doesn't work, maybe need to define a factor in dts.
>
> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

Let's give this a try! Although, rather than queuing it as a fix for
v6.7, I am picking it for v6.8 and adding a stable tag, this should
allow it to become a bit more tested first.

Kind regards
Uffe


> ---
> Changes since v1:
>   Use Phase 90 instand of value 1
>
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index 97168cdfa8e9..29698fceb89c 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
>  static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> -       u32 rx_clk_phase;
> +       u32 val, rx_clk_phase;
>         int ret;
>
>         meson_mx_sdhc_disable_clks(mmc);
> @@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>                 mmc->actual_clock = clk_get_rate(host->sd_clk);
>
>                 /*
> -                * according to Amlogic the following latching points are
> -                * selected with empirical values, there is no (known) formula
> -                * to calculate these.
> +                * Phase 90 should work in most cases. For data transmission,
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
> +               regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
> +               rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
>                 regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
>                                    MESON_SDHC_CLK2_RX_CLK_PHASE,
>                                    FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
> --
> 2.34.1
>
