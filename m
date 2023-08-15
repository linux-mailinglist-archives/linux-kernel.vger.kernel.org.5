Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2877CBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjHOLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjHOLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:41:25 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB81991
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:41:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d64f0c2bc95so4452594276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099681; x=1692704481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4N1vFKm98r9vL5Jh5sxV8586i7eO9cMGxgErXba+/4=;
        b=i8H9RPfwWZN5SdrzuJGdmA3uCpPVgtpphfVjC7dYcJNvPtS1HMkQxxrO5NFviylaUt
         uXTkIExM+KTbbsJLOtDCFLGw4xcd/bV1Js587igO+qTrjKOxouFqVBLAKkIp0+RteYIe
         IrWRkGKOoMudqdKbcEu7pjiJj7Lc2wB66qg7+HZhtv6Dh+tMcsg0gS1D90s9SWqocVfS
         GepCTZK0T9TDuC0l6TCxXkf00H1m6vOMCysuoA9XJda38I/t4aiWMS2a04tbERYcyUZ4
         j0+3uCQYGZMODbLL77987xgsQT01qdievLRXLO1HKPEO6DIqA4Fq7PMfinYhaYSd12BT
         ACbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099682; x=1692704482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4N1vFKm98r9vL5Jh5sxV8586i7eO9cMGxgErXba+/4=;
        b=ZEH4oUp3mjsw9hWObWOfiaqJb6CNAssbujL0HREcWNk2SNk916rdiZGeePXEKnKh7y
         svniWR1syalUkvz9qpESgUtUDVd3Msx4k6bxx8QkAH1rTKfVqzcpEksmLgZMjmqhHuQR
         e1Ff+n+/nHPhZDx0KCwSKY8OEhdmQJ0z8D7YnZ7tQ5/ysaorYloAsmJBLyY3qZnKcp81
         veekfJG4h6f9EM6nWqEwxs86SX/1CYTsg7PZfJKZIJBYnofhbpOdluIhtcvs63Q7Qj5Q
         aUi64aczTu0YGso3hoKeCcwA89tyHQwe6yHqBbdZU7ZH2e06SGhRv/6d3CSZdJdEkG68
         VPqg==
X-Gm-Message-State: AOJu0Yw0bj6ypP64afUGxWC0laenQuwR6X8LA2PJ46n1q56EluovTkM1
        TloIntdqBMurCQRA2rtFoT+9lo9eixbQE4HNqKRcOQ==
X-Google-Smtp-Source: AGHT+IEIAsC6RK376JyprtRFIyknlP7H7j8/Aqc8TKJ/xLDgxozFxS+HxDwj0bExgLR8ZiRgeyS/eLLAaNDqLn3YRww=
X-Received: by 2002:a05:6902:18ca:b0:d5c:fb65:7e72 with SMTP id
 ck10-20020a05690218ca00b00d5cfb657e72mr16923086ybb.65.1692099681618; Tue, 15
 Aug 2023 04:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230811130351.7038-1-adrian.hunter@intel.com>
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Aug 2023 13:40:45 +0200
Message-ID: <CAPDyKFrevs3TVcn_2b7RKR8ZxKUHQgxj3sA-FcXt0L3euujKMw@mail.gmail.com>
Subject: Re: [PATCH 00/16] mmc: sdhci-pltfm: Minor clean up
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 15:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> sdhci_pltfm_unregister() does:
>
>         clk_disable_unprepare(pltfm_host->clk)
>
> which prevents drivers from using devm_clk_get_enabled() or similar.
>
> Move it out, and where drivers are doing devm_clk_get*() immediately
> followed by clk_prepare_enable(), combine them into devm_clk_get_*enabled().
>
> sdhci_pltfm_register() and sdhci_pltfm_unregister() are not paired functions.
> That are just helpers and effectively get renamed:
>
>         sdhci_pltfm_register() -> sdhci_pltfm_init_and_add_host()
>         sdhci_pltfm_unregister() -> sdhci_pltfm_remove()
>
> Please note, the patches are based on top of some
> "Convert to platform remove callback returning void"
> patches by Yangtao Li, which were posted here:
>
>         https://lore.kernel.org/linux-mmc/20230727070051.17778-1-frank.li@vivo.com/
>
> Patches can also be found here:
>
>         https://github.com/ahunter6/linux/commits/sdhci-pltfm-cleanup-1
>
>
> Adrian Hunter (16):
>       mmc: sdhci-pltfm: Add sdhci_pltfm_remove()
>       mmc: sdhci-bcm-kona: Use sdhci_pltfm_remove()
>       mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
>       mmc: sdhci-cadence: Use sdhci_pltfm_remove()
>       mmc: sdhci-dove: Use sdhci_pltfm_remove()
>       mmc: sdhci_f_sdh30: Use sdhci_pltfm_remove()
>       mmc: sdhci-iproc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-at91: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-hlwd: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
>       mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
>       mmc: sdhci-st: Use sdhci_pltfm_remove()
>       mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
>       mmc: sdhci-pltfm: Rename sdhci_pltfm_register()
>
>  drivers/mmc/host/sdhci-bcm-kona.c  | 12 +++++++++++-
>  drivers/mmc/host/sdhci-brcmstb.c   | 18 +++++-------------
>  drivers/mmc/host/sdhci-cadence.c   | 17 ++++-------------
>  drivers/mmc/host/sdhci-dove.c      |  8 ++------
>  drivers/mmc/host/sdhci-iproc.c     | 14 +++-----------
>  drivers/mmc/host/sdhci-of-arasan.c |  4 +++-
>  drivers/mmc/host/sdhci-of-at91.c   |  2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
>  drivers/mmc/host/sdhci-of-hlwd.c   |  4 ++--
>  drivers/mmc/host/sdhci-of-sparx5.c | 17 ++++++-----------
>  drivers/mmc/host/sdhci-pltfm.c     | 14 ++++++--------
>  drivers/mmc/host/sdhci-pltfm.h     |  8 ++++----
>  drivers/mmc/host/sdhci-pxav2.c     | 19 ++++++-------------
>  drivers/mmc/host/sdhci-st.c        |  4 +++-
>  drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
>  15 files changed, 58 insertions(+), 87 deletions(-)
>
>

Applied for next, thanks!

Kind regards
Uffe
