Return-Path: <linux-kernel+bounces-127825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A189517B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CC21C2319A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E25D626A0;
	Tue,  2 Apr 2024 11:10:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BEE59176;
	Tue,  2 Apr 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056205; cv=none; b=fCytmf6ZaBnEECZg4HLBXymatwC9bEI5V/oIVFcWNEtE2GhTiTeUl4+/or6p2c2nzHaoE6aGW9G6odYsmTpwk8HSmaKcaA9fli4cXSy6ZE06vXcnGX8ObpWY4MOilhe/xTvaEtxvRfGic4XggusnsdImliyTKL/MeuQO86/zrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056205; c=relaxed/simple;
	bh=4ZBPmkQjIatLE1GDGNdFvrhnCif2h0CoGIHWile2u0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvam0uO6pkKaJbbBSX70zozxR5Xrbli8vKpe6UCRSBiKMtQhtZ4zzuyCLzYcAz6XxpOGAlLzsljH7pYPdFxJmxWIZf9JlN1w/YvmisFw4U+iaxNDWulOhOOMmNTjD1SPcTCSE51a5XHSY0mGVoymsprpo6rw8l2U5V27MoTw5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E066FEC;
	Tue,  2 Apr 2024 04:10:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7B43F766;
	Tue,  2 Apr 2024 04:10:01 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:09:59 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
	<quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
	<quic_gkohli@quicinc.com>, <quic_nkela@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, <quic_psodagud@quicinc.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
Message-ID: <Zgvnh0J2a_fBH0bR@bogus>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-6-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328095044.2926125-6-quic_sibis@quicinc.com>

On Thu, Mar 28, 2024 at 03:20:44PM +0530, Sibi Sankar wrote:
> Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 4e0ec859ed61..d1d232cd1f25 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -68,6 +68,7 @@ CPU0: cpu@0 {
>  			compatible = "qcom,oryon";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;
>  			next-level-cache = <&L2_0>;
>  			power-domains = <&CPU_PD0>;
>  			power-domain-names = "psci";


Any reason why you wouldn't want to use the new genpd based perf controls.
IIRC it was added based on mainly Qcom platform requirements.

-                     clocks = <&scmi_dvfs 0>;
		      next-level-cache = <&L2_0>;
-  		      power-domains = <&CPU_PD0>;
-  		      power-domain-names = "psci";
+                     power-domains = <&CPU_PD0>, <&scmi_dvfs 0>;
+                     power-domain-names = "psci", "perf";


And the associated changes in the scmi dvfs node for cells property.

This change is OK but just wanted to check the reasoning for the choice.

--
Regards,
Sudeep

