Return-Path: <linux-kernel+bounces-67306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43C856982
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E22EB237D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F43134CC0;
	Thu, 15 Feb 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QazWVB4P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C71134743;
	Thu, 15 Feb 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014355; cv=none; b=e0SpvyzPQ7wDvbR4sZyTm1uuIAV4yUAifqtwnWTtdl2yb7kuCyV1qnO+YU4URVONZBJ9srmvfrhf62bDeoDmTemY/GTubOmcsZ18iKCMrrUoSIrC6do7dlkogpdJZFB3rqhShSHsXK0okqAVj3C4ZhUV0s+YfcpM7UYiIupRORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014355; c=relaxed/simple;
	bh=VSAALJp4MFaIgFzqjLLc6BeLPyT7H5C4A+EO6BbIRzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rHQRTYfvc4XHIroqR7eQNLaNvxg2qxc3PdsuXKS9zuJwsqHxEgx4V/v1URbsSIsy12rIh6WHTicLaAMF+5Xgh8twv181EBuMmaMdIKDimr9r3hGWn3tDJrhxMud71EinChhEdDD2i9CZMUhYeyJGOVShOWF9HIXd+u5Xhd7pdDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QazWVB4P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FBfcDE002449;
	Thu, 15 Feb 2024 16:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2Z2TB9HMc/XqBevRu67UWw4yo4bEz0HNufbBYufQook=; b=Qa
	zWVB4Plwn5QYzPoDSce+5P7tJRoq5Rs9A5yqLbnNwDN68bwyHOi6PGQDEhfBrAWv
	9cZBYHLdek4zigR4bB653tZmodepZShH8afgaS/2aksdm/Te3Zg/GWK/280tpIYu
	MyI7qCT6GAXI/xse+IUPUMBkD1rwhVZJCvPkZnnlDgmD24xRLGUQMKFhQARTRjDZ
	+R7Hh+q5P1eZBa8iKbrD/9T9w4Nahp5h+n8ui+2v1z93O8eUjfN6x8r6NxvCp7V/
	IuK4VpDJcilPAdwttIUVni8BEmvuD3oD/mSQLYUy4GoLGTpdEuEPNXxgcN3vPEwF
	G76wS9sOiYzeryssWFTA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9bfs1m9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:25:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FGPToN023623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:25:29 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 08:25:29 -0800
Message-ID: <74b6c3dc-6add-414c-8056-3dcb94b12cd7@quicinc.com>
Date: Thu, 15 Feb 2024 08:25:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panel: ltk500hd1829: make room for more similar
 panels
To: Heiko Stuebner <heiko@sntech.de>, <neil.armstrong@linaro.org>
CC: <sam@ravnborg.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quentin.schulz@theobroma-systems.com>,
        Heiko
 Stuebner <heiko.stuebner@cherry.de>
References: <20240215090515.3513817-1-heiko@sntech.de>
 <20240215090515.3513817-2-heiko@sntech.de>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240215090515.3513817-2-heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LZfVm8segKP6sX68vyDuaTOJKWkKYxEo
X-Proofpoint-GUID: LZfVm8segKP6sX68vyDuaTOJKWkKYxEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150133



