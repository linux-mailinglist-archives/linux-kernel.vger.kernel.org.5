Return-Path: <linux-kernel+bounces-106846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B087F467
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6236BB20CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693FA29;
	Tue, 19 Mar 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d8BJZS8i"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA083D69;
	Tue, 19 Mar 2024 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807181; cv=none; b=oeK8oKXW7dRIWuEV8aeswDSjZL1RXtFsU5LKrPyi1/K3pM7C8IjCfc6NpRKspLszPrtfUbr4O9dgIAoZK5QIBch97XzibUrWdxfORpYc7Tzosy2UFB8P9sS+jMLhBaNWrTr2XiogT/CTGin3Hk3PwRZEBEGA83gtWTLToOtbhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807181; c=relaxed/simple;
	bh=cJWPjHKoew1CHYHZkQVjW2vYHS+pGQpJZuRRjf5H9x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goiMQfv7JErsm5sJ9svL0Z28wFKkoVuPzxXng4KfKgLkiO9zozlfy6W20bUuG2K9uuxm1DAqcPdyLQC87jLzjN+qKv7AmT+XiORXZ8eGueWnBIdFsymW8NNdzPyAhwFTMCJw9IE//gk7xgJLfM9kTCtj7f8rJWFfYZTzi0CwKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d8BJZS8i; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9361A480;
	Tue, 19 Mar 2024 01:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710807151;
	bh=cJWPjHKoew1CHYHZkQVjW2vYHS+pGQpJZuRRjf5H9x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8BJZS8iGJKZLVolj7pGRGn48j9q6lDP9SSCup0/hbbzaOQB9ES1z7zUegweh/+O9
	 KSI35JwNdPa4FPVBnUBTSMV1ABPNyT33vrycN65BrvNuw//jfx/VPIqUlU3hlPd8Sq
	 dsjbTKQhuorbCoxcGGU8yyI07/EcoeSPVtTr7dRM=
Date: Tue, 19 Mar 2024 02:12:55 +0200
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
Subject: Re: [PATCH v2 4/8] drm: xlnx: zynqmp_dpsub: Minimize usage of global
 flag
Message-ID: <20240319001255.GV13682@pendragon.ideasonboard.com>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
 <20240312-dp-live-fmt-v2-4-a9c35dc5c50d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312-dp-live-fmt-v2-4-a9c35dc5c50d@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Tue, Mar 12, 2024 at 05:55:01PM -0700, Anatoliy Klymenko wrote:
> Avoid usage of global zynqmp_dpsub.dma_enabled flag in DPSUB layer
> context. This flag signals whether the driver runs in DRM CRTC or DRM
> bridge mode, assuming that all display layers share the same live or
> non-live mode of operation. Using per-layer mode instead of global flag
> will siplify future support of the hybrid scenario.

s/siplify/simplify/

> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index af851190f447..dd48fa60fa9a 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -975,7 +975,7 @@ void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer)
>  {
>  	unsigned int i;
>  
> -	if (layer->disp->dpsub->dma_enabled) {
> +	if (layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE) {
>  		for (i = 0; i < layer->drm_fmt->num_planes; i++)
>  			dmaengine_terminate_sync(layer->dmas[i].chan);
>  	}
> @@ -1001,7 +1001,7 @@ void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
>  
>  	zynqmp_disp_avbuf_set_format(layer->disp, layer, layer->disp_fmt);
>  
> -	if (!layer->disp->dpsub->dma_enabled)
> +	if (layer->mode == ZYNQMP_DPSUB_LAYER_LIVE)
>  		return;
>  
>  	/*
> @@ -1039,7 +1039,7 @@ int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
>  	const struct drm_format_info *info = layer->drm_fmt;
>  	unsigned int i;
>  
> -	if (!layer->disp->dpsub->dma_enabled)
> +	if (layer->mode == ZYNQMP_DPSUB_LAYER_LIVE)
>  		return 0;

The above changes look nice.

>  
>  	for (i = 0; i < info->num_planes; i++) {
> @@ -1089,7 +1089,7 @@ static void zynqmp_disp_layer_release_dma(struct zynqmp_disp *disp,
>  {
>  	unsigned int i;
>  
> -	if (!layer->info || !disp->dpsub->dma_enabled)
> +	if (!layer->info)

This, however, doesn't seem right, as this function is called
unconditionally from the remove path. The change below seems weird too.
If I'm missing something, it should at least be explained in the commit
message.

>  		return;
>  
>  	for (i = 0; i < layer->info->num_channels; i++) {
> @@ -1132,9 +1132,6 @@ static int zynqmp_disp_layer_request_dma(struct zynqmp_disp *disp,
>  	unsigned int i;
>  	int ret;
>  
> -	if (!disp->dpsub->dma_enabled)
> -		return 0;
> -
>  	for (i = 0; i < layer->info->num_channels; i++) {
>  		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
>  		char dma_channel_name[16];
> 

-- 
Regards,

Laurent Pinchart

