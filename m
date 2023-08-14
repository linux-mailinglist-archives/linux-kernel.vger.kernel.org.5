Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8977C148
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjHNTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjHNTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:24:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C47BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:24:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bad7499bdcso31060811fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692041083; x=1692645883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TYI8hfD5ubiFIaUUw5xZ9NbDnXIfF/xMmKHoxdgOqM=;
        b=dTjF3oO+tR+a38Tv9Uj2P9O9Vzj6RvIU56UmLeO4FhiwwnPv6HEKeefSK0FR617tcz
         fahtqXTJmrceRRGvNKIqzMuIwUaTecB4klDfyt/DkLlo7XMVvgyl+7rdRzNMYol58shJ
         zSJix8GUpJ6pjMXqollUMbwrnM9VrDZ1NYk/TLK1k/ko2ZSBqybiyX0l4X4cfq2QKLjZ
         kBa7Q3tyPZn9mtloITFsyqFqGhQl8Q4oB9gFbUGLSWKeBE5c4diKrncr7DcbLbaH3llm
         3qdu91V/jklWsVtOY97DHHH/wcPGLAaKlQS5EdPjDHp9ya13oApOdoqZgzMg+RZM/KBg
         LB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041083; x=1692645883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TYI8hfD5ubiFIaUUw5xZ9NbDnXIfF/xMmKHoxdgOqM=;
        b=AQ5qoWwcjY8kckdAw2K3H6TME0pnE4t7Zlm4SEi/zMiFSreiozdeyZ+ziBxCte+tSQ
         +lzGqdhnqJoL1k8Rh2qVwdPHiXxM4edYhDAPmxEcFJ4ghbzzRvDUYlJMMkj4PVcc0OpT
         iq+YA3NhvcmWNg0+TqzyTSjXcauBuqSbuNDebyjhnnu7otGRXH7JgJfpyGrebW4Eu8oj
         QvFTu9gOToJxkVC7vbV52YSg4BAMJV5eAXaE45lKSP23IhX3WTpgZ4TdE/rEOUCXhRED
         hT5J581iTLT7wIBYXNnou1wAvSNm46xXMEE6xICTkkCdCOSjwia+K/7OgG85cI/y90zI
         R22A==
X-Gm-Message-State: AOJu0Yz8SgVeKg4RVDH5D15PG3zBqJxb90lGLqp3l6gKrk/LvIKNY456
        A7Vv1fVtbGhcw9SMv9aI/y1pig==
X-Google-Smtp-Source: AGHT+IHIgsSbN/5vj4ushWzyT6lAMD2obNUe0xO1a1DU9GYJNJLH0vESwVygEgU/xiwHcAEqaUzzbg==
X-Received: by 2002:a2e:9045:0:b0:2bb:3f89:ea50 with SMTP id n5-20020a2e9045000000b002bb3f89ea50mr4368944ljg.24.1692041082687;
        Mon, 14 Aug 2023 12:24:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id md15-20020a170906ae8f00b0098d486d2bdfsm6077811ejb.177.2023.08.14.12.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:24:42 -0700 (PDT)
Message-ID: <3b88bbd0-81f2-a178-1e9f-1b950aad3da7@linaro.org>
Date:   Mon, 14 Aug 2023 21:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, afd@ti.com
References: <20230811184432.732215-1-vigneshr@ti.com>
 <20230811184432.732215-3-vigneshr@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230811184432.732215-3-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 20:44, Vignesh Raghavendra wrote:
> From: Bryan Brattlof <bb@ti.com>
> 
> The AM62Px is an extension of the existing Sitara AM62x low-cost family
> of application processors built for Automotive and Linux Application
> development. Scalable Arm Cortex-A53 performance and embedded features,
> such as: multi high-definition display support, 3D-graphics
> acceleration, 4K video acceleration, and extensive peripherals make the
> AM62Px well-suited for a broad range of automation and industrial
> application, including automotive digital instrumentation, automotive
> displays, industrial HMI, and more.
> 
> Some highlights of AM62P SoC are:
> * Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
>   Dual/Single core variants are provided in the same package to allow HW
>   compatible designs.
> * One Device manager Cortext-R5F for system power and resource
>   management, and one Cortex-R5F for Functional Safety or
>   general-purpose usage.
> * One 3D GPU up to 50 GLFOPS
> * H.264/H.265 Video Encode/Decode.
> * Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
>   2x OLDI-SL), DSI, or DPI. Up to 3840x1080@60fps resolution
> * Integrated Giga-bit Ethernet switch supporting up to a total of two
>   external ports (TSN capable).
> * 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
>   NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
>   1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
> * Dedicated Centralized Hardware Security Module with support for secure
>   boot, debug security and crypto acceleration and trusted execution
>   environment.
> * One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
> * Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
>   enabling battery powered system design.
> 
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here:
> 
>     https://www.ti.com/lit/pdf/spruj83
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 136 ++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    |  15 +++
>  arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi |  32 +++++
>  arch/arm64/boot/dts/ti/k3-am62p.dtsi        | 122 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi       | 107 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h         |   3 +
>  6 files changed, 415 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> new file mode 100644
> index 000000000000..c24ff905437f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for the AM62P main domain peripherals
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&cbass_main {
> +	oc_sram: sram@70000000 {
> +		compatible = "mmio-sram";
> +		reg = <0x00 0x70000000 0x00 0x10000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x00 0x70000000 0x10000>;
> +	};
> +
> +	gic500: interrupt-controller@1800000 {
> +		compatible = "arm,gic-v3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
> +		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
> +		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
> +		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
> +		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
> +		/*
> +		 * vcpumntirq:
> +		 * virtual CPU interface maintenance interrupt
> +		 */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		gic_its: msi-controller@1820000 {
> +			compatible = "arm,gic-v3-its";
> +			reg = <0x00 0x01820000 0x00 0x10000>;
> +			socionext,synquacer-pre-its = <0x1000000 0x400000>;
> +			msi-controller;
> +			#msi-cells = <1>;
> +		};
> +	};
> +
> +	dmss: bus@48000000 {
> +		bootph-all;
> +		compatible = "simple-mfd";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
> +
> +		ti,sci-dev-id = <25>;

My v1 concerns are still valid.

> +
> +		secure_proxy_main: mailbox@4d000000 {
> +			bootph-all;
> +			compatible = "ti,am654-secure-proxy";
> +			#mbox-cells = <1>;
> +			reg-names = "target_data", "rt", "scfg";
> +			reg = <0x00 0x4d000000 0x00 0x80000>,
> +			      <0x00 0x4a600000 0x00 0x80000>,
> +			      <0x00 0x4a400000 0x00 0x80000>;
> +			interrupt-names = "rx_012";
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};


Best regards,
Krzysztof

