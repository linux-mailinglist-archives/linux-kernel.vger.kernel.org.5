Return-Path: <linux-kernel+bounces-153972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2C8AD576
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9B1C20F36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DCC155399;
	Mon, 22 Apr 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy4zP58n"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CA155354
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816023; cv=none; b=f3r3qSLgk8Y0MFQMoRPbgSQYy7R810OC7wOAqUtzCg0xjDAYQjw7qe+VWi/dH8FXPDb1zWnvrCfD0VdzuHRs5C318I/56BXtjAXC7PvnrwgrE2lSuS3xM/NLhR3wUKAm+vXZOqiYtsAfwmZhiDHE5uL/Q7PUewrzuenyTleWTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816023; c=relaxed/simple;
	bh=RnmLLFtIguqqlXcQDn7zwyP2+nK/bcMOi9+ASUUnsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrUD39BV5lfhCIfsOQDs0TnqaeWbvk6qA5/JGNLyNAlDB1wTu4Q4T85yqoj49Bl4XcOWq9c5WBcauedZkYHCbN1/W8IyJ5wuaXgbWMBE9vpy5rO6Q/s9x2HTGcdvPlDfe9LlRgicDdOyJandSQN6gI7QQ2tZKBr+5JYGcpjiGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yy4zP58n; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d264d0e4so5267846e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713816019; x=1714420819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycyox+a8uTJtkdg98AL9SQ6vby8NQcffWAyye0IOB3k=;
        b=Yy4zP58n8E1yX0j6gqzRQI+tV3pJ9OukAgMFKeQMBoiFKSD5w3eLBD7PTtacPy8sup
         /yfpaXSqB+Q6cq/TKBRxr8Ig/XAKIommGkM1QeiUqA8ydyKRJANlEkuGhpiwIvzCJ1jj
         f8EupTAsN8Ub8etWzqYyVxr2ccocJuu0k0AiyMpV2pC+4RqOsUH2Zyp+7uVcg/aVPMPp
         bXF5qxxieBxbIYt1CqaNh6nHUjUnYO2yX9ShBwxmTJvalN9Um9lJaP1Q6wBhZkIENVKJ
         /XZ5wDx7XWdpFOP5RzQNxc+AkUuVkGYo0kVtGpEfbKt3cP5u4HwkEMBZ52to2MtJIC1P
         nt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816019; x=1714420819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycyox+a8uTJtkdg98AL9SQ6vby8NQcffWAyye0IOB3k=;
        b=u1cw26FnaPO5onoBGoCBSJeKFFdkkwwEfDG4tFwjcEnm56KDyqyRydPfcMzP+wyh+p
         greeMkotJfTWIEHOBKLEP6WGQY7Vwj5gUalf2Mcfrt/O3Nt4uD36ioODS7gJG1LABnBj
         dSMvdFChl/aqg5LqvvV6T4N3Mb8FWGyhtJ9NZLnYB3hqUxJSMw0R7z+MnS/N1AYqFtnT
         b8svbAPPWnjicf3yku+MpSEKFTIDVWQq7wgOJq49uQ90tJiOKM74lifO2WjQk7I6KYap
         dMHZHboGQsO5YbgrNFKK/FQSzx8f2kZF5EC6nAekpl21GQZNYQeM70mr2agGkh0/Yb94
         E13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWKqP1C+6UR9W78LdJmHIdYcQO2P5CypL6NhUTGD02NwhIMLEJnDOON08Gz8Zu0wuIXq/r9HzoQWuXN0lf1c9PzUV+RJTtse/VIuFr
X-Gm-Message-State: AOJu0YzteZimFPYEbdnF2cYvfp5u2S113R8lLmaXEtsnlx8m6PCAk9nE
	2UF4u1ZMAiB/O8omWStO4WJULoOEyvIwzXuE5AzuHLsYN3hG6Kzeu5VJCvIuL6c=
X-Google-Smtp-Source: AGHT+IFmcE/rLlQhhc5SXh6s9hDx2crTlCqCj2zT4cYpiu/1t32umou3INKWd2Lj3g3peUhc8hk+aw==
X-Received: by 2002:a05:6512:20ce:b0:51a:bd8e:b3d0 with SMTP id u14-20020a05651220ce00b0051abd8eb3d0mr180760lfr.22.1713816019354;
        Mon, 22 Apr 2024 13:00:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b005178e88b4adsm1834219lfj.86.2024.04.22.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:00:18 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:00:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] drm-bridge: display-connector: Use fwnode API to
 acquire device properties
