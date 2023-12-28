Return-Path: <linux-kernel+bounces-12490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235AC81F58E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B776B1F22631
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA05523F;
	Thu, 28 Dec 2023 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P3jKqTsn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B73D62;
	Thu, 28 Dec 2023 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS7WJtY030966;
	Thu, 28 Dec 2023 07:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=v8R5Z58qJeWtvAnsy/Pmwdxp7+b84gVuhA//nCb5S+Q=; b=P3
	jKqTsnx+zoKiMbTvNMsIUte/9aGxC6zQJZXTNGV0msQDkErtKrX5+erZ6woKgOWn
	/FSy3a0nrFRUuKUZ3lSpCyeAZYdDixR1rqYPB55+T+3TN3GzO/3FvUUYexJwD+Mc
	cbm25gynsr7JJvlaI1CgjLphnz+ihfWCah5vcDVFNwNNYQqtj5YsAydXnMebpGv7
	Gmbwlzp9ta3rSamVgt2FFCGY/Oa/RVsUcjn18CKs73nNsS2LDvAhEly+iXVdPAL4
	SyFT+25QY20x5oUjzz4CfHCe1TqXyDCc55JM7cZ/K1iwetyX8qqVicQuJtoPIrjt
	im02lAPLtItoGBM3vAJw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v94qe80f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 07:36:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BS7acfv024383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 07:36:38 GMT
Received: from [10.253.12.133] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Dec
 2023 23:36:33 -0800
Message-ID: <fffc4f0f-8b61-42ba-95fe-3930804b0743@quicinc.com>
Date: Thu, 28 Dec 2023 15:36:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <20231226-twine-smolder-713cb81fa411@spud>
 <7ad0a344-4f24-4319-8f60-ed2521c21815@quicinc.com>
 <2e58c0f6-08c0-4042-84da-f9b7a6020506@linaro.org>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <2e58c0f6-08c0-4042-84da-f9b7a6020506@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5yz9LiWoFXWzoz0qOGUcGapkplopH06f
X-Proofpoint-ORIG-GUID: 5yz9LiWoFXWzoz0qOGUcGapkplopH06f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=928 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280059



On 12/26/2023 9:19 PM, Krzysztof Kozlowski wrote:
> On 26/12/2023 14:14, Jie Luo wrote:
>>
>>>>>>
>>>>>> This does not resolve mine and Conor's concerns from previous version.
>>>>>> External clocks are defined as clock inputs.
>>>>>
>>>>> No matter the external or internal reference clock, they are the clock
>>>>> source selection for CMN, there are only 48MHZ can be external or
>>>>> internal, other clocks have the different clock rate, so the internal
>>>>> 48MHZ reference clock can be implied when the
>>>>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>>>>> Conor in the previous
>>>>> comments.
>>>>
>>>> I don't think he proposed it, but maybe I missed some message (care to
>>>> point me to his message where he agreed on usage of
>>>> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
>>>> same page, that the presence of clocks defines choice of internal clock.
>>>> This property should go away.
>>>
>>> Exactly, I wanted this property to be removed. My suggestion was about
>>> defaulting to the internal clock when the "clocks" property did not
>>> contain the cmn ref clock.
>>
>> There are two internal reference clock sources 48MHZ and 96MHZ.
> 
> On which devices? Paste entire picture, not half-baked descriptions.

On IPQ9574, the default reference clock source is internal 48MHZ, but
the internal 96MHZ is also configurable on IPQ9574.

If it imply the internal reference clock used by the combination of
the absent of the property and the compatible string, which can't
distinguish the internal 48MHZ and internal 96MHZ on ipq9574.

Since all the reference clock sources have the different clock rate
except for 48MHZ that has internal and external 48MHZ, we just needs
to imply the internal 48MHZ used when the property is absent, other
clock sources are decided by the frequency value of the property.

> 
>> The 96MHZ is used on ipq5018 currently as i said in the previous
>> message, but it is also possible to used on ipq9574 per double checked,
>> since the possible reference clock source should be kept as configurable
>> and the clock source should not be limited on the specific IPQ platform,
>> since the clock source is configurable, the different clock source maybe
>> required by the different board design.
> 
> I don't see how this answers anything about our suggestions.

The reference clock source can be distinguished by the frequency value
as described above.

Without limiting the reference clock source with the compatible string,
the reference clock sources can be kept configurable on IPQ platform,
which makes the MDIO driver code extensible.

> 
> Best regards,
> Krzysztof
> 

