Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34E792BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbjIERAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353686AbjIEHOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:14:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9BCC2;
        Tue,  5 Sep 2023 00:14:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3855JpU7027600;
        Tue, 5 Sep 2023 07:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Jr56pPCe7vVwa+GfRWq+o850n4WReVzh3wS0xw4a67s=;
 b=ZTDcYurxmtEMP6fV0CX3+5wcYejARGL4n02HeWnyTdZJLZOr74QGq2oU3ss0nmL8u/+8
 vwaoxS8FM8unLsnNm1PAp9PoLd5mhh80IJKyDBb+8U5Vd6hIA2bC2qC7Sv+ggRy06ArB
 YOvZC77M2hqe1ihJsEH0DEitDGKvHfFQbg4OJwiho2c43B3SARCSNZQSIdoxlIE59baB
 SM5PEYfcNDeCRXIZ6WsPvrpot6f/VlRtFuzFEKtN/V4sZVydl8BwN4VK+ztS6r8jwoG+
 CS2JL+vH0odLFMqy48PD9ucgbMVdHVWnkrtYllO8J4JOU7FFSsYvPIDKzGikopfyOe6O sA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcrcyct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 07:14:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3857EOrB017725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 07:14:24 GMT
Received: from [10.216.59.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 00:14:17 -0700
Message-ID: <4c0736a1-eb9e-b81f-06ad-7ed407dbc702@quicinc.com>
Date:   Tue, 5 Sep 2023 12:44:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add compatibles for SDX75
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889975-19122-2-git-send-email-quic_rohiagar@quicinc.com>
 <c19e0ecf-7e8c-b9c3-0741-40c7aa3cb200@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <c19e0ecf-7e8c-b9c3-0741-40c7aa3cb200@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BA2MT8c0g0iXhHun8UP_yJ0s5qAEazoh
X-Proofpoint-ORIG-GUID: BA2MT8c0g0iXhHun8UP_yJ0s5qAEazoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050063
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2023 12:29 PM, Krzysztof Kozlowski wrote:
> On 05/09/2023 06:59, Rohit Agarwal wrote:
>> Add dt-bindings compatibles and interconnect IDs for
>> Qualcomm SDX75 platform.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   .../bindings/interconnect/qcom,sdx75-rpmh.yaml     | 100 ++++++++++++++++++++
>>   include/dt-bindings/interconnect/qcom,sdx75.h      | 102 +++++++++++++++++++++
>>   2 files changed, 202 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
>>   create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
>> new file mode 100644
>> index 0000000..f2dc87c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,sdx75-rpmh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm RPMh Network-On-Chip Interconnect on SDX75
>> +
>> +maintainers:
>> +  - Georgi Djakov <djakov@kernel.org>
> I don't think Georgi maintains this device. It's maintainer of device,
> not the subsystem.
Ok, Will update the maintainer.
>
>> +
>> +description:
>> +  RPMh interconnect providers support system bandwidth requirements through
>> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
>> +  associated with each execution environment. Provider nodes must point to at
>> +  least one RPMh device child node pertaining to their RSC and each provider
>> +  can map to multiple RPMh resources.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sdx75-clk-virt
>> +      - qcom,sdx75-dc-noc
>> +      - qcom,sdx75-gem-noc
>> +      - qcom,sdx75-mc-virt
>> +      - qcom,sdx75-pcie-anoc
>> +      - qcom,sdx75-system-noc
>> +
>> +  '#interconnect-cells': true'
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +allOf:
>> +  - $ref: qcom,rpmh-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sdx75-clk-virt
>> +              - qcom,sdx75-mc-virt
>> +    then:
>> +      properties:
>> +        reg: false
>> +    else:
>> +      required:
>> +        - reg
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sdx75-clk-virt
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: RPMH CC QPIC Clock
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sdx75-clk-virt
> This if: clause should be merged with the one earlier.
Ok, understood.
>> +    then:
>> +      required:
>> +        - clocks
>> +    else:
>> +      properties:
>> +        clocks: false
>> +
>> +required:
>> +  - compatible
> Please keep the order like in example-schema, so required: goes before
> allOf.
Sure, will update this.

Thanks,
Rohit.
>> +
>> +unevaluatedProperties: false
> Best regards,
> Krzysztof
>
