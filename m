Return-Path: <linux-kernel+bounces-168319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD068BB662
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B7D1C23DE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A568563F;
	Fri,  3 May 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ai5UqITR"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDC25B1FB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772787; cv=none; b=qYpDKPNcKLtZ0E8ohZpn4cBZOXwJ0jce0ldNDphChIqqiImlBuUFEOqmJTjDXZf78BQOc6StNEf1YkMQdPhZKkT45oiJuH5Q2Seh+Bqf0sReaKUoOiheJ4kfiVJqXH4xj9aEG7sNiHOeIPnLitT+eaG6Rc2eGjYx1lBeDvEeHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772787; c=relaxed/simple;
	bh=vCATFAVm5j2l/tgS89AFZ3qjqyT58OStIRa316aPxP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY0xWwjMR/0qR1//n9ViHoOYh+dXIcouthDHEmw1qAOrXAKznDNI9uIfTgl0FpWJrkQi3lG+HhOLH06qUCfrGAy715Y2X5BP7R7iAr0wlEUQ/DNm9+LXUoHq5VnwElrtZrkSYdO2s8a0VLWfDloVL4HIVLuZgNBYPxdSIxAvdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ai5UqITR; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714772772;
 bh=yJluxrbqMAEdPs4Fo4cA70yAXpw93jOBKBZ/ta4Y4TQ=;
 b=ai5UqITRcaaBjabCnd1fzYfTiHFXQkY6itWKCk3KXZzdR51JrmNnb+8mcHfInc7J3tk3zjocR
 6WG8ELeCdTHEzBu1iqg4dhIOz5gwhAKTYTsMf+hif3E053p0PRrn50BDK+oIaUOJf0SjXFHGTUj
 VSuEviCRVwErU5SBjCpZDbIBp6tX9IC9FXsmVW9ue2jvIMYg/3r8J+AVE33S1sdu71FX29pZefD
 AMoxC+jaVBsNMtbow5py60GZyHxe/Bs1Pd13KReKOHbH1zcSBuc7WmMYBwEqjQX5bNB/JzVSxCK
 u3LMoIdEB8YZ2NQsZIxPIz/g2g1Ztx93OAv9p+/Z79Ow==
Message-ID: <d613aa4d-8c87-4735-8209-00510d5097fb@kwiboo.se>
Date: Fri, 3 May 2024 23:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240428123618.72170-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66355b2215cb5945d1c987e2

Hi Chukun,

On 2024-04-28 14:36, Chukun Pan wrote:
> The Radxa ROCK 3C is a development board with the
> Rockchip RK3566 SoC. It has the following features:
> 
> - 1/2/4GB LPDDR4
> - 1x HDMI Type A
> - 1x PCIE 2.0 slot
> - 1x FAN connector
> - 3.5mm jack with mic
> - 1GbE RTL8211F Ethernet
> - 1x USB 3.0, 3x USB 2.0
> - 40-pin expansion header
> - MicroSD card/eMMC socket
> - 16MB SPI NOR (gd25lq128d)
> - AP6256 or AIC8800 WiFi/BT
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-rock-3c.dts      | 750 ++++++++++++++++++
>  2 files changed, 751 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> 

[snip]

> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;

[snip]

> +		codec {
> +			mic-in-differential;

This should be rockchip,mic-in-differential or removed.

> +		};
> +	};
> +
> +	eeprom: eeprom@50 {
> +		compatible = "belling,bl24c16a", "atmel,24c16";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +};
> +

[snip]

> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	sd-uhs-sdr50;

Do you have any references to issues related to why sd-uhs-sdr104 is not
used here?

My testing shows that io-domain is getting notified and correctly
configured during boot. And card seem to be working correctly.

[    2.162780] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 400000Hz, actual 375000HZ div = 0)

[    2.229408] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000
[    2.230042] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000 done
[    2.231493] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 1800000
[    2.232121] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 1800000 done
[    2.257294] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
[    2.269482] dwmmc_rockchip fe2b0000.mmc: Successfully tuned phase to 254
[    2.270098] mmc1: new ultra high speed SDR104 SDXC card at address aaaa
[    2.271533] mmcblk1: mmc1:aaaa SD64G 59.5 GiB
[    2.277357]  mmcblk1: p1

Also when the card is later removed/re-inserted:

[   80.181598] mmc1: card aaaa removed
[   83.836785] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000
[   83.837611] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000 done
[   83.839263] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000
[   83.839952] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000 done
[   83.855358] mmc_host mmc1: Bus speed (slot 0) = 375000Hz (slot req 400000Hz, actual 375000HZ div = 0)
[   84.153827] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000
[   84.154524] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 3300000 done
[   84.156149] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 1800000
[   84.156838] rockchip-iodomain fdc20000.syscon:io-domains: Setting to 1800000 done
[   84.183932] mmc_host mmc1: Bus speed (slot 0) = 150000000Hz (slot req 150000000Hz, actual 150000000HZ div = 0)
[   84.202888] dwmmc_rockchip fe2b0000.mmc: Successfully tuned phase to 257
[   84.203574] mmc1: new ultra high speed SDR104 SDXC card at address aaaa
[   84.205537] mmcblk1: mmc1:aaaa SD64G 59.5 GiB
[   84.211434]  mmcblk1: p1

sd-uhs-ddr50 should also work based on my testing.

Regards,
Jonas

> +	vmmc-supply = <&vcc3v3_sys>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +

[snip]

