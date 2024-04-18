Return-Path: <linux-kernel+bounces-149659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC78A9424
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C711F21321
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E86F53D;
	Thu, 18 Apr 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E3VkCGcA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2055646E;
	Thu, 18 Apr 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425688; cv=none; b=HC4ySGiJVgMSk+ujVhpC8oLzpytwiSXMZ/47dAUpeCvxkQiVzcJ0mTD16BWBBNMruuY79+4rytsyPikfbQgZu74HNMHvo0EqjneLRFtwODjbQj7+uZzzU+FxwBHZdmGOxCFJ8z3hItDNN1IsfHaOWn2+4cUXgE+44qvXIRRLMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425688; c=relaxed/simple;
	bh=m7tavqSn0c1tx7E2F4JR5XohOQ9YgV/pmV68Fr6cmAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C7xfcL0E+3WfA0IK/ZEP2NnAVsE33PfgVa35KLAQl4845Xm4C9Lpq/YYJ0xX772052yH/lhaAi91v+mjRpB6q15mdaXbCJx3QCvomcM5EOe38Gk5hiw6CGSCqkQ1nJdzb2K0pbr4Hd/Iu+vIvc624l9Lk35kYQ+9KX2Xn2auMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E3VkCGcA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I6JiwR007579;
	Thu, 18 Apr 2024 07:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K12NOf6IsogdQB7rzNNUFBNWb4yAeg2dUoVcMEo6G10=; b=E3
	VkCGcADPsG+qzpq+u70fRLaBsmwdYAqX1G9oT+uXyNqY6v/u3/Vv7uhq1Fh7d88G
	rOUbFP12TUYxB6NKwN+B+lwzpyuTqpfLNdpKUSFh2/g6/oPYtnbEDmMR+r7Aa7SP
	FlRErI/MHErYGGQe5B3aQAHmedTLv4uV73GEDEkH+OgCOsP6ErO5gtelcaMNsQu3
	tNDa1g7mXhVZOs1xCpNNbKewoKZ4xAoEe5wlz9R9VbV/KQ1dZircLz4CX8MWJ6bX
	JETI21XzvbbhI8YPb9Hn/av+7gLhgvzv+VXMeiSdEafWU8xV0o2+nsuexicxvvhn
	RGfd7R5EtE9GH6om4q0g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54g5u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:34:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I7YYXd021883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:34:34 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 00:34:28 -0700
Message-ID: <eaf74619-1732-2b78-007f-3303f7fb1d3d@quicinc.com>
Date: Thu, 18 Apr 2024 13:04:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 3/5] arm64: dts: qcom: x1e80100: Resize GIC
 Redistributor register region
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-4-quic_sibis@quicinc.com>
 <ZiA3f58OWfe5xf1f@hu-bjorande-lv.qualcomm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZiA3f58OWfe5xf1f@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ohxjbgZ28L9ExMN1ubxIMKonFOuwHicd
X-Proofpoint-ORIG-GUID: ohxjbgZ28L9ExMN1ubxIMKonFOuwHicd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180052



On 4/18/24 02:26, Bjorn Andersson wrote:
> On Wed, Apr 17, 2024 at 06:58:54PM +0530, Sibi Sankar wrote:
>> Resize the GICR register region as it currently seeps into the CPU Control
>> Processor mailbox RX region.
>>
> 
> Not that anyone is running a stable kernel here, but please make a habit
> of adding Fixes: tags when correcting previous mistakes.

Yeah, skipped adding fixed for ^^ reason but I'll add it in the next re-
spin.

> 
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>> * Pickup Rb from Dimitry.
>>
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index f5a3b39ae70e..28f65296781d 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -4949,7 +4949,7 @@ apps_smmu: iommu@15000000 {
>>   		intc: interrupt-controller@17000000 {
>>   			compatible = "arm,gic-v3";
>>   			reg = <0 0x17000000 0 0x10000>,     /* GICD */
>> -			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
>> +			      <0 0x17080000 0 0x380000>;    /* GICR * 12 */
>>   
> 
> The 12th GICR ends a bit before that, and per your commit message you're
> just nudging it down to get this range out of the say of your other
> range - rather than giving it a proper value.
> 
> Wouldn't 0x300000 be a better value here? Or am I perhaps missing

Yes, my calc was incorrect. It should be 0x300000.

-Sibi

> something in the difference? If so, I'd like the commit message to state
> what, so someone doesn't get excited and correct/break it later.
> 
> Regards,
> Bjorn
> 
>>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>   
>> -- 
>> 2.34.1
>>

