Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749367EC7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjKOPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjKOPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:52:53 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D319B0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:52:07 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-dae7cc31151so6843069276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700063527; x=1700668327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gRwrbcoUWjBt33xllvAc3J9R6agW+FzVm9V3zSoPOqY=;
        b=NJigtPsXTP3hXZi7RmNqvRBDlIwJ9CaNxWt5BCX0iVDLt2ml1UawiShNoyEXKwG5Wu
         0g6tAlU7PpsEnT+nCVMhGzr644vzOGByBvxc3YIsJ9LmFRwFeIrKUo8AT4sug7Dwr9Ja
         Bvhix17F0UaNB+whtxesYIcWzFY52giiGnYCWt891r7XjaaWhJalmreXgFvc8yqFCAEL
         6ZqnrJteSE0dABcdZMKatP/S+olrR7vM7RzDoF+694Q1PeruxBROCb/P3nSYysG0hzfg
         DCpj19Og1a+eGaty4XT+rG2dV3vTWf/DZId9+Es/bnH1alKwaJKzzfWVQDuATyAn7SBv
         pBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063527; x=1700668327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRwrbcoUWjBt33xllvAc3J9R6agW+FzVm9V3zSoPOqY=;
        b=xFToNDuhO/oc7EWmweY0SvNTKBiDX6/TZZx+PbvQeEVJuR+RtrwsJk5BsQKhgBnPCt
         CfoGYH91hFjLQEai6xoecOOdt09J0sPlMDOVECvuEiVr4ZSRcVLwnyEfLairCcIJo7Rg
         W3Ae0u5zUhB4hwiTJAMU94MNJqCMS7QjFW6EF9mfP0nE7NPvrVBTgHh35A2Uzh0FTq82
         ur/OfDvDsE88wVLMTgk3k2l0dgXdAJmYzib2SoWutIVp1O9jDz7ufhGqJhlBaQrsVLV6
         4qM67EkkhizSAcBJobQJgkVtTEkINBGimXWsKLC2ukreUTwsEqCfO3JCR0aFXC9ujbNz
         W77Q==
X-Gm-Message-State: AOJu0YwuAjVTIImZ/zk2h17vXcRWXtS7iF5GFbPBBDKWicyqjdmyoV5u
        1SpDT6T5zpftxyzYJ1r7LilQZ/bc9Yr+ozqwcRhFbQ==
X-Google-Smtp-Source: AGHT+IG80u7jsi1dhFVEaxNFfuNpDnJLg/1Mkx7sJJgRyAc/r6qU9c5eA4oTzGDG/lGqsJu0Ih079z4DN8ZU/fIc8tg=
X-Received: by 2002:a25:74d1:0:b0:daf:12d8:874 with SMTP id
 p200-20020a2574d1000000b00daf12d80874mr11423988ybc.59.1700063526672; Wed, 15
 Nov 2023 07:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Nov 2023 16:51:30 +0100
Message-ID: <CAPDyKFooGiv6fj+X9c4KXaBjvsTTRaHSrxinQYirTWXmX1Ht5Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] RISC-V: Add MMC support for TH1520 boards
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, 14 Nov 2023 at 22:08, Drew Fustini <dfustini@baylibre.com> wrote:
>
> This series adds support for the MMC controller in the T-Head TH1520
> SoC, and it enables the eMMC and microSD slot on both the BeagleV
> Ahead and the Sipeed LicheePi 4A.
>
> I tested on top of v6.6 with riscv defconfig. I was able to boot the
> Ahead [1] and LPi4a [2] from eMMC. This patch series also exists as a
> git branch [3].
>
> Note: I have only tested eMMC and microSD. I have not yet configured
> or tested the mmc controller used for SDIO WiFi yet.
>
> References:
> [1] https://gist.github.com/pdp7/881342620ec1509685f23a387e2fc8d7
> [2] https://gist.github.com/pdp7/97017ad88d83fccac18eba69bff817b7
> [3] https://github.com/pdp7/linux/tree/b4/th1520-mmc
>
> Changes in PATCH v6:
> - set the mmc nodes to disabled in the th1520.dtsi

Patch 1 -> 3 , applied for next, thanks!

Kind regards
Uffe


