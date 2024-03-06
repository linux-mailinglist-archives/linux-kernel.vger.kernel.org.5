Return-Path: <linux-kernel+bounces-94194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FC873B23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D9D282126
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2E135A49;
	Wed,  6 Mar 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KCRdPITz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162411EF1C;
	Wed,  6 Mar 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740207; cv=none; b=IJgAPvABjSGZ0dq4i9/KiROxHCWXPC0OZLWzkNCPwDDSTjJFhW68SI5DHLncqp85IuqijsCc6QgDLuwTuxWQVENGawdLdTV7f1LEQRXXaK4QETv/QjRMNWjhHPLW28pk5n9ongJ2veQnb8C/SJ6qTOW5aXY/UFBfiVzuTlDpWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740207; c=relaxed/simple;
	bh=3ZSjIwoY/IwTcrtWBjqc2dcmr6HyCAgiEyqDlQowYoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzgydRwPLEfgHC+9xgbkFrLzXknmjFpznXsdlHM2LlK3SqsZRXsJzbAItUW6Cc+UWR4UGf+lg9OWVTo/KyCZGUgiI5YD+DKoLjfh/pFpvoQyC+IGr9uH5sic8a9T3djm5eXFOwZJGMfMV0DvCtwD7KSmUKZ3rAOnj/KkbM//bOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KCRdPITz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426FISU6031255;
	Wed, 6 Mar 2024 15:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MQc1wjjU8NkRsMI5u/E32Gitd9ayAX0A/PGoygQBeSc=; b=KC
	RdPITzRL+3fcBS2Ri3EqXyGW9R/EHPVXwQ4tOoJJJ0fFoqgkKjfs7gKJUVCA3d9P
	GBRATxpEaiVs+M4K1d+9CQbOcY9xwMwDJZla9OnuSIG6hKLTD8c34EoGAWToi0/W
	PTt8RosHOG6RMZn99fGrEGU+vE55N2ceQBpDVVBcd04qnbbIB3RoR4LiNMDG7j00
	UGume81Z97SudfodeJcvMgL4V63OBA9qW9WYXrqfqJbU2D4VWY/r+l6oZcT7wveE
	LFJdDAvd6fehMfXFAIQdTR3ebLG4J7wYqwvQ+S2GRNwUgEYpfKwICFNT//1iuNdB
	dYXoGyqzliEA25nPUOzw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpktps2y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:49:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426FnieG012157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 15:49:44 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 07:49:37 -0800
Message-ID: <b2ae44ff-55e2-495b-b320-cbb8deae81be@quicinc.com>
Date: Wed, 6 Mar 2024 21:19:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple
 power-domains
Content-Language: en-US
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <quic_shazhuss@quicinc.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <kishon@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <sudeep.holla@arm.com>, <p.zabel@pengutronix.de>,
        <ulf.hansson@linaro.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vkoul@kernel.org>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
 <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
 <986b49f5-6a4a-430d-ba6a-2f387f2a262a@quicinc.com>
 <84618a4a-be20-4c59-badc-15fa65debf4c@linaro.org>
 <e441e458-a90b-495f-abf1-448620c14c85@quicinc.com>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <e441e458-a90b-495f-abf1-448620c14c85@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GYy6pibLFHOesiWJtM5ei5MgkmJmw7qf
X-Proofpoint-ORIG-GUID: GYy6pibLFHOesiWJtM5ei5MgkmJmw7qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxlogscore=793 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060126