Message-ID: <nprf453sxgh3dyy4zh67dty5avuuqnpqf3ua4qpydmfuxb2zjs@jinatrfgjg6u>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-5-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-5-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:18:58AM +0800, Sui Jingfeng wrote:
> Make this driver less DT-dependent by using the fwnode helper functions,
> should be no functional changes for DT based systems. Do the necessary
> works before it can be truely DT-independent, this patch do no harms even
> though there is no user yet.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 24 +++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index ab8e00baf3f1..d80cb7bc59e6 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -204,6 +204,7 @@ static int display_connector_get_supply(struct platform_device *pdev,
>  
>  static int display_connector_probe(struct platform_device *pdev)
>  {
> +	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
>  	struct display_connector *conn;
>  	unsigned int type;
>  	const char *label = NULL;
> @@ -215,15 +216,15 @@ static int display_connector_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, conn);
>  
> -	type = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	type = (uintptr_t)device_get_match_data(&pdev->dev);
>  
>  	/* Get the exact connector type. */
>  	switch (type) {
>  	case DRM_MODE_CONNECTOR_DVII: {
>  		bool analog, digital;
>  
> -		analog = of_property_read_bool(pdev->dev.of_node, "analog");
> -		digital = of_property_read_bool(pdev->dev.of_node, "digital");
> +		analog = fwnode_property_present(fwnode, "analog");
> +		digital = fwnode_property_present(fwnode, "digital");
>  		if (analog && !digital) {
>  			conn->bridge.type = DRM_MODE_CONNECTOR_DVIA;
>  		} else if (!analog && digital) {
> @@ -240,8 +241,7 @@ static int display_connector_probe(struct platform_device *pdev)
>  	case DRM_MODE_CONNECTOR_HDMIA: {
>  		const char *hdmi_type;
>  
> -		ret = of_property_read_string(pdev->dev.of_node, "type",
> -					      &hdmi_type);
> +		ret = fwnode_property_read_string(fwnode, "type", &hdmi_type);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "HDMI connector with no type\n");
>  			return -EINVAL;
> @@ -271,7 +271,7 @@ static int display_connector_probe(struct platform_device *pdev)
>  	conn->bridge.interlace_allowed = true;
>  
>  	/* Get the optional connector label. */
> -	of_property_read_string(pdev->dev.of_node, "label", &label);
> +	fwnode_property_read_string(fwnode, "label", &label);
>  
>  	/*
>  	 * Get the HPD GPIO for DVI, HDMI and DP connectors. If the GPIO can provide
> @@ -309,12 +309,12 @@ static int display_connector_probe(struct platform_device *pdev)
>  	if (type == DRM_MODE_CONNECTOR_DVII ||
>  	    type == DRM_MODE_CONNECTOR_HDMIA ||
>  	    type == DRM_MODE_CONNECTOR_VGA) {
> -		struct device_node *phandle;
> +		struct fwnode_handle *phandle;
>  
> -		phandle = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
> -		if (phandle) {
> -			conn->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
> -			of_node_put(phandle);
> +		phandle = fwnode_find_reference(fwnode, "ddc-i2c-bus", 0);
> +		if (!IS_ERR_OR_NULL(phandle)) {

s/IS_ERR_OR_NULL/IS_ERR/

LGTM otherwise.

> +			conn->bridge.ddc = i2c_get_adapter_by_fwnode(phandle);
> +			fwnode_handle_put(phandle);
>  			if (!conn->bridge.ddc)
>  				return -EPROBE_DEFER;
>  		} else {
> @@ -358,7 +358,7 @@ static int display_connector_probe(struct platform_device *pdev)
>  	}
>  
>  	conn->bridge.funcs = &display_connector_bridge_funcs;
> -	conn->bridge.of_node = pdev->dev.of_node;
> +	drm_bridge_set_node(&conn->bridge, fwnode);
>  
>  	if (conn->bridge.ddc)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

