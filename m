Return-Path: <linux-kernel+bounces-50618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0226847BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC54B24E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998483A03;
	Fri,  2 Feb 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J9HscVfo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3B839E5;
	Fri,  2 Feb 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909909; cv=none; b=oby+88b7QC4TUPwqNhbochdRlvrRTGQ8OWkL2WgTfSYsQPSdv5cdtL/r+kS0KKZIzYAQbUaNk1b7DFsXHzmdtYrwVfgRJZPdcFjCV9hGSvNljcwSrKDnb1ldWVZyCfPY83hxvKcW2RRzuOfOEoFO44D7ZPyvEbfTSzwZNPCdSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909909; c=relaxed/simple;
	bh=lqCpQsXVTy+dSJVBp3WfGbAzEvkjwDZvUChqW8CkS9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MvzDNUWHqO4ER+kl2uFqiMuydOkhNhxu+b18XDRUwaV2y5OeJOU7Yi6ofzbOSxtXxDco4PIL3dy4NlbHBB9d8zksyTu4eqN9gJMN3KMC7kueL5++IPYOcWoAnQcjNF8B0UywDp2qYU8vXNQxxIQtZpdewjJwHH4TAKuXFTAMKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J9HscVfo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412Jwwg1021603;
	Fri, 2 Feb 2024 21:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ldFHZ0O8cBXpgd6zgNxpsJBeusJDBKoGQUskWZPAlbg=; b=J9
	HscVfoeIg7tDcfDd1V6Fz5rZdddFJw9+bk6G9r/8sa7pNOJP/F5LycM438m9M8uw
	KGHyvRBQPkSehsSFES02OU5tkcASAef8EMBhHBzlxKS8IKWh5IZ6y7Sp+bp5XDHi
	rBthvJ6TCr85XjViA9C+F/FcvRslEANPzJCovSgtj39SXRMDaxLvRJ/i0M+UQFez
	l1hGB5reDm17+Lsm8dT10YxqJxeTuaP+HwG7H3skeDLpoUtbwNfk8dCjyzBrkjxt
	xR+NhlcUhDDCwLMJOdt32If+DJSHIAJjFxRYgU5eiYT5xlVQv+zonIawUDynZt/W
	MGSY8m9y1XbM4L6pl5/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1tfwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 21:38:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412LbxU0028229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 21:37:59 GMT
Received: from [10.110.44.7] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 13:37:58 -0800
Message-ID: <073bcb5c-6718-4a64-8d14-281a589d2205@quicinc.com>
Date: Fri, 2 Feb 2024 13:37:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] remoteproc: qcom_q6v5_wcss: Use devm_rproc_alloc()
 helper
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team
	<linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice
 Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240123184632.725054-1-afd@ti.com>
 <20240123184632.725054-6-afd@ti.com>
 <256072b3-c1d0-4e11-9456-bbd50b84a310@quicinc.com>
 <60d46d58-ad77-47e8-8ff6-bc05db7cf1be@ti.com>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <60d46d58-ad77-47e8-8ff6-bc05db7cf1be@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 34GYM_9AIe1L18E8Zn0iret852KAD9m2
X-Proofpoint-ORIG-GUID: 34GYM_9AIe1L18E8Zn0iret852KAD9m2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020159

On 2/2/2024 1:14 PM, Andrew Davis wrote:
> On 2/2/24 2:51 PM, Unnathi Chalicheemala wrote:
>>
>>
>> On 1/23/2024 10:46 AM, Andrew Davis wrote:
>>> Use the device lifecycle managed allocation function. This helps prevent
>>> mistakes like freeing out of order in cleanup functions and forgetting to
>>> free on error paths.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>>   drivers/remoteproc/qcom_q6v5_wcss.c | 24 +++++++++---------------
>>>   1 file changed, 9 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
>>> index cff1fa07d1def..94f68c919ee62 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
>>> @@ -1011,8 +1011,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>>       if (!desc)
>>>           return -EINVAL;
>>>   -    rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>>> -                desc->firmware_name, sizeof(*wcss));
>>> +    rproc = devm_rproc_alloc(&pdev->dev, pdev->name, desc->ops,
>>> +                 desc->firmware_name, sizeof(*wcss));
>>>       if (!rproc) {
>>>           dev_err(&pdev->dev, "failed to allocate rproc\n");
>>>           return -ENOMEM;
>>> @@ -1027,29 +1027,29 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>>         ret = q6v5_wcss_init_mmio(wcss, pdev);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        return ret;
>>>         ret = q6v5_alloc_memory_region(wcss);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        return ret;
>>>         if (wcss->version == WCSS_QCS404) {
>>>           ret = q6v5_wcss_init_clock(wcss);
>>>           if (ret)
>>> -            goto free_rproc;
>>> +            return ret;
>>>             ret = q6v5_wcss_init_regulator(wcss);
>>>           if (ret)
>>> -            goto free_rproc;
>>> +            return ret;
>>>       }
>>>         ret = q6v5_wcss_init_reset(wcss, desc);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        return ret;
>>>         ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        return ret;
>>>         qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
>>>       qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
>>> @@ -1061,16 +1061,11 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>>>         ret = rproc_add(rproc);
>>>       if (ret)
>>> -        goto free_rproc;
>>> +        return ret;
>>>         platform_set_drvdata(pdev, rproc);
>>>         return 0;
>>> -
>>> -free_rproc:
>>> -    rproc_free(rproc);
>>> -
>>> -    return ret;
>>
>> This return statement should stay, right?
>>
> 
> No path goes to "free_rproc" anymore, so we always do the "return 0;"
> above on non-error paths.
> 
> Andrew
> 


You're right, thanks all QCOM peripheral patches LGTM.

>>>   }
>>>     static void q6v5_wcss_remove(struct platform_device *pdev)
>>> @@ -1080,7 +1075,6 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
>>>         qcom_q6v5_deinit(&wcss->q6v5);
>>>       rproc_del(rproc);
>>> -    rproc_free(rproc);
>>>   }
>>>     static const struct wcss_data wcss_ipq8074_res_init = {

