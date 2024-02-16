Return-Path: <linux-kernel+bounces-69473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F517858A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCB3B21988
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6461487E7;
	Fri, 16 Feb 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/PeY6S6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04014831D;
	Fri, 16 Feb 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125552; cv=none; b=fPAfcFNKKjIpxCdLxiaqgAHn4mImNL+W+LxuOcaVh0sctpLvs+DNCVmNdl5WLU0bLUePIPQpmoa3+fBS80jCqLl34q490V3JR/fIrJQpdpUQXHgXKaXk7vxXsMtMdWsmIN/huwS2qB4tuUO8FV0vXwaPTYVhZN4FxSEz9x0vLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125552; c=relaxed/simple;
	bh=+KvE0drUw3hvWLoBjE4siZ4vTvDbpWgwBisR1y8afuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHt4MHyOGev+1Eo0d7FJzbduZHOwkUqps6jDsW39xaiL+tzzcnMP3blcU7w1vIJ8yYa/uTY0uFFvK59qufn1UzfrM9R5+NkLjp/sJmfpYB75gCj3Vz4jhC2atejjjP/FCKT324A9chX/FVdey9NOMDJx4IDFLipHmdN/XzGWVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/PeY6S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310C2C433F1;
	Fri, 16 Feb 2024 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125552;
	bh=+KvE0drUw3hvWLoBjE4siZ4vTvDbpWgwBisR1y8afuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/PeY6S6IIcOxma/cxPQzI+bi43pmO/0jOCBjSb+zaj4K7RurwpaR6Pp1GjtoDf9L
	 hlkrDHBEtuKfqON4KnbysdyNXEl1CJYP3vccTglbZIM23lr5KobR5m9+dE4PAruWOj
	 6QPv4evhtPrL+D+GiK+WjPKTRCsEvqoaw/FD/Lv/raCAmGcr02OEI3WkCmHqFRTTUE
	 6UqLnetRck+kiWgAzeO+YWYtfT5H0ROjnv6e+sxjHrKsdGrrBXBKwMOCo5wNmfQhmG
	 Iflt3x3eIJXF2LpuTvSsRVP0JTzn3pTYszdR99amQrgQx2E27lyk+o9Dl3P6CHKs6s
	 p7W7d3IzMTFRg==
Date: Fri, 16 Feb 2024 17:19:09 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-arm-sm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com, quic_cchiluve@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: add slimbus DT node
Message-ID: <wkbz5ska66c4kil67k4csqzm3anusskza7ysisaupfaqak3x77@wb3pqlngyzcd>
References: <20240215090910.30021-1-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215090910.30021-1-quic_vdadhani@quicinc.com>

On Thu, Feb 15, 2024 at 02:39:10PM +0530, Viken Dadhaniya wrote:

You've misspelled "linux-arm-msm" in the mailing list address, so this
was not in my review queue. Please switch to using b4 for preparing and
sending future patches, to avoid such mistakes.

Regards,
Bjorn

> Populate the DTSI node for slimbus instance to be
> used by bluetooth FM audio case.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
> v2 -> v3:
> - Fix patch title by adding "PATCH" string.
> - Update commit log.
> 
> v1 -> v2:
> - change 0x0 -> 0 to reg property.
> - reorder the DT property.
> - change node tag slim_msm to slim.
> ---
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 581818676a4c..1d6afde915aa 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2672,6 +2672,31 @@
>  			status = "disabled";
>  		};
>  
> +		slimbam: dma-controller@3a84000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0 0x03a84000 0 0x20000>;
> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,controlled-remotely;
> +			num-channels  = <31>;
> +			qcom,ee = <1>;
> +			qcom,num-ees = <2>;
> +			iommus = <&apps_smmu 0x1826 0x0>;
> +			status = "disabled";
> +		};
> +
> +		slim: slim-ngd@3ac0000 {
> +			compatible = "qcom,slim-ngd-v1.5.0";
> +			reg = <0 0x03ac0000 0 0x2c000>;
> +			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&slimbam 3>, <&slimbam 4>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x1826 0x0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		lpass_hm: clock-controller@3c00000 {
>  			compatible = "qcom,sc7280-lpasshm";
>  			reg = <0 0x03c00000 0 0x28>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 