>
> Changes in PATCH v5:
> https://lore.kernel.org/r/20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com
> - fix logic in th1520_sdhci_set_phy() to correctly check that both
>   MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO are set in host->mmc->caps2
> - add Acked-by's from Adrian
>
> Changes in PATCH v4:
> https://lore.kernel.org/linux-riscv/20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com/
> - set DWCMSHC_CARD_IS_EMMC when (MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO)
>   as checking MMC_CAP_NONREMOVABLE is not sufficient
> - change prefix of phy functions from th1520 to dwcmshc as they are not
>   th1520 specific
> - remove unneeded check of priv in dwcmshc_phy_1_8v_init()
> - remove unneeded check of auto-tuning in th1520_execute_tuning()
> - fix order of new nodes in th1520-beaglev-ahead.dts: move sdhci_clk
>   before uart_sclk, move mmc0 and mmc1 before uart0
> - fix comment typos pointed out by Adrian
> - add trailers that I missed from v2
>
> Changes in PATCH v3:
> https://lore.kernel.org/r/20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com
> - always call th1520_sdhci_set_phy() in th1520_set_uhs_signaling()
>   and not only when timing is MMC_TIMING_MMC_HS400. This allows the
>   microSD slot to work as th1520_phy_3_3v_init() is called from
>   th1520_sdhci_set_phy().
> - add mmc1 node for mmc controller connected to the microSD slot
> - add enable mmc1 and add properties for microSD on the Ahead and LPi4A
>
> Changes in PATCH v2:
> https://lore.kernel.org/r/20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com
> - make use of BIT(), GENMASK(), FIELD_PREP(), FIELD_GET()
> - add EXPORT_SYMBOL_GPL(__sdhci_execute_tuning)
> - call th1520_phy_1_8v_init() when FLAG_IO_FIXED_1V8 is set
> - set DWCMSHC_CARD_IS_EMMC when mmc caps contains MMC_CAP_NONREMOVABLE
> - remove manipulation of AT_CTRL_AT_EN from th1520_set_uhs_signaling()
> - remove unneccessary cycle of enabling and disabling AT_CTRL_AT_EN in
>   th1520_execute_tuning()
> - remove th1520_phy_1_8v_init_no_pull()
> - remove th1520_phy_3_3v_init_no_pull()
> - remove FLAG_PULL_UP_EN from priv->flags
> - remove thead,phy-pull-up device tree property
>
> Changes in PACH v1:
> https://lore.kernel.org/all/20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com/
> - ADMA mode now works correctly due to a patch from Jisheng on the list
>   ("riscv: dts: thead: set dma-noncoherent to soc bus") and this commit
>   from Icenowy that is now merged: 8eb8fe67e2c8 ("riscv: errata: fix
>   T-Head dcache.cva encoding").
> - Expose __sdhci_execute_tuning from sdhci.c so that it can be called
>   from th1520_execute_tuning()
> - Refactor the define macros for all the PHY related registers to make
>   it easier to understand the bit fields that the code is manipulating
> - Replace magic numbers in the PHY register writes with proper defines
> - Replace non_removable in dwcmshc_priv with check of mmc_host.caps
> - Drop dt prop "thead,io-fixed-1v8" and instead check for existing
>   properties: "mmc-ddr-1_8v", "mmc-hs200-1_8v", or "mmc-hs400-1_8v"
> - Rename dt prop from "thead,pull-up" to "thead,phy-pull-up" and
>   improve the description in the dt binding
> - Replace pull_up_en in dwcmshc_priv with bit field in new flags field
> - Create th1520_set_uhs_signaling() and call dwcmshc_set_uhs_signaling()
>   from it instead of adding th1520 code to dwcmshc_set_uhs_signaling()
> - Return -EIO instead of -1 upon errors in th1520_execute_tuning()
>
> Changes in RFC v2:
> https://lore.kernel.org/linux-riscv/20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com/
> - Expand dwcmshc_priv based on driver in the T-Head 5.10 kernel:
>   delay_line, non_removable, pull_up_en, io_fixed_1v8
> - New boolean property "thead,pull-up" indicates phy pull-up config
> - New boolean property "thead,io-fixed-1v8" indicates that io voltage
>   should be set to 1.8V during reset
> - Add th1520_phy_1_8v_init() as voltage_switch op
> - Add th1520_execute_tuning() as the platform_execute_tuning op
> - Added th1520_sdhci_reset() as the .reset op. This function will set
>   io voltage to 1.8V after calling the standard sdhci_reset() function.
> - Modified dwcmshc_set_uhs_signaling() to enable SDHCI_CTRL_VDD_180 when
>   io_fixed_1v8 is true
> - Add many defines for register offsets and settings based on the mmc
>   support in the T-Head downstream v5.10 kernel
>
> RFC v1 series:
> https://lore.kernel.org/r/20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Drew Fustini (7):
>       dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
>       mmc: sdhci: add __sdhci_execute_tuning() to header
>       mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520
>       riscv: defconfig: Enable mmc and dma drivers for T-Head TH1520
>       riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
>       riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
>       riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  20 ++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  20 ++
>  arch/riscv/boot/dts/thead/th1520.dtsi              |  25 ++
>  arch/riscv/configs/defconfig                       |   2 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c                | 349 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c                           |   3 +-
>  drivers/mmc/host/sdhci.h                           |   1 +
>  8 files changed, 420 insertions(+), 1 deletion(-)
> ---
> base-commit: 8cfd133bee055fb537d2338b808079a77de60052
> change-id: 20231031-th1520-mmc-b4e846fe6869
>
> Best regards,
> --
> Drew Fustini <dfustini@baylibre.com>
>
