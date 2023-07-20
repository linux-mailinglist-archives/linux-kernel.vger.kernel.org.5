Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEE75ACEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGTLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:23:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C434BE;
        Thu, 20 Jul 2023 04:23:46 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K91oU9031590;
        Thu, 20 Jul 2023 11:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RWvW7Ut8P6uREa6M4fno7EiFxB4cqnEBeUW2NYZPin0=;
 b=V7BQ7endvITIYku0eNyjHZf0erk/W64IOTOzAb9MpwjOHW7BeO07dCj8j2dKtlNgbfK1
 Sk2cBWCdSdX8fXEnLGSyIV0GvWCH5IPrC29lY8sVc2lBM+6Kb2s8euuJpjJ7G+rkj9KK
 KyJfPjh+cJBVsjFj/2orQJPj6+w/SpidHEApX/Dxdoc+UWp2VMcX64oHDaQfA5sH40sR
 Vfc6iw+mJp75fBhhn0ssPvGY1bYGO+XLxwPXukZiIPMBv44HpvorBiwrVH5c0OCPGy0L
 Hmw6cnN8b7g6DjP3JR6fBQbFhnJt6stE2KcSwCpPlmbMSP3F0gK9w9JKSYiMKRNW6Q/8 DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3vabn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:23:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KBNgol019381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:23:42 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:23:37 -0700
Message-ID: <a5e31783-c2b1-f0a1-6016-84b984ddac67@quicinc.com>
Date:   Thu, 20 Jul 2023 16:53:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document MP03.6-C2 board
 based on IPQ5018 family
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720075731.20816-1-quic_harihk@quicinc.com>
 <20230720075731.20816-2-quic_harihk@quicinc.com>
 <ebdcd477-5f15-cc05-ec67-42369b23f5f1@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <ebdcd477-5f15-cc05-ec67-42369b23f5f1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IoVqXi6Y2yU4Hijbaf52FbTNfR5PIlZA
X-Proofpoint-ORIG-GUID: IoVqXi6Y2yU4Hijbaf52FbTNfR5PIlZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=978 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 2:30 PM, Krzysztof Kozlowski wrote:
> On 20/07/2023 09:57, Hariharan K wrote:
>> Document the MP03.6-C2 (Reference Design Platform 434) board
>> based on IPQ5018 family of SoCs.
>>
>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 922feb912594..2a18bb881624 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -98,6 +98,7 @@ description: |
>>           ap-mi01.6
>>           ap-mi01.9
>>           ap-mp03.5-c2
>> +        ap-mp03.6-c2
>>           cdp
>>           cp01-c1
>>           dragonboard
>> @@ -344,6 +345,7 @@ properties:
>>         - items:
>>             - enum:
>>                 - qcom,ipq5018-ap-mp03.5-c2
>> +              - qcom,ipq5018-ap-mp03.6-c2
> 
> Really, how do you see it being applied? You sent multiple conflicting
> patches. Now, clone the kernel tree and use b4 to apply one patchset.
> Then apply next one. Then next and next.
> 
> Did it succeed?
> 

Sorry, will logically group the patches and post in next series.

Best regards,
Hariharan K

> Best regards,
> Krzysztof
> 
