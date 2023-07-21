Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA475BC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGUCTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:19:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02A1BDC;
        Thu, 20 Jul 2023 19:19:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1wfDI005723;
        Fri, 21 Jul 2023 02:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/RYsE/x/O4CDHkAsYSLrRAjFeUr9SjszBrGuoN4sfwk=;
 b=YnhO9FbW5MgBEJ4TIu/fqzA5ZjDiLSrGnvbxyOEj/p1eBTX6B7vYf9tNV7iUJCMAB1uj
 IpIrjxbS1WT+pinOLABcGuxxPYKQhCeyWPxSuHosr0EwWrjv5PDVj0HZ3wUhF1KPDeOx
 LT7CQ0Clg1T8p+tyRM2+HwAIkkaZh26bQFuYqztnYdRuXGxchuTbnpAo27CsOz1onBH3
 bku60IbDhu0IE4poDFda9rYSjVQe9gIdzby+XK8iW+a4Muc5PKgfVfXyJwVQcLQBzGa+
 9+mMB4FkAH7VSh5w9N7/i0uqTqz+XUWjxwIi0MtibBhpL4/oMxx+q4me6WF8HKOPyDRd 7A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv2kwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:19:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2JR3g014673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:19:27 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:19:24 -0700
Message-ID: <ff5ed3be-2454-c43b-697f-54cd209471a2@quicinc.com>
Date:   Fri, 21 Jul 2023 10:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: firmware: scm: Add SM4450
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
 <20230719100135.21325-4-quic_tengfan@quicinc.com>
 <af35e6fe-c360-fc13-1f1b-3f00ca0bdf85@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <af35e6fe-c360-fc13-1f1b-3f00ca0bdf85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JSgbvEMF1I2m78Vq3Z7TbSsKAdgy-FJ0
X-Proofpoint-GUID: JSgbvEMF1I2m78Vq3Z7TbSsKAdgy-FJ0
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



在 7/19/2023 6:16 PM, Dmitry Baryshkov 写道:
> On 19/07/2023 13:01, Tengfei Fan wrote:
>> Add compatible for SM4450 SoCs.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml 
>> b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index bdbee58a542b..f02f0815bece 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -62,6 +62,7 @@ properties:
>>             - qcom,scm-sm8450
>>             - qcom,scm-sm8550
>>             - qcom,scm-qcs404
>> +          - qcom,scm-sm4450
> 
> Please keep this list sorted.
V2 patch will resort.
> 
>>         - const: qcom,scm
>>     clocks:
> 

-- 
Thx and BRs,
Tengfei Fan
