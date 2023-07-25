Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519887618DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjGYMvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGYMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:51:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC36D199E;
        Tue, 25 Jul 2023 05:51:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 498BB5AA;
        Tue, 25 Jul 2023 14:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690289434;
        bh=r0N4IALNWIyLeFT+l0HDv1sxuCq1JEIO1fU2R4IY1Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j74uKgC9TXvn6YawIorXbfopQMeFcAD3dY+rZXoP0LtfDas7ec2sDScH9NQbay9l/
         nWz5EChvRrKtfrVzWzNEdiJnwbPZTVzk3e7CxTGBdH8kX27aPMp2T/3lPjQ3mRHAUe
         rgF/DTXqroJHUQA9dxSzLORtxY2omlKCF6qXKdCQ=
Date:   Tue, 25 Jul 2023 15:51:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dan.scally@ideasonboard.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] arm64: dts: imx8mp-debix: remove unused fec
 pinctrl node
Message-ID: <20230725125140.GC21640@pendragon.ideasonboard.com>
References: <20230717165127.2882535-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717165127.2882535-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thank you for the patch.

On Mon, Jul 17, 2023 at 06:51:24PM +0200, Marco Felsch wrote:
> The SoM A make use of the EQOS ethernet interface and not the FEC, so
> drop the FEC pinctrl node from the devicetree.
> 
> Fixes: c86d350aae68 ("arm64: dts: Add device tree for the Debix Model A Board")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

I think the I/O board uses the FEC for its ethernet interface. It would
be nice to eventually move this to an I/O board overlay, but for now,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changelog:
> 
> v2:
> - new patch
> 
>  .../dts/freescale/imx8mp-debix-model-a.dts    | 22 -------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> index b4409349eb3f6..1004ab0abb131 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> @@ -355,28 +355,6 @@ MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18				0x19
>  		>;
>  	};
>  
> -	pinctrl_fec: fecgrp {
> -		fsl,pins = <
> -			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC				0x3
> -			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO				0x3
> -			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0				0x91
> -			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1				0x91
> -			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2				0x91
> -			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3				0x91
> -			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC				0x91
> -			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL			0x91
> -			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0				0x1f
> -			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1				0x1f
> -			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2				0x1f
> -			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3				0x1f
> -			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL			0x1f
> -			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC				0x1f
> -			MX8MP_IOMUXC_SAI1_RXD1__ENET1_1588_EVENT1_OUT			0x1f
> -			MX8MP_IOMUXC_SAI1_RXD0__ENET1_1588_EVENT1_IN			0x1f
> -			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19				0x19
> -		>;
> -	};
> -
>  	pinctrl_gpio_led: gpioledgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19

-- 
Regards,

Laurent Pinchart
