Return-Path: <linux-kernel+bounces-149226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8408A8D59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F11C21E45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA7D4C600;
	Wed, 17 Apr 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mU84SjDK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1B74AEE6;
	Wed, 17 Apr 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387410; cv=none; b=uLyfAyPcxdRGHSokPtjAg+3whhL9Qob6dJNVo5DRXfVxu5SVfAi3/RiwJn5UPZPNHycBeDb/qqrJ2Dg6NthWd1AYRhYZ5ZyX+z7SUTNmLZ/3sNGRoJoVMzYNJoPTFfxqnSt1FRM7O5obWTJsYLBRz5fP9rABBQQIqR27O7UgdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387410; c=relaxed/simple;
	bh=uBroaOcNwptlw/wRzMzeHBNX0ZYdVGKGFyjpYDa/wwY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXUdqjPXyaSq6Ydbjk4xW7zDyHUcfpQmUBux7bi6FONd9XUwr5BskTcmafutaTgYp+gUtr+A1/y5qU2wcG0MClyVaDg3vmqkW1jlMpfYiQND++8pQGCwpNdWCCKpijYJg0g7dAAmgbEQ5lHGaz/8e+59a3EwGNie/NN35WtqnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mU84SjDK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H777mJ006420;
	Wed, 17 Apr 2024 20:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=j3rD2swBZuMDhMJX740s1
	CxFEKcxK850H2X23s0H9u4=; b=mU84SjDK7NDXdc8AeyqXjCpANQC/+qlT8jf/A
	L3x9ce+sSoiekHx4pjLlNyW03KjQszAD2G/gblaHP50kQ+5k+/pLvhsr2RRMTPX9
	8z5bp715MnRxgkvccuGPIxvzroQVeG21ynr0esrvlmR1/XxCYdelitp+LfrkpTwd
	EvDzI7f8rQ4WLfzzmmXYkXqIY2IvUeOPfyATY/tgaC65FWdO7TFl3RXtmNHE87vH
	jyA+0ZGGKoj+IVbQxqJqnFc58puG1GWoGzboLrLyhWUSHGmPf4EtH9GHkZGOT+Uw
	Z+fzZDWsuY/1GMRsbuFfDoPdlWYO51U/QeeA+aPkSyx3hrYoQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9rma60m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:56:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HKuWRX006246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:56:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 13:56:32 -0700
Date: Wed, 17 Apr 2024 13:56:31 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: Re: [PATCH V3 3/5] arm64: dts: qcom: x1e80100: Resize GIC
 Redistributor register region
Message-ID: <ZiA3f58OWfe5xf1f@hu-bjorande-lv.qualcomm.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417132856.1106250-4-quic_sibis@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KQcvb4eADSXPM-yQlmYmAwk-n0Xq9o6D
X-Proofpoint-GUID: KQcvb4eADSXPM-yQlmYmAwk-n0Xq9o6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=749 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170148

On Wed, Apr 17, 2024 at 06:58:54PM +0530, Sibi Sankar wrote:
> Resize the GICR register region as it currently seeps into the CPU Control
> Processor mailbox RX region.
> 

Not that anyone is running a stable kernel here, but please make a habit
of adding Fixes: tags when correcting previous mistakes.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Pickup Rb from Dimitry.
> 
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index f5a3b39ae70e..28f65296781d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4949,7 +4949,7 @@ apps_smmu: iommu@15000000 {
>  		intc: interrupt-controller@17000000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0 0x17000000 0 0x10000>,     /* GICD */
> -			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
> +			      <0 0x17080000 0 0x380000>;    /* GICR * 12 */
>  

The 12th GICR ends a bit before that, and per your commit message you're
just nudging it down to get this range out of the say of your other
range - rather than giving it a proper value.

Wouldn't 0x300000 be a better value here? Or am I perhaps missing
something in the difference? If so, I'd like the commit message to state
what, so someone doesn't get excited and correct/break it later.

Regards,
Bjorn

>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  
> -- 
> 2.34.1
> 

