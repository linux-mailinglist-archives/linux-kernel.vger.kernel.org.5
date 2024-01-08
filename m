Return-Path: <linux-kernel+bounces-19433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18A0826CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9661F22689
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDF210F2;
	Mon,  8 Jan 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="v+HnYiJW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD014A9F;
	Mon,  8 Jan 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C333C480;
	Mon,  8 Jan 2024 12:29:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704713353;
	bh=nY/eWYuqjZwgCZ0QQWwg8jenYFa3Oh8vSrL0JarXuOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v+HnYiJWgGn71TUkxZUOMnn3cv2LFs66ZwINGWJtWb+U/QgeRdf+1gQtWCai9BHCp
	 VqlzrIXFMDDpTUWekKY6JIaPMOHHmWrqdQPtt9bo84ITSg6kuEv4BGim38Wq3v+Fed
	 wGBlcylMmuf47A3U/IYAQIsARCN7Bw5TbzLaGtmk=
Message-ID: <f3415ec4-fb56-49d9-a326-ed05c5346822@ideasonboard.com>
Date: Mon, 8 Jan 2024 13:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] media: rkisp1: Configure gasket on i.MX8MP
Content-Language: en-US
To: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
 aford173@gmail.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240106160221.4183409-1-paul.elder@ideasonboard.com>
 <20240106160221.4183409-8-paul.elder@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240106160221.4183409-8-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2024 18:02, Paul Elder wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> The i.MX8MP has a gasket between the CSI-2 receiver and the ISP.
> Configure and enable it when starting the ISP, and disable it when
> stopping.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> ---
>   .../platform/rockchip/rkisp1/rkisp1-common.h  |   5 +
>   .../platform/rockchip/rkisp1/rkisp1-dev.c     |  16 +++
>   .../platform/rockchip/rkisp1/rkisp1-isp.c     | 131 +++++++++++++++++-
>   3 files changed, 149 insertions(+), 3 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 219d4a2547aa..69940014d597 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -24,6 +24,7 @@
>   #include "rkisp1-regs.h"
>   
>   struct dentry;
> +struct regmap;
>   
>   /*
>    * flags on the 'direction' field in struct rkisp1_mbus_info' that indicate
> @@ -444,6 +445,8 @@ struct rkisp1_debug {
>    * @dev:	   a pointer to the struct device
>    * @clk_size:	   number of clocks
>    * @clks:	   array of clocks
> + * @gasket:	   the gasket - i.MX8MP only
> + * @gasket_id:	   the gasket ID (0 or 1) - i.MX8MP only
>    * @v4l2_dev:	   v4l2_device variable
>    * @media_dev:	   media_device variable
>    * @notifier:	   a notifier to register on the v4l2-async API to be notified on the sensor
> @@ -466,6 +469,8 @@ struct rkisp1_device {
>   	struct device *dev;
>   	unsigned int clk_size;
>   	struct clk_bulk_data clks[RKISP1_MAX_BUS_CLK];
> +	struct regmap *gasket;
> +	unsigned int gasket_id;
>   	struct v4l2_device v4l2_dev;
>   	struct media_device media_dev;
>   	struct v4l2_async_notifier notifier;
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 29a8249852d4..01f811b9f9a5 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/clk.h>
>   #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_graph.h>
> @@ -624,6 +625,21 @@ static int rkisp1_probe(struct platform_device *pdev)
>   		return ret;
>   	rkisp1->clk_size = info->clk_size;
>   
> +	if (info->isp_ver == IMX8MP_V10) {
> +		unsigned int id;
> +
> +		rkisp1->gasket = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +								      "fsl,blk-ctrl",
> +								      1, &id);
> +		if (IS_ERR(rkisp1->gasket)) {
> +			ret = PTR_ERR(rkisp1->gasket);
> +			dev_err(dev, "failed to get gasket: %d\n", ret);
> +			return ret;
> +		}
> +
> +		rkisp1->gasket_id = id;
> +	}
> +
>   	pm_runtime_enable(&pdev->dev);
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> index 78a1f7a1499b..bfd6dc3559cc 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/iopoll.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>   #include <linux/videodev2.h>
>   #include <linux/vmalloc.h>
>   
> @@ -53,6 +54,115 @@
>    * +---------------------------------------------------------+
>    */
>   
> +/* -----------------------------------------------------------------------------
> + * Media block control (i.MX8MP only)
> + */
> +
> +#define ISP_DEWARP_CONTROL				0x0138
> +
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY	BIT(22)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_RISING	(0 << 20)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_NEGATIVE	(1 << 20)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE	(2 << 20)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_FALLING	(3 << 20)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK	GENMASK(21, 20)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE	BIT(19)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt)	((dt) << 13)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK	GENMASK(18, 13)
> +
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY	BIT(12)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_RISING	(0 << 10)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_NEGATIVE	(1 << 10)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE	(2 << 10)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_FALLING	(3 << 10)
> +#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK	GENMASK(11, 10)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE	BIT(9)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt)	((dt) << 3)
> +#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK	GENMASK(8, 3)
> +
> +#define ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE		BIT(1)
> +#define ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE		BIT(0)
> +
> +static int rkisp1_gasket_enable(struct rkisp1_device *rkisp1,
> +				struct media_pad *source)
> +{
> +	struct v4l2_subdev *source_sd;
> +	struct v4l2_mbus_frame_desc fd;
> +	unsigned int dt;
> +	u32 mask;
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Configure and enable the gasket with the CSI-2 data type. Set the
> +	 * vsync polarity as active high, as that is what the ISP is configured
> +	 * to expect in ISP_ACQ_PROP. Enable left justification, as the i.MX8MP
> +	 * ISP has a 16-bit wide input and expects data to be left-aligned.
> +	 */
> +
> +	source_sd = media_entity_to_v4l2_subdev(source->entity);
> +	ret = v4l2_subdev_call(source_sd, pad, get_frame_desc,
> +			       source->index, &fd);
> +	if (ret) {
> +		dev_err(rkisp1->dev,
> +			"failed to get frame descriptor from '%s':%u: %d\n",
> +			source_sd->name, 0, ret);
> +		return ret;
> +	}
> +
> +	if (fd.num_entries != 1) {
> +		dev_err(rkisp1->dev, "invalid frame descriptor for '%s':%u\n",
> +			source_sd->name, 0);
> +		return -EINVAL;
> +	}
> +
> +	dt = fd.entry[0].bus.csi2.dt;
> +
> +	if (rkisp1->gasket_id == 0) {
> +		mask = ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY
> +		     | ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
> +		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
> +		val = ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE
> +		    | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
> +		    | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt);
> +	} else {
> +		mask = ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY
> +		     | ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
> +		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
> +		val = ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE
> +		    | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
> +		    | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt);
> +	}
> +
> +	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
> +
> +	return 0;
> +}
> +
> +static void rkisp1_gasket_disable(struct rkisp1_device *rkisp1)
> +{
> +	u32 mask;
> +	u32 val;
> +
> +	if (rkisp1->gasket_id == 1) {
> +		mask = ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
> +		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
> +		val = ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
> +	} else {
> +		mask = ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
> +		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
> +		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
> +		val = ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
> +	}
> +
> +	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
> +}
> +
>   /* ----------------------------------------------------------------------------
>    * Camera Interface registers configurations
>    */
> @@ -291,6 +401,9 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
>   		     RKISP1_CIF_VI_IRCL_MIPI_SW_RST |
>   		     RKISP1_CIF_VI_IRCL_ISP_SW_RST);
>   	rkisp1_write(rkisp1, RKISP1_CIF_VI_IRCL, 0x0);
> +
> +	if (rkisp1->info->isp_ver == IMX8MP_V10)
> +		rkisp1_gasket_disable(rkisp1);
>   }
>   
>   static void rkisp1_config_clk(struct rkisp1_isp *isp)
> @@ -315,16 +428,24 @@ static void rkisp1_config_clk(struct rkisp1_isp *isp)
>   	}
>   }
>   
> -static void rkisp1_isp_start(struct rkisp1_isp *isp,
> -			     struct v4l2_subdev_state *sd_state)
> +static int rkisp1_isp_start(struct rkisp1_isp *isp,
> +			    struct v4l2_subdev_state *sd_state,
> +			    struct media_pad *source)
>   {
>   	struct rkisp1_device *rkisp1 = isp->rkisp1;
>   	const struct v4l2_mbus_framefmt *src_fmt;
>   	const struct rkisp1_mbus_info *src_info;
>   	u32 val;
> +	int ret;
>   
>   	rkisp1_config_clk(isp);
>   
> +	if (rkisp1->info->isp_ver == IMX8MP_V10) {
> +		ret = rkisp1_gasket_enable(rkisp1, source);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* Activate ISP */
>   	val = rkisp1_read(rkisp1, RKISP1_CIF_ISP_CTRL);
>   	val |= RKISP1_CIF_ISP_CTRL_ISP_CFG_UPD |
> @@ -338,6 +459,8 @@ static void rkisp1_isp_start(struct rkisp1_isp *isp,
>   
>   	if (src_info->pixel_enc != V4L2_PIXEL_ENC_BAYER)
>   		rkisp1_params_post_configure(&rkisp1->params);
> +
> +	return 0;
>   }
>   
>   /* ----------------------------------------------------------------------------
> @@ -848,7 +971,9 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
>   	if (ret)
>   		goto out_unlock;
>   
> -	rkisp1_isp_start(isp, sd_state);
> +	ret = rkisp1_isp_start(isp, sd_state, source_pad);
> +	if (ret)
> +		goto out_unlock;
>   
>   	ret = v4l2_subdev_call(rkisp1->source, video, s_stream, true);
>   	if (ret) {


