Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3470798E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbjIHTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbjIHTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:00:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F7171F;
        Fri,  8 Sep 2023 11:59:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388I26Ce030483;
        Fri, 8 Sep 2023 18:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+WQdbdr4J6HJwmpZ71Qm9fOJMUg5zNqlCiOlxRECRj4=;
 b=fLFG0bGbbJFrgpBnTUWeYVTo873rCgC7WlDm9B5hcMHdcN93vDmuXT840PdG1Rxc+wgp
 6w9elWehN+QWz3pB3QXrvyki1NwIIfzqEbZ1s6ks3QGA9UydJIaxG1lSAPQjmg4+K0nP
 2T90221ww+3yEsBbJhXxBG2Ph8m4mrBuo+GcAoXeM+tJkepyJ4vKH1S7a6Azk+ijl0rw
 7kJZr9Z8q62SXY718IjemP51uKXsaQeKlyhhrf6s5rxF/wm+lvV53w2o5s5BTA93RUOP
 0eQSOYt34DITgtfupXkavV2ExWqvFXWO/9PFnerXGcAJ9s2DvSIjDI9ISWZNNbO1oOvO /Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sym36as3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 18:58:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 388IwHmu006485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 18:58:17 GMT
Received: from [10.110.13.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 11:58:13 -0700
Message-ID: <18bdcbdf-9ff6-5498-41db-8388eb8bf1ed@quicinc.com>
Date:   Fri, 8 Sep 2023 11:58:06 -0700
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
 <2321f4e9-5db2-126a-c5ab-fc18cc507822@quicinc.com>
 <cdf51ad9-d342-4a9c-a55d-384e04bd8754@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <cdf51ad9-d342-4a9c-a55d-384e04bd8754@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ETez3sdKsdJpIv4z7VUmQkzc-vK8RIR_
X-Proofpoint-GUID: ETez3sdKsdJpIv4z7VUmQkzc-vK8RIR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080173
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2023 1:28 AM, Konrad Dybcio wrote:
> On 8.09.2023 02:30, Anjelique Melendez wrote:
>> On 9/7/2023 1:31 PM, Konrad Dybcio wrote:
>>> On 7.09.2023 22:26, Konrad Dybcio wrote:
>>>> On 7.09.2023 21:54, Anjelique Melendez wrote:
>>>>> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>>>>>> On 30.08.2023 20:06, Anjelique Melendez wrote:
>>>>>>> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
>>>>>>> for LUT pattern.
>>>>>>>
>>>>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>>>>> ---
>>>>>>>  drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
>>>>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>>> index 90dc27d5eb7c..0b37d3b539f8 100644
>>>>>>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>>>>>>> @@ -1672,11 +1672,14 @@ static const struct lpg_data pm8994_lpg_data = {
>>>>>>>  static const struct lpg_data pmi632_lpg_data = {
>>>>>>>  	.triled_base = 0xd000,
>>>>>>>  
>>>>>>> +	.lut_size = 64,
>>>>>>> +	.lut_sdam_base = 0x80,
>>>>>> Is that a predefined space for use with LPG?
>>>>>>
>>>>>> Or can it be reclaimed for something else?
>>>>>>
>>>>>> Konrad
>>>>> Yes, this is a predefined space for use with LPG
>>>> We represent the SDAM as a NVMEM device, generally it would
>>>> be nice to add all regions within it as subnodes in the devicetree.
>>> Wait hmm.. we already get it as a nvmem cell.. Or at least that's
>>> how I understand it (lut_sdam_base == lpg_chan_nvmem->start, pseudocode)
>>>
>>> Why don't we access it through the nvmem r/w ops then?
>>>
>>> Konrad
>> I think I might be a little confused on what you are asking so please let
>> me know if this does not answer your question.
>>
>> lut_sdam_base is the offset where lut pattern begins in the SDAM. So when we are writing back
>> our LED pattern we end up calling nvmem_device_write(lpg_chan_nvmem, lut_sdam_base + offset, 1, brightness).
>> So far for every single SDAM PPG devices we have seen the lpg_sdam_base be 0x80 and every
>> LUT SDAM PPG devices (pm8350c) we have seen lpg_sdam_base be 0x45, which is why we 
>> included this value in the lpg_data rather than as a devicetree property since it has
>> been consistent across a few pmics.
>>
>> I am ok if you would like the lut_sdam_base to be moved to a devicetree property.
> So.. we have a slice of SDAM represented as an NVMEM cell (and that
> part of SDAM is reserved solely for LPG), and then within that cell,
> we need to add an additional offset to get to what we want. Correct?
> 
> What's in LPG_NVMEM_CELL[0:offset-1] then?
> 
> Konrad
All SDAMs being used for lpg have the first few registers (0x40 - 0x44) used by PBS
and also contain register map info and sdam size. For the lpg_chan_nvmem SDAM, after
the first few registers we have all of the per channel data such as LUT_EN,
PATTERN_CONFIG, START_INDEX, and END_INDEX. All of these register addresses
that we write back to are defined at the top of leds-qcom-lpg.c and qcom-pbs.c.

When we have single SDAM PPG, pattern entries begin after all of the per channel data at 0x80.
When we have a second SDAM used for LUT, pattern entries begin after the PBS registers at 0x45.

I just went through all of the code again and lut_sdam_base is really only used twice, so we could
define these register addresses instead of having them in device_data if you think that would
make more sense. Would just need to work on variable name that makes the most sense

#define SDAM_LPG_CHAN_SDAM_LUT_PATTERN_OFFSET 0x80
#define SDAM_LUT_SDAM_LUT_PATTERN_OFFSET 0x45

Anjelique
