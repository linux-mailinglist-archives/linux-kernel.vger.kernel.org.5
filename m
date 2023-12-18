Return-Path: <linux-kernel+bounces-4046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24059817728
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BAE1F251B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F042372;
	Mon, 18 Dec 2023 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC6kXNwF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBF11185;
	Mon, 18 Dec 2023 16:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED3BC433C8;
	Mon, 18 Dec 2023 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916078;
	bh=U75V4OnEmiSj0q9JssKWwC2GELlpClzcWhjLzPlGv/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC6kXNwFwWkdZEtA9hMqspYzfyCYilMxu+fzG+dxmaOiVjLzQWwv77tz41+ZpLibq
	 q7x/SCP9QHfGgeHI+DdBtWg8lMSHw5XBggn280Ia8/TdCFgykhN1+WuxwsRgGDz+76
	 lonuZUBz9ZeNUROAohoKvbVmOZFLlJuBTNdnytiQo2JoytCbhIk4AP9Es5fwv8JXh5
	 BsNRdeTzzDln6BwwDgjuCPbnjKLTUd2ILwyzUdvC/q+c8Nc0c5bSdXY+fhZ9c/oSUT
	 aj4D5+qrE+L6eiYTU38NZu7+vRd0cC07Si5xHaQ9CL0G9jUGvsN0A7WJYzuYB55yUP
	 tpkYZFLHhCUeA==
Date: Mon, 18 Dec 2023 21:44:15 +0530
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
Subject: Re: [PATCH 3/3] ARM: dts: qcom: sdx55: fix USB SS wakeup
Message-ID: <20231218161415.GC50521@thinkpad>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-4-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213173131.29436-4-johan+linaro@kernel.org>

On Wed, Dec 13, 2023 at 06:31:31PM +0100, Johan Hovold wrote:
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index 49910279cb71..5b69219170a8 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -586,7 +586,7 @@ usb: usb@a6f8800 {
>  			assigned-clock-rates = <19200000>, <200000000>;
>  
>  			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&intc GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
>  					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

