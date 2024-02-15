Return-Path: <linux-kernel+bounces-67312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49EF85699A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B55E292814
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEB135419;
	Thu, 15 Feb 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Awe7U2hz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160D131E56;
	Thu, 15 Feb 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014669; cv=none; b=M3oE6sowOZ08k0f+WCycDolbZPOa9v5Sn5Tdol6EeIFOdbC8/dNpGmpQbKoRx0lqi9pO9GriGl77WPcuCMEYxQrVNNtS8vEjt+uvHLyH8nmAu4vnUk/xrmtamSS7ahzGFqyI8/wUBorTDbr2PDhfI9VcMMrqbjlzm7e8RpN8fOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014669; c=relaxed/simple;
	bh=z4ELZcom6+D3ZpA7axk9YIyGM84hcV7kqm6ACYOdTeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItA3X8A/ZPEH6b/LpUjPBW7p0CmZeoNvQvQlwMbzRKOP/RTHHwEBwOAT7l9tbOjwVidg/0kGFmiupHBGM6sk9poO026DfHUtnFIAlrzTd3jornNQO3ogWNIw4f132qw9DgfEUomspHeSKAaFne+cUagM7RxzUyjH8RRBZwFP6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Awe7U2hz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FG4xOX016707;
	Thu, 15 Feb 2024 16:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1+fPlBMNGxGtSyJRuRNoVCHqvex/12vd4Nel4vBMG/s=; b=Aw
	e7U2hzwaxHEVta2DSISmeBhn6aJSrD6TST+TrLQ7J6nfktMLZOeKaNy96ei6s5MX
	8s+w76UTmt8zVhxUP8leAP9fQZ7JmEV/SKc1wgDjWzDuh1YtsvrNRtkNiYaIVeRE
	gX3eHvgSD1F6d/PwXhfDf9GO+HoVEgfxVB8PNzNXs/Zc5g7u93ZmPymp5uv69bOp
	Cz5ctDd+XgCVEOdokzPhv6a34CJy6sSl1uQFF65Hk4aC7LTzJukhYA37Hzv3nk1y
	DfcBmNZ4YPEm+h3jGZ1qS4HJuP2MVKb+3Z4w23jwsYySEEM+ekUailotegzg5N0s
	sNgnlNC14I9t2DFErnDg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9342jguw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:30:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41FGUd0I005146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:30:40 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 08:30:39 -0800
Message-ID: <aa76bbac-2f92-4c92-b78a-440a48ebfd4f@quicinc.com>
Date: Thu, 15 Feb 2024 08:30:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panel: ltk500hd1829: add panel type for
 ltk101b4029w
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, <neil.armstrong@linaro.org>
CC: <sam@ravnborg.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quentin.schulz@theobroma-systems.com>,
        Heiko
 Stuebner <heiko.stuebner@cherry.de>
References: <20240215090515.3513817-1-heiko@sntech.de>
 <20240215090515.3513817-4-heiko@sntech.de>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240215090515.3513817-4-heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Rp6xcP08FMw69iGhsqisVqKcRu-EGhZ
X-Proofpoint-GUID: 1Rp6xcP08FMw69iGhsqisVqKcRu-EGhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150132



