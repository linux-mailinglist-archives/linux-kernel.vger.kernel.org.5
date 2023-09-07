Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A706797E85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbjIGWCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIGWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:02:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D391BC1;
        Thu,  7 Sep 2023 15:01:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KoeVo004546;
        Thu, 7 Sep 2023 22:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+dcaaXdggg35Vmrg2mKmJK6tBf0OSHOScRmlONISjAs=;
 b=WDXm07DQ/Orqcr877yFK/mzveoKgF4KDpI6BK+4MJyfmjU0G0AnK//JGg3iDNKhrkZt/
 WJwAtnE1uirKVOu7cYYbwfewcDjGCjTr1e3eOmnX1rNB1PCjZmXjZFgyqPqHotjaoXnq
 ZdEMkYtTPy4lyQTvFIkOuYSV5eJuJCdzVBWkYH1SIyfp4+eJp8GIm4tQAymPvcO3nl0q
 5d/9oYuYgjQ2/NKBlmf3vvRR/pavYxbtLkfdHP8FpQJWGhCJOztPCmj8PANwkqo9CxT9
 pdQ+IPkJmUL28xATbfa5WHz8JqbIydfcVUU87KoVWBbo97JIBLSkfd2UvU26FNH/3AQe pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy951j0su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:01:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387M1Ec0014312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 22:01:14 GMT
Received: from [10.110.111.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 15:01:11 -0700
Message-ID: <5f9e3845-2478-2739-ec5b-38e17bb37379@quicinc.com>
Date:   Thu, 7 Sep 2023 15:01:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
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
 <20230830180600.1865-7-quic_amelende@quicinc.com>
 <3b6f6285-ec3b-4e12-aa65-d5f61937de6f@linaro.org>
 <a9aa7bd9-7d42-3897-443e-b3ef2d73d05c@quicinc.com>
 <09109739-cb9c-42e2-80ab-e919774b4173@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <09109739-cb9c-42e2-80ab-e919774b4173@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k2moF_Kc7Snti5PleFeToWk3MTohZrcX
X-Proofpoint-ORIG-GUID: k2moF_Kc7Snti5PleFeToWk3MTohZrcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=343 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070195
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 1:42 PM, Konrad Dybcio wrote:
> On 7.09.2023 21:55, Anjelique Melendez wrote:
>>
>>
>> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>>> On 30.08.2023 20:05, Anjelique Melendez wrote:
>>>> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
>>>> configuration can be stored in a single SDAM module instead of LUT
>>>> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
>>>> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.
>>> I still fail to understand what benefit this brings.
>>>
>>> Is this a "can be used", or "should be used", or maybe "must be used"?
>>>
>>> Are there any distinct advantages to using one over the other?
>>> I see some limitations in the code below, but that's not being made
>>> obvious.
>>>
>>> This all should be in the commit message, the current one includes
>>> a lot of cryptic names that mean nothing to most people.
>>>
>>> [...]
>> This is a must be used if you would like to trigger patterns. Will update commit message to try and 
>> make that more clear for next patch.
> So essentially without this patchset, PM8350C and PMI632 are not capable
> of producing LED patterns. Is that correct?
Yes, that is correct. Since PMI632 and PM8350C do not have LUT peripherals, current code
will not allow them to produce patterns. Luca mentioned this briefly when adding the 
PMI632 LPG device 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/leds/rgb/leds-qcom-lpg.c?h=v6.5&id=d11a79dd047e18dd0b76bc9abebb8470858856d6

> 
> Though I think that (in a separate patch, or perhaps series), it would
> be worth redoing the code such that hi/lo_pause expresses the deviation
> from the duration of the rest instead of the duration itself. Then we
> could just:
> 
> if ((lo_pause || hi_pause)) && lpg->lpg_chan_nvmem)
> 	goto out_free_pattern;
> 
> But that's just a suggestion from somebody that didn't work on this code.
> 
The value that is written back for hi/low_pause is
"how many steps should we hold the first/last pattern values" where step = delta_t.
So if delta_t == hi/low_pause we would need to write back 1. I can look into seeing
if expressing hi/lo_pause as a deviation can easily translate for a different patch
series.

> Also, I think that using lpg_chan_nvmem interchangeably with SDAM is a
> bit confusing. Do we expect NVMEMs/SRAMs that aren't SDAM to make an
> appearence here?
> I believe we only expect SDAMs. I can change the use of nvmem to sdam in
following patch for comments and variable names.

Thanks,
Anjelique
