Return-Path: <linux-kernel+bounces-11512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B981E780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AFD1F2283A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771D4EB42;
	Tue, 26 Dec 2023 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XtAyQ1Po"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F534EB25;
	Tue, 26 Dec 2023 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQCcuH7029953;
	Tue, 26 Dec 2023 13:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K52oU9sdEHfHjpAJMbid1q1OXehqpGxCjomXi00WJx0=; b=Xt
	AyQ1PopUYsfM98GICWQksi8BOHRdGEyJTMt6AB+kZT6VTX3+aUqmuXrz3p0RNUB7
	rzT5SreoJDW/ZUhXRhMOgMDpOChmp72DY2LuPVo9Ymu1MxXVbcSyb5pajW0wNdxB
	JgadBg772arysdjiE5oQVlP5NxcYdo4o6AUShc1bjsiGJ1V4u2SQlg9EkxGIO0D7
	DeEhYgqZut+n9KfIG8e+xgTf4lg2sbpW3BXuYsB4rgZbKs1eArRp3QfYGC2pyEsh
	cIu9y9bwmUQlcIjbB7yPcWbYrtTIfrph1M3YkMjjxnqY2b44FiDYOBR9tkb5/QcT
	X/Ds4dQk8KNG/heq2SWg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7s8u8txa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 13:07:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQD6sdf025095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 13:06:54 GMT
Received: from [10.253.14.217] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 05:06:49 -0800
Message-ID: <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
Date: Tue, 26 Dec 2023 21:06:47 +0800
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r7Uiofwueh85XjMga1MdmQ9fu_9vsegz
X-Proofpoint-ORIG-GUID: r7Uiofwueh85XjMga1MdmQ9fu_9vsegz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260100



On 12/26/2023 5:28 PM, Krzysztof Kozlowski wrote:
> On 26/12/2023 08:25, Jie Luo wrote:
>>>> -    description:
>>>> -      the first Address and length of the register set for the MDIO controller.
>>>> -      the second Address and length of the register for ethernet LDO, this second
>>>> -      address range is only required by the platform IPQ50xx.
>>>> +    maxItems: 5
>>>> +    description: |
>>>> +      The first address and length of the register set for the MDIO controller,
>>>> +      the optional second address and length of the register is for CMN block,
>>>> +      the optional third, fourth and fifth address and length of the register
>>>> +      for Ethernet LDO, the optional Ethernet LDO address range is required by
>>>
>>> Wait, required? You said in in response to Rob these are not required!
>>
>> As for the response to Rob, i was saying the uniphy ahb and sys clocks
>> are not needed on ipq9574.
>> The LDO are needed on ipq5332 and ipq5018 currently.
> 
> Clocks as well but:
> 
> "A driver can function without knowing about all these new registers and
> ..."

This comments are for compatible string in V2, the MDIO drive configures
the hardware according to the DTS property defined or not for the new
added IPQ platforms(ipq5332 and ipq9574) support.

> 
> Anyway, this should be list ("items:") with descriptions, instead of one
> big description listing things.

Ok, will update to use the list descriptions, thanks.

> 
> 
>>
>>>
>>>> +      the platform IPQ50xx/IPQ5332.
>>>
>>> So these are valid for all platforms or not? Looks not, but nothing
>>> narrows the list for other boards.
>>
>> i add the limitation on the reg usage for the ipq5332 platform on the
>> following part "if condition" of this patch, i will update the patch
>> to narrow down for the other compatibles.
>>
>>>
>>> Anyway, why do you add entries in the middle? LDO was the second, so it
>>> cannot be now fifth.
>>
>> As Rob's suggestion, i move the cmn_blk to second location for
>> simplifying the limitation description, i checked the upstream dts code,
>> the LDO is not used currently, so we can move cmn_blk to the second
>> location here.
> 
> I cannot find his suggestion in the previous thread. Where did he
> propose it?

Rob suggested this on the V2 as below.
"
Perhaps cmn_blk should come 2nd, so all the variants have the same entry
indices. Then you can move this to the top level and just say 'minItems:
4' here.
"

