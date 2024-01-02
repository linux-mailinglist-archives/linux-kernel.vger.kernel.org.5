Return-Path: <linux-kernel+bounces-14815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4E8222C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197C01F22C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632716431;
	Tue,  2 Jan 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gbjTlTiK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036421641A;
	Tue,  2 Jan 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 402IBch4007301;
	Tue, 2 Jan 2024 20:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NUPBWwzrWce/11pJJZOMDE/OxoFWKfvmYb5nB8VG/44=; b=gb
	jTlTiKCzC1UJb+S2jxGNbrQ1GDG30RaG1WyDn3YP7ahAuZMCl5GZ7ibbYnN3P+2k
	RUL98emA5GMMzbh/PbZ1yj+kWVBvtrCrYRKz9UGZqeeyP1s+ie3Mu+XMx4Em/XxO
	mFoK77zV7Ia1dds7mVKAnxP+KgMa+4l3C2tXqO2bTwoyy+WHc1A6APyw9q6FPdwq
	zCUYDvaFudWucTwuFXn3gAP7Fzs/K5XZgODjkaYQi0kDDXYA6428Om46imCIJqGU
	p5WCQv0JI52ond5ZQEPpdSJgXsk6L84Orr3eBg+v6Ge+REsFegzHyEt7G12KYlLW
	VqRW+03vqZSqCcGBG8TQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcets9dfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 20:58:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402KwXPC002559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 20:58:33 GMT
Received: from [10.110.68.103] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 12:58:31 -0800
Message-ID: <996dacdd-428a-4098-a0de-d4a12662d302@quicinc.com>
Date: Tue, 2 Jan 2024 12:58:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH
 for lsl080al02
Content-Language: en-US
To: Artur Weber <aweber.kernel@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
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
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
 <20240101-tab3-display-fixes-v1-2-887ba4dbd16b@gmail.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240101-tab3-display-fixes-v1-2-887ba4dbd16b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WO5dtklJ8Xgb6m4_0rfjLf1Gmaw4sT5S
X-Proofpoint-GUID: WO5dtklJ8Xgb6m4_0rfjLf1Gmaw4sT5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020155



On 1/1/2024 1:00 PM, Artur Weber wrote:
> It turns out that I had misconfigured the device I was using the panel
> with; the bus data polarity is not high for this panel, I had to change
> the config on the display controller's side.
> 
> Fix the panel config to properly reflect its accurate settings.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Hi Artur,

With Henrik's suggestion to add the Fixes tag,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index ea5a85779382..f23d8832a1ad 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -309,7 +309,7 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
>   	.off_func = s6d7aa0_lsl080al02_off,
>   	.drm_mode = &s6d7aa0_lsl080al02_mode,
>   	.mode_flags = MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_NO_HFP,
> -	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.bus_flags = 0,
>   
>   	.has_backlight = false,
>   	.use_passwd3 = false,
> 
> -- 
> 2.43.0
> 

