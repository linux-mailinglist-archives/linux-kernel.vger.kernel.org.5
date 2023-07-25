Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48603760A51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGYG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGYG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:26:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7982CF;
        Mon, 24 Jul 2023 23:26:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P4poQT004251;
        Tue, 25 Jul 2023 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8RcjJCCsQwRpsPqjhjQqQfhBDHGif3SbicAU1EnQ+KY=;
 b=oPJ1YB34WWql6kgGSsTR6ckev+vhINjLujGrFdB1TWV6edezVz8/HZLDBf2P4Guq9yWE
 GzMHtwpWzo/9XW98nqQUkw6O1kXHIVfmhIqb/39X+5Vb57/Jtw1R9eVic8L1SvqiTw14
 MLdSjh7cqqsT7VTGkEhz53i1x/MTZ0h7IyxRyRe+qhTEgMVCtVM9zXn/e6v5eIyn7JMp
 3DWYjNueSIoTTbt+xZ5gWf2hi3GFzWwaPdeUrACh54g0OtbZ34pwZGEbvxFVfjeYbSAp
 ZIWHoQ4FtL01aaUzo3Tn/X8H+3q3GL7ujacRoS+5lUREJQyXwM5hj/irTxG4LlQh/xsC eA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1y6m11s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 06:26:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P6Qg5G032391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 06:26:42 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 23:26:38 -0700
Message-ID: <3aaccc94-59b3-31d3-eac7-f8926f8c88ff@quicinc.com>
Date:   Tue, 25 Jul 2023 14:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Content-Language: en-US
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
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
 <20230725054138.129497-3-quic_fenglinw@quicinc.com>
 <b2ad4863-a38b-7fb6-65b1-ea336c4fc876@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <b2ad4863-a38b-7fb6-65b1-ea336c4fc876@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0oBRzHngtBu9p4ihuaZRfygs2w4tfkos
X-Proofpoint-ORIG-GUID: 0oBRzHngtBu9p4ihuaZRfygs2w4tfkos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250057
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2023 1:53 PM, Krzysztof Kozlowski wrote:
> On 25/07/2023 07:41, Fenglin Wu wrote:
>> Add compatible string 'qcom,spmi-vib-gen2' for vibrator module inside
>> PMI632, PMI7250B, PM7325B, PM7550BA. Also, add 'qcom,spmi-vib-gen1'
>> string for the SPMI vibrator inside PM8916 to maintain the completeness
>> of the hardware version history for SPMI vibrators.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/input/qcom,pm8xxx-vib.yaml        | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> index c8832cd0d7da..ab778714ad29 100644
>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> @@ -11,10 +11,20 @@ maintainers:
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
>> +          - qcom,spmi-vib-gen1
>> +          - qcom,spmi-vib-gen2
> 
> Generic compatibles should not be alone. Drop both lines.

Sure. I will remove 'qcom,spmi-vib-gen2'.
Should I also keep 'qcom,spmi-vib-gen1' as generic compatible and move 
'qcom,pm8916-vib' as its fallback as following?

   compatible:
     oneOf:
       - enum:
           - qcom,pm8058-vib
           - qcom,pm8921-vib
       - items:
           - enum:
               - qcom,pm8916-vib
           - const: qcom,spmi-vib-gen1
       - items:
           - enum:
               - qcom,pmi632-vib
               - qcom,pm7250b-vib
               - qcom,pm7325b-vib
               - qcom,pm7550b-vib
           - const: qcom,spmi-vib-gen2

I saw 'qcom,pm8916-vib' has been used in multiple DTS files and updating 
it as a fallback will result updating those DTS files as well.
Or please help to suggest if there is any way to keep 'qcom,pm8916-vib' 
and 'qcom,spmi-vib-gen1' compatible without updating existing DTS nodes.

Thanks

> 
>> +      - items:
>> +          - enum:
>> +              - qcom,pmi632-vib
>> +              - qcom,pm7250b-vib
>> +              - qcom,pm7325b-vib
>> +              - qcom,pm7550b-vib
>> +          - const: qcom,spmi-vib-gen2
> 
> 
> Best regards,
> Krzysztof
> 
