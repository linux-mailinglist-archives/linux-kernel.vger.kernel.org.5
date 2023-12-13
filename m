Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B338A810C64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjLMI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:27:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5091;
        Wed, 13 Dec 2023 00:27:19 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD7UFmv007336;
        Wed, 13 Dec 2023 08:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=3lO73/urnQDm+kr+1VeDVOz2JVDHAIwLqDv0H1bD5Iw=; b=Yl
        sTbejaClQy+tJ8J+U+DkXgP4bSDdsy1txWlLvJdoqOEG+7n8LuDChqdbPY/B0zks
        yP0wV4zT78EvblM5Zt+DDMonsU/cqTzx5gH9DWKzMLoQKNCGI/dRjZiqGLOIFtGA
        JJ0mSjOOhOET00dcpo/K7d72EO95pInk8lmy5T7aJ3udTYXYOCD82W3xHk74Tp24
        msQX0YiTZjqsQB9per3qb3f4oiM5xtgIRUYbJfCzlQETfR59l8wDsnAHdM7cmRpC
        RUyq2QgbXIM28wEBaSZbdTucJ8kmdBhyEeEpoTv7jbKLF/3yHcsQ/9yrMPCGeLxw
        Ng+Tpn2nsdhnMftTmu3w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy3rprs48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 08:27:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BD8R4Dp012447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 08:27:04 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 00:26:59 -0800
Message-ID: <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
Date:   Wed, 13 Dec 2023 16:26:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231212-caution-improvise-ed3cc6a1d305@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IhyU1Oqb6UTIJDWGvhhHChFCzN1KcSsK
X-Proofpoint-GUID: IhyU1Oqb6UTIJDWGvhhHChFCzN1KcSsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2023 12:06 AM, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
>> Update the yaml file for the new DTS properties.
>>
>> 1. cmn-reference-clock for the CMN PLL source clock select.
>> 2. clock-frequency for MDIO clock frequency config.
>> 3. add uniphy AHB & SYS GCC clocks.
>> 4. add reset-gpios for MDIO bus level reset.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++++-
>>   1 file changed, 153 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> index 3407e909e8a7..9546a6ad7841 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>> @@ -20,6 +20,8 @@ properties:
>>             - enum:
>>                 - qcom,ipq6018-mdio
>>                 - qcom,ipq8074-mdio
>> +              - qcom,ipq9574-mdio
>> +              - qcom,ipq5332-mdio
>>             - const: qcom,ipq4019-mdio
>>   
>>     "#address-cells":
>> @@ -30,19 +32,71 @@ properties:
>>   
>>     reg:
>>       minItems: 1
>> -    maxItems: 2
>> +    maxItems: 5
>>       description:
>> -      the first Address and length of the register set for the MDIO controller.
>> -      the second Address and length of the register for ethernet LDO, this second
>> -      address range is only required by the platform IPQ50xx.
>> +      the first Address and length of the register set for the MDIO controller,
>> +      the optional second, third and fourth address and length of the register
>> +      for ethernet LDO, these three address range are required by the platform
>> +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for the CMN clock
>> +      to select the reference clock.
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    maxItems: 5
>>   
>>     clocks:
>> +    minItems: 1
>>       items:
>>         - description: MDIO clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>   
>>     clock-names:
>> +    minItems: 1
>>       items:
>>         - const: gcc_mdio_ahb_clk
>> +      - const: gcc_uniphy0_ahb_clk
>> +      - const: gcc_uniphy1_ahb_clk
>> +      - const: gcc_uniphy0_sys_clk
>> +      - const: gcc_uniphy1_sys_clk
> 
>> +  cmn-reference-clock:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - 0   # CMN PLL reference internal 48MHZ
>> +              - 1   # CMN PLL reference external 25MHZ
>> +              - 2   # CMN PLL reference external 31250KHZ
>> +              - 3   # CMN PLL reference external 40MHZ
>> +              - 4   # CMN PLL reference external 48MHZ
>> +              - 5   # CMN PLL reference external 50MHZ
>> +              - 6   # CMN PLL reference internal 96MHZ
> 
> Why is this not represented by an element of the clocks property?

This property is for the reference clock source selection of CMN PLL,
CMN PLL generates the different clock rates for the different Ethernet
blocks, this CMN PLL configuration is not located in the GCC, so the
clock framework can't be used, which is the general hardware register
instead of RCG register for GCC.

> 
>> +  clock-frequency:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - 12500000
>> +              - 6250000
>> +              - 3125000
>> +              - 1562500
>> +              - 781250
>> +              - 390625
>> +    description:
>> +      The MDIO bus clock that must be output by the MDIO bus hardware,
>> +      only the listed frequecies above can be configured, other frequency
>> +      will cause malfunction. If absent, the default hardware value is used.
> 
> Likewise.
> 
> Your commit message contains a bullet point list of what you are doing,
> but there's no explanation here for why custom properties are required
> to provide clock information.
> 
> Thanks,
> Conor.

Hi Conor,
This property clock-frequency is optional to configure the MDIO working
clock rate, and this is the MDIO general DT property, since the hardware
default clock rate is 390625HZ, there is requirement for higher clock 
rate in the normal working case, i will update this information in the
next patch set.
