Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903FE78F4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347637AbjHaVwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjHaVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:52:30 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5978B8;
        Thu, 31 Aug 2023 14:52:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 91B938659F;
        Thu, 31 Aug 2023 23:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693518744;
        bh=VX4ueldWGhNie2C6yLSDql4e0oCmV/PfqbMuG7MW9jg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I9pttGndcWPz52/igHC1f7L/vKr9I7RmxuKmktKFpv6NwzFEWQM7bkZ8P4AHJ5R8H
         9vEysRwWn1GAqm1L5rfhnOtK2/AOlkJkghF+gsq6uNjOzK2/gVfFwsICakOM/mBE/v
         XpiFdW53VfWgSGbxoYaCuwVAehxyfgHiFM6hc0Clylb0klDy9VyQiSUYgN7xAr3ud6
         eF4RBan9gCBz2DS7rpjRKDFSiZre3Nt3izBD9KpCtrhKomj9D/PeAp76ohT69ntB4r
         NwJtG2a4FxBw339d/hJQQlujUo7ysz4C9XuQpmMbok/XD56p0J81Y4ykEguP3FyWGA
         U/G8PeFjKrTng==
Message-ID: <99204fbf-3246-6124-2e35-bdc353d7e7b6@denx.de>
Date:   Thu, 31 Aug 2023 23:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 1/3] arm64: dts: imx8mp: Add easrc node
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
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230831044431.250338-1-aford173@gmail.com>
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
> The i.MX8MP has an asynchronous sample rate converter which seems
> to be the same as what is available on the i.MX8M Nano.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  No Change.  The dt-binding update was already accepted into the sound tree, so that patch
>       was dropped from the series
> 
> V2:  No Change.
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 83d907294fbc..3167706d81e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1459,6 +1459,26 @@ sai7: sai@30c80000 {
>   					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>   					status = "disabled";
>   				};
> +
> +				easrc: easrc@30c90000 {
> +					compatible = "fsl,imx8mp-easrc", "fsl,imx8mn-easrc";
> +					reg = <0x30c90000 0x10000>;
> +					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_ASRC_IPG>;
> +					clock-names = "mem";
> +					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +					dma-names = "ctx0_rx", "ctx0_tx",
> +						    "ctx1_rx", "ctx1_tx",
> +						    "ctx2_rx", "ctx2_tx",
> +						    "ctx3_rx", "ctx3_tx";
> +					firmware-name = "imx/easrc/easrc-imx8mn.bin";

Should the firmware name really be imx8mn or should it be imx8mp ?

I think the later is better, you can always add a symlink for the 
firmware name, and you can discern mx8mn/mp firmwares on the same rootfs 
in case that was ever needed in the future.
