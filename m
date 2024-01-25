Return-Path: <linux-kernel+bounces-39017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71983C9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10871C23334
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B9131E45;
	Thu, 25 Jan 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJxgyyNh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBED4F611;
	Thu, 25 Jan 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202890; cv=none; b=jLWhf8Bu+CpBfG0oPtkvkhexYYZHwXGZrd550oun8DPQ9ITDr2iHia+1CWXlolZI8bxoNxSSthdAzw6ZQ2NGeMLx4iD5WcpelR0uaTiJ45ovvvxi17iyWriQIM4+Ceb2fkCjr+qRFBVAuxL8ZauKCLSgx/xWKDEf3eKNw/PRMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202890; c=relaxed/simple;
	bh=FhdGxpb8WRLhcPuhsyXPUQ/OHyb7n5wxsxPBiROQ59I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BhCr7rT2fJM10RbaeN9lLtNra8EmiVEONW8NezpQDSjnTpfWL3NdviUjHG9enxXK3OKF9cVGpiVmktuKZ2+iCZqq5STK4n54Sgn+w8VFVLuwZvywP0WW/oslPwHmm0WCy7TkcH+IeZMwxoqTL+YTuyXpvWToSEeEAeVTSV32UWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJxgyyNh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P6U5C7016792;
	Thu, 25 Jan 2024 17:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QVBi23eTif8k1KMpbX3/5gFCMzFOXHrSwUxTig2rOoU=; b=FJ
	xgyyNh6KGEbV3J7nosNLR6HiZ8eB6gX8Jhi7VpfT+6XmGiw6Cyi1gaQ3f0w9qWOE
	bCA79aMwzv0sVF6s1PCRolBLgu475QtMnnnNvKYI873uHHnEiWdMmnu7tc64Ddw4
	DYuGpGPVHpXzsmDOlbV/3jR4+6xRjFU3DuiNszp5B+Aoh1sZBAR8Q5Yh2tp6SGEi
	otWyjGDKIHXc23vQseWnASv4rFeAS+k/gTjkz6lpAfVdWzW32wi7CGHrQ7yS62uI
	y1dRb4+IbEWaKaWe6g88jEDCYlWF52aISKQsqPZF4/rj3H/9Oae8eYWMA5ZkGPL0
	DzmbNr2hohDCy9hikvJw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufc8245p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 17:14:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PHEeVH002310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 17:14:40 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 09:14:39 -0800
Message-ID: <ba27bb80-2234-60c8-5f76-34a9f7ae6ae9@quicinc.com>
Date: Thu, 25 Jan 2024 09:14:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dpu: make "vblank timeout" more useful
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SHvHfoZSlaQVkG37NNG_upCDrdy3PfRO
X-Proofpoint-GUID: SHvHfoZSlaQVkG37NNG_upCDrdy3PfRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=738 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250122



On 1/5/2024 3:50 PM, Dmitry Baryshkov wrote:
> We have several reports of vblank timeout messages. However after some
> debugging it was found that there might be different causes to that.
> Include the actual CTL_FLUSH value into the timeout message. This allows
> us to identify the DPU block that gets stuck.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index d0f56c5c4cce..fb34067ab6af 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -489,7 +489,7 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
>   		(hw_ctl->ops.get_flush_register(hw_ctl) == 0),
>   		msecs_to_jiffies(50));
>   	if (ret <= 0) {
> -		DPU_ERROR("vblank timeout\n");
> +		DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
>   		return -ETIMEDOUT;
>   	}

Nothing wrong with this change.

But I dont know how much information this is giving to really find out 
what is causing the vblank timeout. Sure, we know which flush bit is 
actually stuck but we dont know why its stuck.

We should add a logic here to get the snapshot on the first vblank 
timeout that way we avoid excessive capture as well similar to the other 
fatal locations of calling snapshot.

>   
> 
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20240106-fd-dpu-debug-timeout-e917f0bc8063
> 
> Best regards,

