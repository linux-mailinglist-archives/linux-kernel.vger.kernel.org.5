Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB5757258
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGRDcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGRDcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F4BB;
        Mon, 17 Jul 2023 20:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762D9613EF;
        Tue, 18 Jul 2023 03:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E10C433C8;
        Tue, 18 Jul 2023 03:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689651158;
        bh=qg8D1ZL0kE/FiqbU+ZMVO/lw10D0/2Fk43wDFmoWhPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7gILZ9Dir144HwOZs3ZGqOBK7TVAtarmcyXl4k06kAJUA88BwiGH78xp9ALqOk+w
         I+pfpBWdamebbV0aeabvBmMRw2DYk3maFiZbBqe9Z/OJOSne2WVDWz+K58dquhJevQ
         f/OUmprMOJ9JumDcRHz9kB9g2DTa17d+2hUfNCPomdiimeWgNHFBYfJpfIJsZDeEDO
         E07UfrGButKFnkp0IPsCcJEGsJyZw66iJsL50I3wu0q6iwMpe2lS27GbjpEhbtuO3H
         BIJysMxpQ65Z2BPOfwo5jHAOBjcknh5Ccfx5LX8Lj1j2ETDDHGbEsWUyDPjp3On/I7
         3Lp6WBmqV0aGw==
Date:   Tue, 18 Jul 2023 11:32:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haibo Chen <haibo.chen@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl
 setting for eMMC
Message-ID: <20230718033227.GE9559@dragon>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
 <20230625124238.4071717-10-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625124238.4071717-10-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:42:37PM +0800, Peng Fan (OSS) wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add 100MHz and 200MHz pinctrl setting for eMMC, and enable 8 bit bus mode
> to config the eMMC work at HS400ES mode.
> 
> Also update to use Standard Drive Strength for USDHC pad to get a better
> signal quality per Hardware team suggests.
> 
> Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index e459dc35e469..ab7af705bbca 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -121,9 +121,11 @@ &lpuart5 {
>  };
>  
>  &usdhc0 {
> -	pinctrl-names = "default", "sleep";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
>  	pinctrl-0 = <&pinctrl_usdhc0>;
>  	pinctrl-1 = <&pinctrl_usdhc0>;
> +	pinctrl-2 = <&pinctrl_usdhc0>;
> +	pinctrl-3 = <&pinctrl_usdhc0>;

All three speed modes use the same pinctrl?

Shawn

>  	non-removable;
>  	bus-width = <8>;
>  	status = "okay";
> @@ -202,17 +204,17 @@ MX8ULP_PAD_PTF15__LPUART5_RX	0x3
>  
>  	pinctrl_usdhc0: usdhc0grp {
>  		fsl,pins = <
> -			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
> -			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10042
> -			MX8ULP_PAD_PTD10__SDHC0_D0	0x43
> -			MX8ULP_PAD_PTD9__SDHC0_D1	0x43
> -			MX8ULP_PAD_PTD8__SDHC0_D2	0x43
> -			MX8ULP_PAD_PTD7__SDHC0_D3	0x43
> -			MX8ULP_PAD_PTD6__SDHC0_D4	0x43
> -			MX8ULP_PAD_PTD5__SDHC0_D5	0x43
> -			MX8ULP_PAD_PTD4__SDHC0_D6	0x43
> -			MX8ULP_PAD_PTD3__SDHC0_D7	0x43
> -			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10042
> +			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
> +			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10002
> +			MX8ULP_PAD_PTD10__SDHC0_D0	0x3
> +			MX8ULP_PAD_PTD9__SDHC0_D1	0x3
> +			MX8ULP_PAD_PTD8__SDHC0_D2	0x3
> +			MX8ULP_PAD_PTD7__SDHC0_D3	0x3
> +			MX8ULP_PAD_PTD6__SDHC0_D4	0x3
> +			MX8ULP_PAD_PTD5__SDHC0_D5	0x3
> +			MX8ULP_PAD_PTD4__SDHC0_D6	0x3
> +			MX8ULP_PAD_PTD3__SDHC0_D7	0x3
> +			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10002
>  		>;
>  	};
>  };
> -- 
> 2.37.1
> 
