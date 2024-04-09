Return-Path: <linux-kernel+bounces-137395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A789E16F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43FE283480
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1A15667A;
	Tue,  9 Apr 2024 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hw+oHEGK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA115624E;
	Tue,  9 Apr 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683200; cv=none; b=OnfLfnC8vYllmS2xNQSOACIO28wDy1GkA0HZzIjgd6GviSrgoxRSu9SmaerhSZ+G9coOwCahxJpyaLOTdUw1r3/Y/1uLMXPb1WlN6NSeBhhFT+t7Gx6DojorbigC+vQaMCFwF3cuy/fbhcKB7R1zQ/Ll8jBnTXmb8q+sBMUlfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683200; c=relaxed/simple;
	bh=MX/jaT995o39SVb4w3KWka52pzriagvfVrr3JcFpSs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dsGR/SNtly86ryZnIrnrTIFdrZ0I9/OrGDTnzcykxckt24YwyHXKfFgqDr68t+FRpvK2wFRlWzutDVQxgH6adjdYlNW/sa6TIQdZ68hN4rsdyooouyXmRk+JDuzX/gp/2Nqk5/nBGq0Dc8MNT4HmscpRlyRsMhZc2nFvgvt9CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hw+oHEGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439AmgRi015186;
	Tue, 9 Apr 2024 17:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QpJxkETK9XY7FK/LiJttaU6PuwaB78Eu6bRDXhDiPMM=; b=Hw
	+oHEGK5YUlXztdarDsrgD0ajdN2AhZZGZstZxuJLScw76F4CzSL+EtXp66vCmUxS
	KbNeQ3aND0H6H0Lx+LSw1xwTmSq50Vj6Bzgc3SyzehT6ihQ8Hb/F8g8yv2Y11mfH
	vwhzkd5Xq4ZYmshltqx9H/9ZyWXVsvR1rq5XNzuywL9cACVPRp7Ad+GmIFhEwbq9
	LB1TL3eJs4tHqymGAVPM4Nc3ZfrQB+n/6o4usCKWL+0JJDLCjQ4vdW905l8omjm8
	ooQBmybUaSx5WL6UNPj8tXca9MJ9FJLkaZcuEZrwR2xV4xUAZm5WOWnqRIcQ6vKQ
	Shn5wgR031FRhIEqeTdQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd0hjsbq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 17:19:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439HJdo5015383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 17:19:39 GMT
Received: from [10.71.108.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 10:19:38 -0700
Message-ID: <bad7f3e8-38ce-4901-8f00-de32a659f0ba@quicinc.com>
Date: Tue, 9 Apr 2024 10:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] drm/mipi-dsi: use correct return type for the DSC
 functions
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sumit Semwal
	<sumit.semwal@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, David
 Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Marijn
 Suijten <marijn.suijten@somainline.org>
References: <20240408-lg-sw43408-panel-v5-0-4e092da22991@linaro.org>
 <20240408-lg-sw43408-panel-v5-2-4e092da22991@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240408-lg-sw43408-panel-v5-2-4e092da22991@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dWVaDgAEYxUcywapg5fLLapUEMvR2SY1
X-Proofpoint-GUID: dWVaDgAEYxUcywapg5fLLapUEMvR2SY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090113



On 4/7/2024 4:53 PM, Dmitry Baryshkov wrote:
> The functions mipi_dsi_compression_mode() and
> mipi_dsi_picture_parameter_set() return 0-or-error rather than a buffer
> size. Follow example of other similar MIPI DSI functions and use int
> return type instead of size_t.

Hi Dmitry,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Fixes: f4dea1aaa9a1 ("drm/dsi: add helpers for DSI compression mode and PPS packets")
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 6 +++---
>   include/drm/drm_mipi_dsi.h     | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index ef6e416522f8..9874ff6d4718 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -654,7 +654,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
>    *
>    * Return: 0 on success or a negative error code on failure.
>    */
> -ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> +int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
>   {
>   	/* Note: Needs updating for non-default PPS or algorithm */
>   	u8 tx[2] = { enable << 0, 0 };
> @@ -679,8 +679,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
>    *
>    * Return: 0 on success or a negative error code on failure.
>    */
> -ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> -				       const struct drm_dsc_picture_parameter_set *pps)
> +int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> +				   const struct drm_dsc_picture_parameter_set *pps)
>   {
>   	struct mipi_dsi_msg msg = {
>   		.channel = dsi->channel,
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index c0aec0d4d664..3011d33eccbd 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -241,9 +241,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
>   int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
>   int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
>   					    u16 value);
> -ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> -ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> -				       const struct drm_dsc_picture_parameter_set *pps);
> +int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
> +int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
> +				   const struct drm_dsc_picture_parameter_set *pps);
>   
>   ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
>   			       size_t size);
> 
> -- 
> 2.39.2
> 

