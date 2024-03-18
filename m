Return-Path: <linux-kernel+bounces-105832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7FB87E52C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6291C20D53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D428DC1;
	Mon, 18 Mar 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uWzEOytt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044C28E1B;
	Mon, 18 Mar 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751669; cv=none; b=Wb0pRYQW6fA8K6LKmK1NYh33/ZATS/Jq/8yj1bcIhjO17vEDCDz3EHfaMQ3mIhCOO5gFui2RHoeo9w3if+UrkW3wqOmXxIV07sMBidaIm7ZKa0FnQ68zUDjIdq/6yTldGoaUpUhIZLzBBagR8VZDVVINM3BDAKw0c6G1frtOBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751669; c=relaxed/simple;
	bh=M+nAJgZSbHlik3v29OC83Fa+Gmr9WGGqm5p13HBc6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z46CsDgzuCHeI8PWmbsWLnyXSKYt8htZ0jRV3rYaboMel01n/KkSfwDW7yCcnKoryDSztwWdazmLJeOCP2s8EwXkFGoljQpRaCZ9QXFjXOS4GNHU4XjIBz3PQNSYqr1P5kGfKneXDSCjAkqU+U60m9y6ozWuwsmMNCuHoM4N3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uWzEOytt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.rasen.tech (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 745F7CC;
	Mon, 18 Mar 2024 09:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710751639;
	bh=M+nAJgZSbHlik3v29OC83Fa+Gmr9WGGqm5p13HBc6PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWzEOyttmezRS4OYMkDvhaEOW6oIm0ByuXMlLm+F08YxFY+DFttNiV21tutoQXs7W
	 Ig7rgx3AMBdcgNZlwiJhRqZcV9sVaEMmOib2vWgIVF1QiT7TKeQ/sulJPL7zQEusSR
	 GIR3J/K8FHjlUbEcf2DABSwoDJVVXFlC/R/rNySU=
Date: Mon, 18 Mar 2024 17:47:35 +0900
From: Paul Elder <paul.elder@ideasonboard.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>,
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] media: rkisp1: Adapt to different SoCs having
 different size limits
Message-ID: <Zff_p_f39dwBATDB@pyrite.rasen.tech>
References: <20240315230245.1385902-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315230245.1385902-1-megi@xff.cz>

Hi Ondrej,

On Sat, Mar 16, 2024 at 12:02:41AM +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> - RK3399 has input/output limit of main path 4416 x 3312
> - PX30 has input/output limit of main path 3264 x 2448
> - i.MX8MP has input/output limit of main path 4096 x 3072
> 
> Use rkisp1_info struct to encode the limits.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Looks good to me.

Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>

