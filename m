Return-Path: <linux-kernel+bounces-41422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3C83F0AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69361F25DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6211EB47;
	Sat, 27 Jan 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/q8Np7f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28871E86B;
	Sat, 27 Jan 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394592; cv=none; b=NaboI4jESvHhSIRGX96R34KE7Ako2jYQdc8NK3jZQbQlCgnKiWjdolfydG9Sjjjb1wBFLFrCI1PdZnNOh9HUhVOb6DgJpuvV+FUD/bbvMpzNj6sgVej1GR8W3uZMiPll4uO9MVzJ2PJ1H1UlyTI5r0fA1J+G205j8HnSX7TUr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394592; c=relaxed/simple;
	bh=iDQONVVSXY8ByWGgcnbg8EXM8f5kTgTJCLvawcFZRb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uECBEcoVeiPIY1bJAg30L+8+PlMO+orcFwcplqDGXn9rQIN+CuBV9Fw6slfKoHWZXR0vW2JCz1BvTMHQ1rc/QL2tuxewOAoyAHW2OOOWotupHbymuoim1xgW4B6k/wjSdLaZrD3bSbtf0JY2b/WlQlacq7CSBbF3CkM2DbK/4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/q8Np7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E2EC433F1;
	Sat, 27 Jan 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394591;
	bh=iDQONVVSXY8ByWGgcnbg8EXM8f5kTgTJCLvawcFZRb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/q8Np7ft1P3qO701VRObNR8yiMxVnlqiRdWhxvLOe3vmLkdqxCoefwtKW4bm4S07
	 6Xz4wdajP7Dpb1A9ZFY3/iaWOi5rBrIxjuZSLOdy6kJTG8/EyE/p1Ue65NemRIvJoS
	 Y7VPyy2FMFQsiv1fee3uJxdVGSGvNV2BcYn5eJYEvyMNHm80TOy5h9j4deHnLWku6E
	 a97nhwDgXCq2uk6/fqk6IyPElK0LGJ3uKLiwOsIK+kgBjNut7YVSyWjz3H7f9GS3Nm
	 z7YEaiP+q10CiRwtUozEoisu04hmc7vCjvVXiK4Nxf37seUbtQyz00kwTwpzqovjYd
	 2RhbiDz4Gp/aw==
Date: Sat, 27 Jan 2024 16:29:48 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Move video-firmware to
 chrome-common
Message-ID: <en2tmgles5xhtffxul7oiqxsut5xkn5w7w7u4h34ygkqrqnksy@sjfkp4tbi55e>
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
 <20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com>

On Fri, Dec 01, 2023 at 10:33:19AM +0100, Luca Weiss wrote:
> If the video-firmware node is present, the venus driver assumes we're on
> a system that doesn't use TZ for starting venus, like on ChromeOS
> devices.
> 
> Move the video-firmware node to chrome-common.dtsi so we can use venus
> on a non-ChromeOS devices. We also need to move the secure SID 0x2184
> for iommu since (on some boards) we cannot touch that.
> 
> At the same time also disable the venus node by default in the dtsi,
> like it's done on other SoCs.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  9 +++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 5d462ae14ba1..459ff877df54 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -104,6 +104,17 @@ &scm {
>  	dma-coherent;
>  };
>  
> +&venus {
> +	iommus = <&apps_smmu 0x2180 0x20>,
> +		 <&apps_smmu 0x2184 0x20>;
> +
> +	status = "okay";
> +
> +	video-firmware {
> +		iommus = <&apps_smmu 0x21a2 0x0>;
> +	};
> +};
> +
>  &watchdog {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 326897af117a..0ff9a2484096 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3836,10 +3836,11 @@ venus: video-codec@aa00000 {
>  					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
>  			interconnect-names = "cpu-cfg", "video-mem";
>  
> -			iommus = <&apps_smmu 0x2180 0x20>,
> -				 <&apps_smmu 0x2184 0x20>;
> +			iommus = <&apps_smmu 0x2180 0x20>;

qcom,sc7280-venus expects 2 items here. Please follow up with a patch to
the binding, if you haven't send one already.

Thanks,
Bjorn

>  			memory-region = <&video_mem>;
>  
> +			status = "disabled";
> +
>  			video-decoder {
>  				compatible = "venus-decoder";
>  			};
> @@ -3848,10 +3849,6 @@ video-encoder {
>  				compatible = "venus-encoder";
>  			};
>  
> -			video-firmware {
> -				iommus = <&apps_smmu 0x21a2 0x0>;
> -			};
> -
>  			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> 
> -- 
> 2.43.0
> 

