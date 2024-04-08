Return-Path: <linux-kernel+bounces-135711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747AD89CA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152DC1F26FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400941428F5;
	Mon,  8 Apr 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gKv71u3F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B6140E2B;
	Mon,  8 Apr 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595148; cv=none; b=S8Q9WQyGBAenV8g+QN+xVayDceVNO2Qm5UeFjTCWFxD5GLX1QPobIwLiY0NrtpDffkB5k4wI1Ry4y6ZtHvKyWe3gU63Vmb/j3bNfGm15/+6qkUi8nTpPCwpu6GjVvGohh5i+REFCe2ZB3RvjYYV4jQJ4HFBUkpZWYiYObfr+tmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595148; c=relaxed/simple;
	bh=rpdGJCQPvlNkkuBKRpcPSOuxjIzClGbODgjz4Pmvkz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeQIbFdO4IBUjgn8bdkgEUGMR3pCDO/J3MV0Il2fr16cBTrtVqFmLMuJvLjpPL+JIFq0RDoJogmfmMPFO1fbA1BAxAhpPtsrq1uO3aBY2ToE5R00ByHbOMOO+Zc9O10hrRCzUoXRupFmV+ytdocqv5TLBhlDrDhN5xy8rQqa5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gKv71u3F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4388hHxc013808;
	Mon, 8 Apr 2024 16:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a1QJLqWuwPzGF5QAUwxhsbEny+tlCv61X+cklcIfyF0=; b=gK
	v71u3Fi6dkLxoEvG0nMlvF2O2+KEQLRFhq+XWGFyaB/Qlv7D3JQrnuoesTZK9TC9
	vAxNfRyxVn/ClIpFnjZXJ2v7sW/v01F4rVOgIbitvHyMNC82UZB2ahfKypCFKIXs
	Q4DxhRlBlvdLXf+m4arLFJY54BpAtYSHAGilAuhhQxLGTa2WfG58TFiVH2lHg+tk
	CZlxQ2KjmSSrgh6Pfa93lxNgfvmrsnPYrbKGYSN1GCVGw5EiQJNYA0x+VdysAoME
	HX5z9qdJmiasM3rg5JeNN+mCCo8ndy6yVoWMKuQZaAKTlpXkChX+vPLHf0SQNJHc
	sBae3uM7X1COxLnw4oPA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbfyhe9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 16:51:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438Gpjae002976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 16:51:45 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 09:51:44 -0700
Message-ID: <c2c3b573-0e62-4452-e657-fbef9abb9430@quicinc.com>
Date: Mon, 8 Apr 2024 09:51:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/msm/dpu: Add callback function pointer check before
 its call
Content-Language: en-US
To: Aleksandr Mishin <amishin@t-argos.ru>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240408085523.12231-1-amishin@t-argos.ru>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240408085523.12231-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HD90BD7yqFpJf_WK5d0r9NlZFaV_FghS
X-Proofpoint-GUID: HD90BD7yqFpJf_WK5d0r9NlZFaV_FghS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_15,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011
 mlxlogscore=659 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080130



On 4/8/2024 1:55 AM, Aleksandr Mishin wrote:
> In dpu_core_irq_callback_handler() callback function pointer is compared to NULL,
> but then callback function is unconditionally called by this pointer.
> Fix this bug by adding conditional return.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

Yes , as dmitry wrote, this should be Reported-by.

But rest LGTM.

> Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index 946dd0135dff..03a16fbd4c99 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
>   
>   	VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
>   
> -	if (!irq_entry->cb)
> +	if (!irq_entry->cb) {
>   		DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
>   			  DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
> +		return;
> +	}
>   
>   	atomic_inc(&irq_entry->count);
>   