On 2/15/2024 1:05 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The ltk101b4029w ist a 10.1 inch DSI panel and shares the same supplies
> and startup timings with the existing ltk500hd1829.
> 
> So simply add it as a variant with its own init sequence and display-mode.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Hi Heiko,

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   .../drm/panel/panel-leadtek-ltk500hd1829.c    | 196 ++++++++++++++++++
>   1 file changed, 196 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> index 42f4e2584af18..7bc538b7c6b7c 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
> @@ -43,6 +43,198 @@ struct ltk500hd1829 {
>   	bool prepared;
>   };
>   
> +static const struct ltk500hd1829_cmd ltk101b4029w_init[] = {
> +	/* Page0 */
> +	{ 0xE0, 0x00 },
> +	/* PASSWORD */
> +	{ 0xE1, 0x93 },
> +	{ 0xE2, 0x65 },
> +	{ 0xE3, 0xF8 },
> +	{ 0x80, 0x03 }, /* 0X03:4-LANE; 0X02:3-LANE; 0X01:2-LANE */
> +	/* Page1 */
> +	{ 0xE0, 0x01 },
> +	/* Set VCOM */
> +	{ 0x00, 0x00 },
> +	{ 0x01, 0x6F },
> +	/* Set Gamma Power, VGMP,VGMN,VGSP,VGSN */
> +	{ 0x17, 0x00 },
> +	{ 0x18, 0xAF }, /* 4.3V */
> +	{ 0x19, 0x01 }, /* 0.3V */
> +	{ 0x1A, 0x00 },
> +	{ 0x1B, 0xAF }, /* 4.3V */
> +	{ 0x1C, 0x01 }, /* 0.3V */
> +	/* Set Gate Power */
> +	{ 0x1F, 0x3E }, /* VGH_R  = 15V */
> +	{ 0x20, 0x28 }, /* VGL_R  = -12V */
> +	{ 0x21, 0x28 }, /* VGL_R2 = -12V */
> +	{ 0x22, 0x7E },
> +	/* SETPANEL */
> +	{ 0x35, 0x26 },
> +	{ 0x37, 0x09 },
> +	/* SET RGBCYC */
> +	{ 0x38, 0x04 },
> +	{ 0x39, 0x00 },
> +	{ 0x3A, 0x01 },
> +	{ 0x3C, 0x7C },
> +	{ 0x3D, 0xFF },
> +	{ 0x3E, 0xFF },
> +	{ 0x3F, 0x7F },
> +	/* Set TCON */
> +	{ 0x40, 0x06 }, /* RSO = 800 RGB */
> +	{ 0x41, 0xA0 }, /* LN = 640->1280 line */
> +	{ 0x42, 0x81 },
> +	{ 0x43, 0x08 }, /* VFP = 8 */
> +	{ 0x44, 0x0B }, /* VBP = 12 */
> +	{ 0x45, 0x28 }, /* HBP = 40 */
> +	/* power voltage */
> +	{ 0x55, 0x0F }, /* DCDCM = 0001, JD PWR_IC */
> +	{ 0x57, 0x69 },
> +	{ 0x59, 0x0A }, /* VCL = -2.9V */
> +	{ 0x5A, 0x28 }, /* VGH = 15V */
> +	{ 0x5B, 0x14 }, /* VGL = -11V */
> +	/* Gamma */
> +	{ 0x5D, 0x7C },
> +	{ 0x5E, 0x65 },
> +	{ 0x5F, 0x55 },
> +	{ 0x60, 0x47 },
> +	{ 0x61, 0x43 },
> +	{ 0x62, 0x32 },
> +	{ 0x63, 0x34 },
> +	{ 0x64, 0x1C },
> +	{ 0x65, 0x33 },
> +	{ 0x66, 0x31 },
> +	{ 0x67, 0x30 },
> +	{ 0x68, 0x4E },
> +	{ 0x69, 0x3C },
> +	{ 0x6A, 0x44 },
> +	{ 0x6B, 0x35 },
> +	{ 0x6C, 0x31 },
> +	{ 0x6D, 0x23 },
> +	{ 0x6E, 0x11 },
> +	{ 0x6F, 0x00 },
> +	{ 0x70, 0x7C },
> +	{ 0x71, 0x65 },
> +	{ 0x72, 0x55 },
> +	{ 0x73, 0x47 },
> +	{ 0x74, 0x43 },
> +	{ 0x75, 0x32 },
> +	{ 0x76, 0x34 },
> +	{ 0x77, 0x1C },
> +	{ 0x78, 0x33 },
> +	{ 0x79, 0x31 },
> +	{ 0x7A, 0x30 },
> +	{ 0x7B, 0x4E },
> +	{ 0x7C, 0x3C },
> +	{ 0x7D, 0x44 },
> +	{ 0x7E, 0x35 },
> +	{ 0x7F, 0x31 },
> +	{ 0x80, 0x23 },
> +	{ 0x81, 0x11 },
> +	{ 0x82, 0x00 },
> +	 /* Page2, for GIP */
> +	{ 0xE0, 0x02 },
> +	/* GIP_L Pin mapping */
> +	{ 0x00, 0x1E },
> +	{ 0x01, 0x1E },
> +	{ 0x02, 0x41 },
> +	{ 0x03, 0x41 },
> +	{ 0x04, 0x43 },
> +	{ 0x05, 0x43 },
> +	{ 0x06, 0x1F },
> +	{ 0x07, 0x1F },
> +	{ 0x08, 0x35 },
> +	{ 0x09, 0x1F },
> +	{ 0x0A, 0x15 },
> +	{ 0x0B, 0x15 },
> +	{ 0x0C, 0x1F },
> +	{ 0x0D, 0x47 },
> +	{ 0x0E, 0x47 },
> +	{ 0x0F, 0x45 },
> +	{ 0x10, 0x45 },
> +	{ 0x11, 0x4B },
> +	{ 0x12, 0x4B },
> +	{ 0x13, 0x49 },
> +	{ 0x14, 0x49 },
> +	{ 0x15, 0x1F },
> +	/* GIP_R Pin mapping */
> +	{ 0x16, 0x1E },
> +	{ 0x17, 0x1E },
> +	{ 0x18, 0x40 },
> +	{ 0x19, 0x40 },
> +	{ 0x1A, 0x42 },
> +	{ 0x1B, 0x42 },
> +	{ 0x1C, 0x1F },
> +	{ 0x1D, 0x1F },
> +	{ 0x1E, 0x35 },
> +	{ 0x1F, 0x1F },
> +	{ 0x20, 0x15 },
> +	{ 0x21, 0x15 },
> +	{ 0x22, 0x1f },
> +	{ 0x23, 0x46 },
> +	{ 0x24, 0x46 },
> +	{ 0x25, 0x44 },
> +	{ 0x26, 0x44 },
> +	{ 0x27, 0x4A },
> +	{ 0x28, 0x4A },
> +	{ 0x29, 0x48 },
> +	{ 0x2A, 0x48 },
> +	{ 0x2B, 0x1F },
> +	/* GIP Timing */
> +	{ 0x58, 0x40 },
> +	{ 0x5B, 0x30 },
> +	{ 0x5C, 0x03 },
> +	{ 0x5D, 0x30 },
> +	{ 0x5E, 0x01 },
> +	{ 0x5F, 0x02 },
> +	{ 0x63, 0x14 },
> +	{ 0x64, 0x6A },
> +	{ 0x67, 0x73 },
> +	{ 0x68, 0x05 },
> +	{ 0x69, 0x14 },
> +	{ 0x6A, 0x6A },
> +	{ 0x6B, 0x08 },
> +	{ 0x6C, 0x00 },
> +	{ 0x6D, 0x00 },
> +	{ 0x6E, 0x00 },
> +	{ 0x6F, 0x88 },
> +	{ 0x77, 0xDD },
> +	{ 0x79, 0x0E },
> +	{ 0x7A, 0x03 },
> +	{ 0x7D, 0x14 },
> +	{ 0x7E, 0x6A },
> +	/* Page4 */
> +	{ 0xE0, 0x04 },
> +	{ 0x09, 0x11 },
> +	{ 0x0E, 0x48 },
> +	{ 0x2B, 0x2B },
> +	{ 0x2D, 0x03 },
> +	{ 0x2E, 0x44 },
> +	/* Page0 */
> +	{ 0xE0, 0x00 },
> +	{ 0xE6, 0x02 },
> +	{ 0xE7, 0x0C },
> +};
> +
> +static const struct drm_display_mode ltk101b4029w_mode = {
> +	.hdisplay	= 800,
> +	.hsync_start	= 800 + 18,
> +	.hsync_end	= 800 + 18 + 18,
> +	.htotal		= 800 + 18 + 18 + 18,
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 24,
> +	.vsync_end	= 1280 + 24 + 4,
> +	.vtotal		= 1280 + 24 + 4 + 8,
> +	.clock		= 67330,
> +	.width_mm	= 136,
> +	.height_mm	= 218,
> +};
> +
> +static const struct ltk500hd1829_desc ltk101b4029w_data = {
> +	.mode = &ltk101b4029w_mode,
> +	.init = ltk101b4029w_init,
> +	.num_init = ARRAY_SIZE(ltk101b4029w_init),
> +};
> +
>   /*
>    * There is no description in the Reference Manual about these commands.
>    * We received them from the vendor, so just use them as is.
> @@ -510,6 +702,10 @@ static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id ltk500hd1829_of_match[] = {
> +	{
> +		.compatible = "leadtek,ltk101b4029w",
> +		.data = &ltk101b4029w_data,
> +	},
>   	{
>   		.compatible = "leadtek,ltk500hd1829",
>   		.data = &ltk500hd1829_data,
> -- 
> 2.39.2
> 

