Return-Path: <linux-kernel+bounces-94201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA47873B45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0071C2265A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB22135A63;
	Wed,  6 Mar 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMKON2kL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19469134CE3;
	Wed,  6 Mar 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740505; cv=none; b=gvZFawoPtU1KLOqmu6ITbw9TIQ3WGltdnZnWUUwLUn18r4IGCoI6/Ie/Ri6Rv22rfXZ88XWy6zsM4icgP4t/uFxhhqVV919OEHsSTVzN0ghVAWUKjtbrfvNOGBwCZs/pv5pGkHCJOlRzyjDVhedNpW5T/w33iy86g478C8XIGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740505; c=relaxed/simple;
	bh=k4mL/wtGKyJCjzGU2g5xz/S9W/wbbBRY2EjxmzxaFBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZQakUiuLtplcKZIJnlJZY7hzOljpk0lsMlSwKCWRgzWPAp6rva+pjMJF43so7WYi5yY/bVZpq9YDC+0RCqQO+BdHPqA37nJ4sG7VNS3yyuvuV9Dp+cUTzKOcjn/MabwAO7uN78ksPhW+U1uk1oCocjYeg1PU5n+b3IThwUpRAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMKON2kL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426BsXjc032484;
	Wed, 6 Mar 2024 15:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dO3z+fak+AKlPiPNffpMF1kG89eMs/8ypWV3I63/l6M=; b=dM
	KON2kLTydlE45Z3SuGdiiY2rHup7eZ+FqR+KFbXIoRJlrn8nVsCZuOylQlA9VpPj
	W0JLl06rVPp+MiPDMgUqZ+dBWVVmF0I11zt/2+gAKS4aVdgTTQ6ShmOv2vh8ce6/
	O36Dht786dJhW4nYyvCSSKDcnGeUZvaVfAAUnJ8t6IR7cBUxL3WymMNMlMLaBNag
	JzSPHWK1Zio+04n49LA1Ykpo1yctanvftXtekIX27BJS1hekIldLp5rWC1A5G13g
	N2ZVcvsgugPCt21yr/SPpfpWxJXYL1JQT6wLLZO//HJ0dd5yu48OLksD79WYVrIA
	uAeNgrxG3nftakaPg4Fg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjqf18du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 15:54:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426FsnO1020776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 15:54:49 GMT
Received: from [10.216.51.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 07:54:42 -0800
Message-ID: <51a21209-82a6-431e-bff8-9fad5142dd42@quicinc.com>
Date: Wed, 6 Mar 2024 21:24:39 +0530
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
To: Bjorn Andersson <andersson@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_wcheng@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_nkela@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
 <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
 <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>
 <qbgyspabmohgwenj3mbpiebyll2jlgvbq5v5fm56mo2ixwgnee@nyjzjrspxrq3>
From: Sriram Dash <quic_sriramd@quicinc.com>
In-Reply-To: <qbgyspabmohgwenj3mbpiebyll2jlgvbq5v5fm56mo2ixwgnee@nyjzjrspxrq3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zHvvQIezNU82e0pBv1kv7Fbp2cLHcEp6
X-Proofpoint-ORIG-GUID: zHvvQIezNU82e0pBv1kv7Fbp2cLHcEp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060127

On 3/6/2024 12:17 AM, Bjorn Andersson wrote:
> On Tue, Mar 05, 2024 at 11:33:54PM +0530, Sriram Dash wrote:
>> On 3/5/2024 10:38 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>> Establish the channel and domain mapping for the power domains to connect
>>>> with firmware, enabling the firmware to handle the assigned resources.
>>>> Since these delegated resources will remain invisible to the operating
>>>> system, ensure that any references to them are removed.
>>>>
>>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
>>>>    1 file changed, 77 insertions(+), 19 deletions(-)
>>>
>>> Do not mix DTS patches with submissions to netdev or USB.
>>>
>>> Please put it inside your internal guides, so you will not be repeating
>>> this over and over.
>>>
>>
>> Sure. Will take care. Thanks.
>>
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> index 26ad05b..b6c9cac 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> @@ -764,8 +764,18 @@
>>>>    };
>>>>    &usb_0 {
>>>> -	pinctrl-names = "default";
>>>> -	pinctrl-0 = <&usb0_en_state>;
>>>> +	/delete-property/ clocks;
>>>> +	/delete-property/ clock-names;
>>>> +	/delete-property/ assigned-clocks;
>>>> +	/delete-property/ assigned-clock-rates;
>>>> +	/delete-property/ required-opps;
>>>> +	/delete-property/ resets;
>>>> +	/delete-property/ interconnects;
>>>> +	/delete-property/ interconnect-names;
>>>> +
>>>> +	power-domains = <TODO>, <TODO>;
>>>
>>> This wasn't even tested.
>>>
>>
>> This is tested with the specific power domains in place
>> of <TODO>. SCMI interface is used for the power domains.
>>
> 
> So you tested this on v6.8-rcN, but you're not able to upstream this
> dependency? The code wouldn't compile if this patch is applied, so what
> do you expect that I should do with it?
> 
> Develop on upstream, test on upstream, send code that improves upstream!
> 

Thanks Bjorn.
Sure. I will wait for the scmi based dt support
for SA8775 and then update the patches on top.

> Thank you,
> Bjorn
> 
>>> Best regards,
>>> Krzysztof
>>>

