Return-Path: <linux-kernel+bounces-93612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739C87328A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A34B29A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCA5DF14;
	Wed,  6 Mar 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KxpyDxY5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836D5C5E9;
	Wed,  6 Mar 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716691; cv=none; b=JRep0TFGBfr5xnp0p36fxvZinJr5tgNpCciGbYe93mWfpouGHvPPFdiJp/H6eup3R2IOvZ9p/7kh1d2Snv0W9qoHQAyoc57ch5cOwIUdefzZfBCJr7HAsdQRtC22YiPmIWsztDnWXHRuLveuP4zK/hhfo4AwNnQzstvlpSxlPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716691; c=relaxed/simple;
	bh=cfxI20d5y5qk2MaaG3XBW6TAX2+iMo5kGMHs5KLDOuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kHcx6i5BKbOk3w4gWIR5misES8/rTvTvrQ4fBawzpZHe7AIePSGXlNNZxKWm75Dn7JhYs8O+ExMacak65uh1tWXN4ImKkz0jayN2FUmMQlM9PDAVtXAkHrBmPnc6B8T3vqyA5o21C/RSHv80t0JwO5dpupymY+E0ip2Vd5EWolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KxpyDxY5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4268mK6M001240;
	Wed, 6 Mar 2024 09:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mmJx23rcur9WCYWhXR3zM5xECJQumaTs6Yiz4SRud2A=; b=Kx
	pyDxY54wN3Y+5ZDYaRGYe4oMGaercyIgndTI9WOvSd3Mvg0/gmJvKzjangXITGO0
	XaPfF8dVqj9PbmUlPCXH8rCpGiX/K4MJ7STHrHNNPakgpSnW6LskUcX0NUIPVRRe
	rZNPZ0giPJHAdwujtCWAKyGoDObV6YaLER47JyOlt8SRpy5Ec2GBrM1bwKgdWyn7
	aYVl2EH2U0aKtCoB/tf55+3ZONybjI6ij2YukYgQ9ohBJnIpizhCVWmM1QcQzApu
	GhZmVNEC7F6VqG7J4xj88vEb2Ehc9NQOfWze4SQikBl1Yc7t4Rt3p9EUQnzfn3H0
	pNkhg4cqOu+7JVV+FQpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpgwmrk3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 09:18:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4269Hx7n002862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 09:17:59 GMT
Received: from [10.216.25.241] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 01:17:55 -0800
Message-ID: <1fafd225-e647-4a60-bd95-af12ad243182@quicinc.com>
Date: Wed, 6 Mar 2024 14:47:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC: <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_anupkulk@quicinc.com>, <quic_cchiluve@quicinc.com>
References: <20240304134228.16627-1-quic_vdadhani@quicinc.com>
 <8dbcd393-580b-4c29-9d6f-42988a5e7655@linaro.org>
Content-Language: en-US
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <8dbcd393-580b-4c29-9d6f-42988a5e7655@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zft9A-24MaGqR3GARGOpsN3quW_Iwrn8
X-Proofpoint-ORIG-GUID: Zft9A-24MaGqR3GARGOpsN3quW_Iwrn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060073



On 3/6/2024 2:49 AM, Konrad Dybcio wrote:
> 
> 
> On 3/4/24 14:42, Viken Dadhaniya wrote:
>> In current driver qcom_slim_ngd_up_worker() indefinitely
>> waiting for ctrl->qmi_up completion object. This is
>> resulting in workqueue lockup on Kthread.
>>
>> Added wait_for_completion_interruptible_timeout to
>> allow the thread to wait for specific timeout period and
>> bail out instead waiting infinitely.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
> 
> Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart 
> support")
> Cc: stable@vger.kernel.org
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
>>   drivers/slimbus/qcom-ngd-ctrl.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c 
>> b/drivers/slimbus/qcom-ngd-ctrl.c
>> index efeba8275a66..c27076d8b7db 100644
>> --- a/drivers/slimbus/qcom-ngd-ctrl.c
>> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
>> @@ -83,6 +83,7 @@
>>   #define QCOM_SLIM_NGD_AUTOSUSPEND    MSEC_PER_SEC
>>   #define SLIM_RX_MSGQ_TIMEOUT_VAL    0x10000
>> +#define SLIM_QMI_TIMEOUT_MS        1000
> 
> This could be inlined instead

Updated in v2.

> 
> Konrad

