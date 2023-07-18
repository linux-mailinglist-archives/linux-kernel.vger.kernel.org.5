Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7048757B91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGRMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjGRMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:11:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7D1B5;
        Tue, 18 Jul 2023 05:11:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7tj3Z007921;
        Tue, 18 Jul 2023 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qicE+6lTC121MT8pLjYZ4FxN8NX1s5aYMJ5jJMYSL+M=;
 b=VXJv4+sxM3T7OJxmAXkLdIQsLDLLL09alzL0w5K5R1uM7VAIsgFigGLeuz6rgMRr0DY3
 DQ7qanJxQIovlSJstNsma356CoBBT3mYp9WHptvw8RYPxtUjtzsCnVJ35wc8mxbxMjEp
 jSUnta0qO0EAtjDS9iKPgGQEhojj77cWB1vJeTNFiaUO1nrSRKSycC+9nJyQK+73mAgQ
 i7CSLJzeonhyeAQR5q1AwuZhTUHFy3j2f5R751IwV3fGxO989Cs7h6vLFOKpwbAUsfok
 Xvd5EpJYsWdIRoy2xzRZi8yWSAhbirlrhwOpkuflxpf9BH86YjjSlhbfsGZej9Vrf8eO iQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwps58kkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:11:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ICBAFf012712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:11:10 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 05:11:02 -0700
Message-ID: <0fbbb9c9-f215-cf41-ec34-8c726a167bbf@quicinc.com>
Date:   Tue, 18 Jul 2023 17:40:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kalle Valo <kvalo@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
 <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
 <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
 <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
 <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
 <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
 <8dbd8330-de83-b663-8105-e33c16687a88@linaro.org>
 <c312824f-1438-d5de-d139-aaeb63f3c566@quicinc.com>
 <2eace846-1feb-4299-4678-e1ff06179fdc@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <2eace846-1feb-4299-4678-e1ff06179fdc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: es7lR4CRbal2WXIQYug0-9Cp5r1i5PE-
X-Proofpoint-ORIG-GUID: es7lR4CRbal2WXIQYug0-9Cp5r1i5PE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_08,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180111
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/2023 4:21 PM, Krzysztof Kozlowski wrote:
> On 30/06/2023 09:12, Manikanta Mylavarapu wrote:
>>
>>
>> On 6/24/2023 12:49 PM, Krzysztof Kozlowski wrote:
>>> On 21/06/2023 13:39, Manikanta Mylavarapu wrote:
>>>>>> on number of wcss radios connected on that board and only one instance
>>>>>> of 'qcom,ipq5018-q6-mpd'.
>>>>>>
>>>>>
>>>>> I don't understand why the user protection domains need a specific
>>>>> compatible. Why do they need compatible at all?
>>>>>
>>>>> Not mentioning that amount of your domains on Q6 is actually fixed per
>>>>> SoC and probably should not be in DT at all.
>>>>>
>>>>      root domain is fixed per soc (One Q6 DSP, one per soc)
>>>>      user domain(s) are variable (based on number of wcss radios attached)
>>>>
>>>>      The sequence to initialize, bring up, tear down the Q6 and wcss radios
>>>>      are completely different. So in order to differentiate them, we will
>>>>      need different compatibles. So this is a new rproc driver/architecture
>>>>      which has a parent/child topology (Q6 DSP -> Master/parent controls
>>>>      the WCSS (child)).
>>>
>>> I understand you need different properties, but I don't see yet the
>>> benefit of creating here artificial compatibles. Look at your ipq9574
>>> DTSI change - it does not use even ipq9574 compatibles for 66% of its
>>> children.
>>>
>>> Maybe you should have there just property describing type of device or
>>> bringup?
>>>
>>
>> 	Yeah i got your point. Indeed the requirement here is to
>> 	have device specific compatibles, so will have just two
>> 	compatible one for Q6-MPD and another for WCSS-MPD device's
>>
>>
>> 	"qcom,q6-mpd" --> For Q6-MPD device
>> 	"qcom,wcss-mpd" --> For WCSS-MPD device
>>
>> 	Is this approach fine ?
> 
> Can you fix your reply style, so it is like on every mailing list? Some
> weird indentation does no help to read it.
>

Sure, i will change my reply style and don't use any indentation.
Sorry for inconvenience.

> I was proposing to drop compatibles entirely. Making compatibles generic
> is not solving any of my concerns.
> 
> I don't understand what do you want to achieve here and very limited
> description of the hardware in the binding does not help.
> 

Sure, i remove user pd compatibles. In root pd probe itself, user pd
remoteproc's are taken care. Also I updated diagram in cover page, it
gives enough information.

>>
>>> Given SoC cannot come with different amount of children (PD) and
>>> different amount of radios. You even fix the firmware name, so
>>> boards/customers cannot use anything else. It's fixed and the only
>>> variable element here is disabling some of the blocks per board, if they
>>> do not have physical interface (e.g. radio).
>>>
>>> You even hard-code the number of PD by using "pd-[123]", without unit
>>> address, so you do not expect it will grow.
>>>
>>> Unless you want to say that these are devices? But your binding does not
>>> really suggest it...
>>>
>>>
>>> 	Yes, as i mentioned above the requirement is to have device
> 
> What requirement? You did not describe anything. Binding describes
> hardware, not your requirements.
> 
> Binding said nothing about devices.
> 

Yeah got your point. So we removed userpd compatibles from dt-bindings.


>> 	specific bindings. We will remove "PD-X" from soc dtsi and
>> 	add it in board dts file.
> 
> Why? How is it related to the bindings? What does it solve? Instead of
> doing some changes you should explain why.
> 
>>
>> 	So soc dts would have "Q6-MPD" master node & board dts have
>> 	"WCSS-MPD" child nodes based on number of radio's connected
>> 	on board.
>>
>> 	Is this fine ?
>>
> 
> Why?
> 

"PD-X" controls user pd WCSS bring up. WCSS blocks may vary based on
number of radio's connected on board but QDSP6 is always present.
So i will keep Q6 node in soc dtsi file and move 'PD-X' node to board
dts file.

Thanks & Regards,
Manikanta.

> Best regards,
> Krzysztof
> 
