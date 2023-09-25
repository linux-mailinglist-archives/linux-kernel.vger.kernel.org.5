Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817217ACD19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIYAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:30:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A15CF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:30:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E447C433C7;
        Mon, 25 Sep 2023 00:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695601800;
        bh=bChhotaAUBhB0O2eKgHOOJkaqSlCFPcPt2ZxA4qg+tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+JdsvcNckN40SXxAULRNaA0AJCYPRQ0AVHRbVZ+umjjAQdB3tGJQ6vRuZHE7CE4m
         jcFKyIqTJus7dQy+VNZnKDqbpcUt57jgeV9Gfre4BvXON5P3hK1A4C8VQBD5he5wyC
         OsmPMT7Rj3pD0u5m7ctHUVI9FfakaetKvM0p2p+I8irlJE+kvSOhY6xcU9LQ6sVQD7
         IcosE7cLhF3umJXR6W34px/5ek1AFod6Md2xyMpR1+ARP5/rLB6fZfquvGp/VZfeDQ
         3k0g/RkQzhdtkgQr7K1qtYEqWQ0wCIbiSQ1D0zdJrYbCFyq1qAXaSGXTQ/ArV8+doK
         a37kmxwv0v1Fw==
Date:   Mon, 25 Sep 2023 08:29:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     joy.zou@nxp.com, shenwei.wang@nxp.com, sherry.sun@nxp.com,
        clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 2/5] arm64: dts: imx8: add edma[0..3]
Message-ID: <20230925002946.GU7231@dragon>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
 <20230822155333.2261262-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822155333.2261262-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:53:30AM -0400, Frank Li wrote:
