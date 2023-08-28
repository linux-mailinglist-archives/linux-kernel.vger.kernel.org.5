Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6678A5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjH1G0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjH1G0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:26:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCBABF;
        Sun, 27 Aug 2023 23:26:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S5nYgN011816;
        Mon, 28 Aug 2023 06:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Vi/7dRcZiZzbceZ+3BSRq4T+rGArOgzICnbhnPDbMFQ=;
 b=Q8oXyCIebZbGVUgUUoFNqi0crnQYJArXp4GXgsWgDY/PnjyCsasAWqG8gvfKApSd/k6J
 r95kuwEJythU8DqQ39v1gNeHBNRBYUPqTu6T4LorqPFoZ/zzDi/E7ZNkASnZxRillheu
 YJdJTxjZMQ6kTZgR6a1QILYEsb7Hhv0K3Vq9iSdJdf/Ciost6um3seELdOKg4bYPfEtC
 qBez6U1xPJidzYyUjV8vPXPNnnRTdWmN2TJIqn9tXkqRaLK42JC1d/drFdH0e1FC/wFG
 RLIVKweCoJeygeTgiyseLSFbSb9D7eckwV+yG+wOibsWdqRq9TXTUdJFvJbkBVuhJcDA jA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8ddjqvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:26:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S6Q8Sg018159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:26:08 GMT
Received: from [10.216.31.112] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 23:26:02 -0700
Message-ID: <a9fa63e1-dcc4-4f44-97b0-03d5afd6435a@quicinc.com>
Date:   Mon, 28 Aug 2023 11:55:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] Revert "dt-bindings: crypto: qcom,prng: Add
 SM8450"
To:     Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
 <20230824212903.GA1453763-robh@kernel.org>
Content-Language: en-US
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20230824212903.GA1453763-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3HWLkX04FpUXTLifZlBLenNB2KFW6aqJ
X-Proofpoint-GUID: 3HWLkX04FpUXTLifZlBLenNB2KFW6aqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 2:59 AM, Rob Herring wrote:
> On Thu, Aug 24, 2023 at 01:33:20PM +0200, Neil Armstrong wrote:
>> This reverts commit b9296bb41275 ("dt-bindings: crypto: qcom,prng: Add SM8450"),
>> since the RNG HW on the SM8450 SoC is in fact a True Random Number Generator,
>> a more appropriate compatible should be instead as reported at [1].
>>
>> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
>>
>> Suggested-by: ￼Om Prakash Singh <quic_omprsing@quicinc.com>
>> Suggested-by: ￼Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Is it just me or looks like an unrenderable character in these.
Yes there are spacial character before Om and Konrad that should have 
been removed.
> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++-----------------
>>   1 file changed, 5 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>> index 36b0ebd9a44b..bb42f4588b40 100644
>> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
>> @@ -11,13 +11,9 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    oneOf:
>> -      - enum:
>> -          - qcom,prng  # 8916 etc.
>> -          - qcom,prng-ee  # 8996 and later using EE
>> -      - items:
>> -          - const: qcom,sm8450-prng-ee
>> -          - const: qcom,prng-ee
>> +    enum:
>> +      - qcom,prng  # 8916 etc.
>> +      - qcom,prng-ee  # 8996 and later using EE
>>   
>>     reg:
>>       maxItems: 1
>> @@ -32,18 +28,8 @@ properties:
>>   required:
>>     - compatible
>>     - reg
>> -
>> -allOf:
>> -  - if:
>> -      not:
>> -        properties:
>> -          compatible:
>> -            contains:
>> -              const: qcom,sm8450-prng-ee
>> -    then:
>> -      required:
>> -        - clocks
>> -        - clock-names
>> +  - clocks
>> +  - clock-names
>>   
>>   additionalProperties: false
>>   
>>
>> -- 
>> 2.34.1
>>
