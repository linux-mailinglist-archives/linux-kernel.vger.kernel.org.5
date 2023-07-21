Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C29575BC35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGUCUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGUCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:20:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758F1BEF;
        Thu, 20 Jul 2023 19:20:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2JDKF012220;
        Fri, 21 Jul 2023 02:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kNmUukYBV4dtDSpPfzLq8+40TyEbdMOv5rTM2pCJP2s=;
 b=PFFWy4NQNPvkZ5i6t0cv+zM1WStSqeCwUGWBGkk7s2XJZgxfhqEYJA1zcY6WIhRkQRVz
 Eufi14r7d+TZlcNm/0ZmCil+Wqgp28SbO0BWsZtRgQb5C2ofZyyaGPa0nYjpU2AAhZlp
 ToirXbyTziJ9TqHHHTKwdvn6Q2UoI97qiNqKgoA4vggwbYxCwzpnkyWCrCs4vh9eMpsb
 GYmn50rrQkrgcEca3ttWrmeYHtFPCR8jgslJuGCfPtUXgOyDkMjwO86Qz5hJ2yGp/Tcu
 8bO6b9JJ2Sk+GKK4nPBU55cnxx0szBh7LwTjQE6s2VsjeMc7ah8ShQWMf3yobUudid1Y TQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv2kxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:20:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2KPb1015676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:20:25 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:20:21 -0700
Message-ID: <355065a5-7112-9f72-e221-60c33343094c@quicinc.com>
Date:   Fri, 21 Jul 2023 10:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: arm: qcom: Document SM4450 SoC and
 boards
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-5-quic_tengfan@quicinc.com>
 <c7642d4e-85a1-0934-c155-6636a86ec3bc@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <c7642d4e-85a1-0934-c155-6636a86ec3bc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yYlnXei78Jd1fIGVnjEZAkyXiw9-Uw49
X-Proofpoint-GUID: yYlnXei78Jd1fIGVnjEZAkyXiw9-Uw49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:15 PM, Dmitry Baryshkov 写道:
> On 19/07/2023 13:01, Tengfei Fan wrote:
>> Document the SM8450 SoC binding and also the boards using it.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml 
>> b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 450f616774e0..691e66612872 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -83,6 +83,7 @@ description: |
>>           sm8350
>>           sm8450
>>           sm8550
>> +        sm4450
> 
> Please sort properly
V2 patch will resort.
> 
>>     The 'board' element must be one of the following strings:
>> @@ -976,6 +977,11 @@ properties:
>>                 - qcom,sm8550-qrd
>>             - const: qcom,sm8550
>> +      - items:
>> +          - enum:
>> +              - qcom,sm4450-qrd
>> +          - const: qcom,sm4450
>> +
> 
> And here
V2 patch will resort.
> 
>>     # Board compatibles go above
>>     qcom,msm-id:
> 

-- 
Thx and BRs,
Tengfei Fan
