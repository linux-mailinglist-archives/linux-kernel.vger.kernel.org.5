Return-Path: <linux-kernel+bounces-153797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18C48AD348
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631701F224D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF18153BE3;
	Mon, 22 Apr 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WpJf0AwF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EE146A6A;
	Mon, 22 Apr 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806610; cv=none; b=C2IpVsZ4GR6/ebtYGb9U529ZfMDez9pgjbwEcbtMbrSoEeAWzw9myaczUJkqW68kBKu5WRL4wKS3vxlSfIk5AUPb1QLGff0/GqQqZUh3kPU7qlE26zhjM2/WIrPev6kgn1mE8tEn36gezJLcSDmQs7/splgKSlxucMQAa6eLzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806610; c=relaxed/simple;
	bh=7sR9LTQhv+ccDVxIYPm8fhQPGdyYb5+zpwnVqUksIPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DbjtzRX95hKjcq8xuE2ctsS6YxCPmgs4UbKMXx3HLHns4Mco52VS/fRmNRua9BIyFcTC4WSyePJ6LgobljbjoQ3PIuYI0Do0uCMDHGblXiCgy3AAEsyRfmK98xEwuVyQxavbD4WtX6YIupavpq9VrGwIGNJgUNwTtEdL98r+7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WpJf0AwF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9bGIv004777;
	Mon, 22 Apr 2024 17:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VRd+FqoZJAkqncCjwp7KhsDNB5TkvPIXDmBsNGsOv6c=; b=Wp
	Jf0AwFPnpDZtLCIsOfhqetGbQHanZZX1VmZkjR/oWj/D+1I7nAEXWSQWoY1Dbd6r
	ham4ZCYwyB/JI3FaTPfPlVzlgUaEsJIHmZxEK0kiX3d0ojhN4dxpZmiWj6he3Uku
	kbxHUW437UemFOZcXBzUIGg6mK9NONnCSPcfQFtCTT4fAh5pkQbZCBlm8aP9tnA3
	RlOoDTHgdGoCm7zgGo/VPFb1ixZ3FIR0l9AGPcb6KxIdhATXePNkoo8oKA2SDeSa
	b6C58Cidgnf3SNZHDPCX1IUuEYXnHh2+M9eNLkga+n0yoKufVy4j7wSCCexlP5tb
	0YfIlS1bZBCdzsjqvcTw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne295jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:23:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHNJWe005527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:23:19 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:23:19 -0700
Message-ID: <7daeeaba-a33d-bf05-1371-d9b5fa0bf0a5@quicinc.com>
Date: Mon, 22 Apr 2024 10:23:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/msm: don't clean up priv->kms prematurely
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
 <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>
 <n7eet54g72usmuh4hdz6yce3i4ieweu4orgd7gewu7y53ejucc@dzmq2a2wdxkc>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <n7eet54g72usmuh4hdz6yce3i4ieweu4orgd7gewu7y53ejucc@dzmq2a2wdxkc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gik2XTWn6sjBZbjbXowMENMblUen81bD
X-Proofpoint-ORIG-GUID: Gik2XTWn6sjBZbjbXowMENMblUen81bD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=740 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220072



On 4/21/2024 3:35 PM, Dmitry Baryshkov wrote:
> On Sat, Apr 20, 2024 at 04:02:00PM -0700, Abhinav Kumar wrote:
>>
>>
>> On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
>>> MSM display drivers provide kms structure allocated during probe().
>>> Don't clean up priv->kms field in case of an error. Otherwise probe
>>> functions might fail after KMS probe deferral.
>>>
>>
>> So just to understand this more, this will happen when master component
>> probe (dpu) succeeded but other sub-component probe (dsi) deferred?
>>
>> Because if master component probe itself deferred it will allocate priv->kms
>> again isnt it and we will not even hit here.
> 
> Master probing succeeds (so priv->kms is set), then kms_init fails at
> runtime, during binding of the master device. This results in probe
> deferral from the last component's component_add() function and reprobe
> attempt when possible (once the next device is added or probed). However
> as priv->kms is NULL, probe crashes.
> 
>>
>>> Fixes: a2ab5d5bb6b1 ("drm/msm: allow passing struct msm_kms to msm_drv_probe()")

Actually, Is this Fixes tag correct?

OR is this one better

Fixes: 506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")


>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/msm/msm_kms.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
>>> index af6a6fcb1173..6749f0fbca96 100644
>>> --- a/drivers/gpu/drm/msm/msm_kms.c
>>> +++ b/drivers/gpu/drm/msm/msm_kms.c
>>> @@ -244,7 +244,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
>>>    	ret = priv->kms_init(ddev);
>>>    	if (ret) {
>>>    		DRM_DEV_ERROR(dev, "failed to load kms\n");
>>> -		priv->kms = NULL;
>>>    		return ret;
>>>    	}
>>>
> 

