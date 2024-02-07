Return-Path: <linux-kernel+bounces-56121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0984C646
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A45B1C24479
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1227A20332;
	Wed,  7 Feb 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZyhDWjW8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47881EB5B;
	Wed,  7 Feb 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294637; cv=none; b=AGrVX8jdrfEuB880NBPO5IkjiM71f4tMo5O3gApekqY5xrF7/p3QnIhxSFBrBQB5c4ObBmJLLnkSv/D8DpBAG10z9cGQd1x33LArr4lLq8UVC8x7/5Xf47oyx9nTR2tlznkMoXPdClorw5Ls413EHOAwsuMRTPW67W6cwBAFU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294637; c=relaxed/simple;
	bh=id1DjRscb4/jlntXspei7C3IckLcjFLyNvjEV43XLcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M+vw3ugwvO/nw8fUAIWtEiFpHUdJCvmK+xUcrrOTsWyz15e1AeRj3BCK+6IS+H/OWT2ok4Prbc2+QaGr/hrnSYtrtI7zRSCaHu7dMHa57FcZwAEZ3ZFGcJQNQqsEAme0BH6+cDbUZ3R+vavV/bRzKH7isNbiU2Xto5jUo/mhz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZyhDWjW8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41759K6f011061;
	Wed, 7 Feb 2024 08:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dqIcPPZIgrc1WSIFR+UP/slzsTkIyO9TmwcdlUuGQsE=; b=Zy
	hDWjW8qV5jtRl0+fvAsystokq52RQzDM5WbtZdPtrxFErCZDNS3oFYK+TeGubYOx
	Yfv43NNKAJNhqxCIcq0ZSs5QULolq884VwIYpADEb3pWZEhlVc9Hq+vxHhzed/so
	WPhMysOLCiidt5FQ/1aEsMp1b0tD3k8e/Sv+ax9Oo78CgUNvlBKFaFtURao70L33
	SNEH6Hz4lZA14eodFFmVDA1ru0QTkiBr7/zK0F9VSe2ncTQRSyKS1239UFwe47Lr
	3774rWXaw7mL+8URtgy6sOxMAvZl6K5H/gMJE02XEafJM4OvCR3PK6ONCbCOVQol
	upE+vRS68VK46LvYDbMQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4021rpv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 08:30:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4178UQf0022713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 08:30:26 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 00:30:24 -0800
Message-ID: <41703424-f711-420e-bcb8-290f68a0aec9@quicinc.com>
Date: Wed, 7 Feb 2024 14:00:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/16] Add missing features to FastRPC driver
To: <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
 <d8e32f3d-1658-4dcd-a1dd-e37b664986ae@linaro.org>
Content-Language: en-US
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <d8e32f3d-1658-4dcd-a1dd-e37b664986ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NEOLLBZ5qixHwlE8rJwfZ19He1FsBCua
X-Proofpoint-GUID: NEOLLBZ5qixHwlE8rJwfZ19He1FsBCua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxlogscore=639 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070062


On 2/2/2024 1:41 PM, neil.armstrong@linaro.org wrote:
> Hi,
>
> On 02/02/2024 07:40, Ekansh Gupta wrote:
>> This patch series adds the listed features that have been missing
>> in upstream fastRPC driver.
>>
>> - Redesign and improve remote heap management.
>> - Add static PD restart support for audio and sensors PD using
>>    PDR framework.
>> - Add changes to support multimode invocation ioctl request. This
>>    ioctl call facilitates multiple types of requests from user including
>>    CRC check, performance counters, shared context bank usage, etc.
>>    This series also carries patch to save and restore interrupted
>>    context.
>> - Add early wakeup support to allow DSP user to send early response
>>    to CPU and improve fastrpc performance.
>> - Add polling mode support with which driver polls on memory to avoid
>>    CPU from going to low power modes.
>> - Add notifications frameworks to provide users with the DSP PD status
>>    notifications.
>> - Add a control mechanism to allow users to clean up DSP user PD
>> - Add wakelock management support
>> - Add DSP signalling support
>> - Add check for untrusted applications and allow trusted processed to
>>    offload to system unsigned PD.
>
> Could you precise:
> - Which workload are you fixing
> - Which platforms are concerned
> - Which platforms were tested
>
1. This patch mostly consists of missing features from fastrpc driver and it doesn't
carry any bug fixes.
2. We are not targeting these changes for any specific platform. These features are
applicable for most of the recent platforms .
3. These changes were tested on SM8650 and QCM6490 platforms.

> So far I've been trying to run the "getserial" on SM8550-QRD and 
> SM8650-QRD without
> success, would those changes fix this ?

Can you please help me with the "getserial" failure details? Or the steps that you are
running to get to the failure? I can have a look at that to understand the reason for
failure.

> Is there any chance we could get an open-source minimal implementation 
> of a fastRPC SDK using
> the open-source Hexagon LLVM like we have for the AIC100 ?
> It would definitely help validating the upstream fastRPC implementation.

Generally Hexagon SDK is used to write and test fastRPC use-cases which is well documented.
Is there anything else that you can suggest would help here?

>
> Thanks,
> Neil
>
Hi Neil, added my comments.

--ekansh

>>
>> Ekansh Gupta (16):
>>    misc: fastrpc: Redesign remote heap management
>>    misc: fastrpc: Add support for unsigned PD
>>    misc: fastrpc: Add static PD restart support
>>    misc: fastrpc: Add fastrpc multimode invoke request support
>>    misc: fastrpc: Add CRC support for remote buffers
>>    misc: fastrpc: Capture kernel and DSP performance counters
>>    misc: fastrpc: Add support to save and restore interrupted
>>    misc: fastrpc: Add support to allocate shared context bank
>>    misc: fastrpc: Add early wakeup support for fastRPC driver
>>    misc: fastrpc: Add polling mode support for fastRPC driver
>>    misc: fastrpc: Add DSP PD notification support
>>    misc: fastrpc: Add support for users to clean up DSP user PD
>>    misc: fastrpc: Add wakelock management support
>>    misc: fastrpc: Add DSP signal support
>>    misc: fastrpc: Restrict untrusted apk to spawn privileged PD
>>    misc: fastrpc: Add system unsigned PD support
>>
>>   drivers/misc/fastrpc.c      | 1949 +++++++++++++++++++++++++++++++----
>>   include/uapi/misc/fastrpc.h |  112 ++
>>   2 files changed, 1844 insertions(+), 217 deletions(-)
>>
>

