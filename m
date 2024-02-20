Return-Path: <linux-kernel+bounces-73593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35085C4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1327B1F255AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4B1369A8;
	Tue, 20 Feb 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nuplWMYP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228D12F5BF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457255; cv=none; b=iWVBVr88cv9phXpqm+QrmAIaWWfDyG5MRyjQ+34LbiSr2XI7MI9LpLa34kGDwYYH9E3BsxXXqKzQBxLLKz8JDJAMo7ps8AlVKdlGSn1e5dytt4IAfoaOgitx2riR5vUS2ztBHVj0KK1lzXm0lAUAJ8qiD+EYwp2nDXL/Z9o6ikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457255; c=relaxed/simple;
	bh=hC88BZuqIjicZPqhBXQ/rRwSX8BaH17kZbuBFpNv1uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=puLQ0HXXO11ig0biZdU1zi0LIrRy7BbWe860yekgPeO1WC7JurfLyjovE6xQBRgPFgmVxSPikfFpXimx9L7VPEforFz68a9HXddM8D4h1/lG5zsorwuiHg7tCAciPqYhphUdEwk/1NZPusRQ241wJL1v+10ij7t1KvTABSAXkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nuplWMYP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KJFiSS021818;
	Tue, 20 Feb 2024 19:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q/plVcvO1WfGsPITbLbiTiRdy4hEFuw8/6lXwDmsHPM=; b=nu
	plWMYPEUkmuINkMR38btt45QYliCGPf55CFvrW3Uz83CkZcv/ITO2biVEbPeqP6P
	13VJfCH2wbws0zb/6Fxt5KUV7dZCpl3VO3zAiRi4XtVdKpSaoyw7eHxM0/aQjufU
	fkJWURSI57zkUX4jGFri+l2a9OI6mz8SJXAbfb7Ux6+E1xZOyTo9QUfgkUBSXmug
	pDE8d7EsYSxKFf57o4GN9vZJ1SOXuHLY2+R0ricV4Xwvc+oHGjAhF46h1nC4wNRv
	UXk1auZg0QWawVpyRpk64pDfT4d7EgsvIqW/sV0KfXTutZeqVxX+4Z/BQOjs1lBf
	Z0tWeEGgg35BhvLZOxCA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd230r0th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KJRJue006072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 19:27:19 GMT
Received: from [10.110.62.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 11:27:18 -0800
Message-ID: <ec5ee910-469e-4224-28ca-336c9f589057@quicinc.com>
Date: Tue, 20 Feb 2024 11:27:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin
	<tvrtko.ursulin@linux.intel.com>,
        <robdclark@gmail.com>, <freedreno@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>, <ville.syrjala@linux.intel.com>,
        <quic_jesszhan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <intel-xe@lists.freedesktop.org>
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
 <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com>
 <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
 <CAA8EJpoeb63QRddxawm2J0s8O0XrLQBrDuYXOB=ZtzDG7mu2PQ@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpoeb63QRddxawm2J0s8O0XrLQBrDuYXOB=ZtzDG7mu2PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YVP7otHqJ9hM93Bim4XH1u-F1NYtMoJb
X-Proofpoint-GUID: YVP7otHqJ9hM93Bim4XH1u-F1NYtMoJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=525
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402200139



On 2/20/2024 11:20 AM, Dmitry Baryshkov wrote:
> On Tue, 20 Feb 2024 at 21:05, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
>>>> On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>>
>>>>> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
>>>>> Lets move this to drm_dp_helper to achieve this.
>>>>>
>>>>> changes in v2:
>>>>>           - rebased on top of drm-tip
>>>>>
>>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>
>>>> v1 had an explicit comment before the ack:
>>>>
>>>
>>> Yes, I remember the comment. I did not make any changes to v2 other than
>>> just rebasing it on drm-tip to get the ack from i915 folks.
>>>
>>>>>      From my side, with the promise of the size fixup.
>>>>
>>>> However I observe neither a second patch removing the size argument
>>>> nor it being dropped as a part of this patch.
>>>>
>>>
>>> Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
>>> the addition of the next patch to remove the size OR as another series
>>> so as to not block the main series which needs this patch.
>>>
>>> I would prefer the latter.
>>
>> It doesn't work this way. The comment should have been fixed for v2.
> 
> This probably deserves some explanation. Currently there is only one
> user of this function. So it is easy to fix it. Once there are several
> users, you have to fix all of them at the same time, patching
> different drm subtrees. That complicates the life of maintainers.
> 

Yes, understood. Its easier to fix it now if its really needed.

Actually, I think the reason the size was passed was to make sure
a valid struct dp_sdp *sdp was being passed.

If we drop the size, we need to have a if (!sdp) check as there is a 
memset followed by dereference.

So maybe, if we want to keep this API protected, its not too bad to have?


