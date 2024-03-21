Return-Path: <linux-kernel+bounces-110714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B98862CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E867E1F22F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1F136668;
	Thu, 21 Mar 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="52n0zck7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BF133998;
	Thu, 21 Mar 2024 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058408; cv=none; b=RNMu42gWBotNoudOr5+rEC8TyirXP6uZkeMSFJHMKP57VZ3Pm173Rx9+na7bUvBMcoLtancc+m6Z9d99LEnwrs1oI0JZXUl499DWkk5HQSZCw2AgkCPG/ODVw/dtb7Izu6VLBxTN7xIPy3JrYm3v4dfnDUhOU0WGqX+OXMQLl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058408; c=relaxed/simple;
	bh=t2QmslawEats+EV93HQG0+kSPQ49sMzPwqUo61078Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9rqWtWJ1iP9efXgS5M/u7NpeyvAy4msQMQQcgbGzb9KtmXNd7Z9C9DLuyO8pvyraMORxt9XtBEMoVsQs2LT46MjrNJWDqQWW7idjiyeHGULbX/steEfDNB+ndL0ApHwi80Diejq8zjueRktO7JMpbqBmrlJJbMFEoMHddSkAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=52n0zck7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TT+5vkWHgG4JG2zDFc0DxT6DP+1/xW6JuSns2VThGEI=; b=52n0zck7k+vUeE+nu8Ctrwc7Ne
	5YWLCUzmuP0BHiG99a9vi2uVwJ4NWyg/aPKrEljnQ54IUg0ZJ/Lf9LhPlyEljuPv8pKm4JKCQ/L+O
	PtapZuCttFCEENUi8xBRZdV8MQYb1gPLG0kdlZWzdewh5F5tGaY3fNcCH/apvSUvFAaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnQS5-00AuVW-Eo; Thu, 21 Mar 2024 22:59:57 +0100
Date: Thu, 21 Mar 2024 22:59:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Message-ID: <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>

On Thu, Mar 21, 2024 at 10:47:12PM +0100, Josua Mayer wrote:
> Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
> reference boards.
> 
> The SoM has been designed as a pin-compatible replacement for the older
> Armada 388 based SoM. Therefore it supports the same boards and a
> similar feature set.
> 
> Most notable upgrades:
> - 4x Cortex-A72
> - 10Gbps SFP
> - Both eMMC and SD supported at the same time
> 
> The developer first supporting this product at SolidRun decided to use
> different filenames for the DTBs: Armada 388 uses the full
> "clearfog" string while cn9130 uses the abbreviation "cf".
> This name is already hard-coded in pre-installed vendor u-boot and can
> not be changed easily.
> 
> NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
> CN9130 SoM has a different footprint from Armada 388 SoM.
> Components on the carrier board below the SoM may collide causing
> damage, such as on Clearfog Base.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  arch/arm64/boot/dts/marvell/Makefile           |   2 +
>  arch/arm64/boot/dts/marvell/cn9130-cf-base.dts | 138 ++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts  | 249 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-cf.dtsi     | 198 ++++++++++++++++++++
>  arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 160 ++++++++++++++++
>  5 files changed, 747 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 99b8cb3c49e1..019f2251d696 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -28,3 +28,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
> new file mode 100644
> index 000000000000..b0067940d5e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun CN9130 Clearfog Base.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +
> +#include "cn9130.dtsi"
> +#include "cn9130-sr-som.dtsi"
> +#include "cn9130-cf.dtsi"
> +
> +/ {
> +	model = "SolidRun CN9130 Clearfog Base";
> +	compatible = "solidrun,clearfog-base-a1", "solidrun,clearfog-a1",
> +		     "solidrun,cn9130-sr-som","marvell,cn9130",
> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&rear_button_pins>;
> +		pinctrl-names = "default";
> +
> +		button-0 {
> +			/* The rear SW3 button */
> +			label = "Rear Button";
> +			gpios = <&cp0_gpio1 31 GPIO_ACTIVE_LOW>;
> +			linux,can-disable;
> +			linux,code = <BTN_0>;
> +		};
> +	};
> +
> +	rfkill-m2-gnss {
> +		compatible = "rfkill-gpio";
> +		label = "m.2 GNSS";
> +		radio-type = "gps";
> +		/* rfkill-gpio inverts internally */
> +		shutdown-gpios = <&expander0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* M.2 is B-keyed, so w-disable is for WWAN */
> +	rfkill-m2-wwan {
> +		compatible = "rfkill-gpio";
> +		label = "m.2 WWAN";
> +		radio-type = "wwan";
> +		/* rfkill-gpio inverts internally */
> +		shutdown-gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* SRDS #3 - SGMII 1GE */
> +&cp0_eth1 {
> +	phy = <&phy1>;
> +	phys = <&cp0_comphy3 1>;
> +	phy-mode = "sgmii";
> +	status = "okay";
> +};
> +

> +&cp0_eth2_phy {
> +	/*
> +	 * Configure LEDs:
> +	 * - LED[0]: link/activity: On/blink (green)
> +	 * - LED[1]: link is 100/1000Mbps: On (yellow)
> +	 * - LED[2]: high impedance (floating)
> +	 */
> +	marvell,reg-init = <3 16 0xf000 0x0a61>;

Sorry, but no. List the LEDs in the PHY node, and they can then be
controlled via /sys/class/leds.

arch/arm/boot/dts/marvell/armada-370-rd.dts is an example.

	Andrew

