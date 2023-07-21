Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB30075BC48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGUC1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUC1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:27:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD310E;
        Thu, 20 Jul 2023 19:27:39 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1oAF9025247;
        Fri, 21 Jul 2023 02:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EV4lfOTr8DSz/ezCXPTmVbt0GeGexOUThNPIVOM7iHU=;
 b=C+7BPUFdSuPLcSZc4VkmzIAPL6Ccxyso5lOy4TelN+etOBArjIGxATTbBnnKyuxRwqWn
 FsJGztCAwMxgfNTi3xJTwmp47uj1Nis0IERrS5ReDhAyiNcJcd9HEEaHJRlU1jZOMZoK
 4odHbeOHXKPxZgZsKsD+jiEmQa/7EmBDJEIML53NXi1vakXVnXfcaH1/ym8aJhCFb4BM
 8UfRoHos0t2W+5gO2iX5yMi+fgUXuQhV5pJl08Rnr43uIPd8lQAAEO8IQeIBoBJ1VeL3
 fbJteIeab17RUHrG4rc3VIFLYnaCOM5yD4zLeilP51ZmILQ/8XsQ2d8dtBJfngpxDi99 Pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ry3y1hy9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:27:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2RZ23006273
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:27:35 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:27:31 -0700
Message-ID: <55eb7002-79de-2348-6f94-69b5f418bd19@quicinc.com>
Date:   Fri, 21 Jul 2023 10:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] soc: qcom: socinfo: add SM4450 ID
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-6-quic_tengfan@quicinc.com>
 <43437691-b228-1078-8f00-9128c4be8c9e@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <43437691-b228-1078-8f00-9128c4be8c9e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ehpOsMQADwJOtCA58-o4NLIIzqE4YI4
X-Proofpoint-ORIG-GUID: 8ehpOsMQADwJOtCA58-o4NLIIzqE4YI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=880 bulkscore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:25 PM, Krzysztof Kozlowski 写道:
> On 19/07/2023 12:01, Tengfei Fan wrote:
>> Add the ID for the Qualcomm SM4450 SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   drivers/soc/qcom/socinfo.c         | 1 +
>>   include/dt-bindings/arm/qcom,ids.h | 2 ++
> 
> Bindings are always separate patches.
V2 patch will separate.
> 
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>> index 4d49945b3a35..fa5e4c54207a 100644
>> --- a/drivers/soc/qcom/socinfo.c
>> +++ b/drivers/soc/qcom/socinfo.c
>> @@ -415,6 +415,7 @@ static const struct soc_id soc_id[] = {
>>   	{ qcom_board_id(IPQ5312) },
>>   	{ qcom_board_id(IPQ5302) },
>>   	{ qcom_board_id(IPQ5300) },
>> +	{ qcom_board_id(SM4450) },
>>   };
>>   
>>   static const char *socinfo_machine(struct device *dev, unsigned int id)
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> index bcbe9ee2cdaf..6201bfb1405e 100644
>> --- a/include/dt-bindings/arm/qcom,ids.h
>> +++ b/include/dt-bindings/arm/qcom,ids.h
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>    * Copyright (c) 2022 Linaro Ltd
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>    * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
>>    */
>>   #ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
>> @@ -259,6 +260,7 @@
>>   #define QCOM_ID_IPQ5312			594
>>   #define QCOM_ID_IPQ5302			595
>>   #define QCOM_ID_IPQ5300			624
>> +#define QCOM_ID_SM4450			568
> 
> No, come on...
V2 patch will resort this.
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
