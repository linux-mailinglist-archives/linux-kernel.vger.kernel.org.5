Return-Path: <linux-kernel+bounces-124172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CA891360
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7B328934E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA023CF4F;
	Fri, 29 Mar 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DjcgK4RJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC73BBF9;
	Fri, 29 Mar 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691277; cv=none; b=qgY1Zqyjyyg49iK+0uEV0mbWfG5p7N+LjpRtpr0Sk9HKxQfUWSLt7LlBGgnXtditYCzwQnmpCrMP0ZH/qJn1UM+LN+KWzY54bEALLX2BGFg6zQP5qkY34GwSCTZ8NC31a/ScFJdRbchyj7agVDc6FWLODdaVF+vkzYqTLnHqP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691277; c=relaxed/simple;
	bh=/W6V/6W7a8Ya1Je5R4mNo3HExZjqF8UzVQn9VCL1T7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KKH90CVROaUlp8odONoebjLUSdILhJ/37wChmpFN2uRaLpYvflJ+W3LZGpCvdNS9ZXV1tFhYL8oyY1Z+ISVAdYKqOTkmYBoT39SjNiUjIw8YQZDV1hkpk70bvTw8rmivfGFToKvHUSDM1J06Aw82dNK4R+t1Us/yo00O7zCRPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DjcgK4RJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T56ewT026747;
	Fri, 29 Mar 2024 05:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qHMK2c3Hat02bYLCr9tXHxXfHvMIl+7AKGE5P3Sc4w4=; b=Dj
	cgK4RJepikXMTRPmQ+WwxPsgyYMXlUzZZdP8u7rWXLqr4iarbLQ/QF130l3adHNl
	MuwNl/3ypMWNjc6KsZkIJcW5bpoXGjldXf/5N7eCtLaAOEumcWSlpbLPxcVR5IXU
	LzHJHaGAuIKg4OGKRmHDZLHETD+4/21g3wnOH4WXuY/QWxuWPWP1gLIlv6doTXkV
	076Q3GVDOB+OI5cJhTCVILriefRz/xH3zi/M29BElomm/yty3RLS9y4H4FeQwoWm
	EkY0pWXDk3uHjbeUKRKEwgt1h4hZWJ/He3pOaZXc+w546m+ml6gO/VcIp4L4xTdD
	/UFBkA1c+ji/r0rP6ziw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aeg9vg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:47:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T5lBpC029367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 05:47:11 GMT
