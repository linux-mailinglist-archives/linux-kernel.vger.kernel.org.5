Return-Path: <linux-kernel+bounces-133730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9B89A7D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22CA1F23B32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CA2CAB;
	Sat,  6 Apr 2024 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TpqP2OyL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681C620;
	Sat,  6 Apr 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361867; cv=none; b=dwEB0BnHUT9vtpqoZ42Pt44Bma+aD7gCHsh4ghwByENsYLBRenjAHdY6ZWtjkjvEZwNZFUZwtJ2Nrdvn2I48hh2xiW84EoaWLw6j3kXfa9/b849Y8aPy30pyTG4lgHnTISkNdxZx2vKm3EOEbewuYzIIVAliMJ5vQg4FFdSq0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361867; c=relaxed/simple;
	bh=OZSxqfje55f6AZuHKngt6qxnN4jEiwF1ve1FyfK5MS4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YRbuUcQS3Ik08O0qZpUPbUlVkO0DXsbB8QBYcpkIr05d85UfzZDuEoFbZy4vqeUNA+Qk5qAk6yml0Gquq9Unv2VATthYDz7fmgW2QBEgjvOlKBjSuPC3ME7JsMuKnbsekty5bvjBsCvbyefOCzrCJISurfEPyfWDwzawfxoJ57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TpqP2OyL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43603PLn029361;
	Sat, 6 Apr 2024 00:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n3fd1TvHrmS8REdQAHXxCVY08vIpmivPBdyqmYLuVNU=; b=Tp
	qP2OyLmf4s6fzYRYX7qAcxuPIJ8XPXVCWeh0AwbA7nV/lISX5TORkQc3hOQfW+Li
	nQMOpYu7bxabgiCqL5/I6sGhh5w0URwvBTw1moOcwQTf+ReCv9gzJoSCMj/Z/reJ
	1VDcwLvCByLbkyMoSt/9PKctUSUPZgSWIreQeWxw7vGqrXw2gVZyZZL5UjZaAn4r
	/kufmTEaoD6OJCBRuUr8Suzb4k4+b9wd6DEenU+8CJuAuy2lCXksRHpv40IWl/g8
	FIJqxe3aDnbyPlgV9IkownAfhnH53mzU9H+owbTlPdI20cJy7dcDiP/DPiLr9rQO
	Q2jEDaab4QM8nNyKr0WA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7snter1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Apr 2024 00:04:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4360466n023355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Apr 2024 00:04:06 GMT
