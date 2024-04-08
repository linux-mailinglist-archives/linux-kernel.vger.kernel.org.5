Return-Path: <linux-kernel+bounces-135935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD889CD55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625EB2819AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CC148820;
	Mon,  8 Apr 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G1Jdps14"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2D147C68;
	Mon,  8 Apr 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611067; cv=none; b=jFh1OXQGyAopF5pEFM7Id3Up9aEL4MDwjJM9/mGf8EKlhxdGsf6C9nMq5tSc0i5/g7qmbT0voKHZ85bsIAo3Ug2RxMFU0RlpZEXYKVj8Ies5L6J/DQYUw6lKq2ESO+BfdPVaFctC9J7L6yTS9wRdR7C8qq+Ucf/38Ykh59POZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611067; c=relaxed/simple;
	bh=9z40TDfJVhK+FHOW3HvQTwOokkHVPLh5OeDqIOTNKEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJdjfyfF9TJLzc/QITQlAEhDKv0VBuGcEhr5JfEyFtATWI3dGOKMWVcEa7OcOW29/gf2pTl+KCP/ucFWbgm/EE8DjPHNYo8B8n/MIILtCgKBFwP3qT6eRFugfrlPc7Pu9kUM9ahKLrMBwvDMhij1OLj3HQFVgoAOBLykg4NaLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G1Jdps14; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438L1FWd008356;
	Mon, 8 Apr 2024 21:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q+YRsfopvj2KlPUnw/diOdnNPYVvqUo7Z15cpWwbaRQ=; b=G1
	Jdps1487GcS3ZnTK6gdPWJGAh+xEVFP0RY8dBkR1HsFPZAYy4UJ84UPnlzmwQPHV
	3gUQn51o4c3Xfi3qGeibG9t8RTP0m9+6uPstNiXdFh2s0nbMIich8QWzLbrT9epu
	RH0wR3Aw+B6j+kfMDFrtXlqPEU+jHS0KXvXrIPn7XeZ+We7l+e+K1XMRiuMzFeea
	fhnl9J43Fy8Uxv9AQ3InSmHSQQvvNAABIdx3D7GfCvPAAaLk0h4iIrdcgoAUoPPN
	Yvs8q34X04Cf7lhl8hzM2AeuBg7KBZhqLQyeMHd1+CLjQzZw83iD2S8yvhvUr60v
	hr+IuSkV2s4M+KTqUFQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcr4hr0q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 21:17:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438LHWRB016931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 21:17:32 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 14:17:31 -0700
Message-ID: <d2442e2d-80fc-c580-3452-57fab0dabf3f@quicinc.com>
Date: Mon, 8 Apr 2024 14:17:29 -0700
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
 <k7f22hyltul4h4o4vqe6prc2yx3mm2q4dzk66j3xrsdpdtqllb@3c6ul4fpimwz>
 <b7ed299d-4cf7-8829-fd7f-e518aef05fb2@quicinc.com>
 <CAA8EJpqYWXs+KzZcrJA0zL2KNhpHQ+5xNpVNPmepztujmVJf=w@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpqYWXs+KzZcrJA0zL2KNhpHQ+5xNpVNPmepztujmVJf=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u2N2PQnvseMjgptqSOCNZO69VpW6_5Lc
X-Proofpoint-ORIG-GUID: u2N2PQnvseMjgptqSOCNZO69VpW6_5Lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080163



On 4/8/2024 2:13 PM, Dmitry Baryshkov wrote:
> On Tue, 9 Apr 2024 at 00:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 4/8/2024 1:41 PM, Bjorn Andersson wrote:
>>> On Mon, Apr 08, 2024 at 12:43:34PM -0700, Abhinav Kumar wrote:
>>>>
>>>>
>>>> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
>>>>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
>>>>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>>>> [..]
>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> index d80f89581760..bfb6dfff27e8 100644
>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>>>>>                     return;
>>>>>>             if (!dp_display->link_ready && status == connector_status_connected)
>>>>>> -          dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>>>>>> +          dp_hpd_plug_handle(dp, 0);
>>>>>
>>>>> If I read the code correctly, and we get an external connect event
>>>>> inbetween a previous disconnect and the related disable call, this
>>>>> should result in a PLUG_INT being injected into the queue still.
>>>>>
>>>>> Will that not cause the same problem?
>>>>>
>>>>> Regards,
>>>>> Bjorn
>>>>>
>>>>
>>>> Yes, your observation is correct and I had asked the same question to kuogee
>>>> before taking over this change and posting.
>>>>
>>>> We will have to handle that case separately. I don't have a good solution
>>>> yet for it without requiring further rework or we drop the below snippet.
>>>>
>>>>           if (state == ST_DISCONNECT_PENDING) {
>>>>                   /* wait until ST_DISCONNECTED */
>>>>                   dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
>>>>                   mutex_unlock(&dp->event_mutex);
>>>>                   return 0;
>>>>           }
>>>>
>>>> I will need sometime to address that use-case as I need to see if we can
>>>> handle that better and then drop the the DISCONNECT_PENDING state to address
>>>> this fully. But it needs more testing.
>>>>
>>>> But, we will need this patch anyway because without this we will not be able
>>>> to fix even the most regular and commonly seen case of basic
>>>> connect/disconnect receiving complementary events.
>>>>
>>>
>>> I did some more testing on this patch. Connecting and disconnecting the
>>> cable while in fbcon works reliably, except for:
>>
>> Thanks for the tests !
>>
>>> - edid/modes are not read before we bring up the link so I always end up
>>>     with 640x480
>>>
>>
>> hmmm, I wonder why this should be affected due to this patch. We always
>> read the EDID during hpd_connect() and the selected resolution will be
>> programmed with the modeset. We will retry this with our x1e80100 and see.
> 
> BTW, why is EDID read during HPD handling? I always supposed that it
> can be read much later, when the DRM framework calls the get_modes /
> get_edid callbacks.
> 

Well, dp_panel_read_sink_caps() is in dp_display_process_hpd_high() 
currently. We read the edid there.

get_modes(), parses the EDID and adds the modes using drm_add_edid_modes().

>>
>>> - if I run modetest -s <id>:<mode> the link is brought up with the new
>>>     resolution and I get my test image on the screen.
>>>     But as we're shutting down the link for the resolution chance I end up
>>>     in dp_bridge_hpd_notify() with link_ready && state = disconnected.
>>>     This triggers an unplug which hangs on the event_mutex, such that as
>>>     soon as I get the test image, the state machine enters
>>>     DISCONNECT_PENDING. This is immediately followed by another
>>>     !link_ready && status = connected, which attempts to perform the plug
>>>     operation, but as we're in DISCONNECT_PENDING this is posted on the
>>>     event queue. From there I get a log entry from my PLUG_INT, every
>>>     100ms stating that we're still in DISCONNECT_PENDING. If I exit
>>>     modetest the screen goes black, and no new mode can be selected,
>>>     because we're in DISCONNECT_PENDING. The only way out is to disconnect
>>>     the cable to complete the DISCONNECT_PENDING.
>>>
>>
>> I am going to run this test-case and see what we can do.
>>
>>> Regards,
>>> Bjorn
>>>
>>>>
>>>>>>             else if (dp_display->link_ready && status == connector_status_disconnected)
>>>>>> -          dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>>>>>> +          dp_hpd_unplug_handle(dp, 0);
>>>>>>     }
>>>>>> --
>>>>>> 2.43.2
>>>>>>
> 
> 
> 