On 2/15/2024 1:05 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> There exist more dsi-panels from Leadtek sharing supplies and timings
> with only the panel-mode and init commands differing.
> 
> So make room in the driver to also keep variants here instead of
> requiring additional drivers per panel.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Hi Heiko,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   .../drm/panel/panel-leadtek-ltk500hd1829.c    | 73 ++++++++++++-------
>   1 file changed, 47 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> index 39e408c9f762f..42f4e2584af18 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> @@ -11,6 +11,7 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include <video/mipi_display.h>
> @@ -21,25 +22,32 @@
>   #include <drm/drm_modes.h>
>   #include <drm/drm_panel.h>
>   
> +struct ltk500hd1829_cmd {
> +	char cmd;
> +	char data;
> +};
> +
> +struct ltk500hd1829_desc {
> +	const struct drm_display_mode *mode;
> +	const struct ltk500hd1829_cmd *init;
> +	unsigned int num_init;
> +};
> +
>   struct ltk500hd1829 {
>   	struct device *dev;
>   	struct drm_panel panel;
>   	struct gpio_desc *reset_gpio;
>   	struct regulator *vcc;
>   	struct regulator *iovcc;
> +	const struct ltk500hd1829_desc *panel_desc;
>   	bool prepared;
>   };
>   
> -struct ltk500hd1829_cmd {
> -	char cmd;
> -	char data;
> -};
> -
>   /*
>    * There is no description in the Reference Manual about these commands.
>    * We received them from the vendor, so just use them as is.
>    */
> -static const struct ltk500hd1829_cmd init_code[] = {
> +static const struct ltk500hd1829_cmd ltk500hd1829_init[] = {
>   	{ 0xE0, 0x00 },
>   	{ 0xE1, 0x93 },
>   	{ 0xE2, 0x65 },
> @@ -260,6 +268,26 @@ static const struct ltk500hd1829_cmd init_code[] = {
>   	{ 0x35, 0x00 },
>   };
>   
> +static const struct drm_display_mode ltk500hd1829_mode = {
> +	.hdisplay	= 720,
> +	.hsync_start	= 720 + 50,
> +	.hsync_end	= 720 + 50 + 50,
> +	.htotal		= 720 + 50 + 50 + 50,
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 30,
> +	.vsync_end	= 1280 + 30 + 4,
> +	.vtotal		= 1280 + 30 + 4 + 12,
> +	.clock		= 69217,
> +	.width_mm	= 62,
> +	.height_mm	= 110,
> +};
> +
> +static const struct ltk500hd1829_desc ltk500hd1829_data = {
> +	.mode = &ltk500hd1829_mode,
> +	.init = ltk500hd1829_init,
> +	.num_init = ARRAY_SIZE(ltk500hd1829_init),
> +};
> +
>   static inline
>   struct ltk500hd1829 *panel_to_ltk500hd1829(struct drm_panel *panel)
>   {
> @@ -324,8 +352,8 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
>   	/* tRT: >= 5ms */
>   	usleep_range(5000, 6000);
>   
> -	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
> -		ret = mipi_dsi_generic_write(dsi, &init_code[i],
> +	for (i = 0; i < ctx->panel_desc->num_init; i++) {
> +		ret = mipi_dsi_generic_write(dsi, &ctx->panel_desc->init[i],
>   					     sizeof(struct ltk500hd1829_cmd));
>   		if (ret < 0) {
>   			dev_err(panel->dev, "failed to write init cmds: %d\n", ret);
> @@ -359,31 +387,17 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
>   	return ret;
>   }
>   
> -static const struct drm_display_mode default_mode = {
> -	.hdisplay	= 720,
> -	.hsync_start	= 720 + 50,
> -	.hsync_end	= 720 + 50 + 50,
> -	.htotal		= 720 + 50 + 50 + 50,
> -	.vdisplay	= 1280,
> -	.vsync_start	= 1280 + 30,
> -	.vsync_end	= 1280 + 30 + 4,
> -	.vtotal		= 1280 + 30 + 4 + 12,
> -	.clock		= 69217,
> -	.width_mm	= 62,
> -	.height_mm	= 110,
> -};
> -
>   static int ltk500hd1829_get_modes(struct drm_panel *panel,
>   				  struct drm_connector *connector)
>   {
>   	struct ltk500hd1829 *ctx = panel_to_ltk500hd1829(panel);
>   	struct drm_display_mode *mode;
>   
> -	mode = drm_mode_duplicate(connector->dev, &default_mode);
> +	mode = drm_mode_duplicate(connector->dev, ctx->panel_desc->mode);
>   	if (!mode) {
>   		dev_err(ctx->dev, "failed to add mode %ux%u@%u\n",
> -			default_mode.hdisplay, default_mode.vdisplay,
> -			drm_mode_vrefresh(&default_mode));
> +			ctx->panel_desc->mode->hdisplay, ctx->panel_desc->mode->vdisplay,
> +			drm_mode_vrefresh(ctx->panel_desc->mode));
>   		return -ENOMEM;
>   	}
>   
> @@ -413,6 +427,10 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
>   	if (!ctx)
>   		return -ENOMEM;
>   
> +	ctx->panel_desc = of_device_get_match_data(dev);
> +	if (!ctx->panel_desc)
> +		return -EINVAL;
> +
>   	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(ctx->reset_gpio)) {
>   		dev_err(dev, "cannot get reset gpio\n");
> @@ -492,7 +510,10 @@ static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id ltk500hd1829_of_match[] = {
> -	{ .compatible = "leadtek,ltk500hd1829", },
> +	{
> +		.compatible = "leadtek,ltk500hd1829",
> +		.data = &ltk500hd1829_data,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, ltk500hd1829_of_match);
> -- 
> 2.39.2
> 

