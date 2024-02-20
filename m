Return-Path: <linux-kernel+bounces-73770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D285CADB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDC11F228F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FA154425;
	Tue, 20 Feb 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4bN5/3K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0628DBD;
	Tue, 20 Feb 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468842; cv=none; b=LI+GCSBE4dnXmoYG7czDMlDoFtcBeesWmtQ8Br4AzBKnnsOe61xSZWbMFQYWKZBZBnkVGE+yxxrCGd1q+UPFWuY1cBcZjhbZqEdzlv2+23nUyQh0MpJLEerazh+SbyMDaxGe9SSEa6BolJ/tFRTdS7v8xLiNioFllHUHtgwRMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468842; c=relaxed/simple;
	bh=X1ODGiav0Vne3qV9C0n6t3FDPsqqP9idzZxGgMBXT2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qw2PbQQqgbaCSF/2tS1GzI9BpnMitlSuCvheasvXk+TFCWD/vI6udEL785pis4uwheugH3axU2FMUCCWhAMd4304WdhhD47hlJOcpqc6xji+HGHLvA28X3NkHREZjWCqUwwxyU6Li5OciQEGwjCVkzqOLSKefP3o31YeHI0I1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B4bN5/3K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KMaWOp006858;
	Tue, 20 Feb 2024 22:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DzgSSjiF7MER59HcHRdD0KQPa4VTP7amKqzcZKrkGcE=; b=B4
	bN5/3Ko+uKUY4iWdMcs0gjISPVK33vQAAyVl7udYyUZzp/oaDv3EQ+r9T48eAaGZ
	a7t5tlBuFBu5KQSRVX1wRZtEi3ETcOvRysP61X4LpxfiFu26exKMcWg+QX8CqMey
	kcQ4XbRQjTAuSa8+VYUaZXZuquHEi8/2oDG1Y8u75alp99YbD/VDBwYhMdXebB7m
	zhXZvcERFTaCgy+RrvuQDTOno4QekBMgThIaB/Ow8k+NkaYZQ5PFKhpWUy8YVQAw
	/fT24ofbN3cdTnzmwdJlta+NYClIKa0j+NonYSBLqfhuBx1aRq6HPq7KN2NlKsX4
	RM2VsRnfG0+/U/A824PA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21s8cd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 22:40:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KMeVAd007363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 22:40:31 GMT
Received: from [10.110.62.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 14:40:31 -0800
Message-ID: <69d152d2-6a25-9ff4-ce6b-c4790247a661@quicinc.com>
Date: Tue, 20 Feb 2024 14:40:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
 <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com>
 <CAA8EJpotiHKT_NYphDs0-vhpvsybgTW281XDYbteUx8qOX=v4g@mail.gmail.com>
 <63bba15b-6d8d-5ba8-d99d-8cd2dd763262@quicinc.com>
 <CAA8EJpqHmVBry9FyJ6HRB+qdVcVNN3Q7rHZz1daZL1Sz6yeZ=A@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpqHmVBry9FyJ6HRB+qdVcVNN3Q7rHZz1daZL1Sz6yeZ=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t9crU5pOJDLNHXaEgNhV7Rf5up6tcKsS
X-Proofpoint-GUID: t9crU5pOJDLNHXaEgNhV7Rf5up6tcKsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=910 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402200163



On 2/19/2024 3:52 AM, Dmitry Baryshkov wrote:
> On Wed, 14 Feb 2024 at 22:36, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 2/14/2024 11:20 AM, Dmitry Baryshkov wrote:
>>> On Wed, 14 Feb 2024 at 20:02, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/8/2024 6:50 AM, Dmitry Baryshkov wrote:
>>>>> We have several reports of vblank timeout messages. However after some
>>>>> debugging it was found that there might be different causes to that.
>>>>> To allow us to identify the DPU block that gets stuck, include the
>>>>> actual CTL_FLUSH value into the timeout message and trigger the devcore
>>>>> snapshot capture.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Added a call to msm_disp_snapshot_state() to trigger devcore dump
>>>>>      (Abhinav)
>>>>> - Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
>>>>> ---
>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>>> index d0f56c5c4cce..a8d6165b3c0a 100644
>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>>>> @@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
>>>>>                 (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
>>>>>                 msecs_to_jiffies(50));
>>>>>         if (ret <= 0) {
>>>>> -             DPU_ERROR("vblank timeout\n");
>>>>> +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
>>>>> +             msm_disp_snapshot_state(phys_enc->parent->dev);
>>>>
>>>>
>>>> There is no rate limiting in this piece of code unfortunately. So this
>>>> will flood the number of snapshots.
>>>
>>> Well... Yes and no. The devcoredump will destroy other snapshots if
>>> there is a pending one. So only the console will be flooded and only
>>> in case when MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE is enabled.
>>>
>>
>> Yes, true but at the same time this makes it hard to capture a good dump
>> as potentially every vblank you could timeout so this destroy/create
>> cycle wont end.
> 
> Excuse me, maybe I miss something. On the first timeout the snapshot
> is created. It is held by the kernel until it is fully read out from
> the userspace. Other snapshots will not interfere with this snapshot.
> 

For every new snapshot a new devcoredump device will be created which 
should remain till it has been read. But now this will be created every 
blank. IMO, this is really too much data for no reason.

Subsequent vblank timeouts are not going to give any new information 
compared to the existing snapshot of the first vblank timeout thats why 
we should just create the snapshot when the first error happens and stop.

For other frame done timeouts, infact subsequent timeouts without any 
sort of recovery in between are quite misleading because hardware was 
already not able to fetch the previous frame so it will most likely not 
fetch the next one either till it has recovered. Typically thats why 
these vblank timeouts happen in a flurry as the hardware never really 
recovered from the first timeout.

> Or are you worried that snapshotting takes time, so taking a snapshot
> will also interfere with the vblank timings for the next vblank?
> 

Yes this is another point.

