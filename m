Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB057CC3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbjJQNI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjJQNI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:08:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07FDB;
        Tue, 17 Oct 2023 06:08:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HBmDVm006199;
        Tue, 17 Oct 2023 13:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=00bFYC7Ja7NL+/joeAJl76ZUlTO9w0QkkfRcikPUniQ=;
 b=ANFD/LHES8wi6pALobJYmLRe6NkUgfjKrIbyTc3HT/ns8zw3b1q0ioqMAk+fwekms5aW
 aeBYHWI1qjB/9X71OvX+aERwEtH6keWFB+O3T5zGDGiw+6VVtpfqzxRvawB811V34EYh
 x9pr8VxZ2KUuPen73EiXfGvR/BVp3gsC07/6IP6Dl33Gpw9oHzSmly6OwLuwjPMW88jN
 h1DDXYVuuqA7DJRxx+KK/q7RqE2r6jgoQOJfzf/Rc0w9grd+bhGGDCa9iq0BWRozGxz0
 g70Zk31BELAynrf0A0zQEs5FWDoqckOQPJ91h5C2YO9Nm/TnU5ulJB/oCYQnYdJq2PEM Hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnearprm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:08:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HD8KU6027988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 13:08:20 GMT
Received: from [10.201.2.147] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 06:08:14 -0700
Message-ID: <fc725a19-bd58-fab4-ec4f-dc320bac5f47@quicinc.com>
Date:   Tue, 17 Oct 2023 18:38:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 3/4] thermal/drivers/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Sricharan R <srichara@win-platform-upstream01.qualcomm.com>,
        <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <dmitry.baryshkov@linaro.org>
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
 <cbe6eae5-3490-eb3e-7f28-87ec2c600875@gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <cbe6eae5-3490-eb3e-7f28-87ec2c600875@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Zw5Ob-SLanNh3rlOdg0XxLbvipuRjC2
X-Proofpoint-ORIG-GUID: -Zw5Ob-SLanNh3rlOdg0XxLbvipuRjC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_01,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170110
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 12:37 AM, Robert Marko wrote:
> 
> On 22. 09. 2023. 13:51, Sricharan R wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
>> The soc does not have a RPM, hence tsens has to be reset and
>> enabled in the driver init. Adding the driver support for same.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v3] Fixed Dmitry's comments for error checks in init_ipq5018
>>
>>   drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.c    |  3 ++
>>   drivers/thermal/qcom/tsens.h    |  2 +-
>>   3 files changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c 
>> b/drivers/thermal/qcom/tsens-v1.c
>> index dc1c4ae2d8b0..acee2064f83e 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -79,6 +79,18 @@ static struct tsens_features tsens_v1_feat = {
>>       .trip_max_temp    = 120000,
>>   };
>> +static struct tsens_features tsens_v1_ipq5018_feat = {
>> +    .ver_major    = VER_1_X,
>> +    .crit_int    = 0,
>> +    .combo_int    = 0,
>> +    .adc        = 1,
>> +    .srot_split    = 1,
>> +    .max_sensors    = 11,
>> +    .trip_min_temp    = -40000,
>> +    .trip_max_temp    = 120000,
>> +    .ignore_enable    = 1,
>> +};
>> +
>>   static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>>       /* ----- SROT ------ */
>>       /* VERSION */
>> @@ -150,6 +162,41 @@ static int __init init_8956(struct tsens_priv 
>> *priv) {
>>       return init_common(priv);
>>   }
>> +static int init_ipq5018(struct tsens_priv *priv)
> 
> __init is missing after int, otherwise I get modpost warning while 
> building:
> WARNING: modpost: vmlinux: section mismatch in reference: 
> init_ipq5018+0x14 (section: .text) -> init_common (section: .init.text)

  ok, will fix it.

Regards,
  Sricharan