On 3/6/2024 1:03 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 3/6/2024 12:33 PM, Krzysztof Kozlowski wrote:
>> On 05/03/2024 19:03, Sriram Dash wrote:
>>> On 3/5/2024 10:37 PM, Krzysztof Kozlowski wrote:
>>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>>> Some target systems allow multiple resources to be managed by 
>>>>> firmware.
>>>>> On these targets, tasks related to clocks, regulators, resets, and
>>>>> interconnects can be delegated to the firmware, while the remaining
>>>>> responsibilities are handled by Linux.
>>>>>
>>>>> To support the management of partial resources in Linux and leave 
>>>>> the rest
>>>>> to firmware, multiple power domains are introduced. Each power 
>>>>> domain can
>>>>> manage one or more resources, depending on the specific use case.
>>>>>
>>>>> These power domains handle SCMI calls to the firmware, enabling the
>>>>> activation and deactivation of firmware-managed resources.
>>>>>
>>>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>>>> ---
>>>>>    .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 
>>>>> ++++++++++++++++------
>>>>>    .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 
>>>>> ++++++++++++--
>>>>>    .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>>>>>    3 files changed, 130 insertions(+), 30 deletions(-)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>>> index 1e2d4dd..53b9ba9 100644
>>>>> --- 
>>>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>>> +++ 
>>>>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>>>> @@ -44,7 +44,32 @@ properties:
>>>>>        maxItems: 5
>>>>>      power-domains:
>>>>> -    maxItems: 1
>>>>> +    description: specifies a phandle to PM domain provider node
>>>>
>>>> Please drop all redundant descriptions. Adding them is not even related
>>>> to this patch.
>>>>
>>>
>>> Thanks Krzysztof for the super quick response !
>>> Sure. will drop the description for power-domain
>>> and power-doamin-names.
>>>
>>>>> +    minItems: 1
>>>>> +    maxItems: 2
>>>>> +
>>>>> +  power-domain-names:
>>>>> +    description:
>>>>> +      A list of power domain name strings sorted in the same order 
>>>>> as the
>>>>> +      power-domains property.
>>>>> +
>>>>> +      For platforms where some resource are firmware managed, the 
>>>>> name
>>>>> +      corresponding to the index of an SCMI domain provider can be
>>>>> +      "usb_core" or "usb_transfer".
>>>>> +    items:
>>>>> +      - const: usb_core
>>>>> +      - const: usb_transfer
>>>>
>>>> How is this related to fw-managed? I fail to see it. Don't mix
>>>> independent problems in one patch.
>>>>
>>>
>>> Some of the the resources like clocks, regulators, etc will be
>>> controlled by the firmware instead of OS. However, some resources
>>> still will be controlled by OS (interrupts for example).
>>>
>>> So, to support the management of partial resources in Linux, and
>>> offload the other resource management to firmware, multiple power
>>> domains are introduced. They will be corresponding to different
>>> hw blocks.
>>>
>>> Do you suggest splitting the addition of power-domain-names and
>>> addition of fw-managed property in separate patches for bindings!
>>>
>>>>> +
>>>>> +  qmp,fw-managed:
>>>>
>>>> Please do not upstream vendor code directly, but perform basic
>>>> adjustment to upstream Linux kernel. There is no such company as gmp.
>>>>
>>>> Run this first through your internal review process.
>>>>
>>>
>>> This property is newly introduced for the qmp superspeed phy and
>>> similar dt properties are introduced for hsphy and dwc3 qcom
>>> controller glue layer driver. It will govern the suspend/ resume
>>> of the resources (by firmware or OS) as required.
>>
>> So that's your answer to "there is no such company as gmp"? It's not
>> relevant at all.
>>
>> Please run it through internal review first.
>>
>>
> Hi Sriram,
> 
>   QMP indicates the driver name "QMP Phy" (for super speed mode of 
> operation), not the company name. If this property is for identification 
> of fw management to be done / (or not to be done) in QMP Phy, then 
> please rename is appropriately. Check how other properties are defined 
> in the QMP bindings and add "qcom" at beginning preferably. For 
> reference as to how properties were added to femto phy driver: [1].
> 
> [1]: 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1662480933-12326-2-git-send-email-quic_kriskura@quicinc.com/
> 

Thanks for the references Krzysztof/Krishna.
I got suggestion from Dmitry on the use of the
property too. Indeed we will be the scmi based
clock/ PD management on SA8775. So, we will
introduce a new compatible string and take the
decision in driver accordingly.


> Regards,
> Krishna,

