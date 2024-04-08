Return-Path: <linux-kernel+bounces-135938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6389CD8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BB11F23A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21321487CE;
	Mon,  8 Apr 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nEgWtIEP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596C495CB;
	Mon,  8 Apr 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611427; cv=none; b=jIKMQEhKKJl7tRJx3OafGPKslOJr9LGgKxhwpbQZTCrU1AR8Mm5io205d90gV8yDIV6mt42BPF8KtwazjU6AVyZ3XefXfeXkG8FE5pJR1k0C8HDnNbYm+mdWZ7jII7shKXk7jIG29zNL/4HI0px5vo8TAEgtFKcXvu1auQNJIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611427; c=relaxed/simple;
	bh=lTcY1BGvyp+f9cnlJMnCikKqaBw7Y9GaPghtI7Sf0GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RIiqHXFzGxBs9TsxZB9Otokb8qnfB0nQ1N3iOSZbfQr3uk2hgPSiVGfLoo8xTlRR3UBQas3uqVUQXVMQ5EfbZMyZ3Vw0YzHsQctEbXUYh3FpMHeQNYv6BmTJBfmDBlvANTY1Oi/Ov9vfwLfBrT+lblWaP8km9k8E6wHzzxYR3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nEgWtIEP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438KhqgH008534;
	Mon, 8 Apr 2024 21:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W8p0/s1UgB3N8CYG7Fp+xe/u8df/dP5sgIH3czhokHc=; b=nE
	gWtIEPH2RTi0H5RcaLb38CvFJSxe4hGp9vDcFSl3hW6ybKbh903OyyILClpIHlO0
	XdLyvJsLiRsVZy0q+J/FSw1guP0i89mugyIOQnCgPq/zep7s20aPKjlB/dXRXcY3
	Zc2Q2rT1iBhAxZUsxhoKdi1B1NsY1rQ2lyPikduUCSZBuLg8gzHhlY6Lk6gj+6Pk
	qPh+Kkdo6wfCTPAKYm7LenIc9VKXbP0FUYz8jVvKsGkFWDgk9RSFjvwTf1QSueq2
	No1Dlg4aY6liyWhNZ1a5Z1IZOTOG0njRKEQHvS0peY2mAPlz4QAf2jsQTYCSUlwX
	oU/kabNcXkZmu9Fw7dyw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg01vnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 21:23:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438LNZLX031220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 21:23:35 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 14:23:33 -0700
Message-ID: <905222ad-612a-3eaf-d966-23c89c99e1f0@quicinc.com>
Date: Mon, 8 Apr 2024 14:23:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, <freedreno@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <quic_jesszhan@quicinc.com>,
        <quic_bjorande@quicinc.com>, <johan@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
 <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com>
 <CAA8EJprzH0LiWNx9Udt6og3G063odY6ccvaAgsNS1r3zG8TmdA@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJprzH0LiWNx9Udt6og3G063odY6ccvaAgsNS1r3zG8TmdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pU5XtUu0P-MOXzfD0nHXKiswY9p_So5N
X-Proofpoint-ORIG-GUID: pU5XtUu0P-MOXzfD0nHXKiswY9p_So5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080163



On 4/8/2024 2:12 PM, Dmitry Baryshkov wrote:
> On Mon, 8 Apr 2024 at 22:43, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
>>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
>>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> [..]
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index d80f89581760..bfb6dfff27e8 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>>>               return;
>>>>
>>>>       if (!dp_display->link_ready && status == connector_status_connected)
>>>> -            dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>>>> +            dp_hpd_plug_handle(dp, 0);
>>>
>>> If I read the code correctly, and we get an external connect event
>>> inbetween a previous disconnect and the related disable call, this
>>> should result in a PLUG_INT being injected into the queue still.
>>>
>>> Will that not cause the same problem?
>>>
>>> Regards,
>>> Bjorn
>>>
>>
>> Yes, your observation is correct and I had asked the same question to
>> kuogee before taking over this change and posting.
> 
> Should it then have the Co-developed-by trailers?
> 

hmmm, perhaps but that didnt result in any code change between v2 and 
v3, so I didnt add it.

>> We will have to handle that case separately. I don't have a good
>> solution yet for it without requiring further rework or we drop the
>> below snippet.
>>
>>           if (state == ST_DISCONNECT_PENDING) {
>>                   /* wait until ST_DISCONNECTED */
>>                   dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
>>                   mutex_unlock(&dp->event_mutex);
>>                   return 0;
>>           }
>>
>> I will need sometime to address that use-case as I need to see if we can
>> handle that better and then drop the the DISCONNECT_PENDING state to
>> address this fully. But it needs more testing.
>>
>> But, we will need this patch anyway because without this we will not be
>> able to fix even the most regular and commonly seen case of basic
>> connect/disconnect receiving complementary events.
> 
> Hmm, no. We need to drop the HPD state machine, not to patch it. Once
> the driver has proper detect() callback, there will be no
> complementary events. That is a proper way to fix the code, not these
> kinds of band-aids patches.
> 

I had discussed this part too :)

I totally agree we should fix .detect()'s behavior to just match cable 
connect/disconnect and not link_ready status.

But that alone would not have fixed this issue. If HPD thread does not 
get scheduled and plug_handle() was not executed, .detect() would have 
still returned old status as we will update the cable status only in 
plug_handle() / unplug_handle() to have a common API between internal 
and external hpd execution.

So we need to do both, make .detect() return correct status AND drop hpd 
event thread processing.

But, dropping the hpd event thread processing alone was fixing the 
complimentary events issue. So kuogee had only this part in this patch.


>>>>       else if (dp_display->link_ready && status == connector_status_disconnected)
>>>> -            dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>>>> +            dp_hpd_unplug_handle(dp, 0);
>>>>    }
>>>> --
>>>> 2.43.2
>>>>
> 
> 
> 

