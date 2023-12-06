Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35E5806B67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbjLFKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377418AbjLFKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:10:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648DD4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:10:35 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 411D23FAE8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701857430;
        bh=fcdtr+UWRkr2bcyvcYZo0x7Tv/0e4LlLY26MkaiwxuM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UzJH0zV2olX7sgDWm8/u+fi8RgSkgJAOAkWVXBjOuN+wSlGjzf0E52NwNxNDRu12Q
         3KRiTFTSMkZagwqU71zvpY1EZFSUGl5TsoY36dwk9SnfFaGoOQXZdnYx8c4Vl6Pz2l
         80msDLUxyRa9j20TNyFE5OP53u9d+P39zQqWv8b93z34EUMIWD9wOjwO4qpeblkxca
         AgcTuiq+psTMCpE9jwGBplIYTs7HMPvxqSsPewBRu8XZGCJwPLrgXZjA4UfmtU+lXD
         5G9bBQUMYaFI1pkBX6Ez81VkNdUtJpSySVlKK23B05aQwBYO2U51cy7wSWetekRUfD
         Lp1ZGZ+C8tFLA==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9f5bf236fso33895451fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857429; x=1702462229;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcdtr+UWRkr2bcyvcYZo0x7Tv/0e4LlLY26MkaiwxuM=;
        b=YhN4cwuAgDx0RuYpOI33PamcXrxZGpxuGdNPSQkV4djJ5NK/iQYd1SUtTxFr5tXdaD
         /sHi9spVnmX5ukP01D08hCxxq6F+guJC1wl6W3SzeN+/R3jqGGmKdayGByFzizobJw17
         hNCWpWQfH3TQIBoGljN5QrPBMYsGxTgABDb/ycPKPG24xtYig4UcE8CeRJjiIxjahNDw
         R64MHNbQE0Z/X/L9Vowd9vMPv4ZL3mJ40n1mkx5tWNv1fXo49t3iAkMjxNmMWYbvosC3
         h/r/or18CJYt4aYjnE0Xgkp29z3PsWolgsylwB0tTZnGe++OTx2uBZg5JzV2EnuuTaJm
         88Ww==
X-Gm-Message-State: AOJu0YxNrLxJxIvd4zuKfkkk0wRmqAHiBKm/YwMkZ/E6gHxfUEra+k+C
        8lal0QsoL0k49oEDEhk98tfBXJf3/VdgeuluE9Pp0wdZsB9+YUZrInNpdIUg6XWiyXS+ONHOkaO
        NqL7xLC6o1OE3DQFDs6q4n47abSS2LDNLkLdiAw2v/eMXLQ29vbAmrS8fiA==
X-Received: by 2002:a2e:a456:0:b0:2ca:252d:ea3d with SMTP id v22-20020a2ea456000000b002ca252dea3dmr330683ljn.98.1701857429651;
        Wed, 06 Dec 2023 02:10:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs92N5wzpZ2+RDYJq5RciPViDvSYByTuJP/RjgJ3NmIPzmJzSvS2xAGrVkoFNNDaX6YxvjLcMhL1PXJThRVN4=
X-Received: by 2002:a2e:a456:0:b0:2ca:252d:ea3d with SMTP id
 v22-20020a2ea456000000b002ca252dea3dmr330669ljn.98.1701857429336; Wed, 06 Dec
 2023 02:10:29 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Dec 2023 04:10:28 -0600
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-2-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com> <20231206-th1520_mmc_dts-v8-2-69220e373e8f@baylibre.com>
Mime-Version: 1.0
Date:   Wed, 6 Dec 2023 04:10:28 -0600
Message-ID: <CAJM55Z_jRhJLLQg9_OzJ_UeqaoqByu_BgxmwtVRUK2Z+qEKZxg@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
To:     Drew Fustini <dfustini@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Fustini wrote:
> Add node for the fixed reference clock used for emmc and sdio nodes.
> Add emmc node for the 1st dwcmshc instance which is typically connected
> to an eMMC device. Add sdio0 node for the 2nd dwcmshc instance which is
> typically connected to microSD slot. Add sdio1 node for the 3rd dwcmshc
> instance which is typically connected to an SDIO WiFi module. The node
> names are based on Table 1-2 C910/C906 memory map in the TH1520 System
> User Manual.
>
> Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>

Thanks! The rest of the patches look good too, but I don't really have
a schematic
to do proper review.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index ba4d2c673ac8..8b915e206f3a 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
>  		#clock-cells = <0>;
>  	};
>
> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <198000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -304,6 +311,33 @@ dmac0: dma-controller@ffefc00000 {
>  			status = "disabled";
>  		};
>
> +		emmc: mmc@ffe7080000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7080000 0x0 0x10000>;
> +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
> +		sdio0: mmc@ffe7090000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7090000 0x0 0x10000>;
> +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
> +		sdio1: mmc@ffe70a0000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe70a0000 0x0 0x10000>;
> +			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
>  		timer0: timer@ffefc32000 {
>  			compatible = "snps,dw-apb-timer";
>  			reg = <0xff 0xefc32000 0x0 0x14>;
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
