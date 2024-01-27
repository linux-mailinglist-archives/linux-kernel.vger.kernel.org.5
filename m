Return-Path: <linux-kernel+bounces-41442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503483F1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA31C21FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92D20338;
	Sat, 27 Jan 2024 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRuwzwoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621D1F946;
	Sat, 27 Jan 2024 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397603; cv=none; b=JtiAONKk5KNaeSjoSIlrygFF2OodLuKBpP6POCGsUrdgaAHdmOB4WCZA8OhDaccQsK2CpeRd+aLcdfKbZCIpo6PLm7iU1pVvwBbr3lPkO4hSDL+KevrXz8iPQgoCDDd7vdNUthYKnDQa9Ygs+IzRHiGV/sWwADw1v9vQt3h2//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397603; c=relaxed/simple;
	bh=iLevUR8td+6qnN+SSEVbbIHCicgNFj0j8Dxgr3vaIb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc0kRXuAs4QrsDTjlx7Y2EY3S6MIEao8DjhdpZGlzA1maBqjdyEZsYw441xZED26ACRuZDHvnqiYX5RkT3zS5H0z+E6KlHSAaPT/vmOSkr2OnN911F9WsN2Bj6H3DaV3gfs38vm4VDNcm5QL21kx2SxtXUCeHrwBm/S+/NW5N4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRuwzwoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F843C433F1;
	Sat, 27 Jan 2024 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706397602;
	bh=iLevUR8td+6qnN+SSEVbbIHCicgNFj0j8Dxgr3vaIb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRuwzwoNl/simX0VAEW0PAQqab76hmF1uYkoJGkmMOXF6AAnkgQavqVeYRw+ct94p
	 SCIRlKYrIuygU+Hp9giCz06BPAofXv9PxFa71sc2Y06T9LPxCxHQ90a5zQBbgDTDvj
	 nrte5fbPUZS6BrS3kAp/kR2ir2zmg76UROOQf72J348+KdRweby1yo+4XTHxvaroSg
	 +k3+2GL+s4vaSQHAVCeClXnhzV5FISevKLqY/zi6HnNbO9506tJPlcDa6T4U0g+ZVp
	 UP/JwRG8k6R6DipMixzX0b88h6uVZd7JGNEiqAEAgYvgOpEY6XgT2s8l72ScTx5hNO
	 CToQpPtbW6isQ==
Date: Sat, 27 Jan 2024 17:19:59 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
Message-ID: <3dev6ez4iovtigj5felmwhascaaupzzptwz5wfoag7ml7knlmj@arnddy2jaqxz>
References: <20240118133022.553339-1-amadeus@jmu.edu.cn>
 <20240118133022.553339-3-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118133022.553339-3-amadeus@jmu.edu.cn>

On Thu, Jan 18, 2024 at 09:30:22PM +0800, Chukun Pan wrote:
> Enable mmc device found on ipq6018 devices.
> This node supports both eMMC and SD cards.
> 
> Tested with:
>   eMMC (HS200)
>   SD Card (SDR50/SDR104)
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 322eced0b876..420c192bccd9 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -441,6 +441,25 @@ dwc_1: usb@7000000 {
>  			};
>  		};
>  
> +		sdhc: mmc@7804000 {
> +			compatible = "qcom,ipq6018-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x7804000 0x0 0x1000>,
> +			      <0x0 0x7805000 0x0 0x1000>;
> +			reg-names = "hc", "cqhci";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +			max-frequency = <192000000>;
> +			status = "disabled";

Subject and commit message says "enable", but this says disable. Could
you change this to "Add" instead?

Do you have a patch for any board where this is actually enabled?
Perhaps you missed a 3rd patch that enables this and uses the ipq6018_l2
regulator you add in patch 1?

Regards,
Bjorn

> +		};
> +
>  		blsp_dma: dma-controller@7884000 {
>  			compatible = "qcom,bam-v1.7.0";
>  			reg = <0x0 0x07884000 0x0 0x2b000>;
> -- 
> 2.25.1
> 

