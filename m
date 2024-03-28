Return-Path: <linux-kernel+bounces-122338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DF88F561
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959321F2CAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02428DBF;
	Thu, 28 Mar 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXHc8PNx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D374D2;
	Thu, 28 Mar 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592946; cv=none; b=TmeOSGlGicvVC7jc4IYOf2xZNbmGTebeIYvTXAprW2klhrR4vA6oNgz36xNE1NVJ3ryE1DCdf8yMiCQIJTfGabGj59cyy/pvTbD5MMVknu2S5z7BPevPxSuAwbylvZSZzrLIKbB8qQcLduYSNIwunIFTs8VwCyf+M8m7X4JkN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592946; c=relaxed/simple;
	bh=rHtUyom4X7jUcKQsE0lSv2b4fCRidQ44ktbNU1WEOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX+Z7Iq0quIAaTMWAhCB7FgNzaQ2KOlZd5R2fqUaulPM4meyj/Bat5iZu1n+1ZaCGSpc9cftT7glrc/MA8XlMsQprYmiu6eah46GauosrAdxAfLDQmX1mriaep7LRBUZaotCF1sMY8F/0cXPkKLM31LxmM61N7kBNaA0gp1h/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXHc8PNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB5FC433F1;
	Thu, 28 Mar 2024 02:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711592946;
	bh=rHtUyom4X7jUcKQsE0lSv2b4fCRidQ44ktbNU1WEOlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXHc8PNx6iNLSZNvfMq4guVnP1fINDyusRbqdOYJsoz9DstfsEfi/s8yCIwfWtuBj
	 Si6aizraugxnkHgi+FuxUgfAaPbjCKqSbdqtgzhcIsWK+yqZbR5gSRsp9a89LorGyl
	 z2CCS/mnyh9gifYnqx/vG9pndtekE29ZCxIRveRw759rlnvuoomB5wKklbQp85/yA6
	 90p+HA2g5tWgJw+Q+Jbdi4jcFgRPARJqRT8mQThqOLtsHwEBjT+mgV965JWBGdSr4Y
	 eaMMiEfNUIEPEl1zR2Bv3xaJQPxZ+werBi4i0mxJF86rF7F4QAN56C7YkP+HHzXBPr
	 mHBdZ0aCOOq8w==
Date: Wed, 27 Mar 2024 21:29:03 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary
 USB controller
Message-ID: <g2zfjcidsmaybwd6dzsrhcour2qxklv4r35d3va7txdk6lwfi3@sw2sslg4jnqi>
References: <20240328022224.336938-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328022224.336938-1-luzmaximilian@gmail.com>

On Thu, Mar 28, 2024 at 03:21:57AM +0100, Maximilian Luz wrote:
> The ACPI DSDT of the Surface Pro X (SQ2) specifies the interrupts for
> the secondary UBS controller as
> 
>     Name (_CRS, ResourceTemplate ()
>     {
>         Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
>         {
>             0x000000AA,
>         }
>         Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, )
>         {
>             0x000000A7,     // hs_phy_irq: &intc GIC_SPI 136
>         }
>         Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, )
>         {
>             0x00000228,     // ss_phy_irq: &pdc 40
>         }
>         Interrupt (ResourceConsumer, Edge, ActiveHigh, SharedAndWake, ,, )
>         {
>             0x0000020A,     // dm_hs_phy_irq: &pdc 10
>         }
>         Interrupt (ResourceConsumer, Edge, ActiveHigh, SharedAndWake, ,, )
>         {
>             0x0000020B,     // dp_hs_phy_irq: &pdc 11
>         }
>     })
> 
> Generally, the interrupts above 0x200 map to the PDC interrupts (as used
> in the devicetree) as ACPI_NUMBER - 0x200. Note that this lines up with
> dm_hs_phy_irq and dp_hs_phy_irq (as well as the interrupts for the
> primary USB controller).
> 
> Based on the snippet above, ss_phy_irq should therefore be PDC 40 (=
> 0x28) and not PDC 7. The latter is according to ACPI instead used as
> ss_phy_irq for port 0 of the multiport USB controller). Fix this by
> setting ss_phy_irq to '&pdc 40'.
> 
> Fixes: b080f53a8f44 ("arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> index 32afc78d5b769..053f7861c3cec 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> @@ -2701,7 +2701,7 @@ usb_sec: usb@a8f8800 {
>  			resets = <&gcc GCC_USB30_SEC_BCR>;
>  			power-domains = <&gcc USB30_SEC_GDSC>;
>  			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&pdc 7 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 40 IRQ_TYPE_LEVEL_HIGH>,
>  					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
> -- 
> 2.44.0
> 

