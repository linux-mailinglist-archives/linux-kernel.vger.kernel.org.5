Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781F8124E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjLNCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:00:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA385
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:01:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCE5C433C7;
        Thu, 14 Dec 2023 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702519259;
        bh=mJwp9Wt+3zEWxjwj3NDYHejaJVXV/U4TQs6qHUx4VHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bbv6SkU2FR2YvI6T24wzRg992B38pmh7L41ohUxSe6RXDkhpste+v8Cob4JbuN9jg
         jdCG3utQeZLu1nGgTVPcR46Fxy1m3aW8mf6NvCUF2aRpy8ZIIFBpjx6QNfLFnJeN8D
         JgfjFC7NCZakROeSipOhMOb2H0Azjj2lUOIUu5B76WL6a5JSi0OFFfrsZr3ri9WpJx
         dBV1AABeAZJyUo4doOWyNjhrNDLeyQmhcrCmP5+wm6Yau9G8w/2QEmzAIcmaBkDdaG
         1y6bJmfr1VNUT4EWbUeK1ZMsDAOUSuQwwilHV3F+YtkoVTAwkigMSlLpVxjK61lmrT
         8YzXqiz+Cu9Vw==
Date:   Thu, 14 Dec 2023 10:00:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qm: Fix edma3 power-domains and
 interrupt number
Message-ID: <20231214020053.GQ270430@dragon>
References: <20231206201256.1113800-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206201256.1113800-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:12:55PM -0500, Frank Li wrote:
> Fixed a kernel dump when access edma3 registers.
> 
> [    1.517547] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
> [    1.517556] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
> [    1.517564] Hardware name: Freescale i.MX8QM MEK (DT)
> [    1.517570] Workqueue: events_unbound deferred_probe_work_func
> [    1.517593] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.517601] pc : vsnprintf+0x60/0x770
> [    1.517612] lr : snprintf+0x58/0x80
> [    1.517619] sp : ffff800082f0b9e0
> [    1.517622] x29: ffff800082f0b9e0 x28: ffff8000819a8af8 x27: ffff000801f90080
> [    1.517632] x26: ffff000801f90510 x25: 0000000000000001 x24: 0000000000000020
> [    1.517640] x23: 00000000ffffffd8 x22: ffff000800114800 x21: ffff800082f0baf0
> [    1.517650] x20: ffff000801f90698 x19: ffff000801f906b8 x18: ffffffffffffffff
> [    1.517659] x17: 6e6f632d616d642e x16: 3030303066396135 x15: ffff800102f0b687
> [    1.517668] x14: 0000000000000000 x13: 30206e6168632065 x12: 74697277203a7265
> [    1.517677] x11: 6c6c6f72746e6f63 x10: 2d616d642e303030 x9 : 72656c6c6f72746e
> [    1.517686] x8 : ffff000800396740 x7 : 205d333337383035 x6 : ffff800082f0baf0
> [    1.517694] x5 : 00000000ffffffd8 x4 : ffff000800396740 x3 : ffff800082f0ba70
> [    1.517703] x2 : ffff8000819a8af8 x1 : ffff800082f0baf0 x0 : 0000000000000025
> [    1.517713] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    1.517718] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.7.0-rc3-next-20231129-dirty #3
> [    1.517724] Hardware name: Freescale i.MX8QM MEK (DT)
> [    1.517727] Workqueue: events_unbound deferred_probe_work_func
> [    1.517736] Call trace:
> [    1.517739]  dump_backtrace+0x90/0xe8
> [    1.517752]  show_stack+0x18/0x24
> [    1.517761]  dump_stack_lvl+0x48/0x60
> [    1.517771]  dump_stack+0x18/0x24
> [    1.517780]  panic+0x36c/0x3ac
> [    1.517789]  nmi_panic+0x48/0x94
> [    1.517796]  arm64_serror_panic+0x6c/0x78
> [    1.517801]  do_serror+0x3c/0x78
> [    1.517806]  el1h_64_error_handler+0x30/0x48
> [    1.517813]  el1h_64_error+0x64/0x68
> [    1.517819]  vsnprintf+0x60/0x770
> [    1.517827]  snprintf+0x58/0x80
> [    1.517834]  fsl_edma_probe+0x2ac/0x830
> 
> It is eDMA1 at QM, which have the same register with eDMA3 at qxp.
> 
> Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Hi Frank,

Did you see the fix [1] from Xiaolei?  It has landed on Linus' tree.

Shawn

[1] https://lore.kernel.org/all/20231110072531.1957891-1-xiaolei.wang@windriver.com/

> ---
>  .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> index 01539df335f8c..5d76b4dee4cef 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
> @@ -44,6 +44,33 @@ can2_lpcg: clock-controller@5acf0000 {
>  	};
>  };
>  
> +/* It is eDMA1 in 8QM RM, but 8QXP it is eDMA3 */
> +&edma3 {
> +	reg = <0x5a9f0000 0x210000>;
> +	dma-channels = <10>;
> +	interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
> +	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
> +			<&pd IMX_SC_R_DMA_1_CH1>,
> +			<&pd IMX_SC_R_DMA_1_CH2>,
> +			<&pd IMX_SC_R_DMA_1_CH3>,
> +			<&pd IMX_SC_R_DMA_1_CH4>,
> +			<&pd IMX_SC_R_DMA_1_CH5>,
> +			<&pd IMX_SC_R_DMA_1_CH6>,
> +			<&pd IMX_SC_R_DMA_1_CH7>,
> +			<&pd IMX_SC_R_DMA_1_CH8>,
> +			<&pd IMX_SC_R_DMA_1_CH9>;
> +};
> +
> +/* It is edma0 in 8QM RM, but it is eDMA2 at 8QXP */
>  &edma2 {
>  	reg = <0x5a1f0000 0x170000>;
>  	#dma-cells = <3>;
> -- 
> 2.34.1
> 
