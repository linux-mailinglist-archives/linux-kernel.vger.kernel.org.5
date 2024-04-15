Return-Path: <linux-kernel+bounces-144974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0298A4D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B21C2116A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2145EE76;
	Mon, 15 Apr 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9CguGD2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1C5CDE4;
	Mon, 15 Apr 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179761; cv=none; b=MO+pw+NqHnyo1KAC2ffCjKCzPOjTeVMOuTO45cXG+k/OwCw+TrmcRarfyB5K5hI+WcAC2vtTCqfgLRzvq8r2uDIeS1SneAxHOSogKyxo7fn/S1ysMRAPu1cTruLAQnmVvv24ja+INp1rcOSdKWvelpGbRFDo2gcgrNk5s8oj19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179761; c=relaxed/simple;
	bh=pS+uyKgsyii1wjRg73vGWLVmn9HUda2om5l4QvZMNPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAiPOrF8zeRHOAs+XFQ3YH/qleVFG+y97RYTelvhBKixMejeKBVlkQdo0zdkdEud/MX0R08HoxBdR569UWdiOUCtUgfVGkTwq3Kf8GsyVys9kcBWGy7CIe0GmvBe6cHh7oN5MFcbbdhZQ+ll0l6OD6JMlM/5TRBRgsch/8am3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9CguGD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CFC113CC;
	Mon, 15 Apr 2024 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713179760;
	bh=pS+uyKgsyii1wjRg73vGWLVmn9HUda2om5l4QvZMNPQ=;
	h=Date:Subject:List-Id:To:Cc:References:From:In-Reply-To:From;
	b=p9CguGD20UqvL+CtegaZxYrRV0MQfovjj0iJ/rNEUvEnlMliidcw1qwq9sZflSkP5
	 YntfStOgSo3hm5LodJeJ4kVHFRTMRrmvshZpBnD3LJjSu5E6nCTn3e1i11d+O0bIgt
	 vkxUFcCPd9q2c96hZASkrYmo49MsvGW+AtUTT4jl2sQtBtCb6tHB7K3IIo+L3AqZYT
	 av44M6ECMSaXKIjkj7xoWMjjS9UuvBLUS19dexS3R6kjvg2AHQJacwuO4BH9rgDb4w
	 owKwNX+6oNqVRR7xuV7uGjTSUa5WQTKIBf78w4xvF1PMECZ3pI4APEikTez0i/wcgh
	 E52+HNhFWP3zA==
Message-ID: <2fa0223f-7cac-4140-b667-886cbe3fb8f5@kernel.org>
Date: Mon, 15 Apr 2024 06:14:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
To: Rob Herring <robh@kernel.org>, soc@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>,
 Antoine Tenart <atenart@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Robert Richter <rric@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "Paul J. Murphy"
 <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jisheng Zhang <jszhang@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-fsd@tesla.com, Michal Simek <michal.simek@amd.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-realtek-soc@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240412222857.3873079-1-robh@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240412222857.3873079-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 17:28, Rob Herring wrote:
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
>   arch/arm/boot/dts/broadcom/bcm2711.dtsi              | 4 ++--
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 2 +-
>   arch/arm64/boot/dts/amazon/alpine-v2.dtsi            | 2 +-
>   arch/arm64/boot/dts/apm/apm-storm.dtsi               | 2 +-
>   arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 2 +-
>   arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi     | 2 +-
>   arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi  | 2 +-
>   arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 2 +-
>   arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi        | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 7 +++++++
>   arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       | 7 +++++++
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 5 -----
>   arch/arm64/boot/dts/freescale/imx8dxl.dtsi           | 2 +-
>   arch/arm64/boot/dts/intel/keembay-soc.dtsi           | 2 +-
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi        | 2 +-

For SoCFPGA,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


