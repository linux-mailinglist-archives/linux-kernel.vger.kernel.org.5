Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384C8128D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjLNHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:13:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00E6107;
        Wed, 13 Dec 2023 23:13:19 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE2wi5i004126;
        Thu, 14 Dec 2023 07:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:from:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=VmqZYjMx0vgFysXJdO/GGgQWXfWPrqIdMa2UVbw3zwY=; b=RT
        r6hH6pnKUNFE5A9SOfH6UW3XurQOgJeUpE+5nvfcZdqLlzXjtUcRktkYHqtqPKa2
        R6z9NV7lFeNneJW+GEbIF0XN+GtP8HPlsBIe5rG0YNQtqYjIk8BkW9PNY4pd0+mB
        k6URBSiIDudlBVNl1zRWN3+9WAExNcrPdoNkgLE8Z1c5NavW2kJkgC7YxNO1rB8J
        ODZeXKzn/exYaVvHDp+M2JygLAuNZB7F1kZpPMOR5UJW7nzYV2xZii8NUhRutQ+y
        7y+TIbFjf1B/G6KDMIQzIZ8Uu9iDp6H3+aa0T4y4zd6gbmc6XD7TpCg7Xnr9QP7U
        ZdmqCDIANd8HmIZ13i9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq9t0ntn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 07:13:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE7D9tH001194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 07:13:09 GMT
Received: from [10.50.15.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 23:13:06 -0800
Message-ID: <54e882ba-4758-1283-1a52-1f12201e1836@quicinc.com>
Date:   Thu, 14 Dec 2023 12:43:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 05/17] scsi: ufs: qcom: Remove the warning message when
 core_reset is not available
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <ahalaney@redhat.com>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <20231208065902.11006-6-manivannan.sadhasivam@linaro.org>
 <7472fe73-e7a0-5c8c-6e85-655db028a5c3@quicinc.com>
 <20231208102832.GA3008@thinkpad>
 <190651ad-6aeb-69eb-89c5-ed18221b5a7a@quicinc.com>
Content-Language: en-US
In-Reply-To: <190651ad-6aeb-69eb-89c5-ed18221b5a7a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W2zM5WfzVBaFH0jkMVrp6SDQahMuyZ3Q
X-Proofpoint-GUID: W2zM5WfzVBaFH0jkMVrp6SDQahMuyZ3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2023 6:59 PM, Nitin Rawat wrote:
> 
> 
> On 12/8/2023 3:58 PM, Manivannan Sadhasivam wrote:
>> On Fri, Dec 08, 2023 at 02:55:21PM +0530, Nitin Rawat wrote:
>>>
>>>
>>> On 12/8/2023 12:28 PM, Manivannan Sadhasivam wrote:
>>>> core_reset is optional, so there is no need to warn the user if it 
>>>> is not
>>>> available.
>>>>
>>>> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>> ---
>>>>    drivers/ufs/host/ufs-qcom.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>> index dc93b1c5ca74..d474de0739e4 100644
>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>> @@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba 
>>>> *hba)
>>>>        struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>>        bool reenable_intr;
>>>> -    if (!host->core_reset) {
>>>> -        dev_warn(hba->dev, "%s: reset control not set\n", __func__);
>>>> +    if (!host->core_reset)
>>>>            return 0;
>>>> -    }
>>>>        reenable_intr = hba->is_irq_enabled;
>>>>        disable_irq(hba->irq);
>>>
>>>
>>> Hi Mani,
>>>
>>> I think core reset is not frequent. It happen during only probe ,error
>>> handler.
>>>
>>> core reset is needed in kernel to cleanup UFS phy and controller
>>> configuration before UFS HLOS operation starts as per HPG.
>>>
>>
>> This sounds like core reset is not an optional property but a required 
>> one. I
>> just checked the upstream DT files for all SoCs, and looks like pretty 
>> much all
>> of them support core reset.
>>
>> Only MSM8996 doesn't have the reset property, but the reset is 
>> available in GCC.
>> So we should be able to use it in dtsi.
>>
>> I also skimmed through the HPG and looks like core reset is not 
>> optional. Please
>> confirm.
>>
>> - Mani
> 
> 
> Hi Mani,
> 
> Yes Core_reset is part of HPG sequence and is needed.
> 
> Regards,
> Nitin


Hi Mani,

I see this patch series is merged . So planning to keep the warn message
based on above discussion.

Regards,
Nitin
> 
> 
>>
>>> Having existing warn print can be used to to debug or atleast know
>>> core_reset is missed in device tree to give indication complete reset 
>>> hasn't
>>> been done and we could still be operating in bootloader configuration.
>>>
>>>
>>> Regards,
>>> Nitin
>>>
>>
> 
