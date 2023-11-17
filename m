Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4687EEB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjKQEH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbjKQEH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:07:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8A98;
        Thu, 16 Nov 2023 20:07:52 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH3l0L4032547;
        Fri, 17 Nov 2023 04:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KntgboeI2VjPb3sUlPr93+tw81LneJ/w+xKvRlUs9rw=;
 b=OPbnHXlinxLLQf7RJO9zRTVPF0zKgkrRpM0oov+L2ENeAxtskZD7vvlqo8EdkeIA5hMG
 Dl1sGJmPcyiNeD8Fuq2Jw8w8nqZTg3dT2SrvsJvseqIFvnu2i2E9va50fEJ0/jvW5thI
 cUrHAczEINgDS4kDQh13h/iVnHKvAEphW+uZDGZJRBZ6XfLEeIDgkZQrtpaTglPsBsKY
 36R+C5vMLQNuJjJPP5pNP+T6hGy0gH8MP0Jvy6OYotpW2wzpQPbxlzPMlmyefo4kWHGz
 iSEDkAFy0A6FnpwqpSo/GsKieoDZWFV274UtxpXpAqgqcXRPG7LXz84S7bV6ZxUOLMdW hg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udhe1t3cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:07:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH47TRw015930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:07:29 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 20:07:21 -0800
Message-ID: <a17d3739-504a-9502-4a2c-3aeddd96c8fa@quicinc.com>
Date:   Fri, 17 Nov 2023 09:37:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: qcom: Document SC8380XP SoC and
 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <ulf.hansson@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <ayan.kumar.halder@amd.com>, <j@jannau.net>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <lpieralisi@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
 <20231025142427.2661-3-quic_sibis@quicinc.com>
 <2cecb51e-9528-471c-8de0-cb716977c0e0@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <2cecb51e-9528-471c-8de0-cb716977c0e0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -hP7qev6dDIavmZEbnbu2NbPLK_DzyMH
X-Proofpoint-ORIG-GUID: -hP7qev6dDIavmZEbnbu2NbPLK_DzyMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170029
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

Thanks for taking time to review the series.

On 10/27/23 13:46, Krzysztof Kozlowski wrote:
> On 25/10/2023 16:24, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Document the SC8380XP SoC binding and also the boards using it.
>> Also document the new board id qcp (Qualcomm Compute Platform).
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 88b84035e7b1..6145e9ad340c 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -62,6 +62,7 @@ description: |
>>           sc7280
>>           sc8180x
>>           sc8280xp
>> +        sc8380xp
>>           sda660
>>           sdm450
>>           sdm630
>> @@ -110,6 +111,7 @@ description: |
>>           liquid
>>           rdp432-c2
>>           mtp
>> +        qcp
>>           qrd
>>           rb2
>>           ride
>> @@ -1044,6 +1046,12 @@ properties:
>>                 - qcom,sm8550-qrd
>>             - const: qcom,sm8550
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,sc8380xp-crd
>> +              - qcom,sc8380xp-qcp
>> +          - const: qcom,sc8380xp
> 
> This is some odd placement. Please keep things properly ordered.

will fix this in the next re-spin.

-Sibi

> 
> Best regards,
> Krzysztof
> 
