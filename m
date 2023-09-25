Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532FD7ACEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjIYEDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIYEDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:03:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C61DF;
        Sun, 24 Sep 2023 21:03:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P42l6F032695;
        Mon, 25 Sep 2023 04:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EJv43BLG4bIBsKldJJ3EqpDZxygtvsu9LxyYIdswit8=;
 b=TW+PArUdTN7VTw5WEF7ySdNctiYEUo2TzaK832Rewq822cUhvICo/ivr5Sy0I2gZoVXs
 xPiucO24bc2jH1gz8OGkHIt3CkkZ4HXado+UWLtGzgaIZuJU/Jdt+LairOtRJU3T9OlB
 jsQwmad+DP4HYTyNYID0GWxf6EWHdhQ46pGpbomdkN49526HFvMvIr+JokwAZLv1NTJw
 s5uGaSQ9cM88txaVY1Saq2QjOmeVVjojefSIpqZO0j8OD9B6XVEZ4kd09212KdbCHjcG
 oIANbPOXJXfoIF3EEhAKBUXPDTp6IxJ1c8qYocGXz9QHtWeL8kzfTq3D9Lfk5D2LusNN bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9r41jk49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 04:03:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P43LpO001397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 04:03:21 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 24 Sep
 2023 21:03:18 -0700
Message-ID: <742d8d13-56f7-40d4-8bfe-fe6e4b062104@quicinc.com>
Date:   Mon, 25 Sep 2023 09:32:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20230607045345.25049-1-quic_kathirav@quicinc.com>
 <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
 <CAA8EJprVQZXXVnNCULDYeUha0-mSyLZr1r6axbmw1MUiP_O9zg@mail.gmail.com>
 <ww5rr5okemzevgdvueok5k5uaqakmqdtdtjtw4jur2cdgfsep7@hz2y7qfat5jv>
 <44a46324-d01a-99a4-f358-aad3be1f4a45@quicinc.com>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <44a46324-d01a-99a4-f358-aad3be1f4a45@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xwUv0D9bGAth9NmlCxM_PXOayrur0wG5
X-Proofpoint-GUID: xwUv0D9bGAth9NmlCxM_PXOayrur0wG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/2023 8:23 AM, Elliot Berman wrote:
>
> On 9/19/2023 8:29 AM, Bjorn Andersson wrote:
>> On Fri, Sep 15, 2023 at 10:10:32PM +0300, Dmitry Baryshkov wrote:
>>> On Fri, 15 Sept 2023 at 18:17, Bjorn Andersson <andersson@kernel.org> wrote:
>>>> On Wed, Jun 07, 2023 at 10:23:45AM +0530, Kathiravan T wrote:
>>>>> During SCM probe, to identify the SCM convention, scm call is made with
>>>>> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
>>>>> result what convention to be used is decided.
>>>>>
>>>>> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
>>>>> variants, however TZ firmware runs in 64bit mode. When running on 32bit
>>>>> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
>>>>> system crash, due to the difference in the register sets between ARM and
>>>>> AARCH64, which is accessed by the TZ.
>>>>>
>>>>> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
>>>>>
>>>> My memory of this is cloudy, but I feel the logic is complicated because
>>>> early 64-bit boards all used 32-bit TZ. So, I really would like Elliot's
>>>> input before picking this change.
>>> But this codepath is not changed by this patch. Only the 32-bit
>>> codepath is altered.
>>>
>> Ohh, you're right, sorry about that. Would still be nice to see some
>> feedback from the team here...
>>
>>
>> The commit message is talking about the convention check crashing the
>> system, the only part of the convention checker that seems to matter to
>> me is the "calling convention" bit in the smc call.
>>
>> Per the "SMC calling convention specification", the 64-bit calling
>> convention bit can only be used when the client is 64-bit. So perhaps
>> this is the actual problem?
>>
>> Beyond that, another practical problem I can see is if we pass more than
>> 4 arguments to a call the layout of the extra arguments will not match
>> between the two worlds (as Linux will pass an array of unsigned long).
>>
>>
>> With this in mind, I'd like the commit message to be more specific.
>>
>> Afaict, this is not an issue with the convention detection, but rather
>> the invalid to call __scm_smc_call() with 64-bit convention on a 32-bit
>> system. Working around this by having an undocumented #if ARM64 in
>> another part of the driver isn't clear enough, IMHO.
>>
>> Moving the check to __scm_smc_call(), or at least documenting the
>> behavior there (and next to the #if) seems reasonable.
>>
> In terms of disallowing 64-bit convention to be probed on a 32-bit kernel:
>
> Reviewed-By: Elliot Berman <quic_eberman@quicinc.com>
>
> I first thought moving the check to __scm_smc_call() would be better but
> then I realized we would be adding an extra runtime check for each SCM call
> that either always passes or always fails. I think the current #if is best
> as-is, although it would be good to add some comments explaining why as
> Bjorn mentioned.


Thanks everyone for taking time to review the patch! Will add a comment 
above the #if block and post the next version.


>
>> Regards,
>> Bjorn
>>
>>
>>>> Regards,
>>>> Bjorn
>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
>>>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>>>> ---
>>>>> Changes in V2:
>>>>>        - Added the Fixes tag and cc'd stable mailing list
>>>>>
>>>>>   drivers/firmware/qcom_scm.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>>> index fde33acd46b7..db6754db48a0 100644
>>>>> --- a/drivers/firmware/qcom_scm.c
>>>>> +++ b/drivers/firmware/qcom_scm.c
>>>>> @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
>>>>>        if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>>>>>                return qcom_scm_convention;
>>>>>
>>>>> +#if IS_ENABLED(CONFIG_ARM64)
>>>>>        /*
>>>>>         * Device isn't required as there is only one argument - no device
>>>>>         * needed to dma_map_single to secure world
>>>>> @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
>>>>>                forced = true;
>>>>>                goto found;
>>>>>        }
>>>>> +#endif
>>>>>
>>>>>        probed_convention = SMC_CONVENTION_ARM_32;
>>>>>        ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
>>>>> --
>>>>> 2.17.1
>>>>>
>>>
>>>
>>> -- 
>>> With best wishes
>>> Dmitry
