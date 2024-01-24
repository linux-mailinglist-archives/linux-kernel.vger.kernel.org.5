Return-Path: <linux-kernel+bounces-37710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4883B43E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A751F21EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF46135406;
	Wed, 24 Jan 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPPtqSum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D042A8E;
	Wed, 24 Jan 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132789; cv=none; b=M9J52RKm3Scn+UgqK3JHlSM1zoPU7xO5T25jKUad60ocF6shSrvMiLTu6AKdG4nhkOaf06g/0uEjihRH+FKZkvupqCYxJmvu8YN4jpZg5BJuh7bgumN631f+XaYUiyAow11xB7VRbP1Rz7VL6p5E+adfyOLSQO2jKTU+3L9k5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132789; c=relaxed/simple;
	bh=rM6xmLejxZB/WOggpRFjLpPZvfPUObjvKe5XzLbFxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC2hthVescAv+J4omp3Bk9FN/1kPjokiDkqewH8v/4s+lyjHty3aQ9PNNGLecoMN5GuJxcaZnwKg9BaR4cjgflwBIBdMYKcFoh+GMm9xQup6RqP5SRvWnLPs0J+dGLu4bOvySyGBoU0kW7IWMRajCR2t68JpeluT72nuB95sje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPPtqSum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C34C433F1;
	Wed, 24 Jan 2024 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132788;
	bh=rM6xmLejxZB/WOggpRFjLpPZvfPUObjvKe5XzLbFxYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPPtqSumktngzNTzqK6CM5viq3QM8pOsma4gP02ZWDiaSu10zbIjH3ILy0V2eE6vk
	 lZEWJ6Vgdy4HDLGs/obsiird/S5aUNGtYXNeNlWJQ0BV8zievtRwPz73xo/Dv4W0mU
	 EByQphIRodtWlH1PPyKTwqXWH7923DH5WT5yEF5C3clluqXGR0pLb9VHPJPRYjaCwN
	 cnmJDD4SH3DP4luLymRBinnrZqYHyq7b18m6C9se05Dl2W4o/8hEhyq2c5zTTImqmd
	 0MWsweP5j4OJ9Ks0HLxL/6bawwmerS9DbKlUSKvHyGy6TLsv4deod7imFGq6/ruM/W
	 2tnAODNAPO5Pw==
Date: Wed, 24 Jan 2024 15:46:24 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
Message-ID: <wqdqkzvni4roqulgsiqxzubxcblzxnoydcwvv2av2pobjjx5o6@b7kwl6lq7hij>
References: <20240120191904.15408-1-quic_kriskura@quicinc.com>
 <20240120191904.15408-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120191904.15408-2-quic_kriskura@quicinc.com>

On Sun, Jan 21, 2024 at 12:49:01AM +0530, Krishna Kurapati wrote:
> On several QUSB2 Targets, the hs_phy_irq mentioned is actually
> qusb2_phy interrupt specific to QUSB2 PHY's. Rename hs_phy_irq
> to qusb2_phy for such targets.
> 
> In actuality, the hs_phy_irq is also present in these targets, but
> kept in for debug purposes in hw test environments. This is not
> triggered by default and its functionality is mutually exclusive
> to that of qusb2_phy interrupt.
> 
> Add missing hs_phy_irq's, pwr_event irq's for QUSB2 PHY targets.
> Add missing ss_phy_irq on some targets which allows for remote
> wakeup to work on a Super Speed link.
> 
> Also modify order of interrupts in accordance to bindings update.
> Since driver looks up for interrupts by name and not by index, it
> is safe to modify order of these interrupts in the DT.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 13 +++++++++++++
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8953.dtsi |  7 +++++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi |  8 ++++++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi |  7 +++++--
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 17 +++++++++++++----
>  arch/arm64/boot/dts/qcom/sm6115.dtsi  |  9 +++++++--
>  arch/arm64/boot/dts/qcom/sm6125.dtsi  |  9 +++++++--
>  8 files changed, 70 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 5e1277fea725..ea70b57d1871 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -418,6 +418,12 @@ usb2: usb@70f8800 {
>  					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
>  			assigned-clock-rates = <133330000>,
>  					       <24000000>;
> +
> +			interrupts-extended = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,

interrupts-extended takes a reference to a interrupt-controller as well,
so this doesn't build.

Did you mean "interrupts" here instead? Please update these and build
test...

Regards,
Bjorn

