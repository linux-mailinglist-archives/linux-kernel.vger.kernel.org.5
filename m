Return-Path: <linux-kernel+bounces-70464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31185983F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AC01F213F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234E6F06D;
	Sun, 18 Feb 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HUrmOfF1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C57376EE;
	Sun, 18 Feb 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278349; cv=none; b=hxpKJqa1IbUjPFDrT1pUYC8Dx9CHEzHEq2e3/9lDQbtyEvaQ3EVj6K2b0ZvyCCN3Ks9CXspFVBS+i0vBNk+HRHUrReXocsgQqtN4uSv1hqksBDaXRwfo62hwYYTuOMDBeQilvHlaxoUe+OH6noxkFB2x8e5iInIHPSKMP4/axqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278349; c=relaxed/simple;
	bh=m9/HCg4kDl2ulJBzPH/2iPU02A2eJjEuQkTS/agnljA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1OhLF5PmMAMUEB0zBts+KLhOmVrDoJOqW7uHlXT7R8r/scbRR5mQZTBxx0sQt+6JqjMNzaIYT30nhGX2tQNcvj7gt4SiNvOq9gJ6HrL9epVdyJv8Vm2U7GRMwPA2aXtftHTKMZeyXLCqybVkCkTv2a5DR7473giS6azAfnqrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HUrmOfF1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0804480;
	Sun, 18 Feb 2024 18:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708278332;
	bh=m9/HCg4kDl2ulJBzPH/2iPU02A2eJjEuQkTS/agnljA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUrmOfF15aj0kJxkHY64oVWY7ivuGxeIgidDRV7pqvdDwj5sjRk8e8ouUaICa1scc
	 x5lmfX1ekXQNi2G+OvysH/QNY1HU/sh5em4rE7PzHMf4hMVTVgeUCkjQfCQk9vE59y
	 Kh7unNf+4fwBD/7++qSDNCKyiDg+f3ROaDhPrA6Y=
Date: Sun, 18 Feb 2024 19:45:41 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 04/12] media: rkisp1: Support devices lacking dual
 crop
Message-ID: <20240218174541.GH7120@pendragon.ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
 <20240216095458.2919694-5-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216095458.2919694-5-paul.elder@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Fri, Feb 16, 2024 at 06:54:50PM +0900, Paul Elder wrote:
> Some versions of the ISP supported by the rkisp1 driver, such as the ISP
> in the i.MX8MP, lack the dual crop registers and don't support cropping
> at the resizer input. They instead rely on cropping in the Image
> Stabilization module, at the output of the ISP, to modify the resizer
> input size and implement digital zoom.
> 
> Add a dual crop feature flag to distinguish the versions of the ISP that
> support dual crop from those that don't, and make sure that the sink
> crop is set to the sink format when dual crop is not supported.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v12:
> - Remove mention of moving resizer input crop to image stabilizer from
>   commit message
> - Make sure the sink crop is set to the sink format when dual crop is
>   not supported
> ---
>  .../media/platform/rockchip/rkisp1/rkisp1-common.h    |  2 ++
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c   |  6 ++++--
>  .../media/platform/rockchip/rkisp1/rkisp1-resizer.c   | 11 +++++++----
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index f7c251f79aa9..219d4a2547aa 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -112,6 +112,7 @@ enum rkisp1_isp_pad {
>   * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
>   * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
>   * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
> + * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
>   *
>   * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>   * the driver to implement support for features present in some ISP versions
> @@ -121,6 +122,7 @@ enum rkisp1_feature {
>  	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
>  	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
>  	RKISP1_FEATURE_SELF_PATH = BIT(2),
> +	RKISP1_FEATURE_DUAL_CROP = BIT(3),
>  };
>  
>  #define rkisp1_has_feature(rkisp1, feature) \
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index f48a21985b18..2e40c376cab5 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -507,7 +507,8 @@ static const struct rkisp1_info px30_isp_info = {
>  	.isr_size = ARRAY_SIZE(px30_isp_isrs),
>  	.isp_ver = RKISP1_V12,
>  	.features = RKISP1_FEATURE_MIPI_CSI2
> -		  | RKISP1_FEATURE_SELF_PATH,
> +		  | RKISP1_FEATURE_SELF_PATH
> +		  | RKISP1_FEATURE_DUAL_CROP,
>  };
>  
>  static const char * const rk3399_isp_clks[] = {
> @@ -527,7 +528,8 @@ static const struct rkisp1_info rk3399_isp_info = {
>  	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
>  	.isp_ver = RKISP1_V10,
>  	.features = RKISP1_FEATURE_MIPI_CSI2
> -		  | RKISP1_FEATURE_SELF_PATH,
> +		  | RKISP1_FEATURE_SELF_PATH
> +		  | RKISP1_FEATURE_DUAL_CROP,
>  };
>  
>  static const struct of_device_id rkisp1_of_match[] = {
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> index dd77a31e6014..755d319b568e 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> @@ -447,8 +447,9 @@ static void rkisp1_rsz_set_sink_crop(struct rkisp1_resizer *rsz,
>  	/* Not crop for MP bayer raw data */

	/* Not crop for MP bayer raw data, or for devices lacking dual crop. */

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I can handle this when applying.

>  	mbus_info = rkisp1_mbus_info_get_by_code(sink_fmt->code);
>  
> -	if (rsz->id == RKISP1_MAINPATH &&
> -	    mbus_info->pixel_enc == V4L2_PIXEL_ENC_BAYER) {
> +	if ((rsz->id == RKISP1_MAINPATH &&
> +	     mbus_info->pixel_enc == V4L2_PIXEL_ENC_BAYER) ||
> +	    !rkisp1_has_feature(rsz->rkisp1, DUAL_CROP)) {
>  		sink_crop->left = 0;
>  		sink_crop->top = 0;
>  		sink_crop->width = sink_fmt->width;
> @@ -635,7 +636,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>  	struct v4l2_subdev_state *sd_state;
>  
>  	if (!enable) {
> -		rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
> +		if (rkisp1_has_feature(rkisp1, DUAL_CROP))
> +			rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
>  		rkisp1_rsz_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
>  		return 0;
>  	}
> @@ -646,7 +648,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>  	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
>  
>  	rkisp1_rsz_config(rsz, sd_state, when);
> -	rkisp1_dcrop_config(rsz, sd_state);
> +	if (rkisp1_has_feature(rkisp1, DUAL_CROP))
> +		rkisp1_dcrop_config(rsz, sd_state);
>  
>  	v4l2_subdev_unlock_state(sd_state);
>  

-- 
Regards,

Laurent Pinchart

