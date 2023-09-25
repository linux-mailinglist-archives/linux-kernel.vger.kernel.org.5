Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18AC7ACD17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjIYA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:27:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A3C4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82AC433C7;
        Mon, 25 Sep 2023 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695601665;
        bh=NBt2mW76tq3+pMFhISh9urmBg211Dnu8Kt16sM9vw2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBCWtmSLwb95mM3Dd37ZjCj5mtV7uGBMmGJzsZeUREDZZZEM622ltccwc/+mKj6+5
         CsSasCdcRyDfd1WK1zM8NpJuJ6thJr8aDC0/GvXd1/cntdyP7gdLDRPk1ls82Rj9aw
         bhZnVsgKSxl60t4fPpyPKXhLVf9UYan84KQjuhP4ySfjvcS2CQnsCaKIByb+CaHXTh
         MVNa7/37h8DIhCOitgXCiFUJGVE4nPdcw5DgEqgvfggBmA5X6iEfaBHnCnV3TkHlnv
         CnrFAfL99Ki8ebyzC7EzChL3acm1IE68fQui+sREBVPT3mM0Tixl3/S8xAmPlxtm6V
         8qkRtUptIN0+g==
Date:   Mon, 25 Sep 2023 08:27:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     joy.zou@nxp.com, shenwei.wang@nxp.com, sherry.sun@nxp.com,
        clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 1/5] firmware: imx: scu-pd: added missing edma channel
 power domain
Message-ID: <20230925002732.GT7231@dragon>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
 <20230822155333.2261262-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822155333.2261262-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:53:29AM -0400, Frank Li wrote:
> There are more power resources for dma channel at 8qxp and 8qm.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Could you rebase on v6.6-rc1?

Shawn

> ---
>  drivers/firmware/imx/scu-pd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> index 84b673427073..7d80eabd7941 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -121,9 +121,11 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>  	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
>  	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
>  	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
> -	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
> +	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
>  	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
> -	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
> +	{ "dma2-ch-0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
> +	{ "dma2-ch-1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
> +	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
>  	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
>  	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
>  	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
> -- 
> 2.34.1
> 
