Return-Path: <linux-kernel+bounces-70566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8336859936
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4683F1F21162
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD771B5D;
	Sun, 18 Feb 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q1uVIakW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35401D689;
	Sun, 18 Feb 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286614; cv=none; b=rvMLjKWFlWcm32Gje/+PzgJv8U+Mb1kCeFb4kbSaCPA9NQIHs5xHnvsfXRShzbkrwedp2LRVbbPP9dixjIZEvrrvvGtrgHARvuXnpf6mw6oKDJN+OCn3Ra6c8OJvjOZeeEvy+INpQan+kn3Bw2IdPxRsumSO2JvD26qP3ehyV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286614; c=relaxed/simple;
	bh=JnI/Ip1IUz1CZLShdqDD8S7P8/cWRGr9iAqd/oacm9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsJPgAQskP1PrBE/o4CzenxpciUFow5UjcbpS4TUwXQq0CEU740yEahf8cSUYET9RCTUUb+Pi5Hgp9dbHxJAkU+lZ+s2d41EGSF8LSIZSKgUJ/EyzYXYJItEvwKlRdX7wN/w16lONRdrJzDraoaaz2W3dgaCUhgRERNPTei7NDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Q1uVIakW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F8DA480;
	Sun, 18 Feb 2024 21:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708286604;
	bh=JnI/Ip1IUz1CZLShdqDD8S7P8/cWRGr9iAqd/oacm9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1uVIakWL2QqPIJ6Q7NbTJjViVxGNVlezGMLmQ+pLM7+DVERsHvbOJ/520gcz0QUu
	 9b0Cgp2vi6W1epFTSOjW7hCOVemeG0KsIuoNClDjEwKE9oAZ8I3WeMM2K0RWWTxWrG
	 ruwSpSymm4he9EnhFE7cWZaDfcbg5+1FOLYHRC6w=
Date: Sun, 18 Feb 2024 22:03:33 +0200
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
Subject: Re: [PATCH v12 12/12] media: rkisp1: Add match data for i.MX8MP ISP
Message-ID: <20240218200333.GL7120@pendragon.ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
 <20240216095458.2919694-13-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216095458.2919694-13-paul.elder@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Fri, Feb 16, 2024 at 06:54:58PM +0900, Paul Elder wrote:
> Add match data to the rkisp1 driver to match the i.MX8MP ISP.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v12:
> - move out adding the version enum
> ---
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 54a62487a4e8..a6b47f0af467 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -533,6 +533,26 @@ static const struct rkisp1_info rk3399_isp_info = {
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
> +	.isp_ver = RKISP1_V_IMX8MP,
> +	.features = RKISP1_FEATURE_MAIN_STRIDE
> +		  | RKISP1_FEATURE_DMA_34BIT,
> +};
> +
>  static const struct of_device_id rkisp1_of_match[] = {
>  	{
>  		.compatible = "rockchip,px30-cif-isp",
> @@ -542,6 +562,10 @@ static const struct of_device_id rkisp1_of_match[] = {
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

-- 
Regards,

Laurent Pinchart

