Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB97F97A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjK0CwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjK0CwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:52:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCCE111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:52:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF929C433C7;
        Mon, 27 Nov 2023 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053544;
        bh=3Pa6bcxnUYbjzkwY5l+rItczdYmOvJ+sRLmKggT80qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agjfGCz8JRXXIXesBromGaIESY2hzaaPocdR8C9+YKJqw/Ciojpkb+wG2c9bFzBlW
         92clO3WsTdHdP+7V/2MtXNloz6ex/L2m9KLJ5Yl7kHRF6aCMTancW+Easgr1qcxwpL
         bhBCxsWqt/2K1+ybpQLbYjeHGm14ZOyQMPSHt3UEGfCD550SUWnd0bnPQoChzdTIKa
         2sZQC2Gt3iFGfMXqCgLNvY1MOTYuPCidyrZ1m9wgJuSGk+4oqrjZ4j5KkxzJW9Jgem
         29clHg/UM+0mAi2r5ZyERTia9WQ0fVcy26924JfEKE2yO1ViNywRuRZEhx8kEPGwDj
         R42iV4f/2tZuA==
Date:   Mon, 27 Nov 2023 10:52:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: imx6q-apalis: add can power-up delay on
 ixora board
Message-ID: <20231127025218.GR87953@dragon>
References: <20231020153022.57858-1-andrejs.cainikovs@gmail.com>
 <20231020153022.57858-3-andrejs.cainikovs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020153022.57858-3-andrejs.cainikovs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:30:22PM +0200, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Newer variants of Ixora boards require a power-up delay when powering up
> the CAN transceiver of up to 1ms.
> 
> Cc: stable@vger.kernel.org

Why is only the iMX6 change required for stable?

Shawn

> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> index 717decda0ceb..3ac7a4501620 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts
> @@ -76,6 +76,7 @@ reg_can1_supply: regulator-can1-supply {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_enable_can1_power>;
>  		regulator-name = "can1_supply";
> +		startup-delay-us = <1000>;
>  	};
>  
>  	reg_can2_supply: regulator-can2-supply {
> @@ -85,6 +86,7 @@ reg_can2_supply: regulator-can2-supply {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_enable_can2_power>;
>  		regulator-name = "can2_supply";
> +		startup-delay-us = <1000>;
>  	};
>  };
>  
> -- 
> 2.34.1
> 
