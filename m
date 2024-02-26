Return-Path: <linux-kernel+bounces-81212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27486721B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4E1C25B14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938E4CB45;
	Mon, 26 Feb 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F1oiaveG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F249F5;
	Mon, 26 Feb 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944569; cv=none; b=KQ/yEUherz9iwntY/uMbe3rcheEL7guWznyflRPnHRSJKEPEuhYYK4KR01uBFfGzNJPz+1MFIk2gqSCFOGKs9rcHX9nX91ci+Hplz3Qi4BoWmBeI/tIpGl2dqxxBWqFau/e/1K8dxkvUZoPP1iJoCaxJ/X+O+PIzlE9zUwieYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944569; c=relaxed/simple;
	bh=z8/tQg16Mj4QPFaSnOVlLDwmLI2YQNbI1hMXpNdN8aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HIIm1M9hhePp/hV4Ofp5bmoAfQ5nlXS0gZPNwvoOhQWPdvK4UrfZMTQB2BDXcpBwHpEEZPOonLbwyypbQxw3Bl65yxkMUtkaU6bWgKVsyYqIPPHXTo2hVILG/DZp48bCmE1zumdyz9UUQl7NUl68f4o0sdt6xI2GwnvqERITSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F1oiaveG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5d3LM005307;
	Mon, 26 Feb 2024 10:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w9TyoGpOCvRQv/gJUy7+mFP1pj5Rw37oykK8RZNDLt8=; b=F1
	oiaveGESwo0VHyX4IWey4qAvMd2F//vUdugkWNibELdC9dBczrj6k5d/lLzZSSKx
	vDdLCZvXMyb1j+X5NUMH2EEf17SdUOa05+0r/zVZP5HZDkdzxJTELJ3gY2d0ZdtF
	LcUgz0XyggfQVCXCd0xkc6UuvebcIeJSs+6wD9XOPn7tajEHJPCeK/aU/EiU0oL9
	gjptgGAcswTrwc6yvCfKeyf3YM6UnIdxbttuSUQtkQVkIHNfj81p3pc797GmLPE8
	+Jmrh4Rv+XpBmkHPsxZiG/e078Pl3q5YS6tzDUBj2g4drKhgRN52e4Au8XSvac5/
	0H73wICntUTF5Tbyo6PA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmgp38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:49:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QAnLYX014322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:49:21 GMT
Received: from [10.216.40.60] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 02:49:19 -0800
Message-ID: <ff4de2ac-ab2f-4c34-a49c-dd78ceb8add5@quicinc.com>
Date: Mon, 26 Feb 2024 16:19:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Add llcc device availability check
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240220122805.9084-1-quic_mojha@quicinc.com>
 <c60638be-e12e-4148-8c20-1dbba9c817da@quicinc.com>
 <d617c991-b7a7-eb8f-0747-303c33cbf9a7@quicinc.com>
From: Sahil Chandna <quic_chandna@quicinc.com>
In-Reply-To: <d617c991-b7a7-eb8f-0747-303c33cbf9a7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qJ9hNCjc6XPSDviz-XC4N3SeuJOVusRD
X-Proofpoint-ORIG-GUID: qJ9hNCjc6XPSDviz-XC4N3SeuJOVusRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260082

On 2/26/2024 4:02 PM, Mukesh Ojha wrote:
> 
> 
> On 2/22/2024 11:37 PM, Sahil Chandna wrote:
>> On 2/20/2024 5:58 PM, Mukesh Ojha wrote:
>>> When llcc driver is enabled  and llcc device is not
>>> physically there on the SoC, client can get
>>> -EPROBE_DEFER on calling llcc_slice_getd() and it
>>> is possible they defer forever.
>>>
>>> Let's add a check device availabilty and set the
>>> appropriate applicable error in drv_data.
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/llcc-qcom.c | 23 ++++++++++++++++++++++-
>>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>> index 4ca88eaebf06..cb336b183bba 100644
>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>> @@ -769,6 +769,27 @@ static const struct qcom_sct_config 
>>> x1e80100_cfgs = {
>>>   };
>>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>>> +static DEFINE_MUTEX(dev_avail);
>> what is the requirement for mutex lock here? Since we are only trying 
>> to find if node present or not
> 
> I was trying to avoid two parallel call from llcc_slice_getd() calling
> parallel call to of_find_node_by_name() as it should be one time search 
> for device presence to find a node and check if device is present or
> not.
> 
> -Mukesh
> 
Got it, but of_find_node_by_name () is holding a raw_spin_lock_irqsave 
() for concurrency, right ? please correct me if understanding is wrong.
>>> +
>>> +static bool is_llcc_device_available(void)
>>> +{
>>> +    static struct llcc_drv_data *ptr;
>>> +
>>> +    mutex_lock(&dev_avail);
>>> +    if (!ptr) {
>>> +        struct device_node *node;
>>> +
>>> +        node = of_find_node_by_name(NULL, "system-cache-controller");
>>> +        if (!of_device_is_available(node)) {
>>> +            pr_warn("llcc-qcom: system-cache-controller node not 
>>> found\n");
>>> +            drv_data = ERR_PTR(-ENODEV);
>>> +        }
>>> +        of_node_put(node);
>>> +        ptr = drv_data;
>>> +    }
>>> +    mutex_unlock(&dev_avail);
>>> +    return (PTR_ERR(ptr) != -ENODEV) ? true : false;
>>> +}
>>>   /**
>>>    * llcc_slice_getd - get llcc slice descriptor
>>> @@ -783,7 +804,7 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
>>>       struct llcc_slice_desc *desc;
>>>       u32 sz, count;
>>> -    if (IS_ERR(drv_data))
>>> +    if (!is_llcc_device_available() || IS_ERR(drv_data))
Also, thinking about this, should the status of device present or not be 
saved in static variable instead of function call for each client ?
>>>           return ERR_CAST(drv_data);
>>>       cfg = drv_data->cfg;
>>

Regards,
Sahil

