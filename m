Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD753762A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGZFEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGZFD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:03:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF591BD1;
        Tue, 25 Jul 2023 22:03:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q3oTXd028986;
        Wed, 26 Jul 2023 05:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=twyDZLScuqcGg4FhKhnDQK0Vk+FnacqmKE1iB5S0/2c=;
 b=F5tn/tF5kmwgTpsO6G2QxjEFHjbw/uGl+wLfutJLhDG7jveGtV/VKMHaWfSRNV7935m9
 gZr5vX7xm9raZiUBNfY64g4ENUDaFQcCUWr+fiMcoEiPvWEHL3/k8okZPhQHSlz4WUJm
 uMHggE/4xRr1AyGfMBfZ2WgB1YLccawq8hYLlagJrFXpUUcchTWKFUE3NlyqZtwMZbvE
 Piqmxb8UsUCItNYHMK6IIlcB6LfDNh53d4EK02MVjTMDDlNkVq0FDomrqpOXxEtFNpiw
 XTUbKw9HH/sJ/CaDR/aAMy4f9z0auapw/J5Mht2NUvJt6JHFi7gEs0rGOnOxQADFcavW NA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1sfa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:03:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q53oBN005206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:03:50 GMT
Received: from [10.201.206.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 22:03:45 -0700
Message-ID: <c1903d09-f307-8e80-0482-2040c7af7a2c@quicinc.com>
Date:   Wed, 26 Jul 2023 10:33:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-Cx and AL03-C2
 boards based on IPQ9574 family
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230720084534.6461-1-quic_sridsn@quicinc.com>
 <20230720084534.6461-2-quic_sridsn@quicinc.com>
 <87c3a3db-d172-bc98-cf83-89b874c9fee7@linaro.org>
 <9e401641-1334-c0bc-c49a-481a8a9af2de@linaro.org>
Content-Language: en-US
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <9e401641-1334-c0bc-c49a-481a8a9af2de@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3fxnL8_Nr9u4J7ucZ9i_RXs-KoAjGJNn
X-Proofpoint-ORIG-GUID: 3fxnL8_Nr9u4J7ucZ9i_RXs-KoAjGJNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260043
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/20/2023 3:18 PM, Konrad Dybcio wrote:
> On 20.07.2023 10:49, Krzysztof Kozlowski wrote:
>> On 20/07/2023 10:45, Sridharan S N wrote:
>>> Document the below listed (Reference Design Platform) RDP boards based on IPQ9574
>>> family of SoCs.
>>>
>>> AL02-C3  - rdp437
>>> AL02-C7  - rdp433-mht-phy
>>> AL02-C10 - rdp433-mht-switch
>>> AL02-C11 - rdp467
>>> AL02-C12 - rdp455
>>> AL02-C13 - rdp459
>>> AL02-C15 - rdp457
>>> AL02-C16 - rdp456
>>> AL02-C17 - rdp469
>>> AL02-C19 - rdp461
>>> AL03-C2  - rdp458
>>>
>>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/arm/qcom.yaml         | 20 +++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index dd66fd872c31..d992261da691 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -89,10 +89,20 @@ description: |
>>>           adp
>>>           ap-al01-c1
>>>           ap-al02-c2
>>> +        ap-al02-c3
>>>           ap-al02-c6
>>>           ap-al02-c7
>>>           ap-al02-c8
>>>           ap-al02-c9
>>> +        ap-al02-c10
>>> +        ap-al02-c11
>>> +        ap-al02-c12
>>> +        ap-al02-c13
>>> +        ap-al02-c15
>>> +        ap-al02-c16
>>> +        ap-al02-c17
>>> +        ap-al02-c19
>> Why? I asked once, but there was no feedback from Qualcomm.
>>
>> Why do we need to do this? What's the point?
> Another question would be, whether these boards are just one-off test
> prototypes of which there exist like 5-10 units, or are they actually
> going to be supported and useful.
>
> If it's the former, I don't think it makes sense to keep the device
> trees upstream.
>
> Konrad

These are all not test rdps and each rdps has its own configurations. 
IPQ9574 has four pcie instances and one QDSP processor. Not all rdps use 
all of the interfaces and it will vary for each rdp. In next version , 
will post with each rdp's configuration explicitly

Thanks,

Sridharan

