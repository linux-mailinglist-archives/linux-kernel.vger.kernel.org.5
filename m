Return-Path: <linux-kernel+bounces-21257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD83828C96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47521B246DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081863C466;
	Tue,  9 Jan 2024 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANEewrSi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416F3C461;
	Tue,  9 Jan 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409GdZtZ001208;
	Tue, 9 Jan 2024 18:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vgOh8J9LCVrnkd0W5QVID1C+VT2ZpzMfPaRIf9AeK44=; b=AN
	EewrSiHMHHUo25DD+g8E0duZ2SgHBA160hLBgjZbKXv7kWtDuyjhesyXqR6SG9V6
	KF17Uye+sPhtQj5Ksuf9yqlAhO+UMrQFjb0FrBkOT/r1s5OBcxVMiU9kVIsBpULx
	urw5wE+o2WTUeKSu9Pohiw4SC5uBHfZnGYXbaMNkaUi3p20Z3q1c9eEWFNfxo/Gv
	qzwEjY2Fx1Fqu7s1/BDrVH43YceG5Y9VvGCdxqnF80PFoWEQKOULGnxKzX3jPP1y
	Dr3r2FsiTANkdCSTpVHzxsyRR4+QXu4mnJB06tti9i+HOfiGhPbZ5CXWwkJh0fWV
	N1V9hxZnDeBFeFRppDYw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9u9g8c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 18:26:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409IQGG5000881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 18:26:16 GMT
Received: from [10.110.0.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 10:26:14 -0800
Message-ID: <9a2b1929-bd01-4d40-89ca-6785d1b9367a@quicinc.com>
Date: Tue, 9 Jan 2024 10:26:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gpu: drm: panel: panel-simple: add new display
 mode for waveshare 7inch touchscreen panel
Content-Language: en-US
To: Shengyang Chen <shengyang.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: <neil.armstrong@linaro.org>, <sam@ravnborg.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <wahrenst@gmx.net>, <dave.stevenson@raspberrypi.com>,
        <thierry.reding@gmail.com>, <changhuang.liang@starfivetech.com>,
        <keith.zhao@starfivetech.com>, <jack.zhu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <20240109070949.23957-3-shengyang.chen@starfivetech.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240109070949.23957-3-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M5iCFI5QdTntp2jPrxNmP6Hs95qU9uNm
X-Proofpoint-ORIG-GUID: M5iCFI5QdTntp2jPrxNmP6Hs95qU9uNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090148



On 1/8/2024 11:09 PM, Shengyang Chen wrote:
> The waveshare 7" 800x480 panel is a clone of Raspberry Pi 7" 800x480 panel
> It also uses a Toshiba TC358762 DSI to DPI bridge chip but it needs different
> timing from Raspberry Pi panel. Add new timing for it.

Hi Shengyang,

The patch itself LGTM, but in case you have to put out a new revision, 
can you please use the "drm/panel: <driver name>:" prefix format that 
other drm/panel commits use?

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> 
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9367a4572dcf..e0896873ea33 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -4110,6 +4110,31 @@ static const struct panel_desc vl050_8048nt_c01 = {
>   	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>   };
>   
> +static const struct drm_display_mode waveshare_7inch_mode = {
> +	.clock = 29700000 / 1000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 90,
> +	.hsync_end = 800 + 90 + 5,
> +	.htotal = 800 + 90 + 5 + 5,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 60,
> +	.vsync_end = 480 + 60 + 5,
> +	.vtotal = 480 + 60 + 5 + 5,
> +	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
> +static const struct panel_desc waveshare_7inch = {
> +	.modes = &waveshare_7inch_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.connector_type = DRM_MODE_CONNECTOR_DSI,
> +};
> +
>   static const struct drm_display_mode winstar_wf35ltiacd_mode = {
>   	.clock = 6410,
>   	.hdisplay = 320,
> @@ -4592,6 +4617,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "vxt,vl050-8048nt-c01",
>   		.data = &vl050_8048nt_c01,
> +	}, {
> +		.compatible = "waveshare,7inch-touchscreen",
> +		.data = &waveshare_7inch,
>   	}, {
>   		.compatible = "winstar,wf35ltiacd",
>   		.data = &winstar_wf35ltiacd,
> -- 
> 2.17.1
> 