> ---
> v2:
> - adapt to i.MX8MP merged for v6.9
> 
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h  | 6 ++++--
>  drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c     | 5 +++--
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c     | 6 ++++++
>  drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c     | 9 +++++----
>  drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c | 4 ++--
>  5 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 26573f6ae575..b4c958b93629 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -34,8 +34,6 @@ struct regmap;
>  #define RKISP1_ISP_SD_SINK			BIT(1)
>  
>  /* min and max values for the widths and heights of the entities */
> -#define RKISP1_ISP_MAX_WIDTH			4032
> -#define RKISP1_ISP_MAX_HEIGHT			3024
>  #define RKISP1_ISP_MIN_WIDTH			32
>  #define RKISP1_ISP_MIN_HEIGHT			32
>  
> @@ -140,6 +138,8 @@ enum rkisp1_feature {
>   * @isr_size: number of entries in the @isrs array
>   * @isp_ver: ISP version
>   * @features: bitmask of rkisp1_feature features implemented by the ISP
> + * @max_width: maximum input frame width
> + * @max_height: maximum input frame height
>   *
>   * This structure contains information about the ISP specific to a particular
>   * ISP model, version, or integration in a particular SoC.
> @@ -151,6 +151,8 @@ struct rkisp1_info {
>  	unsigned int isr_size;
>  	enum rkisp1_cif_isp_version isp_ver;
>  	unsigned int features;
> +	unsigned int max_width;
> +	unsigned int max_height;
>  };
>  
>  /*
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> index 4202642e0523..841e58c20f7f 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> @@ -307,6 +307,7 @@ static int rkisp1_csi_set_fmt(struct v4l2_subdev *sd,
>  			      struct v4l2_subdev_state *sd_state,
>  			      struct v4l2_subdev_format *fmt)
>  {
> +	struct rkisp1_csi *csi = to_rkisp1_csi(sd);
>  	const struct rkisp1_mbus_info *mbus_info;
>  	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
>  
> @@ -326,10 +327,10 @@ static int rkisp1_csi_set_fmt(struct v4l2_subdev *sd,
>  
>  	sink_fmt->width = clamp_t(u32, fmt->format.width,
>  				  RKISP1_ISP_MIN_WIDTH,
> -				  RKISP1_ISP_MAX_WIDTH);
> +				  csi->rkisp1->info->max_width);
>  	sink_fmt->height = clamp_t(u32, fmt->format.height,
>  				   RKISP1_ISP_MIN_HEIGHT,
> -				   RKISP1_ISP_MAX_HEIGHT);
> +				   csi->rkisp1->info->max_height);
>  
>  	fmt->format = *sink_fmt;
>  
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index bb0202386c70..0535ce57e862 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -510,6 +510,8 @@ static const struct rkisp1_info px30_isp_info = {
>  	.features = RKISP1_FEATURE_MIPI_CSI2
>  		  | RKISP1_FEATURE_SELF_PATH
>  		  | RKISP1_FEATURE_DUAL_CROP,
> +	.max_width = 3264,
> +	.max_height = 2448,
>  };
>  
>  static const char * const rk3399_isp_clks[] = {
> @@ -531,6 +533,8 @@ static const struct rkisp1_info rk3399_isp_info = {
>  	.features = RKISP1_FEATURE_MIPI_CSI2
>  		  | RKISP1_FEATURE_SELF_PATH
>  		  | RKISP1_FEATURE_DUAL_CROP,
> +	.max_width = 4416,
> +	.max_height = 3312,
>  };
>  
>  static const char * const imx8mp_isp_clks[] = {
> @@ -551,6 +555,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
>  	.isp_ver = RKISP1_V_IMX8MP,
>  	.features = RKISP1_FEATURE_MAIN_STRIDE
>  		  | RKISP1_FEATURE_DMA_34BIT,
> +	.max_width = 4096,
> +	.max_height = 3072,
>  };
>  
>  static const struct of_device_id rkisp1_of_match[] = {
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index e45a213baf49..f787a7e91e3e 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -517,6 +517,7 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
>  				      struct v4l2_subdev_state *sd_state,
>  				      struct v4l2_subdev_frame_size_enum *fse)
>  {
> +	struct rkisp1_isp *isp = to_rkisp1_isp(sd);
>  	const struct rkisp1_mbus_info *mbus_info;
>  
>  	if (fse->pad == RKISP1_ISP_PAD_SINK_PARAMS ||
> @@ -539,9 +540,9 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
>  		return -EINVAL;
>  
>  	fse->min_width = RKISP1_ISP_MIN_WIDTH;
> -	fse->max_width = RKISP1_ISP_MAX_WIDTH;
> +	fse->max_width = isp->rkisp1->info->max_width;
>  	fse->min_height = RKISP1_ISP_MIN_HEIGHT;
> -	fse->max_height = RKISP1_ISP_MAX_HEIGHT;
> +	fse->max_height = isp->rkisp1->info->max_height;
>  
>  	return 0;
>  }
> @@ -772,10 +773,10 @@ static void rkisp1_isp_set_sink_fmt(struct rkisp1_isp *isp,
>  
>  	sink_fmt->width = clamp_t(u32, format->width,
>  				  RKISP1_ISP_MIN_WIDTH,
> -				  RKISP1_ISP_MAX_WIDTH);
> +				  isp->rkisp1->info->max_width);
>  	sink_fmt->height = clamp_t(u32, format->height,
>  				   RKISP1_ISP_MIN_HEIGHT,
> -				   RKISP1_ISP_MAX_HEIGHT);
> +				   isp->rkisp1->info->max_height);
>  
>  	/*
>  	 * Adjust the color space fields. Accept any color primaries and
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> index 6f3931ca5b51..e22cc2db24cf 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> @@ -494,10 +494,10 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
>  
>  	sink_fmt->width = clamp_t(u32, format->width,
>  				  RKISP1_ISP_MIN_WIDTH,
> -				  RKISP1_ISP_MAX_WIDTH);
> +				  rsz->rkisp1->info->max_width);
>  	sink_fmt->height = clamp_t(u32, format->height,
>  				   RKISP1_ISP_MIN_HEIGHT,
> -				   RKISP1_ISP_MAX_HEIGHT);
> +				   rsz->rkisp1->info->max_height);
>  
>  	/*
>  	 * Adjust the color space fields. Accept any color primaries and
> -- 
> 2.44.0
> 