Received: from [10.110.24.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 17:04:04 -0700
Message-ID: <176bad3e-4b67-f716-cd4f-f85bc66204f4@quicinc.com>
Date: Fri, 5 Apr 2024 17:04:03 -0700
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
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
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
 <27cadd17-10a3-3b8c-2b29-6698ccdce531@quicinc.com>
 <CAA8EJpqYVDG9pBj39m40rPwUNgE7x07HfCt6C3yaMN7eOaWk6Q@mail.gmail.com>
 <efbe5aa8-8bbe-26cd-ca70-1974241a3537@quicinc.com>
 <CAA8EJprES3q3w6GuQ8dW5vicnzbO_eZ6wpNfWe5njTPRDZm5KQ@mail.gmail.com>
 <17489ead-2765-7ed1-f4da-4a45e7d83b1b@quicinc.com>
In-Reply-To: <17489ead-2765-7ed1-f4da-4a45e7d83b1b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JhsB2FcBkn6Js2N3f__Ng_vZ8qDBx_pL
X-Proofpoint-ORIG-GUID: JhsB2FcBkn6Js2N3f__Ng_vZ8qDBx_pL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_29,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050173



On 3/28/2024 10:47 PM, Abhinav Kumar wrote:
> 
> 
> On 3/28/2024 8:23 PM, Dmitry Baryshkov wrote:
>> On Fri, 29 Mar 2024 at 04:16, Abhinav Kumar 
>> <quic_abhinavk@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 3/28/2024 5:10 PM, Dmitry Baryshkov wrote:
>>>> On Fri, 29 Mar 2024 at 01:42, Abhinav Kumar 
>>>> <quic_abhinavk@quicinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/28/2024 3:50 PM, Dmitry Baryshkov wrote:
>>>>>> On Thu, 28 Mar 2024 at 23:21, Abhinav Kumar 
>>>>>> <quic_abhinavk@quicinc.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 3/28/2024 1:58 PM, Stephen Boyd wrote:
>>>>>>>> Quoting Abhinav Kumar (2024-03-28 13:24:34)
>>>>>>>>> + Johan and Bjorn for FYI
>>>>>>>>>
>>>>>>>>> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
>>>>>>>>>> For internal HPD case, hpd_event_thread is created to handle HPD
>>>>>>>>>> interrupts generated by HPD block of DP controller. It converts
>>>>>>>>>> HPD interrupts into events and executed them under 
>>>>>>>>>> hpd_event_thread
>>>>>>>>>> context. For external HPD case, HPD events is delivered by way of
>>>>>>>>>> dp_bridge_hpd_notify() under thread context. Since they are 
>>>>>>>>>> executed
>>>>>>>>>> under thread context already, there is no reason to hand over 
>>>>>>>>>> those
>>>>>>>>>> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
>>>>>>>>>> dp_hpd_unplug_hanlde() are called directly at 
>>>>>>>>>> dp_bridge_hpd_notify().
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
>>>>>>>>>>       1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
>>>>>>>>
>>>>>>>> Is this a bug fix or an optimization? The commit text doesn't 
>>>>>>>> tell me.
>>>>>>>>
>>>>>>>
>>>>>>> I would say both.
>>>>>>>
>>>>>>> optimization as it avoids the need to go through the hpd_event 
>>>>>>> thread
>>>>>>> processing.
>>>>>>>
>>>>>>> bug fix because once you go through the hpd event thread 
>>>>>>> processing it
>>>>>>> exposes and often breaks the already fragile hpd handling state 
>>>>>>> machine
>>>>>>> which can be avoided in this case.
>>>>>>
>>>>>> Please add a description for the particular issue that was observed
>>>>>> and how it is fixed by the patch.
>>>>>>
>>>>>> Otherwise consider there to be an implicit NAK for all HPD-related
>>>>>> patches unless it is a series that moves link training to the enable
>>>>>> path and drops the HPD state machine completely.
>>>>>>
>>>>>> I really mean it. We should stop beating a dead horse unless there is
>>>>>> a grave bug that must be fixed.
>>>>>>
>>>>>
>>>>> I think the commit message is explaining the issue well enough.
>>>>>
>>>>> This was not fixing any issue we saw to explain you the exact scenario
>>>>> of things which happened but this is just from code walkthrough.
>>>>>
>>>>> Like kuogee wrote, hpd event thread was there so handle events coming
>>>>> out of the hpd_isr for internal hpd cases. For the hpd_notify coming
>>>>> from pmic_glink or any other extnernal hpd cases, there is no need to
>>>>> put this through the hpd event thread because this will only make 
>>>>> things
>>>>> worse of exposing the race conditions of the state machine.
>>>>>
>>>>> Moving link training to enable and removal of hpd event thread will be
>>>>> worked on but delaying obvious things we can fix does not make sense.
>>>>
>>>>   From the commit message this feels like an optimisation rather than a
>>>> fix. And granted the fragility of the HPD state machine, I'd prefer to
>>>> stay away from optimisations. As far as I understood from the history
>>>> of the last revert, we'd better make sure that HPD handling goes only
>>>> through the HPD event thread.
>>>>
>>>
>>> I think you are mixing the two. We tried to send the events through
>>> DRM's hpd_notify which ended up in a bad way and btw, thats still not
>>> resolved even though I have seen reports that things are fine with the
>>> revert, we are consistently able to see us ending up in a disconnected
>>> state with all the reverts and fixes in our x1e80100 DP setup.
>>>
>>> I plan to investigate that issue properly in the next week and try to
>>> make some sense of it all.
>>>
>>> In fact, this patch is removing one more user of the hpd event thread
>>> which is the direction in which we all want to head towards.
>>
>> As I stated earlier, from my point of view it doesn't make sense to
>> rework the HPD thread in small steps.
>>
>>> On whether this is an optimization or a bug fix. I think by avoiding hpd
>>> event thread (which should have never been used for hpd_notify updates,
>>> hence a bug) we are avoiding the possibility of more race conditions.
>>
>> I think that the HPD event thread serializes handling of events, so
>> avoiding it increases the possibility of a race condition.
>>
>>>
>>> So, this has my R-b and it holds. Upto you.
>>
>> I'd wait for a proper description of the issue that was observed and
>> how it is solved by this patch.
>>
> 
> This was a code walkthrough fix as I wrote a few times. If there no 
> merit in pushing this, lets ignore it and stop discussing.
> 

Ok, so after we debugged the HPD issue on we have found the issue and 
why actually this change will help. I am going to post a V2 with more 
details on the commit text. We can discuss after that.

