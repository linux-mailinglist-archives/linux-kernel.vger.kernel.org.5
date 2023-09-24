Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A327AC9E9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIXOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIXOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA1E3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:07:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFECC433C7;
        Sun, 24 Sep 2023 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695564468;
        bh=/IUo5QK74OVQlJE7Haqn2Qe9bdoH4g+5kcmCTqhaxCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGekk4D3BViPnTVaEGGSZemWtARscM8cP8iDYJaa5D3OzjXSyQf4AKcY11CNA8LAv
         DRcL2zJMJXR9E2G8StMtftxufNqSr1+gJjh9QPcPZXaLL59BBmKtcS98perqHVcyto
         rG1uHS66TWJD2CV6kZZOx7Rpv2HW8vErUAGzakFgs/4AkCJ0pxgUc5MDnNr5Mgsu+V
         gEIZlipU5qaqH7HxNwlAnAQsaGL1VDjfhh8bLKwvPYHYxgON6naAW80LRMkkdkIlkc
         A3/OZtRMQKDNG5NGkQOXI1YrvakY59i31VH1CNd0WbpgiDscHKgiTgJZe5dL+527qx
         6MNLT8juboHJg==
Date:   Sun, 24 Sep 2023 22:07:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com,
        marcel.ziswiler@toradex.com, Frank.Li@nxp.com,
        xiaoning.wang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
Message-ID: <20230924140734.GL7231@dragon>
References: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:47:15PM +0800, Richard Zhu wrote:
> Add missed PCIEA, SATA0 and SERDES0 power domains for HSIO SS.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

It doesn't apply to v6.6-rc.  Could you rebase?

Shawn

> ---
>  drivers/firmware/imx/scu-pd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> index 84b673427073..7b8c2689b49c 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -165,7 +165,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>  	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
>  
>  	/* HSIO SS */
> +	{ "pcie-a", IMX_SC_R_PCIE_A, 1, false, 0 },
>  	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
> +	{ "sata-0", IMX_SC_R_SATA_0, 1, false, 0 },
> +	{ "serdes-0", IMX_SC_R_SERDES_0, 1, false, 0 },
>  	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
>  	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
>  
> -- 
> 2.34.1
> 
