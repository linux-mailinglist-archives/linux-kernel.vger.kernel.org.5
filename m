Return-Path: <linux-kernel+bounces-148256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA18A7FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C601C214DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCCD13A24E;
	Wed, 17 Apr 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c5igJRlQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561B13848B;
	Wed, 17 Apr 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346735; cv=none; b=TeenG03eZYszufm9ZOxVx1YVtBeEnivLgM4ly4lyYINJsxKvW4/fIMybSiaPyZRi32LRQBlWd//mv1jHleFCnvNM3oJZfs/bYffFnQ5iqU27tRrBOAsU60652wYdjVz3zKVfARv15mZ+52/r/cBkd2UlsXrT3uR2CbjcYjbwZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346735; c=relaxed/simple;
	bh=wz5NL7IQxeWyJ8tQWejK7QFsZwsTHPpFEi5oVoQUE/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkiTkbNcPTmS3dZ4g7bpGtyFfKRjwJdsieNcsTJuN7FjaNFzOiQmaD6ZTih0/B7UjsLlXBIkzVxWo1tuDDtmsDoiQEwx1Ajt3PzUwt92TTLTNMNqtOJSfzHTNL+mSyZ/e2jp8x4kmGnMFbZw/LF999Mqsvpm4hCscgX44hQdrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c5igJRlQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8H2tF016088;
	Wed, 17 Apr 2024 09:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zkjI+l3iXw75pa+Eb9TsKVOgvh6P4+/92z0UQArl9xk=; b=c5
	igJRlQlAvq5s6Nuq0O6XzT6sGSHMWVviESu2Fc+D3txaEuJAkfgm8t5vRB3Sn/9G
	0m/LvqV/DUbJ2ahVMWCAQdR3DhxfWkdkbOp/26w/L17QRp8bw72w7lj9YMKYrurv
	qRJjyzLeD+LpHLWiKs7ronUrvD5JiZe6wd89I9sh7GJJ2QbIY/6N8F54RVeUpb+D
	Lws7LC5aMOeUQWy3/mN8yhl+OCdDtt6KPf6WPiLzQLuwc2EFLKpTbHwflEf6eqY2
	97DeNKtOUtjCWf4bajX+PFmoQJDpSm/efDg3gDeRZkP+qw5W9etB+sZZvjGphLkD
	QpBPJy9B4CTWiYCsu8nw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjarpg5x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:38:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H9cjRD016779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:38:45 GMT
Received: from [10.216.60.103] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 02:38:41 -0700
Message-ID: <aef94318-4c32-4b9d-867f-25f366d425bd@quicinc.com>
Date: Wed, 17 Apr 2024 15:08:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 RESEND] slimbus: stream: Add null pointer check for
 client functions
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_anupkulk@quicinc.com>, <quic_cchiluve@quicinc.com>
References: <20240327083214.29443-1-quic_vdadhani@quicinc.com>
 <d2a4a91d-1b8a-4136-af30-50eb693423df@linaro.org>
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
In-Reply-To: <d2a4a91d-1b8a-4136-af30-50eb693423df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xf7QkCNDm8211gouQyfC2-f_2aC68YrD
X-Proofpoint-ORIG-GUID: xf7QkCNDm8211gouQyfC2-f_2aC68YrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170066



On 4/11/2024 3:19 PM, Srinivas Kandagatla wrote:
> Thanks Viken for the patch,
> 
> On 27/03/2024 08:32, Viken Dadhaniya wrote:
>> There is a possible scenario where client driver is calling
>> slimbus stream APIs in incorrect sequence and it might lead to
>> invalid null access of the stream pointer in slimbus
>> enable/disable/prepare/unprepare/free function.
>>
>> Fix this by checking validity of the stream before accessing in
>> all function API’s exposed to client.
>>
>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
>> ---
>>   drivers/slimbus/stream.c | 37 +++++++++++++++++++++++++++++++++----
>>   1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
>> index 1d6b38657917..c5a436fd0952 100644
>> --- a/drivers/slimbus/stream.c
>> +++ b/drivers/slimbus/stream.c
>> @@ -202,10 +202,16 @@ static int slim_get_prate_code(int rate)
>>   int slim_stream_prepare(struct slim_stream_runtime *rt,
>>               struct slim_stream_config *cfg)
>>   {
>> -    struct slim_controller *ctrl = rt->dev->ctrl;
>> +    struct slim_controller *ctrl;
>>       struct slim_port *port;
>>       int num_ports, i, port_id, prrate;
>> +    if (!rt || !cfg) {
>> +        pr_err("%s: Stream or cfg is NULL, Check from client side\n", 
>> __func__);
> 
> Please use dev_err where possible
> 
> 
> --srini


For error scenario, we don't have valid dev to be used in dev_err 
argument. this log will help for debug.
Please let us know if any concern with pr_err.


>> +        return -EINVAL;
>> +    }
>> +
>> +    ctrl = rt->dev->ctrl;
>>       if (rt->ports) {
>>           dev_err(&rt->dev->dev, "Stream already Prepared\n");
>>           return -EINVAL;
>> @@ -358,9 +364,15 @@ int slim_stream_enable(struct slim_stream_runtime 
>> *stream)
>>   {
>>       DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
>>                   3, SLIM_LA_MANAGER, NULL);
>> -    struct slim_controller *ctrl = stream->dev->ctrl;
>> +    struct slim_controller *ctrl;
>>       int ret, i;
>> +    if (!stream) {
>> +        pr_err("%s: Stream is NULL, Check from client side\n", 
>> __func__);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ctrl = stream->dev->ctrl;
>>       if (ctrl->enable_stream) {
>>           ret = ctrl->enable_stream(stream);
>>           if (ret)
>> @@ -411,12 +423,18 @@ int slim_stream_disable(struct 
>> slim_stream_runtime *stream)
>>   {
>>       DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
>>                   3, SLIM_LA_MANAGER, NULL);
>> -    struct slim_controller *ctrl = stream->dev->ctrl;
>> +    struct slim_controller *ctrl;
>>       int ret, i;
>> +    if (!stream) {
>> +        pr_err("%s: Stream is NULL, Check from client side\n", 
>> __func__);
>> +        return -EINVAL;
>> +    }
>> +
>>       if (!stream->ports || !stream->num_ports)
>>           return -EINVAL;
>> +    ctrl = stream->dev->ctrl;
>>       if (ctrl->disable_stream)
>>           ctrl->disable_stream(stream);
>> @@ -448,6 +466,11 @@ int slim_stream_unprepare(struct 
>> slim_stream_runtime *stream)
>>   {
>>       int i;
>> +    if (!stream) {
>> +        pr_err("%s: Stream is NULL, Check from client side\n", 
>> __func__);
>> +        return -EINVAL;
>> +    }
>> +
>>       if (!stream->ports || !stream->num_ports)
>>           return -EINVAL;
>> @@ -476,8 +499,14 @@ EXPORT_SYMBOL_GPL(slim_stream_unprepare);
>>    */
>>   int slim_stream_free(struct slim_stream_runtime *stream)
>>   {
>> -    struct slim_device *sdev = stream->dev;
>> +    struct slim_device *sdev;
>> +
>> +    if (!stream) {
>> +        pr_err("%s: Stream is NULL, Check from client side\n", 
>> __func__);
>> +        return -EINVAL;
>> +    }
>> +    sdev = stream->dev;
>>       spin_lock(&sdev->stream_list_lock);
>>       list_del(&stream->node);
>>       spin_unlock(&sdev->stream_list_lock);

