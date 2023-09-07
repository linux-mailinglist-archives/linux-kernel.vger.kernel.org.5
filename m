Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874E8797D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjIGTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIGTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:55:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4094CE9;
        Thu,  7 Sep 2023 12:55:44 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Ja3Jt016621;
        Thu, 7 Sep 2023 19:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eM8+fdx712iK+YuWVyhpnJIOJmY8bqc7qlBMEOGWAZA=;
 b=aKUiIoKiGWTMvZTgGMnzrXfLVUUKrzrQnltmH2Z2n6w3u8kROGkSqGkAiT6PCJu99kLV
 MyVzpkidolspOMY9B8K4O4/Kmt/iVyJmYz7mmuX2N7PYo9ZzTuQnYFLetwklXusHHDNK
 vLJvoljtmOpNPVL2oHZckJiX7FmYKG5y8dEHxcqK5LisFRbaRaZQsYGYCV9hjTRYkB55
 OFFMIf0SJsPOEbe7lS3IfcIP7++ZckdCDJbHCAMwBigGkWwRTgHBW0lZGcHshu5S+jwR
 7ZqDS1LvizocytBFGeIJQ+0hOADi3BIiZNMDrwoV0eMQ1q8ovO/twoiU44rO4/4jcP/h iA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy50da3dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 19:55:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387Jt7Ce029599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 19:55:07 GMT
Received: from [10.110.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 12:54:46 -0700
Message-ID: <ca451c20-57c1-6fb4-8c8e-b3446944a0f6@quicinc.com>
Date:   Thu, 7 Sep 2023 12:54:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data
 to support PPG
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-8-quic_amelende@quicinc.com>
 <951a2f24-931a-4a25-a3b7-c3009e135d7d@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <951a2f24-931a-4a25-a3b7-c3009e135d7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2AjBp-j2PA1W6lXAf0Gn41ZC8I6PFUpZ
X-Proofpoint-GUID: 2AjBp-j2PA1W6lXAf0Gn41ZC8I6PFUpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=898 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070175
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
> On 30.08.2023 20:06, Anjelique Melendez wrote:
>> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
>> for LUT pattern.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>> index 90dc27d5eb7c..0b37d3b539f8 100644
>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>> @@ -1672,11 +1672,14 @@ static const struct lpg_data pm8994_lpg_data = {
>>  static const struct lpg_data pmi632_lpg_data = {
>>  	.triled_base = 0xd000,
>>  
>> +	.lut_size = 64,
>> +	.lut_sdam_base = 0x80,
> Is that a predefined space for use with LPG?
> 
> Or can it be reclaimed for something else?
> 
> Konrad
Yes, this is a predefined space for use with LPG
