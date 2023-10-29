Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610017DAC95
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjJ2NJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2NJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:09:04 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5FC0;
        Sun, 29 Oct 2023 06:09:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2fc858feso2177760a34.3;
        Sun, 29 Oct 2023 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698584941; x=1699189741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rEsmHyEPkV7MBoxDxxp2oxo1YnlfdW9ufozgcxhuFE=;
        b=QK1BoZHF1dTzhI0fqLrX23vvfINFRLGDpMUOywVVxezUY0So0vsQkuFRl5AsBShPdy
         dSsufSPD0jAxJzczvzW5Eyhs0cvVDKjLCntnfnGUT7bC8h4JBg52uCDk7Gv/s3hqONTD
         IIO8JMDlte1yEBrCdrv2rrfS32lJyZ7PyoEaZ72HdmQCxFrufytw/ubEygMMyQ/Ej5DR
         5jn78R/5cyPe1V+uC75cWK57uj6dej/BEdifU5Ku5rraEd4YJ3P/JLs4j8tu23hWd00w
         2ExeHskXEgeoeRI9JqciNGr6EKO/C7lDyz8p/V51szc5/CVBOdaTSQ6wYV87Kg2IlQZu
         b5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698584941; x=1699189741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rEsmHyEPkV7MBoxDxxp2oxo1YnlfdW9ufozgcxhuFE=;
        b=gID+n57XS72dU3/TzFLNZGD7h7XA9ztjYxtT4DXUFet7kbOkiLNQrPpqCBByX0fMPk
         1P1/y4FWgsfzFxmNx4Si+F9fmCdpZ7RvXug8jdVN89MQZ07/IIBPUbKbu3qF8Pq6Ir5v
         iln62uReyuBsecG8HPRB8UhULrgqbqtJrWPb4KD2dphWCEvXY7/yyLhGWgFiud4pYGo+
         4VuW2n0/9UMW1s38wiflzhZvId3tpNj/pFGUf7AQrh0iU3xAoRi233VppQhzQ0k6Uy0h
         JD7GyQrvjFCHqO3fAC5ZpATefmlbqj1N+QPS50288x5dASIfCxu/2SnzoiPPYD2rE3Y1
         iEaQ==
X-Gm-Message-State: AOJu0Ywllz7OiKN0DNaBA9aIGAz0vtbZUu7tlmHm2HOPTtHOgFuMgtH3
        44Vh1pffJYNkTzfOM99K+M+Ztc8A0unQgVKfnh2sl1xFcAA=
X-Google-Smtp-Source: AGHT+IGpgcnqNbXuqkw21XHiLu3JGl/K9IyANpWzyC0AbERHNIwUN7/8BkASMY48GhKsjW160YywNZ4xAk1mlz4h83Y=
X-Received: by 2002:a9d:6d8a:0:b0:6c6:1e39:e5c6 with SMTP id
 x10-20020a9d6d8a000000b006c61e39e5c6mr6825448otp.36.1698584940764; Sun, 29
 Oct 2023 06:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 29 Oct 2023 18:38:45 +0530
Message-ID: <CANAwSgTqm2-NsMjZWQwfc77CQhL_kCLnbQpm-ithOBS84UV=4w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     ulf.hansson@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, yinxin_1989@aliyun.com,
        regressions@leemhuis.info, briannorris@chromium.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziyang,

On Tue, 10 Oct 2023 at 22:15, Ziyang Huang <hzyitc@outlook.com> wrote:
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
> ---
> Changes since v1:
>   Use Phase 90 instand of value 1
>

I have tested this patch on my Odroid C1+ board.
Please add my

Tested-by: Anand Moon <linux.amoon@gmail.com>

[alarm@alarm ~]$ sudo cat /sys/kernel/debug/mmc1/ios
clock:          100000000 Hz
actual clock:   94444445 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
[alarm@alarm ~]$ sync && dd if=/dev/zero of=~/testfile bs=100M count=1
oflag=dsync && sync
1+0 records in
1+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 5.70235 s, 18.4 MB/s
[alarm@alarm ~]$ sync && dd if=~/testfile of=/dev/null bs=100M count=1
iflag=dsync && sync
1+0 records in
1+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.20267 s, 517 MB/s

Thanks
-Anand

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
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
