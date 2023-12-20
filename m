Return-Path: <linux-kernel+bounces-6566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A099819A69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6828432E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867241BDE3;
	Wed, 20 Dec 2023 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fwXtfJ8U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233F1DDD2;
	Wed, 20 Dec 2023 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5rZca016735;
	Wed, 20 Dec 2023 08:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Pdm6PTLkR+mB79HpuwHCRfVI5bOMcx6Rg7Rr4q94EQk=; b=fw
	XtfJ8U1brySURW7r7HKbR1GrqJF69lKc+fQxkgXRLzHKV0TWqQSbmFfr9FlOGHrp
	OuULTvFlV0M4T5QYfpSY5+VbDsTysOmFg3myhu9r2M6pxjDtV29bkXDuuJGqPm0k
	cnhi/Cnc95+e7u4lfbvlYiGa2QUH1HNb7jMvX2Amph4PKyAG624Tdo4yWAMbyWfe
	2Aps4/yrWEtcjoJV1/1a9cIVZj3O+MiUjRNubaQQH3j6reGjgehaNW8g3WGDer0a
	nh2ULuVNb8ZmfZhKDwk+BOYYZ3+vFUpDRmmG4ifCs/T1Fbn168LW/huCm+ESrWww
	G2IwRC/p+JcI01dXG4LQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3r6rrk6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:26:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8Q5Fj019322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:26:05 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:26:00 -0800
Message-ID: <362360be-6b21-5f13-6107-ca05419cd5f2@quicinc.com>
Date: Wed, 20 Dec 2023 13:55:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 27/34] media: iris: implement vb2 ops for buf_queue and
 firmware response
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-28-git-send-email-quic_dikshita@quicinc.com>
 <10f7180f-0241-4b69-b331-9d82da15e0c5@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <10f7180f-0241-4b69-b331-9d82da15e0c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kanpfhsZLVBU-7O7wsbhQV1XyAXXR1Rs
X-Proofpoint-GUID: kanpfhsZLVBU-7O7wsbhQV1XyAXXR1Rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=728 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200057



On 12/19/2023 5:51 PM, Konrad Dybcio wrote:
> On 18.12.2023 12:32, Dikshita Agarwal wrote:
>> Implement vb2 ops for buf queue. Below are the different
>> buffer attributes:
>> BUF_ATTR_DEFERRED - buffer queued by client but not submitted
>> to firmware.
>> BUF_ATTR_READ_ONLY - processed buffer received from firmware
>> as read only. These buffers are held in firmware as reference
>> for future frame processing.
>> BUF_ATTR_PENDING_RELEASE - buffers requested to be released
>> from firmware.
>> BUF_ATTR_QUEUED - buffers submitted to firmware.
>> BUF_ATTR_DEQUEUED - buffers received from firmware.
>> BUF_ATTR_BUFFER_DONE - buffers sent back to vb2.
>>
>> Buffers are submitted and received via HFI_CMD_BUFFER.
>> Firmware associates below flags during buffer response:
>> HFI_BUF_FW_FLAG_RELEASE_DONE - buffer released in firmware.
>> HFI_BUF_FW_FLAG_READONLY - buffer used as reference in firmware.
>>
>> Input buffers dequeued from firmware are sent directly to vb2.
>>
>> Output buffers if read only, are sent to vb2 and also maintained
>> in read only list. If the same read only buffer is received form
>> client, HFI_BUF_HOST_FLAG_READONLY is attached to the buffer and
>> submitted to firmware. Once the buffer is received from firmware
>> as non read only, it is removed from read only list.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>>  
>> +enum iris_buffer_flags {
>> +	BUF_FLAG_KEYFRAME	= 0x00000008,
>> +	BUF_FLAG_PFRAME		= 0x00000010,
>> +	BUF_FLAG_BFRAME		= 0x00000020,
>> +	BUF_FLAG_ERROR		= 0x00000040,
> BIT(3), 4, 5, 6?
Sure, will update.
> 
> Konrad
> 

