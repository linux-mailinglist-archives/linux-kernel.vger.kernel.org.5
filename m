Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8E7934D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjIFF0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIFF0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:26:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190CCF1;
        Tue,  5 Sep 2023 22:26:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3865ALQ4012812;
        Wed, 6 Sep 2023 05:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EMHKGw7FOa3vEJGGc37bTqoMMu9Jp5jr8eYVYzNesdw=;
 b=cBHMhJkIAXJQC3db3p1Prtyftd7Js4XWvJwz5JR6mJmGgV0lTTlAZKuUVHqLIVgo00cK
 eZPfNHY79NWfI30n7hoOawvKXaUc6w4xStVcAnP2f5Z/aBJ8N/kneXnqA0fawsvLjjf4
 iJnjtN0/8VVGNTo6/F8G7Lfj3jD5dwsqCK55/6cn0fE84NnmZrs0mG+Zdd9OzfTiMJtk
 caBEw+4TcOMtEB6+DQfJQIpMzy4LRoNH3e4MTzCi95QNn02JsFigtR1ejr55UPYrRqdw
 YKshCfL78lSOZoLAL8nYD9+nZ8MM25u2sn/lUiRCzTVmF7eDeGyT80pqc7uEwoHXMRyY vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhg6ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 05:26:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3865QG7r026091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 05:26:16 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 22:26:09 -0700
Message-ID: <1838845b-9586-6f8c-a4d6-ef052e0a12db@quicinc.com>
Date:   Wed, 6 Sep 2023 10:56:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
Content-Language: en-US
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <abel.vesa@linaro.org>,
        <quic_wcheng@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <kernel@quicinc.com>
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-3-git-send-email-quic_rohiagar@quicinc.com>
 <37fe0c7e-60ad-4c27-b40f-471cc3d92e1c@linaro.org>
 <ea9df6f3-dfde-ea7a-af22-2a0839d82d32@quicinc.com>
In-Reply-To: <ea9df6f3-dfde-ea7a-af22-2a0839d82d32@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZVzo4nNmGSmBtXDRaQi-OqPleqZiiq1g
X-Proofpoint-ORIG-GUID: ZVzo4nNmGSmBtXDRaQi-OqPleqZiiq1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060049
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2023 10:52 AM, Rohit Agarwal wrote:
>
> On 9/6/2023 2:04 AM, Dmitry Baryshkov wrote:
>> On 05/09/2023 13:30, Rohit Agarwal wrote:
>>> Add dt-bindings for USB3 PHY found on Qualcomm SDX75.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 40 
>>> ++++++++++++++++++++--
>>>   1 file changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml 
>>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml 
>>>
>>> index f99fbbc..5725620 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>         - qcom,qcm2290-qmp-usb3-phy
>>>         - qcom,sa8775p-qmp-usb3-uni-phy
>>>         - qcom,sc8280xp-qmp-usb3-uni-phy
>>> +      - qcom,sdx75-qmp-usb3-uni-phy
>>
>> I think the ident is wrong here.
>
> Same. Somehow, your reply has the issue but original not able to see.
>
>>
>>>         - qcom,sm6115-qmp-usb3-phy
>>>       reg:
>>> @@ -38,9 +39,7 @@ properties:
>>>       maxItems: 2
>>>       reset-names:
>>> -    items:
>>> -      - const: phy
>>> -      - const: phy_phy
>>> +    maxItems: 2
>>>       vdda-phy-supply: true
>>>   @@ -75,6 +74,7 @@ allOf:
>>>             contains:
>>>               enum:
>>>                 - qcom,ipq9574-qmp-usb3-phy
>>> +              - qcom,sdx75-qmp-usb3-uni-phy
>>>       then:
>>>         properties:
>>>           clock-names:
>>> @@ -122,6 +122,40 @@ allOf:
>>>         required:
>>>           - power-domains
>>>   +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,ipq9574-qmp-usb3-phy
>>> +              - qcom,qcm2290-qmp-usb3-phy
>>> +              - qcom,sa8775p-qmp-usb3-uni-phy
>>> +              - qcom,sc8280xp-qmp-usb3-uni-phy
>>> +              - qcom,sm6115-qmp-usb3-phy
>>> +    then:
>>> +      properties:
>>> +        resets:
>>> +          maxItems: 2
>>> +        reset-names:
>>> +          items:
>>> +            - const: phy
>>> +            - const: phy_phy
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,sdx75-qmp-usb3-uni-phy
>>> +    then:
>>> +      properties:
>>> +        resets:
>>> +          maxItems: 2
>>> +        reset-names:
>>> +          items:
>>> +            - const: phy
>>> +            - const: common
>>
>> Could you please point us to the actual DTS patch adding this PHY? 
>> I'd say, it is highly likely that you are trying to bring in the 
>> unnecessary change.
> I have not posted the dt patches yet. But sdx75 uses these resets.
> GCC_USB3PHY_PHY_BCR, GCC_USB3_PHY_BCR
>
> These are same as sdx65 and sdx55.
Ok I see in your patch 
https://lore.kernel.org/linux-phy/20230824211952.1397699-17-dmitry.baryshkov@linaro.org/
you are updating the resets name. Fine, this change becomes unnecessary.
Will rebase my change on your patches.

Thanks,
Rohit.
>
> Thanks,
> Rohit.
>
>>
>>> +
>>>   additionalProperties: false
>>>     examples:
>>
