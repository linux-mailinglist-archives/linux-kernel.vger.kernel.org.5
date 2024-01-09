Return-Path: <linux-kernel+bounces-21315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27FD828D74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9D1C248E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D83D3A1;
	Tue,  9 Jan 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="neBSO6qO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E53D386;
	Tue,  9 Jan 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Ga5GC010605;
	Tue, 9 Jan 2024 19:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CLs3YjVYDE1s7FRJYEHsjits3mEdR85aig3ksCqQKco=; b=ne
	BSO6qO4kBzwhbQ+EG8+UBw2PlrbWtcp2JLfbXhWxuqTZUrjI7S1bb5FYYIKDegjx
	j162pkIgmvHKf97UvSvawocVkeKVPSWa/iOTiL77aVy6C5zvWkZWC89mwy7bmx1r
	BWikfg4pTwCN0+LqiF9EpGW/1im6knKgvgcMXWJN9YI7QNw+3GFge0pi0JgOnLxY
	0OveDYXauv7AqSn6SL475w5c570VIpCTgM1yjeb0EsREkW4hOkUaiPwAVC/WjGSk
	FQGpRko8+kmpncAIg2kLm5ng8rc7+33Hw3HKEdYBe11U7qn0wh49Z2hmNI7fWoqx
	5olOzEnOILqXVBpSmjug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9ta0dgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:32:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409JWsMw029883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:32:54 GMT
Received: from [10.110.21.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 11:32:54 -0800
Message-ID: <ac5db099-b810-4e74-551f-2ee3658482c0@quicinc.com>
Date: Tue, 9 Jan 2024 11:32:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/msm: add a kernel param to select between MDP5
 and DPU drivers
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
 <20240106-fd-migrate-mdp5-v3-3-3d2750378063@linaro.org>
 <c8d6769b-eb28-337c-fa55-4dae86611da5@quicinc.com>
 <CAA8EJpoF3uKobGzjHbLMKYvcQbdqYzur7Mn1cNDPyc+wiiZ+SQ@mail.gmail.com>
 <9807bb4a-98d9-8f4b-b24d-0134f42f6cd3@quicinc.com>
 <CAA8EJpqmkzOaewrW8tqSV5wz+0zovZx-kpMdVWp_nW_g1KrRzA@mail.gmail.com>
Content-Language: en-US
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <CAA8EJpqmkzOaewrW8tqSV5wz+0zovZx-kpMdVWp_nW_g1KrRzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IRIjo5imv_n9jIlKOOTZx4hozVTHrK0V
X-Proofpoint-ORIG-GUID: IRIjo5imv_n9jIlKOOTZx4hozVTHrK0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=868
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090157

On 1/8/2024 11:07 AM, Dmitry Baryshkov wrote:
> On Mon, 8 Jan 2024 at 19:57, Carl Vanderlip <quic_carlv@quicinc.com> wrote:
>> On 1/5/2024 4:38 PM, Dmitry Baryshkov wrote:
>>> On Sat, 6 Jan 2024 at 02:04, Carl Vanderlip <quic_carlv@quicinc.com> wrote:
>>>> On 1/5/2024 3:34 PM, Dmitry Baryshkov wrote:
>>>>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>>>>> index 50b65ffc24b1..ef57586fbeca 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_drv.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>>>>> @@ -969,6 +969,37 @@ static int add_components_mdp(struct device *master_dev,
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> +#if !IS_REACHABLE(CONFIG_DRM_MSM_MDP5) || !IS_REACHABLE(CONFIG_DRM_MSM_DPU)
>>>>> +bool msm_disp_drv_should_bind(struct device *dev, bool mdp5_driver)
>>>>> +{
>>>>> +     /* If just a single driver is enabled, use it no matter what */
>>>>> +     return true;
>>>>> +}
>>>>
>>>> This will cause both MDP/DPU probes to return -ENODEV, rather than
>>>> select the enabled one.
>>>
>>> No. The code (e.g. for DPU) is:
>>>
>>>          if (!msm_disp_drv_should_bind(&pdev->dev, true))
>>>                   return -ENODEV;
>>>
>>> So the driver returns -ENODEV if msm_disp_drv_should_bind() returns
>>> false. Which is logical from the function name point of view.
>>>
>>
>> but msm_disp_drv_should_bind() is returning true in the #if !REACHABLE()
>> case?
>>
>> at minimum the comment is incorrect since returning true causes the
>> driver to NOT be used.
> 
> No. Returning _false_ causes the driver to not be used.
> 

Apologies... you are correct.

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

-Carl V.

