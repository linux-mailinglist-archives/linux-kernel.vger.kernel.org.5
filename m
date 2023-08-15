Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6858077C7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjHOGnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjHOGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:43:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A986127;
        Mon, 14 Aug 2023 23:43:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6eHer029692;
        Tue, 15 Aug 2023 06:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nH9TdN+9Ou+OLup3W8vXF8KOi6F2nLMXNpePTMty3Pw=;
 b=TEnr36r8z8X6ycCjCSTdCOPm9MnZz+TeQlfUhh0BwYevNikLmLXL7UdYSzX6NpV4S/+y
 iJI6VrMU1f//HhYUz/P84oat8PeDAz4+rWnqhGwBqckgjcXD+09K3l7Aw5b75yWB51nB
 PEkdcXdEv0tCQp5CP0HRJZvHh9/+ng5yXCWWWApz3BGLZXOPDsHG2EgnloE5PR8U1oJ5
 7jNY2WgUa5J97hc6K78f6VPcvKja3/NigbO/TaH7+M22IOwldnLjA/Ci1OEWK/78H84a
 yAvOPTzUV5ekeoNdFLh/xU59BNXtohOZw6Mld+fa8WiiYRKKxMSjhsRtM52a2qM/jLpA Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sfqp1h7em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:42:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37F6gjWR022595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:42:45 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 14 Aug
 2023 23:42:42 -0700
Message-ID: <d4cee19c-6f13-a1dc-d402-1d5c2b769ad1@quicinc.com>
Date:   Tue, 15 Aug 2023 14:42:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
References: <20230815060314.352103-1-quic_fenglinw@quicinc.com>
 <20230815060314.352103-3-quic_fenglinw@quicinc.com>
 <CUSWRRL6QOPU.1YM7S0F8F3V2D@otso>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CUSWRRL6QOPU.1YM7S0F8F3V2D@otso>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0x4I6bYn13pn8C_SAAubBjQ-LITwhqcZ
X-Proofpoint-ORIG-GUID: 0x4I6bYn13pn8C_SAAubBjQ-LITwhqcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_05,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150060
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 2:35 PM, Luca Weiss wrote:
> Hi Fenglin,
> 
> On Tue Aug 15, 2023 at 8:03 AM CEST, Fenglin Wu wrote:
>> Add compatible strings to support vibrator module inside PMI632,
>> PMI7250B, PM7325B, PM7550BA.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/input/qcom,pm8xxx-vib.yaml           | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> index c8832cd0d7da..72b72c67a9b6 100644
>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> @@ -11,10 +11,17 @@ maintainers:
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
>> +              - qcom,pm7250b-vib
>> +              - qcom,pm7325b-vib
>> +              - qcom,pm7550ba-vib
>> +          - const: qcom,pmi632-vib
> 
> With the new revision the standalone 'compatible = "qcom,pmi632-vib";'
> doesn't pass validation anymore.
> 
> foo.dtb: vibrator@5700: compatible: 'oneOf' conditional failed, one must be fixed:
>          ['qcom,pmi632-vib'] is too short
>          'qcom,pmi632-vib' is not one of ['qcom,pm8058-vib', 'qcom,pm8916-vib', 'qcom,pm8921-vib']
>          'qcom,pmi632-vib' is not one of ['qcom,pm7250b-vib', 'qcom,pm7325b-vib', 'qcom,pm7550ba-vib']
>          from schema $id: http://devicetree.org/schemas/input/qcom,pm8xxx-vib.yaml#
> 
> I believe you need to add the compatible also like this:
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> index 72b72c67a9b6..2025d6a5423e 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> @@ -16,6 +16,7 @@ properties:
>             - qcom,pm8058-vib
>             - qcom,pm8916-vib
>             - qcom,pm8921-vib
> +          - qcom,pmi632-vib
>         - items:
>             - enum:
>                 - qcom,pm7250b-vib
> 
Yeah, thanks for catching this. I will update it soon.

> 
> Regards
> Luca
> 
>>   
>>     reg:
>>       maxItems: 1
> 
