Return-Path: <linux-kernel+bounces-55365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9884BBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448421C231A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334868F7A;
	Tue,  6 Feb 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSLEkObC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEEDD51D;
	Tue,  6 Feb 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240292; cv=none; b=HZdOXb9YPOVAZTMob4UAUCJaAxS6TCLDaVoixfD6lw0iHMi4+qaaQjtT6TqmgDa80qS9kSJu+3gLqK/hgWXNodiQGo9WG4Oj71kJrpIUZ0Y9+MC1QHPFTdM+kxW03vCggYMgH1Fx9zs0itCpS6rNQYBXUq+sjE9l/7+8J7WV44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240292; c=relaxed/simple;
	bh=j3Tn8/Kkr0i2r65iRkK8WBXrJB1l8NjWShsHzzNI9qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E16DSDaK7cZgpcP086+gOvOJyCUt2ZJucRvi+PZjlz0FJH5no9QjZgBdfcomFSPP6P85DMyGSr3VFxgAZNJqz/VwnfTGaF0LMdEIsT6rDPAG9ILf3bQiy33w0ibdT03FWortDpmjBjwsjjOX5kHeDLxsGVeUrrAVuKm2ko8zkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gSLEkObC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416GvOR7021699;
	Tue, 6 Feb 2024 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qUdMIp4/x7DVpBklDSlXSlEvcCkzfd4ODDKt1vMjopA=; b=gS
	LEkObCK/ljULCVhGs7khz1urn1H4niuMlJkHiXTAze3T+3AMCkPdVonP2cA/9vU9
	XKoi5BA3mf1h/2l8OAn24Zd0INuW/HZd37nPhcJ+EkSQVgpIa4qRepw+ZWxQQT+M
	ii105pAGf2MMhUuKbjxFucTsd0UPGhT84GZ6EKlxKKrULkkPU1Ow0/yDCQ/+tSd6
	iUtHUHcdxI2dcJuIS3KDgnxhZcMlRdWaCiGTjthbQx9aUyTPCVbFwbGz/BfJBzz4
	XDseelA3DNUhtm4IqJtvCTizHvF2+utYZogr8oeWkzJ9Vdjzw7Z5SYc2K9sWQUGB
	Kgo2tVpkwMBqxUuLqugQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3hses1x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 17:24:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416HOTX9026207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 17:24:29 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 09:24:28 -0800
Message-ID: <80c8f6cf-5419-4c45-8e0f-f5eab7419df3@quicinc.com>
Date: Tue, 6 Feb 2024 09:24:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/panel: simple: fix flags on RK043FN48H
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20240205-ltdc_mp13-v1-0-072d24bf1b36@foss.st.com>
 <20240205-ltdc_mp13-v1-4-072d24bf1b36@foss.st.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240205-ltdc_mp13-v1-4-072d24bf1b36@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k-aQ9fJsYUBPQZfb54pb-fHgQXF3Xnp1
X-Proofpoint-GUID: k-aQ9fJsYUBPQZfb54pb-fHgQXF3Xnp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060122



On 2/5/2024 1:06 AM, Raphael Gallais-Pou wrote:
> DISPLAY_FLAGS_SYNC_POSEDGE is missing in the flags on the default
> timings. When overriding the default mode with one described in the
> device tree, the mode does not get acked because of this missing flag.
> Moreover since the panel is driven by the positive edge it makes sense
> to add it here.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Hi Raphael,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-simple.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 2214cb09678c..7b286382ffb4 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3523,7 +3523,8 @@ static const struct display_timing rocktech_rk043fn48h_timing = {
>   	.vfront_porch = { 1, 4, 4 },
>   	.vsync_len = { 1, 10, 10 },
>   	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW |
> -		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
>   };
>   
>   static const struct panel_desc rocktech_rk043fn48h = {
> 
> -- 
> 2.25.1
> 

