Return-Path: <linux-kernel+bounces-105626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7687E1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D221C216E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0161CD07;
	Mon, 18 Mar 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lltLGczZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912123741;
	Mon, 18 Mar 2024 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725515; cv=none; b=flsQH6mXq9ufSiAKp/oItAS9JcoUhEtiQhOXTsG5oz6I7xHOBtp4EUmDiUrHLNHnI6S5Z6x4oTPUteOTVQUPLH6ldQvb36WPvEW7lOpyRi9l2hYb2Ryb9iBPqunZDaimyyib+9PpAO7BDKcaqxWIHeySWAJ/EuZwpDqx1hbkAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725515; c=relaxed/simple;
	bh=RNW2aU4AGeGtJeBkdfUoXrquQxQjFBGeXU40AmnU96g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egLs8SwrFJA0Vv28m5L38ccyntS0nvK66153swKzG7fz7WXuGaCzW5EDibd+DKUa2GeO62BJ36j7CXOqFuvDeXc01mvQuE7tQN3m6e7ptR9N4sXuSm2sK+EiF0Q6J+I5t6Z010EuYFs1zrm9kQf0Uapp7ec/vYlAFWv2IPnvMPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lltLGczZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB8C433C7;
	Mon, 18 Mar 2024 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710725514;
	bh=RNW2aU4AGeGtJeBkdfUoXrquQxQjFBGeXU40AmnU96g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lltLGczZUEYWiXjWPLT/E5ad6r6E4M5SzIbTQk7mPFqBHbcEXaNpK5/fD+S0+TMQY
	 gDzown5dOEiyOzEUNzFTAH4BTO8H2XMD6PSCiuCppogyVrj7Xou/K3K7sTlsuvsvxp
	 dHa0xQhd+Inmg5K7WOSzsaQ3vfolfw8wca1WZXpas9CWy1vdBi0uHY/FWKXn+ZvVy8
	 RvXkUXIoZBmuwFVZKYpFimXKlcdsdpxiJGGNJQiMgWBXe+2C2s7WXEY5/7UI20Bsbq
	 IwC3q4QfowYGQpjwBNgb6xMmaK/ccC52x1g3PIVDMoaWXeG7CHxDQSqTEbT6C33Gqw
	 rfmPGvQcufwyw==
Date: Sun, 17 Mar 2024 20:31:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc8280xp: Describe the PCIe
 SMMUv3
Message-ID: <phledylmdu23yrw6f4x7fkefntrejuwagazebsnkgyxsweodzg@pddhnc2gwexz>
References: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
 <20231219-topic-8280_smmuv3-v2-2-c67bd3226687@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-topic-8280_smmuv3-v2-2-c67bd3226687@linaro.org>

On Sat, Mar 09, 2024 at 02:31:10PM +0100, Konrad Dybcio wrote:
> SC8280XP actually has a third SMMU, which can be seen in e.g. the IORT
> ACPI table and is used for the PCIe hosts.
> 
> Unfortunately though, the secure firmware seems to be configured in a
> way such that Linux can't touch it, not even read back the ID registers.
> It also seems like the SMMU is configured to run in some sort of bypass
> mode, completely opaque to the OS.
> 
> Describe it so that one can configure it when running Linux as a
> hypervisor (e.g with [1]) and for hardware description completeness.
> 
> [1] https://github.com/TravMurav/slbounce
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Have this information been validated? Or are you suggesting we add it
for documentation purposes?

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index a5b194813079..28edd30a9c04 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4648,6 +4648,22 @@ cci3_i2c1_sleep: cci3-i2c1-sleep-pins {
>  			};
>  		};
>  
> +		pcie_smmu: iommu@14f80000 {
> +			compatible = "qcom,sc8280xp-smmu-v3", "arm,smmu-v3";
> +			reg = <0 0x14f80000 0 0x80000>;
> +			interrupts = <GIC_SPI 951 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 955 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 953 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "eventq",
> +					  "gerror",
> +					  "cmdq-sync";
> +			#iommu-cells = <1>;
> +			dma-coherent;
> +
> +			/* The hypervisor prevents register access from Linux */
> +			status = "reserved";
> +		};
> +
>  		apps_smmu: iommu@15000000 {
>  			compatible = "qcom,sc8280xp-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
> 
> -- 
> 2.44.0
> 