Received: from [10.110.118.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 22:47:05 -0700
Message-ID: <17489ead-2765-7ed1-f4da-4a45e7d83b1b@quicinc.com>
Date: Thu, 28 Mar 2024 22:47:03 -0700
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
 <27cadd17-10a3-3b8c-2b29-6698ccdce531@quicinc.com>
 <CAA8EJpqYVDG9pBj39m40rPwUNgE7x07HfCt6C3yaMN7eOaWk6Q@mail.gmail.com>
 <efbe5aa8-8bbe-26cd-ca70-1974241a3537@quicinc.com>
 <CAA8EJprES3q3w6GuQ8dW5vicnzbO_eZ6wpNfWe5njTPRDZm5KQ@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJprES3q3w6GuQ8dW5vicnzbO_eZ6wpNfWe5njTPRDZm5KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S9XgzICDRkG1LDH9EqIXllzbQO6ZYBBG
X-Proofpoint-GUID: S9XgzICDRkG1LDH9EqIXllzbQO6ZYBBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_04,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290046



On 3/28/2024 8:23 PM, Dmitry Baryshkov wrote:
> On Fri, 29 Mar 2024 at 04:16, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 3/28/2024 5:10 PM, Dmitry Baryshkov wrote:
>>> On Fri, 29 Mar 2024 at 01:42, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/28/2024 3:50 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, 28 Mar 2024 at 23:21, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 3/28/2024 1:58 PM, Stephen Boyd wrote:
>>>>>>> Quoting Abhinav Kumar (2024-03-28 13:24:34)
>>>>>>>> + Johan and Bjorn for FYI
>>>>>>>>
>>>>>>>> On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
>>>>>>>>> For internal HPD case, hpd_event_thread is created to handle HPD
>>>>>>>>> interrupts generated by HPD block of DP controller. It converts
>>>>>>>>> HPD interrupts into events and executed them under hpd_event_thread
>>>>>>>>> context. For external HPD case, HPD events is delivered by way of
>>>>>>>>> dp_bridge_hpd_notify() under thread context. Since they are executed
>>>>>>>>> under thread context already, there is no reason to hand over those
>>>>>>>>> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
>>>>>>>>> dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>>>>>> ---
>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
>>>>>>>>>       1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")
>>>>>>>
>>>>>>> Is this a bug fix or an optimization? The commit text doesn't tell me.
>>>>>>>
>>>>>>
>>>>>> I would say both.
>>>>>>
>>>>>> optimization as it avoids the need to go through the hpd_event thread
>>>>>> processing.
>>>>>>
>>>>>> bug fix because once you go through the hpd event thread processing it
>>>>>> exposes and often breaks the already fragile hpd handling state machine
>>>>>> which can be avoided in this case.
>>>>>
>>>>> Please add a description for the particular issue that was observed
>>>>> and how it is fixed by the patch.
>>>>>
>>>>> Otherwise consider there to be an implicit NAK for all HPD-related
>>>>> patches unless it is a series that moves link training to the enable
>>>>> path and drops the HPD state machine completely.
>>>>>
>>>>> I really mean it. We should stop beating a dead horse unless there is
>>>>> a grave bug that must be fixed.
>>>>>
>>>>
>>>> I think the commit message is explaining the issue well enough.
>>>>
>>>> This was not fixing any issue we saw to explain you the exact scenario
>>>> of things which happened but this is just from code walkthrough.
>>>>
>>>> Like kuogee wrote, hpd event thread was there so handle events coming
>>>> out of the hpd_isr for internal hpd cases. For the hpd_notify coming
>>>> from pmic_glink or any other extnernal hpd cases, there is no need to
>>>> put this through the hpd event thread because this will only make things
>>>> worse of exposing the race conditions of the state machine.
>>>>
>>>> Moving link training to enable and removal of hpd event thread will be
>>>> worked on but delaying obvious things we can fix does not make sense.
>>>
>>>   From the commit message this feels like an optimisation rather than a
>>> fix. And granted the fragility of the HPD state machine, I'd prefer to
>>> stay away from optimisations. As far as I understood from the history
>>> of the last revert, we'd better make sure that HPD handling goes only
>>> through the HPD event thread.
>>>
>>
>> I think you are mixing the two. We tried to send the events through
>> DRM's hpd_notify which ended up in a bad way and btw, thats still not
>> resolved even though I have seen reports that things are fine with the
>> revert, we are consistently able to see us ending up in a disconnected
>> state with all the reverts and fixes in our x1e80100 DP setup.
>>
>> I plan to investigate that issue properly in the next week and try to
>> make some sense of it all.
>>
>> In fact, this patch is removing one more user of the hpd event thread
>> which is the direction in which we all want to head towards.
> 
> As I stated earlier, from my point of view it doesn't make sense to
> rework the HPD thread in small steps.
> 
>> On whether this is an optimization or a bug fix. I think by avoiding hpd
>> event thread (which should have never been used for hpd_notify updates,
>> hence a bug) we are avoiding the possibility of more race conditions.
> 
> I think that the HPD event thread serializes handling of events, so
> avoiding it increases the possibility of a race condition.
> 
>>
>> So, this has my R-b and it holds. Upto you.
> 
> I'd wait for a proper description of the issue that was observed and
> how it is solved by this patch.
> 

This was a code walkthrough fix as I wrote a few times. If there no 
merit in pushing this, lets ignore it and stop discussing.

