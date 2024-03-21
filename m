Return-Path: <linux-kernel+bounces-109688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37872881C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CBC1F216CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1153B1AA;
	Thu, 21 Mar 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BaT7GRUx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E88F5D;
	Thu, 21 Mar 2024 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001901; cv=none; b=Q6TbULpVAXruxdv+EnPXSO1A2AUITI0fp4LMtEjs/lr8f4d9auG75lu9PdUXVJAWBWCljjgYH4qg6XjtJhEha5efd8rrgsvqjDbCJeG8MeG3n8S1Pir5gFANie+v52R7WHEsTHRhKNtjL2IhiUMHcTXLxGgXy9NJc8rbRmn/fXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001901; c=relaxed/simple;
	bh=XSXIt31jQiBykLaW03iZWv8h6QXsO1YjuZosogxSYao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9QmETwSByVLSMSOrxCr7VQm9XT7AF91pNpeGfy6gzeZHlE4hIWkXCuZFlM85NeKN/Upm8SZ0ObCH6bYKdr/y5qirmhUJUKG226SCuJYIyPP2MJXLfUpn0k/j0u+cSi29J/nHu1Mapc2/fY32I9P8OosRioF3vtVNBcFeac+4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BaT7GRUx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L5klBu020353;
	Thu, 21 Mar 2024 06:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f8P1ipynu1dZUD0BRSHepKnCWVEzksvvO+gl57wVMwY=; b=Ba
	T7GRUxQ35cTfnVht39hWYena3UNSXm5czRZ785AmTzBd7fa7z8L12et4WKrJdGhF
	sgq1WEsq8XO1hRlIRtgh6jXG6HEPEb0e/5prlSVC9Y02AQP1A+epXz+KQglWJC0p
	VHPEGjOYKuT4Ml2WmRIsOsH8ARoATyglreBOMx4gv0cN8yksh5SEC8CHPg1YDR7s
	Mm/RvIN409snC9sov8IvLuVrput/YAINOnLzyi6Suy6YwX+GZQ83RmHtV5MobeAD
	F//mMuVTQkxA6s5HL+pLQ76v3MnETvLdsIorpSvqnVPsvbq2NOAOvc7VDk0boka2
	w6hihAxOS6aNL3pZznGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0f1ng22b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:18:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L6IFaM021426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 06:18:15 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 23:18:13 -0700
Message-ID: <6bbd4f08-a165-4e88-94e0-59e744431b3d@quicinc.com>
Date: Thu, 21 Mar 2024 11:47:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Update SNPS Phy parameters for
 QRD platform
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>
References: <20240319133527.25025-1-quic_ugoswami@quicinc.com>
Content-Language: en-US
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <20240319133527.25025-1-quic_ugoswami@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l3AWiTuXEtOhqPMlAYh_dr8_QuH9Uthj
X-Proofpoint-ORIG-GUID: l3AWiTuXEtOhqPMlAYh_dr8_QuH9Uthj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=881 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210040

Hi All,

On 3/19/2024 7:05 PM, Udipto Goswami wrote:
> Update SNPS Phy tuning parameters for sm8450 QRD platform to fix
> electrical compliance failures.
> 
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index c7d05945aa51..7b62ead68e77 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -467,6 +467,14 @@
>   	vdda-pll-supply = <&vreg_l5b_0p88>;
>   	vdda18-supply = <&vreg_l1c_1p8>;
>   	vdda33-supply = <&vreg_l2b_3p07>;
> +	qcom,squelch-detector-bp = <(-2090)>;
> +	qcom,hs-disconnect-bp = <1743>;
> +	qcom,pre-emphasis-amplitude-bp = <40000>;
> +	qcom,pre-emphasis-duration-bp = <20000>;
> +	qcom,hs-amplitude-bp = <2000>;
> +	qcom,hs-output-impedance-micro-ohms = <2600000>;
> +	qcom,hs-crossover-voltage-microvolt = <(-31000)>;
> +	qcom,hs-rise-fall-time-bp = <(-4100)>;
>   };
>   
>   &usb_1_qmpphy {

sender and cc list is wrong, please ignore this.
Will send it to the right recipients.

Thanks,
-Udipto

