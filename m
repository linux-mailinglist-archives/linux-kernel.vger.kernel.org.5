Return-Path: <linux-kernel+bounces-47793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331368452F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6572E1C25C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF815AAB2;
	Thu,  1 Feb 2024 08:42:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72215A4BE;
	Thu,  1 Feb 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776928; cv=none; b=fxvK1P/LBUaIFNiH8HqgPOGe7tj4d0BuLvZJXZubLkCClnmWmdKnhKNCUQ7IC7ystBz4074wuRrZC7wKjgkEvnc1ikVYW5wjv+YU9k59lixia9Z14qmfILIOV4S2x4BRoXRmCgbi0H2v1gtvsBf0CYWORS9CdUhU425RkSReAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776928; c=relaxed/simple;
	bh=KOCs0XKDeVMwC4fhAcyTbG2/t+oFgK1lavrkMjGyxY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCu1UUAsCy1tmUCmqYoOb92ZS392UNJlJ/2QUzzNW+Pul0wGwS17HUj5nBPyZ8TqHn1yWU5FGLcRjo9m7Ndlqjwkhg75apv6MjjTb7/vroAWhEUfwuR5ir6ouW4BowWvpzlzF6xiydSf6UYquH12I7nAoIhaxnR8qH6+sUeOBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rVSdZ-0004xF-5k; Thu, 01 Feb 2024 09:41:33 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>, Ondrej Jirman <megi@xff.cz>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lucas Tanure <lucas.tanure@collabora.com>, Rob Herring <robh+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com
Subject:
 Re: [PATCH] arm64: dts: rockchip: rk3588: remove redundant cd-gpios in sdmmc
 node
Date: Thu, 01 Feb 2024 09:41:31 +0100
Message-ID: <4514845.zXnORWrf4K@diego>
In-Reply-To: <20240201034621.1970279-1-kever.yang@rock-chips.com>
References: <20240201034621.1970279-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kever,

Am Donnerstag, 1. Februar 2024, 04:46:21 CET schrieb Kever Yang:
> The sdmmc node already have a "&sdmmc_det" for pinctrl which switch the
> GPIO0A4 to sdmmc detect function, no need to define a separate "cd-gpios".

just to make sure, did you test this on actual hardware?
Because there might be differences in behaviour.

> RK3588 has force_jtage feature which is enable JTAG function via sdmmc
> pins automatically when there is no SD card insert, this feature will
> need the GPIO0A4 works in sdmmc_det function like other mmc signal instead
> of GPIO function, or else the force_jtag can not auto be disabled when
> SD card insert.

We disable the jtag switching by default [0] ;-) .
And there are very good reasons for it too:


(1) JTAG is very much a debug feature, that the normal user will not need.
Especially not in a finished product. If a developer is debugging _that_
deep and needs jtag, they can enable it in their debug build.


(2) Randomly enabling features that may compromise security.
Why go through all the hoops of doing things like secure boot, signed
images and everything, just to have the kernel then export direct access
to the hardware on sd-card pins. If one wants to expose JTAG somewhere
this should be conscious choice and devs should not need to fork their
kernel just to shut down unwanted security-critical functionality.


(3) It affects board layouts _not following_ the standard layout.
Nobody is forcing board-designers to use Rockchip's desired pin
for card-detection. Some designer may just select a different pin
or a board could go without card-detect at all - see rk3588-jaguar.
These are both valid use-cases that need to be supported.


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f6878ec6faf16a5f36761c93da6ea9cf09adb33


> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts     | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts         | 1 -
>  arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts        | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 3e660ff6cd5ff..1b606ea5b6cf2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -444,7 +444,6 @@ &sdhci {
>  &sdmmc {
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	max-frequency = <150000000>;
>  	no-sdio;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> index 87a0abf95f7d4..67414d72e2b6e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> @@ -429,7 +429,6 @@ &sdhci {
>  &sdmmc {
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	max-frequency = <150000000>;
>  	no-sdio;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index a0e303c3a1dc6..25a82008e4f76 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -371,7 +371,6 @@ &sdmmc {
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	sd-uhs-sdr104;
>  	vmmc-supply = <&vcc_3v3_s3>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> index 2002fd0221fa3..00afb90d4eb10 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -366,7 +366,6 @@ &sdmmc {
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
>  	cap-sd-highspeed;
> -	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	max-frequency = <150000000>;
>  	no-sdio;
> 





