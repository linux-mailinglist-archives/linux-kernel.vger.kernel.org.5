Return-Path: <linux-kernel+bounces-94225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF4873BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1ADCB233F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8013BAFE;
	Wed,  6 Mar 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WhG9+JIw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0C135A72;
	Wed,  6 Mar 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741029; cv=none; b=I04YoPqvDI2+Al07ljMRbA5yKF+LE0sjexTnp+TWImhP1F4uQHuvPURhWJmn6282PPlQ+g2+WvYVQ/FXvloRL1rqmgaJ4qoVKBcXQVM12LZEdcuoS+AxkbTp7RBDSiOH5YVoxnx5l2VbubTT7oShfsqY3awCzhkSjPSbbJHu0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741029; c=relaxed/simple;
	bh=T2tpTslpzqwaKMQiwKjAZ87z8ODqqUzEP56+97Oo4To=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fl/rcXuAJ2oJRS9UBLNAgLC58nadKfalL2f12CnH4H0HcSaLJSUNeG0qqShsUjsrtHVXdj2lwy5Bj3xuDL1icwm7BRTcgW7qB6yE4JrP3duuHt+MxqEKP7WRsOPF+n61OKIUDGJuJjRsIyOdRr/zJPB6F1LsussVrhTIFXfDJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WhG9+JIw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426E52o6018850;
	Wed, 6 Mar 2024 16:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lD+rsTRMmM5HdcVKk1OnrPnaiKBG5ZbuxzdOCW+qaRM=; b=Wh
	G9+JIw202wJxasxuFBbR0xhbldDxnj5Sp3HmRs5/dtmSrQwIVhVQK0PyDqXQvc9Z
	V30PmRiUQpdqAxYN0OyB0qypbGPHQtqrf9912Pm8vNUSEuSoS8yl+Nguq7sVEaCz
	zm+R3l/v5j4HeTMfjU7U3F+UTI4mYcD2RsYmuh2FsH/iyWAqgSfzGUkfgiJ8rPCw
	VwqNrc8Jix6O+jsycqdFmFePsG9qIffmjTI6aeR8JEDxdBPSs+v6yMLPw1+Wn0il
	yipVmAqLESdIoNEpw/twd3T1S3D19BXavFLaW6zMdYmr0wQSu15HEBkcKJtBdrp/
	+k774LhYGXPbeE5J0QyQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpsxhg9fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 16:03:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426G3VQr001154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 16:03:31 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 08:03:24 -0800
Message-ID: <b3304e24-90c9-4109-8d42-fad778f68758@quicinc.com>
Date: Wed, 6 Mar 2024 21:33:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for
 firmware managed resources
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_wcheng@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>, <devicetree@vger.kernel.org>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
 <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
 <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>
 <a2e863e2-9c8b-47c2-b4d8-5664d954cd49@quicinc.com>
 <5736796f-061b-46a0-b4eb-ab447fac4426@linaro.org>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <5736796f-061b-46a0-b4eb-ab447fac4426@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: riX8b21FI9P2aNeNSalQjcm937xh3guF
X-Proofpoint-ORIG-GUID: riX8b21FI9P2aNeNSalQjcm937xh3guF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060129

On 3/6/2024 2:37 AM, Konrad Dybcio wrote:
> 
> 
> On 3/5/24 19:25, Sriram Dash wrote:
>> On 3/5/2024 11:33 PM, Sriram Dash wrote:
>>> On 3/5/2024 10:38 PM, Krzysztof Kozlowski wrote:
>>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>>> Establish the channel and domain mapping for the power domains to 
>>>>> connect
>>>>> with firmware, enabling the firmware to handle the assigned resources.
>>>>> Since these delegated resources will remain invisible to the operating
>>>>> system, ensure that any references to them are removed.
>>>>>
>>>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 
>>>>> +++++++++++++++++++++++++------
>>>>>   1 file changed, 77 insertions(+), 19 deletions(-)
>>>>
>>>> Do not mix DTS patches with submissions to netdev or USB.
>>>>
>>>> Please put it inside your internal guides, so you will not be repeating
>>>> this over and over.
>>>>
>>>
>>> Sure. Will take care. Thanks.
>>>
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts 
>>>>> b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>>> index 26ad05b..b6c9cac 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>>> @@ -764,8 +764,18 @@
>>>>>   };
>>>>>   &usb_0 {
>>>>> -    pinctrl-names = "default";
>>>>> -    pinctrl-0 = <&usb0_en_state>;
>>>>> +    /delete-property/ clocks;
>>>>> +    /delete-property/ clock-names;
>>>>> +    /delete-property/ assigned-clocks;
>>>>> +    /delete-property/ assigned-clock-rates;
>>>>> +    /delete-property/ required-opps;
>>>>> +    /delete-property/ resets;
>>>>> +    /delete-property/ interconnects;
>>>>> +    /delete-property/ interconnect-names;
> 
> This is totally unacceptable.. And especially makes no sense given
> ride is likely the only sa8775 board in existence..
> 

Sure Konrad.
Will update the patches on top of the scmi based dt
for sa8775.

>>>>> +
>>>>> +    power-domains = <TODO>, <TODO>;
>>>>
>>>> This wasn't even tested.
>>>>
>>>
>>> This is tested with the specific power domains in place
>>> of <TODO>. SCMI interface is used for the power domains.
> 
> I'm sorry, but "break compilation successfully" is not a valid
> test result..
> 
> Konrad

