Return-Path: <linux-kernel+bounces-6339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2A819771
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8310C1F25ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA0BE5E;
	Wed, 20 Dec 2023 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hgY1pU0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D0BE5B;
	Wed, 20 Dec 2023 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK1T3c9015055;
	Wed, 20 Dec 2023 03:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=m6SgXRhJwFhAQ6dv55GNTd9UQkjE3XpPXZe3APKf5F0=; b=hg
	Y1pU0k9iBQEm0Xy9TOm3m6gXii8sSIkjtddyWgqcqAbd7a4eDGTbXsbSRr/Abe/z
	JVxpjTFuE5LGuoWljxmzOpVx3+ICVDl2z+WtSAQiiFxKi9ZeJmsjP4VRYNUnfU4e
	h9BjLrMI7cyCLzmTyv/C3hCdgllaTzlE9stDqIdr3NmwicuywIHj24SGQcN0KjF7
	Rz+xqzaHvjp5w5hFV2OQnfh1WgL6TZ8epn9jfC27d/z15wDRwgM4T+PnSmTc18Ho
	d669Ous9UHoC2pOiuuoYcNstRSzOVBdBAvuRpUAv9PSTOgkujIzUhvr6aeLbhUNH
	jFvGu7W/y9PCVXhuU4og==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3h4w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 03:56:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK3uFk4028816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 03:56:15 GMT
Received: from [10.253.12.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 19:56:11 -0800
Message-ID: <24dcff81-7b19-4301-a69f-1242c1a352b6@quicinc.com>
Date: Wed, 20 Dec 2023 11:56:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] arm64: dts: qcom: sm8550: Fix UFS PHY clocks
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
 <20231218120712.16438-17-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231218120712.16438-17-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LEg498F1SXOE7mQ0_qfpKh5KE5Nak2I5
X-Proofpoint-ORIG-GUID: LEg498F1SXOE7mQ0_qfpKh5KE5Nak2I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=830 impostorscore=0
 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200023



On 12/18/2023 8:07 PM, Manivannan Sadhasivam wrote:
> QMP PHY used in SM8550 requires 3 clocks:
> 
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from TCSR
> 
> Fixes: 35cf1aaab169 ("arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index baa8540868a4..386ffd0d72c4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1891,9 +1891,12 @@ crypto: crypto@1dfa000 {
>   		ufs_mem_phy: phy@1d80000 {
>   			compatible = "qcom,sm8550-qmp-ufs-phy";
>   			reg = <0x0 0x01d80000 0x0 0x2000>;
> -			clocks = <&tcsr TCSR_UFS_CLKREF_EN>,
> -				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> -			clock-names = "ref", "ref_aux";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsr TCSR_UFS_CLKREF_EN>;
> +			clock-names = "ref",
> +				      "ref_aux",
> +				      "qref";
>   
>   			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
>   
Reviewed-by: Can Guo <quic_cang@quicinc.com>

