Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3267775C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHJK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHJK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:27:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB583;
        Thu, 10 Aug 2023 03:27:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A70Ejf000792;
        Thu, 10 Aug 2023 10:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MF8W2MQknXtxWB0YP9TugQ1+T/6dWLvtq+y16AGC6F4=;
 b=d6Vk0ORWqMX0QROw9LRZQB8hbKoCgyztHcHzhsfcPL9miQfA3zERrtliHsWEDTbmxYIN
 /jxkuZRQti76USV4cb87M5DNCU1d9BgsU3wXosfTrn++g3R7j5Ob828X945C+6VoET0s
 QbL8DhFhz6c0Oq4Cs6awgOinZHyAIFgX/AO6UJBrHhR8ftSXcb9uSfb4JezzTWreibb4
 dckjAAlnkEC9N8lKQi9cmHA/ruViMWttGjjmm0wYQ3Yiz8IdMv3FCMuuegbyA4Vo8Ova
 XfLrDUaWUgk68tTjNAvSZLpVWYrNUCaSLUtPc0+eYRvbGu/E1PxogkcbHywpm7ojqUdW wA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scbcgj5gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:27:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AARSRY000746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 10:27:28 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 03:27:24 -0700
Message-ID: <8636b916-749e-2bf7-8ec6-202aff4ab872@quicinc.com>
Date:   Thu, 10 Aug 2023 15:57:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible
 for QDU1000/QRU1000
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <andersson@kernel.org>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-2-quic_kbajaj@quicinc.com>
 <169165201539.3911513.11768504895031523847.robh@kernel.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <169165201539.3911513.11768504895031523847.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oxwFGdCQeg4h8ge6Jd9iFaREzYwkZ9WO
X-Proofpoint-ORIG-GUID: oxwFGdCQeg4h8ge6Jd9iFaREzYwkZ9WO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100087
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 12:50 PM, Rob Herring wrote:
> On Thu, 10 Aug 2023 11:41:35 +0530, Komal Bajaj wrote:
>> Add LLCC compatible for QDU1000/QRU1000 SoCs and add optional
>> nvmem-cells and nvmem-cell-names properties to support multiple
>> configurations for multi channel DDR.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
>
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810061140.15608-2-quic_kbajaj@quicinc.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Hi Rob,
I did run the same steps locally after upgrading dtschema too, but it 
didn't reported any kind of error.
Here also, error is not mentioned, can you please state what's the error 
reported with this patch?

Thanks
Komal

>

