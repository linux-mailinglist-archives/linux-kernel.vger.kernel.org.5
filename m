Return-Path: <linux-kernel+bounces-34581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0637838215
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F58BB26305
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090A95820D;
	Tue, 23 Jan 2024 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LHbgaoIP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95644F8A7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972739; cv=none; b=kCfeaVUD340UnJHe5uQkPNmGYXU+3KNudUp6yEC8K2CAmV8YtqfkTvhvZakyd5N8+8SvWAJyic9mUzkZcu5Sm6qGVqNxye8NHhkkzeF4dZ0IU9U1SaxJexKzpEdQJAKS5nZalIe3mArxQL3a96KHAUJwZ4rGkSXHClnXTPhFW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972739; c=relaxed/simple;
	bh=Po4T/IjGZp1UTUz0bKFVpijLYioCAg8MTsY3sk6USfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDaEu1pdG79nYoWsCu/4JozerQWS1Otd3wICFrtPPxXzj3ff5w7BdFI6gD6gNbS4lZeSM2DFxDA7h0jQNufVLnp7bumP/OPPLqjEUP6Zz2mOEBUhmBpG8sJjlu/lmWGg9zNxxhqYmpqh1D+xNdD5vXagMw00J1q8qBKrtB9V1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LHbgaoIP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99AFCE4;
	Tue, 23 Jan 2024 02:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705972662;
	bh=Po4T/IjGZp1UTUz0bKFVpijLYioCAg8MTsY3sk6USfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHbgaoIPK+K+PeU6wOnWRvRtz9lkLUvvnWj43z7RMlqYToyeb6vwSDCAtvtj3IW+p
	 hJf6UBdrEibznY38sXerc87XxxewewdwAI/pVEZnGWIyqOgJlMHv75GlsiXc6CLb9I
	 8U9K+MR/BJxDkzZQ81QPDTD90qWThLc5uz8+/ZZ8=
Date: Tue, 23 Jan 2024 03:18:59 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/bridge: simple-bridge: Allow acquiring the next
 bridge with fwnode API
Message-ID: <20240123011859.GB22880@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-4-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122163220.110788-4-sui.jingfeng@linux.dev>

On Tue, Jan 23, 2024 at 12:32:18AM +0800, Sui Jingfeng wrote:
> Which make it possible to use this driver on non-DT based systems,
> meanwhile, made no functional changes for DT based systems.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 51 ++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 595f672745b9..cfea5a67cc5b 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -184,6 +184,39 @@ static const void *simple_bridge_get_match_data(const struct device *dev)
>  	return NULL;
>  }
>  
> +static int simple_bridge_get_next_bridge_by_fwnode(struct device *dev,
> +						   struct drm_bridge **next_bridge)
> +{
> +	struct drm_bridge *bridge;
> +	struct fwnode_handle *ep;
> +	struct fwnode_handle *remote;
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev->fwnode, 1, 0, 0);
> +	if (!ep) {
> +		dev_err(dev, "The endpoint is unconnected\n");
> +		return -EINVAL;
> +	}
> +
> +	remote = fwnode_graph_get_remote_port_parent(ep);
> +	fwnode_handle_put(ep);
> +	if (!remote) {
> +		dev_err(dev, "No valid remote node\n");
> +		return -ENODEV;
> +	}
> +
> +	bridge = drm_bridge_find_by_fwnode(remote);
> +	fwnode_handle_put(remote);
> +
> +	if (!bridge) {
> +		dev_warn(dev, "Next bridge not found, deferring probe\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	*next_bridge = bridge;
> +
> +	return 0;
> +}
> +

Hmmmm yes, this convinces me further that we should switch to fwnode,
not implement fwnode and OF side-by-side.

>  static int simple_bridge_probe(struct platform_device *pdev)
>  {
>  	struct simple_bridge *sbridge;
> @@ -199,14 +232,17 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  	else
>  		sbridge->info = simple_bridge_get_match_data(&pdev->dev);
>  
> -	/* Get the next bridge in the pipeline. */
> -	remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> -	if (!remote)
> -		return -EINVAL;
> -
> -	sbridge->next_bridge = of_drm_find_bridge(remote);
> -	of_node_put(remote);
> +	if (pdev->dev.of_node) {
> +		/* Get the next bridge in the pipeline. */
> +		remote = of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> +		if (!remote)
> +			return -EINVAL;
>  
> +		sbridge->next_bridge = of_drm_find_bridge(remote);
> +		of_node_put(remote);
> +	} else {
> +		simple_bridge_get_next_bridge_by_fwnode(&pdev->dev, &sbridge->next_bridge);
> +	}
>  	if (!sbridge->next_bridge) {
>  		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
>  		return -EPROBE_DEFER;
> @@ -231,6 +267,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  	/* Register the bridge. */
>  	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
>  	sbridge->bridge.of_node = pdev->dev.of_node;
> +	sbridge->bridge.fwnode = pdev->dev.fwnode;
>  	sbridge->bridge.timings = sbridge->info->timings;
>  
>  	drm_bridge_add(&sbridge->bridge);
> -- 
> 2.25.1
> 

-- 
Regards,

Laurent Pinchart

