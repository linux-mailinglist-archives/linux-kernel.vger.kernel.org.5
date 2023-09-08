Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2C797FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjIHAbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjIHAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:31:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5131BDD;
        Thu,  7 Sep 2023 17:30:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38800hoJ022604;
        Fri, 8 Sep 2023 00:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0UGIjV4Ps3IubXUAIjAlkPk7/MVnShQNqa2VopwcF0k=;
 b=BcNXjsq+HF9SrA95SUXykJ5W6RAI/UoAiZ8ihXYV4t51L5ZK+6QIs7vgBYRl9C5zzUN3
 6bwYTweG3osRhIS9akmMJIvt5WTOG74l2Z+cAJ1mozOmo+O/WE3u7Sofog5ZIzipTekr
 +yhoJ0PmrXO7a9Vp0pywUAitB7drDvY8POF5+Ak5/qAkYGJMTOJbNTxbLW4sPK7vVeDJ
 mCYz3uNKhBDZKY+R7ftwH0fSKq5UV/bheoka02I7Lr7Or9TrYjeioYYRCmrhUuZFOWfy
 wSIBgID5ZdXH8bTfd/D9rTwxWjwb6dKyPKcSiC/iD85zVZlNJO9XZHv93zcmIjOpgmzF Dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syfj2haba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 00:30:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3880UPF7019711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 00:30:25 GMT
Received: from [10.110.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 17:30:22 -0700
Message-ID: <2321f4e9-5db2-126a-c5ab-fc18cc507822@quicinc.com>
Date:   Thu, 7 Sep 2023 17:30:22 -0700
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
 <ca451c20-57c1-6fb4-8c8e-b3446944a0f6@quicinc.com>
 <ab237850-4724-48a8-bea8-f1287445358f@linaro.org>
 <83f88e88-5624-4ffd-b2df-f58c6988c649@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <83f88e88-5624-4ffd-b2df-f58c6988c649@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7WZpIYxUGjjgXPAkOAp_iNpveTTnLyKK
X-Proofpoint-GUID: 7WZpIYxUGjjgXPAkOAp_iNpveTTnLyKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=869
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080003
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 1:31 PM, Konrad Dybcio wrote:
> On 7.09.2023 22:26, Konrad Dybcio wrote:
>> On 7.09.2023 21:54, Anjelique Melendez wrote:
>>>
>>>
>>> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>>>> On 30.08.2023 20:06, Anjelique Melendez wrote:
>>>>> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
>>>>> for LUT pattern.
>>>>>
>>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>>> ---
>>>>>  drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
>>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>> index 90dc27d5eb7c..0b37d3b539f8 100644
>>>>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>>>>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>> @@ -1672,11 +1672,14 @@ static const struct lpg_data pm8994_lpg_data = {
>>>>>  static const struct lpg_data pmi632_lpg_data = {
>>>>>  	.triled_base = 0xd000,
>>>>>  
>>>>> +	.lut_size = 64,
>>>>> +	.lut_sdam_base = 0x80,
>>>> Is that a predefined space for use with LPG?
>>>>
>>>> Or can it be reclaimed for something else?
>>>>
>>>> Konrad
>>> Yes, this is a predefined space for use with LPG
>> We represent the SDAM as a NVMEM device, generally it would
>> be nice to add all regions within it as subnodes in the devicetree.
> Wait hmm.. we already get it as a nvmem cell.. Or at least that's
> how I understand it (lut_sdam_base == lpg_chan_nvmem->start, pseudocode)
> 
> Why don't we access it through the nvmem r/w ops then?
> 
> Konrad
I think I might be a little confused on what you are asking so please let
me know if this does not answer your question.

lut_sdam_base is the offset where lut pattern begins in the SDAM. So when we are writing back
our LED pattern we end up calling nvmem_device_write(lpg_chan_nvmem, lut_sdam_base + offset, 1, brightness).
So far for every single SDAM PPG devices we have seen the lpg_sdam_base be 0x80 and every
LUT SDAM PPG devices (pm8350c) we have seen lpg_sdam_base be 0x45, which is why we 
included this value in the lpg_data rather than as a devicetree property since it has
been consistent across a few pmics.

I am ok if you would like the lut_sdam_base to be moved to a devicetree property.

Thanks,
Anjelique
