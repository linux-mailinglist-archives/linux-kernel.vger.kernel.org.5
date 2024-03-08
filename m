Return-Path: <linux-kernel+bounces-97019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DE87647D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45EB1F226E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861618EAB;
	Fri,  8 Mar 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JeABPd+f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE414F98;
	Fri,  8 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901828; cv=none; b=a8JImugjxU7ZPXEufrtQz6J7sQZ3uGgBjG/AfVbW/narqxAKsi9uvA0/VcE0B1UBiB51VSwga7V2+YInHZrq3KF89qnurvlalqD9arjBGgaUcN7C1aLf7fzndeR33XxHOia8rv7TN4NZsttg6/c30rkmSw/x7ipu8FTibJaR45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901828; c=relaxed/simple;
	bh=pGPyxY4xey0LpvE+RP3d8bxeSrlEhfkiAYH7RTLqgcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RbSxbyquDAsNBOyYrCwFAuWflNAr1KWaQ2+89WNCiFsJCS9eK4i144vow47xhaeUo7hyt38WXbqYD0GbDobd6k5q9YRdb+J8SWxiFT+bz+kF9qzZRN0S//AwJTBEprlXGj9UjjvIyEaywgX3J8gbwYFWg4OgeMmkjFLC9XLx5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JeABPd+f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428AjMLW026896;
	Fri, 8 Mar 2024 12:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nY2VG82b+ivJfZOzlfIERrNz50L7KSM3nXuL3F//TZ4=; b=Je
	ABPd+fplo5kRF4DK0cCV90chBmoasIm28/y3Dy1vvkWFjpGWsnPgiMWxz7et4P5d
	jyshTiDvTKO1qnS0Sh+uQm1OUXYwsNcZp2ioEieKxR7qqbMEy1iWvnZHMdRmwt31
	6fIAtUCbmKlaIb0Uv8RoW+48RehbHbRt9Vj1/rMa4n89cyEB2i07WlPiV/jluauR
	9yEw12d5bLzsqY8PfWpBLWUKjMAirCKYSWkG1QOcM1rgdjKKcA6yTP9xI1app0aD
	3nPLgM9jKNKzsOzZaHZDJNCMNgxi+H/IpreGuIFQ1z8u2Ka2ZEdg06Q9IFbTrMMO
	0n83cFUzbBJvTuvo5WeQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr16y08dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:43:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428Chc5b003833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 12:43:38 GMT
Received: from [10.216.59.105] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 04:43:35 -0800
Message-ID: <0fe1374b-318b-4dea-94fc-596c665eab53@quicinc.com>
Date: Fri, 8 Mar 2024 18:13:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC: <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_anupkulk@quicinc.com>, <quic_cchiluve@quicinc.com>
References: <20240304135000.21432-1-quic_vdadhani@quicinc.com>
 <d784e46d-974d-4bf3-a2d3-491e7ad19701@linaro.org>
Content-Language: en-US
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <d784e46d-974d-4bf3-a2d3-491e7ad19701@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UTP_M8OGb3LdCuB_7DUa4e32perp86ZZ
X-Proofpoint-GUID: UTP_M8OGb3LdCuB_7DUa4e32perp86ZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080102



On 3/6/2024 2:46 AM, Konrad Dybcio wrote:
> 
> 
> On 3/4/24 14:50, Viken Dadhaniya wrote:
>> Currently we have auto suspend delay of 1s which is
>> very high and it takes long time to driver for runtime
>> suspend after use case is done.
>>
>> Hence to optimize runtime PM ops, reduce auto suspend
>> delay to 100ms.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
> 
> What determines 1s to be high and 100ms to be low enough? Could
> you share some more reasoning?

Right now we don't have exact number which can quantify either power or 
performance. But we are following small window so as to not keep timer 
running longer while having resources like Clock ON. Theoretically and 
testing wise, this is not creating any side effect too.

> 
>>   drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c 
>> b/drivers/slimbus/qcom-ngd-ctrl.c
>> index efeba8275a66..5de45a0e3da5 100644
>> --- a/drivers/slimbus/qcom-ngd-ctrl.c
>> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
>> @@ -81,7 +81,7 @@
>>   #define SLIM_USR_MC_DISCONNECT_PORT    0x2E
>>   #define SLIM_USR_MC_REPEAT_CHANGE_VALUE    0x0
>> -#define QCOM_SLIM_NGD_AUTOSUSPEND    MSEC_PER_SEC
>> +#define QCOM_SLIM_NGD_AUTOSUSPEND    (MSEC_PER_SEC / 10)
> 
> This could be a good opportunity to inline this value..

Updated in v2.

> 
> Konrad

