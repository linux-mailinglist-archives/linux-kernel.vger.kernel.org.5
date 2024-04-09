Return-Path: <linux-kernel+bounces-137197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64B89DEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBBF1C209FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AC132471;
	Tue,  9 Apr 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY5vri1P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE1131186;
	Tue,  9 Apr 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675767; cv=none; b=kTEDVhOiH7wCNk7H9BnNCcoIx7in3izCKhfMTF2TGdRYNTJxttoHG5wtrFF3zO9M4R3ZItDOks7fadVpZmHYY1xdar7fPIjP/goXboP3vzxdrfoTgriZu+wltJRjeJDmuoty/xtNfdOszoRU3dOkv4SFJLCizh6K/5Ir6RQgj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675767; c=relaxed/simple;
	bh=f3myWZI4RqR1eBwp9J9jlZSj1zDzazJbrPRoFoBWj9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMFvNoHbWpJfiSkTHnKkrF0SMxRXDxto4iBzvbK6lZvUesCQYCIM8/Z5sxKwZvfS0NdwaSe6Orz2r1YnS32Qhww9cj823tVZobXMsbsxBWX+gvcHqDih3yHYNEn84B50uxzwj3UIJMCucsBLdQnxnRa6h8jiJIlwuJ/DIqtd8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY5vri1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3F9C433C7;
	Tue,  9 Apr 2024 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675767;
	bh=f3myWZI4RqR1eBwp9J9jlZSj1zDzazJbrPRoFoBWj9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GY5vri1POnG4dP9ifDGnuvqZEWFXPbP+b+tVYk9ILnJAkstOdbTyKEgujA4/V5Wf+
	 MD0bzfq5+08WKAFvw6hCjMQpNmL+kw+PongcjAsDpXI3squxX/3iFE51gwq5cDL1yk
	 JIHUdmcIq6H5K8i7lxLYe0jKnlppUVhxhSieU/G9K+qXFGDHkKGR2DEg75lRjPJm/T
	 T26DtH6rOd/OtwaLp1KCQfONsHtI+wqcNRNlHcQJ3bKUZruW1CO3iwmTjpWA1PdYxh
	 C/N7m1GtW1cvSg2zkFXOs2/wtu9YMox/jpviYAoFcOmta16sLYa1VzjXM+VDrMUwYy
	 AvZt22fMPPwjg==
Date: Tue, 9 Apr 2024 10:16:04 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Umang Chheda <quic_uchheda@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcm6490-idp: Name the regulators
Message-ID: <fn3difeklzlfhherqqpb3ktwyazvaedhqm635umfjnwyuwasix@sdipvwselp7j>
References: <20240403132945.2117890-1-quic_uchheda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403132945.2117890-1-quic_uchheda@quicinc.com>

On Wed, Apr 03, 2024 at 06:59:45PM +0530, Umang Chheda wrote:
> Without explicitly specifying names for the regulators they are named
> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making it impossible to reason debug prints and
> regulator_summary.
> 

Why is this marked "RESEND"? I can only find [1].

But you received review feedback on that one, which you have addressed,
which means that this is a new version of the patch - as such this
should be "[PATCH v2] ...".

[1] https://lore.kernel.org/all/20240329122940.3649730-1-quic_uchheda@quicinc.com/

> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
> ---

And here you can write things that won't be picked up in the git
history, such as the reason for sending the patch, or what changed since
v1.


Please look at go/upstream, adopt b4 for preparing your patches, use
--force-revision to send me v3 - where you clarify the changes between
v1 and v2 (this resend).

You can specify "Resubmit as v3 to clarify history of patch" or
something like that for the v3 changes. 


