Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2317675724F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGRDaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjGRDaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9CE1707;
        Mon, 17 Jul 2023 20:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 498B36125A;
        Tue, 18 Jul 2023 03:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E75C433CA;
        Tue, 18 Jul 2023 03:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689650985;
        bh=3Sqm4UsEUrMMLjMTfUg/mnuKacyQjOkPpH5Zzh5JPYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjQYehnZEkPbSmXprQ38F76j3vceLsXn9BNQWIE2HkLsIfsEx5SdgCW9lVU5m3icP
         rrQywc8/lgaqhxeBsdJTDRfFSkENo7LH+0M+YM1Lu11t/BqqDsQFF2d1KaRKhmJI/n
         g9SdsjibJOidXzs4rzKEi3wQS35IMbsV0sab4dthYgBKAMIVoQYQl2CYK9IUrBnr2Y
         CL0/gp5NlHFI/+WIen5J6YMhLkOD9mCUF1JE8lo0uW8R8lMxtCKMsvr6ximSlNzg+Y
         6EKp1FysL4hioDgx/99Tkorea9wbEtq5aEH3RfDp/fV57KqhBK9W6wF0GFeN2DZ2nT
         crKmxrY51gVyA==
Date:   Tue, 18 Jul 2023 11:29:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 08/10] arm64: dts: imx8ulp-evk: add spi-nor device support
Message-ID: <20230718032934.GC9559@dragon>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
 <20230625124238.4071717-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625124238.4071717-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:42:36PM +0800, Peng Fan (OSS) wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add spi-nor support.
> - 8 bit mode for RX/TX.
> - Set the clock rate to 200MHz.
> - add default/sleep pinctrl.
> 
> Co-developed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index d66e31cf83fe..e459dc35e469 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -95,6 +95,23 @@ &cm33 {
>  	status = "okay";
>  };
>  
> +&flexspi2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
> +	pinctrl-1 = <&pinctrl_flexspi2_ptd>;
> +	status = "okay";
> +
> +	mx25uw51345gxdi00: flash@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";

We usually start the property list with 'compatible'.

Shawn

> +		spi-max-frequency = <200000000>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;


> +	};
> +};
> +
>  &lpuart5 {
>  	/* console */
>  	pinctrl-names = "default", "sleep";
> @@ -159,6 +176,23 @@ MX8ULP_PAD_PTF10__ENET0_1588_CLKIN 0x43
>  		>;
>  	};
>  
> +	pinctrl_flexspi2_ptd: flexspi2ptdgrp {
> +		fsl,pins = <
> +
> +			MX8ULP_PAD_PTD12__FLEXSPI2_A_SS0_B	0x42
> +			MX8ULP_PAD_PTD13__FLEXSPI2_A_SCLK	0x42
> +			MX8ULP_PAD_PTD14__FLEXSPI2_A_DATA3	0x42
> +			MX8ULP_PAD_PTD15__FLEXSPI2_A_DATA2	0x42
> +			MX8ULP_PAD_PTD16__FLEXSPI2_A_DATA1	0x42
> +			MX8ULP_PAD_PTD17__FLEXSPI2_A_DATA0	0x42
> +			MX8ULP_PAD_PTD18__FLEXSPI2_A_DQS	0x42
> +			MX8ULP_PAD_PTD19__FLEXSPI2_A_DATA7	0x42
> +			MX8ULP_PAD_PTD20__FLEXSPI2_A_DATA6	0x42
> +			MX8ULP_PAD_PTD21__FLEXSPI2_A_DATA5	0x42
> +			MX8ULP_PAD_PTD22__FLEXSPI2_A_DATA4	0x42
> +		>;
> +	};
> +
>  	pinctrl_lpuart5: lpuart5grp {
>  		fsl,pins = <
>  			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
> -- 
> 2.37.1
> 
