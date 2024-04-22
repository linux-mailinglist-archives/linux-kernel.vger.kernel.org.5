Return-Path: <linux-kernel+bounces-153844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3508AD414
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FEF1C20D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9C154430;
	Mon, 22 Apr 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UYDUZi4+"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C231514D5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811048; cv=none; b=WlYagCqsvw5zpe1uw24rZf0Hzl9rRq3tbxnPylAK3xITFdiEoL0wkF7c1YqkNMmzhv6wn4uAnkP9dnybiiUFNm8T4R0X7CPJ5Kn8E5gGDL3mbht3TUbSwRGQKWdNe+4NXwCC74zXU5YJL0fS9euZt4WkE6KjgFrJKNO0QyOhL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811048; c=relaxed/simple;
	bh=7M6RuExs4YXRq0NDHqwLA+3ilaRetfrnm1pOw8wGOVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU9n9k7Lop06Xn1RMiz3hijGRx7G19G6/LUGFb/Zmy5haZSl5d+9IjbSz35bnniV+VkTckcgh2v4j3pW/XZzsAbgiaa6zr6ZmcQLH9kDXfxnL3VyjyNc91MQCxiC0JV2zZ+tqeK5+/QNkJrUi9Zlb48LHAVYKVjEja/idLcZF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UYDUZi4+; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713811022;
 bh=FlBAbNs+0ZH1BEM+UXV8F2ZO+BzWQaxaQLhAsfyYQ2s=;
 b=UYDUZi4+43sDpRW6TR7UCehqWPxGlX9DAJBHkt7cqdFgLD/fUCJI96s7zBirb1Vj/b+SbDFVV
 dIK54EyoAoVCtl/WPG6lTqwCiEdWsiOaFNlm9aD23pjE009MwCJJmgadz6uvDJw67eq0Il5QNY4
 qkeYfLirENnDWoDc5qdUBGtdmVWut6gS2eTKvGlxWBDI+dlLFPUxOE8Ozwlp9KpwU2oHKYUCoUd
 VUeK/G225cB8kwNSWAAFbZOsjfFTFAmiF9gGDV0M6Im8aQ0wIJR70d0G/f7H2CxllQDfH7AF+hq
 7i8oeMEcYWC3JuM0ZPb+omXUPPQvbpG9rTMJ5K8o/fCw==
Message-ID: <f33c0c0b-979b-4f50-89f7-976832968494@kwiboo.se>
Date: Mon, 22 Apr 2024 20:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: rockchip: add PCIe3 support on
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>, Heiko Stuebner
 <heiko.stuebner@cherry.de>
Cc: quentin.schulz@theobroma-systems.com,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240422133502.2592975-1-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240422133502.2592975-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6626ae4c936d77d66ebdc27d

Hi Heiko,

On 2024-04-22 15:35, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Jaguar SBC provides an M.2 slot connected to the pcie3 controller.
> In contrast to a number of other boards the pcie-refclk is gpio-controlled,
> so the necessary clock and is added to the list of pcie3 clocks.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
> changes in v3:
> - drop unnecessary pinctrl comment (Quentin)
> - add Quentin's review
> 
> changes in v2:
> - "an" M.2 slot (Dragan)
> - pinctrl for refclk-en and reset pin (Quentin)
> - don't repurpose the pcie30x4_pins pinctrl entry for only wake (Quentin)
> 
>  .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> index 4076c92668ba..0ad53d7768a3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> @@ -72,6 +72,27 @@ led-1 {
>  		};
>  	};
>  
> +	/*
> +	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
> +	 * clock generator.
> +	 * The clock output is gated via the OE pin on the clock generator.
> +	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
> +	 */
> +	pcie_refclk_gen: pcie-refclk-gen-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000000>;

This should probably be 100000000 (100 MHz) and not 1 GHz?

Regards,
Jonas

> +	};
> +
> +	pcie_refclk: pcie-refclk-clock {
> +		compatible = "gpio-gate-clock";
> +		clocks = <&pcie_refclk_gen>;
> +		#clock-cells = <0>;
> +		enable-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>; /* PCIE30X4_CLKREQN_M0 */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie30x4_clkreqn_m0>;
> +	};
> +
>  	pps {
>  		compatible = "pps-gpio";
>  		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> @@ -358,6 +379,30 @@ &pcie2x1l0 {
>  	status = "okay";
>  };
>  
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x4 {
> +	/*
> +	 * The board has a gpio-controlled "pcie_refclk" generator,
> +	 * so add it to the list of clocks.
> +	 */
> +	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
> +		 <&pcie_refclk>;
> +	clock-names = "aclk_mst", "aclk_slv",
> +		      "aclk_dbi", "pclk",
> +		      "aux", "pipe",
> +		      "ref";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x4_waken_m0 &pcie30x4_perstn_m0>;
> +	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */
> +	vpcie3v3-supply = <&vcc3v3_mdot2>;
> +	status = "okay";
> +};
> +
>  &pinctrl {
>  	emmc {
>  		emmc_reset: emmc-reset {
> @@ -376,6 +421,20 @@ led1_pin: led1-pin {
>  			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> +
> +	pcie30x4 {
> +		pcie30x4_clkreqn_m0: pcie30x4-clkreqn-m0 {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x4_perstn_m0: pcie30x4-perstn-m0 {
> +			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x4_waken_m0: pcie30x4-waken-m0 {
> +			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
> +		};
> +	};
>  };
>  
>  &saradc {


