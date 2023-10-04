Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB67B7C02
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbjJDJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJDJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:24:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751CAC;
        Wed,  4 Oct 2023 02:24:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3946vqNe014209;
        Wed, 4 Oct 2023 09:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CPKY0KHDc27eErZGiD+w0+dVq/2NlzHvFtu3lSawsVg=;
 b=SiNN/LXxJCPGICklCDS1k169miOBJF0eQmwDg13SdQqNZi0cre4dnqcgQDxv0IOX0zcK
 px5Xxsoi6oVprCzDqQ9uLHfQwJSDfwOcGYZvJUAT/HBmoHijr3lNM62ILJ6OP7EpGr1V
 jGfde1inx1qps3ma7TbwbhJDJsimuaV7/xLTxWL9mnbKLa9G1ypuHy0qNhPRn0gK7xKu
 1LUKVKyhx0x5QELRnKwb3x6K7o0giPWNh97xfzxpjHWKbge7cg5DKv7Srkbd3iZTJVYk
 gMCe4z0peQ/HDDC5PSkZDNWrHLg9odpu2lhPKvsQ+BNYgr58YZNsquVWMc5CBmsuKSlV nQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th2gq0bux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:24:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3949NtFc005407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:23:55 GMT
Received: from [10.216.40.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 02:23:49 -0700
Message-ID: <5d31facd-8942-d159-a1f1-cd7cae6c09a5@quicinc.com>
Date:   Wed, 4 Oct 2023 14:53:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V13 3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd
 support for IPQ6018
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20231004090449.256229-1-quic_devipriy@quicinc.com>
 <20231004090449.256229-4-quic_devipriy@quicinc.com>
 <60da3633-61f6-49c1-b656-2804c35d3e82@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <60da3633-61f6-49c1-b656-2804c35d3e82@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: poa95C6L0UdTS1Fdu1GyMSQWiZJbkn-7
X-Proofpoint-ORIG-GUID: poa95C6L0UdTS1Fdu1GyMSQWiZJbkn-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040067
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2023 2:50 PM, Krzysztof Kozlowski wrote:
> On 04/10/2023 11:04, Devi Priya wrote:
>> Update the binding to include pwm as the child node to TCSR block and
>> add simple-mfd support for IPQ6018.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>>     reg:
>>       maxItems: 1
>>   
>> +  ranges: true
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +patternProperties:
>> +  "pwm@[a-f0-9]+$":
> 
> type: object
Okay
> 
>> +    $ref: ../pwm/qcom,ipq6018-pwm.yaml
> 
> This should be full patch, so:
> $ref: /schemas/pwm/qcom.......
okay
> 
> 
>> +
>>   required:
>>     - compatible
>>     - reg
> 
> After required (but before additionalProperties), please add:
> 
> allOf:if:then: for other compatible (so use keyword "not:") which will
> disallow pwm for them. Disallowing is via:
> 
>      patternProperties:
>        "pwm@[a-f0-9]+$": false
> 
> See   Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> around line 240. We need something similar.
Sure, will add!
> 
> 
>> @@ -57,8 +74,29 @@ required:
>>   additionalProperties: false
>>   
>>   examples:
>> +  # Example 1 - Syscon node found on MSM8960
>>     - |
>>       syscon@1a400000 {
>>           compatible = "qcom,tcsr-msm8960", "syscon";
>>           reg = <0x1a400000 0x100>;
>>       };
>> +  # Example 2 - Syscon node found on IPQ6018
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
>> +
>> +    syscon@1937000 {
>> +        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>> +        reg = <0x01937000 0x21000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0 0x1937000 0x21000>;
> 
> Please put ranges just after reg.
Sure,okay

Thanks,
Devi Priya
> 
>> +
>> +        pwm: pwm@a010 {
>> +            compatible = "qcom,ipq6018-pwm";
>> +            reg = <0xa010 0x20>;
> 
> Best regards,
> Krzysztof
> 
