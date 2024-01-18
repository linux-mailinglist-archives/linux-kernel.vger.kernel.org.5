Return-Path: <linux-kernel+bounces-30281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B960D831C89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712601F2B73C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB322CCCF;
	Thu, 18 Jan 2024 15:26:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6720B07;
	Thu, 18 Jan 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591567; cv=none; b=Ww97mgFeqQqIJQT4iAebLFV6zDxuOo7m7BZk9yU1nsyrz6VKAqRRZAogtoxRVAw+Y/7tQzIIT0Te/lOzIHSKiR4lkiiQO2N6ub+FHa2hiPCEcHXG70Zanz/nm1KMHIbGyE8nU5Tss7dbBuOXr3l9nuy871gBNvHCmAbovkOw3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591567; c=relaxed/simple;
	bh=teWr3T/sOpLVOh0m3YVr1k4i9zBYM41sFiIiPRFCE1U=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=IluMGtBRT5y7CcrN7mpRKTna7a6LPPoprrRbhzoXLn/+NoGMgBQAxuTESvRY57TTBRnNrBJdNErvGgihfm9C+qbuv8/EBESxmkOOZbHgXJjkLuxiOTgRjZVPIKItURGThI81/KROPQLU0FDD2ZAghwNhjBCOeCwXUc6Cvook9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD5E1042;
	Thu, 18 Jan 2024 07:26:49 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490673F73F;
	Thu, 18 Jan 2024 07:26:01 -0800 (PST)
Date: Thu, 18 Jan 2024 15:25:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <cristian.marussi@arm.com>, <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <konrad.dybcio@linaro.org>,
	<jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	<conor+dt@kernel.org>
Subject: Re: [RFC 6/7] arm64: dts: qcom: x1e80100: Enable cpufreq
Message-ID: <ZalDBWwOhD3Gy1Mb@bogus>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-7-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-7-quic_sibis@quicinc.com>

(Generic note: It is middle of merge window and I have seen multiple
series posted by you. Since I am mainly looking for bug fixes only ATM,
I may miss to look at few. You may have to ping or repost after the merge
window, just responding to this for now as it caught my attention)

On Wed, Jan 17, 2024 at 11:04:57PM +0530, Sibi Sankar wrote:
> Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index afdbd27f8346..6856a206f7fc 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -62,6 +62,7 @@ CPU0: cpu@0 {
>  			compatible = "qcom,oryon";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;

I would use genpd bindings Ulf added recently. The reason I ask is I remember
one of the Qcom platform had both clocks and qcom,freq-domain and each one
served different purpose with latter one being used for cpufreq. So will
that be an issue here ?

-- 
Regards,
Sudeep

