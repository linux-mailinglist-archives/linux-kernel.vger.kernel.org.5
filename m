Return-Path: <linux-kernel+bounces-123835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EA890EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FB1C258EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7531386DF;
	Thu, 28 Mar 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vmg487hU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB026293;
	Thu, 28 Mar 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669339; cv=none; b=GLcuP/8o1037WlI2GkmK7616N6WvDJIcv5My+AlC9z9II1wg5UHHX+52Xk8FzWKcKBfC/PgYIQRfCFGDWdoZvB7K8njC5FyG3O9nRT3wHjGZdpPmXvLaPj3EUnz8FtoN1ytlsH9BxwbkrZA0N5ZqKtqzRS73YsvBs6VqWtToqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669339; c=relaxed/simple;
	bh=9SjDpg3kIIQwlmHBii7c++p8d2jgsfij1d+HiASLf5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c/9fAVx+Axo1vB737Q6ajEhOBH+TUfU14YPgrFFsMqmvDb9d9c1bwuoNu4zWqHeILDHWyHcE+pesablDWeXDc55juMMetwiWmLfKIFJwBzlYkkUIJ3JuE7Wx46xGJo1M6CNJeT3jaPKJmk5j+t9Iljqxz1tLVWSFrLMAnkHVkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vmg487hU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKfHXL014988;
	Thu, 28 Mar 2024 23:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Mau55tBozhBMaO0d5Rfa7Yp5L1oCFg3acc+d9Opj8DI=; b=Vm
	g487hUoNyG6qRBbvOJYZ73Gnez818HIILu2cwVUELQ079aO+fK4JYNp5EKxKR8v4
	IUgnTzGR4xEsQ/mJKFEEmbF4WQDNtRFgjjxFRDtwcJMze8qJQIdf8ts8tdrhEyiD
	xBS2Vzg+Cl1TnMn0nUh3wuDPfaPrUN+Qewjao6nC4kUIytd0iqOtl6G00RUAL0UN
	xACEMT1cV4n0lbcTq/z5rpW9sk4tOGPub7iHtGCHNPxGyJVBX6ChTma3LleHEVw5
	/eY8IfbcMXTDt03iC92HZLroAZHvt7SQrwC5dv/LL+q2w5ovUwPElb0OE20t8iDh
	l7HzruaqUNAiRXihQPtw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x575m9tfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 23:42:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SNg36q011158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 23:42:03 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 16:41:59 -0700
Message-ID: <27cadd17-10a3-3b8c-2b29-6698ccdce531@quicinc.com>
Date: Thu, 28 Mar 2024 16:41:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drm/msm/dp: use dp_hpd_plug_handle() and
 dp_hpd_unplug_handle() directly
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>, <abel.vesa@linaro.org>,
        <agross@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dianders@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
 <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com>
 <CAE-0n503FwcwreZ14MMKgdzu8QybWYtMdLOKasiCwmE8pCJOSw@mail.gmail.com>
 <23de89e9-3ef3-c52d-7abf-93dc2dbb51a4@quicinc.com>
 <CAA8EJppEWXnsQzDD1tdNuMb1ijEVtE7LQct9jt1fwVwMd8ch_Q@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppEWXnsQzDD1tdNuMb1ijEVtE7LQct9jt1fwVwMd8ch_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JhyyTv2RyiL88vdIZHPTeOstcC7Jsia1
X-Proofpoint-GUID: JhyyTv2RyiL88vdIZHPTeOstcC7Jsia1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_18,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280172



On 3/28/2024 3:50 PM, Dmitry Baryshkov wrote:
> On Thu, 28 Mar 2024 at 23:21, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 3/28/2024 1:58 PM, Stephen Boyd wrote:
>>> Quoting Abhinav Kumar (2024-03-28 13:24:34)
>>>> + Johan and Bjorn for FYI
>>>>
>>>> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
>>>>> For internal HPD case, hpd_event_thread is created to handle HPD
>>>>> interrupts generated by HPD block of DP controller. It converts
>>>>> HPD interrupts into events and executed them under hpd_event_thread
>>>>> context. For external HPD case, HPD events is delivered by way of
>>>>> dp_bridge_hpd_notify() under thread context. Since they are executed
>>>>> under thread context already, there is no reason to hand over those
>>>>> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
>>>>> dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
>>>>>
>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>> ---
>>>>>     drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
>>>
>>> Is this a bug fix or an optimization? The commit text doesn't tell me.
>>>
>>
>> I would say both.
>>
>> optimization as it avoids the need to go through the hpd_event thread
>> processing.
>>
>> bug fix because once you go through the hpd event thread processing it
>> exposes and often breaks the already fragile hpd handling state machine
>> which can be avoided in this case.
> 
> Please add a description for the particular issue that was observed
> and how it is fixed by the patch.
> 
> Otherwise consider there to be an implicit NAK for all HPD-related
> patches unless it is a series that moves link training to the enable
> path and drops the HPD state machine completely.
> 
> I really mean it. We should stop beating a dead horse unless there is
> a grave bug that must be fixed.
> 

I think the commit message is explaining the issue well enough.

This was not fixing any issue we saw to explain you the exact scenario 
of things which happened but this is just from code walkthrough.

Like kuogee wrote, hpd event thread was there so handle events coming 
out of the hpd_isr for internal hpd cases. For the hpd_notify coming 
from pmic_glink or any other extnernal hpd cases, there is no need to 
put this through the hpd event thread because this will only make things 
worse of exposing the race conditions of the state machine.

Moving link training to enable and removal of hpd event thread will be 
worked on but delaying obvious things we can fix does not make sense.

>>
>>>>
>>>> Looks right to me,
>>>>
>>>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> 
> 