> 
> ...
> 
>>>> +  qcom,cmn-ref-clock-frequency:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum:
>>>> +      - 25000000
>>>> +      - 31250000
>>>> +      - 40000000
>>>> +      - 48000000
>>>> +      - 50000000
>>>> +      - 96000000
>>>> +    default: 48000000
>>>> +    description: |
>>>> +      The reference clock source of CMN PLL block is selectable, the
>>>> +      reference clock source can be from wifi module or the external
>>>> +      xtal, the reference clock frequency 48MHZ can be from internal
>>>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>>>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
>>>
>>> This does not resolve mine and Conor's concerns from previous version.
>>> External clocks are defined as clock inputs.
>>
>> No matter the external or internal reference clock, they are the clock
>> source selection for CMN, there are only 48MHZ can be external or
>> internal, other clocks have the different clock rate, so the internal
>> 48MHZ reference clock can be implied when the
>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>> Conor in the previous
>> comments.
> 
> I don't think he proposed it, but maybe I missed some message (care to
> point me to his message where he agreed on usage of
> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
> same page, that the presence of clocks defines choice of internal clock.
> This property should go away.

Sorry for this confusion.
Rob said the internal reference source can be decided by the absence of
the property combined with compatible string, because i said the
internal 96MHZ is used on ipq5018 currently in the previous message.

per double checked the current IPQ platforms, the internal 96MHZ is also
possible on ipq9574, and the reference clock source should be kept as
configurable instead of limited by the compatible string, maybe the
different reference clock source is acquired in the future, even
currently it is not used on the special platform for now.

so i update the solution with a little bit of changes.

> 
> It is tiring to keep discussing this.
> 
>>
>>>
>>>> +
>>>> +  clock-frequency:
>>>> +    enum:
>>>> +      - 390625
>>>> +      - 781250
>>>> +      - 1562500
>>>> +      - 3125000
>>>> +      - 6250000
>>>> +      - 12500000
>>>> +    default: 390625
>>>> +    description: |
>>>> +      The MDIO bus clock that must be output by the MDIO bus hardware,
>>>> +      only the listed frequencies above can be supported, other frequency
>>>> +      will cause malfunction. If absent, the default hardware value 0xff
>>>> +      is used, which means the default MDIO clock frequency 390625HZ, The
>>>> +      MDIO clock frequency is MDIO_SYS_CLK/(MDIO_CLK_DIV + 1), the SoC
>>>> +      MDIO_SYS_CLK is fixed to 100MHZ, the MDIO_CLK_DIV is from MDIO control
>>>> +      register, there is higher clock frequency requirement on the normal
>>>> +      working case where the MDIO slave devices support high clock frequency.
>>>>    
>>>>    required:
>>>>      - compatible
>>>> @@ -59,8 +118,10 @@ allOf:
>>>>              contains:
>>>>                enum:
>>>>                  - qcom,ipq5018-mdio
>>>> +              - qcom,ipq5332-mdio
>>>>                  - qcom,ipq6018-mdio
>>>>                  - qcom,ipq8074-mdio
>>>> +              - qcom,ipq9574-mdio
>>>>        then:
>>>>          required:
>>>>            - clocks
>>>> @@ -70,6 +131,20 @@ allOf:
>>>>            clocks: false
>>>>            clock-names: false
>>>>    
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,ipq5332-mdio
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 5
>>>> +          maxItems: 5
>>>> +        reg-names:
>>>> +          minItems: 4
>>>
>>> Why all other variants now have 5 clocks and 5 reg entries? Nothing of
>>> it is explained in the commit msg.
>>
>>   From the condition above, only "qcom,ipq5332-mdio" has 5 clocks (mdio +
>> 4 uniphy clocks) and 4 regs (mdio + cmn_blk + 2 LDOs) as the cmn_blk is
>> moved to the second location.
>>
>> how it can gives the 5 clocks and 5 regs for other variants here?
> 
> How? Just read the beginning of your patch. It clearly says everyone has
> up to 5 reg entries and up to 5 clocks.

Sorry for missing the limitation of the new added regs and clocks for
other platforms, will update the patch to add the limitation usage of
the reg and clocks on the other platform.

Thanks!
> 
> 
> 
> Best regards,
> Krzysztof
> 

