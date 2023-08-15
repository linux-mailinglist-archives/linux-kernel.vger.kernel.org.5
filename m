Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACB77C5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjHOCVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjHOCUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:20:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC91738;
        Mon, 14 Aug 2023 19:20:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F1xA9x030196;
        Tue, 15 Aug 2023 02:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Yi0+KALGAXR2zRMRQ38MVPVVGW3SHLRtSuqkPqJ3wEo=;
 b=Gvw8FG0ket63N1YqMCI3nSIqttL+qkhgOBs9F497M/WSJhcVrWSoH0iuWtJLbCK+6Wup
 xxlXBx4EiEvh6Qa2NDyL4e5UXgYSNzi8Z6nKGMqhIgXX1FboqYbXzmaGt7FKJ87twrOP
 SkxfG+MqkOx2BNIbY+GVR6dHqpx56WmHYQtOyJyMjjAdxxqVieb17hAv2l8iE/iG1a+q
 mSxtUUj/so5nIg/Upyim6cDjHCELbaOfgpgKGVdaw6hp2s7mWyY6af3uanshiMv0+rjs
 r9BdxuJYKz4wWqZP6bLwayNgBNeXTmSgu4zDWK3cYH6XnJSlNy5l6XbL+FSObY7amdOa XA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se40rn4q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 02:20:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F2KdO3025764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 02:20:39 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 19:20:36 -0700
Message-ID: <19e45248-5fff-d806-81f2-feea56d7778d@quicinc.com>
Date:   Tue, 15 Aug 2023 10:20:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
References: <20230731053712.2220898-1-quic_fenglinw@quicinc.com>
 <20230731053712.2220898-3-quic_fenglinw@quicinc.com>
 <a1b1cead-17e4-2016-91a1-9ad9949ff9e3@linaro.org>
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <a1b1cead-17e4-2016-91a1-9ad9949ff9e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TuQWBqoRPNDzak15tfJeAt9mleXA4Gl6
X-Proofpoint-GUID: TuQWBqoRPNDzak15tfJeAt9mleXA4Gl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150018
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 6:06 PM, Krzysztof Kozlowski wrote:
> On 31/07/2023 07:37, Fenglin Wu wrote:
>> Add compatible string 'qcom,spmi-vib-gen2' to support vibrator module
>> inside PMI632, PMI7250B, PM7325B, PM7550BA.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/input/qcom,pm8xxx-vib.yaml          | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> index c8832cd0d7da..4a2319fc1e3f 100644
>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> @@ -11,10 +11,18 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,pm8058-vib
>> -      - qcom,pm8916-vib
>> -      - qcom,pm8921-vib
>> +    oneOf:
>> +      - enum:
>> +          - qcom,pm8058-vib
>> +          - qcom,pm8916-vib
>> +          - qcom,pm8921-vib
>> +      - items:
>> +          - enum:
>> +              - qcom,pmi632-vib
>> +              - qcom,pm7250b-vib
>> +              - qcom,pm7325b-vib
>> +              - qcom,pm7550b-vib
>> +          - const: qcom,spmi-vib-gen2
> 
> This does not seem to implement my comment:
> 
> "Entirely remove qcom,spmi-vib-gen2 and
> qcom,spmi-vib-gen1.
> 
> Use device specific compatibles names only. As fallback and as first
> compatible."
> 
> It's nice to respond that you disagree with it. Therefore, I am not
> going to Ack it.

I saw your comments and I replied your later comments in v2: 
https://lore.kernel.org/linux-arm-msm/b5e58172-beb5-0be3-834f-3f1db3e8b3b3@quicinc.com/. 
It might not be a good place to follow the discussion though, I am 
pasting my last reply below:

'Sorry, I forgot to mention, in v3, I added the 'reg' value to the
register offset and no longer hard code the 16-bit register address,
that makes the vibrators inside PMI632/PM7250B/PM7325B/PM7550BA all
compatible, and that was another motivation of adding a generic
compatible string and make the others as the fallback.

This will be still the case in v4, I might keep it similar in v3 but
just drop "qcom,spmi-vib-gen1" '

Anyway, if this is still not a good reason to add a generic compatible 
string, I can revert it back to use device specific compatible string 
only in next patch.

Thanks

> 
> Best regards,
> Krzysztof
> 
