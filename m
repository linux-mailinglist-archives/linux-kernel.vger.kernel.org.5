Return-Path: <linux-kernel+bounces-152383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB328ABDA4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51251C20A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769D495F0;
	Sat, 20 Apr 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L3V9oR55"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2F205E0A;
	Sat, 20 Apr 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713653454; cv=none; b=h0E4ZAUY2skCNhGyfkk87FrPv8YFpZ3hUQDwSv8ximnJhwYVLwNsTf4KLJi0HsvvtIykxojh9Mxhekf0AZ6C3pllvRa92hXgtPXPkmRs0+fyrsiAdNPNKrC8zrdToqyv1WewkrsHuUHxX+KoL6/GdrattGuZeRWO4OEL4q/77fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713653454; c=relaxed/simple;
	bh=+QjP6FIkutACqLjF/qLHwxXm9b2wg34D8W5h1sfbhes=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tEKgwZXFnnQ87ger+bmuAMn+aiKEMKfDnUhgGm+YxppZLmJHIZ0UWPJBT171gygqWwNSGdMSKV7SLO34rInGvmq41B47ZWG8PLXs1CZwarjgBmc1eGPCwLQxKm7lyOAsoof+ThB16+BcBn5JUyibjz1H5Yocc73r7UbyrV2NNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L3V9oR55; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KMbAuU014226;
	Sat, 20 Apr 2024 22:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zBXf5IpjaMToDMLjr6lG68Po82sfsNY1AWrtBj7dZjE=; b=L3
	V9oR55NzWzd+RCU1duYXo0ia8m5XFYZEjXv6f+wVkJiFvF72inqFmcMYvUA+2wBm
	yGFS46cxQUuN9d9KTGgAVBJ2mk3e+Cul9ilebYV2OcWXDkLN2x+rQ5y8HaVP9LWy
	G34WGWj/6UVv0rWFNbbHzbHcIUEMfPc01nFK7sWUQKzYIDSLrszrgO8mNGQ7ZJrw
	KF8Nj0FIyLpoTrzsZxUvpIrrim3x36M0+esL5wHNnR8vxqK5Rg1ASLt/tZj9taV+
	zalAH0Ssy0tXLuMsZJ+//HOTGaOCpRKoSdOSQbz/9tp8EQBXHJrftCog8iST/uaP
	9mGTIXCqMMZWG9jfFmgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5a31f4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 22:50:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KMoijG006206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 22:50:44 GMT
Received: from [10.110.104.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 15:50:43 -0700
Message-ID: <8afaef40-856d-0faa-5b5f-99d5b6095bc0@quicinc.com>
Date: Sat, 20 Apr 2024 15:50:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 8/9] drm/msm: merge dpu format database to MDP formats
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
References: <20240420-dpu-format-v2-0-9e93226cbffd@linaro.org>
 <20240420-dpu-format-v2-8-9e93226cbffd@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240420-dpu-format-v2-8-9e93226cbffd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: msLpeX5mKaH_n5O6kmVPWosRJ-wVIre7
X-Proofpoint-ORIG-GUID: msLpeX5mKaH_n5O6kmVPWosRJ-wVIre7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_20,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=825 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200169



On 4/19/2024 9:01 PM, Dmitry Baryshkov wrote:
> Finally remove duplication between DPU and generic MDP code by merging
> DPU format lists to the MDP format database.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   4 +-
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   7 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        | 602 --------------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h        |  23 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |  10 -
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   3 +-
>   drivers/gpu/drm/msm/disp/mdp_format.c              | 614 ++++++++++++++++++---
>   drivers/gpu/drm/msm/disp/mdp_format.h              |  10 +
>   drivers/gpu/drm/msm/disp/mdp_kms.h                 |   2 -
>   drivers/gpu/drm/msm/msm_drv.h                      |   2 +
>   11 files changed, 571 insertions(+), 708 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

