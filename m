Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45362758465
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGRSSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGRSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:18:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56144F7;
        Tue, 18 Jul 2023 11:18:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IGmHg7009181;
        Tue, 18 Jul 2023 18:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l4pXiPpeYymHMYShWK/s3/TFJSTWiPRwLM8s3s2kGNc=;
 b=NF16cfC2dAJyLyz8U0D28eSR70AFuZkQnii/q64wm8vweI8uwRdHNuvb71Vzy/rNPtxv
 HfDLWh25+vD/twWjbT8/VbF0YRuJO2S0XvepDJJjrJEaDTco+2T09bA9NBRU/rVg6NlQ
 JXYZpoGfDQbZsJsZ2RQwXJbs+FdNSXMKeqmPSwWz0z0OTxBJTOnWigSjx2+RkaHnQpzL
 1cCqgiXNd1v5hDVevQfqheQhlJAk+5FNVT/n7jy8UjGhoUjaCG7gYvKKSSBANFpKvHPr
 Eqy32wwLPaajgiLJrcTYPL3WEDrHUKOYf3vAI9eAcxpdz+rSCeB8W2JgAqmMgjb1Mdcv Cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwqqg9ajm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 18:18:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IIIW8c002707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 18:18:32 GMT
Received: from [10.110.49.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 11:18:32 -0700
Message-ID: <4753a76c-d0ee-4371-9f70-ffc57d39ff1a@quicinc.com>
Date:   Tue, 18 Jul 2023 11:18:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add qcom specific hvc transport for
 SCMI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-2-quic_nkela@quicinc.com>
 <d05fcac3-1054-6b52-e9d8-15baba424863@linaro.org>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <d05fcac3-1054-6b52-e9d8-15baba424863@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f1KiiObHY6D0zZ2mdTo3imAwRGXdePbr
X-Proofpoint-ORIG-GUID: f1KiiObHY6D0zZ2mdTo3imAwRGXdePbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/2023 11:12 AM, Krzysztof Kozlowski wrote:
> On 18/07/2023 18:08, Nikunj Kela wrote:
>> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
>> transport channel for Qualcomm virtual platforms.
>> The compatible mandates a shared memory channel.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   .../bindings/firmware/arm,scmi.yaml           | 69 +++++++++++++++++++
>>   1 file changed, 69 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index b138f3d23df8..605b1e997a85 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -45,6 +45,9 @@ properties:
>>         - description: SCMI compliant firmware with OP-TEE transport
>>           items:
>>             - const: linaro,scmi-optee
>> +      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
>> +        items:
>> +          - const: qcom,scmi-hvc-shmem
>>   
>>     interrupts:
>>       description:
>> @@ -321,6 +324,16 @@ else:
>>         required:
>>           - linaro,optee-channel-id
>>   
>> +    else:
>> +      if:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: qcom,scmi-hvc-shmem
>> +      then:
>> +        required:
>> +          - shmem
> Unfortunately this pattern if-else-if-else-if-else does not scale well.
> Please convert all entries first to allOf:if:then,if:then,if:then (in
> new patch), and then add new if:then:
Ok!
>
>> +
>>   examples:
>>     - |
>>       firmware {
>> @@ -444,6 +457,62 @@ examples:
>>           };
>>       };
>>   
>> +  - |
>> +    firmware {
>> +        scmi_dpu {
> No underscores in node names.
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
ACK!
>
>
>
>> +            compatible = "qcom,scmi-hvc-shmem";
>> +            shmem = <&shmem_dpu>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            scmi_pd_dpu: protocol@11 {
>> +                reg = <0x11>;
>> +                #power-domain-cells = <1>;
>> +            };
>> +        };
>> +
> Add only one example, but then only if it differs significantly. I see
> no differences - except compatible - so maybe no point of examples.
Other than the compatible, it also doesn't require smc-id, we read it 
from shmem region.  Will remove examples.
>
>
>> +        scmi_gpu {
>> +            compatible = "qcom,scmi-hvc-shmem";
>> +            shmem = <&shmem_gpu>;
> This example for sure is not needed - you duplicate above.
Right, will remove this example.
>
>> +
>> +            interrupts = <GIC_SPI 931 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "a2p";
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            scmi_pd_gpu: protocol@11 {
>> +                reg = <0x11>;
>> +                #power-domain-cells = <1>;
>> +            };
>> +        };
>> +    };
>> +
>> +    soc {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        sram@95c00000 {
>> +            compatible = "mmio-sram";
>> +            reg = <0x95c00000 0x10000>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            shmem_dpu: scmi-sram-dpu@95c00000 {
>> +                compatible = "arm,scmi-shmem";
>> +                reg = <0x95c00000 0x3f0>;
>> +            };
> How does these differ from existing example?

It doesn't. Will remove the example as suggested. Thanks


>
> Best regards,
> Krzysztof
>
