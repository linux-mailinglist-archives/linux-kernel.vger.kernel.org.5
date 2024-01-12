Return-Path: <linux-kernel+bounces-24880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DC82C426
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D4282B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66871B590;
	Fri, 12 Jan 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IdeTu56k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EC17570
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CFQI7q008287;
	Fri, 12 Jan 2024 17:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=b9NZbxKGkMu7WSq1DRJZvs6ktHpD4yfQIktgeIKEyJw=; b=Id
	eTu56kFSblsfgVGDycwx3ezfsyQZ8TwW+/eXm9jeJ6Bg0HWCqKBVWBMm3hekJQtU
	kWBdGXHGPkyoUCI7CVXz+1A7aPcaYPxIBTdVMXP/gCwLThRAjOcnTKCCk9kkyWld
	fyjB7STNPmmQO2F/D1coP2yNyzr69lvgYbZ+E8Sn4UP0Uuy5gzsTTfZosRZoGTzd
	lqcI7QS0vvDkDKLpl63xb+Kzwo+wy26SfRJA1qcKn0uNR8UYoHkbdJzFkUxny2wE
	ujhrm5HLAEUX9iBdjy+XDP7VopEVdtFVeLuVl1n+8saw2LWYu0dEvZBtSu+TsQ+D
	3yso7ktmQSBIv0l3P6MA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjqx1jevd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:00:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CH0iQN021505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:00:44 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 09:00:43 -0800
Message-ID: <3915b289-2741-4b18-ab11-3c7c8e7fbac4@quicinc.com>
Date: Fri, 12 Jan 2024 09:00:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: nt36523: Set 120Hz fps for xiaomi,elish panels
Content-Language: en-US
To: Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240112140047.18123-1-lujianhua000@gmail.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240112140047.18123-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5duJvOEVbRnFTa77GTuHcGGCO9uB0RxV
X-Proofpoint-GUID: 5duJvOEVbRnFTa77GTuHcGGCO9uB0RxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120134



On 1/12/2024 6:00 AM, Jianhua Lu wrote:
> After commit e6c0de5f4450 ("drm/msm/dpu: try multirect based on mdp clock limits")
> merged, 120Hz is working on xiaomi,elish panels, so feature it.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> index a189ce236328..d6fa76dbf948 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> @@ -933,8 +933,7 @@ static int j606f_boe_init_sequence(struct panel_info *pinfo)
>   
>   static const struct drm_display_mode elish_boe_modes[] = {
>   	{
> -		/* There is only one 120 Hz timing, but it doesn't work perfectly, 104 Hz preferred */
> -		.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 104 / 1000,
> +		.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 120 / 1000,
>   		.hdisplay = 1600,
>   		.hsync_start = 1600 + 60,
>   		.hsync_end = 1600 + 60 + 8,
> @@ -948,8 +947,7 @@ static const struct drm_display_mode elish_boe_modes[] = {
>   
>   static const struct drm_display_mode elish_csot_modes[] = {
>   	{
> -		/* There is only one 120 Hz timing, but it doesn't work perfectly, 104 Hz preferred */
> -		.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 104 / 1000,
> +		.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 120 / 1000,
>   		.hdisplay = 1600,
>   		.hsync_start = 1600 + 200,
>   		.hsync_end = 1600 + 200 + 40,
> -- 
> 2.41.0
> 

