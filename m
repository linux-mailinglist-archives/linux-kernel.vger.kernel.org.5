Return-Path: <linux-kernel+bounces-87847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD6086D9EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4D2286B32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5840BE0;
	Fri,  1 Mar 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7ZHeWEU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD63FE5B;
	Fri,  1 Mar 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262018; cv=none; b=BC4rkBiwTogLC5LyThHsmFaTBR6p6ow0dQ2ojtedYTWFi2CEmrGON/G/GmKJl5P6k59YKQrNW5G5elvTH0cBsCyXZV22/vmInugqmPJy6dTBoTe5VcjZWPb9pEQ7gxE/lQFqlXO0uR7odjiwRFXDz2L8RSf3t2iStHiDC5p/hWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262018; c=relaxed/simple;
	bh=cy1flkHCEkyjQ+LrDNJLACLTv5jxDK8tRiGxgC/lIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6ud2Q5HjyIT+dmA9gWCBCV1MaJR5CidvSsQSA/iRTK0BSQ2ZZ4bWSFiUDDqYT5hQWLkmyYPMGKBniVCRSrrGOBAK++T7t3tF+MQOy+sbdEf5nqdREI+1HHuPPbCSCYX7YjQK3RfZLo8NEAEFtqOGJiONawIwA5oD3PRvlSAq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7ZHeWEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC3C433C7;
	Fri,  1 Mar 2024 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709262017;
	bh=cy1flkHCEkyjQ+LrDNJLACLTv5jxDK8tRiGxgC/lIvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7ZHeWEUc22dhyYG992U2xjzYmMHs507mtCLrQ/U9KDjLkZ+hSV8vl9YGB0ylZfVh
	 3MSyxrRp8U1sMFVT4jMG4/e2Fk53x0b2T4scH/wjG4r8uSBZRCEJ32Nwajrd91uIQm
	 qgii5nnOGaI4hg93i/Cu6NkMC180jRHtnkFbvsAoEZCmJJJuzkeWdvsou+3Nv0fhAC
	 H+MWkpRuk6sweWa818+AsoZXgFYjeUFtG+F1N4c9Lcy7x90VjCXJMeUzC93r1f3xvJ
	 /H+DUx/7LZ/hEhOphhAZwbXEltL6+Y1t7L7mUMgs0VHuLtFL97h8LTjfIo8TtqH6Nq
	 adQGRd7KG7SyQ==
Date: Thu, 29 Feb 2024 21:00:14 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 7/7] arm64: dts: qcom-mode-switch: allow 4 lanes for
 DisplayPort and enable QMP PHY mode-switch
Message-ID: <jfwskyt3wllpf33ceeibrodorsfmhctfulfkzpkgmjikzbr63n@f4llf7wcmyxi>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-7-07e24a231840@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-7-07e24a231840@linaro.org>

On Thu, Feb 29, 2024 at 02:07:07PM +0100, Neil Armstrong wrote:
> Allow up to 4 lanes for the DisplayPort link from the PHYs to the Controllers
> and allow mode-switch events to the QMP Combo PHYs.
> 

Please adjust $subject and commit message to suite the x13s.dts...


With this series I'm reaching 4k@60 on my X13s (with some difficulty due
to current hotplug issues in the DP driver) - but 4-lane DP works, and
so does 2-lane combo.

I tested switching between DP-only and a USB device, this worked fine a
few (3-4) times, after which the USB device stopped showing up. The DP
display continued to work nicely and the debug prints from the driver
indicates that we're moving back and forth between the modes...

The problems I had when trying to implement this previously, with the
device crashing on disconnect have not been seen, across 20+
attempts.

Regards,
Bjorn

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index a0fdef55a40a..6c73e0fc001f 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -556,7 +556,7 @@ &mdss0_dp0 {
>  };
>  
>  &mdss0_dp0_out {
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;
>  	remote-endpoint = <&usb_0_qmpphy_dp_in>;
>  };
>  
> @@ -565,7 +565,7 @@ &mdss0_dp1 {
>  };
>  
>  &mdss0_dp1_out {
> -	data-lanes = <0 1>;
> +	data-lanes = <0 1 2 3>;
>  	remote-endpoint = <&usb_1_qmpphy_dp_in>;
>  };
>  
> @@ -1112,6 +1112,7 @@ &usb_0_qmpphy {
>  	vdda-phy-supply = <&vreg_l9d>;
>  	vdda-pll-supply = <&vreg_l4d>;
>  
> +	mode-switch;
>  	orientation-switch;
>  
>  	status = "okay";
> @@ -1149,6 +1150,7 @@ &usb_1_qmpphy {
>  	vdda-phy-supply = <&vreg_l4b>;
>  	vdda-pll-supply = <&vreg_l3b>;
>  
> +	mode-switch;
>  	orientation-switch;
>  
>  	status = "okay";
> 
> -- 
> 2.34.1
> 

