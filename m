Return-Path: <linux-kernel+bounces-137217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BAE89DF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D901C21132
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7313C9CA;
	Tue,  9 Apr 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3zSK5SJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30212F367;
	Tue,  9 Apr 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676333; cv=none; b=d7hL8WmL0GXijOURg83+819LSX3cskog43ZtaYIBCgs/rOCyYEUJ9lGxwCy7+It5biqZjmYD0tWsIsTnddsKh3YhU0lKCBlbTzluHruZ6jiVWHotZ8wh2ivJ3LSWatIjPuI6XJLmFb/djepz8MEX49KFlENhSumXLSDZaFc/vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676333; c=relaxed/simple;
	bh=xkMdXfA590zFnkmRFUF8fT4qO4Xa0lPHjZzwaSSA/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv+BZcrNZgodxEwaT4KmNGZGr7ggmutffvxJKVqzeEF79dYkvN3DNpxFUXTQSv5bTH8XfQF2aq9/er3CFnqdmRXa+69MrfklYWpl12jjJIcsBKxwvnkwXJwC3tfuy5MJ3AdomvRIP8v5dS9FOFysUlwkED3vvF6iMJzVB+9jIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3zSK5SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7DEC43390;
	Tue,  9 Apr 2024 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676331;
	bh=xkMdXfA590zFnkmRFUF8fT4qO4Xa0lPHjZzwaSSA/5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3zSK5SJ9QuA33VEbDf0yFbofMeWSknh2WwFY2Od09HNW3Ilc0DhxDom1RJC1qHz/
	 MSWmigvbX/WDH1VNm4Fa3Kh4ATqzRQfA8vl9fNRpX3+ZSdABHCRekd2xovLeQyI3e7
	 0UIs6NNVUakdEUrK7AxiOLyIOI6R1mIFIwBbQzLfWZ+eJWy4LFsdmt8lHd0NN/isw+
	 jWRWxoYDA60mvHjDj/lf0q1rahoVkZI+cUKMKtmi3h60Z82/MdIzsPl7rh6U0GQXJN
	 SX2SdN71UQE1MXrenzYuw8pv7YvYub0c8bREYjoKWTfZ0Ae4q///EeyFVzo5kPjOZy
	 rKqtGXrXlsPog==
Date: Tue, 9 Apr 2024 10:25:28 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: msm8976: Add Adreno GPU
Message-ID: <b3tshs3ya6nqhf3ykaxnx56rnigbvqfzftpkolvqrxa2rhuzes@wtdu6yrat4qi>
References: <20240401172153.9231-1-a39.skl@gmail.com>
 <20240401172153.9231-4-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401172153.9231-4-a39.skl@gmail.com>

On Mon, Apr 01, 2024 at 07:21:52PM +0200, Adam Skladowski wrote:
> Add Adreno GPU node.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 65 +++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 6be310079f5b..77670fce9b8f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -1074,6 +1074,71 @@ mdss_dsi1_phy: phy@1a96a00 {
>  			};
>  		};
>  
> +		adreno_gpu: gpu@1c00000 {
> +			compatible = "qcom,adreno-510.0", "qcom,adreno";
> +
> +			reg = <0x01c00000 0x40000>;
> +			reg-names = "kgsl_3d0_reg_memory";
> +
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "kgsl_3d0_irq";
> +
> +			clocks = <&gcc GCC_GFX3D_OXILI_CLK>,
> +				 <&gcc GCC_GFX3D_OXILI_AHB_CLK>,
> +				 <&gcc GCC_GFX3D_OXILI_GMEM_CLK>,
> +				 <&gcc GCC_GFX3D_BIMC_CLK>,
> +				 <&gcc GCC_GFX3D_OXILI_TIMER_CLK>,
> +				 <&gcc GCC_GFX3D_OXILI_AON_CLK>;
> +			clock-names = "core",
> +				      "iface",
> +				      "mem",
> +				      "mem_iface",
> +				      "rbbmtimer",
> +				      "alwayson";
> +
> +			power-domains = <&gcc OXILI_GX_GDSC>;
> +
> +			iommus = <&gpu_iommu 0>;
> +
> +			status = "disabled";

Make status the last property of the node, please.

Regards,
Bjorn

> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +

