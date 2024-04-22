Return-Path: <linux-kernel+bounces-153976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D798AD589
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BD01C212D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49227156993;
	Mon, 22 Apr 2024 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCuK6Z9z"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321715689E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816156; cv=none; b=t6/50XEUgs6USzwGU+oIjyrdma9bT+ximgQUn8E5AucYSi29Aa1Zp7Njf73rpDgElFZXVeumScwB82VE/QxqUcTY/j2fI4FbDYiC419/6gAAHou9wxYy9iAN6WxWGTPgtqStxAn4llOs7rKyL2TUb97e2y0bcnFcG03xKgtm8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816156; c=relaxed/simple;
	bh=ticgGBpeT2G+MaRPOg5nCM0Uaa2/RPiLOKPqRDu5MYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6gTRpsAeuHM/4xayTs2NwDI7KXAumhLjilxeugJ4NFDNvsL+HS+9rKjXIMOgt+se7ozUnXKlEeHiwwLCXoYFwcsy7Ga9svCG4YK5BqnicpEzDNHG09EVdt7b/K9uiFNhDVAIzhfzLxdBNrVYE7Fg3iT9tznAzBxJY1L9nmGffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCuK6Z9z; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so6289017e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713816153; x=1714420953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYULDphY2ItayKozrZGvB0zK/xqIWuEyrYhocBQEPFk=;
        b=CCuK6Z9zrG4VQLylOsdpoN/kcaFFyoW26yJZn2x5VCfxvnp6CG9kB9ptp1CJKrRbHY
         m+5ddpwuNYbeUszEBIxIfAO9/fNmuSxvRh1/MQ/HjUdgsJWIbKiJ4aIjQH89/4adBq0C
         sXSgrKOwyTEEwaX3AmUKN1e9Asc3LgDlAR9RX5dyFO9fI8tO/m3Oaiz6brQpWesfs2Ae
         kLcKktm7SE0nfSJM5jUPzLaXZdGqlNLbrWkCAHtJD48OgStu4RroX53Ht3FuhzKztPDH
         DDBfnmkIcu7F6UkrYg3CjIlU5PY0mR7tqVH+eB3qB+DGpWjuDoubjChfOndi6bNSFgPP
         KTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816153; x=1714420953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYULDphY2ItayKozrZGvB0zK/xqIWuEyrYhocBQEPFk=;
        b=NVDWpLxwzG/PM+azpbfW7WQxirog48U5Qt5+yY49B4vuHVq8GKabDzU8yrbufd3vSQ
         CsjCtsizsaIJfhf1hzwd4APw1nN7YmTEHcYCmTO9eE5guWPBp1gGH7S6F9aDo0dJJk2f
         K8TSPSzLDFw2e2w+aNNube2WSC6yJDiQqdMKyVWgp4uQTWGF/dLTkISKGHu/C+Y76hti
         PzzS+tgSl8RYhVmakfHxlz4CTdC/ZJtI3ojPRPkLQAHLW9EED14XEsAzhITASBmG33d5
         naSmJRgREutLwkHWFaobIN00lwNnFZ72R9zQCMrtqfJgSPKFI7LfO1xycSfwzJkmug5Z
         QrTg==
X-Forwarded-Encrypted: i=1; AJvYcCVAxO8ie++B3gCQQLaPirGOKW8v7SfMgfyervMoqrLQ3/9GJQWAJqsd4MBTNI44oS9t3ZANfNK4W3nphJ6yccWP6/x4O3ECiJHZzASf
X-Gm-Message-State: AOJu0YzhQ1G7B0cxkB8jjOXdrLiRq1VI339YD7OZzBsM2LDIGaa5Gwic
	acDKCeMtNV20xLbhA3vkxu8fmTsX4U6ltgpWKUqSbYztIorpFeHD0ZgyV0o83Oc=
X-Google-Smtp-Source: AGHT+IEHpYdHUl6OKNU8zFWazWcfkMxAo7AMxHLtOACiqPGyPX821vxF/ZHJDF+BCrU8Qx8Gkp+mOQ==
X-Received: by 2002:a05:6512:3086:b0:51a:e51c:46be with SMTP id z6-20020a056512308600b0051ae51c46bemr8101937lfd.33.1713816152889;
        Mon, 22 Apr 2024 13:02:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id p10-20020a05651212ca00b0051aecc1c038sm877383lfg.223.2024.04.22.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:02:32 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:02:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] drm-bridge: sii902x: Use fwnode API to acquire
 device properties
Message-ID: <nv2tqsoxj3ste4mqhzmbwhibms7obhqrw62c6vquxdkwrsiez4@yxmexbvocds7>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-7-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-7-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:19:00AM +0800, Sui Jingfeng wrote:
> Make this driver less DT-dependent by calling the freshly created helper
> functions, which reduce boilerplate. Should be no functional changes for
> DT based systems.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 43 +++++++++++---------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 8f84e98249c7..04436f318c7f 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -827,20 +827,19 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  		.spdif = 0,
>  		.max_i2s_channels = 0,
>  	};
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	u8 lanes[4];
>  	int num_lanes, i;
>  
> -	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
> +	if (!fwnode_property_present(fwnode, "#sound-dai-cells")) {
>  		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",
>  			__func__);
>  		return 0;
>  	}
>  
> -	num_lanes = of_property_read_variable_u8_array(dev->of_node,
> -						       "sil,i2s-data-lanes",
> -						       lanes, 1,
> -						       ARRAY_SIZE(lanes));
> -
> +	num_lanes = fwnode_property_read_u8_array(fwnode,
> +						  "sil,i2s-data-lanes",
> +						  lanes, ARRAY_SIZE(lanes));

You have lost support for having less than 4 lanes. Please see the
documentation for this function.

>  	if (num_lanes == -EINVAL) {
>  		dev_dbg(dev,
>  			"%s: No \"sil,i2s-data-lanes\", use default <0>\n",
> @@ -1097,13 +1096,13 @@ static int sii902x_init(struct sii902x *sii902x)
>  		goto err_unreg_audio;
>  
>  	sii902x->bridge.funcs = &sii902x_bridge_funcs;
> -	sii902x->bridge.of_node = dev->of_node;
>  	sii902x->bridge.timings = &default_sii902x_timings;
>  	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
>  
>  	if (sii902x->i2c->irq > 0)
>  		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
>  
> +	drm_bridge_set_node(&sii902x->bridge, dev_fwnode(dev));

Move back to the place of the of_node setter.

>  	drm_bridge_add(&sii902x->bridge);
>  
>  	return 0;
> @@ -1118,7 +1117,6 @@ static int sii902x_init(struct sii902x *sii902x)
>  static int sii902x_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> -	struct device_node *endpoint;
>  	struct sii902x *sii902x;
>  	static const char * const supplies[] = {"iovcc", "cvcc12"};
>  	int ret;
> @@ -1147,27 +1145,14 @@ static int sii902x_probe(struct i2c_client *client)
>  		return PTR_ERR(sii902x->reset_gpio);
>  	}
>  
> -	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
> -	if (endpoint) {
> -		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
> -
> -		of_node_put(endpoint);
> -		if (!remote) {
> -			dev_err(dev, "Endpoint in port@1 unconnected\n");
> -			return -ENODEV;
> -		}
> -
> -		if (!of_device_is_available(remote)) {
> -			dev_err(dev, "port@1 remote device is disabled\n");
> -			of_node_put(remote);
> -			return -ENODEV;
> -		}
> -
> -		sii902x->next_bridge = of_drm_find_bridge(remote);
> -		of_node_put(remote);
> -		if (!sii902x->next_bridge)
> -			return dev_err_probe(dev, -EPROBE_DEFER,
> -					     "Failed to find remote bridge\n");
> +	sii902x->next_bridge = drm_bridge_find_next_bridge_by_fwnode(dev_fwnode(dev), 1);
> +	if (!sii902x->next_bridge) {
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				     "Failed to find the next bridge\n");
> +	} else if (IS_ERR(sii902x->next_bridge)) {
> +		ret = PTR_ERR(sii902x->next_bridge);
> +		dev_err(dev, "Error on find the next bridge: %d\n", ret);
> +		return ret;
>  	}
>  
>  	mutex_init(&sii902x->mutex);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

