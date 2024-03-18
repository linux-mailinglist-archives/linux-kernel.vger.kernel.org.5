Return-Path: <linux-kernel+bounces-106147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A439787E9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4441F1F21EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0C038DEF;
	Mon, 18 Mar 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YnU+g3/Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2D3BB35;
	Mon, 18 Mar 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767323; cv=none; b=VzZxyI+vOIIm7lyQjTCgrzX1DiAfxThrG2UPb4uV0NXNMMdlf/NZs9slxI189LPM7vd/9++dMrCp3yQFyLBfiFqZnxGYdyQVxcvMDGOiuGipSBlMWC+ba25ejUIYThj3sVltJn2KvaMMJ6jmze5EQJYwrslOJbE3UoQh6mqxqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767323; c=relaxed/simple;
	bh=ztUZOiiQ83sOZSaGrczXdpBYDKXlAj5hFGLEYEnTbW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=btZjYQcYVOj1oJooPn0QLMB5bZVMN8yQ7D1cRDSbh1MLv5NqAQ0JgpxvpvKJjLJTomvwYYYgV53pQ0fCmWdxYXY+GVq/wDVbuJJ8PXk9wwn9aop/sih4UKufC4z6xEnx87efF408+EYGkR7Py4F72VVCCPeXEMfArMPgSLMld+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YnU+g3/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IC2IW7021532;
	Mon, 18 Mar 2024 13:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZxobO1it1RfZw+po5acttX2e+DmpggTe3qaJAqZDePs=; b=Yn
	U+g3/ZECPHeIdJ+7j+XUTmlX+oLvz7JBObLHs4uWu+/AhCCeDmS640if38KF2h3O
	2l8ZOSMdO9f0xSCrnjDRpjB1RThnvjppmSkPPYgOZHl563LMPV0n9QjGSl5ay+15
	bj+zRtlwSDzcYlLRFPlNngEgcuwj/N852dZBRMxIWMcssitqe8SGOYD+r3ggu0Zc
	IuktDi3gxvLEmEx3WfRaEZ3lpgHkZEtagCFL7lniz5X8UmDu+dtDfxryuH7W1n7i
	UaAYgvCSUETX2YUJMmyDwHgQ41HbYXTXlgCmMadPmsy+xntZI8O27ef4+6Hr/NGb
	+BSYMtWQecRtLbGGpU6A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxta9y1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 13:08:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ID8VMe029353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 13:08:31 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 06:08:29 -0700
Message-ID: <260371ff-da7a-8406-0511-4019f6b860bf@quicinc.com>
Date: Mon, 18 Mar 2024 18:38:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 7/9] firmware: qcom: scm: Fix __scm->dev assignement
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-8-quic_mojha@quicinc.com>
 <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <n2gomlmlzwodpg2v3gzuc62n3plewdqgiwctrv2tawdih26rig@obqd2a2ovqvp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0D1krBj979_XuCMiTaT-7x-b_71Hffyw
X-Proofpoint-ORIG-GUID: 0D1krBj979_XuCMiTaT-7x-b_71Hffyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_04,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180098



On 3/3/2024 12:55 AM, Bjorn Andersson wrote:
> On Tue, Feb 27, 2024 at 09:23:06PM +0530, Mukesh Ojha wrote:
>> qcom_scm_is_available() gives wrong indication if __scm
>> is initialized but __scm->dev is not.
>>
>> Fix this appropriately by making sure if __scm is
>> initialized and then it is associated with its
>> device.
>>
> 
> This seems like a bug fix, and should as such have a Fixes: tag and
> probably Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/firmware/qcom/qcom_scm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 6c252cddd44e..6f14254c0c10 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -1859,6 +1859,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   	if (!scm)
>>   		return -ENOMEM;
>>   
>> +	scm->dev = &pdev->dev;
>>   	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
>>   	if (ret < 0)
>>   		return ret;
>> @@ -1895,7 +1896,6 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   		return ret;
>>   
>>   	__scm = scm;
>> -	__scm->dev = &pdev->dev;
> 
> Is it sufficient to just move the line up, or do we need a barrier of
> some sort here?

Would be good to use, smp_mb() before the assignment
      __scm = scm
along with moving below line
__scm->dev = &pdev->dev

somewhere up.

-Mukesh

> 
> Regards,
> Bjorn
> 
>>   
>>   	init_completion(&__scm->waitq_comp);
>>   
>> -- 
>> 2.43.0.254.ga26002b62827
>>

