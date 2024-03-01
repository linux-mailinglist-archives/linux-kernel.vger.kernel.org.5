Return-Path: <linux-kernel+bounces-88679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146786E52B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF24E1F25B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A870CD6;
	Fri,  1 Mar 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB/c1HKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5F6F514;
	Fri,  1 Mar 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310096; cv=none; b=HvmqEeCC5DZzcoPuScmNhIf/1xSzdTahQg5Hi6U+tdV8JS7tbDpkdXfyiOgzN5zVu1Vk+6ASSS/Snr+eazWoK3GYBvEmOOwyctxefSmqP2SJrLffxGb5pKcgv9ziz0Aj2WgILPNbXdW3OHQLwQDV3VfznsQTCVcQ2twNKka9AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310096; c=relaxed/simple;
	bh=avyjyGyF/VeFKLhHlTrCk38bYjiWeXUn6I458pAdN64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URgevWDybu0VVXiV+PZOEus2i48qLkYO0Ig+WH34GY5DkHdWwPz5qbGphAFx9d7/umfs6/99+Lsqs57oXO1N3MaJ54lqriCF/pLcGnWvtMwWzEwaXHL7usPA4p/tbh+OzcW6goHJOFSkPxJ+vq4B51qm326WU3rkGIxPQznl180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB/c1HKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA49C433C7;
	Fri,  1 Mar 2024 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709310096;
	bh=avyjyGyF/VeFKLhHlTrCk38bYjiWeXUn6I458pAdN64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JB/c1HKSJpQhaCL6td7M5tCKAtrfU9k213yUhsowltVubPh5SDfNbSm12TZVEylC9
	 FfK/EvWG1ZBCWGDzcadJxn8e/wqxbhpjZSWEcMlKQVmxReYzJlWzSj+r/yupr77wBc
	 D6qSP8tpHeh2REjLyFM9sHXiU/OEuMBLtZGM+I5ycanqw1eSPW2yJOfTMnsRzE+dGz
	 AmxynpDelSO3pq7gTYOtudIgHw/CWbLmEi0VyMsMa+XjjpVq+WzODTd4YBqxtpIDNO
	 axL7RZSL0RP0asrE1wfQudeKh8qoP7VxAxcl4deDrFDGGX43+nEutCHZDADvfAOi7c
	 fHvYwr8MIsevg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg5dr-000000002kJ-2SpG;
	Fri, 01 Mar 2024 17:21:48 +0100
Date: Fri, 1 Mar 2024 17:21:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZeIAm74PplfLVis3@hovoldconsulting.com>
References: <20240213082724.1789096-1-quic_kriskura@quicinc.com>
 <20240213082724.1789096-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213082724.1789096-2-quic_kriskura@quicinc.com>

On Tue, Feb 13, 2024 at 01:57:23PM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride

"interrupts" and "PHYs"

> platforms.

But I suggest you just reword this along the lines of

	Add USB DWC3 multiport controller.

as it's assumed that you'll describe resources like interrupts and PHYs.

Perhaps no need to mention SA8295p either as this change is needed (and
correct) also for sc8280xp proper.

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 82 ++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index febf28356ff8..29dbf2a9cdba 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3331,6 +3331,88 @@ system-cache-controller@9200000 {
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		usb_2: usb@a4f8800 {

> +			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 859 IRQ_TYPE_LEVEL_HIGH>,

> +					      <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,

These should all be IRQ_TYPE_EDGE_BOTH as DP/DM interrupts may need to
trigger also on falling edges.

> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "pwr_event_1", "pwr_event_2",
> +					  "pwr_event_3", "pwr_event_4",
> +					  "hs_phy_1",	 "hs_phy_2",
> +					  "hs_phy_3",	 "hs_phy_4",
> +					  "dp_hs_phy_1", "dm_hs_phy_1",
> +					  "dp_hs_phy_2", "dm_hs_phy_2",
> +					  "dp_hs_phy_3", "dm_hs_phy_3",
> +					  "dp_hs_phy_4", "dm_hs_phy_4",
> +					  "ss_phy_1",	 "ss_phy_2";

Johan

