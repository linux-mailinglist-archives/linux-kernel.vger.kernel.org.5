Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041177F9CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjK0JmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjK0JmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:42:01 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC4DE;
        Mon, 27 Nov 2023 01:42:05 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7Y7u-0008ND-Sp; Mon, 27 Nov 2023 10:42:02 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     lukasz.luba@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
Date:   Mon, 27 Nov 2023 10:42:02 +0100
Message-ID: <14787054.VsHLxoZxqI@diego>
In-Reply-To: <20231127081511.1911706-1-lukasz.luba@arm.com>
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Am Montag, 27. November 2023, 09:15:11 CET schrieb Lukasz Luba:
> Add dynamic-power-coefficient to the GPU node. That will create Energy
> Model for the GPU based on the coefficient and OPP table information.
> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
> In similar way the Energy Model for CPUs in rk3399 is created, so both
> are aligned in power scale. The maximum power used from this coefficient
> is 1.5W at 600MHz.

2640 is a pretty arbitary value, so it would be really helpful to describe
in the commit message, how you arrived with that specific value.


Thanks
Heiko


> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 9da0b6d77c8d..87cfdf570b19 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2113,6 +2113,7 @@ gpu: gpu@ff9a0000 {
>  		interrupt-names = "job", "mmu", "gpu";
>  		clocks = <&cru ACLK_GPU>;
>  		#cooling-cells = <2>;
> +		dynamic-power-coefficient = <2640>;
>  		power-domains = <&power RK3399_PD_GPU>;
>  		status = "disabled";
>  	};
> 




