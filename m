Return-Path: <linux-kernel+bounces-70731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE9859BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA251F20D47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F61CF9A;
	Mon, 19 Feb 2024 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cr8fsVbo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9ED1CF81;
	Mon, 19 Feb 2024 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319833; cv=none; b=PFJIpBUkf/fQaKGWxjRiTH6F7Po4To6r8IpFnTy1e22h+WaCDf/0H85ThV1ykjzSIdRZzI/Z/zNn2isVs9/XKpYLeve5LHWwvYeAsJ8MIGFvUNScZ4ymat84Tojtjlj08TaCcqwc4fDeMw4JVGTfJ8vn/jwDnB3IpYL2eMqvVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319833; c=relaxed/simple;
	bh=M3OTG06d9RxSKB1rENK+SnmvW0I3gkARsXBX2A4vdG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uv5MJfJgsw4440Lgl4flCvfcVrYGE6st/Vei6u0X2U/gRlJFMQ/4dwSh8gyZPatd5r2UGRV5531Cg0YEeI/IaPG1M0sBrxhzitxXi+vJMjtHA9MEGQpwojcw01f+YjmVHq80lzK6i2wfAKXxkErpGcS9IAmoxStgkLDSTytoG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cr8fsVbo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4jvCo020491;
	Mon, 19 Feb 2024 05:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gdKdWz8ss1z4dbc1DHVLkPAo2fig5lGq5nOkdt7FYk0=; b=cr
	8fsVbokmG6zDzm7nARShRIj6GDH1+86KR/fTvON2RTL86F8uIJlB72jExSA2ifYv
	VMNOe8x02Q6WgW9LQh6UiE3lAHaOdruEHSAtn/2ECwYQJ4O+h9PG7YcrAPWDObhr
	OypgsR/Zgu00kkOUmXdeVp1hGkE3zuYZK78ISavS9U9CjNOe/IsZohnGWY9LQsbH
	kuuIKLN6LVQSe0YEcsz2YOIhunnY2EragcvzSvUCINrmnBuHmVzq/w83EFJ3qxSN
	EVpiPuiMkr9FSwn1adxzxv0D7V28a+cQPZ7/cIfW8lWmlXeiUqHzqAgkKUIpQ5ZX
	baaz4VlC/mZrwO63KXDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waktctur9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 05:17:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J5H5Ah009875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 05:17:05 GMT
Received: from [10.216.58.209] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 18 Feb
 2024 21:17:01 -0800
Message-ID: <413e23b5-2b81-4278-907c-a5b9f6992e6a@quicinc.com>
Date: Mon, 19 Feb 2024 10:46:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: add slimbus DT node
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-sm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_cchiluve@quicinc.com>,
        <quic_anupkulk@quicinc.com>
References: <20240215090910.30021-1-quic_vdadhani@quicinc.com>
 <wkbz5ska66c4kil67k4csqzm3anusskza7ysisaupfaqak3x77@wb3pqlngyzcd>
Content-Language: en-US
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <wkbz5ska66c4kil67k4csqzm3anusskza7ysisaupfaqak3x77@wb3pqlngyzcd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dbn1_Bt5JRmsJntLaFQN3UB-x1HcRgeB
X-Proofpoint-ORIG-GUID: dbn1_Bt5JRmsJntLaFQN3UB-x1HcRgeB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_02,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=945 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190037



On 2/17/2024 4:49 AM, Bjorn Andersson wrote:
> On Thu, Feb 15, 2024 at 02:39:10PM +0530, Viken Dadhaniya wrote:
> 
> You've misspelled "linux-arm-msm" in the mailing list address, so this
> was not in my review queue. Please switch to using b4 for preparing and
> sending future patches, to avoid such mistakes.

Corrected mailing list address and submitted V4.

> 
> Regards,
> Bjorn
> 
>> Populate the DTSI node for slimbus instance to be
>> used by bluetooth FM audio case.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
>> v2 -> v3:
>> - Fix patch title by adding "PATCH" string.
>> - Update commit log.
>>
>> v1 -> v2:
>> - change 0x0 -> 0 to reg property.
>> - reorder the DT property.
>> - change node tag slim_msm to slim.
>> ---
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 581818676a4c..1d6afde915aa 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2672,6 +2672,31 @@
>>   			status = "disabled";
>>   		};
>>   
>> +		slimbam: dma-controller@3a84000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0 0x03a84000 0 0x20000>;
>> +			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			qcom,controlled-remotely;
>> +			num-channels  = <31>;
>> +			qcom,ee = <1>;
>> +			qcom,num-ees = <2>;
>> +			iommus = <&apps_smmu 0x1826 0x0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		slim: slim-ngd@3ac0000 {
>> +			compatible = "qcom,slim-ngd-v1.5.0";
>> +			reg = <0 0x03ac0000 0 0x2c000>;
>> +			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
>> +			dmas = <&slimbam 3>, <&slimbam 4>;
>> +			dma-names = "rx", "tx";
>> +			iommus = <&apps_smmu 0x1826 0x0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>>   		lpass_hm: clock-controller@3c00000 {
>>   			compatible = "qcom,sc7280-lpasshm";
>>   			reg = <0 0x03c00000 0 0x28>;
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

