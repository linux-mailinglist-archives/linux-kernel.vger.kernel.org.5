Return-Path: <linux-kernel+bounces-81240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B4867275
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3527A2905B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5501EEE9;
	Mon, 26 Feb 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+tgkjHj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089E1CD20;
	Mon, 26 Feb 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945216; cv=none; b=A431Nio8bEFxMBa93iaEC9c/i6ri0WahDEi6XlXlpY2jzcsdi6PbtinxAYlHTwp1jVjtR2N+tCZ2N6qwXq2xsLsIijM8qVpkOt36xNhdi14Uy32kb8J1TEC6dNaSUy+pO90aiF3nF6U8vefy7FtwBpKEAt/1pyn5aUIXW53Y7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945216; c=relaxed/simple;
	bh=SjLGttHsZJtk6jKIdT3ibTrPXA9NRRX4evGy4abyPLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sHt9UUgueHVn04a45fRfpKlgKJW00nbAmM3TIM+N9lqA7xAwtr/MR9ig0NNwspEO4f+TAacbYAxGVjCdXGqbcg/qokAl2zeCEr10dou6t431ydF6Y7Tp0OCx/p9Q7VB1W2HUThRhbrUnDjulyclcNiRhwnWSq4C96Fios9NCFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N+tgkjHj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5dVqe007726;
	Mon, 26 Feb 2024 11:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ak1pxr0EXcWVcO+J/sI2zGIzURu8/kek+vAkhJGa/4k=; b=N+
	tgkjHj9jbsFxD1qnarGrK86KCdPuNvkthWwpT9W04k1gRf+l2invUqEPUqCUwNKY
	G/HRKeXDgm1TdRWNxRjR5pYpY0OIsgYsy4kYU6PT9BzLPBJKChF55sGpZtow6cJN
	8Kw+H0iR8hF/6NswwIeNqSxaBVdoMikT9jHz+ux6FLyip6zEobvbtZrE69Qc33Gh
	bjkHZgOTIgTFUR7Bv6Oxz1yBwPGj2GVhHwgEeAiSe1Ceb+rf7+MgSLd4VMYLZlxL
	No8rzx2epq2SvkwDcvWfnIVqy6pIqkzIE4qsiDacnvHl0vHcmU7n3AAqmCurrVjx
	HJFqtU/gmRWIa/58QsWg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmgq0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:00:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QB09rw005195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 11:00:09 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 03:00:06 -0800
Message-ID: <96aa13e2-828e-b961-996e-7260cd564589@quicinc.com>
Date: Mon, 26 Feb 2024 16:30:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Add llcc device availability check
Content-Language: en-US
To: Sahil Chandna <quic_chandna@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240220122805.9084-1-quic_mojha@quicinc.com>
 <c60638be-e12e-4148-8c20-1dbba9c817da@quicinc.com>
 <d617c991-b7a7-eb8f-0747-303c33cbf9a7@quicinc.com>
 <ff4de2ac-ab2f-4c34-a49c-dd78ceb8add5@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ff4de2ac-ab2f-4c34-a49c-dd78ceb8add5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q4JPQR-lqbl-Ar7Q1UmltD_gZBYSLttO
X-Proofpoint-ORIG-GUID: q4JPQR-lqbl-Ar7Q1UmltD_gZBYSLttO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260083



On 2/26/2024 4:19 PM, Sahil Chandna wrote:
> On 2/26/2024 4:02 PM, Mukesh Ojha wrote:
>>
>>
>> On 2/22/2024 11:37 PM, Sahil Chandna wrote:
>>> On 2/20/2024 5:58 PM, Mukesh Ojha wrote:
>>>> When llcc driver is enabled  and llcc device is not
>>>> physically there on the SoC, client can get
>>>> -EPROBE_DEFER on calling llcc_slice_getd() and it
>>>> is possible they defer forever.
>>>>
>>>> Let's add a check device availabilty and set the
>>>> appropriate applicable error in drv_data.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>   drivers/soc/qcom/llcc-qcom.c | 23 ++++++++++++++++++++++-
>>>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/llcc-qcom.c 
>>>> b/drivers/soc/qcom/llcc-qcom.c
>>>> index 4ca88eaebf06..cb336b183bba 100644
>>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>>> @@ -769,6 +769,27 @@ static const struct qcom_sct_config 
>>>> x1e80100_cfgs = {
>>>>   };
>>>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>>>> +static DEFINE_MUTEX(dev_avail);
>>> what is the requirement for mutex lock here? Since we are only trying 
>>> to find if node present or not
>>
>> I was trying to avoid two parallel call from llcc_slice_getd() calling
>> parallel call to of_find_node_by_name() as it should be one time 
>> search for device presence to find a node and check if device is 
>> present or
>> not.
>>
>> -Mukesh
>>
> Got it, but of_find_node_by_name () is holding a raw_spin_lock_irqsave 
> () for concurrency, right ? please correct me if understanding is wrong.

Even though, of_find_node_by_name () is holding spin_lock but nothing
is preventing the 2nd call from happening. Here, mutex and check on
!ptr ensures, we don't make 2nd call.

-Mukesh
>>>> +
>>>> +static bool is_llcc_device_available(void)
>>>> +{
>>>> +    static struct llcc_drv_data *ptr;
>>>> +
>>>> +    mutex_lock(&dev_avail);
>>>> +    if (!ptr) {
>>>> +        struct device_node *node;
>>>> +
>>>> +        node = of_find_node_by_name(NULL, "system-cache-controller");
>>>> +        if (!of_device_is_available(node)) {
>>>> +            pr_warn("llcc-qcom: system-cache-controller node not 
>>>> found\n");
>>>> +            drv_data = ERR_PTR(-ENODEV);
>>>> +        }
>>>> +        of_node_put(node);
>>>> +        ptr = drv_data;
>>>> +    }
>>>> +    mutex_unlock(&dev_avail);
>>>> +    return (PTR_ERR(ptr) != -ENODEV) ? true : false;
>>>> +}
>>>>   /**
>>>>    * llcc_slice_getd - get llcc slice descriptor
>>>> @@ -783,7 +804,7 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
>>>>       struct llcc_slice_desc *desc;
>>>>       u32 sz, count;
>>>> -    if (IS_ERR(drv_data))
>>>> +    if (!is_llcc_device_available() || IS_ERR(drv_data))
> Also, thinking about this, should the status of device present or not be 
> saved in static variable instead of function call for each client ?
>>>>           return ERR_CAST(drv_data);
>>>>       cfg = drv_data->cfg;
>>>
> 
> Regards,
> Sahil

