Return-Path: <linux-kernel+bounces-7426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3C081A7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89383283212
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAA48CEA;
	Wed, 20 Dec 2023 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XA7YOmw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32948CC9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKKkIaf022527;
	Wed, 20 Dec 2023 20:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FzeRGjQx/fY0YT5VrAkIf5yvGf+ZU72nLHj+ptlaO5Y=; b=XA
	7YOmw/q3BSD6hxqFs0IcaJkGxR5MHVyI3uXw94ElpG6HlVxMmZSqpTEFHAWblAwq
	4B+oe7sEFNi87oJFHDfkkBeJcBUffCK59e8z67UKlbC4cPQXZrGn9FVZo2efg6Pt
	NWbyBkGYxScQMWL/ZMgQNhjeMQ9dENMKelfIpz1T+xJjFfHIaa4GFOlMqhVt8i8S
	SABrCMZfmkcsMSz6Qfb+Abw6XjAS4FlD9ySNSKCQGHn8efPJI6Kxk8VPm8Qd8YID
	a1bB/a+A8wwdsC03sG0diZBxbj/SllPyeWCI8gWkHWWj3QXSZHrbQGRRlx0h85Br
	Pp4Ldo4mGt8hpPEDdtdg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxvv4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:55:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKKtPCT001957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:55:25 GMT
Received: from [10.110.87.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 12:55:23 -0800
Message-ID: <6e83caa5-4648-4ab4-b825-3c1f964aa113@quicinc.com>
Date: Wed, 20 Dec 2023 12:55:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] drm/panel: Simplify with dev_err_probe()
To: <yang.guang5@zte.com.cn>, <hanxu5@huaqin.corp-partner.google.com>
CC: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <neil.armstrong@linaro.org>, <sam@ravnborg.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <202312201048538333616@zte.com.cn>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <202312201048538333616@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YYIAfmd5pcsoPzjhtPdEUeylxuFrAumm
X-Proofpoint-GUID: YYIAfmd5pcsoPzjhtPdEUeylxuFrAumm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200148



On 12/19/2023 6:48 PM, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-boe-himax8279d.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> index 11b64acbe8a9..e225840b0d67 100644
> --- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> +++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
> @@ -854,26 +854,20 @@ static int panel_add(struct panel_info *pinfo)
> 
>   	pinfo->pp18_gpio = devm_gpiod_get(dev, "pp18", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->pp18_gpio)) {
> -		ret = PTR_ERR(pinfo->pp18_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pp18 gpio: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(pinfo->pp18_gpio),
> +							 "failed to get pp18 gpio\n");
>   	}
> 
>   	pinfo->pp33_gpio = devm_gpiod_get(dev, "pp33", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->pp33_gpio)) {
> -		ret = PTR_ERR(pinfo->pp33_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get pp33 gpio: %d\n", ret);
> -		return ret;
> +		return	dev_err_probe(dev, PTR_ERR(pinfo->pp33_gpio),
> +							 "failed to get pp33 gpio\n");
>   	}
> 
>   	pinfo->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
>   	if (IS_ERR(pinfo->enable_gpio)) {
> -		ret = PTR_ERR(pinfo->enable_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get enable gpio: %d\n", ret);
> -		return ret;
> +		return	dev_err_probe(dev, PTR_ERR(pinfo->enable_gpio),
> +						 "failed to get enable gpio\n");
>   	}
> 
>   	drm_panel_init(&pinfo->base, dev, &panel_funcs,
> -- 
> 2.25.1

