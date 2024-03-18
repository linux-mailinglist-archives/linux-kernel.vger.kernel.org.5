Return-Path: <linux-kernel+bounces-106797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05C87F3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B5528308A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007125DF0A;
	Mon, 18 Mar 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KiNaFHor"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA65D911;
	Mon, 18 Mar 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803809; cv=none; b=A9SIZkFv6jZKK9kjyY90relKRzO6YAg97SMSwVr70sE8tDDzPutTZTyIbmrucQ/LvvrKw6xQ5gC7/1yWCuUuVYCGf3WS9S+fn8xE1NOGlnGq2FaVubKCaTT62gFc5Nyw6RzEVmonbIVeJ1qivVHlUAq4TB4X/h+l7uzCe65uhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803809; c=relaxed/simple;
	bh=sNU97cnAHCTIQJ2D0vU8XGz7+i4FnBZ2NoBEKcWNi6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9Sgf+nPcFwe6amqv32a9EDUrKDUcuZ+yyOg/rHRvZN76gdigFl3l2+8W3aQsMOUFb1mEjFUCMFA6+l872s7zCQ7qiu+ODvLzKvg/oFP6sU/HtWgur9vLFlJkIRa/tkXWpDhPDjYGpThRMsukPBB5i4Xelj0Alaqs5WtkCo1DTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KiNaFHor; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2710A480;
	Tue, 19 Mar 2024 00:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710803779;
	bh=sNU97cnAHCTIQJ2D0vU8XGz7+i4FnBZ2NoBEKcWNi6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiNaFHor+NDwccrJRieVuHC1LAOW7bWoN+65/Vl9po2mB/5K4/fr3Cnw1yg3DaQuG
	 7cw6eltxzpdu/mnj/K2ThGzWKpDd0KPufLaiLjIU83vtT+xoXYdR+E66GAzCKwCzAU
	 WjZdmLZBwinTBBzgMd7cF+FoS695K5p4mrdVLiaU=
Date: Tue, 19 Mar 2024 01:16:42 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 2/8] drm: xlnx: zynqmp_dpsub: Update live format
 defines
Message-ID: <20240318231642.GT13682@pendragon.ideasonboard.com>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
 <20240312-dp-live-fmt-v2-2-a9c35dc5c50d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312-dp-live-fmt-v2-2-a9c35dc5c50d@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Tue, Mar 12, 2024 at 05:54:59PM -0700, Anatoliy Klymenko wrote:
> Update live format defines to match DPSUB AV_BUF_LIVE_VID_CONFIG register
> layout.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp_regs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> index f92a006d5070..fa3935384834 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> @@ -165,10 +165,10 @@
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_10		0x2
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_12		0x3
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_MASK		GENMASK(2, 0)
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		0x0
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	0x1
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	0x2
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	0x3
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		(0x0 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	(0x1 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	(0x2 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	(0x3 << 4)
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_MASK		GENMASK(5, 4)
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_CB_FIRST		BIT(8)
>  #define ZYNQMP_DISP_AV_BUF_PALETTE_MEMORY		0x400
> 

-- 
Regards,

Laurent Pinchart

