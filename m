Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46E7E465C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjKGQu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjKGQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:50:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1078F2695;
        Tue,  7 Nov 2023 07:59:52 -0800 (PST)
Received: from i53875a93.versanet.de ([83.135.90.147] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r0OUR-0005mz-Ot; Tue, 07 Nov 2023 16:59:43 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 3/6] ARM64: dts: rk3588: add crypto node
Date:   Tue, 07 Nov 2023 16:59:42 +0100
Message-ID: <10382065.T7Z3S40VBb@diego>
In-Reply-To: <20231107155532.3747113-4-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-4-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 7. November 2023, 16:55:29 CET schrieb Corentin Labbe:
> The rk3588 has a crypto IP handled by the rk3588 crypto driver so adds a
> node for it.

please follow other commits in the subject line, i.e.:

"arm64: dts: rockchip: add rk3588 crypto node"


Thanks
Heiko

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 7064c0e9179f..a2ba5ebec38d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1523,6 +1523,18 @@ sdhci: mmc@fe2e0000 {
>  		status = "disabled";
>  	};
>  
> +	crypto: crypto@fe370000 {
> +		compatible = "rockchip,rk3588-crypto";
> +		reg = <0x0 0xfe370000 0x0 0x2000>;
> +		interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&scmi_clk SCMI_CRYPTO_CORE>, <&scmi_clk SCMI_ACLK_SECURE_NS>,
> +			 <&scmi_clk SCMI_HCLK_SECURE_NS>;
> +		clock-names = "core", "aclk", "hclk";
> +		resets = <&scmi_reset SRST_CRYPTO_CORE>;
> +		reset-names = "core";
> +		status = "okay";
> +	};
> +
>  	i2s0_8ch: i2s@fe470000 {
>  		compatible = "rockchip,rk3588-i2s-tdm";
>  		reg = <0x0 0xfe470000 0x0 0x1000>;
> 




