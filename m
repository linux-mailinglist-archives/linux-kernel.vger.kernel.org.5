Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5987B2EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjI2I5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjI2I5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:57:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A201A8;
        Fri, 29 Sep 2023 01:57:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7iiO4028762;
        Fri, 29 Sep 2023 08:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KQ3u7Qmhp7iKbIJY4O4pne6xiBdvsIY4Nchj4nodMHg=;
 b=RKroOJxuZznhDQmZKPFtqoKTdxpzS7soxOXFMtUi36wTyWMtOks37pGLqxOeUNXQXxu2
 Hd2HCCVFFfNnioGs6Yg7yFLZW0fKU00lrrxwKf3P3XxB/a+VLZDk3Gb2xpbIHe6969Y7
 HvipsGgX76CyUYBbOyVU2UEitn4pdF14w9uRcCMGZpipPb0lYCebi4OVZHcAPjegHv8T
 LZ6LAM0pr6L7I4eYBpvcjNEhmB5vUaraPkNDM2Cgu8YI4dRzq5cI6elvAaCICdv1t2aq
 YDMAOpvpDfIaabvwIdrFwaRe0qx/GasY/ILH/c15Bop/XDz/iyehyBxvcmu/nQMWPekN 4g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td8wdt9k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 08:57:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T8v46U007495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 08:57:04 GMT
Received: from [10.216.56.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 01:56:57 -0700
Message-ID: <4636a990-1044-1f67-dae5-8583f96021be@quicinc.com>
Date:   Fri, 29 Sep 2023 14:26:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V12 2/3] dt-bindings: pwm: add IPQ6018 binding
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
References: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
 <20230925065915.3467964-3-quic_devipriy@quicinc.com>
 <42338d41-1b90-4f77-958e-479d32e0ce1d@linaro.org>
 <59c9dbdb-8673-8dc7-ecca-32ff120ccf80@quicinc.com>
In-Reply-To: <59c9dbdb-8673-8dc7-ecca-32ff120ccf80@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w7IM-BZdzVl7rNO8FWfDSO_IEViaS47x
X-Proofpoint-GUID: w7IM-BZdzVl7rNO8FWfDSO_IEViaS47x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290076
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 1:25 PM, Devi Priya wrote:
> 
> 
> On 9/25/2023 12:41 PM, Krzysztof Kozlowski wrote:
>> On 25/09/2023 08:59, Devi Priya wrote:
>>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>>>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>
>> ...
>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml 
>>> b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>> new file mode 100644
>>> index 000000000000..857086ad539e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>
>> Filename matching compatible, so qcom,ipq6018-pwm.yaml
> okay
We would have other ipq compatibles (ipq9574 & ipq5332) being added to
the binding in the upcoming series.
So, shall we rename the binding to qcom,ipq-pwm.yaml

Thanks,
Devi Priya
>>
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm IPQ6018 PWM controller
>>> +
>>> +maintainers:
>>> +  - Baruch Siach <baruch@tkos.co.il>
>>> +
>>> +properties:
>>> +  "#pwm-cells":
>>> +    const: 2
>>> +
>>> +  compatible:
>>> +    const: qcom,ipq6018-pwm
>>
>> compatible is always the first property.
> okay
>>
>>> +
>>> +  reg:
>>> +    description: Offset of PWM register in the TCSR block.
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - "#pwm-cells"
>>
>> And this order must be the same as in properties.
> okay
>>
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
>>> +
>>> +    syscon@1937000 {
>>> +        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>>> +        reg = <0x01937000 0x21000>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges = <0 0x1937000 0x21000>;
>>
>> Drop this node, not related. The parent binding could have full example,
>> on the other hand. Additionally, I have doubts that you really tested
>> the parent binding.
> Sure, will drop the syscon node
> 
> Thanks,
> Devi Priya
>>
>>> +
>>> +        pwm: pwm@a010 {
>>> +            compatible = "qcom,ipq6018-pwm";
>>
>> Best regards,
>> Krzysztof
>>
