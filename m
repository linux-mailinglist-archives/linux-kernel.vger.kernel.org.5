Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2277B40C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjHNIYi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjHNIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:24:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCAE6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:24:09 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qVSrT-0002pB-V6; Mon, 14 Aug 2023 10:23:40 +0200
Message-ID: <96c29015f86c84722c08a7ab2272f1355d6042ce.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 10:23:38 +0200
In-Reply-To: <20230813162906.22640-2-aford173@gmail.com>
References: <20230813162906.22640-1-aford173@gmail.com>
         <20230813162906.22640-2-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 13.08.2023 um 11:29 -0500 schrieb Adam Ford:
> A previous patch removed the audio PLL configuration from the clk
> node, which resulted in an incorrect clock rate when attempting
> to playback audio.  Fix this by setting the AUDIO_PLL2 rate inside
> the SAI3 node since it's the SAI3 that needs it.
> 
> Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index 06e91297fb16..acd265d8b58e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -381,9 +381,10 @@ &pcie_phy {
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> -	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
> +			  <&clk IMX8MP_AUDIO_PLL2> ;
>  	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
> -	assigned-clock-rates = <12288000>;
> +	assigned-clock-rates = <12288000>, <361267200>;
>  	fsl,sai-mclk-direction-output;
>  	status = "okay";
>  };

