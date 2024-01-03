Return-Path: <linux-kernel+bounces-15805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1642823343
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC432285EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE971C2A3;
	Wed,  3 Jan 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cufe6aeb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B11C28F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403HEg6q029573;
	Wed, 3 Jan 2024 17:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iNyDOO6fcu45aS2coWmJOrK5JYb9OU9o38pwJhq+dl0=; b=Cu
	fe6aebg+p8X3Lhh6dbN9awFn4ZqA7ratehLzyulnrlqkXLy9BMAFF7N39JS9IDQs
	xH9Nk3uswpu8UASnYQiOPwlPpDvHOiSyTZ7BGs3DLVbzI/03La/CLc9Omg9mpSbf
	mUKOE+2ZxVwIXcXxqkqCMlYpA0yMPYRTInQoshJ1jTwNIAJO4W+NBIMmqnvGU2aD
	XJYGW3VbacgywUXF4gSQ1fLb6FkIVlmDiYQQoRA+3x9V1LeRwmf4YquKPjmFVjg6
	IvtRB2T8q7bGuh3XSFmlvFHEPNBOo4XiD6YpSws+OSnXS3mkhJTxAIqq1ZaLr9Fx
	otW3rm/j+9lyFIZd2ELg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd27yhk0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 17:32:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403HWDGj005686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 17:32:13 GMT
Received: from [10.110.68.103] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 09:32:12 -0800
Message-ID: <d4950cd8-b930-4ea0-84ce-916a8c049f13@quicinc.com>
Date: Wed, 3 Jan 2024 09:32:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v2] drm/panel: Simplify with dev_err_probe()
Content-Language: en-US
To: <chenguanxi11234@163.com>, <hanxu5@huaqin.corp-partner.google.com>
CC: <cgel.zte@gmail.com>, <neil.armstrong@linaro.org>, <sam@ravnborg.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yang.guang5@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
        Chen Haonan
	<chen.haonan2@zte.com.cn>
References: <3ac20d355b0b3ad3cedb87c8f4efa819a055624b.1702967834.git.chen.haonan2@zte.com.cn>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <3ac20d355b0b3ad3cedb87c8f4efa819a055624b.1702967834.git.chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rRwv03f6T8IxMmJ6T3GvnBC0yEXsX8U5
X-Proofpoint-ORIG-GUID: rRwv03f6T8IxMmJ6T3GvnBC0yEXsX8U5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030142



On 12/25/2023 6:26 AM, chenguanxi11234@163.com wrote:
> From: Chen Haonan <chen.haonan2@zte.com.cn>
> 
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-boe-himax8279d.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
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
> 