Change itself looks good, thank you.

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index f8f8a43f638d..ac6d741868ca 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -195,129 +195,151 @@ regulators-0 {
>  		vdd-l14-l16-supply = <&vreg_s8b_1p272>;
>  
>  		vreg_s1b_1p872: smps1 {
> +			regulator-name = "vreg_s1b_1p872";
>  			regulator-min-microvolt = <1840000>;
>  			regulator-max-microvolt = <2040000>;
>  		};
>  
>  		vreg_s2b_0p876: smps2 {
> +			regulator-name = "vreg_s2b_0p876";
>  			regulator-min-microvolt = <570070>;
>  			regulator-max-microvolt = <1050000>;
>  		};
>  
>  		vreg_s7b_0p972: smps7 {
> +			regulator-name = "vreg_s7b_0p972";
>  			regulator-min-microvolt = <535000>;
>  			regulator-max-microvolt = <1120000>;
>  		};
>  
>  		vreg_s8b_1p272: smps8 {
> +			regulator-name = "vreg_s8b_1p272";
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1500000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
>  		};
>  
>  		vreg_l1b_0p912: ldo1 {
> +			regulator-name = "vreg_l1b_0p912";
>  			regulator-min-microvolt = <825000>;
>  			regulator-max-microvolt = <925000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l2b_3p072: ldo2 {
> +			regulator-name = "vreg_l2b_3p072";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l3b_0p504: ldo3 {
> +			regulator-name = "vreg_l3b_0p504";
>  			regulator-min-microvolt = <312000>;
>  			regulator-max-microvolt = <910000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4b_0p752: ldo4 {
> +			regulator-name = "vreg_l4b_0p752";
>  			regulator-min-microvolt = <752000>;
>  			regulator-max-microvolt = <820000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		reg_l5b_0p752: ldo5 {
> +			regulator-name = "reg_l5b_0p752";
>  			regulator-min-microvolt = <552000>;
>  			regulator-max-microvolt = <832000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6b_1p2: ldo6 {
> +			regulator-name = "vreg_l6b_1p2";
>  			regulator-min-microvolt = <1140000>;
>  			regulator-max-microvolt = <1260000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7b_2p952: ldo7 {
> +			regulator-name = "vreg_l7b_2p952";
>  			regulator-min-microvolt = <2400000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l8b_0p904: ldo8 {
> +			regulator-name = "vreg_l8b_0p904";
>  			regulator-min-microvolt = <870000>;
>  			regulator-max-microvolt = <970000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9b_1p2: ldo9 {
> +			regulator-name = "vreg_l9b_1p2";
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1304000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l11b_1p504: ldo11 {
> +			regulator-name = "vreg_l11b_1p504";
>  			regulator-min-microvolt = <1504000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12b_0p751: ldo12 {
> +			regulator-name = "vreg_l12b_0p751";
>  			regulator-min-microvolt = <751000>;
>  			regulator-max-microvolt = <824000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13b_0p53: ldo13 {
> +			regulator-name = "vreg_l13b_0p53";
>  			regulator-min-microvolt = <530000>;
>  			regulator-max-microvolt = <824000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l14b_1p08: ldo14 {
> +			regulator-name = "vreg_l14b_1p08";
>  			regulator-min-microvolt = <1080000>;
>  			regulator-max-microvolt = <1304000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l15b_0p765: ldo15 {
> +			regulator-name = "vreg_l15b_0p765";
>  			regulator-min-microvolt = <765000>;
>  			regulator-max-microvolt = <1020000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l16b_1p1: ldo16 {
> +			regulator-name = "vreg_l16b_1p1";
>  			regulator-min-microvolt = <1100000>;
>  			regulator-max-microvolt = <1300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l17b_1p7: ldo17 {
> +			regulator-name = "vreg_l17b_1p7";
>  			regulator-min-microvolt = <1700000>;
>  			regulator-max-microvolt = <1900000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l18b_1p8: ldo18 {
> +			regulator-name = "vreg_l18b_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l19b_1p8: ldo19 {
> +			regulator-name = "vreg_l19b_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> @@ -349,109 +371,128 @@ regulators-1 {
>  		vdd-bob-supply = <&vph_pwr>;
>  
>  		vreg_s1c_2p19: smps1 {
> +			regulator-name = "vreg_s1c_2p19";
>  			regulator-min-microvolt = <2190000>;
>  			regulator-max-microvolt = <2210000>;
>  		};
>  
>  		vreg_s2c_0p752: smps2 {
> +			regulator-name = "vreg_s2c_0p752";
>  			regulator-min-microvolt = <750000>;
>  			regulator-max-microvolt = <800000>;
>  		};
>  
>  		vreg_s5c_0p752: smps5 {
> +			regulator-name = "vreg_s5c_0p752";
>  			regulator-min-microvolt = <465000>;
>  			regulator-max-microvolt = <1050000>;
>  		};
>  
>  		vreg_s7c_0p752: smps7 {
> +			regulator-name = "vreg_s7c_0p752";
>  			regulator-min-microvolt = <465000>;
>  			regulator-max-microvolt = <800000>;
>  		};
>  
>  		vreg_s9c_1p084: smps9 {
> +			regulator-name = "vreg_s9c_1p084";
>  			regulator-min-microvolt = <1010000>;
>  			regulator-max-microvolt = <1170000>;
>  		};
>  
>  		vreg_l1c_1p8: ldo1 {
> +			regulator-name = "vreg_l1c_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <1980000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l2c_1p62: ldo2 {
> +			regulator-name = "vreg_l2c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <1980000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l3c_2p8: ldo3 {
> +			regulator-name = "vreg_l3c_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <3540000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4c_1p62: ldo4 {
> +			regulator-name = "vreg_l4c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <3300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l5c_1p62: ldo5 {
> +			regulator-name = "vreg_l5c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <3300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6c_2p96: ldo6 {
> +			regulator-name = "vreg_l6c_2p96";
>  			regulator-min-microvolt = <1650000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7c_3p0: ldo7 {
> +			regulator-name = "vreg_l7c_3p0";
>  			regulator-min-microvolt = <3000000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l8c_1p62: ldo8 {
> +			regulator-name = "vreg_l8c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9c_2p96: ldo9 {
> +			regulator-name = "vreg_l9c_2p96";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <35440000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l10c_0p88: ldo10 {
> +			regulator-name = "vreg_l10c_0p88";
>  			regulator-min-microvolt = <720000>;
>  			regulator-max-microvolt = <1050000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l11c_2p8: ldo11 {
> +			regulator-name = "vreg_l11c_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12c_1p65: ldo12 {
> +			regulator-name = "vreg_l12c_1p65";
>  			regulator-min-microvolt = <1650000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13c_2p7: ldo13 {
> +			regulator-name = "vreg_l13c_2p7";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_bob_3p296: bob {
> +			regulator-name = "vreg_bob_3p296";
>  			regulator-min-microvolt = <3008000>;
>  			regulator-max-microvolt = <3960000>;
>  		};
> -- 
> 2.25.1
> 

