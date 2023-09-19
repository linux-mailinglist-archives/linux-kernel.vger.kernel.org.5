Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743E7A62D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjISM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjISM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2989119;
        Tue, 19 Sep 2023 05:26:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF915C433C9;
        Tue, 19 Sep 2023 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126369;
        bh=OnEUCFS4cHitzCR7uggS8zW5KMJ/VY7vW2pRNgs+7/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qyft4lyhCZ4WkH52m3Qm5Bkbe4FtSGuSCsac20JrU7kx8jLTyzoVUIrVOuVkJdIDa
         cbUr+xEIFMSFuVr1MbvdHNi6JKyPPYy8bNDGhD5meCRgpdDhRVEg5d22dxg99TGT3j
         shllbp1BKquJ+s+ckpk6Z7y60fNu2gu3w1qiKNq5t/H5NGsvsw7yuxzVL6t4WL3tff
         BLGfQQgj3wc1xyHFh52T834bXfCjx2Yw4NUXonQO8h3rFSlgDWY2iDJDHWkyheYIB3
         Ixbgc46ehRzQDoK5v5nFq7UiT70JeQsCOYn+oLZokSBUg+ppyRLAFEVYGDWvliRyOK
         cjiV3w0xJ2B5A==
Date:   Tue, 19 Sep 2023 14:26:03 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx jpeg
 encoder/decoder
Message-ID: <20230919122602.GC11740@T480>
References: <20230601023801.25229-1-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601023801.25229-1-ming.qian@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:38:01AM +0800, Ming Qian wrote:
> assign a single slot,
> configure interrupt and power domain only for 1 slot,
> not for the all 4 slots.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> index a90654155a88..176dcce24b64 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> @@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
>  
>  	jpegdec: jpegdec@58400000 {
>  		reg = <0x58400000 0x00050000>;
> -		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
>  			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>  		clock-names = "per", "ipg";
> @@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
>  				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>  		assigned-clock-rates = <200000000>, <200000000>;
>  		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S0>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S1>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S2>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S3>;
> +				<&pd IMX_SC_R_MJPEG_DEC_S0>;
> +		slot = <0>;

I do not find this 'slot' property in bindings doc.

Shawn

>  	};
>  
>  	jpegenc: jpegenc@58450000 {
>  		reg = <0x58450000 0x00050000>;
> -		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
>  			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>  		clock-names = "per", "ipg";
> @@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
>  				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>  		assigned-clock-rates = <200000000>, <200000000>;
>  		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S0>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S1>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S2>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S3>;
> +				<&pd IMX_SC_R_MJPEG_ENC_S0>;
> +		slot = <0>;
>  	};
>  
>  	img_jpeg_dec_lpcg: clock-controller@585d0000 {
> -- 
> 2.38.1
> 
