Return-Path: <linux-kernel+bounces-42112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A7B83FC70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601A028300D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D5FBEB;
	Mon, 29 Jan 2024 03:01:28 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92441F9DF;
	Mon, 29 Jan 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497288; cv=none; b=DvPh/4gbKo2ICaUBXaMcbScc1Vlf/smHztJwHj5V8KG9K6fdr0MWCgauAfBlxx+MrY5gRAidU8RlN+em1/gObgn6eUL3Qbs2aQVvJCNwxDl9NwM4inS2Z52vH5SBE9jPcDVeYVnQ42huvWGdvCk6csXrzQwi5XWdoRCoe9D/fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497288; c=relaxed/simple;
	bh=2xUcCAm+iqsfWkBCNUqENNuPxYyGpXz+6bPj71mvjR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snfsquH39kXfuAIHi6Kjh+ELNVR+6eF1UaDgWVi+Eexu9u1f/SeGTZjJnGo9vi0WvvZSmx9v0dWiBUZLmv0JnDFdE8SR+WrBZeHdkmKH36jP6+YBuhVXuFjYBGhvkrMRnboc9RUxdtXgy+0jsF/puZY/FEmXkDYYmgDMBx6Samk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 29 Jan 2024 03:01:15 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: dts: sophgo: cv18xx: Add spi devices
Message-ID: <20240129030115.GB1097489@ofsar>
References: <IA1PR20MB49533BACE8D47590C1C341D2BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953654F150743B649D5ADCEBB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953654F150743B649D5ADCEBB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>

Hi Inochi Amaoto

On 10:26 Mon 29 Jan     , Inochi Amaoto wrote:
> Add spi devices for the CV180x, CV181x and SG200x soc.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 7c88cbe8e91d..e66f9e9feb48 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -176,6 +176,50 @@ uart3: serial@4170000 {
>  			status = "disabled";
>  		};
> 
> +		spi0: spi@4180000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x04180000 0x10000>;
> +			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
> +			clock-names = "ssi_clk", "pclk";
.
> +			#address-cells = <1>;
> +			#size-cells = <0>;
I'd suggest moving those two above 'interrupts' property

there is an ongoing discussion here..
https://lore.kernel.org/all/20231203174622.18402-1-krzysztof.kozlowski@linaro.org/

> +			status = "disabled";
> +		};
> +
> +		spi1: spi@4190000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x04190000 0x10000>;
> +			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI1>;
> +			clock-names = "ssi_clk", "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi2: spi@41a0000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x041a0000 0x10000>;
> +			interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI2>;
> +			clock-names = "ssi_clk", "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi3: spi@41b0000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x041b0000 0x10000>;
> +			interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI3>;
> +			clock-names = "ssi_clk", "pclk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		uart4: serial@41c0000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x041c0000 0x100>;
> --
> 2.43.0

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

