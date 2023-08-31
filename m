Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482F78F4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbjHaVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjHaVxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:53:08 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA31B0;
        Thu, 31 Aug 2023 14:53:05 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 06A6286146;
        Thu, 31 Aug 2023 23:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693518783;
        bh=7zNiAYmjqejwICsTZJq3BxAP06RQWgh69LgCsjNl+Lc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uRx7kevIBzaKZHWDa6nk1U95Zv0YF9lq3NYfR21MkcUKxm9SGs2+9OEKa4mlsnSxx
         Uv1ZgDJ06E4T6qL/KtM8Xf8O7qTviC/0w52I85/NwvasIUO7zJianktiaqRr2ggJHU
         m4fRDcuG0dzJ9hE9uvAhNDjJvfEYFl8JZT8v0V1do1oQUAnQka3oa+YJAol5Vzafrw
         BHrEk7zGzyXUH/RKr6tJ2ygnMwvgu7jCbbWRZJaMNXR8AoXgN7sktahRo6moKCxV1B
         IMllStmHtrXxEmk5A07wpVHCv4ABWenJgVyfcEEwGzcwNw20eLXb+E56lMpqlFE4ln
         3OfBfQQu3enEQ==
Message-ID: <4d700304-3e10-a19b-d3f0-d0a1aec11580@denx.de>
Date:   Thu, 31 Aug 2023 23:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 2/3] arm64: dts: imx8mp: Add micfil node
Content-Language: en-US
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
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230831044431.250338-1-aford173@gmail.com>
 <20230831044431.250338-2-aford173@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230831044431.250338-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 06:44, Adam Ford wrote:
> The i.MX8MP has a micfil controller which is used for interfacing
> with a pulse density microphone. Add the node and mark it as
> disabled by default.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  The AUDIOMIX_PDM_ROOT doesn't exist and the real clock is
>       called IMX8MP_CLK_AUDIOMIX_PDM_SEL, so swap it out.
> 
> V2:  No change
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 3167706d81e1..341fd0369ce9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
>   					fsl,asrc-format = <2>;
>   					status = "disabled";
>   				};
> +
> +				micfil: audio-controller@30ca0000 {
> +					compatible = "fsl,imx8mp-micfil";
> +					reg = <0x30ca0000 0x10000>;
> +					#sound-dai-cells = <0>;
> +					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
> +						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_SEL>,
> +						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
> +						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
> +						 <&clk IMX8MP_CLK_EXT3>;
> +					clock-names = "ipg_clk", "ipg_clk_app",
> +						      "pll8k", "pll11k", "clkext3";
> +					dmas = <&sdma2 24 25 0x80000000>;
> +					dma-names = "rx";

Is dma-names really required if there is only a single DMA channel in DT ?