> edma<n> is missed, add them
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 88 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 62 +++++++++++++
>  .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 30 +++++++
>  3 files changed, 180 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> index 6c8d75ef9250..8870acf8f743 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -20,6 +20,63 @@ audio_ipg_clk: clock-audio-ipg {
>  		clock-output-names = "audio_ipg_clk";
>  	};
>  
> +	edma0: dma-controller@591F0000 {

Lowercase for hex value.

> +		compatible = "fsl,imx8qm-edma";
> +		reg =   <0x591f0000 0x190000>;

One space after =

> +		#dma-cells = <3>;
> +		shared-interrupt;
> +		dma-channels = <24>;
> +		dma-channel-mask = <0x5c0c00>;
> +		interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>, /* 0 asrc 0 */
> +			     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>, /* 1 */
> +			     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>, /* 2 */
> +			     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>, /* 3 */
> +			     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>, /* 4 */
> +			     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>, /* 5 */
> +			     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* 6 esai0 */
> +			     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* 7 */
> +			     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* 8 spdif0 */
> +			     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>, /* 9 */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 10 unused */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 11 unused */
> +			     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* 12 sai0 */
> +			     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* 13 */
> +			     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* 14 sai1 */
> +			     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* 15 */
> +			     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* 16 sai2 */
> +			     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* 17 sai3 */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 18 unused */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 19 unused */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 20 unused */
> +			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>, /* 21 */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 22 unused */
> +			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>; /* 23 unused */
> +		power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
> +				<&pd IMX_SC_R_DMA_0_CH1>,
> +				<&pd IMX_SC_R_DMA_0_CH2>,
> +				<&pd IMX_SC_R_DMA_0_CH3>,
> +				<&pd IMX_SC_R_DMA_0_CH4>,
> +				<&pd IMX_SC_R_DMA_0_CH5>,
> +				<&pd IMX_SC_R_DMA_0_CH6>,
> +				<&pd IMX_SC_R_DMA_0_CH7>,
> +				<&pd IMX_SC_R_DMA_0_CH8>,
> +				<&pd IMX_SC_R_DMA_0_CH9>,
> +				<&pd IMX_SC_R_DMA_0_CH10>,
> +				<&pd IMX_SC_R_DMA_0_CH11>,
> +				<&pd IMX_SC_R_DMA_0_CH12>,
> +				<&pd IMX_SC_R_DMA_0_CH13>,
> +				<&pd IMX_SC_R_DMA_0_CH14>,
> +				<&pd IMX_SC_R_DMA_0_CH15>,
> +				<&pd IMX_SC_R_DMA_0_CH16>,
> +				<&pd IMX_SC_R_DMA_0_CH17>,
> +				<&pd IMX_SC_R_DMA_0_CH18>,
> +				<&pd IMX_SC_R_DMA_0_CH19>,
> +				<&pd IMX_SC_R_DMA_0_CH20>,
> +				<&pd IMX_SC_R_DMA_0_CH21>,
> +				<&pd IMX_SC_R_DMA_0_CH22>,
> +				<&pd IMX_SC_R_DMA_0_CH23>;
> +	};
> +
>  	dsp_lpcg: clock-controller@59580000 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x59580000 0x10000>;
> @@ -65,4 +122,35 @@ dsp: dsp@596e8000 {
>  		memory-region = <&dsp_reserved>;
>  		status = "disabled";
>  	};
> +
> +	edma1: dma-controller@599f0000 {
> +		compatible = "fsl,imx8qm-edma";
> +		reg =   <0x599f0000 0xc0000>;

Ditto

Shawn

> +		#dma-cells = <3>;
> +		shared-interrupt;
> +		dma-channels = <11>;
> +		dma-channel-mask = <0xc0>;
> +		interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* 0 asrc 1 */
> +			     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>, /* 1 */
> +			     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>, /* 2 */
> +			     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>, /* 3 */
> +			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>, /* 4 */
> +			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>, /* 5 */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 6 unused */
> +			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 7 unused */
> +			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
> +			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
> +		power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
> +				<&pd IMX_SC_R_DMA_1_CH1>,
> +				<&pd IMX_SC_R_DMA_1_CH2>,
> +				<&pd IMX_SC_R_DMA_1_CH3>,
> +				<&pd IMX_SC_R_DMA_1_CH4>,
> +				<&pd IMX_SC_R_DMA_1_CH5>,
> +				<&pd IMX_SC_R_DMA_1_CH6>,
> +				<&pd IMX_SC_R_DMA_1_CH7>,
> +				<&pd IMX_SC_R_DMA_1_CH8>,
> +				<&pd IMX_SC_R_DMA_1_CH9>,
> +				<&pd IMX_SC_R_DMA_1_CH10>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index adb98a72bdfd..76e4aaaf307f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -132,6 +132,68 @@ lpuart3: serial@5a090000 {
>  		status = "disabled";
>  	};
>  
> +	edma2: dma-controller@5a1f0000 {
> +		compatible = "fsl,imx8qm-edma";
> +		reg = <0x5a1f0000 0x170000>;
> +		#dma-cells = <3>;
> +		dma-channels = <16>;
> +		interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
> +				<&pd IMX_SC_R_DMA_2_CH1>,
> +				<&pd IMX_SC_R_DMA_2_CH2>,
> +				<&pd IMX_SC_R_DMA_2_CH3>,
> +				<&pd IMX_SC_R_DMA_2_CH4>,
> +				<&pd IMX_SC_R_DMA_2_CH5>,
> +				<&pd IMX_SC_R_DMA_2_CH6>,
> +				<&pd IMX_SC_R_DMA_2_CH7>,
> +				<&pd IMX_SC_R_DMA_2_CH8>,
> +				<&pd IMX_SC_R_DMA_2_CH9>,
> +				<&pd IMX_SC_R_DMA_2_CH10>,
> +				<&pd IMX_SC_R_DMA_2_CH11>,
> +				<&pd IMX_SC_R_DMA_2_CH12>,
> +				<&pd IMX_SC_R_DMA_2_CH13>,
> +				<&pd IMX_SC_R_DMA_2_CH14>,
> +				<&pd IMX_SC_R_DMA_2_CH15>;
> +	};
> +
> +	edma3: dma-controller@5a9f0000 {
> +		compatible = "fsl,imx8qm-edma";
> +		reg = <0x5a9f0000 0x90000>;
> +		#dma-cells = <3>;
> +		dma-channels = <8>;
> +		interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
> +				<&pd IMX_SC_R_DMA_3_CH1>,
> +				<&pd IMX_SC_R_DMA_3_CH2>,
> +				<&pd IMX_SC_R_DMA_3_CH3>,
> +				<&pd IMX_SC_R_DMA_3_CH4>,
> +				<&pd IMX_SC_R_DMA_3_CH5>,
> +				<&pd IMX_SC_R_DMA_3_CH6>,
> +				<&pd IMX_SC_R_DMA_3_CH7>;
> +	};
> +
>  	spi0_lpcg: clock-controller@5a400000 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x5a400000 0x10000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> index 6881330ab4c6..7e98c5e5624b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> @@ -15,6 +15,36 @@ &adc0 {
>  	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>  };
>  
> +&edma2 {
> +	interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&edma3 {
> +	interrupts = <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &i2c0 {
>  	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>  	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.34.1
> 
