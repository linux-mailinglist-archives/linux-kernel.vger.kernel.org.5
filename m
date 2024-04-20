Return-Path: <linux-kernel+bounces-152385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2C8ABDAD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDA6281301
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3D4C63A;
	Sat, 20 Apr 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cE2cFav/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17613B299;
	Sat, 20 Apr 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713654132; cv=none; b=RLt4Tg+IgKxfu6r4UWajNUbJEWK83VCkaxpYTZyQJLJNSC1i5P//mGscDQt2zHUA+/D0gHlKauaBf3gUhtvThcEhOqUEXWF5FJQojq1pKExqwODOax3DE4s/pOVTZRZUgafx0BHnPuBbgj4a1cjiXbQ+U5Ujftk8kC7tDGSCDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713654132; c=relaxed/simple;
	bh=HX6oWAzxKYykRfPJWXk05IYwhsFq1jTjlGz4/d23Fj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I7/YT2VmoJlcdxyUudcbnYkF5NYrTKy2Br5Hg/6mwSp03QKgu1HHCtkTMPeObk0Wiuxuv7fnKbpTO4CgHFjB5xwKtZgrQPLHBH4TX4WX1RZepbFlpwkW1c2pW8jUWq+qwGTAyIZA8YdvZAZmfAdA6yC1EAKxIO3uFBv/quBym2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cE2cFav/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KN1cx8002829;
	Sat, 20 Apr 2024 23:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FZYXfNTeqeXP5XLOhclyvcDa1LVtNsnPuR/MGqtlR7M=; b=cE
	2cFav/ce0NgFf/WIxPeaWP3VZjpCIFTuUPvo0TgXI2Y1nMPflgWMt6JHw/0raP2a
	hx/3ybAgHiV15gEVNP9xtZZ2qpvN+eCe+GkCbVY8JjnZPl9DSKn/XjheHaOwcFlQ
	zgC6g3k1s0ws+Njwerc4XY8Pl2p3S7N89roAxUTvl/KSOCGo8Eg51nHDlUrtvbI7
	GFLeEu6cm+o42BnSYbkTcYtvs46Oz8pFrApY0vILL96Ewp5tDSEMGu9ocEpUW3g3
	0WsunlN+zkr2lM3DvNl7ar4lRsk1ewTr4U8q7icwNPIj5mKmogUTft/10EwqszQN
	uRGgBDl7KjW1LRK7mp6A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4nuhg33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:02:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KN21ac002290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:02:01 GMT
Received: from [10.110.104.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 16:02:00 -0700
Message-ID: <67fbd629-3e80-b706-83a3-7baff3efd6c1@quicinc.com>
Date: Sat, 20 Apr 2024 16:02:00 -0700
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240420-mdp4-fixes-v1-1-96a70f64fa85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yFrY6Dt2ydamSVAa0RNmpUgIZPrpDKfl
X-Proofpoint-GUID: yFrY6Dt2ydamSVAa0RNmpUgIZPrpDKfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_20,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=772 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404200170



On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
> MSM display drivers provide kms structure allocated during probe().
> Don't clean up priv->kms field in case of an error. Otherwise probe
> functions might fail after KMS probe deferral.
> 

So just to understand this more, this will happen when master component 
probe (dpu) succeeded but other sub-component probe (dsi) deferred?

Because if master component probe itself deferred it will allocate 
priv->kms again isnt it and we will not even hit here.

> Fixes: a2ab5d5bb6b1 ("drm/msm: allow passing struct msm_kms to msm_drv_probe()")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_kms.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index af6a6fcb1173..6749f0fbca96 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -244,7 +244,6 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
>   	ret = priv->kms_init(ddev);
>   	if (ret) {
>   		DRM_DEV_ERROR(dev, "failed to load kms\n");
> -		priv->kms = NULL;
>   		return ret;
>   	}
>   
> 

