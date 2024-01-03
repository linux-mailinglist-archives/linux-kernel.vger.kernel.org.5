Return-Path: <linux-kernel+bounces-15809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C3823374
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DB3B2468B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D2B1CAA0;
	Wed,  3 Jan 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QohP9BY+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFF1CA80
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403C64W3004725;
	Wed, 3 Jan 2024 17:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tV5nWE9aGzQC716rDi1vI5QF6EUxio6crnQ8dPB1FpQ=; b=Qo
	hP9BY+uPb7d2eU4hVIRfM2ozKiFT6j5bWIGVbCuJkx0BL5baYaC49NJGyQI9BmaP
	rwjTJ+GAEkUuob79QU6I+gi2ARDKDBz5nJywK6Gd4J+rsT5loJ6Fl2xsgHh60EZl
	+u/9x2Zylnle7uFln4N8zAM45eW0GTuq5zSb6t3aQQ8Np0aaRoajbRnI926G9Vb/
	6QZc66jI1D4CP6IpruaxMoRcYuahC55Xt+InIHCMxXdVCXkXVumR5FebXa7HVdiD
	Ih2ySDNAM8vrLTCN0o539FBj6H7lxjK8gIWB9Q1wT4IsS51o8ehDRTs0VsUWDCtL
	TZIePtU/hNf+bdrV5e1g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd37y9equ-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 17:37:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403HbKeu011254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 17:37:20 GMT
Received: from [10.110.68.103] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 09:37:19 -0800
Message-ID: <f7354b0a-9199-425a-8146-9de97cbeffea@quicinc.com>
Date: Wed, 3 Jan 2024 09:37:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] drm/panel: samsung: Simplify with
 dev_err_probe()
Content-Language: en-US
To: <chenguanxi11234@163.com>, <neil.armstrong@linaro.org>
CC: <cgel.zte@gmail.com>, <linux-kernel@vger.kernel.org>, <mripard@kernel.org>,
        Chen Haonan <chen.haonan2@zte.com.cn>, <yang.guang5@zte.com.cn>,
        <dri-devel@lists.freedesktop.org>, <tzimmermann@suse.de>,
        <sam@ravnborg.org>
References: <061ed94a003362bb7d7e9d3e4d38358c5b91c8a3.1704186827.git.chen.haonan2@zte.com.cn>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <061ed94a003362bb7d7e9d3e4d38358c5b91c8a3.1704186827.git.chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LXeUonfwL3tnYDd-1FgnfB-oA1mMO_Cy
X-Proofpoint-ORIG-GUID: LXeUonfwL3tnYDd-1FgnfB-oA1mMO_Cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030143



On 1/3/2024 6:17 AM, chenguanxi11234@163.com wrote:
> From: Chen Haonan <chen.haonan2@zte.com.cn>
> 
> dev_err_probe() can check if the error code is -EPROBE_DEFER
> and can return the error code, replacing dev_err() with it
> simplifies the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index 79f611963c61..f4103e762b53 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -194,10 +194,8 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
>   	s6->reset_gpio = devm_gpiod_get_optional(dev, "reset",
>   						GPIOD_OUT_HIGH);
>   	if (IS_ERR(s6->reset_gpio)) {
> -		ret = PTR_ERR(s6->reset_gpio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to request GPIO (%d)\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, PTR_ERR(s6->reset_gpio),
> +							 "failed to request GPIO\n");
>   	}
>   
>   	drm_panel_init(&s6->panel, dev, &s6d16d0_drm_funcs,
> -- 
> 2.25.1
> 

