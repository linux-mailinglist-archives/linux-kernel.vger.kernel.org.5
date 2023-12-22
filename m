Return-Path: <linux-kernel+bounces-10002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D31AA81CE88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6881EB2359F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF112C1B8;
	Fri, 22 Dec 2023 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7cbdxb5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491C2C19C;
	Fri, 22 Dec 2023 18:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CA7C433C8;
	Fri, 22 Dec 2023 18:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703270682;
	bh=ozUHs3QOe8XBcLaaSmuuGkQ6lqNCmtsxOGBXK7THNAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7cbdxb57HVpz/FlHLUNsXvIHfpwOYqWgRMR1Jd/i9gvJFrsOTqDrV5jPCjc0xx8G
	 aUFqQ9DlF0dSC164Y6ujx/pGE6+qcuejtP9yTal50nH0R4/3v4exbpkIuCsaL/fbzf
	 V6sPAO2WK3Y6lCQOOWCwF14+ujC3BB3JReI/FnqPQIR66QL+up2W8I9GmpblzBWM1G
	 x3Jgc/LCLcVW7v3r7C7/lvBwt0gjwRyHf7M2wLYmjmb2B7jGhz5TvqKSUZj1yqxxcX
	 E91w+19JsoqYZJ/aZYSLdJAIXin5FjbPOv13SQFB1aybV3fMfXCBTttoq5/q1wdn2r
	 rlUfVV16fzv1Q==
Date: Fri, 22 Dec 2023 12:44:39 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: revert back to PSCI PC mode
 for herobrine
Message-ID: <gfddmbkzuomvxdm57vzf4ke37qbd6xki3dn7sdvyljegb4jqeq@d7cvsi5sniqx>
References: <20231221235010.3178415-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221235010.3178415-1-olvaffe@gmail.com>

On Thu, Dec 21, 2023 at 03:50:01PM -0800, Chia-I Wu wrote:

Thank you for your patch Chia-I.

> This effectively reverts 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add
> power-domains for cpuidle states") for sc7280-herobrine.  Those devices
> use the TF-A firmware and do not support the OSI mode.
> 

Please read the "Describe your changes" section at:
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Then flip the order around and start by describing the problem you're
seeing. Something like "Commit '7925ca85e9561 ("...")' transitioned all
SC7280 devices to PSCI OS initiated mode, which doesn't work on
TFA-based SC7280 devices. etc etc, technical description of solution..."

> v2: improved commit message

Please move this below the '---' line, so that it doesn't end up in the
git history...

Thank you,
Bjorn

> 
> Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for cpuidle states")
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  .../boot/dts/qcom/sc7280-firmware-tfa.dtsi    | 107 ++++++++++++++++++
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   4 +-
>  3 files changed, 110 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> new file mode 100644
> index 0000000000000..b3fc03da244d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +
> +/*
> + * Devices that use SC7280 with TrustedFirmware-A
> + * need PSCI PC mode instead of the OSI mode provided
> + * by Qualcomm firmware.
> + */
> +
> +&CPU0 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU1 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU2 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU3 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU4 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU5 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU6 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU7 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +/delete-node/ &domain_idle_states;
> +
> +&idle_states {
> +	CLUSTER_SLEEP_0: cluster-sleep-0 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "cluster-power-down";
> +		arm,psci-suspend-param = <0x40003444>;
> +		entry-latency-us = <3263>;
> +		exit-latency-us = <6562>;
> +		min-residency-us = <9926>;
> +		local-timer-stop;
> +	};
> +};
> +
> +/delete-node/ &CPU_PD0;
> +/delete-node/ &CPU_PD1;
> +/delete-node/ &CPU_PD2;
> +/delete-node/ &CPU_PD3;
> +/delete-node/ &CPU_PD4;
> +/delete-node/ &CPU_PD5;
> +/delete-node/ &CPU_PD6;
> +/delete-node/ &CPU_PD7;
> +/delete-node/ &CLUSTER_PD;
> +
> +&apps_rsc {
> +	/delete-property/ power-domains;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 9ea6636125ad9..09b2d370bf7e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -19,6 +19,7 @@
>  
>  #include "sc7280-qcard.dtsi"
>  #include "sc7280-chrome-common.dtsi"
> +#include "sc7280-firmware-tfa.dtsi"
>  
>  / {
>  	chosen {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 66f1eb83cca7e..354bf2868eba6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -383,7 +383,7 @@ core7 {
>  			};
>  		};
>  
> -		idle-states {
> +		idle_states: idle-states {
>  			entry-method = "psci";
>  
>  			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> @@ -427,7 +427,7 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
>  			};
>  		};
>  
> -		domain-idle-states {
> +		domain_idle_states: domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>  				compatible = "domain-idle-state";
>  				idle-state-name = "cluster-power-down";
> -- 
> 2.43.0.195.gebba966016-goog
> 

