Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568B78E9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbjHaKAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjHaKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:00:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA82CED;
        Thu, 31 Aug 2023 03:00:35 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V9GP4v032484;
        Thu, 31 Aug 2023 10:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uh2tVtIUs3ZV9uZDdyhxj6TuRdsD5ZaJVkC1lFuqyjc=;
 b=GBXOQyRKIEj7tgYISTcJORwXHUbiqSBsmmevysG/Yw38pYLSQC8eTCOvfimdDwug0IHq
 Z2GTMK8WwsXUgabhC7b8AK3Hcv8o68ZCCx2M/GJZoHeMJ8QjZHtsrSQBjF6QxmGzUJyq
 6BOLKBYqT6aY8p4u5vF00i6M4kquKd3MwG9ZxmB9ZlgNItpL7FI0Bd9SAPKTZBRH817x
 r06Cf53lV5UHtFSx/pdJKyfxj7YbUXx7URrDXkaKyKhxOYTpG3IHjKuJ/F8r5DYJws5L
 ydTHrJAmSLO+Km90EVqstzxb3Zq6u73364iZPDcDYt6Q8zEL6MgT4SePNDRIoKpG6obK 3w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sswbv2vty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 10:00:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VA0TTr020290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 10:00:29 GMT
Received: from [10.218.10.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 03:00:23 -0700
Message-ID: <7d4a2cd5-291c-e058-9834-1d7eaf911821@quicinc.com>
Date:   Thu, 31 Aug 2023 15:30:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] dt-bindings: clock: qcom: Add GCC clocks for SM4450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-4-quic_ajipan@quicinc.com>
 <161de126-87b0-3440-8517-330b529c3fb6@linaro.org>
From:   Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <161de126-87b0-3440-8517-330b529c3fb6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gl8gxOXJflGu-4r4GQnPBpF3UPZ9ZV9Z
X-Proofpoint-GUID: gl8gxOXJflGu-4r4GQnPBpF3UPZ9ZV9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_07,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310088
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2023 11:40 PM, Krzysztof Kozlowski wrote:
> On 24/08/2023 19:34, Ajit Pandey wrote:
>> Add support for qcom global clock controller bindings for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,sm4450-gcc.yaml       |  54 +++++
>>   include/dt-bindings/clock/qcom,sm4450-gcc.h   | 197 ++++++++++++++++++
>>   2 files changed, 251 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>> new file mode 100644
>> index 000000000000..8c767bdf7f9d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sm4450-gcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller on SM4450
>> +
>> +maintainers:
>> +  - Ajit Pandey <quic_ajipan@quicinc.com>
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module provides the clocks, resets and power
>> +  domains on SM4450
>> +
>> +  See also:: include/dt-bindings/clock/qcom,sm4450-gcc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm4450-gcc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Sleep clock source
>> +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
>> +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
>> +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
> 
> I doubt that these are really optional clocks. They are set as parents
> of your clocks in the controller, so if these clocks are physically
> missing, how does the clock controller work?
> 
> 
> Best regards,
> Krzysztof
> 

Yeah, if these optional clocks are missing, few dependent child clocks 
functionality (UFS/USB) will not work and clock controller will work 
with limited functionality, but I agree that the tag "Optional Clock" is 
bit confusing here and will remove this in next patch series.

-- 
Thanks, and Regards
Ajit
