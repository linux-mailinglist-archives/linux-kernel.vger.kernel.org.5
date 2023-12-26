Return-Path: <linux-kernel+bounces-11513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B908881E784
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DE61F21C75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C384EB46;
	Tue, 26 Dec 2023 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aQgR9dvn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF54EB25;
	Tue, 26 Dec 2023 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQAUL8A024768;
	Tue, 26 Dec 2023 13:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s3KhOx8ps/bXmnu8PNFAT4jER6IQ+2jMvRE09KSzu+U=; b=aQ
	gR9dvnWuJwGU98tmDB5dwrMTvdfOfE2gIIZzmAN0gz2Auf8wxUvRCYCyCRQxOBhX
	9okHXAzMPX+6F3Qmw0hLkV54UVSe/B/anGLkSl/7DorG0LejQtD8kQcCq0UcU0h9
	QFQm7q4usxLXLqM2kWURp9ZKqLaFIoUKr0lNwwgNOQb5dEpS1TRZcgnKOWMNgDPe
	9doBlHNIuRGIcvH6OkcoeBBEnnfTBqLjpgkoISX7M4P/vszgWz/e2C3ZYnq/U29x
	rwY9Sa/cyPoxLad/aoB4FYyYP7UUxKzx1Xycl4jpX4W0ugH1dX31zO8LNZIqBYlJ
	TV25Qp7EdTqiOH3NaE8A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7qbx90q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 13:14:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQDE976031923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 13:14:10 GMT
Received: from [10.253.14.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 05:14:05 -0800
Message-ID: <7ad0a344-4f24-4319-8f60-ed2521c21815@quicinc.com>
Date: Tue, 26 Dec 2023 21:14:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231226-twine-smolder-713cb81fa411@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 61ZAYF9IMO20lDvvENDFXq9kJUgZUWA3
X-Proofpoint-ORIG-GUID: 61ZAYF9IMO20lDvvENDFXq9kJUgZUWA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=803 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260100



On 12/26/2023 8:21 PM, Conor Dooley wrote:
> On Tue, Dec 26, 2023 at 10:28:09AM +0100, Krzysztof Kozlowski wrote:
>> On 26/12/2023 08:25, Jie Luo wrote:
> 
>>>>> +  qcom,cmn-ref-clock-frequency:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum:
>>>>> +      - 25000000
>>>>> +      - 31250000
>>>>> +      - 40000000
>>>>> +      - 48000000
>>>>> +      - 50000000
>>>>> +      - 96000000
>>>>> +    default: 48000000
>>>>> +    description: |
>>>>> +      The reference clock source of CMN PLL block is selectable, the
>>>>> +      reference clock source can be from wifi module or the external
>>>>> +      xtal, the reference clock frequency 48MHZ can be from internal
>>>>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>>>>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
>>>>
>>>> This does not resolve mine and Conor's concerns from previous version.
>>>> External clocks are defined as clock inputs.
>>>
>>> No matter the external or internal reference clock, they are the clock
>>> source selection for CMN, there are only 48MHZ can be external or
>>> internal, other clocks have the different clock rate, so the internal
>>> 48MHZ reference clock can be implied when the
>>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>>> Conor in the previous
>>> comments.
>>
>> I don't think he proposed it, but maybe I missed some message (care to
>> point me to his message where he agreed on usage of
>> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
>> same page, that the presence of clocks defines choice of internal clock.
>> This property should go away.
> 
> Exactly, I wanted this property to be removed. My suggestion was about
> defaulting to the internal clock when the "clocks" property did not
> contain the cmn ref clock.

There are two internal reference clock sources 48MHZ and 96MHZ.
The 96MHZ is used on ipq5018 currently as i said in the previous
message, but it is also possible to used on ipq9574 per double checked,
since the possible reference clock source should be kept as configurable
and the clock source should not be limited on the specific IPQ platform,
since the clock source is configurable, the different clock source maybe
required by the different board design.

As description above, the reference clock source has the different clock
rate except the 48MHZ, so it can imply that the internal 48MHZ used when
the property is absent.

> 
>> It is tiring to keep discussing this.
> 
> Yup.
> 

