Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629F802F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjLDJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjLDJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:47:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D37125
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:47:51 -0800 (PST)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B85F3FB62
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701683267;
        bh=ocWHzI4I/IJpjMhErnBIZA0ZO+r+qla4DpGX2b6C1P0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NmdrRMqz6Dn8pVCxdLH0b38V1DL0b54B2JMSS/NCd7mJDPKWRg4MPVWLNFlC2pQ4o
         6TbXJTyt+RQuBq+MfuUnR9+2ddn/0yXKRlZNyDhMy167W16hTaExy7ufwdus3NZ1qS
         qguGFa9MRVcJfQ6Upz0VoEyV9dlnJXGlNxCcVkxnXFVJ4WSVrUYVSYw58P1Huy30Sn
         nqam6XoCwPjmcLlgczDJOpUG2BZaj3cgixf78zHxY3QlgLMzMjEUT3hWba5tfQ2cuQ
         7ZWek5il3sTfdjzp2TBbtIrpXqzdj9IfdPUoxJkagc61qa2mhAFLQCJT7803/ONhqw
         RTvhs9YALp1uA==
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9a5700c38so657940a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683266; x=1702288066;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocWHzI4I/IJpjMhErnBIZA0ZO+r+qla4DpGX2b6C1P0=;
        b=Ydb0/A1NfpegEHz/n6VLngQA/A1VtUA/8UIEP0E2GfPdDOCMyHbYTHTThdO6F/AJE9
         SrVDGfJcwn8eW2wKwT7kByGd6VlybMO2mfd2wVD8u9xePv2j3uWGNvX+Z4pgslr7aruj
         LqROlppK3Afo8T5ZPnhKKKkKFZ4hv8aTuWzxd0KtjaLEjlCNj8EULiXKeKY3NrJE5Ds5
         qcMbYUGG+zLGAZy/yBfnDieJhKG0gYakkEeJ12YpnQFetFLCJ8Le/Ef/u9em1KA7+IAS
         30/rYmt4JkILZ7uwdviOd3mRKxsiZoQdMP0GlH8uQVbOlt4oYjCsppUBMhmEw6ZbCpdU
         jXYA==
X-Gm-Message-State: AOJu0Yyrh1QFpngsQQE2Aep4lVX1RLaexzgCByWOjtM2/ih/oV+cv4CW
        PLczTD0YnaRQDc8Wf1V1qLHaCE0NbG0wU9ZB5++yiS8DGQ7wBH58QWiAatSvQbdOHIn7o/L7Uho
        8hBFa9mEi6su0xyaPG/04YCoqzSSo89h7TKHuRlzVrmlVP9Qj9pxIa5uCnw==
X-Received: by 2002:a9d:7f0e:0:b0:6d8:74e2:6372 with SMTP id j14-20020a9d7f0e000000b006d874e26372mr3825841otq.76.1701683266646;
        Mon, 04 Dec 2023 01:47:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgZV7GOcP10ElEBcdLXqU6APkmXlqtrKTI9+ZUsE1OOlySmmnZwzKu0ALesi4xbldlngNAXeDz6+sW1IKUSAA=
X-Received: by 2002:a9d:7f0e:0:b0:6d8:74e2:6372 with SMTP id
 j14-20020a9d7f0e000000b006d874e26372mr3825830otq.76.1701683266357; Mon, 04
 Dec 2023 01:47:46 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Dec 2023 01:47:45 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com> <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com>
Mime-Version: 1.0
Date:   Mon, 4 Dec 2023 01:47:45 -0800
Message-ID: <CAJM55Z-qc7gc0fO-K8byqvpOBjDxFD4dP57mFHuijvpOzBWObQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Fustini wrote:
> Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
> controller instance which is typically connected to the eMMC device.
> Add mmc1 node for the second mmc controller instance which is typically
> connected to microSD slot.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index ba4d2c673ac8..af4fdcd82e0b 100644
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
> @@ -304,6 +311,24 @@ dmac0: dma-controller@ffefc00000 {
>  			status = "disabled";
>  		};
>
> +		mmc0: mmc@ffe7080000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7080000 0x0 0x10000>;
> +			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@ffe7090000 {
> +			compatible = "thead,th1520-dwcmshc";
> +			reg = <0xff 0xe7090000 0x0 0x10000>;
> +			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +

Hi Drew,

This doesn't seem to match the documentation shared here:
https://lore.kernel.org/linux-riscv/5f437109d2be2b8843f549a661054a2e3ec0d66e.camel@xry111.site/
From the TH1520 System User Manual.pdf in there, I'd expect something like

	emmc: mmc@ffe7080000 {
		compatible = "thead,th1520-dwcmshc";
		reg = <0xff 0xe7080000 0x0 0x10000>;
		...
	};

	sdio0: mmc@ffe7090000 {
		compatible = "thead,th1520-dwcmshc";
		reg = <0xff 0xe7090000 0x0 0x10000>;
		...
	};

	sdio1: mmc@ffe70a0000 {
		compatible = "thead,th1520-dwcmshc";
		reg = <0xff 0xe70a0000 0x0 0x10000>;
		...
	};

/Emil
