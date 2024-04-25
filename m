Return-Path: <linux-kernel+bounces-159356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C98B2D86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF1F22CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5A15666F;
	Thu, 25 Apr 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vu9PR72t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15A15664A;
	Thu, 25 Apr 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087265; cv=none; b=LSmvEdLySDOe9EnRqfRUxxLr4jl0UL6bzQJ5MY8WQkcTDVOsXakTunCEHQyvjmkmHabqXmfa3JT4nZqVRUW/7wZNWXFWKigOy+I3dNCv1dxNIfq2j9Va5P7G0V6La89b1Ap/lFv3X6rDcnlX7Mfx1ox2Jp1GpaQPrHTcSEtpLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087265; c=relaxed/simple;
	bh=pFLOWFAKLZl326kN1M3nfbqivRN7E2erUMVpSWctlPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCvMcN8+8pEnuM4uXVCCupYqL361uHQL028HV882VtFntpPjznVe0fsLSFG5SGLUeLLSmLVvnbXG/UMJWduhBWsmbDKSHOIq0xhHOSXXJb1siF426kBcadT85dXCOlknOhBYhFjfvm3HzvmISfSFK+wEdc+gkItHdyMBH27Gbig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vu9PR72t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PN3jcJ025178;
	Thu, 25 Apr 2024 23:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z3/6zU11FTdUX6G1mY0fYoZwfDYlLT+dxZNI6+urIMI=; b=Vu
	9PR72th1kbrclW8KWDktYPQTRUQzTdMXlGraqCCzVqUOAMKuQeALSLAe2XMAOlhb
	ZN30oC193axfnABF3t4XLvPer9tv4J//Rw0ISSJXM1AHEcl/PI6z/GQqUTekLGox
	CEWv7rnyf1YlHTdxnj6DcgebT7gK030Ea3SohMozneqsuv7FCsPMuFwXAW88FBy1
	SeW6+AYckv6/2HYwtppOlKuSvO/eN4QP5z4uZVJkZI8qBDDFgLc7RaD6bUJxvam8
	blUSnv3MkDA/dCFlpPU7SFxZqSLdqIdeQxpkKkM/VxJNuT5P98W22Ch+NW+nbEik
	WgAwnMTZDpNtnJsc0KUw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh3wcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:20:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PNKxde028896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 23:20:59 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 16:20:55 -0700
Message-ID: <c5329e9a-6947-4070-a24b-8985724b9981@quicinc.com>
Date: Thu, 25 Apr 2024 16:20:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: mark ethernet devices as
 DMA-coherent
Content-Language: en-US
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240425-mark_ethernet_devices_dma_coherent-v1-1-ad0755044e26@quicinc.com>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240425-mark_ethernet_devices_dma_coherent-v1-1-ad0755044e26@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5tN3PmuJ0LIL42exdfcKXM6qZdzo9NLR
X-Proofpoint-GUID: 5tN3PmuJ0LIL42exdfcKXM6qZdzo9NLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=758 bulkscore=0 clxscore=1011 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250171



On 4/25/2024 4:07 PM, Sagar Cheluvegowda wrote:
> Ethernet devices are cache coherent, mark it as such in the dtsi.
> 
> Change-Id: Id180fae617f2e348c0a80c6664b131cc57fcb4d6
Remove internal change id. 
Not required for upstreaming any changes. 
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 231cea1f0fa8..5ab4ca978837 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -2504,6 +2504,7 @@ ethernet1: ethernet@23000000 {
>  			phy-names = "serdes";
>  
>  			iommus = <&apps_smmu 0x140 0xf>;
> +			dma-coherent;
>  
>  			snps,tso;
>  			snps,pbl = <32>;
> @@ -2538,6 +2539,7 @@ ethernet0: ethernet@23040000 {
>  			phy-names = "serdes";
>  
>  			iommus = <&apps_smmu 0x120 0xf>;
> +			dma-coherent;
>  
>  			snps,tso;
>  			snps,pbl = <32>;
> 
> ---
> base-commit: a93289b830ce783955b22fbe5d1274a464c05acf
> change-id: 20240425-mark_ethernet_devices_dma_coherent-6c6154b84165
> 
> Best regards,

