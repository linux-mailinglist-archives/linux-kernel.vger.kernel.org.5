Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6939773C09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjHHP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHHP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3D5B92;
        Tue,  8 Aug 2023 08:44:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3786rO8j020060;
        Tue, 8 Aug 2023 06:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W6IibI3rqiPbbuFuoeCCniA1LWD+eNWd6v3UOXuPKAI=;
 b=fYWCgQSjgqVuGLs65hNtI74mN0J6uQH0Mg0U2a182VZwuHh2K1ImyYA7rs24wdM9KLbV
 Kb4g7RPF/s4oVKHwOO7zE1jgeDUqS5EgkBOgHjqsMoMnYKBRQ0Zc6O2xxwidAVwAEmjP
 xCkNjEroUQAb4P02GcTGuhdwhxbCO+1xHcItNzghk84xgren4sgU2aQ2cFFWt1fb09be
 UpI+BaaSwCq/Aoal5ELUj0sfvURHKb24Tb7BFs/suZocmJ+IXyVC8uiQHd8pKvYQNaOo
 Y5BDzCdm659f6WLob6Yw7SDAICBGQO+x2WYvLmqNF/bdYYNZXMA+ZKB/SzcAEF+VIinA GQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3saxbbt54p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 06:59:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3786x8dK012327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 06:59:08 GMT
Received: from [10.253.9.41] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 23:59:04 -0700
Message-ID: <15c2fed5-d2b7-3b25-8aa6-95453afee716@quicinc.com>
Date:   Tue, 8 Aug 2023 14:59:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
 <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
 <cf9788f0-a115-5ff9-1195-f4f302551e04@quicinc.com>
 <d1172ed6-ee3b-83b6-1656-c91e35fbc2df@linaro.org>
 <f25e1043-6dfa-2dcc-2948-88025f4881d8@quicinc.com>
 <1f20d778-cdae-d6d9-ac86-744dd45176d3@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1f20d778-cdae-d6d9-ac86-744dd45176d3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6lRNypmy0vf9QnMtd2t9BLMdQ74wz5Gq
X-Proofpoint-GUID: 6lRNypmy0vf9QnMtd2t9BLMdQ74wz5Gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_05,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=862 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080062
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 2:46 PM, Krzysztof Kozlowski wrote:
> On 08/08/2023 08:31, Jie Luo wrote:
>>
>>
>> On 8/8/2023 1:57 PM, Krzysztof Kozlowski wrote:
>>> On 08/08/2023 07:19, Jie Luo wrote:
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: qcom,nsscc-qca8k
>>>>>
>>>>> SoC name is before IP block names. See:
>>>>> Documentation/devicetree/bindings/arm/qcom-soc.yaml
>>>>>
>>>>> qca8k is not SoC specific. I don't know what you are documenting here,
>>>>> but if this is a SoC, then follow SoC rules.
>>>>>
>>>>> If this is not SoC, it confuses me a bit to use GCC binding.
>>>>>
>>>>> Anyway, this was not tested, as pointed out by bot... Please test the
>>>>> code before sending.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> Thanks for the review comments.
>>>> qca8383/qca8084 is a network chip that support switch mode and PHY mode,
>>>> the hardware register is accessed by MDIO bus, which is not a SOC.
>>>>
>>>> But it has the self-contained clock controller system, the clock
>>>> framework of qca8386/qca8084 is same as the GCC of ipq platform such as
>>>> ipq9574.
>>>
>>> OK
>>>
>>>>
>>>> would you help advise whether we can document it with the compatible
>>>> "qcom,qca8k-nsscc"?
>>>
>>> For example:
>>> qcom,qca8084-nsscc
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Thanks Krzysztof for the suggestion.
>>
>> i will document the compatible below.
>> "qcom,qca8084-nsscc" for the PHY mode of device.
>> "qcom,qca8386-nsscc" for the switch mode of device.
> 
> The clocks seem to be exactly the same for both, so use only one
> compatible in the driver (the fallback) and oneOf in the bindings like:
> 
> https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31
> 
> Best regards,
> Krzysztof
> 
Yes, it is the same driver for both.
i will update this in the next patch set, thanks Krzysztof.

Jie.
