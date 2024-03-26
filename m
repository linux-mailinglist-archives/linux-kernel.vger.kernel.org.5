Return-Path: <linux-kernel+bounces-119844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9988CD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AA6B22253
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780713D27D;
	Tue, 26 Mar 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Urn1WrZK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3813D265;
	Tue, 26 Mar 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482979; cv=none; b=vA1Vyp1i1IikJZ6WCIcvi1kyYpGFpmhTdy0r847NK/OxAXAeJGPW12QKpYnha4pn5rYgBbX43OCcZZLDKPagJKQtQ+GhxS07frn4XX2z52ADH6V2CP4osTZQjOClxljnle1yHUSWUHYqCBmgKx/IvG/sixLpdUWm3eQXZ/iodXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482979; c=relaxed/simple;
	bh=sPzkDeSQXglsm1dp8gUCTJnA8tjKoR1gtSKn1zXU9Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g86IHLotYzsJsYdRrJPvePR3a/V4TFGt/5pz5zbzLUQ4V5AyFwcYB+TZXjodRzBdxzgYUsZTXcibwTVXIQeuynKDsqHad5xkK5zccQB2rlNn3w2TveLPLnYA+UT7NKy8uDw+vmCfvv3OGfMkQNQS5OqoLeTPwj3kB4ecTn/8U+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Urn1WrZK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QJUE3X008406;
	Tue, 26 Mar 2024 19:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=R+nb9lS6hms8hfdO9EwdnZGylgYhz9FMnJ+uf2rzXRE=; b=Ur
	n1WrZK3aeBHQ+fRR13VkTmoRkmjb9+zt+TaR/FdscTiU5DxgccUPQ6A/UouVKI1X
	qojt1Zxm7XAOhobVcBL5rslwGpEzXtS/+rbJhT1LP3Ig04XbdbBRt6Y/bylu/nXz
	Cgkbfy26P2NG3aKEHyo2ljYPtwKHwxrWvr8/I/R9arI9DU3vgxjYzKnmM82Zok4p
	I8UqrF0IWcIAr7Mg2tXekoq2RmdsVW6SCczOSEasLu9nyw0obPDT9Cqf1IKoBE8D
	xbltzTaRPn4b8YcsAiOWQM3MbhLU+lXiVo+/64onnHAUovx/rhg1ss7e6qUprFrL
	d9q8sf+maamJsxW9sK/Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3tvy9vkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:56:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QJu7vp030959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:56:07 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 12:56:05 -0700
Message-ID: <0280fa9a-cdb0-5bf7-7940-3c2cda1da829@quicinc.com>
Date: Tue, 26 Mar 2024 12:56:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error:
 variable 'out' set but not used
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        linux-kernel
	<linux-kernel@vger.kernel.org>
References: <CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHEnc3qApu2Q@mail.gmail.com>
 <CAA8EJprTNFgKJ_3cdZz4f_LCkYFghi-cfaj3bZmYh3oA63my6A@mail.gmail.com>
 <85204b78-7b24-61cd-4bae-3e7abc6e4fd3@quicinc.com>
 <CAA8EJppqrF10J1qExM=gopiF4GPDt7v4TB6LrQxx5OGyAL9hSg@mail.gmail.com>
 <671d2662-df4e-4350-0084-476eb1671cc1@quicinc.com>
 <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpppre8ibYqN7gZObyvzR08yVbTevC6hDEDCKQVf8gRVRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qbi3sBaUcbYKyvfA2vrlKfpgK8S3TX12
X-Proofpoint-ORIG-GUID: Qbi3sBaUcbYKyvfA2vrlKfpgK8S3TX12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260143



On 3/26/2024 12:47 PM, Dmitry Baryshkov wrote:
> On Tue, 26 Mar 2024 at 21:32, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 3/26/2024 12:10 PM, Dmitry Baryshkov wrote:
>>> On Tue, 26 Mar 2024 at 20:31, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/26/2024 11:19 AM, Dmitry Baryshkov wrote:
>>>>> On Tue, 26 Mar 2024 at 20:05, Miguel Ojeda
>>>>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> In today's next, I got:
>>>>>>
>>>>>>        drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: error: variable
>>>>>> 'out' set but not used [-Werror,-Wunused-but-set-variable]
>>>>>>
>>>>>> `out` seems to be there since commit 64d6255650d4 ("drm/msm: More
>>>>>> fully implement devcoredump for a7xx").
>>>>>>
>>>>>> Untested diff below assuming `dumper->iova` is constant -- if you want
>>>>>> a formal patch, please let me know.
>>>>>
>>>>> Please send a proper patch that we can pick up.
>>>>>
>>>>
>>>> This should be fixed with https://patchwork.freedesktop.org/patch/581853/.
>>>
>>> Is that a correct fix? If you check other usage locations for
>>> CRASHDUMP_READ, you'll see that `out` is the last parameter and it is
>>> being incremented.
>>>
>>
>> Right but in this function out is not the last parameter of CRASHDUMP_READ.
> 
> Yes. I think in this case the patch from this email is more correct.
> 

Alright, in that case, Miguel can you please repost this with the Fixes 
tags and in a patch form.

>>
>> Maybe you or Rob can correct me but I thought the fix looked sane
>> although noone commented on that patch.
> 
>>
>>>>
>>>> We can pickup that one with a Fixes tag applied.
>>>>
>>>>>>
>>>>>> Cheers,
>>>>>> Miguel
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>>>>>> b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>>>>>> index 1f5245fc2cdc..a847a0f7a73c 100644
>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
>>>>>> @@ -852,7 +852,7 @@ static void a6xx_get_shader_block(struct msm_gpu *gpu,
>>>>>>                 (block->type << 8) | i);
>>>>>>
>>>>>>             in += CRASHDUMP_READ(in, REG_A6XX_HLSQ_DBG_AHB_READ_APERTURE,
>>>>>> -            block->size, dumper->iova + A6XX_CD_DATA_OFFSET);
>>>>>> +            block->size, out);
>>>>>>
>>>>>>             out += block->size * sizeof(u32);
>>>>>>         }
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 

