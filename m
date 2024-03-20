Return-Path: <linux-kernel+bounces-109287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FC88172A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336DD281BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9F6BFC1;
	Wed, 20 Mar 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GwsmVKUy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBD6A8C5;
	Wed, 20 Mar 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958035; cv=none; b=gepIXHiyQul4TWbneWSOGn85usDNW5viJuG01i++OgyHBql6e2CrRLiksi4L9b8NH58heEok65Pp2TCHQFL0eo1WG02JiiReoWgd4XOG/jVokuOv81BSTem6yM+MzJW8mM7lo+am6P7Lo4+wBG8gjoCQQkRbO25GuFj4RUhZCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958035; c=relaxed/simple;
	bh=x6f/dtZgNhfjcmwPU/NJ1nnNGzOLuuGjWr3KuNwZvJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjRWBMD6CMYXTjDm9FR39jkxeOj9oPYLK84AhV+KzHp74gQ0kgb2GY8rcLAc4VKH9SL89jT03BSHi9oXSOXm8KGTsS2VmcpwAyO3ikCxmLHMVMJ5V1hs1BrcbmIwG3mrJ2W78HO920mbc1W0nibXYIvlVBn9DZ+T2BNAPL006Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GwsmVKUy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjsXV009922;
	Wed, 20 Mar 2024 18:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=29xaP5UAvNKSpcikIIjh3JQHAC7eEToqPOI6y4HLrM4=; b=Gw
	smVKUymbkHdUwP7Sd+zIS2l5gX0ho76y4KU+ce/Tz4xz5DhuxfCeQWLmBi5lFf+Y
	e6r2UHyXjXCZTFlrNs1Bx4RRZbOk/lk+Q/r1yE0SplJuS+GhaLZ+iP7qshL7EHuz
	T65HcGOrSZrJ6vgF3YyWiNN5p83bhTmo73QkWowHdcFXgb3IvJJusthUfsTuRJMk
	t7fPQUr6pS9wputCtVP+o5b+4DkmTKUSVEYPNfoJZosRPZd18Yz5YDm8QYdRHtm2
	s5WaPCZyEH8pbbIhCNUTQ8DowKGFBiCT1a6sx10dhwRSETj+Bn/L7I039/93cyeu
	htp8sxRXW9gSeQG0mMZQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyyvdgv2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 18:07:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KI77XO002408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 18:07:07 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 11:07:02 -0700
Message-ID: <f548b8a0-96cc-4079-9070-90236cb28e18@quicinc.com>
Date: Wed, 20 Mar 2024 23:37:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS
 configuration
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-5-quic_okukatla@quicinc.com>
 <feb1be8f-ed13-4925-b284-27303651e933@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <feb1be8f-ed13-4925-b284-27303651e933@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uPMnZVlTUOzsgoWHFzgCTkKD5PZv6s__
X-Proofpoint-ORIG-GUID: uPMnZVlTUOzsgoWHFzgCTkKD5PZv6s__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200144



On 3/12/2024 4:05 PM, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 08:30, Odelu Kukatla wrote:
>> Add handles for required clocks to be enabled for configuring
>> QoS on sc7280.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 7e7f0f0fb41b..e1d8fb6afae8 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2129,6 +2129,8 @@
>>   			reg = <0 0x016e0000 0 0x1c080>;
>>   			#interconnect-cells = <2>;
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>> +				<&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> 
> Please align this with the previous <
> 

I will fix it in v4.

> Konrad

Thanks,
Odelu

