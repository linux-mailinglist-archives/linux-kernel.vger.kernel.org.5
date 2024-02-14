Return-Path: <linux-kernel+bounces-65770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE3855190
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F31F24143
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D012BF3F;
	Wed, 14 Feb 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TdLmQ0K5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B91292CC;
	Wed, 14 Feb 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933774; cv=none; b=utAyTJ9liAM+g5TTWwEr9ERObO+faKxXEDXTrDpuydyr8pLWsxwl/tow/eyCVE0tBlkdGqVwkoIpWxHhIUSQ/OKd44z6WfDQ1MtNp2BmfWOPoOqmVYRLCnFBZvcmfygvcRosRAFt597HYB+KziqDT5C3Nfq/CBZVNr8Oh6bsJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933774; c=relaxed/simple;
	bh=XNSWQVAKioEdiIWsSLtpNc/QmIthNVyXFka5sud+Oeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rlXcX5qIwQ+y+cZCPqaby+M7FeuTftnF4poW+xhjjpMo3eZdxCUbQW/ufItGUROpFYYeg7PfowKtDOMzvwQgeTDqP54WSiWje9/21W6pvG4G4vA78kMY4bVT2kHqFvcbVO4sg9mpendWqgk+eplPM2XoW2pJGkjhZyPtLIsXsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TdLmQ0K5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EHPS46029136;
	Wed, 14 Feb 2024 18:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QoMDsaCSkkb16GXrIH1bJHTndnxHaOKSYN4y2bjArSc=; b=Td
	LmQ0K54PsMs37BGTPVqoe1qWW3ToSayaEHXmQUP1ebSGFYBDGUUYMjnhunVMJH1C
	uS4E6JZa0DaJn4RBrlanFP7tn1Uo0cTwrRsGSi4c0hw0TrmSCQIyy9zcyfbzXYMQ
	VF+A4my/eGgPp8JOOyBwZedT3HC+1KObN25LLxi2rvMjdSYMdy9grAHNfXGMb+Ec
	qYhfeadggdBFxrYOs8ogxgamoQCQITcxYo8205+matQH94XrAEEVt8IkBFPqRcM8
	jZ/kzV/NXCou5dZ1hZ/d3ME/wGtTnYVv7IORPYqwlkPRBTBDb5+7NmG0a6r+c9lq
	BBy78fZcACVle+GVU3YQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8myg1rxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:02:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EI2E5C009061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:02:14 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 10:02:13 -0800
Message-ID: <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com>
Date: Wed, 14 Feb 2024 10:02:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
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
References: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tQaPJv5Iy1j9aGOR7INtSGMYbv6ZM4fi
X-Proofpoint-ORIG-GUID: tQaPJv5Iy1j9aGOR7INtSGMYbv6ZM4fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402140141



On 2/8/2024 6:50 AM, Dmitry Baryshkov wrote:
> We have several reports of vblank timeout messages. However after some
> debugging it was found that there might be different causes to that.
> To allow us to identify the DPU block that gets stuck, include the
> actual CTL_FLUSH value into the timeout message and trigger the devcore
> snapshot capture.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Added a call to msm_disp_snapshot_state() to trigger devcore dump
>    (Abhinav)
> - Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index d0f56c5c4cce..a8d6165b3c0a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
>   		(hw_ctl->ops.get_flush_register(hw_ctl) == 0),
>   		msecs_to_jiffies(50));
>   	if (ret <= 0) {
> -		DPU_ERROR("vblank timeout\n");
> +		DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
> +		msm_disp_snapshot_state(phys_enc->parent->dev);


There is no rate limiting in this piece of code unfortunately. So this 
will flood the number of snapshots.

Short-term solution is you can go with a vblank_timeout_cnt and reset it 
in the enable() like other similar error counters.

long-term solution is we need to centralize these error locations to one 
single dpu_encoder_error_handler() with a single counter and the error 
handler will print out the error code along with the snapshot instead of 
the snapshot being called from all over the place.



>   		return -ETIMEDOUT;
>   	}
>   
> 
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20240106-fd-dpu-debug-timeout-e917f0bc8063
> 
> Best regards,

