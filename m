Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D27CB307
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJPSzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:54:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0090D95;
        Mon, 16 Oct 2023 11:54:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D51C433C7;
        Mon, 16 Oct 2023 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697482496;
        bh=vnpuG6oJGzk3oI7/3eK+xoXxYSfxQmaYjHfWNJ6kGbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9r2kdvshd6iY6IW+giqum/YnWI5uOQBJvCbnTe4xaBNsbUaDnathoKktNFsQH0vs
         V/ruciEdbvU9rBB4Fxv3qaW+K8DjR0+FtiZnfLhw7myfmjR6hCB7599DJLOv30PJwU
         uuMX6hEt3rFIQVwJoV+EwGdbyZULjExk8BIdKVxLicg/5dMx0jGaQZ3dLxRARFcOrw
         LNMcqo6bua3X2ehb9ik/lAFEhNj183ZhI78Y4L7ev51fJ4/e+hjeqo6+e4NUlPNdAD
         bpWFMyDgfOcIE3pZiR/5C674Pi9SfwgcSRR4NxCOc0CvpAhGGf+GTukZqun49ytDDc
         8RiRS8jKx5CdQ==
Date:   Mon, 16 Oct 2023 11:58:44 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add QUP1 SPI controller
Message-ID: <jxvpt2xo3fc2k7kflfsdov6uxpjpgqpomgmfvfgxwytejvkcgu@xwnfrg7be6qi>
References: <20231004191303.331055-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004191303.331055-1-robimarko@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:12:30PM +0200, Robert Marko wrote:
> Add the required BAM and QUP nodes for the QUP1 SPI controller on IPQ5018.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I padded the spi node to 8 digits, and applied the patch.

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 38ffdc3cbdcd..484034e65f4f 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -146,6 +146,16 @@ sdhc_1: mmc@7804000 {
>  			status = "disabled";
>  		};
>  
> +		blsp_dma: dma-controller@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x1d000>;
> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +
>  		blsp1_uart1: serial@78af000 {
>  			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>  			reg = <0x078af000 0x200>;
> @@ -156,6 +166,20 @@ blsp1_uart1: serial@78af000 {
>  			status = "disabled";
>  		};
>  
> +		blsp1_spi1: spi@78b5000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x78b5000 0x600>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
>  		intc: interrupt-controller@b000000 {
>  			compatible = "qcom,msm-qgic2";
>  			reg = <0x0b000000 0x1000>,  /* GICD */
> -- 
> 2.41.0
> 
