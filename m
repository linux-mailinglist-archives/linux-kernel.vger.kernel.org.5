Return-Path: <linux-kernel+bounces-132055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F1898F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9401F238DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF3134426;
	Thu,  4 Apr 2024 19:43:24 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44212D76B;
	Thu,  4 Apr 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259804; cv=none; b=g1ER/mNZniydwsUsNlos6zNNz1zaNApQGBCaRXDZAYkam2XrDkSBqFr5FzOSNRfO5I9ov+rHcNWHuejpG4uh15CEXj+Y4syVWxGhhgl9GhLczzI6Lz2kUxAOzeVFz6ezvqtK8hZfNKrKRpisFW0JfoM0xLVpwcgTD0Wo/5jZYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259804; c=relaxed/simple;
	bh=zUDgi6iudoTJasQRtCJQcwLNiKQJmhurWg2xbJqb//k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUs52ogJC4Ndgop8m0VZPMqjJaMhGBJ1WywD+FBqBG2NkANNCYl9JPt7JA9ea4+5ibuyIEbcbuN1v9+4EbZtNySvY3Vr+Ya2OYCZ+3gVKTqEKZzK7u91jGeQg5BzCkjcSGe0g5SW0HeNK4ehf/Du/UG9Ok9Qj0Ld7jHhOxsk+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rsSzU-0005We-Pz; Thu, 04 Apr 2024 21:43:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] clk: rockchip: clk-rk3568.c: Add missing USB480M_PHY mux
Date: Thu, 04 Apr 2024 21:43:15 +0200
Message-ID: <3612648.44csPzL39Z@phil>
In-Reply-To:
 <20240404-clk-rockchip-rk3568-add-usb480m-phy-mux-v1-1-e8542afd58b9@pengutronix.de>
References:
 <20240404-clk-rockchip-rk3568-add-usb480m-phy-mux-v1-1-e8542afd58b9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sascha,

Am Donnerstag, 4. April 2024, 09:27:01 CEST schrieb Sascha Hauer:
> From: David Jander <david@protonic.nl>
> 
> The USB480M clock can source from a MUX that selects the clock to come
> from either of the USB-phy internal 480MHz PLLs. These clocks are
> provided by the USB phy driver.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/rockchip/clk-rk3568.c      | 4 ++++
>  include/dt-bindings/clock/rk3568-cru.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
> index 8cb21d10beca2..2d44bcaef046b 100644
> --- a/drivers/clk/rockchip/clk-rk3568.c
> +++ b/drivers/clk/rockchip/clk-rk3568.c
> @@ -215,6 +215,7 @@ static const struct rockchip_cpuclk_reg_data rk3568_cpuclk_data = {
>  
>  PNAME(mux_pll_p)			= { "xin24m" };
>  PNAME(mux_usb480m_p)			= { "xin24m", "usb480m_phy", "clk_rtc_32k" };
> +PNAME(mux_usb480m_phy_p)		= { "clk_usbphy0_480m", "clk_usbphy1_480m"};
>  PNAME(mux_armclk_p)			= { "apll", "gpll" };
>  PNAME(clk_i2s0_8ch_tx_p)		= { "clk_i2s0_8ch_tx_src", "clk_i2s0_8ch_tx_frac", "i2s0_mclkin", "xin_osc0_half" };
>  PNAME(clk_i2s0_8ch_rx_p)		= { "clk_i2s0_8ch_rx_src", "clk_i2s0_8ch_rx_frac", "i2s0_mclkin", "xin_osc0_half" };
> @@ -485,6 +486,9 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
>  	MUX(USB480M, "usb480m", mux_usb480m_p, CLK_SET_RATE_PARENT,
>  			RK3568_MODE_CON0, 14, 2, MFLAGS),
>  
> +	MUX(USB480M_PHY, "usb480m_phy", mux_usb480m_phy_p, CLK_SET_RATE_PARENT,
> +			RK3568_MISC_CON2, 15, 1, MFLAGS),
> +
>  	/* PD_CORE */
>  	COMPOSITE(0, "sclk_core_src", apll_gpll_npll_p, CLK_IGNORE_UNUSED,
>  			RK3568_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
> diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
> index d29890865150d..5263085c5b238 100644
> --- a/include/dt-bindings/clock/rk3568-cru.h
> +++ b/include/dt-bindings/clock/rk3568-cru.h
> @@ -78,6 +78,7 @@
>  #define CPLL_333M		9
>  #define ARMCLK			10
>  #define USB480M			11
> +#define USB480M_PHY		12
>  #define ACLK_CORE_NIU2BUS	18
>  #define CLK_CORE_PVTM		19
>  #define CLK_CORE_PVTM_CORE	20
> 

Please separate the code change and clock-id addition into separate
patches. That way dt-maintainers will more easily see that there are
changes to the dt-binding inside.

Other than that, the change looks fine :-)


Thanks
Heiko




