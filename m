Return-Path: <linux-kernel+bounces-144031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38368A4112
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A141C21190
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8904224CC;
	Sun, 14 Apr 2024 07:51:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24A21360;
	Sun, 14 Apr 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081067; cv=none; b=QXnz6JwNhSsJAZIEfORzoAH7tT3w4H94oRWJ//llya+ZTESvwsXigOC/29ud6qTKiLqhmJW/4efzYLlnysL4qoeNMXZphLU+c4grDSd87f/3ExC3efHVoRzuHSsUJc9WUhjl1xlZkSVJon0iI/q+eWAerVkqtigimK1KWwiz2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081067; c=relaxed/simple;
	bh=6GuqLWvuYUqQo5TDZvw45mpK3aLhCABT5CnF056sszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtQeMhdINWYZ3ZsVB6rZ4G1OF1teJXegFgjZJAtbGnfwmQl+BwYveuEmygAaR4GbhYruQoRcPlUiq6YdUNhVCRxjp4swhQ9LULWY82D7wm/4Le/5AK/eZrw9RIwCVJoiGeb6tJkIhGEMWr9tbE0Qiy0g5sTHm6f+C6SgyWkorXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rvudE-0001KG-L5; Sun, 14 Apr 2024 09:50:32 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: soc@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>,
 Antoine Tenart <atenart@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Robert Richter <rric@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "Paul J. Murphy" <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-realtek-soc@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
Date: Sun, 14 Apr 2024 09:50:29 +0200
Message-ID: <2262532.iZASKD2KPV@diego>
In-Reply-To: <20240412222857.3873079-1-robh@kernel.org>
References: <20240412222857.3873079-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 13. April 2024, 00:28:51 CEST schrieb Rob Herring:
> The "arm,armv8-pmuv3" compatible is intended only for s/w models. Primarily,
> it doesn't provide any detail on uarch specific events.
> 
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> SoC Maintainers, Can you please apply this directly.
> ---

>  arch/arm64/boot/dts/rockchip/rk3368.dtsi             | 2 +-

> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 62af0cb94839..734f87db4d11 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -141,7 +141,7 @@ cpu_b3: cpu@103 {
>  	};
>  
>  	arm-pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,

For Rockchip:
Acked-by: Heiko Stuebner <heiko@sntech.de>



