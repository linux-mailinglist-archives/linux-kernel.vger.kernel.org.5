Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B07ACE82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjIYCx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYCx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:53:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5492;
        Sun, 24 Sep 2023 19:53:50 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P2VNUN023321;
        Mon, 25 Sep 2023 02:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bByjAe7L/WqvD+rMPel3o+Dc3rj51SEpxwc1ET0qT/8=;
 b=QlwAjeac52gJeQcJJTvzkb3U9kQie+YnsHhHz5fuorRD1FR9RbMHlxOT7aIhEdsj0bAx
 +N+TYp6ObwthG/8i4JYuBAnwFBvVZB4VGxOGC2zkndITd9goa5rvURsS6VWGZaugySL3
 89GHlOKT4SLujhjwIDTQeOtaVrWtCqTkBHiNMqxjKPmI/ky1/MJNN3puY7nDU4XPzH8X
 hpnBLmrmeHfilnniHAFD4Ab6zHPv5AyAiqX4WjAkqNdGDHiTk+5yjDhCJr+4ma/eU9R1
 rNWzmgUqwbT95SwABCKkTzKurruUwObj7uNBtJz9rYOWisYR5b0JMFhu3bgGPfCgAKYV BQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9rddag13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:53:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P2rkSa004802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:53:46 GMT
Received: from [10.110.53.84] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 24 Sep
 2023 19:53:45 -0700
Message-ID: <44a46324-d01a-99a4-f358-aad3be1f4a45@quicinc.com>
Date:   Sun, 24 Sep 2023 19:53:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20230607045345.25049-1-quic_kathirav@quicinc.com>
 <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
 <CAA8EJprVQZXXVnNCULDYeUha0-mSyLZr1r6axbmw1MUiP_O9zg@mail.gmail.com>
 <ww5rr5okemzevgdvueok5k5uaqakmqdtdtjtw4jur2cdgfsep7@hz2y7qfat5jv>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <ww5rr5okemzevgdvueok5k5uaqakmqdtdtjtw4jur2cdgfsep7@hz2y7qfat5jv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lI6vKl781blDsY8ayNuwTJnWJzTlfiQz
X-Proofpoint-ORIG-GUID: lI6vKl781blDsY8ayNuwTJnWJzTlfiQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250016
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/2023 8:29 AM, Bjorn Andersson wrote:
> On Fri, Sep 15, 2023 at 10:10:32PM +0300, Dmitry Baryshkov wrote:
>> On Fri, 15 Sept 2023 at 18:17, Bjorn Andersson <andersson@kernel.org> wrote:
>>>
>>> On Wed, Jun 07, 2023 at 10:23:45AM +0530, Kathiravan T wrote:
>>>> During SCM probe, to identify the SCM convention, scm call is made with
>>>> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
>>>> result what convention to be used is decided.
>>>>
>>>> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
>>>> variants, however TZ firmware runs in 64bit mode. When running on 32bit
>>>> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
>>>> system crash, due to the difference in the register sets between ARM and
>>>> AARCH64, which is accessed by the TZ.
>>>>
>>>> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
>>>>
>>>
>>> My memory of this is cloudy, but I feel the logic is complicated because
>>> early 64-bit boards all used 32-bit TZ. So, I really would like Elliot's
>>> input before picking this change.
>>
>> But this codepath is not changed by this patch. Only the 32-bit
>> codepath is altered.
>>
> 
> Ohh, you're right, sorry about that. Would still be nice to see some
> feedback from the team here...
> 
> 
> The commit message is talking about the convention check crashing the
> system, the only part of the convention checker that seems to matter to
> me is the "calling convention" bit in the smc call.
> 
> Per the "SMC calling convention specification", the 64-bit calling
> convention bit can only be used when the client is 64-bit. So perhaps
> this is the actual problem?
> 
> Beyond that, another practical problem I can see is if we pass more than
> 4 arguments to a call the layout of the extra arguments will not match
> between the two worlds (as Linux will pass an array of unsigned long).
> 
> 
> With this in mind, I'd like the commit message to be more specific.
> 
> Afaict, this is not an issue with the convention detection, but rather
> the invalid to call __scm_smc_call() with 64-bit convention on a 32-bit
> system. Working around this by having an undocumented #if ARM64 in
> another part of the driver isn't clear enough, IMHO.
> 
> Moving the check to __scm_smc_call(), or at least documenting the
> behavior there (and next to the #if) seems reasonable.
> 

In terms of disallowing 64-bit convention to be probed on a 32-bit kernel:

Reviewed-By: Elliot Berman <quic_eberman@quicinc.com>

I first thought moving the check to __scm_smc_call() would be better but
then I realized we would be adding an extra runtime check for each SCM call
that either always passes or always fails. I think the current #if is best
as-is, although it would be good to add some comments explaining why as
Bjorn mentioned.

> Regards,
> Bjorn
> 
> 
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
>>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>>> ---
>>>> Changes in V2:
>>>>       - Added the Fixes tag and cc'd stable mailing list
>>>>
>>>>  drivers/firmware/qcom_scm.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index fde33acd46b7..db6754db48a0 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
>>>>       if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>>>>               return qcom_scm_convention;
>>>>
>>>> +#if IS_ENABLED(CONFIG_ARM64)
>>>>       /*
>>>>        * Device isn't required as there is only one argument - no device
>>>>        * needed to dma_map_single to secure world
>>>> @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
>>>>               forced = true;
>>>>               goto found;
>>>>       }
>>>> +#endif
>>>>
>>>>       probed_convention = SMC_CONVENTION_ARM_32;
>>>>       ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
>>>> --
>>>> 2.17.1
>>>>
>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry
