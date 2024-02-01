Return-Path: <linux-kernel+bounces-48271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FF845969
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E9B1F2884B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9735D472;
	Thu,  1 Feb 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lh8owA6n"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4615B669;
	Thu,  1 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795749; cv=none; b=RFQiUTLCvwpFHunzxb6+FM6i7mHD3WXImRhwng7hygHIU+H1EbnqtvrLQKzF2jZjLtI9VIgxq1a5K+GUrxlTJL+lPV7+fFrv3j5pO1yOGoDEqgmDV3x3gEf9SetoUUS0I7sZ4yTlOVLX/9VbJfDgU9XGCTQFBMWwDSFhVyfNS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795749; c=relaxed/simple;
	bh=yVe0wPpau/Jkc9Yz0tzUYbm/lq5PZI3a41O+7qw+lzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQI4sX8e+kH3coyx7DyMI/LQLTl3x+5wJ9EJfvX4WaS4dVbNSV6l/vSMj54uZF96/gAvKiVve6Lstp8r/xyhdIe2zFNhYKc2RAgCrofCOHbX6dYObQ7J1436xiX0EjmV4HYM9nKBa69l/d6qGB4D3lGEZvuhnB8AW+Jm2RpCTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Lh8owA6n; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [94.107.229.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75E50613C;
	Thu,  1 Feb 2024 14:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706795665;
	bh=yVe0wPpau/Jkc9Yz0tzUYbm/lq5PZI3a41O+7qw+lzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lh8owA6nHqGwJmgfCmd3MCj45ldbG6crq2p1W+wARpdvMJ3ZrhqPsbl9QbRBFRJeg
	 v4SqfKhBdvKNBYVe9+vMqCSnY6SuQlDulTFFcBODPx5F9BmyE2vqhseZs5Z/UrzYv7
	 cn4m/IR7kLvoWeMXYSfbckgGjk63cmIMQX32UGx8=
Date: Thu, 1 Feb 2024 15:55:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com, Rob Herring <robh@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/11] media: rkisp1: Add match data for i.MX8MP ISP
Message-ID: <20240201135544.GC5344@pendragon.ideasonboard.com>
References: <20240111114831.656736-1-paul.elder@ideasonboard.com>
 <20240111114831.656736-7-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111114831.656736-7-paul.elder@ideasonboard.com>

On Thu, Jan 11, 2024 at 08:48:26PM +0900, Paul Elder wrote:
> Add match data to the rkisp1 driver to match the i.MX8MP ISP.

This patch, or at least the part that adds the compatible entry, should
move to the end of the series, after the other patches that enable the
features needed by the i.MX8MP.

> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     | 23 +++++++++++++++++++
>  include/uapi/linux/rkisp1-config.h            |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 2e40c376cab5..e4aac0234178 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -532,6 +532,25 @@ static const struct rkisp1_info rk3399_isp_info = {
>  		  | RKISP1_FEATURE_DUAL_CROP,
>  };
>  
> +static const char * const imx8mp_isp_clks[] = {
> +	"isp",
> +	"hclk",
> +	"aclk",
> +};
> +
> +static const struct rkisp1_isr_data imx8mp_isp_isrs[] = {
> +	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) },
> +};
> +
> +static const struct rkisp1_info imx8mp_isp_info = {
> +	.clks = imx8mp_isp_clks,
> +	.clk_size = ARRAY_SIZE(imx8mp_isp_clks),
> +	.isrs = imx8mp_isp_isrs,
> +	.isr_size = ARRAY_SIZE(imx8mp_isp_isrs),
> +	.isp_ver = IMX8MP_V10,
> +	.features = RKISP1_FEATURE_MAIN_STRIDE,
> +};
> +
>  static const struct of_device_id rkisp1_of_match[] = {
>  	{
>  		.compatible = "rockchip,px30-cif-isp",
> @@ -541,6 +560,10 @@ static const struct of_device_id rkisp1_of_match[] = {
>  		.compatible = "rockchip,rk3399-cif-isp",
>  		.data = &rk3399_isp_info,
>  	},
> +	{
> +		.compatible = "fsl,imx8mp-isp",
> +		.data = &imx8mp_isp_info,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rkisp1_of_match);
> diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
> index 730673ecc63d..f602442c2018 100644
> --- a/include/uapi/linux/rkisp1-config.h
> +++ b/include/uapi/linux/rkisp1-config.h
> @@ -179,12 +179,14 @@
>   * @RKISP1_V11: declared in the original vendor code, but not used
>   * @RKISP1_V12: used at least in rk3326 and px30
>   * @RKISP1_V13: used at least in rk1808
> + * @IMX8MP_V10: used in at least imx8mp
>   */
>  enum rkisp1_cif_isp_version {
>  	RKISP1_V10 = 10,
>  	RKISP1_V11,
>  	RKISP1_V12,
>  	RKISP1_V13,
> +	IMX8MP_V10,

This is prone to namespace clashes, especially in the userspace API. I
prefer keeping the RKISP1_ prefix. Furthermore, there's no "V10" for the
i.MX8MP. You can name the version RKISP1_V_IMX8MP. I dislike it very
much but have no better alternative to propose without more information
from VSI.

>  };
>  
>  enum rkisp1_cif_isp_histogram_mode {

-- 
Regards,

Laurent Pinchart

