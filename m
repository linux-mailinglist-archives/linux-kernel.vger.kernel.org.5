Return-Path: <linux-kernel+bounces-34583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E478381B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9673C1C217D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE25A7BD;
	Tue, 23 Jan 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fLV+vLCx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F74A1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972898; cv=none; b=Gi6na6E0hqbhpg2J51Fi9KMsIf7LFdgp/r1VjBH5/HL/f8S3bi2DKvfdRCmJmckvqf6rxgwHFMuFYhNxQu5XcZbI6sk1jZCWEPtxQIDaPD9x/h9seDOBC1Wd8NZO9yntgyRELiKWkbaOLpyghmJvAC5wP28SJhmOPW5UMVrGxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972898; c=relaxed/simple;
	bh=jSyJt+l532CbcFX0D/ulUOQwQIAoGhgLhyYRcgl7RGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNESCiPlOEtVjGsRw+XUarXnW1gIy51pKrEjthWOOaMomyGuKAjr1prXm1Tn0KVqPBRqJ7rh3RNYGaNdPgpcGUkB2et59rZ53HCsT+VW/KOoYUDPsyElETQPWXM11X5eul7kb8xWfVC5Pj7n8/y6IWy4C1IA17dv9g7OsHQ5lSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=fLV+vLCx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 018CDE4;
	Tue, 23 Jan 2024 02:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705972822;
	bh=jSyJt+l532CbcFX0D/ulUOQwQIAoGhgLhyYRcgl7RGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLV+vLCxXvkcUwVOBAeMW8JKNEoSVGr4B0QEWY8G4BEPZNQrkBFw0LxNbQcHrr1fc
	 9x+wE8f0nXqM94N8KscfXitIsLNUUxZspHv/2xwJ2rE5ZTWLVW3p+5ynIg3KVHyWFF
	 PAaXakd4jaPXnArN4RLHEorph7Gk9ctx+58VrBZg=
Date: Tue, 23 Jan 2024 03:21:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/bridge: simple-bridge: Extend match support for
 non-DT based systems
Message-ID: <20240123012139.GD22880@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122163220.110788-3-sui.jingfeng@linux.dev>

On Tue, Jan 23, 2024 at 12:32:17AM +0800, Sui Jingfeng wrote:
> Which is intended to be used on non-DT environment, where the simple-bridge
> platform device is created by either the display controller driver side or
> platform firmware subsystem.

Could you give an example of a platform where you intend to use this ?

> To avoid duplication and to keep consistent,
> we choose to reuse the OF match tables. Because the potentional user may
> not has a of_node attached, nor a ACPI match id. If this is the case,
> a software node string property can be provide to fill the niche.

Shouldn't non-DT, non-ACPI platforms use swnodes ?

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index cbe8e778d7c7..595f672745b9 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -166,6 +166,24 @@ static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
>  	.disable	= simple_bridge_disable,
>  };
>  
> +static const void *simple_bridge_get_match_data(const struct device *dev)
> +{
> +	const struct of_device_id *matches = dev->driver->of_match_table;
> +
> +	/* Try to get the match data by software node */
> +	while (matches) {
> +		if (!matches->compatible[0])
> +			break;
> +
> +		if (device_is_compatible(dev, matches->compatible))
> +			return matches->data;
> +
> +		matches++;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int simple_bridge_probe(struct platform_device *pdev)
>  {
>  	struct simple_bridge *sbridge;
> @@ -176,7 +194,10 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, sbridge);
>  
> -	sbridge->info = of_device_get_match_data(&pdev->dev);
> +	if (pdev->dev.of_node)
> +		sbridge->info = of_device_get_match_data(&pdev->dev);
> +	else
> +		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
>  
>  	/* Get the next bridge in the pipeline. */
>  	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> @@ -309,3 +330,4 @@ module_platform_driver(simple_bridge_driver);
>  MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
>  MODULE_DESCRIPTION("Simple DRM bridge driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:simple-bridge");

This is an unrelated change.

-- 
Regards,

Laurent Pinchart

