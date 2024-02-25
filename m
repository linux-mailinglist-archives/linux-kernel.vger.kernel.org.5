Return-Path: <linux-kernel+bounces-80295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B94862D08
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AAD1F21C55
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD61B947;
	Sun, 25 Feb 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KQDl6K2S"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB051367;
	Sun, 25 Feb 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895036; cv=none; b=Lw4rmlBlL7RMbgzFv6WO5n3sOXNPtnQTzKrwVGkl9ettriKbg9vrMtmmLPaX3nvFjP9Fu9xj05oiTq0KPNi4oAVFaO9IYQTswgny2SM0MMkeHpnE0QOtAxmxuk3LAw30muwp6lFN9tmD4QJgmINujly62+wZ+BpB52CFlyTwkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895036; c=relaxed/simple;
	bh=nE4Tnfy5+zj0NK2k6hoQYQYro8P8p/E8b1VECg0XNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SV/VjzFUpUahEmkza2aMM7n7FiVdRPFXWAqEdm5FhVVa3SpWveq/r6Ki+EfyNedSD4wp8Rjy9qFwQcphn+91Ey3bkrL5Ct7UP0MyejZvV/XDCgQZRUpSqE9byXmRu2fGCXy/tvhRr0ENZkokaM+ICVljQfmnlr7K8tGZw2L//n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KQDl6K2S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PL2MPi029136;
	Sun, 25 Feb 2024 21:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Qa9yCTpTWOGr0nlp+bsQ9GEdf7ISmn60BAOC6chAG6g=; b=KQ
	Dl6K2S1B8X51PfXuoC5IHDiQ9ViJoHLLBuRB6+hKA7PPmSZl/jIWYmoX3w9PD6Xg
	SmmqSdQRZlvQRpvLMUUp6MGlNRmK0zzhJmPwDBLobAcYcr4oQ/BmygKhLSjLci70
	Tv32BvmhhjA8bWen4X8z9ylAzUvDP9eYgYToJQ0pplo4h4M4ui4sTDKL4RZLmIjo
	6vzBmca+MvoJfZHNg7mN0EdJbpX5s51OoBTNgzNDgzZ7aDkfYs/5TRH25pGI0htu
	+Du8y2D+Pg9DNFppTlGeXolwBcxsAHNUq41wr5MzZf5tG8J9Dvb78fTCHpguqZvs
	opR+lUfzeVsVWp7dGuCg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf8ubac0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 21:03:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41PL3hLX008579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 21:03:43 GMT
Received: from [10.110.76.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 25 Feb
 2024 13:03:42 -0800
Message-ID: <293d04ae-f6ca-3362-5924-cdd789888360@quicinc.com>
Date: Sun, 25 Feb 2024 13:03:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] drm/msm/dpu: make "vblank timeout" more useful
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20240225-fd-dpu-debug-timeout-v3-0-252f2b21cdcc@linaro.org>
 <20240225-fd-dpu-debug-timeout-v3-1-252f2b21cdcc@linaro.org>
 <4e6b41f4-27a6-4c65-dc03-67437a9716ed@quicinc.com>
 <CAA8EJppNfdDsrMQA3cUR18b2so2qaw1fcFNMz0fW9rMSzFrysg@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppNfdDsrMQA3cUR18b2so2qaw1fcFNMz0fW9rMSzFrysg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zKTH_YHEalCvYn2B29eO31mCHYiW4Cne
X-Proofpoint-GUID: zKTH_YHEalCvYn2B29eO31mCHYiW4Cne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_25,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=792 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402250168



On 2/25/2024 12:57 PM, Dmitry Baryshkov wrote:
> On Sun, 25 Feb 2024 at 21:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 2/25/2024 6:12 AM, Dmitry Baryshkov wrote:
>>> We have several reports of vblank timeout messages. However after some
>>> debugging it was found that there might be different causes to that.
>>> To allow us to identify the DPU block that gets stuck, include the
>>> actual CTL_FLUSH value into the timeout message.
>>>
>>
>> the flush register shall also be part of the coredump in patch 3. so why
>> is this needed?
> 
> I'd prefer to keep it. The devcoredump captures all registers, while
> CTL_FLUSH points to the actual bit without the need to analyze the
> coredump. At the very least, it allows us to analyze whether the issue
> is the same or not (compare SSPP_DMA2 on c630 vs LM_1 on sdm660)
> without looking into the dump.
> 

Ok, sg


Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> index 2aa72b578764..6058706f03e4 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>>> @@ -480,7 +480,7 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
>>>                (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
>>>                msecs_to_jiffies(50));
>>>        if (ret <= 0) {
>>> -             DPU_ERROR("vblank timeout\n");
>>> +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
>>>                return -ETIMEDOUT;
>>>        }
>>>
>>>
> 
> 
> 

