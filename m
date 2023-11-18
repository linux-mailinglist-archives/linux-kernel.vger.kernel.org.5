Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998377EFE73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjKRIHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjKRIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:07:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9530D5D;
        Sat, 18 Nov 2023 00:07:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI7a4sH024517;
        Sat, 18 Nov 2023 08:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HCBNS+RoQsIDvjafJAvRjkAYymAZefxDdkPg6CwX7aI=;
 b=P46aDAL5YtWR4T/uzWOcxnvUjhxajndri1p/msia8MY83BncEeF/U0uzvfbwJVtmo952
 l+pNPBC1L1xqx5bt500QmpGi1koGHHTWCprKZHntPPS+MsdNOmI67IzaDKO/HCLBMMOT
 YwngdlqAOasjz57kq4DmYaaNl2B6glm6IOd5LdNsbvtSmYesnndgUZUYQKkiuozYGyet
 d7+bgtEik39GZq7qrG0wF2ep26Vsq+gc93V2mjlRjVUc7Hle0CpP0A8yFABW7yDhOZ/H
 0cJdPlTiDraVvE86fTXjy6BK68kELO5nLY+RDKmq+xpaTMB3DseCF9uHEyDwrAwxBsSU MQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uep1qr7aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 08:07:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI87Dnw023484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 08:07:13 GMT
Received: from [10.253.8.221] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 18 Nov
 2023 00:07:08 -0800
Message-ID: <de4fa95e-4bc7-438a-94bb-4b31b1b89704@quicinc.com>
Date:   Sat, 18 Nov 2023 16:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-10-quic_luoj@quicinc.com>
 <834cbb58-3a88-4ba6-8db6-10440a4d0893@linaro.org>
 <76e081ba-9d5a-41df-9c1b-d782e5656973@quicinc.com>
 <2a9bb683-da73-47af-8800-f14a833e8ee4@linaro.org>
 <386fcee0-1eab-4c0b-8866-a67821a487ee@quicinc.com>
 <77a194cd-d6a4-4c9b-87f5-373ed335528f@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <77a194cd-d6a4-4c9b-87f5-373ed335528f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S1IxcI4idQDzTWEvoKDYaTWkaAf4VhZK
X-Proofpoint-ORIG-GUID: S1IxcI4idQDzTWEvoKDYaTWkaAf4VhZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_07,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 8:43 PM, Krzysztof Kozlowski wrote:
> On 17/11/2023 12:20, Jie Luo wrote:
>>
>>
>> On 11/17/2023 6:40 PM, Krzysztof Kozlowski wrote:
>>> On 17/11/2023 11:36, Jie Luo wrote:
>>>>>>       clocks:
>>>>>> -    items:
>>>>>> -      - description: MDIO clock source frequency fixed to 100MHZ
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 5
>>>>>> +    description:
>>>>>
>>>>> Doesn't this make all other variants with incorrect constraints?
>>>>
>>>> There are 5 clock items, the first one is the legacy MDIO clock, the
>>>> other clocks are new added for ipq5332 platform, will describe it more
>>>> clearly in the next patch set.
>>>
>>> OTHER variants. Not this one.
>>
>> The change here is for the clock number added for the ipq5332 platform,
>> the other platforms still use only legacy MDIO clock.
> 
> Then your patch is wrong as I said. You now affect other variants. I
> don't quite get your responses. Style of them suggests that you
> disagree, but you are not providing any relevant argument.

The clock arguments are provided in the later part as below. i will also
provide more detail clock names for the new added clocks for the ipq5332
platform in description.

   - if: 

       properties: 

         compatible: 

           contains: 

             enum: 

               - qcom,ipq5332-mdio 

     then: 

       properties: 

         clocks: 

           items: 

             - description: MDIO clock source frequency fixed to 100MHZ 

             - description: UNIPHY0 AHB clock source frequency fixed to 
100MHZ
             - description: UNIPHY0 SYS clock source frequency fixed to 
24MHZ
             - description: UNIPHY1 AHB clock source frequency fixed to 
100MHZ
             - description: UNIPHY1 SYS clock source frequency fixed to 
24MHZ
         clock-names: 

           items: 

             - const: gcc_mdio_ahb_clk 

             - const: gcc_uniphy0_ahb_clk 

             - const: gcc_uniphy0_sys_clk 

             - const: gcc_uniphy1_ahb_clk 

             - const: gcc_uniphy1_sys_clk
> 
>>
>> so i add minItems  and maxItems, i will check other .yaml files for the
>> reference.
>>
>>>
>>>>
>>>>>
>>>>>> +      MDIO system clock frequency fixed to 100MHZ, and the GCC uniphy
>>>>>> +      clocks enabled for resetting ethernet PHY.
>>>>>>     
>>>>>>       clock-names:
>>>>>> -    items:
>>>>>> -      - const: gcc_mdio_ahb_clk
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 5
>>>>>> +
>>>>>> +  phy-reset-gpio:
>>>>>
>>>>> No, for multiple reasons. It's gpios first of all. Where do you see such
>>>>> property? Where is the existing definition?
>>>>
>>>> will remove this property, and update to use the exited PHY GPIO reset.
>>>>
>>>>>
>>>>> Then it is "reset-gpios" if this is MDIO. Why do you put phy properties
>>>>> in MDIO?
>>>>>
>>>>>> +    minItems: 1
>>>>>> +    maxItems: 3
>>>>>> +    description:
>>>>>> +      GPIO used to reset the PHY, each GPIO is for resetting the connected
>>>>>> +      ethernet PHY device.
>>>>>> +
>>>>>> +  phyaddr-fixup:
>>>>>> +    description: Register address for programing MDIO address of PHY devices
>>>>>
>>>>> You did not test code which you sent.
>>>>
>>>> Hi Krzysztof,
>>>> This patch is passed with the following command in my workspace.
>>>> i will upgrade and install yamllint to make sure there is no
>>>> warning reported anymore.
>>>>
>>>> make dt_bg_check
>>>
>>> No clue what's this, but no, I do not believe you tested it at all. It's
>>> not about yamllint. It's was not tested. Look at errors reported on
>>> mailing list.
>>>
>>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>
>>
>> Hi Krzysztof,
>> Here is the output when i run the dt check with this patch applied in my
>> workspace, md64 is the alias for compiling the arm64 platform.
> 
> We still do not know your base and dtschema version.

The code base is the commit id:
5ba73bec5e7b0494da7fdca3e003d8b97fa932cd
<Add linux-next specific files for 20231114>

The dtschema version is as below.
dt-doc-validate --version
2023.9


> 
> 
> Best regards,
> Krzysztof
> 
