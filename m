Return-Path: <linux-kernel+bounces-4045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB17817723
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7251F24EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D842370;
	Mon, 18 Dec 2023 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aink5el2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421ECE57C;
	Mon, 18 Dec 2023 16:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7048C433C8;
	Mon, 18 Dec 2023 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916029;
	bh=VTc39LZjCLzqd6eMZ4DBUBzdF70c+lVEjRmh+DQKRfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aink5el2urJqqPhOekzgsDfGFdnmTPDVzbqrJub8R2cMMjzGvPBvRmNQytOwZ5NcO
	 MCfNiWQ5ELJsj6MDmHbaWANLFu7sGv7ui1V9x59iHe1PnCoL1ulRS7iR6eoRKheJMY
	 3Qye7SXYdbTzmBsrUESDOuSGw0VDXmK4Lf6JiwHUkjo9Z+Pj7NjMguUH7RGAM/8M8u
	 Sm96+usTKuKoo4ldZdnw5DXsFzBEsafK0qP0ybPmzMx62vb+tmeaEbSCkklnlJ+E90
	 tK2GpfTGGrTlINmtohOMDQmvSvCgdcgV9H/hpsvlOcfNZX0zI3VV73Wp/BUsu/eqyX
	 fdIoe2D9gfB9w==
Date: Mon, 18 Dec 2023 21:43:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY
 interrupts
Message-ID: <20231218161333.GB50521@thinkpad>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213173131.29436-3-johan+linaro@kernel.org>

On Wed, Dec 13, 2023 at 06:31:30PM +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: d0ec3c4c11c3 ("ARM: dts: qcom: sdx55: fix USB wakeup interrupt types")
> Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index 0864c99a3da1..49910279cb71 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -585,10 +585,10 @@ usb: usb@a6f8800 {
>  					  <&gcc GCC_USB30_MASTER_CLK>;
>  			assigned-clock-rates = <19200000>, <200000000>;
>  
> -			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 158 IRQ_TYPE_EDGE_BOTH>,
> -				     <GIC_SPI 157 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>  					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>  
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

