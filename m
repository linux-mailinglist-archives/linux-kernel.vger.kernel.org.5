Return-Path: <linux-kernel+bounces-12492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CE81F595
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493E4283DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121A5393;
	Thu, 28 Dec 2023 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fP0tVxm0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C144401;
	Thu, 28 Dec 2023 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS5S0Ep002333;
	Thu, 28 Dec 2023 07:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mbqq5K4vzBILDjx2EzO6ali6MlyoqtPE7nV7XIFsqx8=; b=fP
	0tVxm09NQ88yuqDdBAisfW1Fu+nKa2hTiAz2UeUMGhvFxQkUIVyIC6w0Xa2kIDpR
	S8j6oCpvAuU5V/MCz9PIeRaSIDdbgn7cVZTSll0otDfCUPkICh0GbDGRLZQwYi/Y
	VAIFZA5PazGf8U8ruKlC49fv0EFFihyvkf7BN4KRb8w8T+/SyA/qwf8hG+C4UXOr
	VVoqApe2FMV9NxMvUvJUJPUHh4hFenHDzT4+lU+k/xRFtDGMPzE3NyD1YaS19b3l
	2rYZo7jkRVWAoOc8qh8yZpmUDqbpVb55RC+KnH2+BJ1gWZxNS2M3PU1txjuLKlDM
	vnXKAE4aVPodqERVZpdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8d452gvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 07:38:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BS7cAQr026011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 07:38:10 GMT
Received: from [10.253.12.133] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Dec
 2023 23:38:05 -0800
Message-ID: <d231b7e2-51f5-4676-8fc0-e4bc6154e2d7@quicinc.com>
Date: Thu, 28 Dec 2023 15:38:05 +0800
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
 <28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lq_hY41tAb-luFwJjRJT5cbKFsLzg6j-
X-Proofpoint-GUID: Lq_hY41tAb-luFwJjRJT5cbKFsLzg6j-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312280060



On 12/26/2023 9:18 PM, Krzysztof Kozlowski wrote:
> On 26/12/2023 14:06, Jie Luo wrote:
>>
>>>
>>>
>>>>
>>>>>
>>>>>> +      the platform IPQ50xx/IPQ5332.
>>>>>
>>>>> So these are valid for all platforms or not? Looks not, but nothing
>>>>> narrows the list for other boards.
>>>>
>>>> i add the limitation on the reg usage for the ipq5332 platform on the
>>>> following part "if condition" of this patch, i will update the patch
>>>> to narrow down for the other compatibles.
>>>>
>>>>>
>>>>> Anyway, why do you add entries in the middle? LDO was the second, so it
>>>>> cannot be now fifth.
>>>>
>>>> As Rob's suggestion, i move the cmn_blk to second location for
>>>> simplifying the limitation description, i checked the upstream dts code,
>>>> the LDO is not used currently, so we can move cmn_blk to the second
>>>> location here.
>>>
>>> I cannot find his suggestion in the previous thread. Where did he
>>> propose it?
>>
>> Rob suggested this on the V2 as below.
>> "
>> Perhaps cmn_blk should come 2nd, so all the variants have the same entry
>> indices. Then you can move this to the top level and just say 'minItems:
>> 4' here.
> 
> Wasn't this for new devices? What about all existing which have LDO as
> the second entry?

In the current regs, which includes mdio and one LDO.
mdio is the reg address range for all IPQs.
one LDO is only for ipq5018.

the new added LDO is for ipq5332.
the cmn_blk is for ipq9574 and ipq5332.

i will update these limitations of dt-bindings in the next patch set.

> 
>>>>>> +  qcom,cmn-ref-clock-frequency:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    enum:
>>>>>> +      - 25000000
>>>>>> +      - 31250000
>>>>>> +      - 40000000
>>>>>> +      - 48000000
>>>>>> +      - 50000000
>>>>>> +      - 96000000
>>>>>> +    default: 48000000
>>>>>> +    description: |
>>>>>> +      The reference clock source of CMN PLL block is selectable, the
>>>>>> +      reference clock source can be from wifi module or the external
>>>>>> +      xtal, the reference clock frequency 48MHZ can be from internal
>>>>>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>>>>>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
>>>>>
>>>>> This does not resolve mine and Conor's concerns from previous version.
>>>>> External clocks are defined as clock inputs.
>>>>
>>>> No matter the external or internal reference clock, they are the clock
>>>> source selection for CMN, there are only 48MHZ can be external or
>>>> internal, other clocks have the different clock rate, so the internal
>>>> 48MHZ reference clock can be implied when the
>>>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>>>> Conor in the previous
>>>> comments.
>>>
>>> I don't think he proposed it, but maybe I missed some message (care to
>>> point me to his message where he agreed on usage of
>>> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
>>> same page, that the presence of clocks defines choice of internal clock.
>>> This property should go away.
>>
>> Sorry for this confusion.
>> Rob said the internal reference source can be decided by the absence of
>> the property combined with compatible string, because i said the
> 
> So all your three DT maintainers agree that lack of property for
> choosing clock, defines the usage of interrupt source.

This is the reference clock source selection of CMN block, which
generates the clocks for the Ethernet devices.

> 
> Now we had huge amount of arguments that you do not represent properly
> the clock relationships. Still.

here is the clock topology.
reference clock sources ---> CMN PLL ---> various output clocks

the output clocks are provided to the Ethernet devices(such as the
qca808x PHY devices).

These information is also provided the commit message of the patch
<net: mdio: ipq4019: configure CMN PLL clock for ipq5332>.

> 
>> internal 96MHZ is used on ipq5018 currently in the previous message.
>>
>> per double checked the current IPQ platforms, the internal 96MHZ is also
>> possible on ipq9574, and the reference clock source should be kept as
>> configurable instead of limited by the compatible string, maybe the
>> different reference clock source is acquired in the future, even
>> currently it is not used on the special platform for now.
>>
>> so i update the solution with a little bit of changes.
> 
> You still do not want to implement our suggestions and I don't
> understand your arguments. Nothing in above paragraph explains me why
> you cannot use clock provider/consumer relationships.

Hi Krzysztof,

The reference clock source can be registered as the fix clock provider,
 From the current fix clock provider, the clock rate is useful for the
clock consumer, the fix clock rate is used to generate the output clocks
by the divider or multiplier.

For the CMN block to select reference clock, which is configuring the
clock source, we don't know the formula to get the output clock value
based on the reference clock value.

i also see there is an example in the upstream code, which is same as
the CMN block to select the reference clock source.

the property "ref-clock-frequency" is defined in the yaml file below.
Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml.
"
ref-clock-frequency: 

     $ref: /schemas/types.yaml#/definitions/uint32 

     description: Reference clock frequency.
"

the reference clock source is selected based on the table as below.
source code file drivers/net/wireless/ti/wl12xx/main.c
"
static const struct wl12xx_clock wl12xx_refclock_table[] = { 

         { 19200000,     false,  WL12XX_REFCLOCK_19      }, 

         { 26000000,     false,  WL12XX_REFCLOCK_26      }, 

         { 26000000,     true,   WL12XX_REFCLOCK_26_XTAL }, 

         { 38400000,     false,  WL12XX_REFCLOCK_38      }, 

         { 38400000,     true,   WL12XX_REFCLOCK_38_XTAL }, 

         { 52000000,     false,  WL12XX_REFCLOCK_52      }, 

         { 0,            false,  0 } 

};
"
Thanks.
> 
> 
> Best regards,
> Krzysztof
> 

