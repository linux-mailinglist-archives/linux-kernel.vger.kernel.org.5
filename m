Return-Path: <linux-kernel+bounces-124062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0408911B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F35F1C22B18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1D31A85;
	Fri, 29 Mar 2024 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JgtRMcCH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989E2DF7D;
	Fri, 29 Mar 2024 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711679888; cv=none; b=LD1q/1LcfjEBZ6bw7Z4t22PgS4F/GKr3P3vZPFfqD3HnFdB87Gvuc5isJG4Lq3gik/4UdD+a5O4Fy7d7iIMTJJEqmynRXQYpVoh5yec60ZV6XGcLzERPXniIS8CdhtTaA3TDjIBWq2jBm/g/GFvRt8jT/KVE4Ltprc7hD/7rw+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711679888; c=relaxed/simple;
	bh=lvUn0Rt1L8GduKweGKMduCHqPlOdlNDE1cQtCBoduns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oqmckQF37QH6EWdGPtP59QXP5HZVgHPihakGaVQmt01m39XsAqw9PG7O/kdkruHQ3OZzAI3jTw2/Nu1gjfpa8MLLSD3Jq/8Vp0lalWuUWPt7NtXvfx8Bl9gxnbIJBQcSoTSqz3aJg7t5+gNH/E9ETB2v+OXCHihOoRRbsi/QC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JgtRMcCH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T011a7014147;
	Fri, 29 Mar 2024 02:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iKisYioMzEBw7Rwi9M/qvtiGP/9dquh4W1P2njpTQLs=; b=Jg
	tRMcCHE+NXcFdcrYUowoEq8Q/kVfiPMphig3SeJkqWWt5LKxIlJ/9mBiBBs3GbDm
	pMFlDv39NejJQMztfLr9L9dtDFN9Qgys6XJgvuoFI/hK94cAGBZe4dC9x03F7SXM
	7pQRDSTzMvYUps9uDM7AjtynzaAJ5r+xFAfntUhd8xU6N8n8srbNmu0h+KBNwt5X
	PzM8oPVzG8kfVvh4oc908VqzvtI29Y2l7cQ4zhEHAFavVWMwajnR/A1h1TMISNZK
	y83TztW/85D+lbwVJlPXOdLpqVcfj5E5mgMWlUsoQzsbw/BFDzvDY9j7eJo9/qy6
	Xx5+Zp3w+rvHM02HMUSg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aeg9hdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 02:37:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T2brZO030242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 02:37:53 GMT
Received: from [10.110.118.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 19:37:44 -0700
Message-ID: <3bb6722c-5186-6d25-a4a2-c1ef92977dac@quicinc.com>
Date: Thu, 28 Mar 2024 19:37:42 -0700
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
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>, <abel.vesa@linaro.org>,
        <agross@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dianders@chromium.org>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
 <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com>
 <CAE-0n503FwcwreZ14MMKgdzu8QybWYtMdLOKasiCwmE8pCJOSw@mail.gmail.com>
 <23de89e9-3ef3-c52d-7abf-93dc2dbb51a4@quicinc.com>
 <20240329014659.GA3478031@hu-bjorande-lv.qualcomm.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240329014659.GA3478031@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QpIVvtzj8E2DmWjqFm2Yz6BEgVmeMtSk
X-Proofpoint-GUID: QpIVvtzj8E2DmWjqFm2Yz6BEgVmeMtSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290020



On 3/28/2024 6:46 PM, Bjorn Andersson wrote:
> On Thu, Mar 28, 2024 at 02:21:14PM -0700, Abhinav Kumar wrote:
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
>>
> 
> It removes the main users of the thread, but there's still code paths
> which will post events on the thread.
> 
> I think I like the direction this is taking, but does it really fix the
> whole problem, or just patch one case?
> 

So kuogee's idea behind this that NON-hpd_isr events need not go through 
event thread at all.

We did not run into any special scenario or issue without this. It was a 
code walkthrough fix.

> 
> PS. Please read go/upstream and switch to b4, to avoid some practical
> issues with the way you posted this patch.
> 
> Thanks,
> Bjorn
> 

Just to elaborate the practical issues so that developers know what you 
encountered:

-> no need of v1 on the PATCH
-> somehow this patch was linked "in-reply-to" another patch 
https://lore.kernel.org/all/1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com/ 
 This is quite strange and not sure how it happened. But will double 
check if we did something wrong here.

Thanks for sharing these.


>>>>
>>>> Looks right to me,
>>>>
>>>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

