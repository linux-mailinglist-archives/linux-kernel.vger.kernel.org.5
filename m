Return-Path: <linux-kernel+bounces-160347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5798B3C42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5943228318C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9715B551;
	Fri, 26 Apr 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Bqzr2Sb9"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD3156674;
	Fri, 26 Apr 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147258; cv=none; b=WNU1ss5LBKfyIA7sxWiwqNPHcLc+7BaS10vmirM+SUgX8nMwf9LrPxydW8X167yUmihoaK3wpnX4aAjMghHJQdvIkd6S4XNStVIDuXlY4Yar3SlsldJvBPzeXGkdDSdeBUNGGgdoYYJiRRdGgrE9jrPjB3wkxab5xgJUjBROgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147258; c=relaxed/simple;
	bh=pxSUINJRH2avfn2/9DNzlRx7OkoXTWHoZxUg2HQP2ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuiwAaFAN16PY4ez586WQkeztmyfT5BP9i9hbSaeEonukmED6Ynxo9IE51LkBS+Ru/5uWGBEgDI/qnXXYBoArsNuGvy4kOohLzRp2of0W3R3tLtsVnD32kRgLp7/BeujGw+pxzAu9IVn/2p3b69CVKZ2dF7vUOiyGr8qzmQn4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Bqzr2Sb9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 621FF884FD;
	Fri, 26 Apr 2024 18:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147254;
	bh=nmPDhDmaIgQDkA6x6HObPcx/r00e6kxLkilPuXIURrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bqzr2Sb9yVC8J/dWJRqBSJ4Kf1SRgyZA7YziXD9LhWuIc766fq+iLXU6LTtUw9p+N
	 4Q05nS1575oJ1S6/4QWX/RWGpPjgNs2SRAmvaqz6d/Hc79i3PbcUaDRwd+IKS1wd/V
	 7cNRAC0y35AO82v6uM+uXr9kkGa6MxexjNw+2HiCU2uOV+5Amx39uVLM4tChdbuAOq
	 aVgXL17ZqKUooEQn7N+3L5d7/XNco8HAi8WhChW9myUArTjM3RTv9xRL1dyRWpkxvx
	 Utezn/ahBqafr5aOtNvnpM4ayBbkGgtgUbdCA5KLPej1pVTeyq8sxG5OCAXmXsrhIw
	 voCdCOmUU7c8Q==
Message-ID: <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
Date: Fri, 26 Apr 2024 17:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for
 STM32MP135F-DK board
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-11-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:57 PM, Christophe Roullier wrote:
> Add dual Ethernet:
> -Ethernet1: RMII with crystal
> -Ethernet2: RMII without crystal
> PHYs used are SMSC (LAN8742A)
> 
> With Ethernet1, we can performed WoL from PHY instead of GMAC point
> of view.
> (in this case IRQ for WoL is managed as wakeup pin and configured
> in OS secure).

How does the Linux PHY driver process such a PHY IRQ ?

Or is Linux unaware of the PHY IRQ ? Doesn't that cause issues ?

> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> index 567e53ad285f..3b8eb0ab9ab9 100644
> --- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> +++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
> @@ -19,6 +19,8 @@ / {
>   	compatible = "st,stm32mp135f-dk", "st,stm32mp135";
>   
>   	aliases {
> +		ethernet0 = &ethernet1;
> +		ethernet1 = &ethernet2;
>   		serial0 = &uart4;
>   		serial1 = &usart1;
>   		serial2 = &uart8;
> @@ -141,6 +143,52 @@ &cryp {
>   	status = "okay";
>   };
>   
> +&ethernet1 {
> +	status = "okay";
> +	pinctrl-0 = <&eth1_rmii_pins_a>;
> +	pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	max-speed = <100>;
> +	phy-handle = <&phy0_eth1>;

Keep the list sorted please (is the max-speed even needed? if not, drop it)

> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +
> +		phy0_eth1: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id0007.c131";
> +			reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;
> +			reg = <0>;
> +			wakeup-source;
> +		};
> +	};
> +};
> +
> +&ethernet2 {
> +	status = "okay";
> +	pinctrl-0 = <&eth2_rmii_pins_a>;
> +	pinctrl-1 = <&eth2_rmii_sleep_pins_a>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	max-speed = <100>;
> +	phy-handle = <&phy0_eth2>;
> +	st,ext-phyclk;
> +	phy-supply = <&scmi_v3v3_sw>;

Sort please

[...]

